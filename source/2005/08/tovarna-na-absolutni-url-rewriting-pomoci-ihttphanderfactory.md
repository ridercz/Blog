<!-- dcterms:identifier = aspnetcz#44 -->
<!-- dcterms:title = Továrna na absolutní URL: rewriting pomocí IHttpHanderFactory -->
<!-- dcterms:abstract = URL rewriting je častá technika, používaná k výrobě "hezkých" webových adres. Elegantně je možno ji realizovat pomocí IHttpHanderFactory - narozdíl od jiných metod úspěšně implementuje postback a je Whidbey kompatibilní. -->
<!-- np9:categoryId = 4 -->
<!-- x4w:category = IIS -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2005-08-12T03:10:27.403+02:00 -->
<!-- dcterms:dateAccepted = 2005-08-12T03:10:27.403+02:00 -->

U řady webových aplikací (tento blog nevyjímaje) jest se setkati se zvláštním formátem URL, kdy je nějaký parametr (třeba ID článku) předáván nikoliv jako hodnota v Query Stringu (*http://server/Clanek.aspx?ID=neco*), ale přímo jako název souboru (*http://server/Clanky/neco.aspx*). Důvodů k tomu vedoucích může být povícero, ale obvykle převažuje skutečnost, že tato URL jsou obvykle snáze indexovatelná vyhledávači - a protože se právě nacházíme na vrcholu SEO bubliny, musí to mít každý.

Samozřejmě to neznamená, že by publikační systém generoval pro každý článek zvláštní skript, ale používá se technika zvaná URL rewriting. V rámci zpracování HTTP požadavku ([více o request pipeline v ASP.NET](/entry/article-20050110.aspx)) se na základě vygenerovaných pravidel URL "přepíše" a na straně serveru přesměruje na jinou stránku.

## Context.RewritePath

Nejjednodušší metodu URL rewritingu představuje metoda `System.Web.HttpContext.Current.RewritePath`, volaná příkladně v rámci události `BeginRequest`.

Její použití však má mnohá úskalí. Především pak to, že přepsání se provede takříkajíc "napůl". Onen cílový skript totiž principiálně vůbec netuší, že se stal obětí URL rewritingu, a veškeré případné mapování se děje s ohledem na jeho adresu, nikoliv na původně požadovanou. Nejobvyklejším projevem je, že přestane fungovat postback.

V aplikacích založených na ASP.NET 2.0 (Whidbey) přestane fungovat skoro všechno, protože na relativním odkazování je založeno kdeco, od vyhodnocování odkazů přes postback až po témata.

## Továrna na handlery

Klíčovou roli při zpracování ASP.NET požadavků představují HTTP handlery. Žil jsem v bludu, neb jsem myslel, že jsem je už na tomto serveru někdy do huby bral, ale není tomu tak (až na stručnou zmínku ve [shora odkazovaném článku](/entry/article-20050110.aspx)). V dohledné době to napravím, pro tento okamžik se spokojte s oním jedním odstavcem.

Obvykle se vykonávání nějakého URL či typu URL spojuje s určitým handlerem přímo, protože dopředu víme, co budeme chtít. Vyšší školu představují situace, kdy to podle URL nevíme a je nutno o tomto dynamicky rozhodnout. Pro tento účel disponuje .NET továrnou na výrobu handlerů - HTTP Handler Factory.

Jedná se o třídu, implementující interface `IHttpHandlerFactory`. Ta přijme HTTP požadavek, hluboce se nad ním zamyslí, a namísto aby jej osobně zpracovala, vrátí zpět informaci o tom, kterému handleru má framework předmětný požadavek hodit na hrb.

Tohoto chování jest možno využít pro URL rewriting. Zpracování klasických web formů (*.aspx) totiž také probíhá formou HTTP handleru. Máme možnost tedy možnost zneužít ubohý ASPX soubor ke zpracování požadavku, aniž by tento tušil, že jeho identita zůstane utajena. Veškeré mapování se tak bude provádět relativně vůči původně požadovanému URL, postback bude fungovat a všichni se budou mít rádi.

Háček je v tom, že případné parametry (jako název požadovaného souboru) nelze podvrhnout například formou vygenerovaných Query String parametrů, neb vlastní URL zůstává nezměněno. Pro předávání informací mezi jednotlivými částmi ASP.NET pipeline jest určena kolekce `System.Web.HttpContext.Current.Items`. Můžete si ji představit jako určitou formu cache, která je platná toliko po dobu životnosti jednoho požadavku.

## Praktický příklad

Mějmež web publikující články. Přejeme si, aby adresa článku byla vždy */Articles/nejakeid.aspx*. Vlastní zobrazení článku provádí stránka */Article.aspx*, a ono dříve zmíněné *nejakeid* je pro něj informace o tom, který článek má z databáze vytáhnout.

Začneme tím, že vytvoříme továrnu na handlery. Konkrétně třídu `Remapper`, která bude implementovat rozhraní `IHttpHandlerFactory`:

Imports Microsoft.VisualBasic Public Class Remapper Implements IHttpHandlerFactory Public Function GetHandler(ByVal context As System.Web.HttpContext, ByVal requestType As String, ByVal url As String, ByVal pathTranslated As String) As System.Web.IHttpHandler Implements System.Web.IHttpHandlerFactory.GetHandler ' Put article ID - name of 'virtual' ASPX page - to request cache context.Items("ArticleID") = System.IO.Path.GetFileNameWithoutExtension(pathTranslated) ' Handle request via ~/Article.aspx script Return PageParser.GetCompiledPageInstance("~/Article.aspx", _ context.Server.MapPath("~/Article.aspx"), _ context) End Function Public Sub ReleaseHandler(ByVal handler As System.Web.IHttpHandler) Implements System.Web.IHttpHandlerFactory.ReleaseHandler End Sub End Class

Metoda `GetHandler` načte název požadovaného souboru bez přípony a uloží jej jako prvek s klíčem `ArticleID` do context cache. Následně pak vyvolá instanci handleru pro stránku `~/Article.aspx` a vráti jí zpět k vykonání.

Stránka ~/Article.aspx je primitivní, neb jenom vezme jí předané `ArticleID` a zobrazí ho:

<%@ Page Language="VB" %> <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"> <script runat="server"> Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Me.LabelArticleID.Text = String.Format(Me.LabelArticleID.Text, Context.Items("ArticleID")) End Sub </script> <html xmlns="http://www.w3.org/1999/xhtml"> <head runat="server"> <title>Untitled Page</title> </head> <body> <form id="form1" runat="server"> <div> <asp:Label ID="LabelArticleID" runat="server" Text="Article ID = {0}" /> </div> </form> </body> </html>

Poslední nezbytnou komponentou systému je vhodné nastavení v souboru `Web.Config`. Námi vygenerovanou třídu Remapper je nutno přidat jako handler požadavků pro patřičné URL (`articles/*.aspx`):

<?xml version="1.0"?> <configuration xmlns="http://schemas.microsoft.com/.NetConfiguration/v2.0"> <system.web> <httpHandlers> <add verb="*" path="Articles/*.aspx" type="Remapper"/> </httpHandlers> </system.web> </configuration>

Kompletní ukázkovou aplikaci jest možno si stáhnout [zde](https://www.cdn.altairis.cz/Blog/2005/20050812-url-rewriting.zip). Je určena, stejně jako výše uvedený kód, pro ASP.NET 2.0 (Whidbey), leč popsaná metoda funguje i ve verzi 1.1.