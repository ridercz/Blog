<!-- dcterms:title = Instalace a konfigurace Kali Linuxu na Hyper-V -->
<!-- dcterms:abstract = Kali je speciální distribuce Linuxu pro bezpečnostní účely, penetrační testy a další bohulibé aktivity. Přináším návod, jak ji nainstalovat na Hyper-V a jak ji zkonfigurovat pro účely dema/labu. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20181007-kali-linux-na-hyperv.png -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20211127-kali-linux-na-hyperv.jpg -->
<!-- x4w:category = Bezpečnost -->
<!-- x4w:category = IT -->
<!-- x4w:category = Software -->
<!-- dcterms:date = 2021-11-27 -->

Kali je speciální distribuce Linuxu pro bezpečnostní účely, penetrační testy a další bohulibé aktivity. Často se používá jako "live" distribuce, která se neinstaluje, ale jenom se nahraje na DVD nebo USB disk a nabootuje. Já ji nicméně používám pro různá dema a laby a mám ji nainstalovanou ve virtualizační platformě Hyper-V.

Pro konkurenční platformy VMWare a VirtualBox jsou k dispozici přímo oficiální předinstalované images. Pro Hyper-V nic takového není a virtuálku si musíte vytvořit sami. Není to obtížné a nádavkem přidávám pár konfiguračních tipů. Takhle konfiguruji svoje Kali já pro účely výuky a dema. Samozřejmě pro praktické použití budete chtít postupovat jiným způsobem.

## Získání instalačního image a vytvoření Hyper-V VM

Instalační ISO image si stáhnete na webu [kali.org v sekci Downloads](https://www.kali.org/downloads/). Zvolte si možnost [Bare Metal](https://www.kali.org/get-kali/#kali-bare-metal) a stáhněte si image NetInstaller. Ten má jenom asi 50 MB a vše potřebné si stáhne až při instalaci. Můžete si stáhnout i kompletní instalační image, který má 3,2 GB. V době vydání článku je aktuální verze 2021.3a a můj návod se vztahuje právě k ní - postup je nicméně stejný již mnoho verzí a předpokládám, že bude aktuální i do budoucna.

![VM musí být "Generation 1"](https://www.cdn.altairis.cz/Blog/2018/20181007-kali-01.png)

Vytvoření VM je velmi jednoduché a v průvodci postupujte běžným způsobem. Jenom si dejte pozor, abyste vytvořili _Generation 1_ VM. Po vytvoření VM ji nabootuje z ISO image.

## Instalace operačního systému

![Kali Linux Boot Screen](https://www.cdn.altairis.cz/Blog/2018/20181007-kali-02.png)

Měla by se vám ukázat úvodní obrazovka s možnostmi umožňujícími spustit Kali jako live distribuci a nebo jej nainstalovat. Zvolte Graphical Install.

Občas se mi stává, že se boot screen zobrazí chybně - je tam jenom prázdný obrázek bez textu. V takovém případě pomáhá se odpojit (zavřít okno _Virtual Machine Connection_) a zase se připojit.

Samotnou instalaci OS nechávám s výchozími hodnotami, včetně regionálních nastavení (je to poněkud zmatené, takže všechno nechávám na English/US a měním dodatečně).

U živé distribuce Kali se vzhledem k jejímu speciálnímu určení vesměs předpokládá, že budete pracovat jako `root` (administrátor), ale při instalaci budete vyzváni k zadání jména a hesla non-root uživatele.

## Nastavení rozložení klávesnice

V systémovém menu vyberte _Settings > Keyboard_. Na záložce Layout zakažte _Use system defaults_ a v části _Keyboard layout_ klepněte na _Edit_ a vyberte požadované rozložení klávesnice.

## Instalace nástrojů

Současná verze Kali je "štíhlejší" než byly verze předchozí. Pokud chcete nainstalovat sadu stejných nástrojů, jaká byla výchozí v předchozí verzi, můžete tak učinit následujícím příkazem:

```bash
sudo apt-get update && sudo apt-get install kali-linux-large -y
```
Podrobnější informace o metapackages najdete v [dokumentaci Kali](https://www.kali.org/docs/general-use/metapackages/).

## Nastavení rozlišení

Po instalaci má počítač nastavené rozlišení 1152x864 (XGA+). Já Kali používám hodně pro prezentace a videa a tam se hodí širokoúhlé rozlišení - já používám 1280x720. Pro jeho nastavení je nutné (jako root) editovat soubor `/etc/default/grub`. Najděte následující řádek:

    GRUB_CMDLINE_LINUX_DEFAULT="quiet"

a nahraďte jej tímto:

    GRUB_CMDLINE_LINUX_DEFAULT="quiet splash video=hyperv_fb:1280x720"

Poté spusťte příkaz `sudo update-grub` a restartujte počítač příkazem `sudo reboot`.

> Postupem popsaným v článku [Installing Hyper-V Enhanced Session Mode](https://www.kali.org/docs/virtualization/install-hyper-v-guest-enhanced-session-mode/) by mělo být možné nastavit podporu Enhanced Session v Hyper-V, což by umožnilo nastavení rozlišení z klienta. To se mi ale nikdy nepodařilo rozchodit.

## Nastavení automatického přihlašování

Pro dema se hodí mít nastavené automatické přihlašování. To zapnete tak, že editujete soubor `/etc/lightdm/lightdm.conf`. 

Najděte sekci `[Seat:*]` a najděte následující řádky:

    #autologin-user=
    #autologin-user-timeout=

Změňte je následujícím způsobem (místo _developer_ napište jméno svého uživatele):

    autologin-user=developer
    autologin-user-timeout=0

Dále pak jako root editujte soubor `/etc/pam.d/lightdm-autologin`. Najděte v něm následující řádek:

    auth required pam_succeed_if.so user != root quiet_success

a zakomentujte ho tím, že před něj napíšete `#`:

    #auth required pam_succeed_if.so user != root quiet_success

To zařídí automatické přihlašování. Vyzkoušejte to tím, že restartujete počítač.

## Zákaz zamykání konzole a vypínání obrazovky

Ještě je třeba zakázat automatické zamykání konzole a vypínání obrazovky. To se dá udělat ze systémového menu (logo Kali vlevo nahoře) vyberete _Settings > Power Manager_.

* Na záložce _Display_ vypněte _Display power management_ a přetáhněte slider _Blank after_ úplně doleva (na _Never_).
* Na záložce _Security_ nastavte _Automatically lock the session_ na _Never_.

> Pokud se vám zdá, že jste podobný článek již v minulosti četli, tak se vám to nezdá. O instalaci Kali na Hyper-V jsem už psal [v říjnu 2018](/2018/10/kali-linux-na-hyperv). Toto je verze aktualizovaná pro Kali 2021.3a.