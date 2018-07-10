<!-- dcterms:identifier = aspnetcz#110 -->
<!-- dcterms:title = Virtualizace: Virtual Server 2005 R2 -->
<!-- dcterms:abstract = V předchozím povídání o virtualizaci jsem vám představil program Virtual PC. To je dobré na interaktivní práci, ale nemůžete v něm provozovat "ostré" servery - a přitom právě jejich konsolidace je jedním z hnacích motorů virtualizace jako takové. Proto je tu "větší bratříček" jménem Virtual Server. -->
<!-- np9:categoryId = 6 -->
<!-- x4w:category = Akce a události -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- np9:serialId = 1 -->
<!-- x4w:serial = Virtualizace -->
<!-- dcterms:created = 2006-08-25T17:31:25.503+02:00 -->
<!-- dcterms:dateAccepted = 2006-08-25T17:31:25.503+02:00 -->

 

V [předchozím povídání o virtualizaci](https://www.aspnet.cz/Articles/104-virtualizace-virtual-pc-2004.aspx) jsem vám představil program Virtual PC. To je dobré na interaktivní práci, ale nemůžete v něm provozovat "ostré" servery - a přitom právě jejich konsolidace je jedním z hnacích motorů virtualizace jako takové. Proto je tu "větší bratříček" jménem **Virtual Server**.

## Servery, které neexistují

Když jsem na českém Internetu začínal, byly počítače dřevěné, šlapací a především *drahé*. Takže většina lidí - když už byli ochotni a schopni platit ty nehorázné poplatky za hosting - měla jenom jeden a ten dělal všechno: poštu, web, DNS, databázový server... Často ne právě s radostí: můj první server (poháněl ho Cyrixí klon Pentia o úžasné taktovací frekvenci 150 MHz a měl úžasných 64 MB RAM) skončil v plamenech.

Časem se situace obrítila a počítače začaly být až urážlivě laciné. Není problém vybudovat mohutnou serverovou farmu a jednotlivé služby a zákazníky od sebe izolovat. Poplatky za konektivitu sice klesly, ale při větším počtu se vám může snadno stát, že budete platit víc za fyzické umístění stádečka počítačů, než za konektivitu.

Rovněž výkon počítačů stoupá závratným tempem. Dnešní dvoujádrové 64-bitové procesory toho zvládnou opravdu hodně. Přesto je ale dobrý nápad mít různé funkce izolované na různých počítačích. Každý program má specifické nároky na paměť, na konfiguraci a tak dále.

Zde se opět ke slovu dostanou virtuální počítače, tentokráte tedy virtuální servery. Základní idea je stejná jako v případě Virtual PC a byla nastíněna již [v prvním dílu tohoto seriálu](https://www.aspnet.cz/Articles/103-virtualizace-uvod.aspx): v rámci jednoho fyzického počítače existuje několik virtuálních.

## Microsoft Virtual Server 2005 R2

Serverovým řešením pro virtualizaci je na platformě Microsoft program **[Virtual Server 2005 R2](http://www.microsoft.com/windowsserversystem/virtualserver/software/default.mspx)**. S jistou mírou nepřesnosti můžeme říct, že má podobná "střeva" jako Virtual PC, pojednávané minule, ale má jiné rozhraní. Virtual PC předpokládá interaktivní práci, má standardní uživatelské rozhraní, běží v rámci uživatelovy session jako běžná GUI aplikace. 

Virtual Server oproti tomu předpokládá, že bude běžet na serveru, bez přímé interakce. Funguje jako služba (Windows service) a jeho virtuální stroje se mohou spouštět automaticky po startu systému. Správa (tedy vytváření virtuálních počítačů, sítí, jejich úpravy a podobně) probíhá přes webové rozhraní.

[![Rozhraní Virtual Serveru 2005 R2](https://www.cdn.altairis.cz/Blog/2006/20060825-virtualserver-lq.gif) ](https://www.cdn.altairis.cz/Blog/2006/20060825-virtualserver-hq.png)

Pro připojení na konzoli počítače slouží speciální VMRC klient. Vzdáleně připomíná klienta pro připojení k terminálovým službám, ale opravdu jenom vzdáleně. Sice umí fungovat po síti, ale použitý protokol je jiný, stejně jako účel.

Připojení na virtuální server není zdaleka tak schopné a pohodlné, jako práce s rozhraním Virtual PC nebo přes terminál. Nefunguje sdílení schránky, přenozsy souborů, změna velikosti okna za běhu a tak dále. U serverů se předpokládá, že pro přístup k nim se bude především používat prostředků nainstalovaného operačního systému, tj. že si nainstalujete virtuální server a pro práci na něm se budete připojovat např. přes RDP (terminálové služby, vzdálená plocha).

## Rozdíl mezi Virtual PC a Virtual Serverem

Programy *Virtual PC* a *Virtual Server* mají podobné jádro (byť nikoliv stejné), ale různé určení a proto se liší jejich schopnosti.

**Virtual PC 2004 SP1:** 

*   Je desktopové řešení.
*   Předpokládá interakci s uživatelem.
*   Má komfortní rozhraní pro práci, sdílení schránky, drag and drop přenos souborů atd.
*   Má omezené možnosti vytváření virtuálních sítí.
*   Podporuje pouze virtuální IDE řadiče, takže v počítači můžete mít nejvýše čtyři zařízení, z toho nejvýše jednu CD/DVD mechaniku.
*   Má virtuální zvukovou kartu.
*   Je optimalizován pro současný běh jednoho virtuálního počítače.

**Virtual Server 2005 R2:** 

*   Je serverové řešení.
*   Běží jako služba.
*   Nemá příliš komfortní rozhraní, nepředpokládá se interaktivní práce.
*   Má široké možnosti vytváření a propojování virtuálních sítí.
*   Podporuje virtuální IDE a SCSI řadiče, může tedy mít připojeno velké množství disků a CD/DVD mechanik.
*   Nepodporuje zvukovou kartu.
*   Má širší možnosti automatizované správy a dohledování, podporuje skriptování, WMI a podobně.
*   Je optimalizován pro současný běh více virtuálních počítačů.
*   Podporuje více operačních systémů, včetně některých distribucí Linuxu.

Podrobnější popis rozdílů mezi těmito programy najdete [na webu Microsoftu](http://www.microsoft.com/windowsserversystem/virtualserver/techinfo/vsvsvpc.mspx).

## Kompatibilita

Oba dva programy používají stejný formát pro virtuální hard disky (VHD). Konfigurační soubory (VMC) jsou také kompatibilní, pokud přihlédnete ke shora uvedeným rozdílům, tj. např. před přenosem PC -> Server zakážete zvukovou kartu.

V zásadě kompatibilní jsou i Virtual Machine Additions, i když i tam jsou samozřejmě rozdíly vycházející z odlišností popsaných výše. Nicméně je možné například nainstalovat ve Virtual PC počítač, přenést jeho obraz na server a tam ho spustit, případně naopak.

## Licence

Virtual Server 2005 R2 sám o sobě je k dispozici k downloadu zdarma. Z hlediska licencování dalších programů obecně nehraje roli, zda počítač, na kterém je SW nainstalován, je virtuální nebo fyzický, k běhu software ve virtuálním počítači tedy potřebujete stejnou licenci, jako pro fyzický PC.

V případě **Windows Serveru 2003 Enterprise Edition** nicméně platí, že kromě jedné fyzické můžete provozovat ještě čtyři další virtuální instance Windows. Tato podpora není vázána na konkrétní virtualizační technologii, vztahuje se na vás tedy i v případě, že používáte např. VMWare ESX Server (který je sám sobě operačním systémem).

Od 1. října 2006 bude též platit, že v případě **Datacenter Edition** můžete virtuálních serverů provozovat [neomezený počet](http://www.microsoft.com/windowsserver2003/evaluation/news/bulletins/datacenterhighavail.mspx).

## Podpora non-Windows OS

Jak již bylo řečeno dříve, virtualizace znamená kompletní reprezentaci počítače. Obecně tedy můžete do virtuálního počítače nainstalovat jakýkoliv operační systém pro x86 platofrmu. Nejsou tomu kladena žádná licenční ani úmyslná technologická omezení. V praxi nicméně některé (zejména starší) operační systémy do virtuálního počítače nainstalovat nejdou. Na adrese [http://vpc.visualwin.com/](http://vpc.visualwin.com/) můžete najít seznam bezmála patnácti set operačních systémů, které byly testovány na kompatibilitu s Virtual PC (a z nich 273 neběží, nicméně o většině z nich jsem v životě neslyšel).

Oficiálně podporovaných operačních systémů je samozřejmě mnohem méně. Vyznačují se tím, že jsou pro ně k dispozici Virtual Machine Additions a technická podpora. K dispozici jsou i pro [některé distribuce Linuxu](http://www.microsoft.com/windowsserversystem/virtualserver/evaluation/linuxguestsupport/default.mspx).

## Odkazy

*   [Virtual Server 2005 R2](http://www.microsoft.com/windowsserversystem/virtualserver/software/default.mspx) je volně ke stažení
*   [Service Pack 1, beta 1](http://www.microsoft.com/windowsserversystem/virtualserver/downloads/servicepack.mspx)
*   [Virtual Machine Additions for Linux](http://www.microsoft.com/windowsserversystem/virtualserver/evaluation/linuxguestsupport/default.mspx)
*   [MOM Management Pack](http://www.microsoft.com/downloads/details.aspx?FamilyId=BF21F798-9B10-40DC-BCDD-4A8358CCE94D)

Existuje též nástroj jménem [Virtual Server 2005 Migration Toolkit](http://www.microsoft.com/windowsserversystem/virtualserver/evaluation/vsmt.mspx), který by měl umožnit snadnou migraci fyzického serveru do virtuálního prostředí. Osobně s ním ale nemám žádnou zkušenost. Pokud vy ano, podělte se.

## Speciální poznámka k VMWare

V komentářích se často objevuje jméno konkurenčního produktu, VMWare. Píšu o Virtual PC a Virtual Serveru, protože ho narozdíl od VMWare znám a používám. VMWare jsem naposledy viděl v nějaké verze 2.0 nebo tak nějak. Bohužel tedy nejsem schopen se k němu nijak vyjádřit. Pokud někdo napíše o tomto SW nějaké pojednání, rád na něj odkážu a nebo ho zde zveřejním.