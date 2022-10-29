<!-- dcterms:title = Sqlite: Databáze pro menší projekty -->
<!-- dcterms:abstract = Když se před .NET vývojářem řekne "databáze", zpravidla si představí Microsoft SQL Server. Nicméně nejpoužívanější relační databází na světě je něco jiného: embedded databáze Sqlite. A ta má přímo od Microsoftu velmi dobrou podporu i v .NETu. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:coverUrl = /cover-pictures/20200713-bacpac.jpg -->
<!-- x4w:coverCredits = @jankolario via Unsplash.com -->
<!-- x4w:pictureUrl = /perex-pictures/20200713-bacpac.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = IT -->
<!-- dcterms:dateAccepted = 2022-10-29 -->

Když se před .NET vývojářem řekne "databáze", zpravidla si představí Microsoft SQL Server. Nicméně nejpoužívanější relační databází na světě je něco jiného: embedded databáze [Sqlite](https://www.sqlite.com/). A ta má přímo od Microsoftu velmi dobrou podporu i v .NETu.

## Embedded database

Co jsou _embedded database_? Formy úložiště dat, které nejsou aplikaci poskytovány externě jako služba, ale spravuje si je aplikace sama vlastními prostředky, obvykle za pomoci nějaké knihovny. Zatímco klasické databáze běží v samostatném procesu na aplikaci nezávislém (a často běžícím třeba i na jiném serveru), embedded databáze běží v procesu aplikace samé.

Pravděpodobně nejpoužívanější embedded databází je Sqlite. Máte ji pravděpodobně v desítkách kopií na svém počítači, mobilu a možná i v autě. Jako formát pro ukládání dat ji používá třeba Adobe Lightroom, iTunes (a řada dalších aplikací od Apple), Dropbox, prakticky všechny webové prohlížeče (Chrome, Firefox, Edge, Opera), Skype, automobilové infotainment systémy od firmy Bosch, letadlo A350 XWB od firmy Airbus a řada dalších.

Nejedná se však o jedinou embedded databázi. Z těch známějších:

* [Extensible Storage Engine](https://learn.microsoft.com/en-us/windows/win32/extensible-storage-engine/extensible-storage-engine) je embedded nerelační databáze, kterou používá Exchange, Microsoft Update a řada dalších produktů od Microsoftu.
* Microsoft měl ještě jednu embedded databázi, SQL Server Compact, ale ta je již delší dobu deprecated a Microsoft místo ní doporučuje právě Sqlite.
* Firebird, Informix, InterBase a MySql mají své embedded verze.

### Výhody embedded databází

* Malý footprint, potřebné knihovny mají obvykle jednotky až desítky megabajtů.
* Není nutné je samostatně instalovat, jsou součástí programu.
* Neběží pokud neběží aplikace která je využívá.
* Lze je použít jako interní souborový formát (srovnatelné např. s JSON, XML nebo různými samo-domo formáty).
* Jsou zpravidla zdarma a není nutné platit licenční poplatky. Sqlite je dokonce public domain.

### Nevýhody embedded databází

* Neřeší automatizovanou zálohu a údržbu dat, to si musí aplikace zajistit sama.
* Nejsou vhodné, pokud je databáze od klienta oddělena sítí.
* Špatně zvládají paralelní zápisy od více klientů současně. Sqlite takové požadavky řadí do fronty.
* Nejsou vhodné pro velké objemy dat (řádově gigabajty až desítky gigabajtů a více).
* Jedná se o "bázi dat" v nejortodoxnějším smyslu, tedy "úložiště dat". Embedded databáze zpravidla nepodporují jakoukoliv funkcionalitu na straně databáze, jako uložené procedury a podobně.
* "Velké" databáze zpravidla nabízejí různé pokročilejší funkce jako fultextové vyhledávání, analytiku, reporty... Embedded databáze nic takového nemívají.

## Seriál na kanálu Z-TECH

Natočil jsem trojici videí, která popisuje použití Sqlite v .NET a ASP.NET aplikacích. Jako první doporučuji shlédnout video obecně popisující embedded databáze a Sqlite:

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/LHbZzr23q0o" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

Další video se zabývá tím, jak lze používat Sqlite z Entity Frameworku Core a hlavně jak napsat univerzální aplikaci, která umí fungovat jak proti Microsoft SQL Serveru, tak proti Sqlite, včetně podpory migrací:

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/Z-3Kx2oAZrs" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

Z mého hlediska zásadní nevýhodou Sqlite je, že nemá automatizovanou zálohu. Abych tento problém vyřešil, napsal jsem knihovnu [Altairis.SqliteBackup](https://github.com/ridercz/Altairis.SqliteBackup), která umí Sqlite databáze automaticky zálohovat na lokální server, vzdálený server nebo do Microsoft Azure:

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/XQErfo-yVhM" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

## Hodí se Sqlite na webové aplikace?

Podle mého názoru na většinu menších aplikací ano. Pod pojmem "menší" aplikace rozumím takovou, která má jeden aplikační server (tj. ne webovou farmu/cluster), databáze o velikosti do řádově jednotek gigabajtů, stovky až menší tisíce uživatelů a hodně se z ní čte a málo zapisuje. Za těchto podmínek Sqlite svými funkcemi i výkonem většinou zcela postačuje.

Zásadní překážkou je podle mne absence automatické zálohy. Proto jsem vytvořil výše zmíněnou knihovnu Altairis.SqliteBackup, která tento nedostatek odstraňuje.

Samozřejmě pokud máte infrastrukturu, v níž již máte SQL Server a není pro vás problém vytvořit si tam další databázi, Sqlite můžete možná pominout. Anebo taky ne. Mnohde je s databázemi menších aplikací problém cenový a/nebo organizační.Na hostingu nebo v cloudu za mini databázi o pěti tabulkách pro mini splikaci zaplatíte stejně jako za poměrně slušnou databázi. Viz například Azure, kde se se SQL Serverem pod $5 měsíčně nedostanete - a pokud máte malých aplikací desítky, leze to docela do peněz. Viděl jsem úspěšné použití Sqlite databází i v korporacích, kde interní náklady na zprovoznění nové databáze (papírování a schvalování) jsou tak velké, že je lepší použít Sqlite. Minimálně jako dočasné řešení, přičemž se zde často projevuje česká národní zkušenost, že jednotkou dočasnosti je jeden furt.

V neposlední řadě lze Sqlite použít pro vývoj, testování a dema, kdy nechcete dodatečný overhead v podobě nutnosti vytvářet a udržovat databáze na SQL Serveru, byť třeba bezplatné Expres edici.