<!-- dcterms:title = Upgrade Ubuntu Linuxu z verze 22.04 LTS na verzi 24.04 LTS -->
<!-- dcterms:abstract = V dubnu vyšla další long term support (LTS) verze Ubuntu Linuxu 24.04. Naučím vás, jak na ni rychle a bezbolestně upgradovat z předchozí LTS verze 22.04. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/logo-ubuntu.svg -->
<!-- x4w:coverUrl = /cover-pictures/20240704-ubuntu-upgrade.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = IT -->
<!-- x4w:category = Lab -->
<!-- x4w:category = Linux -->
<!-- dcterms:date = 2024-07-04 -->
<!-- x4w:type = TMD -->

<!-- $ -->

V dubnu letošního roku vyšla nová verze Ubuntu LTS (Long Term Support), 24.04 (Noble Numbat). Pokud máte na svých serverech předchozí verzi 22.04 (Jammy Jellyfish) a chcete upgradovat, připravil jsem pro vás návod, jak na to.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/qNWe4UWGVOc" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

Upgrade není dnes nezbytně nutný, protože Ubuntu má podobnou politiku podpory jako Microsoft: LTS systémy jsou podporovány pět let od uvedení v režimu Standard Security Maintenance a dalších pět v Expanded Security Maintenance. Verze 22.04 bude podporována až do roku 2027, resp. 2032.

![](https://www.cdn.altairis.cz/Blog/2024/20240704-ubuntu-upgrade.png)

Podrobnější informace najdete na stránce [The Ubuntu lifecycle and release cadence](https://ubuntu.com/about/release-cycle), ze které jsem převzal i výše uvedený obrázek.
- - -
## Příprava
- - -
Před započetím prací se důrazně doporučuje provést zálohu systému.
- - -
Když se na svůj server přihlásíte, přivítá vás hlášení podobné následujícímu (část v závorce se může lišit):

    Welcome to Ubuntu 22.04.4 LTS (GNU/Linux 6.5.0-1023-azure x86_64)

Případně si můžete verzi vypsat příkazem `lsb_release -a`, který vypíše něco jako:

    Distributor ID: Ubuntu
    Description:    Ubuntu 22.04.4 LTS
    Release:        22.04
    Codename:       jammy

Pokud ve výpisu nevidíte verzi `22.04`, ale nějakou jinou, tento návod není pro vás.
- - -
Začněte tím, že následujícími příkazy aktualizujete všechny balíčky na nejnovější verzi pro stávající systém:

    sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get dist-upgrade

To bude, v závislosti na množství aktualizací a rychlosti vašeho připojení nějakou dobu trvat.
- - -
Je dobrý nápad server před aktualizací restartovat:

    sudo reboot now
- - -
## Nastavení firewallu
- - -
Canonical poněkud alibisticky nedoporučuje provádět upgrade systému na dálku, pomocí SSH. Nicméně v praxi vám často nic jiného nezbude, zejména u cloudových systémů. V průběhu instalace bude vytvořen záložní SSH server na portu `1022` (pro případ, že by ten standardní byl nedostupný). Nemáte-li přístup na konzoli serveru, je dobrý nápad povolit tento port na firewallu.

Pokud používáte UFW, můžete tak učinit následujícími příkazy:

    sudo ufw allow 1022/tcp
    sudo ufw reload

Pokud používáte Iptables, můžete totéž učinit následujícím příkazem:

    sudo iptables -I INPUT -p tcp --dport 1022 -j ACCEPT
- - -
(i)
Pokud váš server běží v cloudu, bude nejspíše nutné tento port povolit i na cloudovém firewallu. To ale teď nemusíte dělat, jenom na to pamatujte v případě, že by došlo k havárii a museli byste rento záložní SSH server skutečně využít.
- - -
## Upgrade
- - -
Upgrade spustíte následujícím příkazem:

    sudo do-release-upgrade -d
- - -
(i)
Pokud váš systém `do-release-upgrade` nezná, nainstalujte si balíček `ubuntu-release-upgrader-core`:

    sudo apt install ubuntu-release-upgrader-core

Poté příkaz spusťte znovu:

    sudo do-release-upgrade -d
- - -
Zobrazí se vám základní informace a otázka `Continue [yN]`. Odpovězte `y` a odešlete _Enter_.
- - -
Zobrazí se vám varování o nevhodnosti upgrade pomocí SSH. Na `Continue [yN]`. Odpovězte `y` a odešlete _Enter_.
- - -
Budete vyzváni k otevření portu `1022` na firewallu, což jste už udělali v předchozím kroku. Klepněte na _Enter_.
- - -
Vytvoří se seznam balíčků potřebných pro upgrade a vypíše se zpráva v následujícím duchu:


    Do you want to start the upgrade?


    2 installed packages are no longer supported by Canonical. You can
    still get support from the community.

    60 packages are going to be removed. 143 new packages are going to be
    installed. 609 packages are going to be upgraded.

    You have to download a total of 474 M. This download will take about
    1 minute with your connection.

    Installing the upgrade can take several hours. Once the download has
    finished, the process cannot be canceled.

    Continue [yN]  Details [d]

Odpovězte `y` a odešlete _Enter_.
- - -
Začne vlastní proces upgrade, který může trvat - jak vás předchozí zpráva varovala - i několik hodin, v závislosti na rychlosti vašeho serveru, připojení a množství balíčků.
- - -
(i)
V průběhu instalace můžete být dotázáni, zda chcete dříve modifikovaný soubor přepsat novou verzí. Můžete si nechat zobrazit porovnání změn (diff), ale pokud nevíte co odpovědět, většinou je bezpečnější nechat původní verzi.
- - -
Budete dotázáni, zda chcete odstranit zastaralé balíčky, čímž se mimo jiné uvolní místo na disku.

    Remove obsolete packages?


    106 packages are going to be removed.

    Removing the packages can take several hours.

    Continue [yN]  Details [d]

Odpovězte dle vlastního uvážení a odešlete _Enter_. Ačkoliv program varuje, že to může trvat několik hodin, většinou to bývá podstatně rychlejší, v řádu minut.
- - -
Pro dokončení upgrade je nutné restartovat počítač:

    System upgrade is complete.

    Restart required

    To finish the upgrade, a restart is required.
    If you select 'y' the system will be restarted.

    Continue [yN]

Odpovězte `y` a odešlete _Enter_.
- - -
Vyčkejte, dokud se server nerestartuje. 
- - -
Měli byste být přivítáni přibližně následujícím hlášením:

    Welcome to Ubuntu 24.04 LTS (GNU/Linux 6.8.0-1009-azure x86_64)

Proces upgrade byl úspěšně dokončen.
- - -
## Konfigurace firewallu
- - -
Můžete zrušit pravidlo na firewallu, které povolilo přístup na port 1022.

Pokud používáte UFW, můžete tak učinit následujícími příkazy:

    sudo ufw delete allow 1022/tcp
    sudo ufw reload

Pokud používáte Iptables, můžete totéž učinit následujícím příkazem:

    sudo iptables -D INPUT -p tcp --dport 1022 -j ACCEPT
    