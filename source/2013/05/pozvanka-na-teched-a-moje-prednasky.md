<!-- dcterms:identifier = aspnetcz#3409 -->
<!-- dcterms:title = Pozvánka na TechEd a moje přednášky -->
<!-- dcterms:abstract = Zvu vás na letošní pražský TechEd. Jako obvykle na něm mám hromadu přednášek, na které vás zvu obzvláště. -->
<!-- np9:categoryId = 6 -->
<!-- x4w:category = Akce a události -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2013-05-01T00:44:37.337+02:00 -->
<!-- dcterms:dateAccepted = 2013-05-01T00:47:23+02:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20130501-pozvanka-na-teched-a-moje-prednasky.png -->

Zvu vás na letošní pražský TechEd, který se bude konat od 21. do 24. května 2013 na novém místě, v multikině Premeiere Cinemas v Hostivaři. Jako obvykle na něm mám hromadu přednášek, na které vás zvu obzvláště.

## Keynote + novinky

**Úterý, 10:00-11:50**

Opět po roce přehled toho, co si na nás Microsoft připravil v oblasti (nejenom) webového vývoje. Seznámíme se s novinkami ve druhém čtvrtletním update Visual Studia 2012, s rozšířením Web Essentials a novinkami nejnověji dostupnými v ASP.NET 4.5.

## SignalR: Realtime web v ASP.NET

**Úterý, 14:20-15:35 **

Ze serverového kódu nelze volat klientský. Klient se vždy musí připojit na server a nikdy naopak. Data nelze na klienta "tlačit", musí si je vždy výslovně vyžádat. Nelze zjstit, že klient zavřel okno prohlížeče, ani skutečný počet současných uživatelů webu. Základní paradigmata webového vývoje přestávají díky novým vymoženostem v HTML a HTTP (jako například Web Sockets) platit. Open source knihovna SignalR, která je nyní součástí ASP.NET umožňuje propojit webový server a klienta v reálném čase a aktualizovat údaje ihned, když se server o změně dozví, bez čekání na nějaký timeout.

## Novinky v ASP.NET autentizaci

**Středa, 10:30-11:45**

ASP.NET Membership je s námi již od roku 2005 a ač pro jednoduché scénáře stále stačí, ve složitějších případech je lepší sáhnout po jiné technologii. ASP.NET nabízí „claims-based authentication“, mechanismy, jak používat identity federation a mít možnost přihlašovat se k webové aplikaci třeba pomocí Twitteru, Facebooku nebo firemního STS. Podíváme se na bezplatnou službu Windows Azure Access Control Service a ukážeme si, jak ji využít, a proč se o ni zajímat, i když cloudové služby vůbec nepoužíváte.

## Bundling a minifikace v ASP.NET

**Středa, 14:15-15:30**

Dnešní webové aplikace si nevystačí s prostým HTML a potřebují ke štěstí značné množství doplňkových souborů s kaskádovými styly a JavaScriptem. ASP.NET umí tyto soubory jednoduše sloučit do jednoho a zkomprimovat, čímž se zmenší počet HTTP requestů a objem stahovaných dat. Zároveň elegantně řeší i cache busting při změně zdrojových souborů. Podíváme se také na nové způsoby registrace skriptů, potřebné pro plnohodnotnou práci s ASP.NET 4.5.

## HTTPS a SSL v IIS 8.0

**Středa, 15:45-17:00**

IIS 8.0, součást Windows Serveru 2012, nabízí řadu novinek pro práci se zabezpečeným HTTP: HTTPS/SSL/TLS. Nový certificate store, vyšší výkon, podpora SNI a více šifrovaných webů na jedné IP adrese… V dnešní době již neexistuje mnoho důvodů, proč nepoužívat pro webové aplikace přístup přes SSL.

## Bootstrap, aneb začínáme s novým projektem v ASP.NET

**Čtvrtek, 10:30-11:45**

Začít s novou webovou aplikací v ASP.NET od nuly není zase tak snadné. Instalace a registrace obvyklých knihoven v aktuálních verzích, konfigurace bundlingu a minifikace, vytvoření základní struktury… Nudné operace, které se opakují s jedním každým novým projektem. Ukážeme si, jak nastartovat nový projekt v duchu aktuálních technologií a jak celý proces automatizovat pomocí NuGet balíčků

## Deployment webových aplikací

**Čtvrtek, 14:15-15:30**

Webovou aplikaci máme hotovou a je třeba ji nasadit na server. Netřeba ručně kopírovat pomocí FTP, když máme MS Deploy a Web Publishing. Umí nasadit, co je potřeba, provést transformaci konfiguračních souborů, nebo třeba i migraci databáze. Tento postup lze použít pro nasazení aplikace do Windows Azure, ale i na vlastní servery a s příchodem nejnovější aktualizace doznal mnohých vylepšení.

## Ladění HTTP

**Čtvrtek, 15:45-17:00**

Co se vlastně děje při komunikaci mezi webovým serverem a klientem, ať už jím je běžný webový prohlížeč, nebo cokoliv jiného? Pomocí nástrojů jako jsou IE Developer Tools nebo Fiddler můžete webovou komunikaci odposlouchávat, a nejenom to – lze ji různým způsobem modifikovat, testovat různé požadavky nebo za letu dešifrovat HTTPS traffic. 

## E-mail pro programátory webových aplikací

**Pátek, 10:30-11:45 **

Co je těžkého na tom, poslat z webové aplikace mail? Docela dost, pokud chcete rozesílat zpráv velké množství, lokalizovat je do několika jazyků, spravovat mailing listy nebo tak činit ve Windows Azure. A ještě horší to je, když chcete e-maily nejenom odesílat, ale i přijímat a zpracovávat příchozí zprávy. Ukážeme si osvědčené postupy, jak tyto problémy řešit.

## Azure Web Sites prakticky

**Pátek, 14:15-15:30**

Konečně pořádný web hosting! Azure Web Sites totiž v podstatě nic jiného nejsou, kvalitně a komfortně udělaný web hosting od Microsoftu. Má ovšem svá omezení a drobné problémy. Na příkladu několika aplikací si ukážeme, jak lze Azure Web Sites používat a jak řešit problémy, na které pravděpodobně při migraci narazíte.