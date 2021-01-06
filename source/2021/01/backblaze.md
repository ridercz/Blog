<!-- dcterms:title = Neomezená záloha pro každého za stovku měsíčně - nyní tři měsíce zdarma -->
<!-- dcterms:abstract = Uživatelé se prý dělí na dvě skupiny: jedni zálohují a druzí o svá data ještě nepřišli. Nicméně znám i takové, kteří o svá data přišli už několikrát a nezálohují furt. V každém případě, Backblaze pokládám za velmi dobré a zároveň levné řešení, vhodné pro běžné uživatele. A nyní běží promotion, v jejímž rámci máte možnost získat až tři měsíce zdarma. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/logo-backblaze.svg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20210106-backblaze.jpg -->
<!-- x4w:coverCredits = Backblaze.com -->
<!-- x4w:category = IT -->
<!-- dcterms:dateAccepted = 2021-01-06 -->

Uživatelé se prý dělí na dvě skupiny: jedni zálohují a druzí o svá data ještě nepřišli. Nicméně znám i takové, kteří o svá data přišli už několikrát a nezálohují furt. V každém případě, Backblaze pokládám za velmi dobré a zároveň levné řešení, vhodné pro běžné uživatele. A nyní běží promotion, v jejímž rámci máte možnost získat až tři měsíce zdarma.

## Co to je a proč by mě to mělo zajímat?

Backblaze Personal Backup je služba, která vám umožňuje zazálohovat za pevný měsíční poplatek neomezený objem dat z jednoho počítače do cloudu a kdykoliv ho obnovit zpět. Sleduje také třicet dnů historie změn, takže když si omylem smažete nebo změníte soubor (nebo vám ho třeba zašifruje nebo smaže malware), máte měsíc na to, abyste ho obnovili.

Obrovskou výhodou je, že všechno fugnuje zcela automaticky a ve výchozím nastavení se zálohuje prakticky všechno. Většina zálohovacích řešení funguje tak, že musíte vybrat, co se má zálohovat. Backblaze obecně zálohuje všechno, co mu explicitně nezakážete (plus má výjimky na někteté typu souborů, typicky různé pracovní a dočasné).

Výhodou je také fixní cena bez ohledu na objem dat. Neřešíte co zálohovat, protože vás to stojí stejné množství peněz.

> Backblaze nabízí i další služby, jako je zálohování pro firmy a univerzální úložiště B2. Ty ale nejsou předmětem tohoto článku.

## Kolik to stojí?

Služba Personal Backup není bezplatná, ale její cena je dle mého názoru velice nízká:

* Základní cena je $6 (~130 Kč) měsíčně, při měsíční platbě.
* Při platbě na rok dopředu platíte $60 (~1300 Kč), tj. $5 (~105 Kč) měsíčně.
* Při platbě na dva roky zaplatíte $110 (~2330 Kč), tj. $4,6 (~97 Kč) měsíčně.

**Do konce ledna má Backblaze výhodnou nabídku.** Pokud se zaregistrujete přes můj affiliate odkaz [altair.is/backblaze](https://altair.is/backblaze), dostanete zdarma měsíční období na vyzkoušení. Pokud se poté rozhodnete pro placenou službu, dostanete další dva měsíce zdarma, celkem tedy čtvrt roku zálohování zdarma. V rámci _full disclosure_ uvádím, že pokud použijete můj affiliate odkaz, dostanu zdarma stejnou dobu služby jako vy.

## Jak to funguje?

Po registraci si stáhnete a nainstalujete klienta (existuje pro PC a Mac), který veškerá data na vašich discích, která nejsou ve výjimkách, postupně nahraje na servery Backblaze a bude je průběžně udržovat aktuální. Ten proces prvotního nahrání dat může trvat docela dlouho (klidně i několik týdnů), v závislosti na jejich objemu a rychlosti vaší linky. Není třeba se o nic starat či řešit a nastavovat, 

Pokud o svá data přijdete (třeba si je omylem smažete, nebo vám odejde disk, nebo vám je zašifruje ransomware), můžete je zpětně obnovit. Udržují se i starší verze dokumentů, a to třicet dnů zpětně. Tj. pokud si např. přepíšete omylem novější verzi souboru nějakou starší, není problém ji obnovit s delším časovým odstupem. Backblaze za příplatek nabízí též prodloužení této doby (tj. uchovávání starších verzí souborů za delší dobu).

Data můžete obnovit buďto tím, že si je stáhnete přes Internet, nebo si je (za poplatek) můžete nechat poslat na disku nebo flashce kurýrem. Což se hodí, pokud máte hodně dat k obnově a pomalou linku. Pokud médium vrátíte, podstatnou část toho poplatku vám vrátí zpátky.

Data můžete šifrovat symetrickým klíčem, který zůstává jenom na vašem počítači a Backblaze tedy nemá k vašim datům přístup. Nevýhodou je, že klíč musíte pro obnovu zadat a provozovatel se ho tedy při obnově dozví (neumí vám poslat data zašifrovaná, abyste si je sami rozšifrovali). Pokud ale máte takové nároky na bezpečnost, že to nejste ochotni riskovat, můžete si data šifrovat sami (např. pomocí VeraCryptu) a zálohovat vámi šifrovaná data.

## Co Backblaze Personal Backup není a co neumí

* Není to univerzální úložiště, jako třeba OneDrive, DropBox nebo Google Drive. Je to služba specificky určená k zálohování.
* Není to nástroj na synchronizaci, kterou kromě výše zmíněných nabízí třeba i Resilio Sync (dříve BitTorrent Sync).
* Uní zálohovat i externí disky (třeba USB disky nebo flashky), ale musíte je pravidelně připojovat k počítači, nejméně jednou za měsíc.
* Nehodí se v případě, že máte hodně dat a pomalý upload (uplink) nebo omezený objem dat.

U běžných způsobů připojení k Internetu (jako je xDSL nebo kabelovka) je typické, že jsou asymetrické. Pokud data stahujete, je to rychlejší (i řádově), než když je na Internet nahráváte. Vychází se přitom z toho, že běžný uživatel víc dat stahuje než nahrává. Pro rychlost zálohování je podstatná právě rychlost uploadu (uplinku), což je to _menší_ číslo, které se uvádí u parametrů vašeho připojení. Pokud tedy máte pomalé připojení (třeba u starého ADSL může být jenom 512 kb/s), bude nahrávání velkého objemu dat trvat neprakticky dlouho.

<figure>
    <img src="https://www.cdn.altairis.cz/Blog/2021/20210106-backblaze-vodafone.png" alt="Nabídka připojení přes kabelovku Vodafone"/>
    <figcaption>Například na této nabídce připojení od Vodafone přes kabelovou televizi je podstatná rychlost "nahrávání" (v desítkách Mb/s) nikoliv "stahování" (ve stovkách Mb/s).</figcaption>
</figure>

Další problém může být, pokud je vaše připojení omezeno objemem dat (tzv. FUP), typicky u mobilního připojení.

## Praktické tipy pro využití

Já osobně Backblaze využívám tak, že mám klienta nainstalovaného na počítači, kam se kopírují a synchronizují data ze všech počítačů celé smečky. A tento počítač je pak celý zálohován do Backblaze. Mám tam takto zálohováno několik terabajtů dat, za cenu méně než sto korun měsíčně.

Pokud máte pomalé připojení, můžete zkusit prvotní zálohu provést odjinud. Počítač nechat připojený někde, kde je tlustá linka (u známého nebo třeba v práci), dokud záloha nedoběhne. Další změny bývají objemově docela malé (pokud třeba netočíte kvanta videa a podobně) a lze je rozumně nahrát i po pomalé lince.