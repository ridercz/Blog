<!-- dcterms:title = C# pro mírně pokročilé: Generické typy a od delegátů po lambda expression -->
<!-- dcterms:abstract = Uplynulý týden jsem bohužel strávil neplánovaně v nemocnici, což poněkud narušilo mé plány na vydávání nového seriálu o C# na kanálu Z-TECH. Dnes jsem vydal nový díl o cestě od delegátů k lambda expressions, ale v článku bude řeč i o generických typech z týdne minulého. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20210902-csharp-generika-delegati.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20210902-csharp-generika-delegati.jpg-->
<!-- x4w:category = Z-TECH -->
<!-- x4w:category = IT -->
<!-- dcterms:dateAccepted = 2021-09-02 -->

Uplynulý týden jsem bohužel zcela neplánovaně strávil v laskavé péči zdravotnického personálu Nemocnice na Bulovce. Ve čtvrtek se sice stihl vydat naplánovaný první díl seriálu o genetických typech v C#, ale už jsem nebyl schopen k tomu nic napsat. Činím tak tedy alespoň teď, spolu s popisem nového dílu o cestě od delegátů k lambda expressions.

## 01 Generické typy

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/2sIdPVo-GZM" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

Generické typy jsou součástí jazyka C# už pěkně dlouho, konkrétně od verze 2.0, která vyšla někdy před šestnácti lety. Ve své podstatě se jedná o primitivní jazykovou funkci, která umožňuje tvorbu konstrukcí (metod, tříd...) které neberou argument jednoho konkrétního typu, ale jakéhokoliv typu `T`. To umožňuje tvorbu velice elegantního a efektivního kódu, může zamezovat zbytečnému boxingu a unboxingu a přetypování.

Pomocí generických constraintů lze vlastnosti onoho typu `T` přece jenom omezit. Například požadavkem aby měl bezparametrický konstruktor (pak lze vytvořit jeho novou instanci voláním `new T()`, aby byl hodnotový, naopak referenční, nebo dědil od určité třídy či implementoval konkrétní interface a další.

## 02 Od delegátů k lambda expressions přes extension metody a yield return

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/o9_L_DQ0IJ0" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

Dnešní video pak představuje moje oblíbené demo, které dělám na každém druhém kurzu a kde si každý divák najde něco svého.

Jeho hlavním tématem je cesta C# od delegátů k lambda expressions. V úvodním dílu tohoto seriálu jsem zmínil, že C# dnes je jazykem _multiparadigmatickým_, že v něm lze programovat jak imperativně, tak funkcionálně. Typickou funkcionální konstrukcí je pak možnost předat kus programového kódu (třeba podmínku) jako argument nějaké metody, která se pak stane univerzálnější.

To C# umožňoval odjakživa v podobě dnes už poněkud pozapomenuté feature delegátů. Ale postupem času přibyla řada syntaktického cukru, která umožňovala ten předávaný kód zapisovat stále efektivněji a stručněji. Nejnovější evolucí jsou právě _lambda expressions_ (poznáte je podle používaného symbolu `=>`). Současný styl kódu počítá s jejich samozřejmou znalostí a využívá je velice extenzivně. Má zkušenost ale říká, že mnoho programátorů se v nich poněkud utápí. Moje video jim pomůže pochopit, jak vlastně vznikly a jak fungují.

Vedlejšími tématy tohoto videa jsou zajímavá konstrukce `yield return` a pro úplnost se podíváme na extension metody, které umožňují rozšiřovat objekty o instanční metody, aniž by bylo nutné je modifikovat (nebo mít k modifikaci vůbec možnost).

Kombinace výše zmíněných technik pak vede k možnosti vytvoření technologie LINQ (Language Integrated Query), sloužící k dotazování do objektových datových struktur. V podobě _LINQ to Enumerable_ jednoduše vykoná předaný kód jako argument, ale v pokročilejších variantách (jako je _LINQ to entities_) umí předanou lambda expression (resp. expression tree) nikoliv spustit, ale analyzovat a přeložit do jazyka úložiště (např. příslušného dialektu SQL), což umožňuje C# programátorům užívajícím Entity Framework psát komplexní dotazy, aniž by museli znát SQL nebo řešit rozdíly mezi jednotlivými relačními databázemi.