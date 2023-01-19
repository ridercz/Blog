<!-- dcterms:title = Hyper-V: Velmi jemný úvod do virtualizace na Windows -->
<!-- dcterms:abstract = Většina serverů jejichž služby využíváte je nejspíš virtualizovaná. Jejich software neběží přímo na hardware, ale ve virtuálním, emulovaném počítači, který umožňuje na jednom fyzickém hardware provozovat několik logických serverů. Děje se tak z důvodu snazší správy i z důvodů ekonomických, umožňuje to lépe využívat dostupný výpočetní výkon. Na Z-TECHu jsem pro vás připravil seriál o virtualizační platformě Hyper-V, která je součástí Windows. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:coverUrl = /cover-pictures/20221120-hyperv.jpg -->
<!-- x4w:pictureUrl = /perex-pictures/20221120-hyperv.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = Z-TECH -->
<!-- x4w:category = IT -->
<!-- dcterms:date = 2022-11-19 -->

Většina serverů jejichž služby využíváte je nejspíš virtualizovaná. Jejich software neběží přímo na hardware, ale ve virtuálním, emulovaném počítači, který umožňuje na jednom fyzickém hardware provozovat několik logických serverů. Děje se tak z důvodu snazší správy i z důvodů ekonomických, umožňuje to lépe využívat dostupný výpočetní výkon. 

Světovým leaderem je společnost VMWare, která nabízí několik virtualizačních řešení pro různé účely. Druhá příčka patří Hyper-V od Microsoftu a další hráči jsou třeba Xen, Proxmox, VirtualBox a další. Na Z-TECHu jsem pro vás připravil seriál o virtualizační platformě Hyper-V, která je součástí Windows.

## K čemu virtualizace

**Serverová virtualizace** se používá pro dříve zmíněný účel, totiž pro efektivnější nasazení serverů v produkci. Nás bude ale zajímat spíše **klientská virtualizace**, která se používá zejména pro různé pokusy a testování. Pomocí ní můžete vybudovat na svém počítači celou serverovou farmu a vyzkoušet si na ní cokoliv potřebujete, aniž byste k tomu potřebovali rozsáhlou infrastrukturu. 

Virtualizace nabízí kromě té základní funkčnosti - více počítačů schovaných v jednom - i další možnosti, které se pro testování hodí. Třeba možnost pomocí checkpointů (snapshotů) zaznamenat stav virtuálního počítače a pak se k němu kdykoliv zpětně vrátit.

Virtualizaci využívá i [Windows Sandbox](/2022/11/sandbox), o kterém už na tomto blogu byla řeč a pro jednodušší scénáře dostatečně vyhoví. Pokud chcete mít vše pod lepší kontrolou a také větší možnosti, potřebujete plnokrevnou virtualizační platformu. Ta vám umožní protozovat třeba i jiný operační systém. Na klientských Windows 10 nebo 11 můžete provozovat třeba serverová Windows anebo i úplně jiné operační systémy, jako třeba různé distribuce Linuxu.

## Začínáme s Hyper-V

K tomu, abyste mohli používat Hyper-V potřebujete _Pro_ verzi Windows, na _Home_ edicích neběží. Dále pak potřebujete 64-bitový procesor s podporou Second Level Address Translation (SLAT) a VM Monitor Mode Extension (například Intel VT-x). Hodí se dostatek paměti a velké rychlé disky. Co je _dostatek_ záleží na tom, jaké VM budete chtít rozjíždět a kolik jich bude, protože ty se do té paměti a na disky musejí vměstnat.

S podporovaným procesorem již problém nejspíš nebude, pokud nemáte opravdu historický stroj, ale možná budete muset potřebné funkce (podporu virtualzace a Data Execution Prevention) povolit v nastavení počítače (BIOS/UEFI), některé starší desky to mají v základu vypnuté. Potíž je, že se to u každé desky dělá a také jmenuje jinak.

## Seriál o Hyper-V

Připravil jsem pro vás seriál, který vám ukáže, jak na Hyper-V rozjet virtuální testovací laboratoř, ve které budete mít vše pod kontrolou, včetně sítě a certifikační autority:

* **[Instalace a vytvoření virtuálního stroje](https://www.youtube.com/watch?v=Y1MeiiiiZPE)** - Samotný začátek, jak Hyper-V nainstalovat a vytvořit virtuální počítač a nainstalovat do něj operační systém.
* **[Routování vnitřní sítě pomocí pfSense](https://www.youtube.com/watch?v=lnaqTBVs9E8)** - C když chcete svou virtuální síť mít pod kontrolou? Jaké bude mít IP adresy, DNS, jak se bude routovat do Internetu a podobně. V takovém případě si musíte do virtuálního prostředí nainstalovat router a zkonfigurovat ho. Ukážu vám, jak to můžete udělat pomocí programu pfSense: malého virtuálního stroje, který můžete konfigurovat pomocí webového rozhraní, podobně jako třeba domácí router.
* **[Certifikační autorita pomocí pfSense](https://www.youtube.com/watch?v=cKmIoaZ7lk4)** - Chceme-li dnes vytvořit izolovanou síť na dema a testování, potřebujeme též certifikační autoritu, kterou máme pod kontrolou. Naštěstí pfSense umí jednoduchou CA vytvořit a provozovat na pár kliknutí.
* **[Checkpoints](https://www.youtube.com/watch?v=Gt2UjPN6csI)** - Výhodou virtuálních počítačů proti fyzickým je, že jejich emulovaný stav máme plně pod kontrolou. Můžeme tedy libovolný okamžik jejich existence "zmrazit" pomocí checkpointu a pak se k němu kdykoliv vrátit zpět. Tato funkce je užitečná zejména pro testování a dema.
* **[Export a import virtuálního počítače](https://www.youtube.com/watch?v=eEOpva4rtd4)** - Jak vlastně vypadá Hyper-V virtuální počítač na disku hostitelského serveru? Jako sbírka obyčejných souborů s obsahem pevného disku a konfiguračními informacemi. Chcete-li VM přesunout nebo zkopírovat jinam, stačí zkopírovat tyto soubory. Ale mnohem lepší je použít systemizovanou funkci pro import a export.
* **[Virtuální hard disky](https://www.youtube.com/watch?v=LqtvOTZhFgE)** - Pevné disky virtuálních počítačů jsou v Hyper-V reprezentovány prostřednictvím souborů ve formátu VHD/VHDX. Windows tento formát používají nejenom pro virtualizaci, ale třeba i pro zálohování a podobně. Ukážu vám, jak můžete s VHDX soubory pracovat ve Windows a také jak můžete přimountovat jiné obrazy disků a virtuální disky.