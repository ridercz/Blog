<!-- dcterms:identifier = aspnetcz#103 -->
<!-- dcterms:title = Virtualizace: Úvod -->
<!-- dcterms:abstract = Tématu virtualizace jsem se na tomto webu dosud nevěnoval a na českém Internetu mu není věnován zdaleka takový prostor, jaký by si zaloužilo. Microsoft nyní uvolnil zdarma k použití pro všechny oba dva své virtualizační produkty: Virtual PC 2004 i Virtual Server 2005 R2. To mne vede k nápadu sepsat sérii článků o virtualizaci a jejím využití. První článek této série se zabývá konceptem virtualizace jako takovým. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = IT -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- np9:serialId = 1 -->
<!-- x4w:serial = Virtualizace -->
<!-- dcterms:created = 2006-07-15T01:01:01.603+02:00 -->
<!-- dcterms:date = 2006-07-15T01:01:01.603+02:00 -->

 

Tématu virtualizace jsem se na tomto webu dosud nevěnoval a na českém Internetu mu není věnován zdaleka takový prostor, jaký by si zaloužilo. Microsoft nyní uvolnil zdarma k použití pro všechny oba dva své virtualizační produkty: Virtual PC 2004 i Virtual Server 2005 R2. To mne vede k nápadu sepsat sérii článků o virtualizaci a jejím využití. 

![Okno Virtual PC](https://www.cdn.altairis.cz/Blog/2006/20060715-VirtualPC.png)První článek této série se zabývá konceptem virtualizace jako takovým.

## Co je virtualizace

Virtualizací se v tomto kontextu myslí možnost provozovat v rámci jednoho fyzického počítače několik logických, oddělených instancí operačního systému (mnohdy různých operačních systémů). Využívá se toho, že výkon dnešních počítačů je pro běžné použití silně naddimenzovaný.

Řešení pro virtualizaci je celá řada. Microsoftí řešení se jmenujen [Virtual PC 2004](http://www.microsoft.com/windows/virtualpc/default.mspx) (pro běžné, klientské stanice) a [Virtual Server 2005 R2](http://www.microsoft.com/windowsserversystem/virtualserver/default.mspx) (pro virtualizaci serverových řešení). Největší konkurencí je řada produktů [VMware](http://www.vmware.com/). 

Specifickým případem je projekt [PearPC](http://pearpc.sourceforge.net/), který umožňuje na x86 platformě emulovat PowerPC, tedy platformu Apple.

Na linuxové platformě je populární software [Xen](http://www.cl.cam.ac.uk/Research/SRG/netos/xen/), vyvíjený na University of Cambridge. Nativně umožňuje běh pouze upraveného operačního systému, je sice méně univerzální, ale zato velmi efektivní.

Ve hře jsou dva důležité pojmy: *emulace* a *virtualizace*. V případě emulace je vše realizováno softwarově, bez nějaké zvláštní podpory hardware. Lze tak emulovat třeba i jinou hardwarovou platformu, jak je vidět například na výše zmíněném PearPC. To pomocí Intel x86 procesorů emuluje procesory Motorola PowerPC.

Nové procesory od Intelu i AMD ovšem s provozem virtuálních strojů přímo počítají a mají pro ně přímo v hardware vestavěnou zvláštní podporu. Práce virtualizačního software je pak jednodušší, protože v řadě případů stačí "jenom" tuto podporu zprostředkovat. Tomuto režimu práce se říká *virtualizace*. Virtualizace je pak samozřejmě rychlejší než emulace.

Z produktů Microsoft umí tuto hardwarovou podporu využít pouze Virtual Server 2005 R2 (důležité je tam právě to "R2"). Předchozí verze a Virtual PC umí pouze emulaci.

## Kdy virtuální počítače použít

Výhodou virtuálních počítačů je, že je můžete snadno vytvářet a zase rušit. Přitom z funkčního a síťového hlediska se jedná o plnohodnotné počítače, bootují, je v nich operační systém nezávislý na OS hostitelského stroje a podobně. Typické případy pro nasazení virtuálních počítačů jsou:

### Vývoj a testování

Jednou z hlavních zásad stabilní pracovní stanice je: mít na ní minimum pochybného software. Ale co když si chcete otestovat nový program, zkusit novou verzi a přitom nevíte, jak se systém zachová? Můžete použít virtuální počítač a nainstalovat program do něj. Pokud se po vyzkoušení ukáže býti důvěryhodným, můžete jej pustit i na svou hlavní pracovní stanici.

Ve virtuálním počítači můžete mít i jiný operační systém, než na svém fyzickém stroji. Chcete si vyzkoušet Linux, FreeBSD nebo třeba ReactOS? Máte možnost a nemusíte formátovat disk. Stejně tak můžete odzkoušet kompatibilitu svého software na jiné jazykové verzi operačního systému či na starší verzi OS.

### Staré aplikace, bez kterých se neobejdete

V řadě firem najdete někde v rohu zastrčený starší počítač, na němž běží Windows 95, protože firma k běhu nutně potřebuje nějaký speciální program (obvykle má něco společného s účetnictvím nebo něčím takovým). Jeho autor již před lety zanechal programování a věnuje se pěstování růží, případně byl zastřelen jedním z nespokojených zákazníků, ale firma bez tohoto obskurního kousku software prostě existovat nemůže.

Řešením může být využití virtuálního počítače, do nějž nainstalujete onen historický OS a aplikaci. Při správném nastavení může být uživatelský komfort podobný prostému spuštění programu a uživatel ani nemusí vědět, že má za zády virtualizační technologii.

### Školení a prezentace

Prostředí virtuálního počítače je stoprocentně kontrolované, opakovatelné a relativně nezávislé na vrtoších hardware. Proto se výtečně hodí na školení a předváděčky všeho druhu.

### Konsolidace serverů

Zatímco předchozí použití zahrnovalo spíše instalaci Virtual PC, pro serverové nasazení je určen Virtual Server. Z bezpečnostních a organizačních důvodů je rozumné, aby byly různé agendy provozovány na oddělených serverech. S ohledem na zvyšující se výkon jednotlivých počítačů a technologie jako dual core procesory postačuje výkon jednoho počítače pro několik virtuálních serverů.

Před nedávnem jsme dokončili konsolidaci serverů, kdy jsme deset fyzických serverů nahradili třemi a začali používat virtuální počítače (mimo jiné i web, který si právě prohlížíte, běží na virtuálu).

## Kdy virtuální počítače naopak nepoužívat

Obecně není dobrý nápad používatg virtuální počítače v případě, že vám hodně závisí na výkonu kde je velký počet I/O operací. Typicky například u databázových serverů a u hodně používaných poštovních serverů.

## Ke stažení

*   [Microsoft Virtual PC 2004 +SP1](http://www.microsoft.com/windows/virtualpc/downloads/sp1.mspx) 
*   [Microsoft Virtual Server 2005 R2](http://www.microsoft.com/windowsserversystem/virtualserver/software/default.mspx) 

*Příště se podíváme na Microsoft Virtual PC 2004, což je program pro "běžné uživatele" a virtualizaci na jejich pracovních stanicích. Do komentářů můžete psát dotazy a připomínky, budu na ně brát ohled při tvorbě dalších dílů tohoto seriálu.* 