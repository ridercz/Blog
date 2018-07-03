<!-- dcterms:identifier = aspnetcz#216 -->
<!-- dcterms:title = Řešení problémů s identitou webu u Personal Information Cards -->
<!-- dcterms:abstract = Téměř přesně před rokem jsem si v článku Jak se zjišťuje identita webu u Personal Information Cards? stěžoval na to, že algoritmus pro výpočet identity relying party (tedy typicky webu) je špatný. Specifikace ISIP verze 1.5 tento problém řeší. Problém u Windows CardSpace řeší .NET Framework 3.5 SP1. -->
<!-- np9:categoryId = 2 -->
<!-- x4w:category = Bezpečnost -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2008-11-19T01:55:29.763+01:00 -->
<!-- dcterms:dateAccepted = 2008-11-19T01:55:29.763+01:00 -->

Téměř přesně před rokem jsem si v článku [Jak se zjišťuje identita webu u Personal Information Cards?](http://www.aspnet.cz/Articles/171-jak-se-zjistuje-identita-webu-u-personal-information-cards.aspx) stěžoval na to, že algoritmus pro výpočet identity relying party (tedy typicky webu) je špatný. Specifikace [ISIP verze 1.5](http://www.microsoft.com/downloads/details.aspx?FamilyID=b94817fc-3991-4dd0-8e85-b73e626f6764&DisplayLang=en) tento problém řeší. Problém u Windows CardSpace řeší .NET Framework 3.5 SP1.

## V čem byl problém?

Osobní (unmanaged) information cards používají jako základní identifikační prvek PPID – private personal identifier. Ten je unikátní vždy pro kombinaci konkrétní karty (uživatele) a relying party (webu). To je dobré z důvodu bezpečnosti a ochrany soukromí uživatele. Řeší to problém phishingu, protože i když phisher zmate uživatele a ten mu pošle kartu, získá útočník identifikátor platný jenom pro svůj web. A z hlediska ochrany soukromí si může být uživatel jist, že provozovatelé dvou webů nemohou jeho údaje za jeho zády propojit, protože PPID je pro každou stranu jiné.

Klíčovým problémem je, jak se zjistí identita RP (relying party). Typicky se používají údaje ze SSL certifikátu. Způsob výpočtu popisuje dokument jménem Identity Selector Interoperability Profile. Tento ve své verzi 1.0 předepisoval postup, který defacto znamenal, že s každou změnou certifikátu se změnilo PPID. Podrobný rozbor problému najdete v [mém předchozím článku](http://www.aspnet.cz/Articles/171-jak-se-zjistuje-identita-webu-u-personal-information-cards.aspx).

## Jak byl vyřešen?

Byl změněn algoritmus výpočtu PPID. Nově platí, že:

*   Algoritmus výpočtu pro **HTTPS s EV certifikátem** zůstal nezměněn. Identita se tedy vypočítá z DN komponent O, L, S a C, například tedy z řetězce `|O="Altairis, s.r.o."|L="Praha"|S=""|C="CZ"|`. 
*   V případě **HTTPS s certifikátem, kde jsou uvedenu údaje o žadateli, ale není EV**, se algoritmus změnil. Nově se neuvažuje certifikační autorita. Řetězec je stejný jako pro EV, jenom se na začátek přidá string `|Non-EV`, tj. výsledek bude příkladně `|Non-EV|O="Altairis, s.r.o."|L="Praha"|S=""|C="CZ"|`. 
*   V případě **HTTPS s certifikátem, kde nejsou uvedeny údaje o žadateli, ale je uveden název serveru**, se algoritmus také změnil. Použije se pouze Common Name, nepřihlíží se ke klíči, např. tedy `|CN="www.altairis.cz"|`. 
*   V případě **HTTP bez certifikátu** se použije hostname serveru, převedený na malá písmena (např. tedy `www.altairis.cz`). 
*   Teprve v případě, že **certifikát neobsahuje žádné údaje o žadateli ani serveru** (takový jsem ještě neviděl) a nebo pokud **není propojen s důvěryhodnou certifikační autoritou**, použije se jeho veřejný klíč.  

To pro provozovatele webů znamená, že:

*   Všechny weby stejného provozovatele, bez ohledu na adresu, budou mít stejné PPID (v případě standardního certifikátu, kde je uvedena identita žadatele). Žadatelé mohou svobodně měnit poskytovatele certifikačních služeb. Identita bude ale jiná pro EV a Non-EV weby téhoš subjektu. 
*   V případě "desetidolarových" certifikátů, kde se ověřuje jenom název serveru, se při změně certifikátu nezmění PPID. To zůstane na věky stejné (dokud je stejný název serveru). 
*   Pokud používají libovolný ne-EV certifikát, mají jednorázový problém: jakmile si klient nainstaluje identity selector podporující ISIP 1.5 (což v případě CardSpace znamená, že si nainstalují SP1 na .NET Framework 3.5, který bude co nevidět na Windows Update), změní se jim PPID. Protože CardSpace z NetFx 3.0 podporuje ISIP 1.0 a ten z NetFx 3.5 SP1 podporuje ISIP 1.5.  

Stávající provozovatelé webů budou tedy muset znovu asociovat PPID se svými uživateli, principiálně stejným způsobem jako při registraci a nebo při ztrátě karty.

Obecně tento krok hodnotím velmi pozitivně, protože znamená výrazné usnadnění pozice RP pro malé weby, které nedosáhnou na EV certifikát. Spolu s uvedením "Geneva" Frameworku (který usnadní implementaci claims-based autentizačních mechanismů) se jedná o odstranění zásadní překážky akceptace karet na straně provozovatelů webů.

Ještě je nutné učinit druhý krok: zajistit, aby identity selector, tedy například Windows CardSpace, byl uživatelsky přítulnější. Tedy menší, rychlejší a především pohodlnější. Uživatelé jsou líní a nebudou nové autentizační mechanismy používat, pokud to pro ně nebude jednodušší, než uživatelská jména a hesla. Proto je dobře, že právě toto je cílem připravované nové verze, CardSpace "Geneva".