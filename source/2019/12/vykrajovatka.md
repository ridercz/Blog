<!-- dcterms:title = Vykrajovátka na vánoční cukroví z 3D tiskárny -->
<!-- dcterms:abstract = Jedním z nejoblíbenějších 3D tištěných předmětů jsou kolem Vánoc vykrajovátka na vánoční cukroví. Když si na Thingiverse necháte vyhledat "cookie cutter", najdete skoro 6000 výsledků. Ukážu vám, jak vykrajovátko jednoduše vytvořit z jakéhokoliv SVG souboru pomocí OpenSCADu. -->
<!-- x4w:category = 3D tisk -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:dateAccepted = 2019-12-04 -->
<!-- x4w:pictureUrl = /perex-pictures/20191204-vykrajovatka.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20191204-vykrajovatka.jpg -->

Jedním z nejoblíbenějších 3D tištěných předmětů jsou kolem Vánoc vykrajovátka na vánoční cukroví. Když si na Thingiverse necháte vyhledat _cookie cutter_, najdete skoro [6000 výsledků](https://www.thingiverse.com/search?q=cookie+cutter). Ukážu vám, jak vykrajovátko jednoduše vytvořit z jakéhokoliv SVG souboru pomocí OpenSCADu.

OpenSCAD totiž v aktuální verzi 2019.05 disponuje funkcí `import`, která umí [naimportovat SVG soubor](https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Importing_Geometry#import) jako 2D geometrii, se kterou se dá libovolně pracovat. Je pak triviální napsat kód, která pomocí funkce `offset` vytvoří řezací okraj a silnější lem, který pomůže udržet tvar.

```scad
image_file = "CC-HowlingHead.svg";
total_height = 15;
wall_thickness = .86;
base_width = 3;
base_height = 1.2;
mirror_options = [1, 0, 0];

// Cutting edge
linear_extrude(total_height) mirror(mirror_options) difference() {
    offset(delta = wall_thickness) import(image_file, center = true);
    import(image_file, center = true);
}

// Base
linear_extrude(base_height) mirror(mirror_options) difference() {
    offset(r = wall_thickness + base_width) import(image_file, center = true);
    offset(r = -base_width) import(image_file, center = true);
}
```

Výše uvedený kód je univerzální, poradí si s jakýmkoliv obrysem ve vektorovém formátu SVG. Pro letošní rok jsem připravil tři modely koňské a tři (jako)vlčí. Testovací dávka dopadla výborně.

<figure>
    <img src="https://www.cdn.altairis.cz/Blog/2019/20191204-vykrajovatka-1.jpg" alt="3D tištěná vykrajovátka" />
    <figcaption>3D tištěná vykrajovátka v akci</figcaption>
</figure>

<figure>
    <img src="https://www.cdn.altairis.cz/Blog/2019/20191204-vykrajovatka-2.jpg" alt="Vykrájené obrysy před pečením" />
    <figcaption>Vykrájené obrysy před pečením</figcaption>
</figure>

<figure>
    <img src="https://www.cdn.altairis.cz/Blog/2019/20191204-vykrajovatka-3.jpg" alt="Hotové sušenky" />
    <figcaption>Hotové sušenky</figcaption>
</figure>

## Chcete je?

Potřebné zdrojové soubory najdete na webu PrusaPrinters [(jako)vlci](https://www.prusaprinters.org/prints/8644-wolf-wolfdog-cookie-cutters), [koně](https://www.prusaprinters.org/prints/12268-horse-cookie-cutters) a můžete je použít k tisku na jakékoliv 3D tiskárně (nejenom Prusa). Tisk je snadný, model je jednoduchý.

Pokud nemáte 3D tiskárnu a vykrajovátka byste chtěli, [napište mi](https://m.me/rider.cz) a nějak se domluvíme :-)