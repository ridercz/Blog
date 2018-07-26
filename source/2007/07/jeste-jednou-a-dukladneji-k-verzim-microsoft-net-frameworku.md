<!-- dcterms:identifier = aspnetcz#161 -->
<!-- dcterms:title = Ještě jednou a důkladněji k verzím Microsoft .NET Frameworku -->
<!-- dcterms:abstract = AKTUALIZOVÁNO o verze AJAX Extensions. Poslední dobou se množí dotazy, jejichž společným jmenovatelem je nepochopení systému verzí .NET Frameworku a souvisejících technologií. Není se čenu divit, protože v tom zmatek skutečně je. Proto vznikl tento článek, který popisuje všechny existující verze .NETu a vztahy mezi nimi. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = IT -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2007-07-30T08:49:16+02:00 -->
<!-- dcterms:dateAccepted = 2007-07-30T08:49:16+02:00 -->

Poslední dobou se množí dotazy, jejichž společným jmenovatelem je nepochopení systému verzí .NET Frameworku a souvisejících technologií (tématu jsem se již věnoval v článku [Co je vlastně .NET Framework 3.0](http://www.aspnet.cz/Articles/123-co-je-vlastne-net-framework-3-0.aspx)). Není se čenu divit, protože v tom zmatek skutečně je. 

Pokusím se popsat vývoj .NET Frameworku a souvisejících technologií, včetně seznamu použitých kódových jmen.

## Microsoft .NET Framework 1.0

Historicky první verze .NETu. S ní bylo nerozlučně spjato též **Microsoft Visual Studio .NET** (kde ".NET" je označení verze, něco jako XP). To bylo posléze polooficiálně překřtěno na **Microsoft Visual Studio .NET 2002**. Kódové označení této release bylo **Rainier**.

## Microsoft .NET Framework 1.1

"Service Pack" na .NET; nepřinášel koncepční změny, ale spíš aktualizace. Odpovídalo mu **Microsoft Visual Studio .NET 2003** (codename **Everett**). Tato verze uměla pracovat jenom s .NETem 1.1 (ne 1.0) a naopak - verze VS byla tedy spjata s verzí frameworku.

Jedná se o první verzi .NET Frameworku, která je přímo součástí operačního systému - Windows Serveru 2003.

## Microsoft .NET Framework 2.0

Zcela nová a v mnohých ohledech převratná verze .NET Frameworku. Přináší opět nové Studio: **Microsoft Visual Studio 2005** (codename **Whidbey**). Stejně jako v předchozích verzích platí, že verze VS je pevně spjata s verzí frameworku. 

Nově se též objevují "Express" edice nástrojů, například **Microsoft Visual Web Developer Express 2005**. Tyto "Express" edice nemají nic společného s rodinou nástrojů "**Microsoft Expression**", což jsou nástroje pro grafický design.

Současně s touto verzí je uvolněna též nová verze databázového stroje: **Microsoft SQL Server 2005** (codename **Yukon**). I on má Express edici, která je zdarma a nahrazuje předcházející MSDE 2000.

### Microsoft ASP.NET Ajax Extensions

K .NET Frameworku 2.0 vychází řada rozšíření. Asi nejvýznamnější z nich od Microsoftu jsou Ajax Extensions (kódové označení **Atlas**). Jedná se o sadu knihoven pro ASP.NET 2.0, umožňující použití technologie Ajax. Nejedná se o novou verzi ASP.NET, ačkoliv "Atlas" bylo svého času používáno i v tomto významu.

## Microsoft .NET Framework 3.0

Aktuální verze 3.0 je v podstatě [marketingový podvod](http://www.aspnet.cz/Articles/123-co-je-vlastne-net-framework-3-0.aspx). "Nová" verze je další sada rozšiřujících knihoven pro .NET 2.0, srovnatelná principiálně s Ajax Extensions. Rozšiřující knihovny zahrnují **Windows Communications Foundation** (WCF, codename **Indigo**), **Windows Presentation Foundation** (WPF, codename **Avalon**), **Windows Workflow Foundation** (WF) a **Windows Card Space** (alias **InfoCard**).

Kódové označení této verze jako celku bylo **WinFX**. Aplikace pro V 3.0 se vyvíjejí v předchozí generaci vývojových nástrojů (VS 2005 atd.). Tato verze je součástí Microsoft Windows Vista.

Z hlediska "čistého" ASP.NET a Web Forms vývoje je jedinou novinkou ve verzi 3.0 technologie CardSpace, neobjevily se žádné nové server controly ani schopnosti.

## Microsoft .NET Framework 3.5

Verze .NET Frameworku, která bude uvolněna v únoru 2008, v době psaní tohoto článku je k dispozici ve verzi Beta 2. Jedná se opět o rozšíření verze 2.0, i když velmi zásadní. Pro ASP.NET přináší hromadu nových serverových ovládacích prvků

Novinkou je, že **Microsoft Visual Studio 2008** (codename **Orcas**) bude poprvé v historii podporovat vývoj aplikací pro více verzí .NET Frameworku - multi targeting. Ve VS 2008 tedy budete schopni vyvíjet aplikace pro verze 2.0, 3.0 a 3.5.

Spolu s .NET Frameworkem 3.5 a VS 2008 bude uveden též **Microsoft SQL Server 2008** (codename **Katmai**) a **Microsoft Windows Server 2008** (codename **Longhorn**).

## A co AJAX?

Krátce po vydání tohoto článku shodou okolností vyšel na weblogu Scotta Guthrieho článek [ASP.NET AJAX in .NET 3.5 and VS 2008](http://weblogs.asp.net/scottgu/archive/2007/07/30/asp-net-ajax-in-net-3-5-and-vs-2008.aspx), který se zabývá vztahem AJAX Extensions a AJAX Control Toolkitu s verzemi frameworku 2.0/3.0/3.5.