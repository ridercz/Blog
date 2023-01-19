<!-- dcterms:title = Moje vybavení pro live stream: OBS control rig -->
<!-- dcterms:abstract = Příští týden mne čekají hned tři live streamy a proto jsem se rozhodl poněkud upgradovat svou streamovací sestavu, dosud používanou převážně na dálková školení. Vyrobil jsem také hardwarovou konzoli (rig) na ovládání OBS Studia. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20190302-obs-control.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20190302-obs-control.jpg -->
<!-- x4w:category = Bastlení -->
<!-- dcterms:date = 2019-03-02 -->

Příští týden mne čekají hned tři live streamy (v pondělí a úterý o [pamětech v Arduinu](/2019/03/pameti-v-arduinu) a ve čtvrtek budeme [pokračovat s přepisem AskMe do DotVVM](/2019/02/askme-dotvvm-1-zaznam)) a proto jsem se rozhodl poněkud upgradovat svou streamovací sestavu, dosud používanou převážně na dálková školení. Vyrobil jsem také hardwarovou konzoli (rig) na ovládání OBS Studia.

## Hardware

Ke streamování používám svou hlavní pracovní stanici. Je to klasický desktop a procesorem AMD Ryzen 5, 32 GB RAM, hromadou disků a připojenými čtyřmi monitory. K tomu mám Microsoft LifeCam Studio, což je velmi kvalitní USB webkamera s Full HD rozlišením a slušnou optikou.

Mám ještě několik dalších HD kamer, které chci natáhnout na další místa, až budu zase něco pájet nebo dělat s hardwarem, ale s tím jsem zatím ještě nic zásadního nedělal.

## Software a nastavení

Ke streamování používám program [OBS Studio](https://obsproject.com/). Ten umí pracovat s několika různými zdroji obrazu a zvuku (obrazovka, kamera, video soubor, framegrabber atd.) a různě je mixovat přes sebe a podobně. Výsledný signál umí lokálně nahrávat a přes RTSP posílat na různé video servery, které ho posílají dál do světa. Já mám zkušenosti s YouTube a Facebook Live, Tomáš Herceg zase používá Twitch.

V OBS Studiu lze definovat "Scény", které obsahují obraz z různých zdrojů a mezi kterými se lze jednoduše přepínat:

<figure>
    <img src="https://www.cdn.altairis.cz/Blog/2019/20190302-obs-scene1.png" alt="Camera only" />
    <figcaption>Scéna "Camera only" obsahuje pouze obraz z kamery a zvuk ze stolního mikrofonu. Tuto scénu používám, když něco vykládám a není důležité, co je na obrazovce.</figcaption>
</figure>
<figure>
    <img src="https://www.cdn.altairis.cz/Blog/2019/20190302-obs-scene2.png" alt="Screen only" />
    <figcaption>Scéna "Screen only" obsahuje obrazovku mého hlavního monitoru. Je trochu ořízlý, protože používám rozlišení 1920&times;1200 a stream je jenom 1920&times;1080. Chybí tedy 60px nahoře a 60px dole. Což většinou nevadí a přijde mi to jako menší zlo, než zmenšovat obraz a doplnit ho černými pruhy po stranách. Tuto scénu používám, když chci, aby diváci přesně viděli, co dělám na obrazovce.</figcaption>
</figure>
<figure>
    <img src="https://www.cdn.altairis.cz/Blog/2019/20190302-obs-scene3.png" alt="Screen + camera" />
    <figcaption>Scéna "Screen + Camera" obsahuje zmenšenou obrazovku a oříznutý obraz z kamery. Používám ji, když vykládám s prezentací, takže zmenšení nevadí a zároveň je dobré vidět i přednášejícího.</figcaption>
</figure>
<figure>
    <img src="https://www.cdn.altairis.cz/Blog/2019/20190302-obs-scene4.png" alt="Brand loop 01" />
    <figcaption>Scéna "Brand loop 01" obsahuje video, logo firmy na abstraktním pozadí.</figcaption>
</figure>
<figure>
    <img src="https://www.cdn.altairis.cz/Blog/2019/20190302-obs-scene5.png" alt="Brand loop 02" />
    <figcaption>Scéna "Brand loop 02" obsahuje jiné video podobného typu. Tyto scény používám na začátku a na konci streamu, případně když z nějakého důvodu potřebuju vypnout zvuk nebo nic nesdílet. Video je vhodnější než statický obrázek, protože diváci vidí, že se tam pořád něco hýbe a že stream běží.</figcaption>
</figure>

## Ovládací panel

OBS se samozřejmě dá ovládat pomocí myši, klávesových zkratek nebo dotykové obrazovky. Pro rychlou práci ale není nic lepšího, než klasická hardwarová tlačítka.

Vyrobil jsem si tedy ovládací panel, který používá velká barevná tlačítka z hracích automatů:

![OBS Control Rig](https://www.cdn.altairis.cz/Blog/2019/20190302-rig-front.jpg)

Pět barevných tlačítek dole přepíná scény. Červené hranaté tlačítko spouští a zastavuje záznam, zelené hranaté tlačítko pak streamování. Obě hrataná tlačítka jsou podsvícená a pokud běží záznam nebo stream, svítí. Komunikace mezi ovládacím panelem a OBS je ale jednosměrná, panel neví zda se skutečně nahrává nebo ne, ví jenom kolikrát bylo stisknuto příslušné tlačítko. Předpokládá se, že po zapojení panelu nebude OBS Studio ovládáno jinak.

Celý panel je postaven na desce Arduino Pro Micro, která obsahuje procesor ATmega32u4. Ten umí mimo jiné emulovat USB klávesnici. Panel nedělá nic jiného, než že posílá do počítače klávesové zkratky _Ctrl+Alt+Shift+F1_ až _Ctrl+Alt+Shift+F7_. Ty jsem v nastavení OBS namapoval na přepínání výše uvedených scén a start/stop záznamu a streamu.

Fyzicky je panel vyrobený kombinací několika technologií:

* Hlavní skříňka je vytištěna na 3D tiskárně.
* Na ní je položený potištěný papír vyřezaný na řezacím plotteru, který obsahuje popisky scén.
* Papír je přikrytý 2 mm silným plexisklem, které ho chrání proti ušpinění a jinému poškození.

Myšlenka je, že papír by mělo být možné snadno vyměnit, podle toho jaký bude význam tlačítek.

Tato konstrukce se v praxi neosvědčila. Takhle velký model se na 3D tiskárně tiskne dlouho a nikdy se mi nepodařilo ho vytisknout úplně dokonale. Je přijatelný, ale není zcela přesný. Proto jsem se rozhodl vytvořit novější model, který bude mít skříňku vyřezanou na laseru z překližky a trochu jinak udělaný kryt z plexi.

Pokud vás zajímají podklady pro výrobu a zdrojové kódy, [najdete je na mém GitHubu](https://github.com/ridercz/ObsControl).