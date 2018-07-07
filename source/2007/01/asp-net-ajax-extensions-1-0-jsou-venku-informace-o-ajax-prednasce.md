<!-- dcterms:identifier = aspnetcz#134 -->
<!-- dcterms:title = ASP.NET AJAX Extensions 1.0 jsou venku (+ informace o Ajax přednášce) -->
<!-- dcterms:abstract = Před několika hodinami byla uvolněna finální verze ASP.NET AJAX Extensions. Uvnitř článku naleznete odkaz a informace o Ajaxu se týkajících akcích. -->
<!-- np9:categoryId = 6 -->
<!-- x4w:category = Akce a události -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2007-01-24T01:52:35.64+01:00 -->
<!-- dcterms:dateAccepted = 2007-01-24T01:52:35.64+01:00 -->

Před několika hodinami (včera v 0900 místního času v Seattle) byla uvolněna dlouho očekávaná ostrá verze 1.0 ASP.NET AJAX Extensions. Na níže uvedených adresách si ji můžete stáhnout:

*   [ASP.NET AJAX Extensions 1.0 RTM](http://go.microsoft.com/fwlink/?LinkID=77296) 
*   [AJAX Control Toolkit release 10123 Production](http://www.codeplex.com/Release/ProjectReleases.aspx?ProjectName=AtlasControlToolkit) 
*   [AJAX Futures January CTP](http://go.microsoft.com/fwlink/?LinkID=77294) 

## Z čeho se AJAX Extensions skládají?

### Microsoft AJAX Library

Základem všeho je teoreticky [Microsoft AJAX Library](http://ajax.asp.net/downloads/library/default.aspx?tabid=47). Jedná se o sbírku klientských skriptů (JavaScriptu), která je platformně nezávislá. Pokud si k tomu seženete nebo dopíšete (rozhraní je otevřené) serverovou část, můžete tuto knihovnu používat třeba v PHP nebo čemkoliv jiném. Pokud píšete v ASP.NET, nemusíte se tím zabývat, protože tato knihovna je zahrnuta v následných verzízh.

### ASP.NET AJAX Extensions

Toto je sbírka komponent, které využívají (a mají v sobě vestavěnou) shora uvedenou knihovnu. Z hlediska ASP.NET programátora se jedná o standardní server controls, které se používají úplně stejně jako jakákoliv jiná komponenta v ASP.NET. Tato knihovna je plně podporována standardními prostředky Microsoftu a obsahuje funkce, které jsou důkladně otestované, mj. i na kompatibilitu v prohlížečích.

### AJAX Control Toolkit

Control Toolkit je sada rozšiřujících komponent, které využívají AJAX Extensions. Tento projekt je vyvíjen i lidmi mimo Microsoft a na serveru CodePlex jsou volně dostupné jeho [zdrojové kódy](http://www.codeplex.com/Release/ProjectReleases.aspx?ProjectName=AtlasControlToolkit).

### AJAX Futures

Do knihovny AJAX Futures Microsoft zařadil funkce, které nepovažuje za tak důvěryhodné a široce kompatibilní jako ty, co jsou součástí jádra. Dá se předpokládat, že postupně budou tyto funkce integrovány do jádra, ale v současné době Microsoft tuto knihovnu oficiálně nepodporuje.

## Akce týkající se AJAX Extensions

Před týdnem jsem měl [přednášku o Ajaxu](http://akce.altairis.cz/Events/25.aspx). Dosud jsem se nedostal k tomu, abych zpracoval záznamy a zveřejnil příklady. Ve světle těchto událostí tak ani nebudu činit a uspořádám aktualizovanou přednášku, která bude odpovídat ostré verzi. Její termín včas oznámím, momentálně ho řeším s Microsoftem.

Pokud máte zájem o hlubší vhled, doporučuji Hands-on-lab GOC37 od Gopasu, který připravuji. Více informací najdete v [tomuto kurzu věnovanému článku](https://www.aspnet.cz/Articles/133-hands-on-labs-na-asp-net-ajax-a-dalsi-rozsireni.aspx).