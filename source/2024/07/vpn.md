<!-- dcterms:title = Vlastní VPN bez speciálního software - IKEv2 nebo L2TP/IPsec -->
<!-- dcterms:abstract = Popularita VPN stoupá. Hodí se z důvodu bezpečnosti, z důvodu ochrany soukromí, nebo když se váš stát rozhodne, že bude cenzurovat přístup k Internetu. Většina běžných návodů předpokládá, že máte na svém počítači speciální klientský software. Já vám ukážu, jak vytvořit VPN server, na který se připojíte čistě pomocí toho, co máte k dispozici ve svém operačním systému. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20240709-vpn.jpg -->
<!-- x4w:coverUrl = /cover-pictures/20240709-vpn.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = IT -->
<!-- x4w:category = Lab -->
<!-- x4w:category = Linux -->
<!-- dcterms:date = 2024-07-09 -->
<!-- x4w:type = TMD -->

<!-- $ -->

Popularita VPN stoupá. Hodí se z důvodu bezpečnosti, z důvodu ochrany soukromí, nebo když se váš stát rozhodne, že bude cenzurovat přístup k Internetu.

Nejjednodušší z uživatelsky nejpřívětivější je použít nějakou komerční VPN službu. Reklam na ně je plný Internet a jsou jich plné appstory na všech platformách. Důrazně vám doporučuji se jim všem vyhnout. Proč? 

1. Jsou jenom tak bezpečné a důvěryhodné, jak důvěryhodný je jejich provozovatel, což většinou není mnoho.
2. Jsou drahé. Na jednorázový poplatek nevěřte (není to ekonomicky únosný model a poskytovatel přestane časem existovat a začne fungovat pod jinou vlajkou) a měsíční poplatky se rychle nasčítají. Vlastní řešení bude nejspíš podstatně výhodnější.
3. Dají se snadno blokovat. Je jich celkem malé množství a je snadné je zablokovat síťově a ještě snazší donutit Apple nebo Google, aby aplikace stáhli z app store, jak se nedávno stalo v Rusku.

Provozovat vlastní VPN server je snadné. Ostatně, vytvořil jsem [bezplatný online kurz](https://elearning.altairis.cz/courses/outline), jak si nainstalovat Outline VPN, což je program, který to výrazně usnadňuje i laikům. To se blokuje hůře. Není to nemožné, ale je to technologicky podstatně komplikovanější, než zablokovat pár nejpopulárnějších poskytovatelů komerčních VPN služeb. Pokud budete používat svou soukromou VPN sami, nebude nápadná. Navíc tyto technologie jsou tak rozšířené, že jejich plošné blokování by přineslo spoustu problémů i z hlediska režimu žádoucích cílů.

Nicméně Outline má jednu nevýhodu: vyžaduje speciální klientskou aplikaci. Proto vás naučím, jak jednoduše vytvořit VPN pomocí standardních technologií IKEv2 a L2TP/IPsec. Ty pro standardní operační systémy (včetně mobilních) nepotřebují žádnou speciální aplikaci, ale podpora pro ně je součástí systému samotného.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/udeTS5GDk-c" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

Jediné co je nutné, je mít k dispozici server, na kterém běží Ubuntu, Debian nebo CentOS, je dostupný z Internetu (má veřejnou IP adresu) a byl umístěn v síťové lokaci, kterou pokládáte pro svůj účel za vhodnou, neboť pro zbytek Internetu budete přistupovat z ní. O všechno ostatní se postarají skripty projektu [setupvpn.net](https://setupvpn.net/).

> **Já s oblibou používám cloudového poskytovatele Digital Ocean. Pokud se zaregistrujete přes odkaz [https://altair.is/digitalocean](https://altair.is/digitalocean), dostanete do začátku kredit $200 na 60 dnů.** Můžete ale použít i jiného cloudového poskytovatele - Microsoft Azure, Amazon EC2, Oracle Cloud Infrastructure... Případně normální VPS hosting nebo vlastní server. 

- - -
(i)
Tento návod předpokládá, že váš server má IP adresu `198.51.100.42`. Místo ní použijte skutečnou adresu vašeho serveru.
- - -
## Konfigurace serveru
- - -
Připojte se přes SSH na server, např.:

    ssh root@198.51.100.42

Budete-li vyzváni k potvrzení otisku klíčů serveru, zadejte `yes`.
- - -
Na serveru zadejte následující příkaz:

    wget https://get.vpnsetup.net -O vpn.sh && sudo sh vpn.sh

Tím stáhnete setup skript a automaticky ho spustíte.
- - -
<!-- #credentials -->
Na konci vám vypíše důležité údaje, poznamenejte si je:

<pre>
================================================

IPsec VPN server is now ready for use!

Connect to your new VPN with these details:

Server IP: <ins>198.51.100.42</ins>
IPsec PSK: <ins>xxxxxxxxxxxxxxxxxxxx</ins>
Username: vpnuser
Password: <ins>xxxxxxxxxxxxxxxx</ins>

Write these down. You'll need them to connect!

VPN client setup: https://vpnsetup.net/clients

================================================

================================================

IKEv2 setup successful. Details for IKEv2 mode:

VPN server address: <ins>198.51.100.42</ins>
VPN client name: vpnclient

Client configuration is available at:
/root/vpnclient.p12 (for Windows & Linux)
/root/vpnclient.sswan (for Android)
/root/vpnclient.mobileconfig (for iOS & macOS)

Next steps: Configure IKEv2 clients. See:
https://vpnsetup.net/clients

================================================
</pre>
- - -
(i)

V tomto okamžiku vám na serveru běží VPN server pro dva protokoly:

* **[IKEv2/IPSec](https://en.wikipedia.org/wiki/Internet_Key_Exchange)** - zkratka znamená _Internet Key Exchange version 2_ a je to (relativně) nový standard, který pro autentizaci používá asymetrickou kryptografii. Pokud je to možné, použijte tento protokol, mimo jiné protože lépe funguje skrz různé NATy, firewally a podobně.
* **[L2TP/IPsec](https://en.wikipedia.org/wiki/Layer_2_Tunneling_Protocol)** - zkratka znamená _Layer 2 Tunneling Protocol_ a je to (relativně) starší standard, který v našem případě pro autentizaci používá uživatelské jméno, heslo a další _sdílené tajemství_ - pre-shared key, PSK.

Kromě toho můžete jednoduše pomocí podobných skriptů nastavit podporu i pro [WireGuard](https://github.com/hwdsl2/wireguard-install) a [OpenVPN](https://github.com/hwdsl2/openvpn-install). To jsou další protokoly pro VPN, které ale nemají v klientských OS vestavěnou podporu (potřebujete doinstalovat odpovídajícího klienta).

Na klientovi můžete nastavit podporu pro jeden nebo více protokolů, nezávisle na sobě. Doporučuji jich přidat více, zvýšíte tím šanci, že skrz restriktivní firewall jeden z nich projde.

Pokud je mezi serverem a klientem firewall, je třeba ho patřičně nastavit. Je třeba povolit:

* Port 500/udp (IKE)
* Port 1701/udp (L2TP)
* Port 4500/udp (NAT-T-IKE)
* IP Protocol 50 (ESP, Encapsulated Security Payload)
* IP Protocol 51 (AH, Authentication Header)
- - -
## Konfigurace klienta

Následující návod je určen pro Windows. Pro jiné operační systémy najdete postup na adrese [https://vpnsetup.net/clients](https://vpnsetup.net/clients).

* Pokud chcete nastavit IKEv2/IPsec VPN, pokračujte následujícím krokem číslo [#setup-ikev2].
* Pokud chcete nastavit L2TP/IPsec VPN, pokračujte krokem číslo [#setup-l2tp].

- - -
### Konfigurace IKEv2/IPsec na Windows
- - -
(i)
Následující návod bude fungovat na Windows 11, na starších verzích se postup může mírně lišit. Na dnes již nepodporovaných verzích Windows (7, 8) standardně není nainstalováno `curl` a `scp` a budete tedy muset soubory přenést jinak a dávkový soubor stáhnout ručně.
- - -
<!-- #setup-ikev2 -->
Na serveru byl vytvořen soubor `/root/vpnclient.p12`, který obsahuje klíče, které potřebujete pro připojení k VPN. Následujícím příkazem ho zkopírujete na lokální počítač:

    scp root@198.51.100.42:/root/vpnclient.p12 .
- - -
Dále pak do stejného adresáře stáhněte z GitHubu soubor [ikev2_config_import.cmd](https://github.com/hwdsl2/vpn-extras/releases/latest/download/ikev2_config_import.cmd), například následujícím příkazem:

    curl -L https://github.com/hwdsl2/vpn-extras/releases/latest/download/ikev2_config_import.cmd > ikev2_config_import.cmd
- - -
Spusťte tento soubor jako administrátor (klepnout pravým tlačítkem a zvolit _Run as administrator_ nebo _Spustit jako správce_).
- - -
Skript vypíše úvodní zprávu:

    ===================================================================
    Welcome! Use this helper script to import an IKEv2 configuration
    into a PC running Windows 8, 10 or 11.
    For more details, see https://vpnsetup.net/ikev2

    Before continuing, you must put the .p12 file you transferred from
    the VPN server in the *same folder* as this script.
    ===================================================================

    Enter the name of the IKEv2 VPN client to import.
    Note: This is the same as the .p12 filename without extension.
    To accept the suggested client name, press Enter.
    VPN client name: [vpnclient]

Pokud jste soubor `vpnclient.p12` nepřejmenovali, stačí stisknout _Enter_. Pokud ano, zadejte nový název souboru (bez přípony).
- - -
Skript vypíše:

    Enter the IP address (or DNS name) of the VPN server.
    Note: This must exactly match the VPN server address in the output
    of the IKEv2 helper script on your server.
    VPN server address:

Zde zadejte název nebo IP adresu vašeho VPN serveru (v příkladu `198.51.100.42`).
- - -

Skript vypíše:

    Provide a name for the new IKEv2 connection.
    To accept the suggested connection name, press Enter.
    IKEv2 connection name: [IKEv2 VPN 198.51.100.42]

Zde zadejte název VPN, pod kterým bude vidět v systému. Standarně je to `IKEv2 VPN <název serveru>`, ale můžete zadat cokoliv, např. `VPN Test IKEv2`.
- - -
Skript na konci vypíše:

    IKEv2 configuration successfully imported!
    To connect to the VPN, click on the wireless/network icon in your system tray,
    select the "IKEv2 VPN 198.51.100.42" VPN entry, and click Connect.

    Press any key to exit.

Stiskněte _Enter_ pro ukončení nastavení.
- - -
Pro připojení k VPN klepněte na ikonu síťových připojení na hlavním panelu. Vyberte ikonu VPN a klepněte na název nově vytvořené VPN. Tím budete připojeni.
- - -
(i)
Že jste připojeni přes VPN si můžete ověřit například na stránce [https://www.whatismyip.com/](https://www.whatismyip.com/). Ta vypíše, z jaké IP adresy přicházíte a kde se (podle její geolokace) nachází.
- - -
### Konfigurace L2TP/IPSec VPN na Windows 7 a novějších
- - -
(i)
Následující návod bude fungovat na Windows 11, na starších verzích se postup může mírně lišit.
- - -
<!-- #setup-l2tp -->
Pokud je váš počítač za NAT (což asi je), spusťte jako administrátor z příkazové řádky následující příkaz, kterým nastavíte podporu příslušné funkce:

    REG ADD HKLM\SYSTEM\CurrentControlSet\Services\PolicyAgent /v AssumeUDPEncapsulationContextOnSendRule /t REG_DWORD /d 0x2 /f

Alternativně můžete stáhnout a spustit [připravený .reg soubor](https://github.com/hwdsl2/vpn-extras/releases/download/v1.0.0/Fix_VPN_Error_809_Windows_Vista_7_8_10_Reboot_Required.reg), který udělá totéž.
- - -
Poté restartujte počítač.
- - -
Otevřete nastavení Windows (například stiskem _Win+I_).
- - -
Vyberte _Network & Internet_ (_Síť a Internet_) a poté _VPN_.
- - -
Klepněte na tlačítko _Add VPN_.
- - -
V dialogu pro přidání VPN zadejte následující hodnoty:

* **VPN provider:** _Windows (built-in)_
* **Connection name:** cokoliv chcete, např. _VPN Test L2TP_
* **Server name or address:** název či adresu vašeho serveru, např. _198.51.100.42_
* **VPN type:** _L2TP/IPsec with pre-shared key_
* **Pre-shared key:** hodnotu _IPsec PSK_ zjištěnou v kroku [#credentials]
* **Type of sign-in info:** _Username and password_
* **Username:** _vpnuser_
* **Password:** heslo zjištěné v kroku [#credentials]

Poté klepněte na _Save_ pro ukončení nastavení.
- - -
Pro připojení k VPN klepněte na ikonu síťových připojení na hlavním panelu. Vyberte ikonu VPN a klepněte na název nově vytvořené VPN. Tím budete připojeni.
- - -
(i)
Že jste připojeni přes VPN si můžete ověřit například na stránce [https://myip.sh/](https://myip.sh/). Ta vypíše, z jaké IP adresy přicházíte a kde se (podle její geolokace) nachází.
