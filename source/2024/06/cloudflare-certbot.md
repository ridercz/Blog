<!-- dcterms:title = Získání certifikátů od Let's Encrypt pomocí dns-01 challenge s Cloudflare -->
<!-- dcterms:abstract = Při získávání certifikátů od CA Let's Encrypt se zpravidla používá http-01 challenge, kdy se ověřuje kontrola nad doménou pomocí HTTP requestu na definovanou URL. To je velice snadné a dá se to jednoduše automatizovat. Někdy se ale hodí dns-01 challenge, kdy se kontrola nad doménou ověřuje pomocí DNS záznamů. To je náročnější, ale umožňuje získat wildcard certifikáty nebo certifikáty pro server schovaný v neveřejné síti, případně ne webový. Nabízím podrobný návod, jak na to. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/logo-letsencrypt.svg -->
<!-- x4w:coverUrl = /cover-pictures/20240627-cloudflare-certbot.jpg -->
<!-- x4w:coverCredits = rivage via Unsplash.com -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = IT -->
<!-- x4w:category = Bezpečnost -->
<!-- dcterms:date = 2024-06-27 -->
<!-- x4w:type = TMD -->

<!-- $ -->

Při získávání certifikátů od CA [Let's Encrypt](https://www.letsencrypt.org/) se zpravidla používá _http-01_ challenge, kdy se ověřuje kontrola nad doménou pomocí HTTP requestu na definovanou URL. To je velice snadné a dá se to jednoduše automatizovat. Na Linuxu můžete použít [Certbot](https://certbot.eff.org), na Windows + IIS třeba [AutoACME](https://www.autoacme.net/) nebo [win-acme](https://www.win-acme.com/).

Někdy se ale hodí _dns-01_ challenge, kdy se kontrola nad doménou ověřuje pomocí DNS záznamů. To je náročnější (protože je třeba mít možnost vytvořit patřičné DNS záznamy pomocí nějakého API, což ne každé řešení umožňuje), ale má to své výhody:

* Můžete tak získat wildcard certifikát, platný pro všechny záznamy v dané doméně, např. `*.example.com`.
* Můžete tak získat certifikát pro server, který není dostupný přes HTTP (SMTP, FTP, MQTT...) anebo dokonce sice má FQDN z veřejné domény, ale není z Internetu přímo dostupný. Může být například dostupný pouze z vnitřní sítě nebo pomocí VPN.

V tomto labu si ukážeme, jak takový certifikát získat, pokud je váš DNS provozován u Cloudflare. Návod je psán pro Raspberry Pi OS, ale bude přiměřeně platit i pro ostatní distribuce Linuxu. 

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/pGrYUbgA7DQ" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

- - -
## Získání API tokenu od Cloudflare

Nejprve budeme muset získat autentizační údaj, který umožní pracovat s danou doménou (zónou). Cloudflare rozeznává dva druhy takových údajů:

* _API keys_ jsou globální a můžeme je použít k jakýmkoliv operacím v rámci daného CF účtu.
* _API tokens_ jsou omezené na určitou množinu operací s konkrétní doménou (zónou).

Budeme používat tokeny, protože je to bezpečnější.
- - -
Přihlašte se do Cloudflare Dashboard na adrese [https://dash.cloudflare.com/](https://dash.cloudflare.com/).
- - -
Klepněte v pravém horním rohu na ikonu uživatele a pak na _My Profile_.

![](https://www.cdn.altairis.cz/Blog/2024/20240627-cloudflare-certtbot-01.png)
- - -
Klepněte v levém menu na [API Tokens](https://dash.cloudflare.com/profile/api-tokens) a poté na _Create Token_.

![](https://www.cdn.altairis.cz/Blog/2024/20240627-cloudflare-certtbot-02.png)
- - -
Vyberte šablonu _Edit zone DNS_.

![](https://www.cdn.altairis.cz/Blog/2024/20240627-cloudflare-certtbot-03.png)
- - -
Vyberte jednu nebo více zón, které má mít tento token možnost editovat a klepněte na _Continue to summary_.

![](https://www.cdn.altairis.cz/Blog/2024/20240627-cloudflare-certtbot-04.png)
- - -
(i)

Můžete také nastavit časové omezení platnosti tokenu a případě omezení IP adres, z nichž smí být používán.
- - -
V potvrzovacím dialogu klepněte na _Create token_.
- - -
<!-- #cftoken -->
Zobrazí se vám token, který si pečlivě poznamenejte. Nebudete ho moci později zobrazit, ale budete ho později potřebovat.

![](https://www.cdn.altairis.cz/Blog/2024/20240627-cloudflare-certtbot-05.png)
- - -
(i)

Pomocí příkazu `curl` si můžete ověřit, že je zadaný token funkční. Pokud ano, vrátí se vám odpověď v následujícím tvaru:

    {
    "result": {
        "id": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
        "status": "active"
    },
    "success": true,
    "errors": [],
    "messages": [
        {
        "code": 10000,
        "message": "This API Token is valid and active",
        "type": null
        }
    ]
    }

Pozor, Cloudflarem nabídnutý příkaz bude fungovat jenom v Bashi. Ve Windows s `cmd` musíte příkaz napsat na jeden řádek nebo místo `\` použít `^`, např.:

    curl -X GET "https://api.cloudflare.com/client/v4/user/tokens/verify" ^
         -H "Authorization: Bearer XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" ^
         -H "Content-Type:application/json"

V PowesShellu musíte název příkazu napsat včetně přípony `.exe` a pro pokračování řádku se používá zpětný apostrof:

    curl.exe -X GET "https://api.cloudflare.com/client/v4/user/tokens/verify" `
             -H "Authorization: Bearer XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" `
             -H "Content-Type:application/json"
- - -
## Instalace utility Certbot

[Certbot](https://certbot.eff.org/) je program od EFF, který se stará o získávání a obnovování certifikátů. Bohužel nefunguje na Windows, ale na Linuxu funguje výborně.
- - -
Pokud váš systém podporuje Snap (Ubuntu a některé další distribuce), naninstalujte ho následujícím příkazem:

    sudo snap install --classic certbot
- - -
Pokud příkaz skončil chybou, např. `sudo: snap: command not found`, musíte nejprve nainstalovat `snap`, což učiníte následující sekvencí příkazů:

    sudo apt-get update
    sudo apt-get install snapd -y
    sudo snap install core

Poté znovu zadejte příkaz pro instalaci Certbota:

    sudo snap install --classic certbot
- - -
Následujícím příkazem vytvořte symlink, pomocí kterého bude možné Certbota snadno spouštět:

    sudo ln -s /snap/bin/certbot /usr/bin/certbot
- - -
Následujícími příkazy nainstalujte plugin pro Cloudflare a určíte, že má běžet ve stejném kontextu, jako certbot sám:

    sudo snap set certbot trust-plugin-with-root=ok
    sudo snap install certbot-dns-cloudflare
- - -
Vytvořte adresář `/root/.secrets`:

    sudo mkdir /root/.secrets
- - -
Následujícím příkazem vytvořte soubor `/root/.secrets/cloudflare.ini` pomocí editoru `nano`:

    sudo nano /root/.secrets/cloudflare.ini
- - -
Zadejte do souboru následující obsah (použijte token, který jste vytvořili v kroku [#cftoken]):

    dns_cloudflare_api_token = XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
- - -
Uložte provedené změny klávesovou zkratkou _Ctrl+S_ a ukončete editor pomocí _Ctrl+X_.
- - -
Následujícími příkazy zajistěte, že k souboru nebude mít přístup nikdo jiný, než `root`:

    sudo chmod 0700 /root/.secrets/
    sudo chmod 0400 /root/.secrets/cloudflare.ini
- - -

- - -
## Žádost o certifikát
- - -
Následujícím příkazem pošlete žádost o certifikát (samozřejmě nahraďte `www.example.com` vlastním názvem serveru):

    sudo certbot certonly \
        --dns-cloudflare \
        --dns-cloudflare-credentials /root/.secrets/cloudflare.ini \
        --preferred-challenges dns-01 \
        -d www.example.com

Při prvním spuštění budete požádáni o zadání e-mailové adresy, souhlas s licenčními podmínkami a souhlas se zasíláním zpráv od EFF (ten je volitelný).
- - -
(i)

Pokud chcete vydat certifikát platný pro více DNS jmen, použijte parametr `-d` vícekrát, např.:

    sudo certbot certonly \
        --dns-cloudflare \
        --dns-cloudflare-credentials /root/.secrets/cloudflare.ini \
        --preferred-challenges dns-01 \
        -d www.example.com -d example.com

Pokud chcete požádat o wildcard certifikát, použijte hvězdičku:

    sudo certbot certonly \
        --dns-cloudflare \
        --dns-cloudflare-credentials /root/.secrets/cloudflare.ini \
        --preferred-challenges dns-01 \
        -d *.example.com -d example.com
- - -
(!)

Pozor, wildcard certifikát `*.example.com` bude fungovat například pro `www.example.com` nebo `praha.example.com`. Nebude ale fungovat pro `example.com` (to musíte uvést zvlášť) nebo `www.praha.example.com`. 

Wildcard `*` je povolen jenom před první tečkou ve jméně. Můžete tedy požádat o `*.praha.example.com` ale ne třeba o `www.*.example.com`.
- - -
Nyní máte v adresáři `/etc/letsencrypt/live/www.example.com/` vše, co potřebujete k použití certifikátu. Najdete tam následující soubory:

* `privkey.pem` je privátní klíč k certifikátu.
* `fullchain.pem` certifikát (veřejný klíč) a všechny certifikáty potřebné pro jeho ověření.
* `cert.pem` je pouze certifikát.
* `chain.pem` jsou certifikáty potřebné pro jeho ověření.

Záleží na použitém serverovém software, zda bude chtít certifikát a chain dohromady nebo zvlášť a jakou formou má být konfigurován.
