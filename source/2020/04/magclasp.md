<!-- dcterms:title = Magnetická spona nejen na roušku: proces vývoje a model v OpenSCADu -->
<!-- dcterms:abstract = Jako většinu národa mne zasáhla moudrost naší vlády, která nejdřív občanům zakázala koupit si účinnou ochranu před šířením koronaviru a poté jim přikázala nosit aspoň tu neúčinnou. Protože mne štve zavazování čehokoliv a zejména když na to nevidím, rozhodl jsem se, že na tkaničky od roušky potřebuji nějakou inteligentní sponu. Výsledkem je model univerzální parametrické spony v OpenSCADu, který vám dávám k dispozici. Zároveň popíšu celý proces vzniku modelu, jako jakýsi doplněk svého nedávného online školení o modelování v OpenSCADu. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:coverUrl = /cover-pictures/20200404-magclasp.jpg -->
<!-- x4w:pictureUrl = /perex-pictures/20200404-magclasp.png -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = 3D tisk -->
<!-- dcterms:date = 2020-04-04 -->

Jako většinu národa mne zasáhla moudrost naší vlády, která nejdřív občanům zakázala koupit si účinnou ochranu před šířením koronaviru a poté jim přikázala nosit aspoň tu neúčinnou. Protože mne štve zavazování čehokoliv a zejména když na to nevidím, rozhodl jsem se, že na tkaničky od roušky potřebuji nějakou inteligentní sponu. Výsledkem je model univerzální parametrické spony v OpenSCADu, který vám dávám k dispozici. Zároveň popíšu celý proces vzniku modelu, jako jakýsi doplněk svého nedávného online školení o modelování v OpenSCADu.

## Zadání

Při návrhu je třeba nejprve definovat problém a požadované řešení. Moje zadání je následující:

* Spona musí fungovat na bavlněnou tkanici šířky 20 mm (s možnou parametrizací pro jiné šířky).
* Sponu musí být snadné zapnout a rozepnout poslepu, s rukama za hlavou.
* Spona musí držet spolehlivě a musí vydržet opakované rozepínání a zapínání.
* Tkanici musí být možné ve sponě utáhnout tak, aby maska dobře držela.
* Bude-li řešení zahrnovat 3D tisk, měl by model být jednoduchý na tisk, bez nutnosti používat podpory.

## Existující řešení

Samozřejmě nejjednodušší je použít nějaké existující řešení, než vytvářet vlastní. Jako první se nabízí použít klasické "trojzubce", plastové spony, které se běžně používají u batohů a všude možně. Nicméně ty v rozměru 20 mm nemám a nejsem schopen je v tomto okamžiku rychle koupit. Kromě toho nesplňují podmínku snadného zapínání za hlavou, alespoň pro mne.

![](https://www.cdn.altairis.cz/Blog/2020/20200404-magclasp-01-trojzubec.jpg)

Dále jsem se podíval na [Thingiverse](https://www.thingiverse.com/) a [PrusaPrinters.org](https://www.prusaprinters.org/), jestli tam nenajdu něco použitelného. Bohužel jsem nebyl úspěšný. Asi nejvíc se mému zadání blížil model [Clasp 50mm](https://www.thingiverse.com/thing:2146656/files) od uživatele _Nys1_, ale z mého pohledu má řadu nevýhod:

* Je navržený na šířku 50 mm a není parametrický.
* Nedá se orientovat tak, aby se netisklo "do vzduchu", což je problém.
* Nejsem si jist, jak by splňoval podmínku snadnosti použití.

## Moje vlastní řešení

Napadlo mne pro sponu použít neodymové magnety. S magnety při návrhu pracuji často a rád, protože se snadno dají zalepit nebo zatisknout do modelu a lze je použít pro relativně pevné a přitom opakovaně použitelné spojení. Navíc se magnety umí samy "slícovat", což usnadňuje použití.

Ukázkové modely v tomto článku jsou záměrně tištěné z částečně průhledného materiálu, takže jsou magnety vidět. To samozřejmě není podmínkou.

![](https://www.cdn.altairis.cz/Blog/2020/20200404-magclasp-02-prototyp.jpg)

Moje první řešení spoléhalo čistě na přídržnou funkci magnetů. Ty jsem zatiskl do jednoduchého plastového držáku, který se navlékne na tkanici. Toto řešení bohužel nefungovalo, protože magnety neměly pro tento účel dostatečnou sílu, masku nebylo možné dostatečně utáhnout.

![](https://www.cdn.altairis.cz/Blog/2020/20200404-magclasp-03-final.jpg)

Druhá verze proto přidala ještě výčnělek, který zapadá do otvoru v protikusu. To drží sponu zavřenou ve směru tahu tkanice. Magnety pak působí ve směru kolmém, drží jenom dvě části spony u sebe. V tomto směru je jejich síla větší a zároveň je spona v tomto směru namáhána minimálně. Zapínání na podobném principu jsem už v minulosti viděl, takže jsem ho jenom upravil pro své potřeby.

Výsledný model vypadá takto:

<script src="https://gist.github.com/ridercz/930a9afaa381601c04744996d75be718.js"></script>

## Modelování v OpenSCADu

Pro modelování jsem využil samozřejmě svůj oblíbený OpenSCAD. Pro zjednodušení jsem navrhl sponu tak, že oba dva díly jsou zcela identické, liší se jenom orientací vložených magnetů. Pro zapínání klasické masky se dvěma páry tkalounů tedy potřebujete vytisknout čtyři kusy (dva páry).

Výsledný kód vypadá takto:

<script src="https://gist.github.com/ridercz/d403dfe63ca1fbc37a08617bdc7583ba.js"></script>

Pojďme si nyní probrat jeho konstrukci a techniky, které jsem v OpenSCADu využil. Základní princip je jednoduchý: jde v podstatě o 2D tvar vytažený do výšky, ve kterém je jedna část "vykousnutá" a dá se do ní vložit protikus.

Při návrhu jsem využil svou [knihovnu A2D](https://github.com/ridercz/A2D), protože mi umožňuje snadno dělat tvary se zaoblenými rohy. Zaoblené rohy vypadají lépe, jsou příjemnější na omak a také se snáze tisknou, protože tiskárna může jet plynule a nemusí se na rohu zastavit při náhlé změně směru o 90°.

Tu tedy referencuji na začátku souboru a ověřím si, že má správnou verzi:

```scad
include <A2D.scad>; // https://github.com/ridercz/A2D
assert(a2d_required([1, 5, 0]), "Please upgrade A2D library to version 1.5.0 or higher.");
```

### Parametrický návrh

Prakticky při každém návrhu začínám definicí proměnných. Mám pevně dané některé rozměry (zde magnetu a tkanice) a od nich je pak odvozeno všechno ostatní. Proměnné jsou zároveň opatřeny komentáři pro použití rozhraní Customizer, protože mne to v zásadě nic nestojí.

```scad
/* [General] */
// Render two parts clasped together
render_preview = false;
// Add holding peg and corresponding hole
use_peg = true;
```

Je-li hodnota `render_preview` nastavena na `false`, což je výchozí hodnota, vykreslí se jeden model, který lze vyexportovat a poslat na tiskárnu. Je-li nastavena na `true`, tak se vykreslí modely dva, napozicované proti sobě tak, jak budou v zapnutém stavu. To umožní vizuálně zkontrolovat, že všechno sedí.

Proměnná `use_peg` umožňuje zapnout (`true`, výchozí nastavení) nebo vypnout (`false`) generování kolíku a odpovídajícího otvoru. Pokud bude generování vypnuto, vytvoří se první verze spony, která spoléhá jenom na přídržnou sílu magnetů. To se může hodit pro jiné scénáře použití, silnější magnety a podobně.

Parametrizace nemusí spočívat pouze ve změně rozměru, ale i v chování modelu.

```scad
/* [Ribbon] */
// Width of ribbon tape
ribbon_width = 20;      // [20:50]
// Thickness of ribbon (width of hole)
ribbon_thickness = 3;   // [2:10]
// Number of holes
ribbon_holes = 2;       // [1, 2, 3]
```

Proměnné v sekci _Ribbon_ nastavují šířku tkalounu (`ribbon_width`, 20 mm), tloušťku otvorů pro něj (`ribbon_thickness`, aby se dal otvorem provléknout, případně i dvakrát vedle sebe), tu jsem odhadl na 3 mm. Proměnná `ribbon_holes` pak určuje počet otvorů. Může být třeba jeden (pokud bude tkaloun pevně přišitý), dva (pro provléknutí tkalounu a držení frikcí) nebo tři (pevnější uchycení, vhodné třeba pro hladké materiály, ale zvětšuje sponu).

```scad
/* [Magnet] */
// Diameter of magnet hole
magnet_diameter = 11;
// Height of magnet hole
magnet_height = 1.8;
// Amount of material under and over magnet, should be 2-4 layers
magnet_cover = .4;
```

Proměnné v sekci _Magnet_ určují rozměry magnetu. Přesněji rozměr díry pro něj. Mnou použité magnety mají průměr 10 mm a tloušťku 1,7 mm. 

Průměr díry jsem udělal o milimetr větší. V 3D tisku jsou díry vždy ve skutečnosti o něco menší, než v modelu. Je to dáno tím, že průměr otvoru je ve skutečnosti průměr kružnice opsané pravidelnému mnohoúhelníku a z tohoto titulu je skutečný otvor o maličko menší. Navíc roztavený plast má tendenci se maličko "slévat", což otvor dále zmenšuje. V praxi je tedy třeba otvory navrhovat o něco větší, řádově o 0,5 až 1 mm, podle průměru, nastavení tiskárny, materiálu... Další variantou je otvory po tisku protáhnout vrtákem o přesném průměru, ale to zde nelze použít, protože magnet bude zatisknutý uvnitř modelu a budu ho vkládat v průběhu tisku. Navíc i kdyby magnet v otvoru trochu "plaval", při této konstrukci to vadit nebude.

Výška díry je o 0,1 mm větší, než výška magnetu. Je tomu tak opět ze dvou důvodů. První je, že počítám s tiskem s výškou vrstvy 0,2 mm a tedy je žádoucí, aby všechny horizontální plochy měly výšku v násobcích výšky vrstvy. Druhý je, že při zatiskávání čehokoliv do modelu nesmí zatiskávaný předmět (magnet, matice, ložisko...) vůbec přečnívat, protože by do něj mohla narazit tisková hlava a výtisk zkazit.

Proměnná `magnet_cover` určuje, kolik materiálu bude pod a nad zatisknutým magnetem. Chci aby byla spona co možná nejtenčí, ale zároveň aby držela. Zkušenost říká, že pro tento účel jsou vhodné nejméně dvě vrstvy materiálu, tedy 0,4 mm. Pokud bych zatiskával matici, bylo by patrně nutné použít vrstev více, aby ji bylo možné přitáhnout, ale tady mi dvě vrstvy stačí.

```scad
/* [Other] */
// Minimal wall thickness, should be 4 perimeters
wall_thickness = 1.67;
// Radius of rounded corners
corner_radius = 3;
// Clearance of pegs
part_clearance = 1;
```

Sekce _Other_ obsahuje proměnné, které se jinam nehodily:

* `wall_thickness` je minimální tloušťka svislé stěny, kterou v modelu chci mít. Zkušenost říká, že obecně by to měly být čtyři perimetry, což u standardní trysky o průměru 0,4 mm odpovídá 1,67 mm.
* `corner_radius` je poloměr zaoblení rohů. Při předpokládané velikosti mi 3 mm přišly tak akorát.
* `part_clearance` je tolerance jednotlivých částí. Má-li být možné do sebe části vložit (zasunout kolík do otvoru), musí být průměr kolíku o něco menší, než průměr otvoru a podobně. Nastavení tolerance je závislé na druhu modelu, účelu spoje a vlastnostech tiskárny. Já ho obvykle nastavuji jako 0,25-1 mm. Zde jsem sáhl po relativně vysoké hodnotě 1 mm, protože určitá vůle není na závadu, naopak je žádoucí, aby se spona dala snadno sestavit a rozebrat.

```scad
/* [Hidden] */
$fudge = 1;
total_width = ribbon_width + 2 * wall_thickness;
module_length = ribbon_width / 2 + (wall_thickness + ribbon_thickness) * (ribbon_holes + 1);
module_height = magnet_height + 2 * magnet_cover;
polygon_sides = 6;
polygon_angle = 180 / polygon_sides;
```

Sekce _Hidden_ se v customizeru nezobrazuje. Obsahuje hodnoty, které nepředpokládám, že by uživatel měnil, nebo které jsou vypočítané z těch zadaných.

* `$fudge` je hodnota pro zamezení vzniku stěn o nulové šířce. Zvětším o ni hodnoty odečítané od základního tvaru.
* `total_width` je celková šířka spony (rozměr ve směru osy Y). Je to šířka tkalounu plus minimální tloušťka zdi z každé strany kolem.
* `module_length` není celková délka spony, ale délka části vlevo od středu (ve směru osy X). Šetiúhelníková část, kde se spony překrývají, bude na středu a tato proměnná je vypočítána tak, aby se vedle šestiúhelníku přesně vešel zkonfigurovaný počet otvorů plus stěny mezi nimi. Jednu šířku otvoru pak přidávám jako vzdálenost mezi šestiúhelníkem a jemu nejbližším otvorem (ve skutečnosti bude užší o polovinu tolerance, ale k tomu se dostaneme později).
* `module_height` je polovina výšky modelu (rozměr v ose Z). Ta je určena výškou magnetu (resp. otvoru pro něj) plus materiálem, který má být nad ním a pod ním.
* `polygon_sides` je počet stran šestiúhelníku a `polygon_angle` úhel jeho vrcholů od středové osy. Model napevno počítá s šestiúhelníkem, ale přijde mi čitelnější tu hodnotu psát v podobě proměnné (resp. spíše konstanty, ale OpenSCAD konstanty a proměnné nerozlišuje), aby bylo jasné, co znamená.

Tohle je koncept, který u svých modelů používám často. Zadám jenom minimální nutné hodnoty a zbytek dynamicky vypočítám z nich tím, že použiju jednu hodnotu pro víc účelů (zde např. šířku díry na tkaloun pro výpočet vzdálenosti díry od šestiúhelníku) nebo použiju nějaký koeficient, kterým hodnoty vynásobím. Zjednodušuje to parametrizovatelnost modelu. Na druhou stranu, ta není neomezená. Když se zadají extrémní hodnoty, nebo hodnoty ve vzájemném nesouladu, model nebude fungovat. Například tento design počítá s tím, že průměr magnetu bude nejvýše zhruba polovina šířky tkalounu. Pokud bu byl větší, bude magnet zasahovat do díry pro kolík.

### Základní 2D návrh

Model je definován v modulu `part`. To mi umožňuje s ním jednoduše manipulovat, jako třeba udělat více kopií a napozicovat je vůči sobě a podobně.

Základem je tento 2D tvar:

![](https://www.cdn.altairis.cz/Blog/2020/20200404-magclasp-04-2d.png)

V levé části je obdélník se zaoblenými rohy, v pravé pak šestiúhelník se zaoblenými rohy. Ty jsou spojeny do jednoho celku funkcí `hull` (je to jednodušší, než počítat rozměr obdélníku tak, aby se přesně potkal).

Do tohoto tvaru pak jsou udělány díry pro tkaloun a díra pro kolík. Kód, který to všechno zařizuje, vypadá takto:

```scad
difference() {
    // Main shape
    hull() {
        r_regpoly(od = total_width, vertices = polygon_sides, radius = corner_radius, $fn = 16);
        translate([-module_length, -total_width / 2]) r_square([corner_radius * 2, total_width], corner_radius, $fn = 16);
    }

    // Ribbon holes
    hole_xpos = [ for(i = [0:ribbon_holes - 1]) -module_length + wall_thickness * (i + 1) + ribbon_thickness * i ];
    for(x = hole_xpos) translate([x, -ribbon_width / 2]) r_square([ribbon_thickness, ribbon_width], ribbon_thickness / 2, $fn = 16);

    // Peg hole
    if(use_peg) translate([-corner_radius / 2, 0]) hull() 
        for(a = [-180 + polygon_angle, +180 - polygon_angle]) translate(vector_point(alpha = a, delta = total_width / 2 - corner_radius))
            circle(d = corner_radius + part_clearance, $fn = 16);
}
```

### Odečtení otvoru pro druhou část

Tento tvar je pak příkazem `linear_extrude(module_height * 2)` vytažen do výšky. Je od něj ale nutné odečíst tvar o polovině výšky, aby se daly dva díly dát do sebe.

Nejjednodušší řešení by bylo udělat tvar "společné" části prostě obdélníkový a odečíst kvádr. Já jsem se rozhodl pro tvar šestiúhelníku. Dílem z důvodů estetických, ale také protože "vede" dvě části k sobě a mírně omezuje namáhání ve směru osy Y.

Odečtený tvar je o něco větší (šestiúhelník má větší průměr o 1 mm tolerance). Je tomu tak jednak kvůli prevenci vzniku stěny o nulové šířce a jednak kvůli toleranci tisku.

V této fázi také vytvořím válcovou díru pro magnet. Ta není na modelu vidět, protože je ze všech stran zakryta, ale uvidíme ji ve sliceru.

Kód pro vytvoření téměř celé části vypadá takto:

```scad
difference() {
    // Extruded base 2D shape
    linear_extrude(module_height * 2) difference() {
        // Main shape
        hull() {
            r_regpoly(od = total_width, vertices = polygon_sides, radius = corner_radius, $fn = 16);
            translate([-module_length, -total_width / 2]) r_square([corner_radius * 2, total_width], corner_radius, $fn = 16);
        }

        // Ribbon holes
        hole_xpos = [ for(i = [0:ribbon_holes - 1]) -module_length + wall_thickness * (i + 1) + ribbon_thickness * i ];
        for(x = hole_xpos) translate([x, -ribbon_width / 2]) r_square([ribbon_thickness, ribbon_width], ribbon_thickness / 2, $fn = 16);

        // Peg hole
        if(use_peg) translate([-corner_radius / 2, 0]) hull() 
            for(a = [-180 + polygon_angle, +180 - polygon_angle]) translate(vector_point(alpha = a, delta = total_width / 2 - corner_radius))
                circle(d = corner_radius + part_clearance, $fn = 16);
    }

    // Other half cutout
    translate([0, 0, module_height]) linear_extrude(module_height + $fudge) r_regpoly(od = total_width + part_clearance, vertices = polygon_sides, radius = corner_radius, $fn = 16);   

    // Magnet hole
    translate([0, 0, magnet_cover]) cylinder(d = magnet_diameter, h = magnet_height, $fn = 32);
}
```

### Jistící kolík

Zbývá jenom vytvořit jistící kolík, umístěný tak, aby zapadl do otvoru na symetrickém místě v druhém dílu. Může mít jakýkoliv tvar, jenom musí odpovídat otvoru.

Já jsem se rozhodl udělat ho ve tvaru oválu, jsou to dva válce na vrcholech šestiúhelníku, průměr odpovídající poloměru zaoblení rohů. Přes ně pak natáhnu opět `hull`.

```scad
module part() {
    difference() {
        // Extruded base 2D shape
        linear_extrude(module_height * 2) difference() {
            // Main shape
            hull() {
                r_regpoly(od = total_width, vertices = polygon_sides, radius = corner_radius, $fn = 16);
                translate([-module_length, -total_width / 2]) r_square([corner_radius * 2, total_width], corner_radius, $fn = 16);
            }

            // Ribbon holes
            hole_xpos = [ for(i = [0:ribbon_holes - 1]) -module_length + wall_thickness * (i + 1) + ribbon_thickness * i ];
            for(x = hole_xpos) translate([x, -ribbon_width / 2]) r_square([ribbon_thickness, ribbon_width], ribbon_thickness / 2, $fn = 16);

            // Peg hole
            if(use_peg) translate([-corner_radius / 2, 0]) hull() 
                for(a = [-180 + polygon_angle, +180 - polygon_angle]) translate(vector_point(alpha = a, delta = total_width / 2 - corner_radius))
                    circle(d = corner_radius + part_clearance, $fn = 16);
        }

        // Other half cutout
        translate([0, 0, module_height]) linear_extrude(module_height + $fudge) r_regpoly(od = total_width + part_clearance, vertices = polygon_sides, radius = corner_radius, $fn = 16);   

        // Magnet hole
        translate([0, 0, magnet_cover]) cylinder(d = magnet_diameter, h = magnet_height, $fn = 32);
    }

    // Peg
    if(use_peg) translate([corner_radius / 2, 0]) hull() 
        for(a = [-polygon_angle, +polygon_angle]) translate(vector_point(alpha = a, delta = total_width / 2 - corner_radius))
            cylinder(d = corner_radius, h = module_height * 2, $fn = 16);
}
```

Tuto konstrukci jsme již viděli, v zrcadlovém provedení, při vytváření otvoru. Používám zde funkci `vector_point`, která vypočítá bod (střed podstavy válce) na základě úhlu a vzdálenosti od originu.

### Zobrazení náhledu a jednoho dílu

Následující kód zobrazí buďto jeden díl pro tisk nebo dva díly, jeden červený a modrý, napozicované nad sebe tak, jak budou při složení obou dílů dohromady.

```scad
// Main render
if(render_preview) {
    // Render two parts together, to show how it works and also check if it fits
    color("#cc0000") part();
    color("#000099") translate([0, 0, module_height * 2 + part_clearance / 2]) rotate([0, 180, 0]) part();
} else {
    // Render single part, for export and printing
    part();
}
```

![](https://www.cdn.altairis.cz/Blog/2020/20200404-magclasp-05-preview.png)

## 3D tisk

Model je navržen tak, aby byl 3D tisk pokud možno co nejjednodušší. Jediná zákeřnost se skrývá v nutnosti ve správné výšce přerušit tisk a vložit magnety.

Tisk je nutné přerušit před tiskem 12. vrstvy ve výšce 2,4 mm. Při této vrstvě začne tiskárna zakrývat díru novým materiálem.

![](https://www.cdn.altairis.cz/Blog/2020/20200404-magclasp-06-slicer.png)

Pro přípravu modelu k tisku používám program PrusaSlicer. Ve starších verzích bylo nutné tisk přerušit buďto ručně nebo použít funkci výměna filamentu. Nejnovější verze 2.2.0 ale obsahuje funkci pozastavení tisku, kdy není nutné vyjímat a znovu zavádět tiskovou strunu.

V nastavení tisku jsem ještě nastavil čtyři perimetry (výchozí jsou dva), protože to tomuto modelu lépe sedí.

![](https://www.cdn.altairis.cz/Blog/2020/20200404-magclasp-07-preruseni.jpg)

Po přerušení tisku odjede tisková hlava stranou a lze vložit magnety.

![](https://www.cdn.altairis.cz/Blog/2020/20200404-magclasp-08-magnety.jpg)

Dejte si pozor na jejich správnou orientaci! Jeden pár (jedno  který, všechny díly jsou stejné) musí mít nahoru severní pól, druhý jižní, aby zapadly do sebe.

![](https://www.cdn.altairis.cz/Blog/2020/20200404-magclasp-09-pokracovani.jpg)

Poté lze pokračovat v tisku. Tisk kompletní sady čtyř dílů trvá cca. hodinu. Jako tiskový materiál jsem použil PLA, ale lze použít cokoliv.

![](https://www.cdn.altairis.cz/Blog/2020/20200404-magclasp-10-komplet.jpg)

## Soubory ke stažení

* [`MagClasp.scad`](https://gist.github.com/ridercz/d403dfe63ca1fbc37a08617bdc7583ba/raw/f49b7ca2d34d9e63e371ea1b514a6dc5bcdd44db/MagClasp.scad) (Zdrojový kód v OpenSCADu)
* [`MagClasp.stl`](https://gist.github.com/ridercz/930a9afaa381601c04744996d75be718/raw/389b3360002fe36159053a6673fa354684f6b99a/MagClasp.stl) (Výsledný STL soubor pro 20 mm šíři)