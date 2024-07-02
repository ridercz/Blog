<!-- dcterms:title = Jak rozběhnout synchronizační software Syncthing na Windows i na Linuxu -->
<!-- dcterms:abstract = Na synchronizaci dat mezi počítači používám nástroj Syncthing. Na kanálu Z-TECH o něm vytvářím seriál a nabízím vám návod, jak ho rozběhnout na Windows i na Linuxu. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20240514-syncthing-linux.png -->
<!-- x4w:coverUrl = /cover-pictures/20240514-syncthing-linux.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = IT -->
<!-- dcterms:date = 2024-05-14 -->
<!-- x4w:category = Lab -->
<!-- x4w:category = Linux -->
<!-- x4w:type = TMD -->

<!-- $ -->
Na synchronizaci dat mezi počítači používám bezplatný a otevřený nástroj [Syncthing](https://syncthing.net/). Dříve jsem používal Resilio Sync, ale poté co změnili licenční politiku a pro běh na serverovém OS je třeba měsíční platba, přešel jsem právě na Syncthing. A na kanálu Z-TECH jsem o něm vytvořil seriál:

1. [Základní představení a instalace na Windows](https://youtu.be/khn4ki850nE)
2. [Instalace na Linux a Raspberry Pi](https://youtu.be/S9OFykSyvAU)
3. [Pokročilejší nastavení synchronizace](https://youtu.be/xdUcCBodx9s)
4. [Instalace na Windows jako služba](https://youtu.be/H2m47dAi9q4)

Instalace na Windows je poměrně přímočará, ale na Linuxu je to o něco složitější, je tam více manuálních kroků. Proto jsem připravil návod krok za krokem.

## Instalace aplikace Syncthing na Linuxu

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/S9OFykSyvAU" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

Tento návod popisuje, jak nainstalovat synchronizační software na Linux. Počítá s následujícími distribucemi, aktuálními ke dni vydání článku:

* **Ubuntu Linux** 24.04 LTS
* **Raspberry Pi OS** 2024-03-15 (Debian 12 - Bookworm)

Z mého pohledu je důležitá zejména instalace na Raspberry Pi, protože pomocí něj a externího disku (ukážu vám, jak ho zprovoznit) si můžete jednoduše vytvořit off-site zálohu. V práci, u známého, kdekoliv kde je připojení k Internetu, si můžete jednoduše vytvořit zálohovací server, který ochrání vaše data i v případě, že by primární lokace byla zničena, například požárem.

Návodů na zprovoznění Syncthingu na Linuxu jsem našel spoustu, ale mají z mého pohledu dvě zásadní vady z hlediska bezpečnosti:

* Syncthing běží pod rootem, nebo pod uživatelem s vysokými oprávněními. Můj návod počítá s vytvořením speciálního uživatele s nízkými právy.
* Jeho webové administrační rozhraní je dostupné přímo z vnější sítě (případně z Internetu). Můj návod schovává rozhraní za nginx proxy.
- - -
### Základní instalace
- - -
Připojte se na server z konzole nebo přes SSH.
- - -
Následujícími příkazy plně aktualizujte systém

    sudo apt-get update && sudo apt-get upgrade -y

Vyčkejte, dokud vše neproběhne, což může v závislosti na rychlosti vašeho připojení a počítače trvat i několik desítek minut.
- - -
### Instalace aplikace Syncthing
- - -
Přidejte klíč APT repository Syncthingu mezi důvěryhodné:

    curl -s https://syncthing.net/release-key.txt | gpg --dearmor | sudo tee /usr/share/keyrings/syncthing-archive-keyring.gpg >/dev/null
- - -
Přidejte repository do systému:

    echo "deb [signed-by=/usr/share/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list
- - -
Aktualizujte seznam dostupných balíčků:

    sudo apt-get update
- - -
Nainstalujte aplikaci Syncthing:

    sudo apt-get install syncthing -y
- - -
### Vytvoření uživatele

Chceme, aby aplikace běžela nikoliv pod rootem (nebo jiným uživatelem s vysokými právy), ale pod svým vlastním uživatelem `syncthing` s minimálními oprávněními.
- - -
Následujícím příkazem vytvoříte pro službu uživatele:

    sudo adduser --disabled-password --gecos "Syncthing service" syncthing
- - -
Přepněte se do kontextu tohoto uživatele:

    sudo su syncthing
- - -
Spusťte z konzole Syncthing, aby se vytvořila konfigurace:

    syncthing
- - -
Měli byste vidět log, zhruba jako na následujícím obrázku:

![](https://www.cdn.altairis.cz/Blog/2024/20240514-syncthing-01.png)

Ukončete aplikaci stiskem _Ctrl+C_.
- - -
Opusťte kontext uživatele služby:

    exit
- - -
### Konfigurace aplikace a registrace daemona

Protože budeme chtít webové rozhraní aplikace publikovat do Internetu pomocí nginxu, je třeba provést změnu v konfiguraci, aby fungovala publikace pomocí proxy. Také je nutné nastavit Syncthing jako daemona, automaticky spouštěnou aplikaci běžící na pozadí.
- - -
Otevřete konfigurační soubor v editoru Nano:

    sudo nano /home/syncthing/.local/state/syncthing/config.xml
- - -
Najděte v XML dokumentu element `/configuration/gui` a přidejte do něj následující element:

    <insecureSkipHostcheck>true</insecureSkipHostcheck>

![](https://www.cdn.altairis.cz/Blog/2024/20240514-syncthing-02.png)
- - -
Stiskem _Ctrl+S_ uložte změny a stiskem _Ctrl+X_ ukončete editor.
- - -
Vytvořte v editoru Nano soubor s definicí služby:

    sudo nano /lib/systemd/system/syncthing.service
- - -
Zadejte do něj následující text:

    [Unit]
    Description=Syncthing
    Documentation=man:syncthing(1)
    After=network.target

    [Service]
    User=syncthing
    WorkingDirectory=/home/syncthing
    ExecStart=/usr/bin/syncthing -no-browser -no-restart -logflags=0
    Restart=on-failure
    RestartSec=5
    SuccessExitStatus=3 4
    RestartForceExitStatus=3 4
    SyslogIdentifier=syncthing
    ProtectSystem=full
    PrivateTmp=true
    SystemCallArchitectures=native
    MemoryDenyWriteExecute=true
    NoNewPrivileges=true

    [Install]
    WantedBy=multi-user.target
- - -
Stiskem _Ctrl+S_ uložte změny a stiskem _Ctrl+X_ ukončete editor.
- - -
Následujícími příkazy službu zaregistrujte a nastartujte:

    sudo systemctl enable syncthing
    sudo systemctl start syncthing
- - -
Následujícím příkazem si ověřte, že úspěšně běží (je tam `Active: active (running)` jako na obrázku):

    sudo systemctl status syncthing

![](https://www.cdn.altairis.cz/Blog/2024/20240514-syncthing-03.png)
- - -
(i)
Nyní již Syncthing běží a mohli byste se k němu připojit pomocí adresy `http://127.0.0.1:8384` - ale jenom z lokálního počítače, ne zvenčí.
- - -
### Publikace pomocí nginxu

Nechceme, aby byl Syncthing do sítě (Internetu) vystaven přímo, ale prostřednictvím proxy nginx. Z bezpečnostních důvodů a i z důvodů praktických -- například je výrazně jednodušší nastavit automatické vystavení a obnovování HTTPS certifikátů od Let's Encrypt CA pro nginx než přímo pro Syncthing.
- - -
Nainstalujte nginx:

    sudo apt-get install nginx -y
- - -
Vytvořte v editoru Nano konfigurační soubor pro naši site:

    sudo nano /etc/nginx/sites-available/syncthing
- - -
Zadejte do něj následující obsah:

    server {
        listen 80;
        location / {
            proxy_pass http://localhost:8384;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection keep-alive;
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
        }
    }
- - -
Stiskem _Ctrl+S_ uložte změny a stiskem _Ctrl+X_ ukončete editor.
- - -
Zakažte výchozí demo site a povolte nově vytvořenou site pro Syncthing:

    sudo rm /etc/nginx/sites-enabled/default
    sudo ln /etc/nginx/sites-available/syncthing /etc/nginx/sites-enabled/syncthing
- - -
Reloadněte konfiguraci nginxu:

    sudo nginx -s reload
- - -
### Základní zabezpečení
- - -
Podívejte se v prohlížeči na IP adresu nebo název vašeho serveru. Zobrazí se vám webové GUI aplikace Syncthing:

![](https://www.cdn.altairis.cz/Blog/2024/20240514-syncthing-04.png)
- - -
<!-- #userinfo -->
V tomto okamžiku není nastaveno pro webové rozhraní žádné uživatelské jméno a heslo. 

1. Klepněte na odkaz _Settings_.
2. Vyberte záložku _GUI_.
3. Vyplňte požadované uživatelské jméno.
4. Vyplňte požadované heslo.
5. Klepněte na _Save_.

![](https://www.cdn.altairis.cz/Blog/2024/20240514-syncthing-05.png)
- - -
(!)
Po klepnutí na _Save_ se Syncthing restartuje, což chvíli trvá. Nenechte se zmást chybovými hlášeními jako například _502 Gateway Timeout_. Chvíli vyčkejte a obnovte stránku.
- - -
Nyní budete před vstupem do uživatelského rozhraní vyzváni k zadání jména a hesla, které jste zvolili v kroku [#userinfo].
- - -
Abychom zvýšili zabezpečení celého systému, nastavíme pravidla na firewallu tak, aby byly povoleny pouze vybrané porty. Nainstalujte Uncomplicated firewall (UFW):

    sudo apt-get install ufw -y
- - -
(i)
Instalace UFW není nezbytná, lze přímo konfigurovat iptables, ale to není dvakrát pohodlné, proto je lepší toto jednoduché rozhraní.
- - -
Následujícími příkazy povolíte porty 22, 80 a 443:

    sudo ufw allow 22/tcp
    sudo ufw allow 80/tcp
    sudo ufw allow 443/tcp
- - -
Následujícím příkazem firewall aktivujete:

    sudo ufw enable

Na dotaz `Command may disrupt existing ssh connections. Proceed with operation (y|n)?` odpovězte `y`.
- - -
Následujícím příkazem restartujte server a ověřte si, že všechny služby po rebootu řádně nastartovaly:

    sudo reboot now
- - -
### Instalace dalšího disku

Syncthing nám úspěšně běží a můžeme s ním běžným způsobem pracovat. Nicméně v případě Raspberry Pi máme k dispozici pouze úložiště na paměťové kartě, což není ideální. Následujícím postupem lze připojit k Raspberry externí disk pomocí USB a zpřístupnit ho pro použití Syncthingem.
- - -
(i)
Tento postup předpokládá, že disk je zcela nový, prázdný, bez partitions atd. Pokud tomu tak není, budete v kroku [#partition] muset nejprve smazat existující partitions.
- - -
Nejprve zjistěte, jak se váš disk systémově jmenuje. To záleží na mnoha okolnostech, ale typicky to bude `/dev/sda` (na Raspberry Pi, které nabootovalo z MicroSD karty a má připojený nový disk přes USB), `/dev/sdb` (na běžném PC, které má jeden systémový disk a jeden nový přes USB nebo SATA) a podobně.
- - -
(!)
Je velmi důležité si být jisti, že pracujete se správným diskem! Pokud budete příkazy volat proti špatnému disku, přijdete o veškerá data na něm!
- - -
Následujícím příkazem si vypište seznam všech disků:

    sudo fdisk -l
- - -
Najděte svůj disk. Poznáte jej podle velikosti (zde _931,51 GiB_) a modelu (zde _024 HN-M101MBB_). Pro náš případ se tento disk jmenuje `/dev/sda`.

![](https://www.cdn.altairis.cz/Blog/2024/20240514-syncthing-06.png)
- - -
(!)
Pokud se váš disk jmenuje jinak, musíte `/dev/sda` v následujících příkazech nahradit za váš název.
- - -
Spusťte interaktivní aplikaci pro vytvoření partitions cfdisk:

    sudo cfdisk /dev/sda
- - -
Jako label type zvolte výchozí hodnotu `gpt` (stačí stisknout _Enter_).

![](https://www.cdn.altairis.cz/Blog/2024/20240514-syncthing-07.png)
- - -
<!-- #partition -->
Pokud je váš disk prázdný, uvidíte pouze informaci _Free space_. Pokud by na něm byly partitions, musíte všechny smazat (_Delete_), dokud se do tohoto stavu nedostanete.

![](https://www.cdn.altairis.cz/Blog/2024/20240514-syncthing-08.png)
- - -
Šipkami vyberte _New_ a klepněte na _Enter_.
- - -
Potvrďte výchozí velikost (použije se celý disk) tím, že klepnete na _Enter_.
- - -
Vyberte _Write_. Na otázku _Are you sure you want to write the partition table to disk?_ odpovězte `yes` a _Enter_.
- - -
Podívejte se, jak se jmenuje nově vytvořená partition. Zde `/dev/sda1`. Poté vyberte _Quit_ a ukončete cfdisk.

![](https://www.cdn.altairis.cz/Blog/2024/20240514-syncthing-09.png)
- - -
(!)
Pokud se vaše partition jmenuje jinak, musíte `/dev/sda1` v následujících příkazech nahradit za váš název.
- - -
Následujícím příkazem partition naformátujte na souborový systém EXT4. První parametr (`-L /syncthing-data`) je label disku, který může být jakýkoliv. Druhý parametr je název partition zjištěný v předchozím kroku.

    sudo mkfs.ext4 -L /syncthing-data /dev/sda1
- - -
(i)
Pokud budete vyzváni k přepsání existující partition, odpovězte `y` a _Enter_. Formátování bude chvíli trvat, buďte trpěliví.
- - -
Vytvořte prázdný adresář `/syncthing-data`:

    sudo mkdir /syncthing-data
- - -
Přimountujte novou partition do tohoto adresáře:

    sudo mount /dev/sda1 /syncthing-data
- - -
(i)
Nyní je váš disk dostupný pro operační systém. Můžete se o tom přesvědčit příkazem `ls -la /syncthing-data`. Pokud je vše správně, uvidíte tam systémový adresář `lost+found`.
- - -
Učiňte uživatele `syncthing` vlastníkem adresáře a tedy celého disku:

    sudo chown -R syncthing: /syncthing-data
- - -
Zakažte přístup komukoliv kromě vlastníka:

    sudo chmod go-rwx /syncthing-data
- - -
Nyní všechno funguje, ale po rebootu přestane. Aby byl disk funkční i po restartu (automaticky se přimountoval), editujte soubor `/etc/fstab`:

    sudo nano /etc/fstab
- - -
Přidejte na konec souboru následující řádek (oddělovač je tabulátor):

    /dev/sda1       /syncthing-data ext4    defaults        0       0

![](https://www.cdn.altairis.cz/Blog/2024/20240514-syncthing-10.png)
- - -
Stiskem _Ctrl+S_ uložte změny a stiskem _Ctrl+X_ ukončete editor.
- - -
Následujícím příkazem restartujte server:

    sudo reboot now
- - -
Po restartu se přesvědčte, že je disk řádně namountován (uvidíte v něm jako root adresář `lost+found`). Pokud ano, můžete nový disk zdárně používat v aplikaci Syncthing.