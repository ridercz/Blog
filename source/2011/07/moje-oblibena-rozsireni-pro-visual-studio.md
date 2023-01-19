<!-- dcterms:identifier = aspnetcz#329 -->
<!-- dcterms:title = Moje oblíbená rozšíření pro Visual Studio -->
<!-- dcterms:abstract = Reinstalace počítače spojená s výměnou systémového disku za SSD mne přiměla k vytvoření seznamu rozšíření pro Visual Studio, která používám. Jsem si vědom toho, že preference jsou věcí čistě subjektivní, ale přesto zveřejňuji své tipy, protože by se mohly hodit I ostatním. Můžete se v komentářích podělit i o svoje vlastní tipy. -->
<!-- np9:categoryId = 7 -->
<!-- x4w:category = Software -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2011-07-10T22:15:01.973+02:00 -->
<!-- dcterms:date = 2011-07-10T22:15:03+02:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20110710-moje-oblibena-rozsireni-pro-visual-studio.jpg -->

Reinstalace počítače spojená s výměnou systémového disku za SSD mne přiměla k vytvoření seznamu rozšíření pro Visual Studio, která používám. Jsem si vědom toho, že preference jsou věcí čistě subjektivní, ale přesto zveřejňuji své tipy, protože by se mohly hodit I ostatním. Můžete se v komentářích podělit i o svoje vlastní.

Všechna zde zmiňovaná rozšíření jsou k dispozici zdarma.

## VisualSVN Server + TortoiseSVN + AnkhSVN

Nikdy jsem nepřišel na chuť Team Foundation Serveru ani různým distribuovaným version control systémům typu Mercurial nebo Git a používám Subversion.

*   **[VisualSVN Server](http://www.visualsvn.com/server/)** je server pro Subversion. Je to jednoduchý instalační balíček, který v sobě skrývá vlastní Subversion a Apache pro HTTP/HTTPS přístup. Zkonfigurovat vlastní SVN server pod Apache není jednoduché (zvlášť pokud se pohybujete ve světě .NET a IIS a o Apache nic nevíte), s tímto produktem je to snadné. Má i placenou "Enterprise" verzi, kterou ovšem nejspíš nebudete potřebovat.
*   **[TortoiseSVN](http://www.tortoisesvn.net)** je populární Subversion klient, který integruje jeho schopnosti do operačního systému. Pokud používáte 64-bitovou platformu, musíte si nainstalovat obě verze, x86 i x64 (protože i na x64 systému jsou některé části x86 a 64-bitové shell extensions na nich nefungují).
*   **[AnkhSVN](http://ankhsvn.open.collab.net/)** je Subversion source control plugin do Visual Studia. Umožňuje vám tedy pracovat s repository přímo z prostředí Visual Studia.

## PowerCommands for Visual Studio 2010

Podle mého názoru zcela nezbytný doplněk pro Visual Studio, přímo od Microsoftu. Přidává některé funkce, na které se podle mého názoru zapomnělo, jako kopírování referencí, zavírání všech oken najednou, organizace importů v celé projektu najednou a další. Stahujte pomocí Extensions Manageru nebo z [Visual Studio Extensions Gallery](http://visualstudiogallery.msdn.microsoft.com/e5f41ad9-4edc-4912-bca3-91147db95b99/).

## Productivity Power Tools

Rozšíření z podobného vrhu. Obsahuje spoustu funkcí, z nichž asi polovina mne nevýslovně štve a okamžitě je vypínám (jiný find/replace dialog, align assignments, některé funkce se záložkami...), bez jiných nedokážu žít (automatické doplňování závorek, jiný dialog pro přidávání referencí, HTML copy, barevné záložky podle projektu… Stahujte pomocí Extensions Manageru nebo z [Visual Studio Extensions Gallery](http://visualstudiogallery.msdn.microsoft.com/d0d33361-18e2-46c0-8ff2-4adea1e34fef/).

## JScript Editor Extensions

Sada doplňků od Microsoftu, vylepšující IntelliSense a obecně práci s JavaScriptem. Stahujte pomocí Extensions Manageru nebo z [Visual Studio Extensions Gallery](http://visualstudiogallery.msdn.microsoft.com/872d27ee-38c7-4a97-98dc-0d8a431cc2ed).

## Indent Guides

Doplní čáry, vizuálně zdůrazňující odsazení částí kódu. Nepostradatelné v hluboce hierarchicky strukturovaných záležitostech HTML, XML, C#… Stahujte pomocí Extensions Manageru nebo z [Visual Studio Extensions Gallery](http://visualstudiogallery.msdn.microsoft.com/e792686d-542b-474a-8c55-630980e72c30).

## Image Optimizer

Addin, který řeší optimalizaci velikosti PNG a JPG souborů. Optimalizace je bezztrátová, funguje na principu vnitřní optimalizace datových struktur. Addin umí také převést obrázky na Data URIs. Stahujte pomocí Extensions Manageru nebo na [blogu autora](http://madskristensen.net/post/Image-Optimizer-(beta)-VS2010-extension.aspx).

## POCO Templates for Entity Framework

T4 šablony pro generování "plain old CLR classes" z Entity Framework data modelů. Stahujte pomocí Extensions Manageru, více informací na [blogu ADO.NET teamu](http://blogs.msdn.com/b/adonet/archive/2010/01/25/walkthrough-poco-template-for-the-entity-framework.aspx).

## NuGet Package Manager

Netřeba myslím zvlášť představovat, podrobnější informace najdete na [www.nuget.org](http://www.nuget.org). 

## SQL Server Compact Toolbox

Pokud používáte SQL Server CE, v podstatě nepostradatelná pomůcka. Pohodlná správa SDF souborů, skriptování, migrace obsahu mezi "velkým" a "malým" SQL Serverem… K dispozici jako addin do Visual Studia nebo jako samostatná aplikace na [http://sqlcetoolbox.codeplex.com/](http://sqlcetoolbox.codeplex.com/ "http://sqlcetoolbox.codeplex.com/").

## GhostDoc

Nástroj pro automatické generování XML dokumentace ke třídám, vlastnostem, metodám… Má spoustu inteligentních šablon, které vygenerují I hodně návodného textu, který pak staší jenom upravit. Free verze je zdarma, schopnější Pro za peníze. Ke stažení na [SubMain](http://submain.com/products/ghostdoc.aspx).

## Web Standards Update

Podpora pro CSS 3.0 a HTML 5 ve Visual Studiu 2010 – validace, intellisense… Opět k dispozici přes Extension manager nebo na [Visual Studio Gallery](http://visualstudiogallery.msdn.microsoft.com/a15c3ce9-f58f-42b7-8668-53f6cdc2cd83).