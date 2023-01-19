<!-- dcterms:title = Desetinná čísla v C# a .NET -->
<!-- dcterms:abstract = Ve starším článku a videu jsem se zabýval tím, jak jsou v .NETu ukládána celá čísla se znaménkem i bez něj. Logický dotaz byl jak jsou ukládána čísla desetinná. V .NETu na to máme čtyři datové typy a je s tím spousta zábavy. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20220106-csharp-cisla.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20220106-csharp-cisla.jpg -->
<!-- x4w:coverCredits = Alexander Sinn via Unsplash.com -->
<!-- x4w:category = Z-TECH -->
<!-- x4w:category = IT -->
<!-- dcterms:date = 2022-04-12 -->

Ve [starším článku a videu](https://www.altair.blog/2022/01/csharp-numbers) jsem se zabýval tím, jak jsou v .NETu ukládána celá čísla se znaménkem i bez něj. Logický dotaz byl jak jsou ukládána čísla desetinná. V .NETu na to máme čtyři datové typy a je s tím spousta zábavy.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/t_Do1Cb-ccY" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

Desetinná čísla umějí počítače ukládat buďto s pevnou nebo plovoucí desetinnou čárkou. 

Čísla s pevnou desetinnou čáskou mají pevně stanovenou přesnost na určitý počet desetinných míst a používají se třeba v Microsoft SQL Serveru. Jazyk C# a platforma .NET takové datové typy nemají. Podobné funkcionality můžete nicméně dosáhnout prostě tak, že použijete celočíselné typy a hodnoty vynásobíte příslušnou mocninou deseti. Například pro měny se často používá ukládání v haléřích, že 1 Kč se uloží jako 100 atd., čímž se vyhnete některým (ne všem) problémům při práci s desetinnými čísly

Čísla s plovoucí desetinnou čárkou nemají přesnost takto fixně stanovenu a používají se rozličné triky, jejichž cílem je dosáhnout co největší přenosti s co nejmenší spotřebou paměti. V .NETu máme k dispozici následující desetinné datové typy:

CLI datový typ   | C# keyword | Suffix | Bity | Bajty | Minimum | Maximum
---------------- | ---------- | ------ | ---: | ----: | ------: | ------:
`System.Half`    |            |        | 16   | 2     | -65 500 | +65 500
`System.Single`  | `float`    | `f`    | 32   | 4     | -3,403 &times; 10<sup>38</sup> | +3,403 &times; 10<sup>38</sup>
`System.Double`  | `double`   | `d`    | 64   | 8     | -1,797 &times; 10<sup>308</sup> | 1,797 &times; 10<sup>308</sup>
`System.Decimal` | `decimal`  | `m`    | 128  | 16    | -7,923 &times; 10<sup>28</sup> | 7,923 &times; 10<sup>28</sup>

`System.Half` je datový typ, [který se objevil v .NET 5.0](https://devblogs.microsoft.com/dotnet/introducing-the-half-type/). Nabízí poměrně malý rozsah hodnot a přesnost, ale zato zabírá jenom šestnáct bitů, takže se hodí v případě, že jich máte opravdu hodně, jako třeba v machine learningu. Informace o ostatních datových typech najdete v článku [Floating-point numeric types (C# reference)](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/builtin-types/floating-point-numeric-types).

## Binární datové typy

Datové typy `Half`, `Single` a `Double` ukládají data binárně. Podrobný popis toho, jak konkrétně se ukládají najdete na webu [C# in Depth](https://csharpindepth.com/articles/FloatingPoint).

Tento způsob ukládání je sice velice efektivní, ale je omezený v tom, že neumožňuje přesně ukládat některé hodnoty a výsledky aritmetických operací pak neodpovídají realitě:

```csharp
float a = 1.05f;
float b = 0.05f;
float c = 1.10f;

Console.WriteLine(a + b == c);
```

Tento program vypíše `False`. Protože výsledkem součtu nebude `1.1`, jak bychom očekávali, ale `1.0999999`. Problém lze vyřešit tím, že použijeme datový typ `double`, ale tím ho jenom odsuneme, stačí přidat pár nul za desetinnou čárku:

```csharp
double a = 1.00005d;
double b = 0.00005d;
double c = 1.00010d;
Console.WriteLine(a + b == c);
```

V tomto případě bude výsledek `1.0001000000000002` místo očekávaného `1.0001`.

## Desítkový datový typ `decimal`

Záchranu slibuje datový typ `decimal`, který data ukládá desítkově, ne binárně. Nicméně nechá si za svou službu dobře zaplatit, protože zabírá 128 bitů (16 bajtů) paměti. Za to ovšem máme jistotu, že se nebudeme muset potýkat se shora uvedenými obtížemi.

## Kdy použít jaký typ?

* Pokud potřebujete absolutní přesnost, typicky protože se jedná o peníze a podobné hodnoty, použijte datový typ `decimal`. Stejně tak pokud je hodnot málo a nezáleží vám na paměti.
* Pokud je hodnot hodně a pocházejí z reálného světa (naměřené hodnoty apod.), použijte klidně `single` nebo `double`, podle požadované přesnosti a upravte kód tak, aby si dokázal s nepřesnostmi poradit. Naměřené hodnoty - teploty, napětí a podobně - jsou samy zatíženy jistou chybou měření a drobné chyby někde daleko za desetinnou čárkou asi dokážete přežít.