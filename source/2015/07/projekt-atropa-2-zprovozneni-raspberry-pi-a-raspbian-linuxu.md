<!-- dcterms:identifier = aspnetcz#5430 -->
<!-- dcterms:title = Projekt Atropa (2): Zprovoznění Raspberry Pi a Raspbian Linuxu -->
<!-- dcterms:abstract = Gratuluji, pořídili jste si Raspberry Pi! Třímáte v ruce malou destičku s ježatými konektory. Právě vám je určen druhý díl seriálu o tom, jak na Raspberry Pi rozjet ASP.NET. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Programování -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- np9:serialId = 7 -->
<!-- x4w:serial = Projekt Atropa -->
<!-- dcterms:created = 2015-07-13T03:10:49.3+02:00 -->
<!-- dcterms:dateAccepted = 2015-07-20T00:00:00+02:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20150713-projekt-atropa-1-jak-vyrobit-z-raspberry-pi-zle-zarizeni-s-netem.jpg -->

Gratuluji, pořídili jste si Raspberry Pi! Třímáte v ruce malou destičku s ježatými konektory. Právě vám je určen druhý díl seriálu o tom, jak na Raspberry Pi rozjet ASP.NET. Oficiální návod ke zprovoznění (anglicky) najdete na webu [Raspberry Pi](https://www.raspberrypi.org/documentation/installation/).

Nezapomeňte si přečíst [úvod k této sérii](https://www.aspnet.cz/Articles/5429-projekt-atropa-jak-vyrobit-z-raspberry-pi-zle-zarizeni-s-netem), kde najdete seznam všeho potřebného a důležitá varování.

## Co budete potřebovat?

*   **Raspberry Pi.** Já pracuji s [RASPBERRY Pi 2 Model B](https://www.alza.cz/raspberry-pi-2-d2307258.htm), ale měl by vám stačít i [RASPBERRY Pi Model B+](https://www.alza.cz/raspberry-pi-model-b-d2141877.htm). (Linky vedou na Alza.cz, ale RPi lze na menších e-shopech koupit výrazně levněji). Doporučuji si k němu koupit i nějakou krabičku. 
*   **Dostatečně silný zdroj s MicroUSB konektorem.** Budete z něj napájet Raspberry a měl by mít alespoň 2 A. Já používám ke své spokojenosti 2 A zdroj od tabletu. Nabíječka na mobil vám téměř jistě stačit nebude. 
*   **MicroSD kartu.** Používám 8 GB Class 10, ale možná by stačila i 4 GB. Také budete potřebovat patřičnou čtečku pro vaše PC a případně redukci z MicroSD na velkou SD.  Redukce bývá u některých karet přímo součástí balení. 
*   **Monitor s HDMI vstupem.** To má většina novějších monitorů, případně vám stačí DVI nebo DisplayPort vstup a patřičná redukce/kabel. 
*   **USB klávesnice.** Jakákoliv standardní klávesnice postačí. 
*   **USB Wi-Fi karta.** Nejlépe se mi osvědčila karta [TP-LINK TL-WN722N](https://www.alza.cz/tp-link-tl-wn722n-lite-d155291.htm). Je levná, široce kompatibilní (Raspbian s ní umí pracovat automaticky), má všechny funkce potřebné i pro pokročilejší Wi-Fi škození a externí anténu, místo které je možné připojit jinou. 

Dále pak budete potřebovat běžný počítač s v podstatě libovolným operačním systémem. Já používám poslední preview Windows 10, ale nesejde na tom, protože z tohoto PC budeme potřebovat jenom kopírovat souboryu a používat terminálový program. Využívat budeme též různý volně dostupný software, na který vás postupně upozorním v průběhu návodu.

## Příprava MicroSD karty

Vložte MicroSD kartu do čtečky a připojte k počítači. Kartu je třeba zformátovat na FAT32 file systém. V zásadě k tomuto účelu můžete použít i běžné funkce operačního systému, nicméně lepší nápad je použít utilitu [SD Formatter](https://www.sdcard.org/downloads/formatter_4/), která je dílem SD Association a je určena speciálně pro práci s paměťovými kartami.

Spusťte utilitu, vyberte patřičný disk a po klepnutí na tlačítko *Option* povolte *Format size adjustment*, čímž zformátujete celou kartu, nejen případnou první partition:

[![Formátování SD karty](https://www.cdn.altairis.cz/Blog/2015/20150713-atropa_sdformat_thumb.png "Formátování SD karty")](https://www.cdn.altairis.cz/Blog/2015/20150713-atropa_sdformat_2.png)

Nyní na kartu musíte nahrát správná data. Existují v zásadě tři postupy:

*   Můžete použít NOOBS Lite, kdy na kartu nahrajete minimální množství dat a zbytek se dynamicky dotáhne při instalaci. Musíte mít ovšem Raspberry připojené k Internetu, nejlépe klasickým ethernetovým kabelem (nejsem si jist, zda to funguje přes Wi-Fi). Automaticky se dotáhne vše potřebné. 
*   Můžete použít NOOBS, který obsahuje vše potřebné pro instalaci a při instalaci samotné můžete být offline. To použijte ve chvíli, kdy v místě instalace nebudete mít dostatečně solidní připojení k Internetu.
*   Můžete si stáhnout hotový kompletní image. 

Vše potřebné je ke stažení na webu RaspberryPi.org v [sekci Download](https://www.raspberrypi.org/downloads/).

Já budu v následujícím návodu používat první zmíněný postup a použiji tedy [NOOBS Lite](https://downloads.raspberrypi.org/NOOBS_lite_latest). Stáhněte si ZIP archiv, který má 22 MB a jeho obsah (nikoliv archiv samotný) uložte na SD kartu do rootu. V kořenovém adresáři musíte mít soubor `bootcode.bin` a další.

## Zapojení RPi

Na následujícím obrázku vidíte zapojené Raspberry Pi model 2+ plné jeho kráse:

[![Celkový pohled na Raspberry Pi](https://www.cdn.altairis.cz/Blog/2015/20150713-atropa_rpihw_thumb_1.jpg "Celkový pohled na Raspberry Pi")](https://www.cdn.altairis.cz/Blog/2015/20150713-atropa_rpihw_4.jpg)

V levém dolním rohu je připojena USB Wi-Fi, nad ní vede kabel k USB klávesnici, dále je ethernetový síťový kabel. Nahoře je HDMI kabel k monitoru a MicroUSB napájení (které zatím nepřipojujte) a vpravo uprostřed je ve spodní části desku MicroSD karta. RPi mám v průhledné krabičce, kterou si nicméně musíte koupit zvlášť a je vhodná spíše na dema, než na praktické použití.

V pravé dolní části desky je červená LEDka (na fotce svítí). Pokud začne poblikávat, máte příliš slabý zdroj. Na monitoru se přitom v pravém horním rohu objeví duhový čtvereček. Nestabilita napájení může způsobovat značné problémy, takže si ve vlastním zájmu obstarejte kvalitní zdroj.

Zasuňte MicroSD kartu a zapojte všechny kabely, napájení jako poslední.

## Instalace operačního systému

Raspberry Pi rychle nabootuje a na monitoru se vám zobrazí prostředí NOOBS, kde si můžete vybrat (mezerníkem) operační systémy, které chcete instalovat. Vyberte si Raspbian, což je speciální varianta Debianu pro Raspberry Pi. Stiskem klávesy I zahájíte instalaci. 

[![Instalace operačního systému](https://www.cdn.altairis.cz/Blog/2015/20150713-atropa_rpinoobs_thumb.jpg "Instalace operačního systému")](https://www.cdn.altairis.cz/Blog/2015/20150713-atropa_rpinoobs_2.jpg)

Ta bude nějakou dobu trvat, přičemž přesnější kvantifikace oné doby záleží na rychlosti vašeho připojení k Internetu. Budou se stahovat zhruba dva gigabajty dat. Tak si běžte uvařit kafe. Nebo, máte-li ADSL nebo mobilní připojení, oběd o šesti chodech. Po dokončení stiskem klávesy Enter RPi restartujte.

Po restartu se spustí textové menu. V něm si můžete změnit heslo (výchozí je uživatel `pi` s heslem `raspberry`, obojí je case sensitive). V International settings si můžete nastavit například časovou zónu (ale pozor, RPi nemá hodiny reálného času) a rozložení klávesnice. Až budete spokojeni, vyberte *Finish*.

Po dokončení textové části setupu se vám ukáže příkazová řádka s promptem `pi@raspberrypi ~ $`. Počítač můžete používat s připojenou klávesnicí, monitorem a případně myší. K dispozici je celkem šest terminálů, mezi kterými se přepínáte pomocí klávesové zkratky *Alt+F1* až *Alt+F6*. Kromě textového můžete použít i grafické rozhraní (to spustíte příkazem `startx`).

## Připojení po síti

My nicméně nebudeme používat lokální konzoli, ale budeme s Raspberry Pi komunikovat po síti. 

Jako první potřebujeme zjistit IP adresu počítače. Tu lze zjistit mnoha způsoby (třeba z DHCP serveru), ale protože máme k dispozici lokální konzoli, stačí napsat příkaz `ifconfig`, což je obdoba příkazu `ipconfig` na Windows. Ukáže se něco takového:

    pi@raspberrypi ~ $ ifconfig
    eth0      Link encap:Ethernet  HWaddr b8:27:eb:07:93:41
              inet addr:**10.7.0.101**  Bcast:10.7.0.255  Mask:255.255.255.0
              UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
              RX packets:14124 errors:0 dropped:0 overruns:0 frame:0
              TX packets:2286 errors:0 dropped:0 overruns:0 carrier:0
              collisions:0 txqueuelen:1000
              RX bytes:17452927 (16.6 MiB)  TX bytes:281223 (274.6 KiB)

    lo        Link encap:Local Loopback
              inet addr:127.0.0.1  Mask:255.0.0.0
              UP LOOPBACK RUNNING  MTU:65536  Metric:1
              RX packets:72 errors:0 dropped:0 overruns:0 frame:0
              TX packets:72 errors:0 dropped:0 overruns:0 carrier:0
              collisions:0 txqueuelen:0
              RX bytes:6288 (6.1 KiB)  TX bytes:6288 (6.1 KiB)

    wlan0     Link encap:Ethernet  HWaddr c4:6e:1f:13:27:87
              UP BROADCAST MULTICAST  MTU:1500  Metric:1
              RX packets:0 errors:0 dropped:0 overruns:0 frame:0
              TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
              collisions:0 txqueuelen:1000
              RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

Nás zajímá adresa u rozhraní `eth0`, za `inet addr:`, zde 10.7.0.101 (ve výpisu zobrazena tučně).

Maje cílové adresy, můžeme se připojit. K tomu potřebujete SSH klienta a nejčastěji se používá program jménem Putty. Stáhněte si [ZIP soubor](http://the.earth.li/~sgtatham/putty/latest/x86/putty.zip) a někam ho rozbalte.

Spusťte program `PUTTY.EXE`. Aby vše řádně fungovalo, je dobrý nápad nastavit některé parametry.

V levé části klepněte na *Appearance* a zvolte si vašemu oku libou velikost a typ fontu. Já používám Consolas o velikost 14 bodů, ale já jsem napůl slepý, vám bude možná vyhovovat menší písmo.

[![Konfigurace písma v Putty](https://www.cdn.altairis.cz/Blog/2015/20150713-atropa_putty_1_thumb.png "Konfigurace písma v Putty")](https://www.cdn.altairis.cz/Blog/2015/20150713-atropa_putty_1_2.png)

V sekci Translation si jako *Remote character set* vyberte UTF-8 a ve spodní části vyberte *Use Unicode Line Drawing Code Points*.

[![Konfigurace kódování v Putty](https://www.cdn.altairis.cz/Blog/2015/20150713-atropa_putty_2_thumb.png "Konfigurace kódování v Putty")](https://www.cdn.altairis.cz/Blog/2015/20150713-atropa_putty_2_2.png)

V sekci Session zadejte jako název nebo IP adresu cílového zařízení dříve zjištěnou IP adresu a jako typ spojení SSH. Poté klepněte na *Default Settings* a *Save*, čímž nastavení uložíte jako výchozí.

[![Parametry spojení v Putty](https://www.cdn.altairis.cz/Blog/2015/20150713-atropa_putty_3_thumb.png "Parametry spojení v Putty")](https://www.cdn.altairis.cz/Blog/2015/20150713-atropa_putty_3_2.png)

Nyní můžete klepnout na *Open* a připojit se. Při prvním připojení budete vyzváni k potvrzení správnosti SSH klíče, což potvrďte (bezpečnost zde v tomto okamžiku neřešíme, pro ostré nasazení je nutné vygenerovat vlastní klíč a ověřit si pomocí fingerprintu jeho pravost). Poté musíte zadat uživatelské jméno (`pi`) a heslo (`raspberry`, pokud jste ho dříve nezměnili).

Poté budete úspěšně přihlášeni:

[![Přihlášení ke vzdálenému systému](https://www.cdn.altairis.cz/Blog/2015/20150713-atropa_putty_4_thumb.png "Přihlášení ke vzdálenému systému")](https://www.cdn.altairis.cz/Blog/2015/20150713-atropa_putty_4_2.png)

Tipy k použití Putty:

*   Okno můžete myší zvětšovat a zmenšovat v obou směrech. Přizpůsobí se počet řádků a sloupců.
*   Můžete používat i schránku. Text na lokálním počítači běžným způsobem zkopírujte a poté klepněte kamkoliv do okna Putty pravým tlačítkem, čímž se text vloží.
*   Pokud chcete kopírovat ze vzdáleného počítače na lokální, označte požadovaný text pomocí levého tlačítka myši. Klepnutím levým tlačítkem označení zmizí a kód se zkopíruje do schránky.
*   Pokud po označení klepnete pravým tlačítkem, text se zkopíruje a ihned vloží, což je užitečné zejména, pokud to příkazu potřebujete zapsat něco, co jste získali napsané na obrazovce.

## Aktualizace balíčků

Programy a součásti systému se na Linuxu instalují vesměs pomocí balíčkovacích systémů. Raspbian používá Aptitude a bude vás tedy zajímat příkaz `apt-get`.

Aktualizaci seznamu dostupných balíčků a instalaci těch nejnovějších provedete následujícím příkazem

    sudo apt-get update && sudo apt-get upgrade -y

Příkaz `sudo` slouží k vykonání příkazu pod oprávněním správce systému (uživatel `root`). Poněkud to připomíná User Account Control (UAC) na Windows Vista a novějších. Přepínač `-y` v tomto případě znamená, že se operace má rovnou provést a že se příkaz na nic nemá ptát. Obecně platí, že u všeho (příkazů, názvů souborů, parametrů…) záleží na použití velkých a malých písmen.

## Instalace užitečného software

Při práci se vám téměř jistě budou hodit některé utility, které si můžete snadno nainstalovat pomocí následujících příkazů:

*   `sudo apt-get install mc` – nainstaluje Midnight Commander, což je dvoupanelový správce souborů, který poněkud připomíná Norton Commander pro DOS (nebo, pro později narozené, Total Commander pro Windows). 
*   `sudo apt-get install lynx` – nainstaluje Lynx, textový webový prohlížeč. Pro mne znamená závan nostalgie, protože v něm jsem poprvé lezl na web. Pro vás může znamenat užitečný nástroj pro kontrolu funkčnosti webu. 
*   `sudo apt-get install dnsutils` – nainstaluje utility `nslookup` a `dig`, které můžete použít pro diagnostiku problémů s DNS a kontrolu jeho nastavení. 

Vše najednou a bez ptaní nainstalujete následujícím příkazem:

    sudo apt-get install mc lynx dnsutils -y

[![Midnight Commander spustíte příkazem 'mc'](https://www.cdn.altairis.cz/Blog/2015/20150713-atropa_mc_thumb.png "Midnight Commander spustíte příkazem 'mc'")](https://www.cdn.altairis.cz/Blog/2015/20150713-atropa_mc_2.png)

## Restart a vypnutí

Žádný počítač by se neměl vypínat vytažením napájení a Raspberry Pi není výjimkou. Pro vypnutí použijte příkaz `sudo shutdown -hP now` a pro restart `sudo reboot`. Pokud se chcete jenom odhlásit ze vzdáleného terminálu, zavřete okno Putty nebo použijte příkaz `logout`.