<!-- dcterms:title = Tisk textu na 3D tiskárnách -->
<!-- dcterms:abstract = Vymodelovat text v OpenSCADu je snadné. Ale jak ho tisknout? Vypadá lépe extrudovaný nebo embosovaný? Tisknutý na horní, spodní nebo boční stranu? Vyplatí se používat ironing? -->
<!-- x4w:category = 3D tisk -->
<!-- x4w:category = Z-TECH -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:dateAccepted = 2022-01-18 -->
<!-- x4w:pictureUrl = /perex-pictures/20220118-tisk-textu.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20220118-tisk-textu.jpg -->

Vymodelovat text v OpenSCADu je snadné. Ale jak ho tisknout? Vypadá lépe extrudovaný nebo embosovaný? Tisknutý na horní, spodní nebo boční stranu? Vyplatí se používat ironing?

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/QBAzC4BWW7w" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

Veškeré ukázky byly vytištěny z PLA na standardní tiskárně Prusa i3 MK3S s 0,4 mm tryskou. Můžete si [stáhnout použité modely](https://www.cdn.altairis.cz/Blog/2022/20220118-models.zip) jako SCAD i STL. Pro slicing jsem použil PrusaSlicer 2.4 s profily _Generic PLA_ a _0.20mm SPEED_.

## Text na svislé stěně

První varianta tisku je, že písmena budou kolmá ke směru tisku, tedy budou na svislé stěně. Na následujícím obrázku vidíte extrudovaný a embossovaný text o tloušťkách 0,2-1,0 mm:

![Tisk na svislé stěně](https://www.cdn.altairis.cz/Blog/2022/20220118-svisle.jpg)

* Počítejte s tím, že pohyb trysky poněkud "rozmaže" okraje písmen.
* Doporučuji aby znaky přečnívaly nebo byly vnořeny 0,6 mm. Při nižším rozměru nejsou dobře čitelné, při větším mají tendenci se deformovat.

## Text na vodorovné stěně

![Tisk na vodorovné stěně, extruze](https://www.cdn.altairis.cz/Blog/2022/20220118-vodorovne_extruze.jpg)

Intuitivně nejsnazší je tisk nápisu tak, že písmena budou rovnoběžná se směrem tisku, extrudovaná směrem nahoru. 

* Tisk tímto způsobem je obvykle dobře čitelný, ale písmena mohou být zdeformovaná a mohou mezi nimi zůstat tenká vlákna (stringování).
* Při volbě písma je nutné brát ohled na průměr trysky, aby linie písma měly alespoň dva tahy tryskou.
* Doporučuji alespoň dvě vrstvy tisku (tj. 0,4 mm při výše popsaných parametrech).

![Tisk na vodorovné stěně, emboss nahoru](https://www.cdn.altairis.cz/Blog/2022/20220118-vodorovne_emboss_nahoru.jpg)

Druhá možnost je tatáž orientace, ale text je vytlačený do modelu, embossovaný. Podle mého názoru je to nejhorší způsob tisku, protože nejednodnost povrchu nevypadá dobře a okraje písmen se slévají. Rozhodně ho nedoporučuji pro malé velikosti písma.

![Tisk na vodorovné stěně, emboss dolů](https://www.cdn.altairis.cz/Blog/2022/20220118-vodorovne_emboss_dolu.jpg)

Z hlediska vzhledu a čitelnosti je pro mne na první pohled trochu nelogicky vítězem embossovaný text, ovšem tištěný směrem dolů, na zrnitý tiskový plát.

* Tento tisk je výtečně čitelný i při malém rozměru, protože kontrast textury tiskového plátu a vnitřní výplně je dostatečný a okraje nemají tendenci se tolik slévat, protože je drží tisková podložka.
* Doporučuji výšku dvě až tři vrstvy, tj. 0,4-0,6 mm.
* Zejména pro tisk drobného písma je nutná dobrá přilnavost podložky, aby na ní složité tvary dobře držely.

## Vícebarevný tisk a použití vyhlazování

Tisk rovnoběžný s podložkou má tu výhodu, že lze mezi vrstvami vyměnit filament a vytvořit tak vícebarevný tisk, kdy motiv má jinou barvu než podklad. Tohoto efektu lze dosáhnout jak při tisku extruze tak embossu.

Některé slicery navíc podporují funkci "vyhlazování" (ironing). Při něm se po vodorovném povrchu modelu přejíždí tiskovou hlavou, která vytlačuje malé množství filamentu, čímž dochází k vyhlazování povrchu, který pak nemá typickou "šrafovanou" strukturu (resp. není tak zřetelná).

![Vícebarevný tisk, extruze](https://www.cdn.altairis.cz/Blog/2022/20220118-colorprint_extruze.jpg)

* Tento typ tisku vypadá obvykle dobře, vyšší kontrast dokáže kompenzovat nevýhody této orientace.
* Je nutné počítat s možnou průhledností horního filamentu a použít odpovídající počet vrstev, aby byl kontrast dostatečný. Při tisku světlým filamentem na tmavém pozadí, případně při použití fosforeskujícího filamentu je vhodné změnit filament dvakrát: nejprve na tmavé pozadí vytisknout dvě vrstvy bílým plastem a teprve na něj tisknout světlý filament, aby zůstal zachován dostatečný kontrast.
* Ironing je dvojsečná zbraň. Zlepšuje kvalitu povrchu, ale nefunguje dobře při použití na malém povrchu.

![Vícebarevný tisk, emboss](https://www.cdn.altairis.cz/Blog/2022/20220118-colorprint_emboss.jpg)

Tuto kombinaci pro malou velikost písma obecně nedoporučuji, protože chyby spíše zvýrazňuje než skrývá.