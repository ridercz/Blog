<!-- dcterms:identifier = aspnetcz#51 -->
<!-- dcterms:title = Tvorba vlastního parametru pro data binding v ASP.NET 2.0 -->
<!-- dcterms:abstract = Verze ASP.NET 2.0 přináší mimo jiné možnost velmi schopného deklarativního data bindingu. Pro parametrizaci dotazů můžete využít některé vestavěné zdroje (cookie, query string, session, profil...). Tento článek popisuje tvorb vlastního typu parametru, který vrcací uživatelské jméno. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Tipy, triky -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2005-10-05T05:18:03.07+02:00 -->
<!-- dcterms:dateAccepted = 2005-10-05T05:18:03.07+02:00 -->

Verze ASP.NET 2.0 přináší mimo jiné možnost velmi schopného deklarativního data bindingu. Co je data binding asi většina ví - vygenerování obsahu nějakého zobrazovače (typicky třeba DataGrid/GridView) na základě přiřazeného datového zdroje a nějaké soustavy pravidel a šablon. Tím je programátor ušetřen psaní kódu, ve kterém postupně řádek po řádku procházel vrácená data a generoval jejich HTML reprezentaci.

Ve verzích 1.x se prakticky veškerý data binding děl z backendového kódu, nějak takhle:

Dim CMD As New SqlCommand("SELECT * FROM Tabulka", DB) Dim R as SqlDataReader = CMD.ExecuteReader(CloseConnection) Me.DataGrid1.DataSource = R Me.DataGrid1.DataBind() R.Close()

Whidbey razí všude, kde je to možné, deklarativní přístup. Zamezuje nutnosti psát opakující se jednoduchý kód, a místo toho umožnit maximum věcí automatizovat, zapisovat parametricky. Shora uvedený příklad by bylo možno v nové verzi napsat nějak takhle:

<asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1" /> <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MujConnectionString %>" SelectCommand="SELECT * FROM Tabulka"/>

## Deklarativní generování parametrů

V praxi ale není nic tak jednoduché, jako v příkladech a prezentacích, a dotazy (či uložené procedury) mají parametry, které jest jim nutno předávati. Naštěstí .NET Framework myslí i na tohle. Jednotlivé datové zdroje mohou mít definovány rozličné parametry. Jejich hodnota jest pak před voláním dotazu naplněna podle stavu určeného zdroje. Standardně oním zdrojem může být:

*   jiný ovládací prvek (`asp:ControlParameter`)
*   cookie (`asp:CookieParameter`)
*   formulářové pole předané metodou POST (`asp:FormParameter`)
*   uživatelský profil (`asp:ProfileParameter`)
*   query stringu (`asp:QueryStringParameter`)
*   session (`asp:SessionParameter`)
*   nic, hodnota zapsaná "natvrdo" (`asp:Parameter`) 

Pokud chcete, aby dotaz byl závislý na čemkoliv jiném, než jsou shora uvedené možnosti, existují dvě základní řešení. První je použít prostý `asp:Parameter` a jeho hodnotu nastavit z backendového kódu. Tím se ovšem připravujete o výhody deklarativního přístupu. Druhou možností je využít rozšiřitelnosti .NET Frameworku a napsat si vlastní typ parametru.

## Píšeme vlastní parametr - UserNameParameter

Jednou z vlastností, které mi vyloženě chybí, je možnost použít jako parametr jméno právě přihlášeného uživatele. Dokážeme si s tím poradit poměrně snadno: Vytvoříme (v adresáři `App_Code`) novou třídu, nazvanou `UserNameParameter` a podědíme ji od prototypu `System.Web.UI.WebControls.Parameter`. Funkčnost dodáme přepsáním metody `Evaluate`. Patřičný kód bude vypadat nějak takhle:

Namespace MyControls Public Class UserNameParameter Inherits System.Web.UI.WebControls.Parameter Protected Overrides Function Evaluate(ByVal Context As System.Web.HttpContext, ByVal Control As System.Web.UI.Control) As Object Return Context.User.Identity.Name End Function End Class End Namespace

Třídu jsem umístil do namespace `MyControls`, protože to je nutné, aby bylo možno se na ni odkazovat z ASPX stránek (na názvu NS nezáleží, ale prostě musí být určen). Použití parametru ve stránce sestává ze dvou činností. Za prvé musíme ovládací prvek zaregistrovat, což učiníme tak, že na začátek stránky zapíšeme direktivu `@Register`. Posléze daný prvek prostě použijeme:

<%@ Register TagPrefix="My" Namespace="MyControls" %> ... <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1" /> <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:NemesisForum_Data %>" SelectCommand="SELECT * FROM Tabulka WHERE Uzivatel=@Uzivatel"> <SelectParameters> <my:UserNameParameter Name="Uzivatel" /> </SelectParameters> </asp:SqlDataSource>

Sluší se poznamenat, že shora uvedená metoda nemá podporu v průvodcích ve VS.NET/VWD. V těch uvidíte "natvrdo" pouze vestavěné parametry, podpora uživatelských se plánuje až do příští verze.

## Dotaz do pléna

Novinky ve Whidbey, které se týkají data bindingu, mi přijdou velice užitečné a zajímavé. Nerad bych ale nosil sovy do Athén a psal o něčem, co všichni znají. Přejete si, abych se data bindingu ve Whidbey věnoval v některém z budoucích článků obšírněji?