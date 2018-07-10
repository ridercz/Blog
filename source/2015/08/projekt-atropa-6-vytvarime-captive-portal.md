<!-- dcterms:identifier = aspnetcz#5437 -->
<!-- dcterms:title = Projekt Atropa (6): Vytváříme captive portal -->
<!-- dcterms:abstract = V šestém dílu seriálu o vytvoření "zlé maliny" pro útoky sociálním inženýrstvím si ukážeme, jak vytvořit webovou aplikaci, která se bude tvářit jako autentizační captive portál a pokusí se z uživatelů vylákat přihlašovací údaje k populárním službám. Použijeme přitom ASP.NET 5 a MVC 6. -->
<!-- np9:categoryId = 2 -->
<!-- x4w:category = Bezpečnost -->
<!-- x4w:serial = Projekt Atropa -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2015-08-23T03:44:49.987+02:00 -->
<!-- dcterms:dateAccepted = 2015-08-24T00:00:00+02:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20150713-projekt-atropa-1-jak-vyrobit-z-raspberry-pi-zle-zarizeni-s-netem.jpg -->

V šestém dílu seriálu o vytvoření ["zlé maliny" pro útoky sociálním inženýrstvím](http://www.aspnet.cz/articles/5429-projekt-atropa-1-jak-vyrobit-z-raspberry-pi-zle-zarizeni-s-netem) si ukážeme, jak vytvořit webovou aplikaci, která se bude tvářit jako autentizační captive portál a pokusí se z uživatelů vylákat přihlašovací údaje k populárním službám. Použijeme přitom ASP.NET 5 a MVC 6. Aplikace je poměrně triviální a nepochybně by téhož výsledku bylo možno dosáhnout i jednoduššími prostředky. Já jsem zvolil ASP.NET 5 a MVC 6, protože jsem chtěl novou platformu vyzkoušet a také zkusit na Linuxu rozběhnout z .NETu trochu víc, než obligátní "Hello World!".

## User experience

Co bude naše aplikace dělat? Pokud se uživatel připojí k otevřenému Wi-Fi hotspotu, každý HTTP požadavek ho přenese na naši aplikaci. Ta mu ukáže úhledný dialog a nabídne, že se může připojit k Internetu, pokud se přihlásí pomocí služeb jako je Facebook, Twitter, Google Account, Microsoft Account nebo místní Seznam.cz:

[![atropa-gate-step0](https://www.cdn.altairis.cz/Blog/2015/20150823-atropa-gate-step0_thumb.png "atropa-gate-step0")](https://www.cdn.altairis.cz/Blog/2015/20150823-atropa-gate-step0_2.png)

Seznam služeb je konfigurovatelný, pro změny stačí editovat soubor `config.json` a přidat správně pojmenovaný soubor s obrázkem. Poté, co uživatel klepnutím vybere službu, zobrazí se mu přihlašovací dialog a bude vyzván k zadání jména nebo hesla pro příslušnou službu:

[![atropa-gate-step1](https://www.cdn.altairis.cz/Blog/2015/20150823-atropa-gate-step1_thumb.png "atropa-gate-step1")](https://www.cdn.altairis.cz/Blog/2015/20150823-atropa-gate-step1_2.png)

Bez ohledu na to, jaké heslo zadá, bude mu po odeslání zobrazena následující chybová stránka:

[![atropa-gate-step2](https://www.cdn.altairis.cz/Blog/2015/20150823-atropa-gate-step2_thumb_1.png "atropa-gate-step2")](https://www.cdn.altairis.cz/Blog/2015/20150823-atropa-gate-step2_4.png)

Vše vypadá podle mého názoru velice elegantně a profesionálně. Upřímně řečeno, aplikace je minimálně po vizuální stránce a po stránce podpory pro mobilní zařízení napsána lépe, než většina skutečných přihlašovacích portálů.

Na rozdíl od nich však uživateli Internet nezpřístupní, jenom zaznamená zadané jméno a heslo do obyčejného textového souboru.

## Konfigurace aplikace

Aplikace je napsána v ASP.NET 5 a MVC 6, ve Visual Studiu 2015. Je velice jednoduchá, obsahuje jeden controller se čtyřmi akcemi, tři pohledy a celý jeden model. Zdrojové kódy [najdete na GitHubu](https://github.com/ridercz/WifiGate/). K dispozici jsou dva releasy. Verze [1.0.0-alpha](https://github.com/ridercz/WifiGate/releases/tag/v1.0.0-alpha) je naprosto minimální implementace, kde je všechno zapsáno natvrdo a aplikace nemá žádnou grafiku, která by stála za řeč. [Verze 1.0.0](https://github.com/ridercz/WifiGate/releases/tag/v1.0.0) už je kompletní aplikace s konfigurací a grafikou.

Klíčovou součástí aplikace je její konfigurace, neboť ta říká, co se vlastně bude dělat. Využívám zde nový konfigurační systém v ASP.NET 5, který je vymyšlený docela dobře, ale zato je mizerně popsaný. Jeho fungování věnuji samostatný článek, zde je jednom návod k použití. Aplikaci řídí soubor `config.json`, který ve výchozím nastavení vypadá takto:

    {
        "ForceHostName": "www.wifigate-login.local",
        "OutputFileName": "wwwroot/passwords.txt",
        "MaximumPasswordLength": 4,
        "IdentityProviders": [
            {
                "Id": "facebook",
                "Title": "Facebook"
            },
            {
                "Id": "google",
                "Title": "Google Account"
            },
            {
                "Id": "twitter",
                "Title": "Twitter"
            },
            {
                "Id": "microsoft",
                "Title": "Microsoft Account"
            },
            {
                "Id": "seznam",
                "Title": "Seznam.cz"
            }
        ]
    }

Význam konfiguračních hodnot je následující:

*   `ForceHostName` je název serveru, na který bude uživatel přesměrován poté, co se na aplikaci dostane. Účelem je zvýšit důvěryhodnost rozhraní, neboť takto autorizační portály obvykle postupují. Můžete sem zadat jakoukoliv adresu - existující, neexistující, dokonce i s vymyšlenou top-level doménou. Nebo - jako já - můžete použít standardizovanou doménu "`.local`" pro lokální sítě. Po [konfiguraci popsané v předchozím dílu](http://www.aspnet.cz/articles/5435-projekt-atropa-5-vytvarime-honeypot) bude stejně jakýkoliv DNS dotaz resolvován na adresu našeho honeypotu. Tento parametr je nepovinný, pokud bude hodnota prázdná nebo nebude přítomna vůbec, přesměrování se neprovede. Také se neprovede, pokud aplikace běží ve vývojovém prostředí. 
*   `OutputFileName` je název výsledného souboru, kam se budou ukládat ulovená hesla. Adresa je relativní k rootu aplikace. V uvedeném příkladu se budou data ukládat do souboru, který bude dostupný na adrese `http://adresa-honeypotu/passwords.txt`. 
*   `MaximumPasswordLength` je počet znaků z hesla, které se budou ukládat. Vzhledem k tomu, že celou aplikaci hodlám používat pro výukové účely a výsledek její činnosti uživatelům online ukazovat, nechci skladovat celá hesla. Ukládat se bude jenom prvních několik znaků (zde čtyři), zbytek hesla bude nahrazen hvězdičkami. 
*   `IdentityProviders` je seznam služeb, přes které chceme povolit přihlašování (jejichž přihlašovací údaje chceme získat). Pro každou z nich určujeme její `Id` a `Název` (`Title`). Parametr `Id` bude součástí URL a také se použije jako název obrázku s logem. Mělo by se tedy jednat o "bezpečný" string, který lze použít jako název souboru a cesty. `Title` je lidsky čitelný název služby. Identity providerů může být neomezené množství, já jsem zvolil čtyři nejpopupárnější služby plus lokálního favorita Seznam.cz. 

## Jak aplikace funguje?

O tvorbě aplikací v ASP.NET 5 napíšu podrobnější článek někdy jindy, zde jenom stručně:

*   `project.json` je extrémně důležitý, protože drží celou aplikaci pohromadě. Dí se říct, že je křížencem souborů `.csproj` a `packages.config` z předchozích verzí. Obsahuje seznam NuGet balíčků a také instrukce pro build. Můj soubor je víceméně ve výchozím stavu, přidal jsem jenom podporu pro Kestrel, který budeme potřebovat pro běh na Linuxu. 
*   `Startup.cs` je Owin Startup Class. Kód v něm se spouští jako první při startu aplikace a celou ji inicializuje. Je jakýmsi křížencem souborů `Global.asax` a `web.config` v předchozích verzích. V jeho konstruktoru načítám výše popsanou konfiguraci. V `ConfigureServices` registruji služby, které se budou později používat pro dependency injection. V Configure pak říkám, jaké OWIN middlewares (ekvivalent HTTP modulů a handlerů ze starších verzí) se budou používat atd. 
*   `hosting.ini` je soubor, který mi tam zbyl z výchozí šablony a upřímně, zatím jsem nevyzkoumal, k čemu je dobrý, musím se na to podívat později. 
*   `GlobalSuppressions.cs` na běh aplikace nemá vliv. Používám ve Visual Studiu 2015 plugin [Refactoring Essentials](http://vsrefactoringessentials.com/), který hlídá dodržování standardů psaní kódu a nabízí refactoring obvyklých porušení. Některá jeho pravidla se mi nelíbí a v tomto souboru se dají na úrovni projektu vypnout. 
*   `WifiGateOptions.cs` je model používaný pro konfiguraci. 

Ostatní soubory jsou standardní a neliší se podstatně od běžné ASP.NET MVC aplikace.

## Nasazení na honeypot

Raspberry připravené podle předchozích dílů seriálu připojíme do stejné drátové sítě jako řídící počítač a zapneme. Potřebujeme na něj aplikaci zkopírovat, což lze učinit mnoha způsoby. Já budu používat SCP, což je přenos souborů po SSH. Pokud jste si nainstalovali PuTTY, k čemuž jsem vás vyzýval ve [druhém dílu](http://www.aspnet.cz/articles/5430-projekt-atropa-2-zprovozneni-raspberry-pi-a-raspbian-linuxu), máte k dispozici řádkovou utilitu `pscp.exe`.

Smažte na Raspberry Pi obsah složky s obsahem web serveru, tedy `/home/pi/www/wifigate`, ovšem nikoliv složku samotnou. Můžete tak učinit třeba příkazem `rm -rf /home/pi/www/wifigate/*`.

Poté pomocí `pscp.exe` nakopírujte zdrojové kódy aplikace WifiGate.  Použijete k tomu následující příkaz, spuštěný ovšem na Windows:

    pscp -r -batch -C -pw raspberry "C:\Users\Altair\Source\Repos\WifiGate\src\WifiGate\*" pi@10.7.0.103:/home/pi/www/wifigate

Význam parametrů je následující:

*   `-r` postupuje rekurzivně, kopíruje i podadresáře. 
*   `-batch` se neptá na přepis souborů. 
*   `-C` použije při přenosu kompresi. 
*   `-pw raspberry` umožňuje specifikovat heslo (v tomto případě `raspberry`). 
*   `"C:\Users\...\*"` popisuje, které soubory se mají přenášet. Zde všechno ve složce WifiGate; uvozovky jsou nutné, pokud cesta obsahuje mezery. 
*   Posledním parametrem určujete, kam se mají data nakopírovat. Formát je `uživatel@host:cesta`. Zde se připojuji jako uživatel `pi` k počítači s adresou `10.7.0.103` a ukládám do adresáře `/home/pi/www/wifigate`. 

Po nakopírování souborů se opět připojte na Raspberry a spusťte obnovu NuGet balíčků příkazem `dnu restore /home/pi/www/wifigate`.

Nyní raspberry restartujte a počkejte, dokud nenaběhne. Pokud jste vše udělali správně, po restartu začne honeypot vysílat otevřenou síť jménem Internet. Když se k ní připojíte, jakýkoliv HTTP request bude přesměrován na adresu falešného portálu a vyzváni k zadání hesla. Ulovená hesla najdete na adrese brány v souboru `passwords.txt`.

V dokončení seriálu si ukážeme, jak se útokům tohoto typu bránit z pozice uživatele a z pozice autora serveru.