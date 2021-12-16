<!-- dcterms:title = Jak zastavit robotické depo Zásilkovny: Představení projektu -->
<!-- dcterms:abstract = Zásilkovna nedávno otevřela své první robotické depo, kde zásilky místo lidí třídí roboti - nebo alespoň proti lidem hrají přesilovku. Ukážeme si, jak takové depo funguje a také jaký bude můj konstruktérský úkol: vyrobit tlačítko, které ho dokáže celé zastavit. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20211118-robodepo-1.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20211118-robodepo-1.jpg -->
<!-- x4w:category = Z-TECH -->
<!-- x4w:category = IT -->
<!-- x4w:serial = Robotické depo -->
<!-- dcterms:dateAccepted = 2021-11-18 -->

Zásilkovna před nedávnem ve Šterboholích otevřela nové depo. Je první svého druhu, protože zásilky v něm třídí roboti. Bez lidí se zatím úplně neobejdou, ale jsou jich skoro dvě stovky a hrají proti lidem výraznou přesilovku. Depo jsem navštívil a po technickém řediteli Zásilkovny, Adamu Hörzenbergerovi, vyzvěděl jak funguje. A zároveň jsem v rámci projektu dostal úkol: navrhnout tlačítko, které ho celé zastaví.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/oihLfHliR5g" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

## K čemu je dobré robotické depo?

Zjednodušeně řečeno funguje doprava balíčků v síti Zásilkovny tak, že se zásilka z podacího místa přiveze na nejbližší z padesáti dep po republice. Tam se zásilky roztřídí podle toho kam směřují a dovezou se do depa nejbližšího výdejnímu místu. Třídění lze dělat buďto ručně nebo automaticky pomocí třídící linky. Třídící linka má ovšem jednu zásadní nevýhodu: špatně škáluje. Když ji jednou postavíte, je těžké výrazně navýšit její kapacitu. Nebo ji přestěhovat. Nebo v ní vlastně udělat jakoukoliv změnu. Takže Zásilkovna většinově využívá při třídení lidskou práci.

Jenomže lidí je pro takovou práci škoda. Není příliš povznášející, lidé dělají chyby a obecně jich je málo a bylo by lepší jejich sílu a inteligenci využít pro poněkud sofistikovanější zadání. A proto vzniklo robotické depo, jedno z prvních svého druhu na světě (a určitě první v republice). Bez lidí se neobejde (zatím ještě, i to je v plánu), ale sto osmdesát robotů hraje proti lidem přesilovku.

V třídící hale se nachází dvoupatrové "molo", což je jakási rampa, po které jezdí roboti. Kolem mola jsou stanice, na kterých lidé u příchozí zásilky naskenují čárový kód a položí ji na připraveného malého robota. Ten ji odveze k některému ze skluzů, pro každý směr je jeden.

Počítače a roboti jsou rychlejší než lidé a dělají méně chyb a jsou výrazně levnější než klasická třídící linka. A hlavně, mnohem variabilnější. Molo lze jednoduše rozšířit, překonfigurovat, přestěhovat...

## Roboti na šachovnici

Zásilkovní robot je úžasný svou jednoduchostí. Je to v základu jednoduchý podvozek s elektromotory na spodní straně a malým dopravníkovým pásem na horní straně. Na pás obsluha položí zásilku, robot ji odveze k patřičnému shozu a pohybem pásu shodí. Roboti jezdí po speciálních gumových dlaždicích, které připomínají pěnové puzzle pro malé děti. Každý dlaždice má uprostřed RFID čip s unikátním identifikátorem, podle kterého robot ví, na které dlaždici se právě nachází. Dále pak obsahuje magnetické pásky a robot pomocí Hallových sond dokáže zjistit za prvé svou vlastní orientaci, kterým směrem stojí, ale také na centimetr přesnou pozici v rámci dlaždice.

Roboti sami jsou hotové řešení od čínského dodavatele a nejsou nijak zvlášť drazí, stojí něco okolo tří tisíc dolarů. Dají se snadno dokoupit a nahradit. Důležitý je ale systém který je řídí, říká jim kam a jak se mají pohybovat, aby k cíli dorazili nejefektivnější trasou a nikde se cestou nesrazili. Ten je dílem Zásilkovny.

Řídící systém sleduje i stav baterií robotů a drží jej v optimálním pásmu z hlediska životnosti. Pokud stav baterie poklesne pod 40 %, robot si samočinně zajede do nabíječky a několik minut se nabíjí. Vydrží tak fungovat zhruba hodinu či dvě, přičemž v tomto režimu - kdy se baterie chrání před přílišným vybitím i nabitím - má plánovanou životnost osm let.

## Jak zastavit robota?

I když je poměr robotů k lidem vysoce ve prospěch robotů, není nutné se obávat jejich vzpoury. Do pozitronických mozků schopných vstřebat - a případně porušit - Asimovovy tři robotické zákony mají ještě dosti daleko. Ale nehody se stávají. Špatně naložená zásilka může spadnout a zablokovat trasu a podobně. V takovém případě je nutné provoz na molu zastavit, problém vyřešit a pokračovat v práci. Jenomže zastavit čtyřikrát pětačtytřicet robotů (dvě mola po dvou patrech) není úplně jednoduché. Fungují částečně autonomně, takže nestačí "vyhodit jistič". Je nutné je zastavit softwarově.

Dostal jsem za úkol vyvinout zařízení, které to dokáže zajistit. Navenek bude vypadat velice jednoduše, klasické velké červené "STOP" tlačítko. Ale stiskem tlačítka se zavolá webhook (udělá HTTP request), který backendu řekne, co je třeba udělat. Zadání to není složité, ale úplně jednoduché také není. S jakými obtížemi se budu muset vyrovnat?

* Molo nabízí připojení k napájení (USB 5 V), ale ne žádnou datovou konektivitu. Veškerá komunikace probíhá přes Wi-Fi a i tlačítko bude muset komunikovat bezdrátově.
* Komunikaci je třeba rozumně zabezpečit, aby molo nedokázal zastavit každý, kdo jde kolem s mobilem. Nelze spoléhat na zabezpečení sítě jako takové, je třeba se chránit proti replay útokům...
* Tlačítek je třeba v první fázi vyrobit asi čtyřicet, postupně jich budou malé stovky. Což je trochu málo na nějaké zásadní originální hardwarové řešení, ale zase trochu moc na rozsáhlou ruční montáž. Je třeba správně navrhnout hardware, ale i nějaký provisioning a věci související.

Naštěstí ale už mám nápad jak se s tím vyrovnat a nenechám si ho pro sebe. Každý týden budu nyní na kanálu Z-TECH zveřejňovat jedno video, které bude popisovat stav vývoje a výsledek bude zveřejněn jako open source. Rešení není specifické pro Zásilkovnu, pomůže každému, kdo potřebuje tlačítko jehož stisknutím se spustí webhook.

Dnes si můžete prohlédnout první díl, který popisuje depo jako takové. Co nás čeká do budoucna? To v době psaní tohoto článku ještě nevím, ale můj plán je následující:

* Příští týden se podíváme na hardwarovou platformu. Jak bude tlačítko vypadat a na jaké platformě bude postavené. Mám několik prototypů, které vám představím.
* Další díl se bude věnovat zabezpečení. Provedeme jednoduchou bezpečnostní analýzu a vymyslíme, jak si v rámci zadání poradit s riziky, která pokládáme za relevantní.
* V dalším pokračování se detailněji podíváme na firmware, který v tlačítku poběží a také na software na serverové straně.
* Závěrem se podíváme na provisioning, na aplikaci pro konfiguraci parametrů zařízení a jejich celkovou správu.