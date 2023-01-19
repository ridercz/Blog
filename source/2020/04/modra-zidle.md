<!-- dcterms:title = Modrá židle: modelování zase trochu jinak -->
<!-- dcterms:abstract = Praktické modelování v OpenSCADu a využití 3D tisku zase trochu jinak. Často se mne ptáte, co vlastně na 3D tiskárně tisknu. Většinu tvoří různé držáky, krabičky - a náhradní díly. Tohle je ukázka toho třetího případu. A zase trochu jiné techniky modelování v OpenSCADu. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:coverUrl = /cover-pictures/20200406-modra-zidle.jpg -->
<!-- x4w:pictureUrl = /perex-pictures/20200406-modra-zidle.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = 3D tisk -->
<!-- dcterms:date = 2020-04-06 -->

Praktické modelování v OpenSCADu a využití 3D tisku zase trochu jinak. Často se mne ptáte, co vlastně na 3D tiskárně tisknu. Většinu tvoří různé držáky, krabičky - a náhradní díly. Tohle je ukázka toho třetího případu. A zase trochu jiné techniky modelování v OpenSCADu.

## Problém

Máme doma židli. Tedy, my máme doma spoustu židlí, ale teď jde o jednu zcela konkrétní, kuchyňskou. Modrou, ale to je podstatné pouze pro nás doma, abychom věděli, o které je řeč. Přesněji, o kterých. Máme dvě. Koupené v bazaru za pár korun před více než deseti lety a dost rozvrzané. Mimo jiné protože při cestě věky ztratily pár takových plochých kovových součástek, které je pomáhají držet pohromadě.

Kde bych vzal nové nevím, tak jsem se rozhodl vytisknout nové z PETG. Nebudou tak pevné jako kovové, ale lepší něco než nic. Celé to vypadá takhle - kovový díl vpravo je originál, bílý vlevo je plastový výtisk z 3D tiskárny.

![](https://www.cdn.altairis.cz/Blog/2020/20200406-modra-zidle-01.jpg)

## Měření

Při vytváření náhradního dílu je zpravidla třeba začít měřením. V lepším případě dílu který máte (a je třeba vytvořit kopii), v horším pak jeho okolí a vymyslet díl, o kterém sice nevíte jak původně vypadal, ale potřebujete funkčně ekvivalentní náhradu.

![](https://www.cdn.altairis.cz/Blog/2020/20200406-modra-zidle-02.jpg)

Mně po chvilce s posuvným měřítkem vyšel takovýhle nákres, který by mému učiteli technického kreslení z průmyslovky, panu Smrtovi, způsobil nejspíš smrt, ale pro náš účel je dobrý víc než dost. 

Díl je triviální a dá se změřit docela dobře, bývá to horší.

## Návrh

Pro návrh jsem se rozhodl použít jako základ funkci `polygon`. Základní tvar je obdélník se zkoseným rohem a zaznamenat si souřadnice jeho vrcholů (na nákresu jsou červeně) je velmi jednoduché.

![](https://www.cdn.altairis.cz/Blog/2020/20200406-modra-zidle-03.png)

Odečíst od něj kombinaci (`hull`) kruhu a čtverce je triviální, stejně jako "vytáhnout" ho do požadované výšky 3 mm.

![](https://www.cdn.altairis.cz/Blog/2020/20200406-modra-zidle-04.png)

Kód v OpenSCADu vypadá takto:

```scad
base_points = [
    [ 0,  0],
    [25,  0],
    [25, 12],
    [22, 15],
    [ 0, 15]
];

linear_extrude(3) difference() {
    // Base shape
    polygon(points = base_points);
    
    // Cutout
    translate([25 / 2, 6]) hull() {
        circle(d = 6, $fn = 16);
        translate([-3, -20]) square([6, 2]);
    }
}
```

Žádná velká kouzla v něm nehledejte. Není dokonce ani parametrizovaný, všechno píšu natvrdo, protože u tohoto modelu parametrizace nedává smysl.

## 3D tisk

Ani tisk není tentokrát nijak komplikovaný. Pouze jsem jako materiál použil místo obvyklého PLA materiál PETG, protože je pevnější a houževnatější, což se může hodit, protože tento díl slouží v podstatě jako podložka, proti které se přitahuje šroub. A vytiskl jsem ho 4&times;, i když jsem potřeboval jenom dva kusy, protože u malých výtisků je dobré jich dělat víc najednou, aby se výtisk stihl chladit a nedeformoval se teplem.

![](https://www.cdn.altairis.cz/Blog/2020/20200406-modra-zidle-05.jpg)

Pak stačilo díl jenom namontovat zespodu pod sedák a židle je... no, ne jako nová, ale rozhodně ještě nějakou dobu poslouží.

![](https://www.cdn.altairis.cz/Blog/2020/20200406-modra-zidle-06.jpg)