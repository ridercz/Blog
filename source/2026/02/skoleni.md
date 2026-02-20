<!-- dcterms:title = Pozvánka na komplexní školení ASP.NET Core 10 -->
<!-- dcterms:abstract = Aktuální verze .NET 10 je už nějakou dobu venku a nadešel čas se mu pořádně podívat na kloub. Proto jsem připravil zcela novou verzi školení, která vás naučí mu doopravdy porozumět. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20250427-data.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20250427-data.jpg -->
<!-- x4w:category = Akce a události -->
<!-- x4w:category = IT -->
<!-- dcterms:date = 2026-02-20 -->

Aktuální verze .NET 10 je už nějakou dobu venku a nadešel čas se mu pořádně podívat na kloub. Proto jsem připravil školení, která vás naučí mu doopravdy porozumět.

* **Úvod do ASP.NET 10** vám ukáže základy fungování .NETu jako takového a ASP.NET Core. Důkladně. Ukážeme si také, jak ASP.NET Core aplikace provozovat v různých scénářích.
* **ASP.NET 10 prakticky** je přímým pokračováním, které staví na těchto základech a podrobně vysvětluje řešení praktických problémů v Razor Pages a MVC, včetně zabezpečení a autentizace.

Ve své podstatě jde o jedno školení, které bylo pro velký objem rozděleno na dvě a vřele doporučuji se účastnit obou částí školení.

## Kdy a kde se budou školení konat

Školení se budou konat **online** pomocí systému [Altairis eLearning](https://elearning.altairis.cz), s přenosem videa lektora k účastníkům a chatem pro dotazy (s možností individuální pomoci a konzultací). Účastníkům bude k dispozici záznam a výukové materiály i po skončení školení.

* Termín první části školení je **09. - 13. března 2026**.
* Termín druhé částí školení je **23. - 27. března 2026**.

Čas je vždy od **12:00 do 17:00**. Tento termín umožňuje, aby účastník nebyl blokován celý pracovní den. 

Pokud byste se školení rádi zúčastnili, ale nevyhovuje vám termín, vyplňte [objednací formulář](https://forms.office.com/r/PfbJeNEi7U) a napište to do poznámky - pokusím se vám vyjít vstříc. Stejně tak, pokud byste měli zájem o prezenční školení nebo privátní jenom pro vaši firmu.

## Kolik školení stojí

* Cena jedné části školení je 18 000 Kč.
* Cena obou částí školení je 35 000 Kč.

V případě tří a více účastníků z jedné firmy (na jedné objednávce) je další sleva 10 %. Cena je uvedena bez DPH.

* **[Objednávkový formulář](https://forms.office.com/r/PfbJeNEi7U)**

## Obsah první části školení

Platformu .NET používám po celé čtvrtstoletí její existence a prakticky stejnou dobu to učím ostatní. Toto školení je nejnovější verzí osvědčeného schématu, které pomohlo již mnoha lidem, která byla výrazně rozšířena a aktualizována. 

První část školení se zabývá tím, jak .NET a ASP.NET vlastně fungují a jak aplikace v nich provozovat. Začátečníkům pomůže se zorientovat v problematice. Zkušenějším programátorům pak uspořádat znalosti a dovednosti, protože se na ně podíváme systematicky, nejenom optikou toho, co momentálně hoří.

Část věnuji i softwarové architektuře a SOLID principům, dependncy injection atd. protože na nich je moderní .NET založen a ze zkušenosti vím, že mnoho programátorů má s pochopením tohoto aspektu problémy.

### Základní osnova

* .NET včera, dnes a zítra
  * Stručný přehled historie platformy
  * Které technologie přežily a které ne
  * Základní náhled na upgrade aplikací v .NET Frameworku
  * Verzování, STS a LTS releases
  * .NET Standard
* NuGet
  * Balíčkovací systém pro .NET
  * Jak vytvářet a publikovat vlastní balíčky
  * .NET Tools, globální a lokální
* .NET pro web
  * Dostupné vývojové frameworky
  * Co s legacy aplikacemi
* Spouštění a běh ASP.NET Core aplikací
  * Hosting aplikací, minimal hosting model
  * Middleware
  * Endpoint routing
  * Route parametry, route constraints
* Deployment ASP.NET Core aplikací
  * Základní režimy fungování (SDK, FDD, SCD)
  * Hosting na Windows a IIS
  * Hosting v Microsoft Azure
  * Hosting na Linuxu
  * Psaní multiplatformních aplikací
* .NET nejen pro web
  * Konzolové aplikace
  * Parkování příkazové řádky
  * Background workers a proč je chcete používat
  * Windows Services, Linux Daemons
* Ideové principy programování
  * SOLID principy
  * IoC/DI
  * Použití vestavěného kontejneru
  * Náhrada vestavěného kontejneru jiným
* ASP.NET MVC a Razor View Engine
  * Model-View-Controller pattern v .NETu
  * Razor View Engine
  * Razor direktivy
  * Layout pages a další speciální druhy views
* Práce se statickými soubory
  * Obrázky, JavaScript a další
  * Static Files a Static Assets, cacheování
  * Práce s klientskými knihovnami různými způsoby
  * SASS/SCSS, bundling, minifikace
  * Správné a bezpečné použití CDN
* Tag Helpers
  * Co jsou tag helpers a jak jsou užitečné
  * Kompletní přehled vestavěných tag helperů
  * Tvorba vlastních tag helperů, od jednoduchých ke složitým
* Cookies a jejich alternativy
  * HTTP jako bezstavový protokol
  * Cookies nánosu mýtů zbavené
  * Alternativy k cookies
* Logování
  * Použití logování z vlastní aplikace
  * Logging providers
  * Message templates, Event IDs, strukturované logování
* Health checks
  * Monitoring aplikace
  * Vnitřní kontrola funkčnosti a závislostí
  * Kontrola background workerů
  * Health Checks UI

## Obsah druhé části školení

Druhá část staví na základech první části; používá Razor Pages (ale popisované postupy jsou použitelné i v MVC a Blazoru). Jedná se principiálně o tvorbu jednoduché aplikace, při níž se řeší problémy obvyklé u typických webových aplikací. Ukazuje, jak to dělat správně a dodržovat best practices. Podstatná část - s důrazem na best practices - je věnována bezpečnosti aplikací a autentizaci pomocí ASP.NET Identity a dalších technik.

### Základní osnova

* Razor Pages
  * Představení frameworku
  * Model-View-ViewModel (MVVM)
  * Porovnání s MVC
  * Handler metody pro zpracování requestů
* Konfigurace
  * Zdroje konfigurace
  * Konfigurační soubory, proměnné prostředí a další
  * Výchozí nastavení
  * Objektová práce s konfiguračními hodnotami
  * User secrets
  * Keeping secrets in production
* Maily v ASP.NET Core
  * Různé možnosti odesílání e-mailů
  * Ukázka architekonického řešení
  * Přijímání mailů a proč to nedělat
* View Components
  * Základní představení VC
  * Věci shodné a rozdílné od tag helperů a partial views
  * Volání view components pomocí tag helperů
* Validace uživatelského vstupu
  * Validace modelů
  * Vestavěné validační atributy
  * Logické datové typy
  * Psaní jednoduchých a složitých validačních atributů
  * Rozhraní `IValidatableObject`
  * Validace na straně klienta
* Dynamické generování uživatelského rozhraní
  * Generování na úrovni pole
  * Generování na úrovni modelu nebo jeho části
  * Vlastní šablony pro generování
* Internacionalizace webových aplikací
  * Lokalizace a globalizace
  * Třída CultureInfo a její použití
  * Uchovávání informace o jazyku na webu
  * Resources v .NETu
  * Lokalizace validačních atributů
  * Lokalizace views
  * Conventional Metadata Providers
  * RESX Manager
  * Rozsáhlejší internacionalizace v praxi
* Upload a download souborů
  * Generování downloadu souborů
  * Hlavičky `Content-Type` a `Content-Disposition`
  * Práce s CSV soubory
  * Kódování češtiny
  * Upload souborů pomocí formuláře
  * Upload velkých souborů
  * Jak a kam ukládat binární data
  * Knihovna FLuentStorage
* Zabezpečení
  * Ideologie identity
  * Autentizační faktory
  * Claims-based authentication
  * Identity federation
  * Cookie authentication middleware
* ASP.NET Core Identity
  * Porovnání s předchozími technologiemi
  * Přihlašování, odhlašování
  * Reset hesla: jak to dělat správně
  * Práce s rolemi
  * Registrace uživatelů, ověření a změna e-mailu
  * Dvoufaktorová autentizace, recovery keys
  * Customizace ASP.NET Identity
  * Úschova hesel a proč do toho raději nezasahovat
  * Migrace z jiných technologií - pohodlně pro uživatele a bezpečně pro systém
  * Sign-in Manager
  * Security Stamp a odhlášení ze všech zařízení
  * Passwordless autentizace
  * Použití externích identity providerů
  * Rozumná politika hesel
* ASP.NET Data Protection
  * K čemu slouží v .NETu
  * Vlastní využití
  * Konfigurace a úschova klíčů

## Požadavky na účastníky

Po technické stránce se předpokládá, že účastníci budou mít k dispozici:

* Počítač s připojením k Internetu umožňujícím přehrávání video streamu
* Podporovaná verze Windows, Visual Studio 2026 libovolné edice (včetně bezplatné Community Edition), Microsoft SQL Server (včetně bezplatné edice Express). _Lze používat i jinou platformu (Linux, Mac OS) a vývojové prostředí (VS Code, JetBrains Rider...), ale návody počítají s Windows a VS 2026._
* Libovolné předplatné Microsoft Azure (včetně aktivního trialu). Není absolutně nezbytné, ale část školení ho využívá.

Po stránce dovedností a vědomostí se očekává, že účastníci budou mít základní obecné povědnomí o programování v C#/.NET, HTML, CSS a JavaScriptu.

## Objednávky a dotazy

Školení si můžete [objednat pomocí formuláře](https://forms.office.com/r/PfbJeNEi7U). V případě dotazů napište poznámku do formuláře nebo [mne kontaktujte jakkoliv jinak](https://www.rider.cz/#contact).