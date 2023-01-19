<!-- dcterms:title = Pozvánka na odpolední školení ASP.NET Core -->
<!-- dcterms:abstract = Máte půl dne času? Zvu vás na komplexní online školení ASP.NET Core. Tedy, pokud budete mít půl dne času dva týdny. Koronavirus řadu lidí i firem přesvědčil, že školení nemusí probíhat jenom osobně, ale lze ho dělat i na dálku. A speciální formát školení zařídí, že účastníci nebudou vyřazeni z provozu na příliš dlouho. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:coverUrl = /cover-pictures/20200716-odpoledni-skoleni.jpg -->
<!-- x4w:coverCredits = Charles Deluvio via Unsplash.com -->
<!-- x4w:pictureUrl = /perex-pictures/logo-netcore.svg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = IT -->
<!-- x4w:category = Akce a události -->
<!-- dcterms:date = 2020-07-16 -->

Máte půl dne času? Zvu vás na komplexní online školení ASP.NET Core. Tedy, pokud budete mít půl dne času dva týdny. Koronavirus řadu lidí i firem přesvědčil, že školení nemusí probíhat jenom osobně, ale lze ho dělat i na dálku. A speciální formát školení zařídí, že účastníci nebudou vyřazeni z provozu na příliš dlouho. Školení je určeno programátory, kteří mají obecnou znalost webových technologií (HTML, CSS, JavaScript...) a alespoň základů .NET (C#, Razor, Web Forms, MVC 5...). Cílem je upgradovat jejich znalosti a dovednosti na aktuální úroveň.

## Kdy, kde a jak se bude školení konat?

Školení se bude konat online pomocí video streamu v systému [Altairis eLearning](https://elearning.altairis.cz/). Účastníci budou moci klást otázky prostřednictvím online chatu. Výukové materiály (cvičení, příklady, prezentace) a záznam video streamu vám budou přístupné i po skončení školení.

Školení se bude konat vždy odpoledne, od 12 do 16-17 hodin, a to v následujících termínech:

* První část: 7. - 11. 9. 2020
* Druhá část: 21. - 25. 9. 2020

Pokud vám termín školení nevyhovuje ale přesto o něj máte zájem, nebo máte jakékoliv jiné dotazy, [kontaktujte mne](https://www.rider.cz/#contact).

## Kolik školení stojí a jak se na něj mohu přihlásit?

Cena první či druhé části školení samostatně je **15 000 Kč** za osobu. Cena obou částí školení dohromady je **28 000 Kč**. V případě tří a více účastníků z jedné firmy (na jednu fakturu) je cena jedné části školení **14 000 Kč** za osobu a cena celého školení pak **26 000 Kč**. Všechny ceny jsou uvedeny bez DPH.

Přihlásit se můžete pomocí [objednávkového formuláře](https://forms.office.com/Pages/ResponsePage.aspx?id=DQSIkWdsW0yxEjajBLZtrQAAAAAAAAAAAANAAaGd_xhUMTBOSzZMWFUwRTVZWUtVS1I1WVYxWUhRRi4u). Na jeho základě vám bude vystavena zálohová faktura. Pokud se vás hlásí víc z jedné firmy, uveďte jména a e-mailové adresy dalších účastníků do poznámky.

## Jaké jsou technické požadavky na školení?

Každý účastník bude potřebovat počítač s následujícím softwarem:

* Aktuální verze Windows 10 (starší dosud podporované verze Windows lze také použít, ale nedoporučuji to).
* Visual Studio 2019 (jakákoliv edice včetně bezplatné Community Edition).
* Microsoft SQL Server (jakákoliv podporovaná verze a edice včetně bezplatné Express).

Dále pak budete potřebovat webový prohlížeč a připojení k Internetu dostatečné na to, aby dokázalo plynule přehrávat video z YouTube. Pro některá cvičení budete potřebovat funkční subscription do Microsoft Azure (stačí trial) a funkční účet u poskytovatele Digital Ocean (pokud si ho zřídíte přes odkaz [altair.is/digitalocean](https://altair.is/digitalocean), dostanete zdarma kredit 50 USD na 30 dní).

## Co je obsahem školení

### První část

Vysvětlím vám obecné základy platformy .NET Core, ukážeme si, jak webové aplikace hostovat on premises, v cloudu Microsoft Azure, na Windows i na Linuxu. Řeč bude i o psaní konzolových aplikací a Windows Services a daemonů na Linuxu.

Poté nahlédneme do základů softwarové architektury a do SOLID principů, na nichž je postavena platforma ASP.NET Core. Důležitou součástí ASP.NET Core je IoC/DI kontejner, představíme si funkci toho vestavěného i jeho náhradu nějakým jiným.

V další části se budeme věnovat ASP.NET MVC a vylepšeními v templatovacím engine Razor. Ukážeme si, jak vytvořit základ webové aplikace a práci s JavaScriptem, CSS preprocesory a CDN.

Poslední část pak je věnována tag helperům, nové formě rozšiřitelnosti Razor engine, tj. MVC a Razor Pages. Představíme si existující tag helpery i postup, jakým lze vytvářet nové.

V závěru bude řeč o cookies a dalších formách překlenutí bezstavovosti HTTP.

* Úvod
  * Důvody vzniku
  * Ideové novinky, změny proti .NET Frameworku
  * Doporučení pro stávající aplikace
  * Dostupné varianty runtime, LTS versus current verze
  * .NET Standard – co to je a jak ho používat
  * NuGet balíčky, jejich role v .NET Core, jak je vytvářet a publikovat
  * Základy ASP.NET, koncept middleware, tvorba vlastního middleware
  * Webový server Kestrel, práce se statickými soubory
* Provoz a hosting ASP.NET Core aplikací
  * SCD, FDD, SDK deployment
  * Instalace a konfigurace serveru s Windows a IIS, základní diagnostika
  * Hosting aplikace v Azure App Service s využitím Azure SQL Database, deployment sloty
  * Proč a jak psát multiplatformní aplikace
  * Instalace a konfigurace web serveru na Linuxu, nasazení a provoz ASP.NET Core aplikace
* .NET Core nejen pro web: Konzolové aplikace
  * Proč je psát
  * Parsování příkazového řádku – NConsoler
  * CommandLineUtils – framework pro psaní rozsáhlejších konzolových aplikací
* Windows Services a démoni
  * Proč používat background processing ve webových aplikacích
  * Hostování standardní webové aplikace ve vlastní Windows Service mimo IIS
  * Background worker hostovaný ve Windows Service nebo démonovi
  * Background worker hostovaný ve webovém procesu
* Jemný úvod do softwarové architektury
  * Proč potřebujeme softwarovou architekturu
  * SOLID principy (SRP, OCP, LSP, ISP, DIP)
  * IoC/DI jako implementace těchto principů
* IoC/DI v ASP.NET Core
  * Vestavěný kontejner
  * Náhrada vestavěného kontejneru Autofacem
  * Pokročilejší možnosti Autofacu
* ASP.NET MVC Core a nový Razor
  * Změny proti MVC 5
  * Novinky v Razoru (@inject, _ViewImports.cshtml, inicializace)
* Základní kostra aplikace v ASP.NET MVC Core
  * Práce s JavaScriptem a CSS, použití Client Library Manageru (LibMan)
  * CSS a JavaScript preprocesory (SASS, LESS)
  * Bundling a minifikace
  * Využití CDN, fallback, SRI, CORS
  * Koncept prostředí (Hosting Environment) a jejich využití
* Tag helpers v Razoru
  * Registrace tag helperů
  * Tag helpery pro vytváření odkazů
  * Tag helpery pro cacheování
  * Tag helpery pro formuláře
  * Tvorba vlastních tag helperů
* Cookies v ASP.NET
  * Práce s cookies v ASP.NET Core
  * Bezpečnostní aspekty a omezení
  * Cookie Consent a GDPR
  * Alternativy k cookies – Local Storage a Session Storage

### Druhá část

Pokračovat budeme jemným úvodem to Entity Frameworku Core a pak se vrhneme na Razor Pages, MVVM framework, který Microsoft nabízí jako alternativu k přece jenom poněkud fundamentalisticky pojatému MVC.

Aplikace vyžadují konfiguraci a .NET Core opouští předchozí řešení založené na XML web.config souborech. Nabízí nový model mnoha konfiguračních zdrojů, objektovou nadstavbu i User Secrets pro bezpečnou úschovu citlivých konfiguračních údajů při vývoji.

Téměř každá webová aplikace potřebuje odesílat e-maily. Ukážeme si, jaké možnosti v ASP.NET Core aplikacích máte a představíme si knihovnu Altairis.Services.Mailing. Tu můžete použít pro řešení svých e-mailovacích potřeb, ale také jako ukázku toho, jak se obecně píší univerzální knihovny pro .NET Core.

Další velký blok je věnován internacionalizaci – přípravě aplikace na globální nasazení, překladu do různých jazyků, validaci uživatelských vstupů včetně klientské validace (a překladu jejích hlášek). Uživatelské rozhraní je možné – a vhodné – generovat na základě anotačních atributů dynamicky a ukážeme si, jak na to.

Poslední část se týká zabezpečení a použití ASP.NET Identity. Naučím vás, jak ji správně nasadit, zabezpečit aplikaci pomocí rolí, dvoufaktorové autentizace, vlastních claimů, přihlašování pomocí externích identity providerů a další užitečné věci. Ukážu vám také, jak můžete do své nové krásné bezpečné aplikace dostat uživatele ze starších aplikací, které nejsou tak krásné (a hlavně tak bezpečné).

* Jemný úvod do Entity Frameworku Core
  * Změny proti EF 6
  * Migrace a jejich zákeřnosti
  * Vytvoření DAL v EF Core
* ASP.NET Core Razor Pages
  * Razor Pages jako alternativa k MVC Core
  * Model-View-ViewModel (MVVM) versus Model-View-Controller (MVC) pattern
  * Základní použití Razor Pages
  * Metody pro zpracování requestů
* Konfigurace
  * Změny proti ASP.NET 4 a zkáza souboru web.config
  * Zdroje konfigurace: soubory, proměnné prostředí, příkazová řádka a další
  * Objektová nadstavba nad key-value konfigurací
  * Validace konfiguračních hodnot
  * Sledování změn v konfiguračních souborech
  * User Secrets – úschova citlivých konfiguračních údajů při vývoji
* E-mail v ASP.NET Core
  * Možnosti posílání e-mailů (vlastní server, externí služba)
  * Knihovna Altairis.Services.Mailing jako připravené řešení a zároveň ukázka typické praxe v .NET Core.
* View Components
  * View Components jako náhrada child akcí
  * Rozdíly proti Server Controls v ASP.NET Web Forms
  * Registrace a tvorba vlastních view components
* Validace vstupu a model binding
  * Standardní validační atributy
  * Vlastní validační atributy pro vlastnosti i celé entity
  * Rozhraní IValidatableObject
  * Klientská validace pomocí JavaScriptu a CSS
* Dynamické generování uživatelského rozhraní
  * Proč UI vytvářet dynamicky na základě metadat
  * Generování UI na úrovni pole
  * Generování UI na úrovni modelu nebo jeho části
  * Tvorba vlastních šablon
* Internacionalizace
  * Globalizace a lokalizace
  * Třída CultureInfo, neutrální a specifické kultury, Invariant Culture a proč se jí vyhnout
  * Nastavení kultury, request localization middleware
  * Lokalizace uživatelského rozhraní pomocí resources
  * Lokalizace data annotations atributů
  * Conventional Metadata Providers
* Zabezpečení webových aplikací
  * Základní koncepty a pojmy
  * Autentizační faktory
  * Cookie Authentication Middleware
  * Claims-based Identity
* ASP.NET Identity
  * Základní použití, vytváření uživatelů, přihlášení, odhlášení
  * Reset hesla jako slabé místo bezpečnosti aplikací a jak to dělat správně
  * Práce s rolemi a role-based autorizace
  * Dvoufaktorová autentizace, použití jednorázových hesel
* Customizace ASP.NET Identity
  * Rozšíření údajů o uživateli
  * Identity Stores
  * Úschova hesel a proč se do toho nevrtat
  * Migrace legacy uživatelů, aneb když se do toho vrtat bohužel musíte
  * Třída SignInManager, logování a omezení přihlášení
  * SecurityStamp a jeho využití, odhlášení ze všech sessions
  * Přihlašování pomocí externích identity providerů a jiných facebooků
  * Ověření telefonního čísla pomocí SMS
  * Login Approvals: přihlašování bez hesel
  * Použití vlastních claimů v ASP.NET Identity
* ASP.NET Data Protection
  * Použití v rámci .NET Core a vlastní využití
  * Výchozí konfigurace a její změny
  * Ukládání klíčů do souborového systému
  * Ukládání klíčů do databáze