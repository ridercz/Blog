<!-- dcterms:title = Malý kabel, velká díra: příběh z konstrukce -->
<!-- dcterms:abstract = Obvykle u svých modelů prezentuji hotová řešení. Jenomže ono to často nevyjde na první pokus. 3D tisk je ovšem nástrojem pro rychlé prototypování a iterativní vývoj. Na příkladu jednoduché průchodky vám ukážu postupný vývoj a ladění. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:coverUrl = /cover-pictures/20211026-pruchodka.jpg -->
<!-- x4w:pictureUrl = /perex-pictures/20211026-pruchodka.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = 3D tisk -->
<!-- dcterms:dateAccepted = 2021-10-26 -->

Obvykle u svých modelů prezentuji hotová řešení. Jenomže ono to často nevyjde na první pokus. 3D tisk je ovšem nástrojem pro rychlé prototypování a iterativní vývoj. Na příkladu jednoduché průchodky vám ukážu postupný vývoj a ladění.

V základu je zadání jednoduché. Mám velkou díru (⌀ 20 mm), kterou potřebuju protáhnout malý kabel (⌀ 4-5 mm). Což je v mnoha ohledech pořád lepší situace, než kdybych měl malou díru a velký kabel, ale ani tak nic moc. Aby byla situace ještě o něco zábavnější, kabel má na konci USB konektor, takže velká díra se hodí, ale po protažení ji potřebuju nějak zaslepit, aby se dovnitř neprášilo a výsledek vypadal aspoň trochu profesionálně.

![](https://www.cdn.altairis.cz/Blog/2021/20211026-pruchodka-1.jpg)

Sice existují různé průchodky, ale nepodařilo se mi najít takovou, která by vyhohovala všem parametrům. [FITJPI!](https://www.altair.blog/2020/02/fitjpi)

## Tři generace prototypů

![](https://www.cdn.altairis.cz/Blog/2021/20211026-pruchodka-2.jpg)

Základní koncept je jednoduchý: Šroub a matka, uprostřed šroubu díra pro kabel a šroub rozdělený na dvě části, aby prošel i konektor. 

Na obrázku vidíte tři iterace prototypu:

**První pokus (vlevo)** vyšel překvapivě dobře. Bál jsem se, jestli tištěný závit bude funkční, ale přestože vizuálně není dokonalý, funguje v praxi dobře. Nicméně po praktickém vyzkoušení jsem našel tři problémy:

1. Kulatá základna znamená, že se to špatně utahuje, protože to není za co chytit.
2. Rozdělení šroubu na dvě části je funkční, ale vzhledem k nepřesnosti tisku je třeba vkládaný díl (ve tvaru _V_) lepší udělat o malý kousek menší.
3. Venkovní matice o výšce 12 mm je zbytečně robustní, lze ji udělat nižší, což mimo jiné zkrátí dobu tisku.

**Druhý pokus (uprostřed)** vyřešil první a druhý problém. Čtvercová základna zabraňuje protočení šroubu a o 0,25 mm zmenšená menší výseč šroubu je tak akorát. Nicméně přinesl další, protože jsem si neuvědomil, že v krabičce jsou v rozích malé nálitky, které zabraňují tomu, aby čtvercová základna zapadla na místo. Nicméně koncept je funkční, což jsem ověřil tím, že jsem rohy prostě uštípl kleštěmi.

**Třetí pokus (vpravo)** je zatím poslední iterace. Větší zaoblení rohů vyřešilo problém s nálitky a snížení matice ze 7 mm na 5 mm přineslo zkrácení doby tisku na půl hodiny

Hotový výrobek je zcela uspokojivý:

![](https://www.cdn.altairis.cz/Blog/2021/20211026-pruchodka-3.jpg)

![](https://www.cdn.altairis.cz/Blog/2021/20211026-pruchodka-4.jpg)

![](https://www.cdn.altairis.cz/Blog/2021/20211026-pruchodka-5.jpg)

## Výsledný kód

Pro vlastní generování metrického závitu M20 jsem použil [hotovou knihovnu](https://github.com/rcolyer/threads-scad). Pro generování zaoblených rohů pak používám svou vlastní knihovnu [A2D](https://github.com/ridercz/A2D/) Kód v OpenSCADu vypadá takto:

<script src="https://gist.github.com/ridercz/c301e139817d6044c66b63ea7e6659e0.js"></script>

## Naučte se OpenSCAD

Pokud vás modelování v OpenSCADu zaujalo, podívejte se na [seriál video školení na kanálu Z-TECH](https://www.youtube.com/playlist?list=PLFZurxJN0pMa_CTpYev0dB7HzkeOUe5SZ). Je k němu i [bezplatný eLearning](https://go.ztech.cz/OPENSCAD). Nový díl vychází každé úterý v poledne.