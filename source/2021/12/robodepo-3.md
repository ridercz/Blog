<!-- dcterms:title = Jak zastavit robotické depo Zásilkovny: Bezpečnost -->
<!-- dcterms:abstract = Časté dotazy ke stop tlačítku pro robotické depo Zásilkovny směřovaly k tomu, proč se používá Wi-Fi a ne nějaký jiný (bezpečnější) komunikační kanál. To se dozvíte v tomto videu, stejně jako jak jsem se rozhodl komunikaci zabezpečit i přesto, že na ESP8266 je obtížné naimplementovat správnou podporu HTTPS. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20211202-robodepo-3.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20211202-robodepo-3.jpg -->
<!-- x4w:category = Z-TECH -->
<!-- x4w:category = IT -->
<!-- x4w:category = Bezpečnost -->
<!-- dcterms:dateAccepted = 2021-12-02 -->

Časté dotazy ke stop tlačítku pro robotické depo Zásilkovny směřovaly k tomu, proč se používá Wi-Fi a ne nějaký jiný (bezpečnější) komunikační kanál. To se dozvíte v tomto videu, stejně jako jak jsem se rozhodl komunikaci zabezpečit i přesto, že na ESP8266 je obtížné naimplementovat správnou podporu HTTPS.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/FWUkR0MhXIA" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

## K bezpečnosti obecně

Několikrát jsem byl na sociálních sítích upozorněn, že si to představuju jako Hurvínek válku, že na tlačítka pro nouzové zastavení jsou normy a vůbec že to je cesta do kriminálu. Zde je nutné si uvědomit, že se nejedná o tlačítko nouzového zastavení v případě ohrožení života nebo zdraví. Roboti nemohou nikomu ublížit, jsou asi tak velcí jako robotický vysavač a zhruba stejně nebezpeční: mohou do vás maximálně žďouchat.

Účelem stop tlačítka není fungovat v případě havárie, ale zastavit jejich pohyb třeba v případě, že z robota spadne špatně uložená zásilka a bude třeba, aby operátor fyzicky vlezl na molo a sebral ji. Nechceme, aby se v takovém případě pletl robotům a roboti jemu. To je celé.

## Wi-Fi a jeho zabezpečení

Robotické depo je existující projekt, do kterého se můj kousek musí zapojit. Nestavím na zelené louce a interoperabilita je důležitá. S tím souvisejí i bezpečnostní rozhodnutí. Základní princip je, že molo (po němž jezdí roboti) by nemělo být moc zadrátované. Všude se tahá jenom napájení. Veškerá data jdou vzduchem přes Wi-Fi.

Z tohoto důvodu jsem zvolil Wi-Fi jako komunikační médium i pro stop tlačítko. Ano, lze jej zarušit nebo jiným způsobem škodit (provést DoS útok). Jenomže pokud se to stane, bude nejmenší problém, že nefungují moje tlačítka - zkolabuje celá komunikace čteček atd. 

Z hlediska odolnosti proti rušení by bylo samozřejmě nejlepší používat drátovou komunikaci. Bylo by to i technicky nejjednodušší, protože by stačilo použít prostě NC tlačítka zapojená do série k jednomu "chytrému" modulu, který by přes backend zastavil roboty. Ale zadání znělo jinak.

## Proč ne HTTPS

Zdánlivě nejjednodušší by bylo pro autentizaci použít HTTPS, serverové a klientské certifikáty. Nicméně správně naimplementovat HTTPS na ESP8266 je někde mezi "hodně těžké" a "nemožné". Potýkáme se přitom se dvěma problémy.

Prvním je, že mikrokontroler nemá hodiny reálného času. Když se zapne nebo restartuje, neví kolik je hodin. Neumí tedy ověřit časovou platnost certifkátu, zda již nevyexpiroval. Samozřejmě je možné k němu dát RTC modul s baterií pro zálohování, např. [známý modul DS3231](http://www.esp8266learning.com/wemos-ds3231-rtc-example.php). Ale to by dost zkomplikovalo celou konstrukci. Taky je možné čas při startu zjistit ze sítě, např. přes NTP. Jenomže to se zase nedá udělat bezpečně, je to potenciální vektor útoku.

Druhým problémem je, že na ESP lze obtížně vytvořit a hlavně udržovat seznam důvěryhodných certifikačních autorit. U běžného počítače se o to stará operační systém. U mikrokontroleru bychom museli odpovídající infrastrukturu vybudovat sami, což je dost obtížné.

Z tohoto důvodu jsem dospěl k poněkud netradičnímu řešení: HTTPS sice použiji, ale nebudu ověřovat platnost serverového certifikátu. Klient akceptuje jakýkoliv, i když bude neplatný, self-signed a podobně. Stejně tak dobře bychom mohli použít prosté HTTP, ale dneska už je pomalu jednodušší udělat HTTPS web než HTTP. Navíc i takto naimplementované HTTPS ochrání proti čistě pasivnímu man-in-the-middle útoku (ne že by byl pravděpodobný).

## Podepisování URL

Ochranu zajistí podepisování zaslané zprávy, přesněji query stringových parametrů URL. Tomuto tématu jsem se už na tomto blogu věnoval ve [dvou](https://www.altair.blog/2019/08/url-signer) [článcích](https://www.altair.blog/2019/08/url-signer-jeste-jednou).

Používám zde algoritmus HMAC (Hash Message Authentication Code). Každé zařízení má svůj vlastní tajný klíč. To jsou náhodně vygenerovaná data, pro každé zařízení jiná, známá jenom tomu zařízení (jsou uložena v konfiguraci) a serveru, který má podpis ověřit. HAMC funguje tak, že se vezme podepisovaná zpráva a přidá se k ní tajný klíč a z toho celého se spočítá kryptografický hash, v našem případě SHA256.

> Celý ten mechanismus je o něco komplikovanější, aby byl celý proces odolnější proti různým druhům útoků. Podrobnější informace najdete příkladmo na [Wikipedii](https://en.wikipedia.org/wiki/HMAC).

Prosté podepisování dat by ale umožnilo _replay attack_. Útočník sice nedokáže zprávu padělat, ale dokáže validní zprávu zachytit a odeslat později. Abychom tomu zabránili, musíme každou zprávu učinit jedinečnou a neopakovatelnou. V předchozích článcích o URL signeru jsem to řešil přidáváním časového údaje. Jenomže to zde udělat nemůžeme, protože ESP8266 neví kolik je hodin. Naštěstí pro nás však existuje alternativa: prosté počítadlo. Zařízení (i server) si budou evidovat, kolik zpráv již bylo odesláno. A s každou zprávou se pořadové číslo zvýší o jedničku a přidá se ke zprávě samé.

Pokud vás zajímá, jak to celé bude implementováno v C# kódu, počkejte si do příštího čtvrtka na další pokračování tohoto seriálu.