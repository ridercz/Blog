<!-- dcterms:title = MQTT server do kapsy: Mosquitto na Orange Pi Zero -->
<!-- dcterms:abstract = Na IoT mi vadí hlavně to první písmenko - Internet. Nevidím důvod, proč by při budování "chytré domácnosti" měla vnitřní komunikace být závislá na externí internetové službě - a na připojení k Internetu vůbec. Základem pro komunikaci (nejen) IoT komponent je protokol MQTT. Rozhodl jsem si tedy postavit vlastní MQTT server na bázi Orange Pi Zero, miniaturního počítače s ARM. Přináším vám kompletní návod. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:coverUrl = /cover-pictures/20200120-mqtt-do-kapsy.jpg -->
<!-- x4w:pictureUrl = /perex-pictures/20200120-mqtt-do-kapsy.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = IT -->
<!-- x4w:category = Bastlení -->
<!-- x4w:category = Bezpečnost -->
<!-- dcterms:dateAccepted = 2020-01-20 -->

Na IoT mi vadí hlavně to první písmenko - Internet. Nevidím důvod, proč by při budování "chytré domácnosti" měla vnitřní komunikace být závislá na externí internetové službě - a na připojení k Internetu vůbec. Základem pro komunikaci (nejen) IoT komponent je protokol MQTT. Rozhodl jsem si tedy postavit vlastní MQTT server na bázi Orange Pi Zero, miniaturního počítače s ARM.

## Co je Orange Pi Zero

![](https://www.cdn.altairis.cz/Blog/2020/20200120-orangepizero.png)

Předpokládám že znáte [Raspberry Pi](https://www.raspberrypi.org), malý a levný počítač s ARM procesorem, na kterém může běžet Linux nebo jiné operační systémy. Řada [Orange Pi](http://www.orangepi.org) je něco podobného. Budu používat model [Orange Pi Zero](https://www.orangepi.org/orangepizero), což je ten úplně nejmenší a nejlevnější model, stojí okolo deseti dolarů.

Jeho hardwarové charakteristiky nejsou nijak úchvatné: Procesor Allwinner H2 se čtyřmi jádry ARM Cortex-A7, 256 nebo 512 MB DDR3 SDRAM, jeden USB 2.0 port, jeden MicroUSB pro napájení, RJ45 Ethernet 10/100M, slot na MicroSD kartu a WiFi. Na rozdíl od vyšších modelů (a třeba Raspberry Pi) nemá konektory pro zvukový nebo grafický výstup. Sice jsou k dispozici na zvláštní rozšiřující desce, ale obecně je tento počítač určený spíše pro headless aplikace.

Mám ho tady už několik let, navrhl jsem na něj dokonce i [krabičku](https://www.prusaprinters.org/prints/8653-compact-and-secure-orange-pi-zero-case), vyzkoušel jsem ho, ale pořád jsem nevěděl co s ním. Myslím že pro MQTT server bude zcela ideální.

## Co je MQTT?

[MQTT](http://mqtt.org/) (MQ Telemetry Transport) je komunikační protokol, který se používá v IoT sítích a nejen tam. Historicky vznikl v roce 1999 pro potřeby monitorování zařízení na ropovodech v poušti. Dokáže si poradit s pomalým spojením s vysokou latencí (např. satelitním), je to velice jednoduchý protokol přinášející minimální overhead. Právě proto je populární pro IoT.

Existuje mnoho MQTT brokerů (serverů) a klientů. Já budu používat [Mosquitto](https://www.mosquitto.org/), což je jednoduchý multiplatformní open source broker.

## Základní nastavení Armbianu

Kroky v této části nemají nic společného s Mosquittem nebo MQTT. Jde o obecný postup sloužící k nastavení a základnímu zabezpečení v zásadě jakéhokoliv serveru na Linuxu.

### Příprava SD karty

Jako operační systém budu používat [Armbian](https://www.armbian.org/), což je ARM klon Debianu. Je udržovaný a desky Orange Pi patří k [oficiálně podporovaným](https://www.armbian.com/orange-pi-zero/). Z webu Armbianu jsem si tedy stáhl aktuální image Armbian Buster.

![](https://www.cdn.altairis.cz/Blog/2020/20200120-rufus.png)

Image je třeba nahrát na MicroSD kartu o velikosti nejméně 2 GB. K tomu používám utilitu [Rufus](https://rufus.ie/), ale můžete použít cokoliv pro práci s obrazy disků, populární je třeba [Win32DiskImager](http://sourceforge.net/projects/win32diskimager/) nebo multiplatformní [balenaEtcher](https://www.balena.io/etcher/).

### První boot a přihlášení

První boot nějakou dobu trvá, protože se při něm zvětšují partitions, generují se SSH klíče dělají a další věci, takže buďte trpěliví. Zjistěte, jakou IP adresu přidělil váš DHCP server klientovi. Já jsem mu rovnou nastavil přes DHCP rezervaci a nasměroval na něj DNS jméno, řekněme `mqtt.example.com`.

Připojte se pomocí příkazu SSH, který je součástí aktuální verze Windows 10 nebo pomocí jiného SSH klienta:

    ssh root@mqtt.example.com

Při prvním připojení budete vyzváni k ověření SSH klíče serveru. Pokud by se v budoucnu změnil, budete varováni - obvykle to věští něco nekalého.

    The authenticity of host 'mqtt.example.com (10.7.2.17)' can't be established.
    ECDSA key fingerprint is SHA256:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx.
                                    
    Are you sure you want to continue connecting (yes/no)? yes
    Warning: Permanently added 'mqtt.example.com,10.0.0.1' (ECDSA) to the list of known hosts.

Výchozí heslo uživatele `root` je `1234` a po prvním přihlášení si ho musíte změnit:

    You are required to change your password immediately (administrator enforced)
     ____  ____  _   _____
    /  _ \|  _ \(_) |__  /___ _ __ ___
    | | | | |_) | |   / // _ \ '__/ _ \
    | |_| |  __/| |  / /|  __/ | | (_) |
    \____/|_|   |_| /____\___|_|  \___/

    Welcome to Armbian buster with Linux 5.4.8-sunxi

    System load:   0.00 0.00 0.00   Up time:       1:05 hour
    Memory usage:  29 % of 238MB    Zram usage:    17 % of 119Mb    IP:            10.0.0.1
    CPU temp:      50°C
    Usage of /:    7% of 15G

    New to Armbian? Check the documentation first: https://docs.armbian.com
    Changing password for root.
    Current password: 1234
    New password: ********
    Retype new password: ********


    Thank you for choosing Armbian! Support: www.armbian.com

Zároveň jste vyzváni k vytvoření běžného ne-administrátorského uživatele, což sice není povinné, ale je to dobrý nápad, takže vám to vřele doporučuji:

    Creating a new user account. Press <Ctrl-C> to abort

    Please provide a username (eg. your forename): altair
    Trying to add user altair
    Adding user `altair' ...
    Adding new group `altair' (1000) ...
    Adding new user `altair' (1000) with group `altair' ...
    Creating home directory `/home/altair' ...
    Copying files from `/etc/skel' ...
    New password: ********
    Retype new password: ********
    passwd: password updated successfully
    Changing the user information for altair
    Enter the new value, or press ENTER for the default
            Full Name []: Michal Altair Valasek
            Room Number []:
            Work Phone []:
            Home Phone []:
            Other []:
    Is the information correct? [Y/n]

    Dear Michal Altair Valasek, your account altair has been created and is sudo enabled.
    Please use this account for your daily work from now on.

Ukončete SSH session příkazem `exit` a znovu se přihlašte, tentokrát jako nově vytvořený uživatel (zde `altair`):

    ssh altair@mqtt.example.com

### Nastavení přihlášení pomocí klíče

Přihlašování pomocí hesel není ani pohodlné ani bezpečné. Mnohem lepší je vygenerovat si SSH klíče a přihlašovat se pomocí nich. Pokud ještě žádné nemáte, vygenerujte si je (na klientovi, ne na serveru) pomocí příkazu `ssh-keygen`. Vygenerované klíče najdete v `%USERPROFILE%\.ssh` a bezodkladně je zálohujte.

Na serveru pomocí následujících příkazů vytvořte soubor `~/.ssh/authorized_keys`:

    mkdir ~/.ssh
    nano ~/.ssh/authorized_keys

Do souboru zkopírujte obsah souboru `%USERPROFILE%\.ssh\id_rsa.pub`. Měl by vypadat nějak takto:

    ssh-rsa xxxxxxxxxx uzivatel@POCITAC

Stiskem _Ctrl+S_ soubor uložte a stiskem _Ctrl+X_ ukončete editor Nano. Následujícími příkazy nastavte práva na tyto soubory tak, abyste se k nim dostali jenom vy:

    chmod 700 ~/.ssh
    chmod 600 ~/.ssh/authorized_keys

Příkazem `exit` se odhlašte a znovu se přihlašte. Pokud jste udělali všechno správně, nebudete tázáni na heslo a budete automaticky přihlášeni pomocí klíče (pokud jste při generování klíče zadali heslo, budete tázáni na toto heslo ke klíči, lokální).

Pozor! Své přihlašovací heslo nezapomínejte! Budete ho moci použít pro přihlášení z konzole (ne po síti) a bude potřeba pro příkaz `sudo`.

### Základní konfigurace

Následujícím příkazem spusťte konfigurační utilitu Armbian Config:

    sudo armbian-config

![](https://www.cdn.altairis.cz/Blog/2020/20200120-armbian-config.png)

V části _System_ - _SSH_ zakažte přihlášení uživatele `root` a přihlašování pomocí hesla, povolte jenom přihlášení pomocí klíče:

![](https://www.cdn.altairis.cz/Blog/2020/20200120-armbian-config-ssh.png)

V části _Personal_ můžete nastavit časovou zónu. Výchozí je _UTC_, pravděpodobně budete chtít _Europe/Prague_. OPi Zero nemá zálohované hodiny reálného času a čas si načítá přes NTP ze sítě.

Nejspíš budete chtít změnit i název serveru (hostname) z výchozího `orangepizero`.

Následujícím příkazem aktualizujte systém:

    sudo apt-get update && sudo apt-get upgrade -y

Počítejte s tím, že to bude chvíli trvat, v závislosti na rychlosti sítě, množství aktualizací a rychlosti SD karty.

### Nastavení firewallu

Z hlediska bezpečnosti je dobré nastavit firewall tak, aby odmítal všechna spojení zvenčí, s výjimkou výslovně povolených. K tomu použijeme nástroj UFW (Uncomplicated Firewall).

Ten není standardní součástí instalace, takže ho musíme nejprve nainstalovat:

    sudo apt-get install ufw -y

Poté povolte OpenSSH a firewall aktivujte. Celé generace správců by mohly vykládat o tom, jak nemoudré je nastavovat pravidla na firewallu po síti, ale nám nic jiného nezbývá. Proto na otázku, zda chcete UFW opravdu povolit, odpovězte `y`:

    sudo ufw allow OpenSSH
    sudo ufw enable

## Mosquitto

V této části nainstalujeme a zabezpečíme MQTT broker Mosquitto.

### Instalace a otestování funkčnosti

Mosquitto nainstalujte pomocí následujícího příkazu:

    sudo apt-get install mosquitto mosquitto-clients -y

Následujícím příkazem se přihlašte k odběru topicu `test`. Příkaz zdánlivě nic neudělá a zůstane "viset". Čeká totiž na příchozí zprávy.

    mosquitto_sub -h localhost -t test

Otevřete si druhé SSH spojení na stejný server a v něm zadejte následující příkaz:

    mosquitto_pub -h localhost -t test -m "Hello, World!"

Zaslaná zpráva `Hello, World!` se zobrazí v prvním okně. Tam můžete ukončit `mosquitto_sub` stiskem _Ctrl+C_ a druhé okno zavřít.

### Nastavení autentizace

Nyní je server zcela otevřený, tj. kdokoliv může bez omezení jako anonym posílat a číst jakékoliv zprávy, což nejspíše nechcete. Zkonfigurujeme server tak, aby pro přístup vyžadoval heslo.

Následujícími příkazy vytvoříte konfigurační soubor s uživateli a vytvoříte uživatele `developer` s heslem `pass.word123`:

    sudo cp /dev/null /etc/mosquitto/passwd
    sudo mosquitto_passwd -b /etc/mosquitto/passwd developer pass.word123

Dále vytvořte soubor `/etc/mosquitto/conf.d/default.conf` a otevřete jej v editoru Nano:

    sudo nano /etc/mosquitto/conf.d/default.conf

Zadejte do něj následující obsah, kterým zakážete anonymní připojení a specifikujete, ze kterého souboru se mají brát uživatelé a hesla:

    allow_anonymous false
    password_file /etc/mosquitto/passwd

Stiskem _Ctrl+S_ soubor uložte a stiskem _Ctrl+X_ ukončete editor Nano. Následujícím příkazem restartujte Mosquitto:

    sudo systemctl restart mosquitto

Pokud nyní budete chtít číst nebo posílat zprávy, musíte k příkazům `mosquitto_sub` a `mosquitto_pub` přidat parametry `-u` a `-P` (case sensitive), pomocí kterých určíte jmého a heslo, například:

    mosquitto_sub -h localhost -t test -u developer -P pass.word123

Pokud chcete Mosquitto zpřístupnit ze sítě pomocí nešifrovaného spojení (což může a nemusí být dobrý nápad, v závislosti na tom, jaké použití plánujete), můžete tak učinit na firewallu následujícím příkazem:

    sudo ufw allow 1883

### Získání TLS certifikátu od Let's Encrypt

#### Ověření pomocí HTTP challenge

Pokud by na port 80 našeho MQTT serveru byl přímý přístup zvenčí, použil bych nástroj [CertBot](https://certbot.eff.org) od [Electronic Frontier Foundation](https://www.eff.org/):

    # Nainstalovat CertBot
    sudo add-apt-repository ppa:certbot/certbot -y
    sudo apt-get update
    sudo apt-get install certbot -y

    # Povolit na firewallu port 80 pro HTTP challenge
    sudo ufw allow HTTP

    # Požádat o certifikát
    sudo certbot certonly --standalone --preferred-challenges http-01 -d mqtt.example.com

Poté bych ještě nastavil cron (správce načasovaných úloh) tak, aby každý den v pět ráno obnovil certifikáty, u nichž je to třeba. Pomocí příkazu `sudo crontab -e` bych spustil editaci seznamu úloh a na konec souboru bych přidal následující řádky:

    # Renew certificates using CertBot every day at 05:00
    0 5 * * * certbot renew --noninteractive --post-hook "systemctl restart mosquitto"

#### Ověření pomocí DNS challenge

Ve chvíli, kdy nelze HTTP challenge použít, je nutné ověření realizovat pomocí DNS. Což může být jednoduché nebo komplikované, v závislosti na tom, jaké DNS servery používáte. Já mám své domény u společnosti [CloudFlare](https://www.cloudflare.com/), jejichž API je v CertBotu podporováno. Bohužel ale CertBot vyžaduje příliš vysoká oprávnění do CloudFlare, protože pracuje s jejich starším API. Proto používám jiného klienta, který se jmenuje [Lego](https://go-acme.github.io/lego/).

Nejprve je nutné získat API tokeny od Cloudflare. Budeme potřebovat dva: jeden pro výpis seznamu zón a druhý pro práci s DNS záznamy v konkrétní zóně.

Tokeny můžete generovat ve svém profilu v sekci [API Tokens](https://dash.cloudflare.com/profile/api-tokens). Začněte tím, že klepnete na tlačítko _Create Token_:

![](https://www.cdn.altairis.cz/Blog/2020/20200120-cf1.png)

Token pojmenujte _MQTT-ListZones_ a nastavte práva _Zone / Zone / Read_ pro všechny zóny a klepněte na _Continue to summary_:

![](https://www.cdn.altairis.cz/Blog/2020/20200120-cf2.png)

Klepněte na _Create Token_ a poznamenejte si vygenerovaný token - vidíte ho poprvé a naposledy. Stejným způsobem vygenerujte token jménem _MQTT-EditDNS_ a nastavte mu práva _Zone / DNS / Edit_ pro konkrétní zónu (doménu) kterou chcete spravovat:

![](https://www.cdn.altairis.cz/Blog/2020/20200120-cf3.png)

Bohužel, v repozitáři je historická verze, pročež je nutné nainstalovat aktuální binárku ručně. Na stránce [releases](https://github.com/go-acme/lego/releases) najděte adresu distribučního balíčku aktuální verze pro architekturu `linux_armv7`. V době psaní tohoto článku je to verze 3.3.0. Odpovídajícím způsobem pak upravte příkazy níže, kterými Lego stáhnete a nainstalujete do cesty `/opt/lego/lego`:

    sudo su
    mkdir /root/lego
    cd /root/lego
    wget https://github.com/go-acme/lego/releases/download/v3.3.0/lego_v3.3.0_linux_armv7.tar.gz
    tar zxf lego_v3.3.0_linux_armv7.tar.gz
    rm lego_v3.3.0_linux_armv7.tar.gz
    mkdir /opt/lego
    mv * /opt/lego/
    cd ..
    rm -rf lego
    exit

Následujícím příkazem zažádáte o vystavení cerifikátu:

    sudo \
    CF_ZONE_API_TOKEN=xxxxx 
    CF_DNS_API_TOKEN=yyyyy \
    /opt/lego/lego -a --path /etc/lego  --dns cloudflare --domains mqtt.example.com --email hostmaster@example.com run

Změňte ho tak, aby obsahoval vaše hodnoty:

* Místo `xxxxx` je token _MQTT-ListZones_.
* Místo `yyyyy` je token _MQTT-EditDNS_.
* Místo `mqtt.example.com` je název vašeho serveru.
* Místo `hostmaster@example.com` je vaše e-mailová adresa.

Vygenerovaný privátní klíč a veřený klíč (certifikát) budou uloženy do `/etc/lego/certificates`

Certifikát platí 90 dnů a je nutné ho pravidelně obnovovat. To lze udělat pomocí cronu. Spusťte příkazem `sudo crontab -e` editaci jeho konfiguračního souboru a  na konec přidejte následující řádek:

    # Renew certificates using Lego every day at 05:00
    0 5 * * * CF_ZONE_API_TOKEN=xxxxx CF_DNS_API_TOKEN=yyyyy /opt/lego/lego -a --path /etc/lego --dns cloudflare --domains mqtt.example.com --email hostmaster@example.com renew --days 30 --renew-hook "systemctl restart mosquitto"

Každý den v pět hodin ráno se spustí příkaz, který obnoví certifikát v případě, že jeho platnost končí za 30 nebo méně dnů. Pokud je certifikát obnoven, restartuje Mosquitto.

Stiskem _Ctrl+S_ soubor uložte a stiskem _Ctrl+X_ ukončete editor Nano.

### Nastavení TLS endpointu

Certifikáty máme, teď je ještě třeba zařídit, aby je Mosquitto používalo. Následujícím příkazem editujte jeho konfigurační soubor:

    sudo nano /etc/mosquitto/conf.d/default.conf

Na konec souboru přidejte následující řádky v případě, že jste použili CertBot a HTTP challenge:

    # Use non-secure listener
    listener 1883

    # Use secure listener
    listener 8883
    certfile /etc/letsencrypt/live/mqtt.example.com/cert.pem
    cafile /etc/letsencrypt/live/mqtt.example.com/chain.pem
    keyfile /etc/letsencrypt/live/mqtt.example.com/privkey.pem

Pokud jste použili Lego a DNS challenge, přidejte následující řádky:

    # Use non-secure listener
    listener 1883

    # Use secure listener
    listener 8883
    certfile /etc/lego/certificates/mqtt.example.com.crt
    cafile /etc/lego/certificates/mqtt.example.com.issuer.crt
    keyfile /etc/lego/certificates/mqtt.example.com.key

Cestu k souborům samozřejmě upravte podle vašeho názvu serveru. Pokud chcete provozovat pouze šifrované rozhraní, můžete vynechat část s `listener 1883`.

Aby se změny projevily, je nutné následujícím příkazem restartovat Mosquitto:

    sudo systemctl restart mosquitto

Aby bylo možné k endpointu přistupovat zvenčí, je nutné povolit port 8883 na firewallu následujícím příkazem:

    sudo ufw allow 8883

### Otestování funkčnosti TLS

Zbývá jenom otestovat, že vše úspěšně funguje. Můžete tak učinit z libovolného počítače kde je Mosquitto klient (včetně serveru samotného). Příkazům `mosquitto_pub` a `mosquitto_sub` je třeba přidat pouze argumenty `-p` (číslo portu, `8883`) a `--capath` (cesta k seznamu důvěryhodných certifikátů, obvykle `--/etc/ssl/certs`).

Příkaz pro subscribe je:

    mosquitto_sub -h www.example.com -t test -u developer -P pass.word123 -p 8883 --capath /etc/ssl/certs

Příkaz pro publish je:

    mosquitto_pub -h www.example.com -t test -u developer -P pass.word123 -p 8883 --capath /etc/ssl/certs -m "Hello, secure world!"

## Závěr

Nyní máte funkční MQTT server, běžící na počítači za deset dolarů, zabezpečený pomocí TLS certifikátů a uživatelských jmen a hesel.

Nevíte, k čemu je taková věc dobrá? Nevíte jak lépe nastavit práva, aby každý nemohl dělat všechno? Podrobněji se budu vytváření "Lan of Things" věnovat v několika na sebe navazujících přednáškách na akci [TechFurMeet 2020](https://www.techfurmeet.org/), která se bude konat začátkem února. Co je to za akci, o tom jsem psal [před rokem](https://www.altair.blog/2019/01/jak-jsme-zviratka-naucili-pajet). 

Příští ročník TechFurMeetu se připravuje, ale [program](https://www.techfurmeet.org/cs/events) je už teď docela našlapaný. Moje témata budou:

* **Odroid GO** - open source platforma retro handheld herní konzole a jak pro ni vytvářet vlastní programy.
* **Příliš spořádaný svět, aneb Vesmír nehraje v kostky** - povídání o generování náhodných čísel s možností si vlastní elektronickou hrací kostku postavit.
* **.NET Core pro každého** - úvod do platformy .NET Core pro úplné začátečníky.
* **Digital Signage a kiosky pomocí Raspberry Pi** - na místě plánuji zprovoznit selfie kiosek s hodně zajímavým příslušenstvím.
* **OpenSCAD 2019.05: Co je nového?** - Dlouho očekávaná nová verze OpenSCADu přinesla řadu novinek, o kterých bude řeč. Všich účastníci TFM dostanou přístup do našeho eLearningového systému na školení 3D modelování v OpenSCADu.
* **Intranet of Things** - na IoT mi nejvíc vadí ten Internet. Jak si vyrobit chytrou domácnost bez nutnosti opustit bezpečí vnitřní sítě?

Tradičním hostem bude **Štěpán Bechynský**, který bude mluvit o nové tiskárně Prusa Mini a o tom, jak hlídat, že se nehýbe někdo, komu jste to zakázali, pomocí IoT platformy BigClown. Další položky programu jsou v jednání.

TFM není jenom pro furries, pokud vás obsah zajímá, neváhejte se [registrovat](https://www.techfurmeet.org/cs/reg). Pokud budete hodní a uděláte to rychle, odpustím vám chaosný poplatek za pozdní registraci.
