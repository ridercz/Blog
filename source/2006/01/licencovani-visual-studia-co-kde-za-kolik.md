<!-- dcterms:identifier = aspnetcz#71 -->
<!-- dcterms:title = Licencování Visual Studia: co, kde, za kolik... -->
<!-- dcterms:abstract = Dlouhodobě se nijak netajím s názorem, že vývojářský software Microsoftu je mnohem snazší ukrást, než koupit. Ba co více, ono je obvykle téměř nemožné snadno zjistit, kolik že vlastně stojí. Proto jsem, za laskavé spolupráce spřátelených odborníků, sepsal tento článek, který popíše aktuální stav ohledně Visual Studia a Microsoft SQL Serveru. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Programování -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2006-01-02T05:06:40.607+01:00 -->
<!-- dcterms:dateAccepted = 2006-01-02T05:06:40.607+01:00 -->

Dlouhodobě se nijak netajím s názorem, že vývojářský software Microsoftu je mnohem snazší ukrást, než koupit. Ba co více, ono je obvykle téměř nemožné snadno zjistit, kolik že vlastně stojí. Proto jsem, za laskavé spolupráce spřátelených odborníků, sepsal tento článek, který popíše aktuální stav ohledně Visual Studia a Microsoft SQL Serveru.

## Průvodce edicemi Microsoft Visual Studia

Hlavním vývojářským nástrojem od Microsoftu je Visual Studio 2005. To se vyskytuje ve čtyřech hlavních edicích. Budu se jim věnovat dosti podrobně a říkat i zdánlivé triviality – vím na co se lidé ptají, co je pro jednoho samozřejmé, jinému tak připadat nebude.

### Express Editions

Formálně pojednáno nepatří vývojové nástroje Express mezi edice Visual Studia. Pojednáno prakticky však nepochybně ano. Jejich hlavním znakem jest, že jsou až na další k dispozici zdarma. 

Ono „další“ znamená, že oficiální stanovisko Microsoftu je, že cena Express edice je $ 49, ale po dobu jednoho roku od uvedení (tedy do listopadu 2006) je možno je stáhnout zdarma. Licence sama je trvalá, takže i pokud MS po roce další stahování znemožní, budete moci tyto edice používat nadále. Osobně jsem přesvědčen že k žádnému zpoplatnění nikdy reálně nedojde a že se jedná o poslední křeč Microsoftu před porušením letité tradice nedávat vývojové nástroje zdarma.

První rodinu Express nástrojů tvoří samostatné jazyky: **Visual Basic .NET Express**, **Visual C# Express**, **Visual J# Express** a **Visual C++ Express.** Je to prostředí určené pro vývoj běžných desktopových aplikací v daném programovacím jazyce.

Pro vývoj webových aplikací je tu **Visual Web Developer Express**. Pro vývoj webových aplikací v něm můžete použít VB.NET a nebo C#, VWD podporuje obojí.

Zcela samostatnou kapitolou je **Microsoft SQL Server 2005 Express**. Nevztahuje se na něj shora uvedená obezlička chytré horákyně „zadarmo i za peníze“ a bude oficiálně k dispozici zdarma na věky věkův. Jedná se totiž o následovníka SQL Server Desktop Engine, alias MSDE. Jedná se o odlehčenou verzi SQL Serveru, omezení jsou přehledně shrnuta [v článku na webu Terratrax](http://www.teratrax.com/articles/sql_server_2005_express.html). Výhodou je, že k Express edici je k dispozici i základní nástroj pro správu, [Management Studio Express](http://www.microsoft.com/downloads/details.aspx?FamilyID=c243a5ae-4bd1-4e3d-94b8-5a0f62bf7796&DisplayLang=en).

Express edice jsou jediné, kde jsou jazyky a platformy v oddělených produktech. Všechny vyšší edice obsahují všechno v jednom, vývoj pro web i desktop, ve všech jazycích a tak dále. Dále pak nemůžete psát programy pro mobilní zařízení (Pocket PC), add-iny pro Microsoft Office a Visual Studio a 64bitové aplikace.

S výjimkou shora uvedených neexistují žádná další omezení. Z hlediska licenčního můžete vyvíjet jaké aplikace chcete, komerční, open source, freeware, jak je libo. Z hlediska technologického také neexistují žádná omezení, aplikace mohou být libovolně složité, kompilátor je ve všech edicích stejné. Stejná (v Express edicích i ve „velkém“ VS 2005) je i logika ovládání a formáty projektových souborů. Nic vám tedy nebrání začít pracovat v Expressu a přejít později na VS nebo naopak.

Pokud to potřebujete, můžete si na počítač nainstalovat Express edic několik, a to i pokud máte nainstalované „velké“ Visual Studio. Osobně mám na počítači nainstalován VB.NET Express, VWD Express a Visual Studio 2005 Team Edition. Za prvé abych věděl co všechno Express edice umí a za druhé protože VWD je menší, rychlejší a zabírá méně paměti – na většinu práce používám VWD místo velkého Studia.

### Visual Studio Standard Edition

Jedná se o základní verzi VS. Od Expressu se odlišuje především tím, že je „všechno v jednom“. Dále pak má schopnější uživatelské rozhraní (pluginy, možnost používat source control systems atd.). Umí též kompilovat programy pro kapesní počítače a platformu x64.

### Visual Studio Professional Edition

Nejviditelnějším skokem proti Standardu je, že součástí je licence na Microsoft SQL Server 2005 Developer Edition (ve Standardu je pořád jenom Express). S tím souvisí i přítomnost pokročilejších nástrojů pro práci s databází a vývoj databázových aplikací. Zároveň umí remote debugging.

### Visual Studio Tools for Office

Tato edice je určena speciálně pro vývoj aplikací rozšiřujících Microsoft Office. Je křížencem mezi Standard a Professional, ale umožňuje pouze vývoj pro Office. Součástí je kromě SQL Serveru 2005 Developer Edition též licence na redistribuci Access runtime. Podporuje pouze Visual Basic a C#.

### Visual Studio Team System

Vlajková loď Microsoftu v oblasti vývojových nástrojů. Umí úplně všechno, co předchozí edice (včetně vývoje pro Office). Jako jediná edice umožňuje vývoj pro serverovou 64-bitovou platformu Itanium.

Její hlavní smysl ale spočívá v silné podpoře pro týmovou spolupráci pomocí VS Team Foundation Serveru, tedy pro vývoj ve větších firmách. Dále pak obsahuje mocné nástroje pro testování: statickou analýzu, unit testing atd.

## Co za to?

Nejzábavnější část celého procesu pořizování vývojových nástrojů nastane ve chvíli, kdy víte co chcete a začnete se zajímat o to kdo vám to prodá – a hlavně za kolik. Přirozená reakce je, že se podíváte do ceníku svého oblíbeného dodavatele počítačovin. První (a dosti pravděpodobná) možnost je, že tam VS 2005 nenajdete vůbec. Opačným extrémem je, že tam najdete několik desítek řádků, které se liší jedním až třemi písmenky a cenou v širokém rozpětí od padesáti korun po půl miliónu, což vám asi mnoho k užitku nebude.

Přes houževnatý odpor se mi pro vás podařilo v průběhu křížového výslechu třetího stupně získat i nějaká konkrétní čísla. Cena Visual Studia 2005 ve verzi Standard je okolo devíti tisíc bez DPH. Professional stojí tisíc zhruba pětadvacet, případně čtyřicet i ročním předplatným MSDN.

Shora uvedené údaje byly doprovázeny rozličným nezapamatovatelným pakliže a jestliže. Cena může být mnohem nižší v případě upgrade (a upgradovat se dá za různých podmínek z ledasčeho, včetně neaktuálních verzí a konkurenčních nástrojů). Jiné ceny platí pro předplatné na více než jeden rok, jiné pro školství a studenty, jiné pro orgány státní správy a samosprávy a podobně. 

Licenční politika Microsoftu je neustále se měnící džunglí speciálních nabídek, upgradů, multilicencí a předplatných, v níž přežije jenom ten nejsilnější. Je dosti pravděpodobné, že některou z těchto nabídek můžete využít, i když o tom možná ani nevíte. Proto doporučuji držet se úsloví *líná huba, holé neštěstí* a *drzé čelo lepší než poplužní dvůr* a zeptat se u odborníků. 

To může znamenat informační linku Microsoftu, ale ještě lépe MSDN infocentrum, které v ČR provozuje společnost Daquas (web mají na [www.daquas.cz](http://www.daquas.cz/), ale radši tam nechoďte dokud se mi nepodaří je přesvědčit že chtějí abych jim udělal nový :-) Sestylizujte tedy pečlivě svůj dotaz a odešlete ho na adresu [msdn@daquas.cz](mailto:msdn@daquas.cz). 

Buďte ovšem připraveni na to, že v odpověď budete podrobeni přísnému křížovému výslechu, jehož cílem bude zjistit, zda nespadáte do některé z momentálně protěžovaných skupin. Odpovídejte podrobně a pravdivě, je to ve vašem vlastním zájmu.

Na tomto webu srdnatě hájím zájmy těch nejmenších. Nemám samozřejmě na mysli děti – chmurnou budoucnost národa, ale osamocemé vývojářské vlky, začínající firmičky a podobně. Podezíravě jsem se tedy ptal, zda se se mnou bude někdo bavit, i když chci *jednu* licenci Standard edice Visual Studia a nebudu mít kšeft za milión? Dostalo se mi ujištění že bude. Na tyto dotazy jsou v MSDN infocentru Daquasu cvičení a jsou za to údajně i placeni.

## Výzva místo závěru

Pokud máte nějaké dotazy, týkající se licencování vývojářských nástrojů, napište je do diskuze k tomuto článku. Negarantuji jejich zodpovězení, ale budeme se snažit a případně z odpovědí zkompiluji další článek.

Za pomoc při přípravě tohoto článku děkuji Igoru Vítovi (mimochodem MVP pro Fox Pro) a jeho krásné kolegyni z Daquasu, jejíý jméno jsem bohužel již úspěšně zapomněl.

### Související odkazy:

*   [Porovnání edic Visual Studia 2005](http://msdn.microsoft.com/vstudio/products/compare/default.aspx)

*   [Daquasí časopis Quas](http://www.daquas.cz/quas/), obsahující rozličné informace o právě vypuknuvších akcích, FAQ a podobně
*   [ASP.NET 2.0: Nechejte maličkých přijíti ke mně… ](http://weblog.rider.cz/entry/article-20051109.aspx)– zamyšlení nad politikou Microsoftu v oblasti vývojových nástrojů na mém osobním weblogu
*   [Zdejší článek k uvedení Express nástrojů](/entry/article-20051114.aspx#192050)

*   [Stažení Express edic](http://msdn.microsoft.com/vstudio/express/) z webu Microsoftu
*   [MSDN Connection: Vánoční dárek od Microsoftu](/entry/article-20051220.aspx#164258) – pokud se vám nechce stahovat, objednejte si DVD s knížkou zdarma