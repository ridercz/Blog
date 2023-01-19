<!-- dcterms:identifier = aspnetcz#332 -->
<!-- dcterms:title = SQL Server Compact 4.0: Embedded databáze pro web -->
<!-- dcterms:abstract = Většina webových aplikací potřebuje datové úložiště. Typicky databázi, ale může se jednat i jenom o pár souborů s jednoduchou strukturou. Úložištěm první volby je pro většinu ASP.NET vývojářů Microsoft SQL Server, ale zejména pro menší aplikace může být jeho použití zbytečný overkill. Alternativou může být třeba SQL Server Compact Edition (SQL CE). -->
<!-- np9:categoryId = 7 -->
<!-- x4w:category = Software -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2011-08-23T02:50:50.877+02:00 -->
<!-- dcterms:date = 2011-08-23T02:50:52+02:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20110823-sql-server-compact-4-0-embedded-databaze-pro-web.png -->

Většina webových aplikací potřebuje datové úložiště. Typicky databázi, ale může se jednat i jenom o pár souborů s jednoduchou strukturou. Úložištěm první volby je pro většinu ASP.NET vývojářů Microsoft SQL Server, ale zejména pro menší aplikace může být jeho použití zbytečný overkill. Alternativou může být třeba SQL Server Compact Edition (SQL CE).

## Velké versus malé databáze

Klasické databázové systémy, jako třeba Microsoft SQL Server, Oracle nebo MySQL fungují nezávisle na aplikacích, které je využívají. Běží ve svém vlastním nezávislém procesu, typicky jako služba (Windows Service) a naše aplikace s nimi komunikuje pomocí nějakého definovaného rozhraní, typicky ADO.NET pomocí nějakého dialektu jazyka SQL. Databáze je pro nás černou skříňkou. Typicky nemáme jako programátoři aplikace přímou kontrolu nad tím, jak ten databázový server funguje, má svou vlastní správu paměti, souborů a práv. Běží typicky pod svým vlastním účtem a dokonce mnohdy i na jiném serveru, než je ten náš.

Instalace, konfigurace a údržba samostatného databázového systému není jednoduchá a vyžaduje samostatnou sadu znalostí, odlišnou od té programátorské. Tato komplikovaná architektura nicméně umožňuje jistou formu rozložení zátěže mezi dva fyzické servery (webový a databázový). V řadě případů si můžeme vybrat, zda ty či ony činnosti chceme vykonávat na straně webového serveru (tedy na straně ASP.NET) a nebo na straně databázového serveru. Něco je dáno pevně, ale šedá zóna, kde si můžeme vybrat dle vlastního přesvědčení, se stále rozšiřuje. 

Současná databáze nemusí být nutně jenom hloupým skladištěm dat, ale databázový server může být de facto serverem aplikačním. Řadu úkonů lze realizovat jako uložené procedury psané v T-SQL a s pomocí technologie SQLCLR lze na straně databázového serveru spouštět i .netový kód. S trochou zjednodušení by bylo možné říct, že počínaje SQL Serverem 2005 můžete psát uložené procedury v C#.

V řadě případů ale nic tak velkého nepotřebujeme. Pro velkou část aplikací se šťastně spokojím s tím, že databáze bude hloupé úložiště dat, děkuju pěkně. V řadě případů bych se bez databáze i obešel, stačí mi třeba prostý XML soubor nebo když na to přijde data oddělená čárkami. A tím se dostáváme do světa embedded databází, z nichž asi nejznámější je [SQLite](http://www.sqlite.org/).

V tomto článku vám chci představit embedded databázi od Microsoftu – **SQL Server Compact Edition**, známý také jako **SQL CE**. Nejedná se o žádnou novinku, SQL CE tady je už nějaký pátek, ale teprve verze 4.0 je použitelná i pro webové aplikace. Jeho hlavní vlastnosti (zhusta sdílené mezi embedded databázemi obecně) jsou:

*   Stejný nebo velmi podobný způsob komunikace jako s "velkým" SQL Serverem (ADO.NET, T-SQL, Entity Framework…).
*   Není nutné instalovat, stačí nakopírovat patřičné knihovny. Nevyžaduje tedy specifickou podporu např. hostingové firmy.
*   Běží jako součást aplikace, tedy v rámci jejího procesu a paměťového prostoru.
*   Datový soubor obsahuje pouze data, nemůže obsahovat žádný kód (uložené procedury, funkce…) a je tedy bezpečný z pohledu možnosti šíření malware.
*   Standardní přípona datového souboru je *.sdf*, ale je možné ji změnit a např. použít tento formát jako interní formát své aplikace.
*   Databáze nemá samostatný soubor s daty a transakčním logem (*.mdf* + *.ldf*), ale jenom jeden soubor.
*   Záloha je snadná, stačí zkopírovat datový soubor.

Pro tyto vlastnosti se embedded databáze hojně využívají v klientských (desktopových) aplikacích. Ve skutečnosti je dost pravděpodobné, že na svém počítači několik různých embedded databází už máte, protože jsou hojně využívány např. programy pro instant messaging (MSN používá SQL CE, Skype SQLite), webové prohlížeče (Mozilla používá SQLite) nebo multimediální přehrávače s knhovnou médií. V takových případech je jednodušší k aplikaci přibalit jedno DLLko, než nebohého uživatele nutit, aby instaloval a spravoval byť třeba zdarma dostupný SQL Server Express.

## SQL CE pro webové aplikace

Starší verze SQL CE nebylo možné používat ve webových aplikacích, protože nebyly připravené na současné přístupy několika uživatelů. Sice bylo možné za pomoci různých ošklivých triků a s vědomím možných problémů toto omezení obejít, ale podporovaná konfigurace to nebyla. Počínaje verzí 4.0 je nicméně SQL Server Compact Edition pro webové nasazení oficiálně schválen a doporučen Microsoftem.

Kdy byste se tedy měli poohlížet po použití SQL Serveru CE místo vyšších edic?

*   Pokud potřebujete databázi jenom jako **hloupé úložiště**. SQL CE nepodporuje uložené procedury, funkce, ani nic takového.
*   Pokud vaše aplikace pracuje s **menším objemem dat**. Ovšem ono "menší" berte s rezervou. Maximální velikost databáze jsou u SQL CE 4 GB. Mám jednu databázi, která má zhruba gigabajt a subjektivně chodí svižně.
*   Máte **méně zatěžovaný web**. Opět, to "méně" berte s rezervou, zejména pokud se hodně čte a málo zapisuje.
*   Potřebujete **zjednodušit distribuci** aplikace. SQL Server Express a vyšší musí někdo nainstalovat a zkonfigurovat. Knihovny SQL CE stačí nakopírovat do *bin* adresáře.
*   Potřebujete **zjednodušit konfiguraci** aplikace. Použití běžné databáze na Microsoft SQL Serveru vyžaduje patřičné nastavení, což nelze jednoduše udělat automaticky. Je nutné vytvořit databázi, dostat do ní patřičné objekty a zkonfigurovat connection string. U SQL CE stačí ukázat na patřičný SDF soubor.

## Nástroje pro práci se SQL CE

Pokud chcete pracovat se SQL Serverem CE, potřebujete k tomu patřičné nástroje. Visual Studio (2005 a novější) bez dalšího umí pracovat pouze s databázemi SQL CE verze 3.5, ne 4.0. Pokud chcete používat SQL CE 4.0, musíte si jednak nainstalovat patřičný runtime, ale také musíte mít Service Pack 1 pro Visual Studio (včetně Express edice). Samotný SP1 ale nestačí, musíte si nainstalovat ještě *Microsoft Visual Studio 2010 SP1 Tools for SQL Server Compact 4.0*. Podrobnější informace o nástrojích pro práci se SQL CE najdete na [blogu jeho vývojového týmu](http://blogs.msdn.com/b/sqlservercompact/archive/2011/03/15/sql-server-compact-4-0-tooling-support-in-visual-studio-2010-sp1-and-visual-web-developer-express-2010-sp1.aspx).

Nástroje od MS jsou dle mého názoru funkcemi dost omezující. Doporučuji tedy kromě nich používat i [SQL Server Compact Toolbox](http://sqlcetoolbox.codeplex.com/), což je zdarma dostupný add-in pro Visual Studio, který umí většinu toho, po čem budete kdy toužit. Zejména umí snadno kopírovat data mezi "velkým" a "malým" SQL serverem. Vaší laskavé pozornosti doporučuji i [blog autora tohoto nástroje](http://erikej.blogspot.com/), neb tam najdete spoustu informací o SQL CE.

## Jak pro SQL CE programovat

Máte v zásadě dvě možnosti: Buďto budete používat klasické ADO.NET a psát ručně SQL příkazy. V takovém případě se programování od klasického SQL liší jenom minimálně, místo *SqlConnection* použijete *CeConnection* atd. 

Druhá varianta spočívá v použití nějakého O/R mapperu, např. ADO.NET Entity Frameworku. V takovém případě vás použitý ORM od databáze odstíní úplně a na programování se nic nezmění.

Je velmi snadné psát aplikace tak, aby pouhou konfigurační změnou mohly použít buďto "velký" nebo "malý" SQL Server, případně obecně jakoukoliv ADO.NET kompatibilní databázi. Pokud nevíte jak a zajímá vás to, ozvěte se v komentářích, napíšu o tom článek.

Praktickou ukázku aplikace, která využívá SQL Server CE najdete v mém nedávném článku [WebContactList: Nová ukázková aplikace postavená na moderních technologiích](http://www.aspnet.cz/articles/331-webcontactlist-nova-ukazkova-aplikace-postavena-na-modernich-technologiich).