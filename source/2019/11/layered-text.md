<!-- dcterms:title = Textový přívešek na klíče v OpenSCADu -->
<!-- dcterms:abstract = OpenSCAD je 3D modelovací software, ve kterém se modely nekreslí, ale programují. Výtečně se proto hodí na parametrické a generativní modelování. Udělal jsem parametrický model, který na sebe umí vrstvit texty v různých barvách a velikostech. Výsledný model se pak dá použít třeba na klíče nebo zajímavě vypadající tabulky. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:coverUrl = /cover-pictures/20191110-layered-text.jpg -->
<!-- x4w:pictureUrl = /perex-pictures/20191110-layered-text.png -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = 3D tisk -->
<!-- dcterms:date = 2019-11-10 -->

OpenSCAD je 3D modelovací software, ve kterém se modely nekreslí, ale programují. Výtečně se proto hodí na parametrické a generativní modelování. Udělal jsem parametrický model, který na sebe umí vrstvit texty v různých barvách a velikostech. Výsledný model se pak dá použít třeba na klíče nebo zajímavě vypadající tabulky.

Celé to začalo ve chvíli, kdy "můj" Theophilos (jsem členem syndikátu, v jehož barvách běhá) vyhrál Velkou pardubickou. Chtěl jsem na paměť jeho úžasného výkonu něco vytvořit. A napadl mne vícebarevný přívěšek v barvách našeho syndikátu, bílé a zelené. Přidal jsem k tomu ještě červenou barvu čapky a zasedl k OpenSCADu. Výsledek vypadal takto:

![](https://www.cdn.altairis.cz/Blog/2019/20191110-theophilos.png)

Římská číslice CXXIX odpovídá 129. ročníku Velké pardubické.

A když už jsem to celé dělal, tak proč ne rovnou univerzálně, aby se dala vytisknout jakákoliv kombinace slov? Na ukázku třeba heslo "HORSE POWER":

![](https://www.cdn.altairis.cz/Blog/2019/20191110-horsepower.png)

Vrstev může být i víc než dvě. Model jich zvládá neomezené množství. Nicméně za hraniční obecně pokládám tři vrstvy, více jich už bude nečitelných. Zkusil jsem třeba heslo "1918 CZECH REPUBLIC" v národních barvách:

![](https://www.cdn.altairis.cz/Blog/2019/20191110-czech.png)

## OpenSCAD kód

Takto vypadá OpenSCAD kód mého modelu:

```scad
/* [Base] */
base_color = "#333333";
base_paddding = 2;
base_height = 2;

/* [Text layers] */
layer_heights = [1, 1];
layer_text_strings = [ "HORSE", "POWER"];
layer_text_sizes = [22, 17];
layer_colors = [ "#FF6600", "#EEEEEE"];
font_name = "Arial Rounded MT Bold";

/* [Hanging hole] */
hole_position = [55, 5];
hole_diameter = 5;

// Create base
color(base_color) linear_extrude(base_height) difference() {
    offset(base_paddding) union() {
        for(i = [0:len(layer_heights) - 1]) text(text = layer_text_strings[i], font = font_name, size = layer_text_sizes[i], halign = "center", valign = "center");
        if(hole_diameter > 0) translate(hole_position) circle(d = hole_diameter, $fn = 32);
    }
    if(hole_diameter > 0) translate(hole_position) circle(d = hole_diameter, $fn = 32);
}

// Create text layers
translate([0, 0, base_height]) for(i = [0:len(layer_heights) - 1]) {
    lh = csum(layer_heights, i);
    color(layer_colors[i]) linear_extrude(lh) text(text = layer_text_strings[i], font = font_name, size = layer_text_sizes[i], halign = "center", valign = "center");
}

// Helper function to compute total layer height
function csum(items, i, val = 0, n = 0) = n >= i ? val + items[n] : csum(items, i, val + items[n], n + 1);
```

Pojďme se podívat na jednotlivé jeho části. Na začátku je deklarace proměnných, které určují, jak bude model vypadat.

```scad
/* [Base] */
base_color = "#333333";
base_paddding = 2;
base_height = 2;
```

První sada proměnných popisuje základnu, na které písmena leží:
* `base_color` popisuje barvu, která se ukáže v náhledu. Informace o barvě není součástí modelu, použije se jenom při náhledu. 
* `base_padding` je vzdálenost, o kterou bude základna přečnívat písmena. Hodnotu je nutné určit experimentálně na základě textu a použitého fontu. Podstatné je, aby se písmena "slila" a vytvořila jeden tvar.
* `base_height` je výška základny.

```scad
/* [Text layers] */
layer_heights = [1, 1];
layer_text_strings = [ "HORSE", "POWER"];
layer_text_sizes = [22, 17];
layer_colors = [ "#FF6600", "#EEEEEE"];
font_name = "Arial Rounded MT Bold";
```

Druhá sada proměnných popisuje textové vrstvy - jejich výšku (`layer_heights`), text (`layer_text_strings`), velikost písma (`layer_text_sizes`) a barvy (`layer_colors`). Ve všech případech se jedná o seznam (pole), který obsahuje tolik prvků, kolik je vrstev - zde dvě. Pořadí vrstev a velikost písma je nutné nakombinovat podle textu, aby to hezky vypadalo.

Proměnná `font_name` je název použitého písma. Já používám _Arial Rounded MT Bold_, protože ze zkušenosti vím, že jeho zaoblené rohy vypadají při tisku dobře.

```scad
/* [Hanging hole] */
hole_position = [55, 5];
hole_diameter = 5;
```

Poslední sada proměnných popisuje průměr díry na pověšení (`hole_diameter`) a její umístění relativně vůči středu (`hole_position`). Díra musí být umístěna mimo text a její umístění záleží na účelu a zobrazeném textu. Pokud v modelu nemá díra být, stačí nastavit její průměr na nulu.

```
// Create base
color(base_color) linear_extrude(base_height) difference() {
    offset(base_paddding) union() {
        for(i = [0:len(layer_heights) - 1]) text(text = layer_text_strings[i], font = font_name, size = layer_text_sizes[i], halign = "center", valign = "center");
        if(hole_diameter > 0) translate(hole_position) circle(d = hole_diameter, $fn = 32);
    }
    if(hole_diameter > 0) translate(hole_position) circle(d = hole_diameter, $fn = 32);
}
```

Následuje kód pro vytvoření základny. Nejprve napíšeme jednotlivé textové vrstvy "přes sebe" a přidáme k nim pozici díry. Pomocí `union()` tvary sloučíme do jednoho a pomocí `offset()` k výslednému tvaru přidáme padding. Pomocí `difference()` odečteme z tvaru kruhový otvor. Vše navrhujeme ve 2D, do správné výšky to vytáhneme pomocí `linear_extrude`.

```scad
// Create text layers
translate([0, 0, base_height]) for(i = [0:len(layer_heights) - 1]) {
    lh = csum(layer_heights, i);
    color(layer_colors[i]) linear_extrude(lh) text(text = layer_text_strings[i], font = font_name, size = layer_text_sizes[i], halign = "center", valign = "center");
}
```

Další část vytvoří jednotlivé textové vrstvy. Smyčka je velice podobná té předchozí, ale každou vrstvu vytvoříme v jiné výšce, aby bylo možné v průběhu tisku měnit filament a tím i barvu výtisku.

```scad
// Helper function to compute total layer height
function csum(items, i, val = 0, n = 0) = n >= i ? val + items[n] : csum(items, i, val + items[n], n + 1);
```

K určení celkové výšky vrstvy slouží funce `csum`, která sečte definované výšky vrstev.

## Výsledný model

Můžete si stáhnout model, kterým to všechno začalo, oslavu Theophilova vítězství. K dispozici je ve formátu [STL](https://www.cdn.altairis.cz/Blog/2019/20191110-theo.stl), který ale neobsahuje informace o změně filamentu (je nutné ho změnit ve výšce 1,4 a 2,0 mm při výšce vrstvy 0,2 mm). Všehcny tyto informace včetně tiskového profilu pro PrusaSlicer pak obsahuje formát [3MF](https://www.cdn.altairis.cz/Blog/2019/20191110-theo.3mf).

Všechny tři zmíněné modely v podobě OpenSCAD kódu a `.json` parametrizačního souboru (pro verzi 2019.05) si můžete stáhnout jako [ZIP archiv](https://www.cdn.altairis.cz/Blog/2019/20191110-theo.zip).