<!-- dcterms:title = Instalace a konfigurace Kali Linuxu na Hyper-V -->
<!-- dcterms:abstract = Kali je speciální distribuce Linuxu pro bezpečnostní účely, penetrační testy a další bohulibé aktivity. Přináším návod, jak ji nainstalovat na Hyper-V a jak ji zkonfigurovat pro účely dema/labu. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20181007-kali-linux-na-hyperv.png -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = Bezpečnost -->
<!-- x4w:category = IT -->
<!-- x4w:category = Software -->
<!-- dcterms:date = 2018-10-07 -->

> **Tento text je zastaralý a ponechávám ho zde jenom pro informaci.** 
> K dispozici je [aktualizovaná verze článku](/2021/11/kali-linux-na-hyperv) z roku 2021 pro verzi Kali 2021.3a.

Kali je speciální distribuce Linuxu pro bezpečnostní účely, penetrační testy a další bohulibé aktivity. Často se používá jako "live" distribuce, která se neinstaluje, ale jenom se nahraje na DVD nebo USB disk a nabootuje. Já ji nicméně používám pro různá dema a laby a mám ji nainstalovanou ve virtualizační platformě Hyper-V.

Pro konkurenční platformy VMWare a VirtualBox jsou k dispozici přímo oficiální předinstalované images. Pro Hyper-V nic takového není a virtuálku si musíte vytvořit sami. Není to obtížné a nádavkem přidávám pár konfiguračních tipů. Takhle konfiguruji svoje Kali já pro účely výuky a dema. Samozřejmě pro praktické použití budete chtít postupovat jiným způsobem.

## Získání instalačního image a vytvoření Hyper-V VM

Instalační ISO image si stáhnete na webu [kali.org v sekci Downloads](https://www.kali.org/downloads/). Bude vás zajímat ten nejběžnější image - _Kali Linux 64 bit_. V době vydání článku je aktuální verze 2018.3a a můj návod se vztahuje právě k ní - postup je nicméně stejný již mnoho verzí a předpokládám, že bude aktuální i do budoucna.

![VM musí být "Generation 1"](https://www.cdn.altairis.cz/Blog/2018/20181007-kali-01.png)

Vytvoření VM je velmi jednoduché a v průvodci postupujte běžným způsobem. Jenom si dejte pozor, abyste vytvořili _Generation 1_ VM. Po vytvoření VM ji nabootuje z ISO image.

## Instalace operačního systému

![Kali Linux Boot Screen](https://www.cdn.altairis.cz/Blog/2018/20181007-kali-02.png)

Měla by se vám ukázat úvodní obrazovka s možnostmi umožňujícími spustit Kali jako live distribuci a nebo jej nainstalovat. Zvolte Graphical Install.

Občas se mi stává, že se boot screen zobrazí chybně - je tam jenom prázdný obrázek bez textu. V takovém případě pomáhá se odpojit (zavřít okno _Virtual Machine Connection_) a zase se připojit.

Samotnou instalaci OS nechávám s výchozími hodnotami, včetně regionálních nastavení (je to poněkud zmatené, takže všechno nechávám na English/US a měním dodatečně).

U Kali se vzhledem k jeho speciálnímu určení vesměs předpokládá, že budete pracovat jako `root` (administrátor), takže v rámci instalace zadávám jeho heslo a nevytvářím speciálního uživatele.

## Nastavení rozlišení

Po instalaci má počítač nastavené rozlišení 1152x864 (XGA+). Já Kali používám hodně pro prezentace a videa a tam se hodí širokoúhlé rozlišení - já používám 1280x720. Pro jeho nastavení je nutné editovat soubor `/etc/default/grub`. Najděte následující řádek:

    GRUB_CMDLINE_LINUX_DEFAULT="quiet"

a nahraďte jej tímto:

    GRUB_CMDLINE_LINUX_DEFAULT="quiet splash video=hyperv_fb:1280x720"

Poté spusťte příkaz `update-grub` a restartujte počítač.

## Nastavení automatického přihlašování

Pro dema se hodí mít nastavené automatické přihlašování. To zapnete tak, že editujete soubor `/etc/gdm3/daemon.conf`. Odstraněním `#` v něm odkomentujte následující řádky:

    AutomaticLoginEnable = true
    AutomaticLogin = root

To zařídí automatické přihlašování. Ještě je třeba zakázat automatické zamykání konzole a vypínání obrazovky. To se dá udělat ze systémového menu (šipka dolů vpravo nahoře):

* _Settings > Power > Blank screen_
* _Settings > Privacy > Screen lock_

## Regionální nastavení

Chci, aby na mne systém mluvil anglicky, ale abych měl českou QWERTY klávesnici, české formáty datumu a času a českou časovou zónu. To se dá opět udělat ze systémového menu v _Settings > Region & Language_.

## Nastavení pozadí

Všechny moje VM pro dema mají na pozadí vycentrované firemní logo a barvu, která je specifická pro dané VM, aby se daly snadno rozeznat. To je nejjednodušší nastavit z příkazové řádky následujícími příkazy:

    gsettings set org.gnome.desktop.background picture-uri "file:///root/Pictures/Wallpapers/Altairis-Background-for-Virtual-PC.png"
    gsettings set org.gnome.desktop.background picture-options "centered"
    gsettings set org.gnome.desktop.background primary-color "#F26631"