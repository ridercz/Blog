<!-- dcterms:identifier = aspnetcz#104 -->
<!-- dcterms:title = Virtualizace: Virtual PC 2004 -->
<!-- dcterms:abstract = Tématu virtualizace jsem se na tomto webu dosud nevěnoval a na českém Internetu mu není věnován zdaleka takový prostor, jaký by si zaloužilo. Microsoft nyní uvolnil zdarma k použití pro všechny oba dva své virtualizační produkty: Virtual PC 2004 i Virtual Server 2005 R2. To mne vede k nápadu sepsat sérii článků o virtualizaci a jejím využití. Tento druhý díl se bude zabývat programem Microsoft Virtual PC 2004, tedy "virtualizací pro normální lidi". -->
<!-- np9:categoryId = 6 -->
<!-- x4w:category = Akce a události -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- np9:serialId = 1 -->
<!-- x4w:serial = Virtualizace -->
<!-- dcterms:created = 2006-07-17T04:00:00+02:00 -->
<!-- dcterms:dateAccepted = 2006-07-17T04:00:00+02:00 -->

 ![Okno Virtual PC](/Files/20060715-VirtualPC.png)Tématu virtualizace jsem se na tomto webu dosud nevěnoval a na českém Internetu mu není věnován zdaleka takový prostor, jaký by si zaloužilo. Microsoft nyní uvolnil zdarma k použití pro všechny oba dva své virtualizační produkty: Virtual PC 2004 i Virtual Server 2005 R2. To mne vede k nápadu sepsat sérii článků o virtualizaci a jejím využití. 

Tento druhý díl se bude zabývat programem Microsoft Virtual PC 2004, tedy "virtualizací pro normální lidi". [Předchozí díl](/Articles/103-virtualizace-uvod.aspx) byl věnován obecnému úvodu do virtualizace.

## Získání a instalace

Program Virtual PC je k dispozici zdarma a můžete si ho [stáhnout ze stránek Microsoftu](http://www.microsoft.com/windows/virtualpc/downloads/sp1.mspx). Aktuální je verze 2004 SP1 (software na výše uvedeném linku už SP1 obsahuje).

Instalace je bezproblémová a nevyžaduje žádná specifická nastavení ani znalosti.

Hardwarové požadavky závisejí na tom, jaké virtuální počítače chcete provozovat a kolik jich bude. Samozřejmě platí "čím více, tím lépe". Doporučuji dual-core procesor, ale nejkritičtějším bodem je jednoznačně paměť. Paměť, kterou chcete přidělit virtuálnímu počítači musíte mít na tom fyzickém, tj. pokud vytvoříte virtuální počítač s 512 MB RAM, sebere vám to 512 MB paměti na fyzickém stroji.

Bez větších problémů jsem virtuální počítače provozoval na notebooku s 2 GHz procesorem a 1 GB paměti, měl jsem ale spuštěn vždy jenom jeden virtuální počítač současně. Za optimální konfiguraci považuji svoji současnou pracovní stanici: dual core procesor na 3 GHz a 2 GB operační paměti (té by mohlo být i víc).

Počítejte rovněž s tím, že VPC je dosti velký žrout diskového prostoru. Virtuální hard disky jednotlivých počítačů jsou na disku ukládány jako samostatné soubory o velikosti několika gigabajtů.

## Jak vypadá virtuální počítač

Virtuální počítače typicky sestávají z několika souborů, rozlišených podle přípon:

*   **VMC **jsou malé XML soubory, které popisují konfiguraci počítače.
*   **VHD **jsou velké soubory, které reprezentují virtuální hard disky. Je jich několik typů, jak pojednáme později.
*   **VFD **jsou obrazy disket, ale v životě jsem žádný neviděl.
*   **VSV** jsou dočasně existující soubory které vzniknou, pokud vypnete virtuální počítač a uložíte jeho stav. V takovém případě se obsah jeho paměti uloží do tohoto souboru. Podobá se to procesu hibernace který jistě znáte, pokud jste uživateli notebooku. 

## Vytvoření a konfigurace virtuálního počítače

Při prvním spuštění Virtual PC se spustí průvodce vytvořením virtuálního počítače. Kdykoliv později ho můžete spustit klepnutím na tlačítko "New..." v hlavním okně programu. V průběhu průvodce budete vyzváni k určení názvu a umístění souborů tohoto VPC. Ze shora uvedených důvodů vyberte disk, na kterém máte dost místa (a který je dost rychlý).

Virtual PC se vás optá, jaký operační systém hodláte ve virtuálním počítači provozovat. Seznam OS je značně omezený a slouží v podstatě jenom k nastavení doporučené paměti, kterou stejně v dalším kroku můžete změnit. V žádném případě se nejedná o seznam podporovaných operačních systémů (pokud vás zajímá, můžete ho najít na [webu Jonathana Maltze](http://vpc.visualwin.com/)).

Pokud se týče paměti, závisí na tom, co chcete s daným virtuálním počítačem provádět. Pokud chcete jenom něco malého vyzkoušet, stačí dát minimum paměti pro daný OS. Pokud ve virtuálu chcete vyvíjet ve Visual Studiu, dejte paměti co nejvíc.

Po vytvoření klepněte na tlačítko Settings. Otevře se vám okno, kde můžete podrobně nastavit všechny parametry:

 ![Okno Virtual PC - nastavení](/files/20060715-VpcSettings.gif) 

Okno nastavení je poněkud zrádné v tom, že některé věci můžete (celkem logicky) nastavit pouze pokud je virtuální počítač vypnuté (paměť, disky...). Jiné ovšem pouze tehdy, pokud VPC běží a jsou na něm nainstalovány Virtual Machine Additions).

K virtuálnímu počítači můžete připojit až tři virtuální hard disky v podobě VHD souborů nebo namapovaného fyzického disku. Disky jsou připojeny k virtuálnímu IDE řadiči, Virtual PC nepodporuje virtuální SCSI. Pokud povolíte "undo disks", budou se změny ukládat do zvláštního souboru a při vypínání virtuálního počítače budete mít možnost změny nechat jak jsou, definitivně je potvrdit a nebo zrušit. Tato funkce je náročnější na diskový prostor, ale pro rozličné testování a pokusy může být velice užitečná.

Virtuální CD/DVD nebo floppy mechanika se umí napojit na fyzickou mechaniku vašeho počítače a nebo připojit soubor s image (pro floppy VFD, pro CD/DVD standardní ISO).

Obdobným způsobem lze připojit sériové a paralelní porty, což jsem ale v praxi nikdy nezkoušel.

Velmi důležitá je sekce Networking. Počítač může mít až čtyři virtuální síťové karty, u nichž si můžete vybrat, v jakém režimu budou operovat:

*   **Not connected** - síťová karta není nikam připojena, počítač se chová, jako by do ní nebyl zasunut kabel.
*   **Local only** - bude vytvořena virtuální síť, která umožní komunikovat více současně spuštěným virtuálním počítačům mezi sebou. Nebude možno komunikovat s reálnou sítí ani s hostitelským počítačem.
*   **Shared networking (NAT)** - hostitelský počítač se bude chovat jako router s NATem. Virtuální počítač bude přes DHCP přidělenou adresu z rozsashu 192.168.131.x. Bude schopen se připojit na vnější síť, ale nikoliv naopak, protože jednoduchý NAT nepodporuje "inbound port mapping".
*   **Network adapter on the physical computer** - pravděpodobně nejzajímavější řešení. Pomocí fyzické síťové karty hostitelského počítače se virtuální počítač připojí do fyzické sítě a bude se jí jevit jako další připojený počítač se vším všudy. 

Při použití poslední možnosti je nutné si uvědomit několik věcí:

*   Síťová konfigurace virtuálního počítače bude podobná, jako konfigurace hostitelského. Pokud v síti běží DHCP, přidělí mu dynamicky adresu. Pokud v síti funguje statické přidělování adres, je nutné počítači takovou přidělit a nastavit.
*   Vzhledem ke způsobu připojení je jakýkoliv softwarový firewall běžící na hostitelském stroji vůči virtuálnímu počítači neúčinný. Z hlediska zabezpečení je tedy nutno k virtuálnímu stroji přistupovat jako k fyzickému.
*   Pokud přenášíte virtuální počítače mezi fyzickými, zkontrolujte si po přenosu nastavení této hodnoty, protože nastavení je vázáno na název síťové karty (který bude pravděpodobně odlišný). 

## Spuštění VPC a instalace guest OS

 ![Virtuální počítač bootuje](/files/20060715-VpcBooting.gif)Klepnutím na tlačítko Start virtuální počítač spustíte a začne bootovat. Musíte na něj nainstalovat operační systém, stejně jako na fyzický počítač.

Nejčastěji budete postupovat tak, že si v menu *CD* připojíte fyzickou mechaniku (*Use Physical Drive*) nebo ISO image (*Capture ISO image*) a nabootujete z CD.

Postup instalace je stejný, jako byste instalovali na skutečný počítač. Osobně zpravidla postupuji tak, že mám jeden "master" image s operačním systémem a ten pak používám k rychlému vytvoření "pokusných" strojů. 

Ke slovu se také dostanou utilitky typu *sysprep* (najdete ji na instalačním CD Windows) nebo [NewSid](http://www.sysinternals.com/Utilities/NewSid.html) od SysInternals.

Pokud do okna virtuálního počítače klepnete myší, zůstane myš "zachycena" v okně a nedostanete se ven. Abyste kurzor uvolnili, stiskněte naprázdno pravý *Alt* (bývá označen jako *AltGr*).

AltGr je ve virtuálním počítači velmi důležitá klávesa. Obecně se jí říká *host key* a v nastavení ji můžete změnit; zpravidla se tak ale neděje. Používá se k různým "systémovým" účelům a lze tak do guest počítače "poslat" speciální klávesové zkratky typu CTRL-ALT-DEL.Nejpoužívanější klávesové zkratky jsou:

*   *AltGr + DEL* pošle do virtuálního počítače CTRL-ALT-DEL
*   *AltGr + ENTER* přepíná mezi full screen režimem a během v okně
*   *AltGr + P* zastaví (pause) a pak zase rozběhne (resume) virtuální stroj
*   *AltGr + R* vyresetuje virtuální stroj 

## Virtual Machine Additions

Virtual Machine Additions je balík software, který se instaluje do virtuálního počítače. Pokud je nainstalujete, výrazně tím zvýšíte výkon virtuálního počítače a komfort práce s ním.

Virtual Machine Additions jsou dostupné pro následující operační systémy

*   **Windows 95, 98, NT, Me, 2000, XP, 2003** - standardní součást instalace
*   **MS-DOS** - standardní součást instalace, postup instalace pro VMA pro DOS najdete v [Q833146](http://support.microsoft.com/?kbid=833146)
*   **OS/2** - standardní součást instalace, nezkoušel jsem (nemáte někdo instalačky OS/2?)
*   **Windows Vista** - provoz Visty pod Virtual PC je spojen s řadou problémů a oficiálně není podporován. Jsou nicméně k dispozici polooficiální VMA pro Vistu. S některými beta verzemi Visty fungují, s jinými ne. Podrobnější informace najdete na blogu s příznačným podtitulem "*[Views on using an unreleased operating system on a computer that doesn't exist](http://blogs.msdn.com/mikekol/archive/category/11647.aspx)*".
*   **RedHat a SuSE Linux** - additions si můžete stáhnout [z webu Microsoftu](http://www.microsoft.com/windowsserversystem/virtualserver/evaluation/linuxguestsupport/default.mspx), kde také najdete konkrétní seznam podporovaných distribucí. Jsou určeny pro Virtual Server, ale údajně fungují i pod Virtual PC. 

Kromě neviditelných "systémových" vylepšení získáte instalací VM Additions (pro Windows) následující výhody:

*   Standardní chování kurzoru myší (nezachytává se)
*   Sdílení schránky (přenos dat mezi host OS a guest OS přes schránku)
*   Mapování adresářů (sekce *Shared Folders* v Settings umožní namapovat adresář z host OS jako síťový disk v guest OS)
*   Dynamická změna rozlišení (změnou velikosti okna měníte rozlišení v guest OS)
*   Drag and drop přenos souborů (přetahováním můžete přenášet soubory mezi guest a host OS) 

 *Příště se podíváme na Microsoft Virtual Server 2005, což je řešení pro provoz virtuálních serverů. Do komentářů můžete psát dotazy a připomínky, budu na ně brát ohled při tvorbě dalších dílů tohoto seriálu.* 