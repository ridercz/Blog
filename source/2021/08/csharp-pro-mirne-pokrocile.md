<!-- dcterms:title = Nový seriál na Z-TECHU: C# pro mírně pokročilé -->
<!-- dcterms:abstract = C# je univerzální imperativní procedurální objektový reflexivní staticky typovaný jazyk s unifikovaným systémem typů. To vám teoreticky říká vše, co o něm potřebujete vědět. Ale co to znamená? A je to po dvaceti letech vývoje vlastně ještě vůbec pravda? Dneškem začínáme na kanále Z-TECH nový seriál o C# pro mírně pokročilé, kde si postupně ukážeme vývoj pokročilejších konstrukcí a možnosti současné verze C# 9.0 (a trochu i těch budoucích). -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/logo-csharp.svg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20200512-taghelpers.png-->
<!-- x4w:category = Z-TECH -->
<!-- x4w:category = IT -->
<!-- dcterms:dateAccepted = 2021-08-19 -->

C# je univerzální imperativní procedurální objektový reflexivní staticky typovaný jazyk s unifikovaným systémem typů. To vám teoreticky říká vše, co o něm potřebujete vědět. Ale co to znamená? A je to po dvaceti letech vývoje vlastně ještě vůbec pravda?

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/IjmnNzkfdkY" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

Dnešní C# (verze 9.0) je univerzální multiparadigmatický jazyk, který se od svých počátků výrazně změnil. Když začnu psát kód plný lambda expression a pattern matchingu, značná část C# programátorů na mne nevěřícně zírá. Vypadá to jako když se splaší psací stroj a nevěří, že se to byť jenom zkompiluje, natož aby to něco dělalo.

Proto jsem se rozhodl udělat seriál o C# pro mírně pokročilé. Jeho cílovou skupinou jsou lidé, kteří v C# programují, ale delší dobu neměli čas se mu nějak systematicky věnovat. Jednotlivé díly popisují, co do C# postupně přibývalo a jak se rozšiřují naše možnosti. Předpokládám, že mnoho z toho, o čem budu mluvit, již znáte, ale že můj výklad vás přesto naučí něco nového a umožní vám vaše znalosti uvést do kontextu a téma hlouběji pochopit.

> **Pokud jste začátečníci a chcete se naučit C#**, toto nejsou videa pro vás. Ale můžete se podívat na [seriál Petra Voborníka](https://bit.ly/ZakladyCs), který je určen právě pro začátečníky a vykládá C# od základů.

Dnes jsem zveřejnil [úvodní díl](https://youtu.be/IjmnNzkfdkY), další budou následovat každý čtvrtek v týdenních intervalech:

1. **Generické typy** se objevily už v C# 2.0, ale od té doby se dále rozvinuly. Řeč bude i o generických constraintech a jejich využítí.
1. **Od delegátů od lambda expressions a LINQ** je demo, které předvádím skoro na každém svém školení. Snažím se z "lambda expressions" strhnout závoj tajemna a ukázat, jak se vlastně vyvinuli a co je vlastně ten slavný LINQ.
1. **Vlastnosti vlastností** jsou oblast, ve které se C# za léta hodně změnilo a zjednodušilo, přibyla spousta syntaktického cukru.
1. **Rozšiřitelnost tříd** pomocí dědičnosti je základní vlastnost všech objektově orientovaných jazyků. C# ale umí i jiné věci, parciální metody a extension metody.
1. **Miliardová chyba jménem null** se bude věnovat hodnotě `null`. Povíme si o hodnotových a referenčních typech, speciálních operátorech pro práci s `null` a o tom, jak se současný C# snaží vyvarovat nepopulární `NullReferenceException` za běhu.
1. **Argumenty metod** za dvacet let existence doznaly značných vylepšení. Od pojmenovaných a volitelných argumentů přes caller info atributy po discards a readonly references.
1. **Formátování řetězců** je zajímavé a podceňované téma, od jednoduchého escapingu po stringovou interpolaci, s přesahem do internacionalizace a významu rozhraní `IFormattable`.

**Všechny díly** postupně najdete v [tomto playlistu](https://www.youtube.com/playlist?list=PLFZurxJN0pMZQ7fGjEiAN0EE9fP6XxjzM). 