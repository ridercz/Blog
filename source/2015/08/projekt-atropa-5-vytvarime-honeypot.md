<!-- dcterms:identifier = aspnetcz#5435 -->
<!-- dcterms:title = Projekt Atropa (5): Vytváříme honeypot -->
<!-- dcterms:abstract = V předchozích dílech seriálu o vytvoření "zlé maliny" jsme si ukázali, jak na Raspberry Pi nainstalovat operační systém Raspbian, ASP.NET 5 a jak aplikaci pomocí nginxu vypublikovat do Internetu. Dnes z Raspberry vytvoříme Wi-Fi honeypot, tedy Wi-Fi access point, který každému dovolí, aby se připojil, a všechny HTTP požadavky bude směřovat sám na sebe. -->
<!-- np9:categoryId = 2 -->
<!-- x4w:category = Bezpečnost -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- np9:serialId = 7 -->
<!-- x4w:serial = Projekt Atropa -->
<!-- dcterms:created = 2015-08-09T19:10:44.97+02:00 -->
<!-- dcterms:dateAccepted = 2015-08-10T00:00:00+02:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20150713-projekt-atropa-1-jak-vyrobit-z-raspberry-pi-zle-zarizeni-s-netem.jpg -->

> **Upozornění:** Tento text je několik let starý a spousta věcí se změnila. Zejména v ASP.NET Core (zde pod starým názvem ASP.NET 5). Článek ponechávám jako referenci, ale obecně doporučuji nalézt novější zdroje, jako napříkad [tento seriál](/serials/asp-net-na-raspberry-pi).

V předchozích dílech seriálu o vytvoření "zlé maliny" jsme si ukázali, jak na Raspberry Pi nainstalovat operační systém Raspbian, ASP.NET 5 a jak aplikaci pomocí nginxu vypublikovat do Internetu. Dnes z Raspberry vytvoříme Wi-Fi honeypot, tedy Wi-Fi access point, který každému dovolí, aby se připojil, a všechny HTTP požadavky bude směřovat sám na sebe.

## Umí moje Wi-Fi režim AP?

Základem úspěchu je mít Wi-Fi síťovou kartu, která podporuje AP režim. V [úvodním dílu](http://www.aspnet.cz/articles/5429-projekt-atropa-1-jak-vyrobit-z-raspberry-pi-zle-zarizeni-s-netem) jsem doporučoval [TP-LINK TL-WN722N](https://www.alza.cz/tp-link-tl-wn722n-lite-d155291.htm) a ten AP umí. Pokud budete mít jinou a nejste si jisti, zkontrolujte to.

Začněte tím, že příkazem `sudo apt-get install iw -y` nainstalujete utilitu `iw`, která umí mimo jiné vypsat schopnosti vaší Wi-Fi. Poté si příkazem `iw list` vypište všechny Wi-Fi ve vašem systému a jejich schopnosti.

Najděte sekci *Supported interface modes* a v ní hledejte režim *AP*. Pokud ho nenajdete, kupte si jinou kartu.

## Vytvoření Wi-Fi AP pomocí hostapd

V celém návodu budu předpokládat, že se vaše Wi-Fi karta jmenuje `wlan0`, což je nejspíš pravda (pokud máte v systému jedinou kartu). Pokud si nejste jisti, zjistěte to příkazem `iwconfig`, který vypíše všechny bezdrátové síťovky ve vašem systému:

    *pi@raspberrypi ~ $* **iwconfig**
    wlan0     IEEE 802.11bgn  ESSID:off/any
              Mode:Managed  Access Point: Not-Associated   Tx-Power=20 dBm
              Retry short limit:7   RTS thr:off   Fragment thr:off
              Power Management:off

    lo        no wireless extensions.

    eth0      no wireless extensions.

`Hostapd` je program, který z vašeho Raspberry Pi udělá Wi-Fi přístupový bod. Nainstalujte ho příkazem `sudo apt-get install hostapd -y`. Dále pak vytvořte jeho konfigurační soubor příkazem `sudo nano /etc/hostapd/hostapd.conf`. Zadejte do něj následující obsah:

    interface=wlan0
    driver=nl80211
    ssid=Internet
    channel=6

Poté změny uložte (Ctrl+X, Y, ENTER). Význam parametrů je následující:

*   `interface` je název rozhraní, v našem případě tedy `wlan0`. 
*   `driver` je název ovladače. Pokud nemáte opravdu starou nebo opravdu divnou kartu, bude to `nl80211`. 
*   `ssid` je název sítě, zde `Internet`. 
*   `channel` je číslo kanálu. Zvolte takový, který nebude kolidovat se sítěmi ve vašem okolí. 

Dále musíme hostapd říct, kde konfiguraci najde. Příkazem `sudo nano /etc/init.d/hostapd` otevřete jeho spouštěcí skript a najděte řádek, který začíná `DAEMON_CONF=`. Za rovnítko napište cestu ke konfiguračnímu souboru. Celý řádek tedy bude vypadat tako:

    DAEMON_CONF=/etc/hostapd/hostapd.conf

Poté změny uložte (Ctrl+X, Y, ENTER). 

Příkazem `sudo update-rc.d hostapd defaults` nastavte, aby se hostapd automaticky nastartoval po rebootu.

Tímto jsme náš počítač zkonfigurovali jako AP pro síť Internet, která je zcela otevřená (bez hesla). Zatím ho ale nebudeme startovat, protože by se klienti stejně nemohli připojit, protože by nedostali adresu přes DHCP.

## Instalace a konfigurace dnsmasq

Dnsmasq je program, který funguje jako jednoduchý DNS a DHCP server. Nainstalujte ho příkazem `sudo apt-get install dnsmasq -y`. Poté otevřete jeho konfigurační soubor příkazem `sudo nano /etc/dnsmasq.conf`. Na konec souboru přidejte následující:

    log-facility=/var/log/dnsmasq.log
    address=/#/10.0.0.1
    interface=wlan0
    dhcp-range=10.0.0.10,10.0.0.250,1h
    no-resolv
    log-queries

Poté změny uložte (Ctrl+X, Y, ENTER). Tento zápis všem připojeným přes interface `wlan0` přidělí IP adresu z rozsahu `10.0.0.100-250` a na všechny DNS dotazy bude odpovídat adresou `10.0.0.1`. To bude adresa našeho počítače, takže ať už se uživatel zeptá na cokoliv, bude přesměrován na náš lokální web server. Dále pak budeme všechny DNS dotazy ukládat do souboru `/var/log/dnsmasq.log`.

Příkazem `sudo update-rc.d dnsmasq defaults` nastavte, aby se dnsmasq automaticky nastartoval po rebootu.

## Nastavení sítě a firewallu

Začneme tím, že na firewallu zakážeme pro rozhraní wlan0 všechny porty, s výjimkou HTTP, DHCP a DNS. Zadejte následující příkazy:

    sudo iptables -F
    sudo iptables -i wlan0 -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
    sudo iptables -i wlan0 -A INPUT -p udp --dport 53 -j ACCEPT
    sudo iptables -i wlan0 -A INPUT -p udp --dport 67:68 -j ACCEPT
    sudo iptables -i wlan0 -A INPUT -p tcp --dport 80 -j ACCEPT
    sudo iptables -i wlan0 -A INPUT -j DROP
    sudo sh -c "iptables-save > /etc/iptables.rules"

Těmi nastavíte, že se budou zahazovat všechny pakety mimo DNS (port 53 UDP), DHCP (porty 67-68 UDP) a HTTP (port 80 TCP). Nastavení platí pouze pro rozhraní `wlan0`, takže přes drátový Ethernet bude možné se nadále normálně připojit. Posledním příkazem nastavení iptables vyexportujete do souboru `/etc/iptables.rules`, ze kterého je budeme později načítat.

Dále pak nastavíme naší bezdrátové kartě pevnou IP adresu 10.0.0.1 a zajistíme, že se při startu načtou shora uvedená pravidla. Editujte konfigurační soubor příkazem `sudo nano /etc/network/interfaces`. V tomto souboru vymažte celou sekci týkající se rozhraní `wlan0` (celý řádek smažete pomocí Ctrl+K). Místo ní zadejte tučný text v následujícím výpisu (který zahrnuje pro informaci i konfiguraci ostatních rozhraní, tedy celý soubor na mém RPi):

    auto lo
    iface lo inet loopback

    auto eth0
    allow-hotplug eth0
    iface eth0 inet manual

    **iface wlan0 inet static
    address 10.0.0.1
    netmask 255.255.255.0
    broadcast 255.0.0.0
    pre-up iptables-restore < /etc/iptables.rules**

    auto wlan1
    allow-hotplug wlan1
    iface wlan1 inet manual
    wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf

Poté změny uložte (Ctrl+X, Y, ENTER). 

Poslední věc, kterou je třeba zajistit je, abychom se nestali obětí vlastního honeypotu. Tedy aby Raspberry Pi samo dokázalo udělat funkční DNS resolving a neresolvovalo vše samo na sebe. Nastavíme tedy, že bude napevno používat DNS server Google. Příkazem `sudo nano /etc/resolvconf.conf` otevřete konfigurační soubor, odkomentujte řádek začínající `#name_servers=` a místo `127.0.0.1` zadejte adresu DNS serveru, který chcete používat, např. `8.8.8.8`. Celý soubor bude po provedení změn vypadat takto:

    # Configuration for resolvconf(8)
    # See resolvconf.conf(5) for details

    resolv_conf=/etc/resolv.conf
    # If you run a local name server, you should uncomment the below line and
    # configure your subscribers configuration files below.
    **name_servers=8.8.8.8**

    # Mirror the Debian package defaults for the below resolvers
    # so that resolvconf integrates seemlessly.
    dnsmasq_resolv=/var/run/dnsmasq/resolv.conf
    pdnsd_conf=/etc/pdnsd.conf
    unbound_conf=/var/cache/unbound/resolvconf_resolvers.conf

Poté změny uložte (Ctrl+X, Y, ENTER).

## Zkouška honeypotu

Začněte tím, že Raspberry restarujtete příkazem `sudo reboot`. Vyčkejte, dokud nenastartuje. Poté se připojte k otevřené síti Internet (nebo jak jste ji pojmenovali) a zadejte do browseru jakoukoliv webovou adresu. Budete přesměrováni na výchozí stránku naší ukázkové ASP.NET aplikace.

V příštím pokračování si ukážeme, jak napsat aplikaci tak, aby sbírala hesla uživatelů.