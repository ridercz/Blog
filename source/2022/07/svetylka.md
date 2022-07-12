<!-- dcterms:title = Výroba vodotěsných LED lampiček za pár korun -->
<!-- dcterms:abstract = Začaly prázdniny a možná by se vám hodily jednoduché LED lampičky, které jsou navíc vodotěsné. Ukážu vám jak takové vyrobit s pomocí dózy od žvýkaček, CR2032 baterie, svítivé diody a (volitelně) trochy 3D tisku. Výrobu zvládnou i děti. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:coverUrl = /cover-pictures/20220712-svetylka.jpg -->
<!-- x4w:pictureUrl = /perex-pictures/20220712-svetylka.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = Z-TECH -->
<!-- x4w:category = 3D tisk -->
<!-- x4w:category = Bastlení -->
<!-- dcterms:dateAccepted = 2022-07-12 -->

Začaly prázdniny a možná by se vám hodily jednoduché LED lampičky, které jsou navíc vodotěsné. Ukážu vám jak takové vyrobit s pomocí dózy od žvýkaček, CR2032 baterie, svítivé diody a (volitelně) trochy 3D tisku. Výrobu zvládnou i děti.

## Základní princip

Základní princip je jednoduchý: vezměte knoflíkovou baterii CR2032 a běžnou svítivou diodu (LED). LED dejte "obkročmo" na knoflíkovou baterii tak, aby se delší nožička LED dotýkala kladného pólu baterie a kratší nožička toho záporného. LEDka se rozsvítí. Můžete to celé přelepit lepící páskou, aby to drželo. Přidejte k tomu ještě neodymový magnet a máte _LED throwie_, malé světýlko, které můžete magneticky přichytit kamkoliv a páchat tak umění nebo [přispět k dopravní nehodě ministra vnitra](https://ct24.ceskatelevize.cz/domaci/1312748-v-havarovane-limuzine-cestoval-john-jel-pry-proverit-podezrele-krabicky).

Výdrž takového světýlka záleží na barvě použité LED, protože mají různý odběr. Ten stoupá s klesající vlnovou délkou, takže nejmenší odběr má červená LED, pak následuje žlutá, zelená a modrá. Nejkratší dobu vydrží bílé LED, které kombinují červenou, modrou a zelenou najednou. Obecně se ale pohybuje mezi 1-3 dny.

> Pro účely tohoto článku pomíjím různé speciality jako vysocesvítivé LED s velkým odběrem, infračervené, ultrafialové a podobné radosti. Laiků se to netýká a odborníci to stejně už vědí.

Takové světýlko ale má tu nevýhodu, že docela oslňuje a paradoxně není moc vidět, protože působí bodově. Je tedy třeba ho rozplýlit pomocí nějakého difuzéru. Můžete třeba na LEDku postavit láhev s vodou vyrobíte si improvizovanou lahvičku.

Nebo můžete umístit LEDku i s baterií do průsvitné (ne průhledné) lahvičky. Já ve velkém žeru žvýkačky JetGum, které Lidl prodává v malých bílých dózách, které jsou pro tento účel naprosto ideální. Mají tu výhodu, že jsou vodotěsné a prakticky nerozbitné.

## Co budete potřebovat

* Jakoukoliv **malou průsvitnou lahvičku**, např. zmíněnou dózu od žvýkaček, ale můžete použít cokoliv.
* **Baterie CR2032** můžete draze koupit v jakémkoliv elektru nebo trafice, levně v [IKEA](https://www.ikea.com/cz/cs/p/plattboj-lith-baterie-80291156/) nebo na [AliExpressu](https://s.click.aliexpress.com/e/_DmJmxVD).
* **Běžné LED**. Opět platí že je (relativně) draho koupíte v obchodech s elektrosoučástkami nebo velmi levně na AliExpressu. Tady je pár odkazů na různé typy:
    * [Různé barvy](https://s.click.aliexpress.com/e/_DkeZKeJ)
    * [Simulace plamene svíčky](https://s.click.aliexpress.com/e/_DCGvLj9)
    * [Měnící barvu (pomalu, rychle)](https://s.click.aliexpress.com/e/_DnEypfV)
    * [Blikající (prodlužuje výdrž na baterie)](https://s.click.aliexpress.com/e/_DCzBDMX)
* Volitelně **3D tištěný držáček** (viz dále).

## 3D tištěný držáček baterie a LED

Ten v zásadě nepotřebujete. Vystačíte si s lepící páskou, trochou modelíny, tavným lepidlem, čímkoliv čím ty tři věci (baterii, LED a lahvičku) dokážete spojit dohromady. Nicméně pokud disponujete 3D tiskárnou, můžete to celé udělat elegantně a opakovaně použitelně, protože lze snadno vyměnit baterii anebo LED vyjmout, pokud zrovna nemá svítit.

O modelování jsem natočil video pro kanál Z-TECH, který provozuji společně se Zásilkovnou:

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/okRb0nigA_o" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

Zde je výsledný kód a STL model:

<script src="https://gist.github.com/ridercz/062039f173a32b63391dea762da300ff.js"></script>

## Jak na to, krok za krokem:

<figure>
    <img src="https://www.cdn.altairis.cz/Blog/2022/20220712-svetylka-1.jpg" alt="Potřebný materiál" />
    <figcaption><b>Krok 1:</b> Potřebný materiál</figcaption>
</figure>

<figure>
    <img src="https://www.cdn.altairis.cz/Blog/2022/20220712-svetylka-2.jpg" alt="Instalace držáku" />
    <figcaption<b>Krok 2:</b> Dózu zbavte štítku a do víčka vložte vytištěný držák. Pokud nechce držet, přilepte ho tavným lepidlem nebo něčím podobným.</figcaption>
</figure>

<figure>
    <img src="https://www.cdn.altairis.cz/Blog/2022/20220712-svetylka-3.jpg" alt="Instalace baterie a LED" />
    <figcaption><b>Krok 3:</b>Do držáku zasuňte baterii a po stranách do trojúhelníkových zářezů i LED. Pokud nesvítí, zkuste ji otočit :)</figcaption>
</figure>

<figure>
    <img src="https://www.cdn.altairis.cz/Blog/2022/20220712-svetylka-4.jpg" alt="Výsledek" />
    <figcaption><b>Krok 4:</b> Výsledek - vodotěsné lampičky s rozptýleným světlem.</figcaption>
</figure>