<!-- dcterms:title = Instalace MQTT serveru Mosquitto na Linux -->
<!-- dcterms:abstract = V prvním a druhém dílu seriálu o MQTT jsem používal veřejný MQTT broker. To se hodí pro demo, ale produkční systém na tom stavět nechcete. Pokud pro svůj MQTT server nechcete používat hostované řešení, můžete si rozjet vlastní server. Asi nejpoužívanějším softwarem pro tento účel je Mosquitto. Je to open source multiplatformní projekt, který funguje na Windows, Linuxu i Mac OS. Ukážu vám, jak Mosquitto nainstalovat na Linux, nastavit na něm TLS zabezpečení a WebSockets rozhraní. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/logo-mqtt.svg -->
<!-- x4w:coverUrl = /cover-pictures/20240702-mosquitto-linux.jpg -->
<!-- x4w:coverCredits = Thomas Jensen via Unsplash.com -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = IT -->
<!-- dcterms:date = 2024-07-02 -->
<!-- x4w:type = TMD -->

<!-- $ -->

V prvním a druhém dílu seriálu o MQTT jsem používal veřejný MQTT broker. To se hodí pro demo, ale produkční systém na tom stavět nechcete. Pokud pro svůj MQTT server nechcete používat hostované řešení, můžete si rozjet vlastní server. Asi nejpoužívanějším softwarem pro tento účel je [Mosquitto](https://www.mosquitto.org). Je to open source multiplatformní projekt, který funguje na Windows, Linuxu i Mac OS. Ukážu vám, jak Mosquitto nainstalovat na Linux, nastavit na něm TLS zabezpečení a WebSockets rozhraní.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/G2P_n9IDE4c" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

Následující postup funguje na aktuálním Ubuntu a Raspberry Pi OS. Měl by přiměřeně fungovat i na ostatních distribucích.

- - -
## Instalace
- - -
Ve většině distribucí Linuxu je Mosquitto součástí standardních repozitářů. Mělo by tedy stačit nainstalovat balíčky `mosquitto` a `mosquitto-clients`:

    sudo apt-get install mosquitto mosquitto-clients -y
- - -
(i)

Pokud výše uvedený příkaz skončí chybou, postupujte podle návodu pro vaši distribuci na webu [mosquitto.org](https://mosquitto.org/download/).
- - -
<!-- #checkmqtt -->
Mosquitto nyní běží s výchozími nastaveními. Máte k dispozici utility `mosquitto_pub` a `mosquitto_sub`, které slouží jako publisher a subscriber.

Následujícím příkazem spusťte subcriber tak, že bude naslouchat na topicu `test`:

    mosquitto_sub -h localhost -t test &
- - -
<!-- #pid -->
Znak `&` na konci příkazu znamená, že proces má běžet na pozadí a tedy nemá blokovat interaktivní konzoli. Příkaz vypsal něco jako:

    [1] 12345

To druhé číslo (zde `12345`) je PID, číselný identifikátor procesu. Poznamenejte si ho, budete ho později potřebovat k jeho ukončení.
- - -
(i)

Seznam svých běžících procesů si můžete vypsat pomocí příkazu `ps`. Měli byste vidět něco jako:

    PID   TTY          TIME CMD
    12100 pts/0    00:00:00 bash
    12345 pts/0    00:00:00 mosquitto_sub
    12347 pts/0    00:00:00 ps
- - -
Následujícím příkazem pošlete pomocí publishera zprávu `Hello, world!` do topicu `test`:

    mosquitto_pub -h localhost -t test -m "Hello, world!"
- - -
Zpráva bude vypsána na konzoli. Vypsal ji tam proces `mosquitto_sub`.
- - -
Pomocí `kill` můžete ukončit subscribera běžícího na pozadí. Použijte k tomu PID zjištěné v kroku [#pid].

    kill 12345
- - -
Pomocí `ps` si můžete ověřit, že proces subscribera neběží.
- - -
## Nastavení firewallu

MQTT obvykle využívá následující porty:

* Standardní port pro nešifrované spojení: `1883`
* MQTT over TLS (šifrované): `8883`
* MQTT over QUIC: `14567`
* MQTT over Web Sockets: výchozí HTTPS port `443`, případně jiné, jako `8884` nebo `8443`, pokud na výchozím běží jiný web server.
- - -
V tomto návodu budeme pracovat s porty `1883` (MQTT), `8883` (šifrované MQTTS), `8884` (MQTT over WebSockets). Zpřístupněte tyto porty na firewallu. Pomocí UFW tak můžete učinit následujícími příkazy:

    sudo ufw allow 1883/tcp
    sudo ufw allow 8883/tcp
    sudo ufw allow 8884/tcp
    sudo ufw reload
- - -
## Nastavení TLS

Název serveru v příkladu je `mqtt.ztech.cz`. Upravte postup podle vašeho názvu serveru.
- - -
Abyste mohli používat Mosquitto s TLS (ať už přímo nebo přes WebSockets), musíte mít certifikát vydané důvěryhodnou certifikační autoritou.

Pokud takový certifikát máte, musíte ho zpřístupnit Mosquittu, například tak, že vytvoříte následující soubory:

* `/etc/mosquitto/certs/cert.pem` - vlastní certifikát,
* `/etc/mosquitto/certs/privkey.pem` - privátní klíč k certifikátu,
* `/etc/mosquitto/certs/chain.pem` - certifikát CA a mezilehlých autorit.

Následující postup předpokládá, že máte certifikáty získané od Let's Encrypt CA pomocí utility Certbot. Pokud máte certifikáty získané jinak, např. od vlastní CA, nakopírujte je na výše uvedené cesty a pokračujte krokem [#mosquittoconf].
- - -
### Zpřístupnění certifikátů získaných od Let's Encrypt

Pokud nemáte validní certifikát, můžete ho zdarma získat od Let's Encrypt certifikační autority. Pokud na stejném serveru běží web server a má veřejnou adresu, je to triviální. Pokud ne, můžete použít například postup popsaný v článku [Získání certifikátů od Let’s Encrypt pomocí dns-01 challenge s Cloudflare](https://www.altair.blog/2024/06/cloudflare-certbot).

Certbot certifikáty ve výchozím nastavení umístí do adresáře `/etc/letsencrypt/live/` a nastaví práva tak, že k privátnímu klíči má přístup jenom `root`. Nicméně můžeme nastavit deploy hook, který vždy po získání nových certifikátů tyto nakopíruje do `/etc/mosquitto/certs` a dá práva uživateli `mosquitto`.
- - -
Vytvořte soubor `/usr/local/sbin/copy-to-mosquitto.sh`, který bude obsahovat příkazy pro zkopírování souborů a nastavení práv:

    sudo nano /usr/local/sbin/copy-to-mosquitto.sh
- - -
Zadejte do souboru následující příkazy (místo `mqtt.ztech.cz` zadejte název vašeho certifikátu):

    cp /etc/letsencrypt/live/mqtt.ztech.cz/cert.pem /etc/mosquitto/certs/
    cp /etc/letsencrypt/live/mqtt.ztech.cz/privkey.pem /etc/mosquitto/certs/
    cp /etc/letsencrypt/live/mqtt.ztech.cz/chain.pem /etc/mosquitto/certs/
    chown mosquitto:mosquitto /etc/mosquitto/certs/*.pem
- - -
Stiskem _Ctrl+S_ uložte soubor a _Ctrl+X_ ukončete editor.
- - -
Následujícím příkazem nastavte soubor jako spustitelný:

    sudo chmod +x /usr/local/sbin/copy-to-mosquitto.sh
- - -
Následujícím příkazem (místo `mqtt.ztech.cz` zadejte název vašeho certifikátu) nastavíte, že se má po vydání nového certifikátu shora uvedený soubor spustit (a zároveň ho spustíte ihned):
    
    sudo certbot reconfigure --cert-name mqtt.ztech.cz \
                             --deploy-hook "/usr/local/sbin/copy-to-mosquitto.sh" \
                             --run-deploy-hooks
- - -
Následujícím příkazem si zkontrolujte, že vše v pořádku proběhlo:

    sudo ls -la /etc/mosquitto/certs/

Měli byste vidět něco jako:

    drwxr-xr-x 2 root      root      4096 Jun 28 21:41 .
    drwxr-xr-x 5 root      root      4096 Jun 28 18:22 ..
    -rw-r-xr-- 1 mosquitto mosquitto 1302 Jun 28 21:41 cert.pem
    -rw-r-xr-- 1 mosquitto mosquitto 1566 Jun 28 21:41 chain.pem
    -rw-r-x--- 1 mosquitto mosquitto  241 Jun 28 21:41 privkey.pem
    -rw-r--r-- 1 root      root       130 Sep 30  2023 README
- - -
### Konfigurace Mosquitta
- - -
<!-- #mosquittoconf -->
Následujícím příkazem vytvořte konfigurační soubor Mosquitta:

    sudo nano /etc/mosquitto/conf.d/default.conf
- - -
(i)
Soubor se může jmenovat jakkoliv, ale musí být umístěn v adresáři `/etc/mosquitto/conf.d/` a mít příponu `.conf`.
- - -
Zadejte do něj následující obsah (upravte cestu k certifikátům a privátnímu klíči dle potřeby). Za textem v posledním řádku (`keyfile...`) stiskněte _Enter_ - musí tam být zalomení řádku. Pokud tomu tak není, bude ho Mosquitto ignorovat.

<pre>
allow_anonymous true

# Non-secure listener
listener 1883

# TLS-enabled listener
listener 8883
certfile /etc/mosquitto/certs/cert.pem
cafile /etc/mosquitto/certs/chain.pem
keyfile /etc/mosquitto/certs/privkey.pem

</pre>
- - -
(!)
Volba `allow_anonymous true` říká, že se na náš server může připojit kdokoliv a může cokoliv kamkoliv publikovat a číst. To obecně není dobrý nápad. Nastavení práv probereme v dalším pokračování tohoto seriálu.
- - -
Stiskem _Ctrl+S_ uložte soubor a _Ctrl+X_ ukončete editor.
- - -
Následujícím příkazem Mosquitto restartujete

    sudo systemctl restart mosquitto
- - -
Že vše funguje si můžete ověřit podobně jako v kroku [#checkmqtt]. Místo `mqtt.ztech.cz` zadejte název vašeho serveru.

Příkaz pro spuštění subscribera na pozadí je: 

    mosquitto_sub -h mqtt.ztech.cz -p 8883 --capath /etc/ssl/certs \
                  -t test &

Příkaz pro zaslání zprávy do topicu `test` je:

    mosquitto_pub -h mqtt.ztech.cz -p 8883 --capath /etc/ssl/certs \
                  -t test -m "Hello, world!"
- - -
## Nastavení MQTT over WebSockets

Pokud chcete využívat MQTT přímo z prohlížeče, musí být MQTT server dostupný pomocí HTTPS a WebSockets.
- - -
Následujícím příkazem otevřete k editaci konfigurační soubor Mosquitta:

    sudo nano /etc/mosquitto/conf.d/default.conf
- - -
Přidejte do něj následující konfiguraci (a nezapomeňte na prázdný řádek na konci souboru):

<pre>
allow_anonymous true

# Non-secure listener
listener 1883

# TLS-enabled listener
listener 8883
certfile /etc/mosquitto/certs/cert.pem
cafile /etc/mosquitto/certs/chain.pem
keyfile /etc/mosquitto/certs/privkey.pem

<ins># WebSockets+TLS listener
listener 8884
protocol websockets
certfile /etc/mosquitto/certs/cert.pem
cafile /etc/mosquitto/certs/chain.pem
keyfile /etc/mosquitto/certs/privkey.pem</ins>

</pre>
- - -
Stiskem _Ctrl+S_ uložte soubor a _Ctrl+X_ ukončete editor.
- - -
Následujícím příkazem Mosquitto restartujte, aby se projevila změna konfigurace:

    sudo systemctl restart mosquitto
- - -
Že vše funguje přes WebSockets si můžete ověřit např. z [webového klienta od HiveMQ](https://www.hivemq.com/demos/websocket-client/).