<!-- dcterms:identifier = aspnetcz#5454 -->
<!-- dcterms:title = Let's Encrypt na Windows: PoC aplikace -->
<!-- dcterms:abstract = V předchozím článku jsem vám představil certifikační autoritu Let's Encrypt a protokol ACME. Nyní si ukážeme, jak s CA pomocí ACME komunikovat z prostředí .NET aplikace. -->
<!-- np9:categoryId = 4 -->
<!-- x4w:category = Bezpečnost -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2017-01-15T01:40:15.217+01:00 -->
<!-- dcterms:dateAccepted = 2017-01-22T00:00:00+01:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/logo-autoacme.png -->

V předchozím článku jsem vám představil certifikační autoritu Let's Encrypt a protokol ACME. Nyní si ukážeme, jak s CA pomocí ACME komunikovat z prostředí .NET aplikace. Napíšeme jednoduchou proof of concept aplikaci, která projde procesem ověření totožnosti a vydání jednoho certifikátu.

Pro komunikaci protokolem ACME použijeme [Certes](https://github.com/fszlin/certes), .NET kliente pro ACME protokol. Přišel mi srozumitelnější, než populárnější [ACMESharp](https://github.com/ebekker/ACMESharp). Součástí projektu Certes je i klient z příkazové řádky, který dělá část toho, co chceme. Pokud nechcete plně automatizovaný proces, podívejte se na něj, může vám být užitečné.

Zdrojový kód mé aplikace najdete jako [gist na GitHubu](https://gist.github.com/ridercz/ce6473b9693402882a7ec56fb722ea0c). V podstatě jde o mírně upravený a rozšířený příklad, který najdete na stránkách projektu [Certes](https://github.com/fszlin/certes#get-started). 

Kód postupně dělá následující:

1.  Zaregistruje se pod definovanou e-mailovou adresou. V případě problémů (zejména expirovaného certifikátu, pro který nebyl vydán následný) vám na ni Let's Encrypt pošle zprávu.
2.  Odsouhlasí podmínky použití.
3.  Získá challenge pro daný host name.
4.  Počká, dokud challenge nenahrajete na správné místo a nestisknete ENTER.
5.  Vyžádá si ověření challenge (což může chvíli trvat).
6.  Pokud challenge uspěje, vygeneruje žádost o podpis certifikátu (Certificate Signing Request, CSR).
7.  Žádost odešle na server a nechá vystavit certifikát.
8.  Načte certifikát a zobrazí jeho vlastnosti.
9.  Vyexportuje certifikát do souboru CRT.
10.  Vyexportuje certifikát a privátní klíč do souboru PFX.

Krátce se zastavíme u bodu č. 4, neboť tam musíte zasáhnout ručně. Challenge obsahuje dvě důležité informace: ID a samotný ověřovací řetězec. Ověřovací řetězec musí být nějakým způsobem zpřístupněn přes HTTP nebo HTTPS na ověřovaném host name na adrese */.well-known/acme-challenge/<id>*. Tj. budete-li ověřovat host name *example.com* a vygenerované ID bude *1234abcd*, musí být ověřovací řetězec dostupný na adrese *http://example.com/.well-known/acme-challenge/1234abcd*.

Požadovaný soubor lze snadno vytvořit pomocí příkazu echo, který stačí jenom spustit na serveru, kde je příslušný web hostován (ukázková aplikace nemusí být spuštěna na web serveru).

[![AutoAcmeLogo_256](https://www.cdn.altairis.cz/Blog/2017/20170115-AutoAcmeLogo_256_thumb.png "AutoAcmeLogo_256")](https://www.cdn.altairis.cz/Blog/2017/20170115-AutoAcmeLogo_256_2.png)

Zároveň tímto P. T. čtenářům představuji i logo projektu AutoAcme. Název protokolu ACME je také název [společnosti z grotesek Looney Tunes](https://en.wikipedia.org/wiki/Acme_Corporation). Jedním z nejlepších zákazníků společnosti Acme Corporation byl Wile E. Coyote a jedním z často se objevujících motivů byla právě kovadlina, dodaná společností ACME. 