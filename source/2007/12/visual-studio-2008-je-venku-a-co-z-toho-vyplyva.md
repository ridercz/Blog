<!-- dcterms:identifier = aspnetcz#173 -->
<!-- dcterms:title = Visual Studio 2008 je venku a co z toho vyplývá -->
<!-- dcterms:abstract = Před několika dny byla uveřejněna finální verze Microsoft .NET Frameworku 3.5 a Visual Studia 2008. Pojďme se podívat na to, co z toho vyplývá a jak náročný bude přechod. -->
<!-- np9:categoryId = 7 -->
<!-- x4w:category = Software -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2007-12-05T09:00:55+01:00 -->
<!-- dcterms:dateAccepted = 2007-12-05T09:00:55+01:00 -->

Jak jste patrně zaznamenali, byl před pár dny zveřejněn Microsoft .NET Framework 3.5 a Visual Studio 2008. Co z toho vyplývá pro vývojáře, a to zejména webové?

## Co je vlastně Microsoft .NET Framework verze 3.5?

Stejně jako v případě verze 3.0, i .NET Framework 3.5 je v podstatě jenom hromádka rozšiřujících knihoven nad runtime verze 2.0. Ačkoliv jsem se v jednom z minulých článků vyjádřil poněkud nelichotivě, že nové verzování je marketingový podvod, ve skutečnosti je to spíše jev pozitivní. Platforma je ve verzi 2.0 navržená natolik dobře a robustně, že lze i rozšíření poměrně zásadní, jako je například Linq a podobně, implementovat, aniž by bylo nutné zasahovat do jádra samého.

Dobrou zprávu to znamená i pro vývojáře, protože to znamená podstatně jednodušší side-by-side konfiguraci a žádné *breaking changes*. Součástí .NET Frameworku 3.5 je i SP1 pro .NET 2.0 a .NET 3.0, který umožní některé z novinek.

Zvláštní péči nemusíte zachovávat ani při provozu webových aplikací na web serveru. Vzhledem ke stejnému základu mohou aplikace verzí 2.0, 3.0 a 3.5 běžet v jednom application poolu. Nebude se tedy opakovat situace z přechodu mezi verzemi 1.1 a 2.0, které je nutné provozovat každou v samostatném application poolu.

Více informací o verzování .NET Frameworku najdete v následujících článcích:

*   [Ještě jednou a důkladněji k verzím Microsoft .NET Frameworku](http://www.aspnet.cz/Articles/161-jeste-jednou-a-dukladneji-k-verzim-microsoft-net-frameworku.aspx) [Co je vlastně .NET Framework 3.0](http://www.aspnet.cz/Articles/123-co-je-vlastne-net-framework-3-0.aspx) 

### Instalace .NET 3.5

.NET Framework 3.5 bude nepochybně časem na Windows Update, zatím si ho ale musíte stáhnout zvlášť v [download centru](http://go.microsoft.com/?linkid=7755937).

Standardní instalace na výše uvedené vám stáhne jenom třímegový bootstrapper, který si z Internetu dotáhne vše, co je třeba, v závislosti na tom, jaké verze .NETu už máte. Pokud byste chtěli stáhnout celou instalačku, hledejte na shora uvedené stránce odkaz [.NET Framework 3.5 full package](http://download.microsoft.com/download/6/0/f/60fc5854-3cb8-4892-b6db-bd4f42510f28/dotnetfx35.exe). Full package má bezmála 200 MB, protože obsahuje verze 2.0, 3.0 a 3.5 v x86 i x64 verzi.

## Co je v 3.5 nového pro ASP.NET?

Odpověď *nic* by nebyla přesná. S odpovědí *nemnoho* však pochodíme výrazně lépe. Integrace se dočkaly ASP.NET Ajax Extensions, které se musely do předchozí verze doinstalovávat, nyní jsou přímo součástí ASP.NET. Funkcionalita zůstala totožná. Pokud používáte Ajax Control Toolkit, tak ten se nyní vyvíjí paralelně ve dvou verzích, jedna pro .NET 2.0 a jedna pro 3.5. Obě dvě si můžete stáhnout na [CodePlexu](http://www.codeplex.com/AtlasControlToolkit/).

Kromě Ajaxovin přibylo několik nových controlů, žádný z nich však neznamená revoluci:

*   `ListView` rozšířil řady prvků pro data binding. Umožňuje programátorovi větší kontrolu nad výsledným HTML kódem a jednodušší realizaci některých scénářů, které dříve bylo nutno řešit poněkud nesystémově a/nebo znásilňováním jiných prvků. `DataPager` je samostatná komponenta pro stránkování, která umí fungovat ve spojitosti s data bound controls, zejména výše zmíněným `ListView`. Měla by konečně umožnit civilizované stránkování nezávislé na JavaScriptu, ale zatím jsem neměl čas ji prozkoumat do hloubky. `LinqDataSource` umožňuje dotazovat se do datových zdrojů přes Linq, přítomnost tohoto prvku se tedy dala docela čekat. 

Pro webové vývojáře budou důležitější změny spíše v IIS 7.0 než v ASP.NET jako takovém. IIS má zcela novou architekturu, je mnohem rozšiřitelnější atakdále. Budu o tom mluvit na DevConu, patrně se budou konat i nějaké další akce a zcela určitě bude toto téma probíráno na pražském TechEdu příští rok na jaře. Rovněž na toto téma připravujeme nový kurz v Gopasu. Chystal jsem se o tom napsat článek, ale drobet se mi to zvrhlo, takže to vidím spíš na knížku.

Weboví programátoři nicméně nepochybně ocení novinky obecně přítomné v .NETu a neomezující se jenom na web. Zejména samozřejmě mluvím o technologii Linq. Napsal jsem pomocí Linqu dvě aplikace a musím říct, že to je fakt bomba, všechno je strongly typed, funguje IntelliSense a vývoj aplikací jde kupředu výrazně rychleji. Pro mne osobně je Linq největším plusem a už se bez něj nehodlám obejít.

Další užitečnou novinkou jsou extension methods. V principu se jedná o způsob, jak k existující třídě "zvenčí" přidat nové metody. Napsal jsem ukázkovou aplikací TraceGPS, která je hojně využívá. Tato aplikace je volně ke stažení pro členy programu [MSDN Connection](https://www.microsoft.com/cze/msdn/connection/).

## Vývojové nástroje a multitargeting

[![V&yacute;běr verze runtime ve Visual Studiu 2008](https://www.cdn.altairis.cz/Blog/2007/20071203-20071202-multitargeting_thumb.gif)](https://www.cdn.altairis.cz/Blog/2007/20071203-20071202-multitargeting_2.gif) Jak je obvyklé, s novou verzí .NETu přichází i nová verze Visual Studia. Co ale není obvyklé je nová vlastnost pojmenovaná *multitargeting*. Předchozí verze vývojových nástrojů byly spjaty s konkrétní verzí .NET Frameworku. Jedinou výjimkou je Visual Studio 2005, které je navrženo pro .NET 2.0 a verzi 3.0 se ze shora uvedených důvodů nijak zvlášť nebrání (ale také ji nijak zvlášť nepodporuje).

Visual Studio 2008 ve všech svých edicích (včetně Express) umožňuje vyvíjet aplikace pro .NET 2.0, 3.0 a 3.5. Nových funkcí vývojového prostředí můžete tedy využívat i při vývoji 2.0 aplikací. Formát projektů je shodný s předchozí verzí, formát solutions ovšem nikoliv. Pokud tedy chcete projekt vyvíjet v obou verzích, potřebujete dva SLN soubory, ukazující ale na stejné projekty.

Webové programátory patrně potěší zejména nový vizuální designér web formů. Populární split mode (zobrazení designéru a zdrojového kódu současně) já osobně moc nemusím ( ve výsledku není pořádvě vidět ani jedno), ale celkově se mi Visual Studio jeví být jaksi svižnější - a to jsem kvůli němu ani neupgradoval počítač, jak se bývalo s novou verzí VS milou tradicí. Výrazně vylepšena byla i práce s CSS a hlavně je k dispozici JavaScript intellisense.

Poslední překážkou pro definitivní přechod pro mne byla neexistence Web Deployment Projects, a tato překážka padla 1. prosince s uvedením December CTP těchto. Více najdete na blogu [Web Development Tools teamu](http://blogs.msdn.com/webdevtools/archive/2007/12/01/web-deployment-projects-wdp-for-visual-studio-2008-december-2007-ctp-released.aspx).

Express edice si muzete stahnout na [MSDN](http://www.microsoft.com/express/). Rozličné možnosti získání vyšších edic podrobněji pojednává Michael Juřek na svém blogu v příspěvku [VS 2008 a TFS 2008 - kde je vzít?](http://blog.vyvojar.cz/mjurek/archive/2007/12/02/vs-2008-a-tfs-2008-kde-je-vz-t.aspx)

## Co nás čeká dál?

Visual Studio codename Rosario je zahaleno v mlhách tajemství a střeženo zlými draky NDA.

Zajímavé věci nás ale čekají i v budoucnosti bližší: zveřejnění zdrojového kódu .NET 3.5 a zejména ASP.NET 3.5 Extensions: MVC Framework, vylepšení Ajaxu a novinky pro přístup k datům. Pre-release shora uvedeného by měly být k dispozici každým dnem, alespoň podle [článku na blogu Scotta Guthrieho](http://weblogs.asp.net/scottgu/archive/2007/11/29/net-web-product-roadmap-asp-net-silverlight-iis7.aspx) - a ten obvykle ví, o čem mluví.