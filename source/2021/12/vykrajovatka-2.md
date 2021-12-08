<!-- dcterms:title = Vánoční vykrajovátka ještě jednou -->
<!-- dcterms:abstract = Od včerejška jsem poněkud vylepšil skript na generování vánočních vykrajovátek. Poradí si i se složenými tvary a publikoval jsem ho (včetně mnoha tvarů) na GitHubu. -->
<!-- x4w:category = 3D tisk -->
<!-- x4w:category = Z-TECH -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:dateAccepted = 2021-12-08 -->
<!-- x4w:pictureUrl = /perex-pictures/20211208-vykrajovatka-2.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20211208-vykrajovatka-2.jpg -->

Od [včerejšího videa](https://www.altair.blog/2021/12/vykrajovatka) jsem poněkud vylepšil skript na generování vánočních vykrajovátek. Poradí si i se složenými tvary a publikoval jsem ho (včetně mnoha tvarů) [na GitHubu](https://github.com/ridercz/CookieCutters).

Model psaný ve videu byl ve skutečnosti zjednodušenou verzí toho, který používám již několik let. Má trochu jinak řešenou parametrizaci, ale hlavně si umí poradit i se složenými tvary.

## Jak na složené tvary?

![Paragraf - složený tvar](https://www.cdn.altairis.cz/Blog/2021/20211208-paragraf.png)

Co je složený tvar? Takový, který má v sobě díru, jako například paragraf na obrázku výše. Pokud bychom prostě načetli SVG, tak by výsledkem byly dva tvary, jeden vnější obrys a pak díra. Abych tyto dva tvary spojil, lze volitelně vygenerovat na pozadí tvaru mřížku (s nastavitelnou šířkou, rozpalem příček a rotací).

Příslušný kód vypadá následovně:

```scad
// Grid
if(use_grid) {
    linear_extrude(base_height) intersection() {
        import(image_file, center = true);
        rotate(grid_rotation) translate(grid_size / -2) {
            for(offset = [0 : grid_span : grid_size[0]]) translate([0, offset - grid_width / 2]) square([grid_size[1], grid_width]);
            for(offset = [0 : grid_span : grid_size[1]]) translate([offset - grid_width / 2, 0]) square([grid_width, grid_size[0]]);
        }
    }
}
```

Vygeneruju mřížku o velikosti `grid_size`. Na její velikosti příliš nezáleží, musí být jenom větší než tvar vykrajovátka (výchozí rozměr je `[200, 200]`). Rozpal příček, jejich velikost a rotaci je nutné nastavit pro každý model individuálně, aby byly všechny vnitřní tvary rozumně podporovány. Výchozí nastavení je "sázka na jistotu", ale pro většinu reálných tvarů bude zbytečně husté, což prodlužuje dobu tisku a znesnadňuje manipulaci.

## Modely na GitHubu

Zdrojový kód, vstupní SVG soubory i výstupní STL najdete na [mém GitHubu v repozitáři CookieCutters](https://github.com/ridercz/CookieCutters). Pokud máte vlastní 3D tiskárnu, můžete s radostí tisknout. Pokud nemáte tiskárnu a chtěli byste nějaký vlastní tvar, tak se mi [ozvěte](https://www.rider.cz/#contact) a nějak se domluvíme na výrobě.