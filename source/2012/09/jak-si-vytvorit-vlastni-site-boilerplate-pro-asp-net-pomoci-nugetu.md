<!-- dcterms:identifier = aspnetcz#403 -->
<!-- dcterms:title = Jak si vytvořit vlastní site boilerplate pro ASP.NET pomocí NuGetu -->
<!-- dcterms:abstract = Pokaždé, když začínám vyvíjet nějaký nový projekt, strávím určitý čas základním nastavením projektu – instalací obvyklých NuGet balíčků, konfigurací ve web.configu, vytvořením základní master/content page struktury a podobně. Automatizovat tuto činnost se ukázalo být překvapivě komplikovaným, ale nakonec jsem to porazil. Nabízím vám návod, jak si vytvořit vlastní ASP.NET Site Boilerplate podle svých představ. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Tipy, triky -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2012-09-02T19:28:15.82+02:00 -->
<!-- dcterms:dateAccepted = 2012-09-03T08:00:00+02:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20120903-jak-si-vytvorit-vlastni-site-boilerplate-pro-asp-net-pomoci-nugetu.png -->

Pokaždé, když začínám vyvíjet nějaký nový projekt, strávím určitý čas základním nastavením projektu – instalací obvyklých NuGet balíčků, konfigurací ve web.configu, vytvořením základní master/content page struktury a podobně. Automatizovat tuto činnost se ukázalo být překvapivě komplikovaným, ale nakonec jsem to porazil. Nabízím vám návod, jak si vytvořit vlastní ASP.NET Site Boilerplate podle svých představ.

> **Co je boilerplate?** Úplně původně se jednalo o [štítek s označením výrobce parních kotlů](http://www.virtualmuseum.ca/Exhibitions/Railway/en/ag2.php?id=49&pn=4) s plasticky vyvedenými písmeny. Později se tento termín začal používat i při výrobě novin. Opakovaně používané části tiskovin, jako třeba inzeráty nebo syndikované články se začaly distribuovat v podobě hotového ocelového štočku, což zjednodušilo produkci. Termín "boilerplate" se přeneseně používá v případech, kdy máme nějakou obecnou šablonu, kterou používáme opakovaně.

Pro běžný front-end takových šablon existuje celá řada, nejpopulárnější z nich je asi [HTML5 Boilerplate](http://html5boilerplate.com/), ale pro ASP.NET jsem nic použitelného nenašel. Existují sice různé šablony (Project Templates) pro Visual Studio, ale ty zase nemají automatickou aktualizaci NuGet balíčků. Napadlo mne využít i NuGet samotný, ale i ten je třeba trochu znásilnit, aby dělal co je třeba.

## Project Templates a jejich omezení

Na první pohled nejvýhodnějším řešením by bylo použití Project Templates (šablon projektů) ve Visual Studiu. Visual Studio obsahuje [řadu vestavěných šablon](http://msdn.microsoft.com/en-us/library/0fyc0azh.aspx), z nichž mi ovšem žádná nevyhovuje. Výchozí šablona `ASP.NET Web Application` toho obsahuje příliš mnoho a `ASP.NET Empty Web Application` zase příliš málo (přesněji nic).

Vytvořit novou šablonu je [překvapivě snadné](http://msdn.microsoft.com/en-us/library/xkh1wxd8.aspx) a stačí pár kliků v GUI. Napojit to na NuGet infrastrukturu je už poněkud složitější, ale [také je to možné](http://docs.nuget.org/docs/reference/packages-in-visual-studio-templates). 

Nicméně show stopper pro mne je, že šablona neumožňuje nainstalovat nejnovější dostupnou verzi NuGet balíčku, ale trvá na instalaci konkrétní verze. Motivace za tím je velmi ušlechtilá, protože nová verze nemusí být nutně kompatibilní se zbytkem projektu. Nicméně toto riziko jsem v zásadě ochoten nést. Rozhodně lépe, než že budu po vytvoření projektu muset ručně aktualizovat všechny balíčky.

## NuGet šablony a jejich omezení

Druhá moje volba byla vykašlat se na šablony a použít NuGet balíčky. Tj. že postup bude takový, že vytvořím prázdný projekt (`ASP.NET Empty Web Application`) a do něj nainstaluji NuGet balíček, který bude obsahovat vše potřebné. Tedy můj vlastní kód i odkazy na další NuGet balíčky, jako třeba jQuery, jQuery UI a další.

Nepříjemné omezení pak ale spočívá v tom, že ony další NuGet balíčky nejdou odinstalovat, protože je na nich závislý ten hlavní balíček. A když odinstaluji ten, přijdu o další změny.

Nicméně, existuje cesta, jak z toho ven: pokud balíček odinstalujete, smaže všechno, co sám přinesl, ale neodinstaluje balíčky, na kterých závisí. Problém se dá tedy vyřešit tak, že vytvoříte balíčky dva:

*   Vnitřní (v mém případě se jmenuje `Altairis.SiteBoilerplate.Internal`), který obsahuje jenom vaše vlastní soubory s kódem, nastavení atd, ale neobsahuje žádné závislosti na jiných balíčcích. 
*   Vnější (v mém případě `Altairis.SiteBoilerplate`), který obsahuje pouze závislosti na další balíčky (včetně toho vnitřního), ale žádný vlastní obsah.  

Použití potom vypadá tak, že nainstalujete vnější balíček a hned jej zase odinstalujete. Nic se odinstalací nesmaže, protože balíček nemá žádný obsah), a ostatní balíčky, které nainstaloval, v projektu zůstanou – a dá se s nimi bez omezení jednotlivě pracovat.

## Kompletní postup

Na konci článku najdete moje hotové balíčky, ale jejich sestava je vždy přísně individuální, takže předpokládám, že je nepoužijete tak, jak leží a běží, ale spíše si na jejich motivy vytvoříte vlastní. Proto popisuji krok za krokem postup, jak to udělat – můj postup si pak upravte podle potřeby.

Můj postup je pro ASP.NET 4.5 a Visual Studio 2012, ale principy jsou totožné i pro starší verze.

### Vytvoření projektu a instalace NuGet balíčků

Začněte tím, že vytvoříte nový projekt podle šablony `ASP.NET Empty Web Site`, tj úplně prázdný. Pojmenujte ho libovolně, ale tak aby bylo pojmenování unikátní a nezaměnitelné s názvy jiných tříd, které budete používat – později jej budeme hledat a nahrazovat přes Find & Replace. Výchozí název typu `WebApplication1` funguje velmi dobře.

Poté nainstalujte NuGet balíčky, které používáte. V mém případě jsou to následující:

*   `[AspNet.ScriptManager.jQuery](http://www.jquery.com)` – jQuery, včetně registrace pro ScriptManager tak, jak ji vyžaduje nová validace v ASP.NET 4.5. 
*   `[AspNet.ScriptManager.jQuery.UI.Combined](http://www.jqueryui.com)` – jQuery UI, opět včetně registrace pro ScriptManager, a výchozí skin. 
*   `Microsoft.AspNet.ScriptManager.WebForms` – klientské skripty, které vyžaduje ASP.NET v podobě připravené pro bundling. 
*   `[Altairis.Web.UI](http://altairiswebui.codeplex.com/)` – sbírka mých vlastních ovládacích prvků, které používám prakticky ve všech svých projektech. 
*   `[Altairis.Web.Management](http://altairiswebmgmt.codeplex.com/)` – druhá moje knihovna, tentokrát obsahující různé HTTP moduly pro ošetřování chyb, přepínání mezi HTTP a HTTPS a další. 
*   `Microsoft.AspNet.Web.Optimization` – knihovna od Microsoftu pro bundling a minifikaci JavaScriptu a CSS. 
*   `[Modernizr](http://modernizr.com/)` – JavaScriptová knihovna, která umí detekovat podporu různých funkcí v prohlížečích a umí přidat podporu pro některé HTML5 sémantické elementy do starších prohlížečů.  

### Registrace v GLOBAL.ASAX

S příchodem technologií jako je routing a bundling mi podezřele narůstá objem kódu v `Application_Start` v `GLOBAL.ASAX`, protože tam se to všechno registruje a inicializuje. Proto jsem se inspiroval ve výchozím projektu ASP.NET a vytvořil si za tímto účelem statické třídy v adresáři App_Start, které tyhle věci dělají a jenom se volají z původní metody `Application_Start`.

Vytvořte tedy novou složku `App_Start` a v ní statickou třídu `RouteRegistration`. Ta bude obsahovat registrace routes, zatím je tam jenom jedna pro homepage:

using System; using System.Web.Routing; namespace WebApplication1.App_Start { public static class RouteRegistration { public static void Start() { RouteTable.Routes.MapPageRoute("HomePage", "", "~/Pages/HomePage.aspx"); } } }

Následuje třída `ScriptRegistration`, která se stará o registraci JavaScriptů. Registruje celkem tři bundly:

*   **`~/bundles/WebFormsJs`** – balíček standardních WebForms skriptů v podobě, v jaké jej vyžaduje NuGet balíček `Microsoft.AspNet.ScriptManager.WebForms`. Ten se také postará o registraci pro ScriptManager pomocí `ScriptResourceDefinition`. 
*   **`~/bundles/modernizr`** – bundle pro Modernizr. Zde se s registrací pro ScriptManager neobtěžujeme, protože Modernizr musí být natažený už v hlavičce. 
*   **`~/bundles/SiteJs`** – bundle pro moje vlastní skripty, zahrnuje vše s cestou `~/Scripts/Site/*.js`. Vyhovuje mým potřebám (obvykle mám JavaScriptu málo, jednoduchý a společný pro celý web). Zároveň jej registrujeme pro ScriptManager pod logickým názvem `SiteBundle`.  

Zdrojový kód třídy `ScriptRegistration` je následující:

using System; using System.Web.Optimization; using System.Web.UI; namespace WebApplication1.App_Start { public static class ScriptRegistration { public static void Start() { // Register bundles for ASP.NET infrastructure BundleTable.Bundles.Add(new ScriptBundle("~/bundles/WebFormsJs").Include( "~/Scripts/WebForms/WebForms.js", "~/Scripts/WebForms/WebUIValidation.js", "~/Scripts/WebForms/MenuStandards.js", "~/Scripts/WebForms/Focus.js", "~/Scripts/WebForms/GridView.js", "~/Scripts/WebForms/DetailsView.js", "~/Scripts/WebForms/TreeView.js", "~/Scripts/WebForms/WebParts.js")); // Modernizr - useful for HTML5 support for older browser BundleTable.Bundles.Add(new ScriptBundle("~/bundles/modernizr").Include( "~/Scripts/modernizr-*")); // Local JavaScript files BundleTable.Bundles.Add(new ScriptBundle("~/bundles/SiteJs").Include( "~/Scripts/site/*.js")); // Register script resource mapping for local JavaScript files ScriptManager.ScriptResourceMapping.AddDefinition("SiteBundle", new ScriptResourceDefinition { Path = "~/bundles/SiteJs" }); } } }

Poslední z trojice je třída `StyleRegistration`, která registruje bundle pro výchozí styl jQuery UI. Můžete sem také přidat svůj oblíbený CSS reset styl, pokud nějaký máte.

using System; using System.Web.Optimization; namespace WebApplication1.App_Start { public static class StyleRegistration { public static void Start() { BundleTable.Bundles.Add(new StyleBundle("~/content/themes/base/css").Include( // jQuery UI core "~/Content/themes/base/jquery.ui.core.css", // jQuery UI widgets "~/Content/themes/base/jquery.ui.accordion.css", "~/Content/themes/base/jquery.ui.autocomplete.css", "~/Content/themes/base/jquery.ui.button.css", "~/Content/themes/base/jquery.ui.datepicker.css", "~/Content/themes/base/jquery.ui.dialog.css", "~/Content/themes/base/jquery.ui.icons.css", "~/Content/themes/base/jquery.ui.progressbar.css", "~/Content/themes/base/jquery.ui.resizable.css", "~/Content/themes/base/jquery.ui.selectable.css", "~/Content/themes/base/jquery.ui.slider.css", "~/Content/themes/base/jquery.ui.tabs.css", // jQuery UI visual theme "~/Content/themes/base/jquery.ui.theme.css")); } } }

Upravíme také `GLOBAL.ASAX`, která bude volat metody `Start` výše uvedených tříd:

using System; using WebApplication1.App_Start; namespace WebApplication1 { public class Global : System.Web.HttpApplication { protected void Application_Start(object sender, EventArgs e) { // Register scripts, styles and routes ScriptRegistration.Start(); StyleRegistration.Start(); RouteRegistration.Start(); } } }

### Vytvoření Master a Content page

Vytvořte složku `~/Pages` a v ní master page jménem `Site.Master`. Její zdrojový kód vypadá takto:

<%@ Master Language="C#" AutoEventWireup="true" CodeBehind="Site.master.cs" Inherits="WebApplication1.Pages.Site" ViewStateMode="Disabled" %> <!DOCTYPE html> <html xmlns="http://www.w3.org/1999/xhtml"> <head runat="server"> <meta charset="utf-8" /> <meta name="viewport" content="width=device-width" /> <title></title> <asp:PlaceHolder runat="server"> <%: Styles.Render("~/Content/themes/base/css") %> <%: Scripts.Render("~/bundles/modernizr") %> </asp:PlaceHolder> </head> <body> <form id="form1" runat="server"> <asp:ScriptManager runat="server" AjaxFrameworkMode="Disabled" EnableCdn="true"> <Scripts> <%-- jQuery --%> <asp:ScriptReference Name="jquery" /> <asp:ScriptReference Name="jquery.ui.combined" /> <%-- ASP.NET --%> <asp:ScriptReference Name="WebForms.js" Assembly="System.Web" Path="~/Scripts/WebForms/WebForms.js" /> <asp:ScriptReference Name="WebUIValidation.js" Assembly="System.Web" Path="~/Scripts/WebForms/WebUIValidation.js" /> <asp:ScriptReference Name="MenuStandards.js" Assembly="System.Web" Path="~/Scripts/WebForms/MenuStandards.js" /> <asp:ScriptReference Name="GridView.js" Assembly="System.Web" Path="~/Scripts/WebForms/GridView.js" /> <asp:ScriptReference Name="DetailsView.js" Assembly="System.Web" Path="~/Scripts/WebForms/DetailsView.js" /> <asp:ScriptReference Name="TreeView.js" Assembly="System.Web" Path="~/Scripts/WebForms/TreeView.js" /> <asp:ScriptReference Name="WebParts.js" Assembly="System.Web" Path="~/Scripts/WebForms/WebParts.js" /> <asp:ScriptReference Name="Focus.js" Assembly="System.Web" Path="~/Scripts/WebForms/Focus.js" /> <asp:ScriptReference Name="WebFormsBundle" /> <%-- Site JS --%> <asp:ScriptReference Name="SiteBundle" /> </Scripts> </asp:ScriptManager> <header> <h1>Lorem Ipsum</h1> </header> <section> <asp:ContentPlaceHolder ID="Main" runat="server" /> </section> <footer> Copyright </footer> </form> </body> </html>

Co jsme v master page udělali?

*   Nastavením `ViewStateMode="disabled"` jsme vypnuli ViewState. Jednotlivé prvky si ho ale mohou znovu zapnout, pokud na tom budou trvat. 
*   Do hlavičky jsme přidali META tag, který na mobilních zařízeních vypne automatické zmenšování. 
*   Kromě toho jsme do hlavičky přidali odkaz na Modernizr a bundle se styly. 
*   Přidali jsme `ScriptManager` s odkazem na jQuery, jQuery UI, Web Forms skripty (ta složitá registrace je tam nutná, ale teď se mi nechce rozebírat proč) a naše vlastní skripty. 
*   No a konečně stránka obsahuje jeden obsahový `ContentPlaceholder` a základní strukturu HTML 5 tagů.  

Dále vytvoříme content page s názvem `~/Pages/HomePage.aspx`.V ní není nic převratného, já tam mám nějaké ukázkové HTML inspirované [HTMLipsum](http://www.htmlipsum.com), které mi pomůže při stylování.

### Vytvoření ASP.NET tématu pro učesání HTML

Logika Themes ve Web Forms je nyní dost odsouvána na druhou kolej. Nicméně v něčem jsou Themes nenahraditelné, umožňují jednoduše učesat HTML generované ovládacími prvky, zrušit tabulky kolem některých prvků a podobně.

Vytvořte nový skin file `~/App_Themes/Normalize/Normalize.skin` s následujícím obsahem:

<%-- Add sensible defaults to web form controls --%> <asp:Button runat="server" CssClass="button" /> <asp:TextBox runat="server" CssClass="textbox" /> <asp:DropDownList runat="server" CssClass="textbox" /> <asp:ListBox runat="server" CssClass="textbox" /> <asp:CheckBox runat="server" CssClass="checkbox" /> <asp:RadioButton runat="server" CssClass="checkbox" /> <asp:RadioButtonList runat="server" CssClass="checklist" RepeatLayout="UnorderedList" /> <asp:CheckBoxList runat="server" CssClass="checklist" RepeatLayout="UnorderedList" /> <asp:Login runat="server" RenderOuterTable="false" /> <asp:FormView runat="server" RenderOuterTable="false" /> <asp:ValidationSummary runat="server" CssClass="validation" /> <altairis:AutoModeFormView runat="server" RenderOuterTable="false" />

### Vytvoření prázdného výchozího skriptu

Vytvořte skript v `~/Scripts/Site/core.js`. Vzhledem k bundlingu je jedno, jak se jmenuje, ale musí být v adresáři Site. Skript je fakticky prázdný, mám v něm jenom IntelliSense reference na jQuery, jQuery UI a Modernizr a základní jQuery konstrukt pro vodlání kódu po načtení dokumentu:

/// <reference path="../jquery-1.8.0.js" /> /// <reference path="../jquery-ui-1.8.23.js" /> /// <reference path="../modernizr-2.5.3.js" /> $(function () { });

### Nastavení ve web.configu

Do web.configu přidejte libovolná nastavení, která chcete v projektu mít. Jako například:

*   Vypnutí session state. 
*   Nastavení cache pro statický obsah. 
*   Nastavení správných MIME typů pro standardně nepodoporované typy (jako třeba .woff).  

### Zkontrolujte funkčnost projektu

Nyní si zkontrolujte, zda vám všechno funguje jak má, zda se všechno referencuje správně a dle vašich představ.

### Vytvoření vnitřního NuGet balíčku

Proveďte v celém projektu Find & Replace a nahraďte název projektu (`WebApplication1`) řetězcem `$rootnamespace$`. Na jeho místo se při aplikaci šablony doplní výchozí namespace vašeho projektu. Pozor, tímto krokem si projekt "rozbijete", nepůjde nadále buildovat a nebude fungovat. To je v pořádku.

Zavřete Visual Studio a smažte z adresáře svého projektu všechno, co nemá být součástí šablony, případně co je součástí vámi přidaných NuGet balíčků. Tj. zejména následující složky a soubory:

*   `App_Data` 
*   `bin` 
*   `obj` 
*   `Properties` 
*   Všechno ve `Scripts`, až na `Site\core.js` 
*   `Packages.config` 
*   `Web.debug.config` 
*   `Web.release.config` 
*   `WebApplication1.csproj` 
*   `WebApplication1.csproj.user`  

Otevřete si soubor `web.config` a vymažte z něj všechna nastavení, která jste do něj explicitně nezapsali. Tj. vše, co v něm je jako výchozí, nebo co do něj nahrály vámi používané NuGet balíčky. Mně z něj zůstalo následující torzo:

<?xml version="1.0" encoding="utf-8"?> <configuration> <system.web> <pages styleSheetTheme="Normalize"> <namespaces> <add namespace="System.Web.Optimization" /> </namespaces> </pages> <sessionState mode="Off" /> </system.web> <system.webServer> <modules runAllManagedModulesForAllRequests="true"> </modules> <staticContent> <clientCache cacheControlMode="UseMaxAge" cacheControlMaxAge="365.00:00:00" /> </staticContent> <staticContent> <remove fileExtension=".ttf" /> <remove fileExtension=".eot" /> <remove fileExtension=".woff" /> <mimeMap fileExtension=".eot" mimeType="application/vnd.bw-fontobject" /> <mimeMap fileExtension=".ttf" mimeType="application/x-font-ttf" /> <mimeMap fileExtension=".woff" mimeType="application/x-woff" /> </staticContent> </system.webServer> </configuration>

Přejmenujte soubor `web.config` na `web.config.transform`. Tím zajistíte, že se sloučí s tím, co již v projektu máte a který modifikují ostatníé balíčky.

Ke všem souborům s příponou `.aspx`, `.master` nebo `.cs` přidejte ještě příponu `.pp`. Tj. soubory se budou jmenovat nějak jako `HomePage.aspx.pp` a `HomePage.aspx.cs.pp`. Tím zajistíte, že se zpracují placeholdery jako `$rootnamespace$`.

Libovolným způsobem, třeba pomocí GUI programu [NuGet Package Explorer](http://nuget.codeplex.com/releases) vytvořte balíček `Altairis.SiteBoilerplate.Internal`. Do jeho složky content umistěte všechny soubory, které vám v projektu zbyly po výše popisované genocidě. Nenastavujte mu žádnou závislost na dalších balíčcích ani nic podobného.

Můj `.nuspec` soubor vypadá takto:

<?xml version="1.0" encoding="utf-16"?> <package xmlns="http://schemas.microsoft.com/packaging/2011/08/nuspec.xsd"> <metadata> <id>Altairis.SiteBoilerplate.Internal</id> <version>1.0.0</version> <title>Altairis Site Boilerplate (Internal)</title> <authors>Altair</authors> <owners /> <iconUrl>http://www.cdn.altairis.cz/NuGet/icon-32x32.png</iconUrl> <requireLicenseAcceptance>false</requireLicenseAcceptance> <description>Bolerplate for new web site, includes common settings and NuGet packages.</description> <releaseNotes>This is the internal package.</releaseNotes> <copyright>Copyright (c) Altairis, 2012</copyright> <language>en-US</language> <tags>boilerplate</tags> </metadata> </package>

Uložte balíček pod názvem `Altairis.SiteBoilerplate.Internal.1.0.0.nupkg`.

### Vytvoření vnějšího NuGet balíčku

Vytvořte nový NuGet balíček a pojmenujte ho `Altairis.SiteBoilerplate`. Tento balíček nebude mít žádný vlastní obsah, bude mít jenom závislosti na jiných balíčcích. Jako první uveďte `Altairis.SiteBoilerplate.Internal` vytvořený před chvílí. Poté zadejte všechny další balíčky, které jste použili.

Můj `.nuspec` soubor vypadá takto:

<?xml version="1.0" encoding="utf-16"?> <package xmlns="http://schemas.microsoft.com/packaging/2011/08/nuspec.xsd"> <metadata> <id>Altairis.SiteBoilerplate</id> <version>1.0.0</version> <title>Altairis Site Boilerplate</title> <authors>Altair</authors> <owners /> <iconUrl>http://www.cdn.altairis.cz/NuGet/icon-32x32.png</iconUrl> <requireLicenseAcceptance>false</requireLicenseAcceptance> <description>Bolerplate for new web site, includes common settings and NuGet packages.</description> <releaseNotes>This is the public package.</releaseNotes> <copyright>Copyright (c) Altairis, 2012</copyright> <language>en-US</language> <tags>boilerplate</tags> <dependencies> <dependency id="Altairis.SiteBoilerplate.Internal" /> <dependency id="AspNet.ScriptManager.jQuery" /> <dependency id="AspNet.ScriptManager.jQuery.UI.Combined" /> <dependency id="Microsoft.AspNet.ScriptManager.WebForms" /> <dependency id="Altairis.Web.UI" /> <dependency id="Altairis.Web.Management" /> <dependency id="Microsoft.AspNet.Web.Optimization" /> <dependency id="Modernizr" /> </dependencies> </metadata> </package>

Uložte balíček pod názvem `Altairis.SiteBoilerplate.1.0.0.nupkg`.

### Vytvoření soukromého NuGet feedu

Vzhledem k poměrně specifické povaze těchto balíčků není vhodné je publikovat na nuget.org, ale je vhodné vytvořit si pro ně soukromý repozitář. Zde popíšu nejjednodušší způsob, lokální adresář, ale pro práci v týmu si můžete vytvořit i interní webový repozitář. Pokud nevíte jak, podívejte se na záznam z přednášky [NuGet pro uživatele i autory komponent](http://youtu.be/9Qbr19h_Un0).

Oba dva balíčky (`*.nupkg`) nahrajte do libovolné složky někde na disku. V mém případě je to složka `C:\Users\altair\Projects\_NuGet`.

Spusťte Visual Studio a v menu jděte do `Tools –> Options –> Package Manager –> Package Sources`. Přidejte nový zdroj, pojmenuje ho třeba `Private` a jako cestu zadejte název výše uvedené složky.

### Použití šablony v praxi

1.  Spusťte Visual Studio a vytvořte nový projekt podle šablony `ASP.NET Empty Web Site`. 
2.  Otevřete okno Package Manager Console. 
3.  Ujistěte se, že v rozbalovacím seznamu "Package source" máte vybráno "All". 
4.  Příkazem `install-package Altairis.SiteBoilerplate` nainstalujte balíček a všechny jeho závislosti. 
5.  Po dokončení balíček zase odinstalujte příkazem `uninstall-package Altairis.SiteBoilerplate`.  

Tímto postupem jste do svého projektu nahráli nejnovější verze vámi používaných knihoven, svoje vlastní nastavení a všechno je ve stavu způsobilém další práce a případně odinstalace modulů, které zrovna v tomto konkrétním projektu nepotřebujete.

Moje hotové šablony si můžete stáhnout [zde](https://www.cdn.altairis.cz/Blog/2012/20120903-SiteBoilerplate.zip).