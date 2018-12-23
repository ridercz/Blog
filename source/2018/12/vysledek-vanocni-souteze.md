<!-- dcterms:title = Výsledek vánoční soutěže -->
<!-- dcterms:abstract = Včera jsem vyhlásil vánoční soutěž, kde bylo vaším úkolem vyluštit zprávu, zakódovanou od obrázku. Trvalo jenom pár hodin, než ji Tomáš Jecha (a za ním v závěsu Jakub Bouček) vyhrál. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20181222-vanocni-soutez.png -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = IT -->
<!-- dcterms:dateAccepted = 2018-12-23 -->

Včera jsem vyhlásil [vánoční soutěž](/2018/12/vanocni-soutez), kde bylo vaším úkolem vyluštit zprávu, zakódovanou od obrázku. Trvalo jenom pár hodin, než ji [Tomáš Jecha](https://github.com/ridercz/Blog/issues/7) (a za ním v závěsu [Jakub Bouček](https://github.com/ridercz/Blog/issues/7)) vyhrál.

## Výsledky

    Against_stupidity_even_the_gods_themselves_contend_in_vain.
    Čerňoučký kůň vymýšlí ďábelské nápady.
    The_difference_between_science_and_the_fuzzy_subjects_is_that_science_requires_reasoning,_while_the_other_subjects_require_scholarship.

Z nápověd byla nepravdivá ta s MD5 hashem. Což bylo očividné už z toho, že jako výsledek byla udána hodnota, která je příliš dlouhá a nikdy se tedy nemohlo jednat o výsledek MD5 hashe.

## Postup

Základem všeho je velmi jednoduché kódování:

1. Text je převeden do UTF-8 (což potrápilo Jakuba Boučka a jsem rád že mi to vyšlo, proto obsahuje zdruhá zpráva nabodeníčka).
2. První dva moduly obrázku jsou "jedna" a "nula", což má sloužit ke kalibraci, neboť moduly mohou mít různou velikost. Kalibrace mimochodem není udělaná úplně nejlépe, protože při (ne)vhodné struktuře dat a nulové mezeře mezi řádky dává nejednoznačné výsledky.
3. Dále pak následují jednotlivé bity dat jako moduly o barvě popředí nebo pozadí.
4. Mezi jednotlivými řádky obrázku může (ale nemusí) být libovolně velká mezera.

Celé je to nejlépe vidět na prvním obrázku. Jednička je světlejší bod, nula tmavší a moduly jsou čtvercové:

![](https://www.cdn.altairis.cz/Blog/2018/20181222-zadani-1.png)

Druhý obrázek používá totéž, ale moduly jsou obdélníkové, barvy invertované a text obsahuje znaky s diakritikou:

![](https://www.cdn.altairis.cz/Blog/2018/20181222-zadani-2.png)

Poslední obrázek vyžaduje kombinovaný přístup člověka a počítače. Počítač na rozdíl od člověka pozná, že se v obrázku vyskytují dvě barvy: `#ff0000` a `#fe0000`. Nicméně velikost modulu je 1 pixel a všechno je nahloučeno do levého horního rohu. Zbytek obrázku je prázdný, což v předchozích souborech nebylo:

![](https://www.cdn.altairis.cz/Blog/2018/20181222-zadani-3.png)

Postup použitý u třetího obrázku je vlastně steganografie, skrývání dat v jiných datech. Pokud bych nechtěl, aby to bylo tak nápadné, mohl bych jako základ použít nějaký skutečný obrázek a pro uchování informace použít nejméně významný bit jedné nebo více barevných složek. Mírná změna barvy nezpůsobí žádný viditelný rozdíl, ale počítač si s ní poradí.

<ins>Tomáš v [komentáři na GitHubu](https://github.com/ridercz/Blog/issues/7#issuecomment-449627117) popsal způsob, jakým se se zadáním popasoval. [Jakub taky](https://github.com/ridercz/Blog/issues/8#issuecomment-449633871). </ins>

## Program

Můžete si stáhnout [zdrojový kód](https://www.cdn.altairis.cz/Blog/2018/20181223-imagencode.zip) programu, který jsem použil pro zakódování. Je napsán v ASP.NET Core a pro práci s obrázky využívá knihovnu [ImageSharp](https://github.com/SixLabors/ImageSharp).