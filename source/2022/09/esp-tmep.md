<!-- dcterms:title = Jak ze tří součástek vyrobit internetový teploměr -->
<!-- dcterms:abstract = Twitter zaplavily fotky domácích teploměrů. Teplota v místnosti je nová rouška. Ať už doma ve jmému úspor a boje proti Putinovi mrznete při patnácti nebo se naopak potíte při třiceti stupních a chcete to sdělit světu, technika vám s virtue signallingem může pomoci. Ukážu vám, jak si ze tří součástek můžete postavit teploměr, který naměřená data odesílá do české služby TMEP.CZ. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:coverUrl = /cover-pictures/20220927-esp-tmep.jpg -->
<!-- x4w:pictureUrl = /perex-pictures/20220927-esp-tmep.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = Z-TECH -->
<!-- x4w:category = 3D tisk -->
<!-- x4w:category = Bastlení -->
<!-- dcterms:dateAccepted = 2022-09-27 -->

Twitter zaplavily fotky domácích teploměrů. Teplota v místnosti je nová rouška. Ať už doma ve jmému úspor a boje proti Putinovi mrznete při patnácti nebo se naopak potíte při třiceti stupních a chcete to sdělit světu, technika vám s virtue signallingem může pomoci. Ukážu vám, jak si ze tří součástek můžete postavit teploměr, který naměřená data odesílá do české služby [TMEP.CZ](https://www.tmep.cz).

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/qh9V8oPX-iM" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

## Co k tomu potřebujete

* Deska s čipsetem ESP8266, já používám [D1 mini](https://s.click.aliexpress.com/e/_DFBHSuR)
* Teplotní čidlo [DS18B20](https://s.click.aliexpress.com/e/_DmJplrp), dá se koupit buďto jako "holá" součástka nebo ve vodotěsném provedení na kabelu.
* [Rezistor 4700 &Omega;](https://s.click.aliexpress.com/e/_DmKnEIL) (4.7k, 4k7)
* Vhodnou krabičku, já jsem použil [tento model pro 3D tisk](https://www.printables.com/model/44083-wemos-d1-mini-enclosure)

Potřebný software najdete na [mém GitHubu](https://github.com/ridercz/ESP-TMEP).

## Konstrukční poznámky

U senzorů tohoto typu je velký problém umístit teplotní čidlo tak, aby měřící zařízení samo neovlivňovalo naměřenou hodnotu. Čip se totiž zahřívá a pokud byste čidlo umístili přímo na desku do krabičky, byla by naměřená hodnota ovlivněna právě tím zahříváním. Z tohoto důvodu používám raději hotovou variantu na kabelu, umístěnou mimo vlastní krabičku.

Pokud byste chtěli měřit venkovní teplotu, musíte zase zajistit, aby na teploměr přímo nesvítilo slunce a postavit mu radiační štít.

## Co s naměřenou hodnotou

Pokud jste weboví vývojáři, asi dokážete snadno napsat aplikaci, která dokáže naměřenou hodnotu zaznamenat a nějak vyhodnocovat. Nicméně nemáte-li obzvláště specifické nároky, doporučuji českou službu [TMEP.CZ](https://www.tmep.cz), která je určena přesně pro tento scénář (a umí sledovat víc než jenom teplotu). Proto jsem firmware napsal tak, aby hodnoty posílal právě této službě. Úprava pro jinou podobnou službu je triviální.

Teplotu ve studiu Z-TECH můžete sledovat na [ztech.tmep.cz](https://ztech.tmep.cz/).

Služba je na tři měsíce zdarma, poté se platí za první čidlo 100 Kč ročně, za každé další 50 Kč ročně, což je dle mého názoru velice dobrá cena, rozhodně to vyjde levněji než psát a provozovat vlastní řešení.