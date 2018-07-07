<!-- dcterms:identifier = aspnetcz#371 -->
<!-- dcterms:title = Windows 8, Visual Studio 11 – první dojmy -->
<!-- dcterms:abstract = Nemohl jsem se dočkat a hned v první den jejich dostupnosti jsem nainstaloval Windows 8 Consumer Preview a Visual Studio 11 Beta. Pro jedince méně šílené sepisuji své zkušenosti s touto sestavou. -->
<!-- np9:categoryId = 7 -->
<!-- x4w:category = Software -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2012-03-02T04:25:21.623+01:00 -->
<!-- dcterms:dateAccepted = 2012-03-03T10:52:46.623+01:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20120303-windows-8-visual-studio-11-prvni-dojmy.png -->

Nemohl jsem se dočkat a hned v první den jejich dostupnosti jsem nainstaloval **Windows 8 Consumer Preview** a **Visual Studio 11 Beta**. Pro jedince méně šílené sepisuji své zkušenosti s touto sestavou. Předesílám, že se nejedná o žádný rozsáhlý test, neměl jsem zatím čas to nějak zásadněji testovat, jde spíš o to, zda na Windows 8 fungují dosavadní programy.

Vše jsem instaloval na svůj hlavní pracovní počítač, který je dnes už v některých aspektech zastaralý. Je to notebook Lenovo ThinkPad R61, ovšem se SSD diskem a 8 GB paměti.

## Windows 8: Bomba!

Instalace proběhla naprosto bez problémů a velmi rychle. Hned na začátku jsem zvolil přihlášení pomocí Windows Live účtu, což byla chyba, protože systémový název účtu mi to vygenerovalo "MichalAltair" místo "Altair", což mi přineslo různé problémy. Dodatečně jsem účet přejmenoval a změnil i umístění profilu, ale pokud trváte na tom, že váš účet má mít konkrétní jméno, použijte nejdřív lokální účet a pak ho dodatečně spárujte s Windows Live ID.

Mile mne překvapilo, že si Windows automaticky nainstalovaly úplně všechny ovladače. Včetně těch obskurnějších, jako že mi fungují všechny hotkeys, Bluetooth a podobně. Proces instalace je plně automatický a bohužel mírně matoucí, protože jeho průběh není nijak indikován, ovladače se instalují za pochodu. Takže například přesně ve chvíli, kdy jsem řešil, proč můj počítač nevidí dva monitory, problikl obraz a nainstalovaly se mi ovladače na grafiku.

Ovladače grafické karty byly také jediné, se kterými jsem měl problém. Automaticky nainstalované poměrně často padaly, tak jsem z webu NVidia stáhl nové (kupodivu i pro mou starší grafiku Quattro NVM 140 jsou ovladače pro Windows 8). Od té doby nespadly ani jednou.

Externí DVD-RW, 3G Modem od Vodafone i čtečka čipových karet fungují. Zatím se mi nepodařilo rozchodit po síti barevnou laserovku EPSON AL-C1100, ale s ní jsem měl problémy už na 64-bitových sedmičkách a vyžadovalo to různou černou magii.

Windows si zákeřně standardně nastavení vyšší DPI a 125% zvětšení. Všechno je tedy o čtvrtinu větší, než jak jste byli zvyklí z předchozích verzí. To obecně pokládám za docela dobrý nápad zejména na noteboocích s menšími displeji s vysokým rozlišením, ale může to být nezvyk. Já mám poměrně velký monitor s poměrně malým rozlišením, takže jsem si vrátil velikost na 100%.

Po vizuální stránce se mi Windows 8 líbí. Jsem funkcionalistický fundamentalista a zastávám Loosovo heslo "ornament je zločin". Střízlivý hranatý design se mi velmi líbí. Pokud se týče Metro rozhraní, tak se na něj těším na tabletu, na běžném nedotykovém notebooku ho nejspíš používat nebudu, nějak zatím nevidím důvod proč. Nedovedu si představit, že by moje nejpoužívanější aplikace (Visual Studio, Word, Outlook) byly převedené do Metro podoby.

[![Windows 8 Start](https://www.cdn.altairis.cz/Blog/2012/20120302-win8_thumb.png "Windows 8 Start")](https://www.cdn.altairis.cz/Blog/2012/20120302-win8_2.png)

Neuralgickým bodem pro většinu uživatelů se zdá být absence tlačítka Start a Start menu. Já se sice zatím vždycky leknu, když zmáčknu Windows klávesu a změní se mi celá obrazovka, ale v praxi změnu hodnotím pozitivně. Proč? Protože start menu jako takové nepoužívám a v podstatě jsem nikdy nepoužíval. 

Na Windows 7 mám ty nejpoužívanější programy (browser, RDP klient, Altap Salamander, Visual Studio, Management Studio) připnuté na taskbaru (to funguje pořád stejně).

Ty méně používané ale pořád často spouštěné mám připnuté ve start menu (a měl jsem i ve starších verzích Windows, akorát tehdy se tomu říkalo jinak). Tam jsou takové věci, jako Word, Excel, eWallet atd. Ve Windows 8 jsem si je připnul do nabídky Start také, jenom je mám lépe organizované, viz screenshot nahoře. Vadí mi jenom to, že dlaždice nelze organizovat zcela libovolně, skupiny lze vytvářet pouze horizontálně a nelze třeba vytvořit sloupec o šířce jedné dlaždice (víc by se mi líbilo mít Word, Excel, Powerpoint a Visio pod sebou a nebo vedle sebe a ostatní programy pod nimi). Ale to je víceméně drobnost. Dále pak je trochu nešťastné, že všechny programy v bývalém Start menu mají ve výchozím nastavení dlaždici na Start obrazovce. Takže po instalaci jsem tam měl desítky dlaždic, ve kterých se nedalo vyznat. Ale dají se snadno odstranit (klikáním pravým tlačítkem je označíte, pak zvolte "Unpin from Start menu").

[![win8_search](https://www.cdn.altairis.cz/Blog/2012/20120302-win8_search_thumb.png "win8_search")](https://www.cdn.altairis.cz/Blog/2012/20120302-win8_search_2.png)

Programy třetí kategorie nemám nervy hledat podle ikonek, takže používám vyhledávání: zmáčknu Start a napíšu část názvu. To funguje beze změn i nadále.

Další užitečnou funkcionalitu získal taskbar. Můžete ho mít na několika monitorech současně (dokonce třeba na každém v jiné poloze) a lze nastavit, že se na něm budou vždy zobrazovat aplikace na jednotlivých monitorech. Mám ve zvyku mít na samostatném monitoru trvale otevřené různé "pomocné" záležitosti, jako třeba IM klienta, přehrávač a další. Ty mi dřív zabíraly místo na taskbaru hlavnímo monitoru, nyní se přestěhují na svůj.

Zatím jsem neřešil novou funkcionalitu typu obnovování, synchronizace a podobné věci. Líbí se mi ideově integrace SkyDrive, která ovšem bezešvě funguje jenom z Metro rozhraní, z normálních Windows se mi stále ještě nepodařilo se na SkyDrive rozumně dostat.

## Internet Explorer 10<strike>: hlavní problém (zatím)</strike>

<strike>To je nejslabší místo Windows 8 a z mého hlediska největší komplikace. Řada webů totiž v IE 10 prostě nefunguje nebo funguje divně. Typicky jsou to různé zaAJAXované aplikace, které hojně využívají asynchronní callbacky. Z těch známých a velkých mi na IE 10 nefunguje Facebook (nelze na něm cokoliv napsat, je read only), Seznam e-mail (nepodařilo se mi přečíst zprávu, jenom zobrazit jejich seznam) nebo třeba Google Reader (nezaznamenává přečtené zprávy).</strike>

<strike>Z tohoto důvodu jsem musel začít jako sekundární prohlížeč na Facebook a podobně používat Chrome. Tato situace je nicméně běžná při vydání každé nové verze IE, kdy chvíli trvá, než autoři aplikací zaregistrují, že staré triky nefungují a weby napíšou pořádně nebo si alespoň vynutí přepnutí do režimu kompatibility. Počítám tady, že během pár dnů až týdnů se situace zlepší a užívám si tradičních bolestí early adoptera.</strike>

Bližším vyšetřováním bylo zjištěno, že problémy, které jsem připisoval IE 10, byly ve skutečnosti způsobeny [Free Download Managerem](http://www.freedownloadmanager.org/). Po jeho odinstalaci všechno funguje správně a na problémy jsem nenarazil.

Na IE 10 mne ještě zlobí vestavěná kontrola pravopisu, zejména proto, že polovinu věcí na webu píšu anglicky. Na Internetu se často dočtete, že tato funkce nejde vypnout. Není to pravda, vypnout jde, akorát se to nedělá v IE, ale v nastavení systému (je to funkce systému, ne IE):

[![lang](https://www.cdn.altairis.cz/Blog/2012/20120303-lang_thumb.png "lang")](https://www.cdn.altairis.cz/Blog/2012/20120303-lang_2.png)

## Visual Studio 11: Uměřené nadšení

Nové šedé rozhraní Visual Studia budí velmi smíšené reakce. Někomu se líbí, spousta lidí na něj nadává, zejména pak na monochromatické ikonky. Mně osobně se jednoduché a střízlivé rozhraní Studia strašně líbí a od zveřejnění prvních screenshotů jsem se na něj vyloženě těšil. Vadí mi jenom názvy oken psané velkými písmeny, což je ošklivé a nepřehledné – místo toho bych zvolil tučný řez nebo jinou barvu.

[![vs11](https://www.cdn.altairis.cz/Blog/2012/20120302-vs11_thumb.png "vs11")](https://www.cdn.altairis.cz/Blog/2012/20120302-vs11_2.png)

S monochromatickými ikonkami zásadní problém nemám, ale spustil se okolo toho takový řev, že s tím Microsoft nejspíš něco udělá. Lépe řečeno: nevadí mi ikonky na toolbarech, protože je stejně nepoužívám a toolbary typicky vypínám. Za poněkud nepraktické považuji jednobarevné ikonky pro soubory v Solution Exploreru. Ani ne tak pro jejich jednobarevnost jako takovou, ale hlavně proto, že jsou jiné, než na jaké jsem zvyklý.

Visual Studiu a .NET Frameworku se zde budu věnovat ještě v budoucnu, tohle jako malá ochutnávka pro dnešek myslím stačí.