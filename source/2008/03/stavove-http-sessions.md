<!-- dcterms:identifier = aspnetcz#193 -->
<!-- dcterms:title = Stavové HTTP: Sessions -->
<!-- dcterms:abstract = Web byl stvořen jako bezstavový a struktura HTTP a HTML tomu odpovídá. Pokud chceme tuto bezstavovost překlenout, existuje několik technik, které nám umožní toto omezení obejít. Populární jsou například sessions. Podíváme se jak fungují a jak jsou implementovány v ASP.NET. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Programování -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- np9:serialId = 4 -->
<!-- x4w:serial = Stavové HTTP -->
<!-- dcterms:created = 2008-03-22T08:00:00+01:00 -->
<!-- dcterms:dateAccepted = 2008-03-22T08:00:00+01:00 -->

V [minulém díle](http://www.aspnet.cz/Articles/191-stavove-http-cookies.aspx) našeho seriálu jsme se podívali na technologii cookies a mimo jiné též na problémy, které přináší. Některé problémy cookies lze vyřešit poměrně snadno. Do cookie si uložíme pouze nějaký identifikační řetězec, jednoznačný identifikátor klienta, třeba nějaký GUID. A vlastní obsah si budeme držet na serveru, v paměti, v databázi, na disku nebo kdekoliv jinde.

To je v kostce popsán princip techniky sessions, která je v té či oné podobě implementována ve většině technologií pro vývoj webů. Vygenerujeme nějaký náhodný identifikátor - obvykle se mu říká Session ID - a ten pak jako jediný posíláme s každým požadavkem v cookie, nebo jako parametr v query stringu.

## Kam data ukládat

ASP.NET podporuje ukládání dat ze session kolekce třemi způsoby, lépe řečeno na třech místech. Volí se nastavením ve *web.configu*, v sekci */configuration/system.web/sessionState/@mode*. 

### InProc

Výchozí volba je *InProc* a při ní se obsah sessions ukládá do paměti ASP.NET worker procesu. Výhodou tohoto režimu je jeho jednoduchost, rychlost a minimální omezení na to, jaké objekty můžete do session kolekce ukládat. 

Nevýhodou je, že session nepřežije restart worker procesu. Nedá se také použít v případě, že máte webovou farmu (požadavky na tentýž web vyřizuje několik fyzických serverů) nebo webovou zahrádku (web garden, více worker procesů v rámci jednoho serveru).

### State Server

Nastavení *StateServer* způsobí, že se session data ukládají na speciální k tomu účelu určený state server. Tedy na server, na němž běží ASP.NET State Service. To může být web server sám, nebo to může být samostatný počítač. 

Toto řešení se používá zejména v případě webových farem, kdy více front-endů sdílí jeden state server. Jeho výhodou je, že obsah session přežije restart worker procesu a že méně zatěžuje web server samotný. 

Nevýhodou je, že v tomto nastavení lze do session kolekce ukládat jenom serializovatelné objekty a že se v případě webové farmy vytváří úzké hrdlo a "single point of failure". Pokud vypadne state server, má problémy celá farma, protože state server se nedá rozložit na více fyzických počítačů.

### SQL Server

Nastavení *SqlServer* umožní ukládat session data do SQL databáze. Toto řešení je nejrobustnější, protože data uložená v session přežijí v podstatě cokoliv, včetně třeba restartu databázového serveru (pokud změníte výchozí nastavení a budete je ukládat jinam, než do databáze *tempdb*). Také je možné použít SQL cluster za účelem zvýšení dostupnosti serveru. 

Nevýhodou je poměrně velká hardwarová náročnost celého řešení a relativní pomalost proti ukládání do paměti. I v tomto případě můžete navíc ukládat pouze serializovatelné objekty.

### Custom a Off

Existují ještě dvě další hodnoty: *Custom* říká, že se o ukládání dat postará nějaký jiný session state store provider a *Off* podporu sessions úplně vypne.

## Vlastnosti sessions

Použitím session jsme vyřešili jednu sadu problémů cookies: objem přenášených dat je poměrně nízký (přenáší se jenom Session ID), nepotřebujeme podporu cookies (pokud umístíme Session ID do URL) a data se drží na straně serveru a jsou tedy "v bezpečí". Na druhou stranu, na další problémy jsme si zadělali.

Sessions zatěžují server, data zabírají paměť, místo na disku a podobně. Pokud počet sessions zásadně naroste, může se jednat o úzké hrdlo vaší aplikace a limitem její škálovatelnosti. Nárůst počtu sessions nemusí nutně být způsoben nárůstem počtu uživatelů. Stačí například, když váš web bude indexovat nějaký robot, který nepodporuje cookies (ukládáte-li Session ID do cookies) a každý jeho požadavek vám založí novou session. Nesprávné použití session se může stát i nástrojem DoS útoku. Pokud lze vytvořit požadavek, který do session uloží velké množství dat, lze snadno napsat program, který bude generovat velké množství požadavků tohoto typu a tím server "vyswapuje" - zabere veškerou dostupnou paměť.

Druhá nevýhoda vyplývá z toho, že dost dobře nevíme, kdy platnost session ukončit. Vaše webová aplikace neví, nemá jak poznat, že uživatel ze stránek už definitivně odešel na jiné, zavřel okno prohlížeče a podobně. Vždy tedy musíte přijmout nějakou premisu typu "session vyprší X minut po posledním požadavku". Správné nastavení hodnoty X je dost obtížné. Pokud nastavíte session timeout na příliš dlouhou dobu, nebude vás váš server mít rád, protože bude muset opečovávat spoustu už zbytečných údajů. Pokud nastavíte timeout na moc krátkou dobu, nebudou vás mít rádi vaši uživatelé. Zejména poté, co začnou vyplňovat nějaký obludný formulář se stopadesáti políčky, mezitím vyřídí nějaký telefonický rozhovor a když celou tu opičárnu slavně odešlou, server jim zahlásí chybu, že jejich session vypršela a mají to zkusit znovu.

Třetí nevýhodou je, že na session se prostě nemůžete spolehnout, zejména v jednodušších scénářích, kde použijete *InProc* ukládání. K restartu worker procesu může dojít v podstatě kdykoliv a z mnoha různýců důvodů a aplikace mu nemůže nijak zabránit. Nelze se ani spolehnout na zavolání události *Session_End*, pokud k ukončení worker procesu dochází násilně, např. ze strany application poolu.

## Výhody a nevýhody

### Proč sessions použítat

*   Je to jednoduché - stačí použít kolekci *HttpContext.Session*.  Můžete ukládat větší množství údajů, bez zvýšení objemu přenášených dat. 

### Proč sessions nepoužívat

*   Špatná škálovatelnost - vytváříte úzké hrdlo v aplikaci.  Single point of failure u webových farem.  Session timeout je pouze odhadem - většinou špatným.  Bezpečnostní rizika - session stealing. 

### Doporučení

*   Sessions nepoužívejte a zejména vypněte.  Když už je používáte, důkladně zvažte, v jakém režimu mají fungovat.  Ukládejte pouze minimální množství dat, nepoužívejte session jako cache (na to je v ASP.NET zvláštní mechanismus).  Zejména u InProc sessions počítejte s tím, že se obsah může ztratit - při restartu worker procesu a nespoléhejte na něj. 

*Zítra se v dalším dílu tohoto seriálu podíváme na poslední technologii, a tou je ViewState.*