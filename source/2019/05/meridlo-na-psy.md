<!-- dcterms:title = Jak vyrobit měřidlo na psy -->
<!-- dcterms:abstract = Kamarádka mne požádala, abych jí vyrobil měřidlo na psy. To je jednoduchý nástroj, který se používá při bonitaci (hodnocení psa za účelem určení chovnosti) a měří se jím kohoutková výška psa. Výroba je poměrně jednoduchá a dala mi možnost použít některé mé oblíbené konstrukční postupy. -->
<!-- x4w:category = Bastlení -->
<!-- x4w:category = 3D tisk -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:dateAccepted = 2019-05-01 -->
<!-- x4w:coverUrl = /cover-pictures/20190501-meridlo-na-psy.jpg -->
<!-- x4w:pictureUrl = /perex-pictures/20190501-meridlo-na-psy.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->

Kamarádka mne požádala, abych jí vyrobil měřidlo na psy. Výroba je poměrně jednoduchá a dala mi možnost použít některé mé oblíbené konstrukční postupy. Měřidlo je poměrně jednoduchý nástroj, který se používá při bonitaci (hodnocení psa za účelem určení chovnosti) a měří se jím kohoutková výška psa. Jak takové měření vypadá se můžete podívat na následujícím videu:

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/vDDpcQeN36Y" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

Někteří chovatelé si měřidlo pořizují, aby mohli se svými psy měření trénovat. Někteří psi jsou bázlivější a neznámé udělátko nemají rádi, tak je dobré je na něj zvykat.

Měřidlo samo je prostě tyč, na které je centimetrová stupnice. Dole z ní v pravém úhlu ční kratší tyčka, na kterou je možné si stoupnout a měřidlo přidržet a nahoře je na druhou stranu podobné rameno, jenom delší, které se volně pohybuje. Položí se psovi na kohoutek a tím se určí výška. Výsledek vypadá takto:

![Hotové měřidlo](https://www.cdn.altairis.cz/Blog/2019/20190501-01-vysledek.jpg)

Základem konstrukce jsou hliníkové profily, spojené dohromady pomocí plastových dílů vyrobených na 3D tiskárně.

## Materiál a vybavení

* Materiál:
  * hliníkový profil 15&times;15 mm, délka 90, 20 a 40 cm,
  * krejčovský metr,
  * 4x šroub M4&times;12 s válcovou hlavou a vnitřním šestihranem,
  * 2x šroub M5&times;10 s šestihrannou hlavou,
  * 2x matka M5 nízká čtverhranná (s mírnou úpravou modelu lze použít i běžnou nízkou šestihrannou),
  * tištěné díly, [modely ke stažení](https://www.thingiverse.com/thing:3600322) na Thingiverse,
  * kyanoakrylátové (vteřinové) lepidlo.
* Nářadí:
  * pilka (na hliník stačí běžná pilka na dřevo),
  * vrtačka,
  * vrtáky a závitníky na díry M4 a M5,
  * imbus na M4 šrouby.

## Modelování a 3D tisk

![Sada 3D tištěných dílů](https://www.cdn.altairis.cz/Blog/2019/20190501-02-openscadmodel.png)

Všechny díly jsem vymodeloval v OpenSCADu a jsou plně parametrické. Lze je tedy snadno upravit např. pro jiný typ profilu. Zdrojové kódy i hotové modely si můžete [stáhnout na Thingiverse](https://www.thingiverse.com/thing:3600322).

<script src="https://gist.github.com/ridercz/0c8cd69bc91c31531b06539a3209d985.js"></script>

Nejsložitější model představují trojúhelníkové spojky, které drží ALU profily v pravém úhlu. Čtverhranný otvor pro svislý profil je o něco větší, aby se mohla spojka volně pohybovat. Není čtvercový, protože profil bude v jednom směru silnější o šířku nalepeného krejčovského metru.

<script src="https://gist.github.com/ridercz/5e828b7423ce4d2828f15f167b5e2302.js"></script>

Horní a spodní díl se liší v jediném ohledu: horním dílem vede otvor skrz, ve spodním dílu je 10 mm vysoké dno. Tisk těchto dílů je jednoduchý, lze je tisknout s podporami i bez.

<script src="https://gist.github.com/ridercz/0abd288ef1b6d0499c150ccc006a3c94.js"></script>

Další díl je jednoduchá zátka na konce ALU profilů. Budete potřebovat celkem tři. Je problém je udělat přesně, aby šly do konců profilů nasadit a zároveň držely. Nakonec jsem to vyřešil tak, že jsem je udělal o něco menší a omotal jsem je elektrikářskou izolační páskou, která je měkká a lze to celé šetrně namlátit do konců profilů.

<script src="https://gist.github.com/ridercz/f66b2b6cf3cdbb8fa3113f18f6c18034.js"></script>

Dále budete potřebovat dva kusy knoflíků na M5 šrouby, aby se jimi dalo dobře otáčet rukou. Jejich okraje jsem udělal vroubkované, pro snazší manipulaci.

<script src="https://gist.github.com/ridercz/d198c5b72d69e48601c6e7729cdd57fc.js"></script>

Protože se mi nelíbilo, jak jsou vidět hlavy šestihranných šroubů, vymodeloval jsem ještě vrchní část, která se po vložení šroubu přilepí. Z funkčního hlediska není nutná, ale esteticky dílo vylepšuje.

![Nastavení vícebarevného tisku](https://www.cdn.altairis.cz/Blog/2019/20190501-08-colorprint.png)

Na vrchní část jsem přidal svoje logo a nastavil tisk tak, že jsem na poslední dvě vrstvy vyměnil filament. Většina dílů je černá, ale vršek knoflíku je oranžový a na něm je moje logo opět v černé barvě.

Použil jsem běžné PLA, jeho mechanické vlastnosti jsou dostatečné a dobře se s ním pracuje. Díly jsem vytiskl z materiálu Prusament Galaxy Black. Matná černá barva se stříbrnými částečkami schová nerovnosti při tisku a vypadá to prostě dobře. Oranžové PLA je nějaký zbytek, co se mi tady válel, ani nevím kde jsem k němu přišel.

## Sestavení

![Vrtání děr do profilu](https://www.cdn.altairis.cz/Blog/2019/20190501-03-vrtani.jpg)

Začněte tím, že do trojúhelníkových dílů vložíte zespoda krátké (20 a 40 cm) kousky profilů. Zeshora pak do profilu vyvrtejte díry vrtákem 3,3 mm. Nejprve si označte jejich místa skrz plastový díl a poté je vyvrtejte samostatně.

![Řezání závitu](https://www.cdn.altairis.cz/Blog/2019/20190501-04-zavit.jpg)

Poté pomocí závitníku vyřežte M4 závit. Do hliníku to jde snadno, je to jeden z důvodů, proč jsem ho použil.

![Zkouška šroubů](https://www.cdn.altairis.cz/Blog/2019/20190501-05-srouby.jpg)

Plastové díly pevně přišroubujte pomocí šroubů M4&times;12. Já jsem použil s válcovou hlavou a vnitřním šestihranem, protože se mi s nimi dobře pracuje a používám je ve všech svých konstrukcích, ale v zásadě na typu šroubu nezáleží, stejně nebude vidět.

![Knoflíky na M5 šroubech](https://www.cdn.altairis.cz/Blog/2019/20190501-07-knofliky.jpg)

Vytištěnými knoflíky prostrčte šrouby M5&times;10 a šestihranné hlavy zapusťte do příslušných otvorů. Pokud chcete, můžete nyní na knoflíky nalepit ozdobné kryty.

![Zapuštěná čtvercová matice](https://www.cdn.altairis.cz/Blog/2019/20190501-09-matka.jpg)

Do stěny trojúhelníkových dílů vložte matice M5. Já pro tento účel dávám přednost čtvercovým maticím, protože ve vytištěných dírách lépe drží a neprotáčejí se. Nicméně můžete použít i běžné šestihranné matice, nízké nebo vysoké. V takovém případě je ovšem třeba upravit model v OpenSCADu. Je na to připraven, stačí změnit následující proměnné:

* `set_screw_nut_diameter` - průměr matice (průměr kružnice opsané, tj. vzdálenost mezi vrcholy, ne mezi plochami),
* `set_screw_nut_height` - výška matice,
* `set_screw_nut_sides` - počet stran matice, `4` nebo `6`.

Matici do stěny nejsnáze vložíte tak, že otvorem prostrčíte M5 šroub a matku na něj nasadíte pomocí kleští s tenkými čelistmi nebo pinzety. Pak šroub utáhnete a matku vtáhnete do stěny. Otvor pro čtvercovou matici je pootočen o 45°, protože se tak snáze tiskne.

![Označení díry pro šroub spodního dílu](https://www.cdn.altairis.cz/Blog/2019/20190501-06-oznaceni.jpg)

Nasaďte spodní díl na nejdelší profil, který zasunete až na doraz. Poté zašroubujte M5 šroub s knoflíkem, dosti pevně. Konec šroubu v měkkém hliníku označí místo, kde je třeba vyvrtat otvor vrtákem 4.2 mm a vyřezat závit M5. Díry můžete udělat z obou protilehlých stran, aby šel spodní díl nasadit oběma směry.

![Hotový spodní díl](https://www.cdn.altairis.cz/Blog/2019/20190501-10-spodni.jpg)

Na stěnu, v níž nejsou díry, nalepte kyanoakrylátovým lepidlem krejčovský metr. Ustřihněte první centimetr, aby stupnice začínala od jedničky, ne od nuly. Dno spodního dílu je vysoké přesně 10 mm.

![Hotový horní díl](https://www.cdn.altairis.cz/Blog/2019/20190501-11-horni.jpg)

Nasaďte horní díl, který by se měl volně pohybovat. V požadované poloze ho můžete zajistit šroubem. Tím je celý výrobek hotov. Měří s přesností v řádu milimetrů (je dána přesností 3D tisku a sestavení), což je pro daný účel více než dostatečné.