<!-- dcterms:title = C# pro mírně pokročilé: Formátování řetězců, rozhraní IFormattable a string interpolation -->
<!-- dcterms:abstract = Každý objekt v C# lze pomocí metody ToString převést na řetězec. Ale jak si poradit, když je třeba řešit formátování a internacionalizaci? Od toho je tady rozhraní IFormattable. A další radosti zažijete s metodou String.Format a string interpolation. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20210923-csharp-format.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20210923-csharp-format.jpg-->
<!-- x4w:category = Z-TECH -->
<!-- x4w:category = IT -->
<!-- dcterms:dateAccepted = 2021-09-23 -->

Řetězce se v C# zapisují do uvozovek a pro speciální znaky se používají stejné escape sekvence jako v C, tedy zpětné lomítko a za ním něco dalšího. Např. pomocí sekvence `\"` lze zapsat uvozovky jako součást řetězce, `\r\n` je zalomení řádku pomocí CRLF a `\\` je obyčejné zpětné lomítko. 

```cs
var s = "\"Congrats\" to your baby.\r\n"
      + "Congrats to \"your\" baby.\r\n"
      + "Congrats to your \"baby\".";
```

Escapování pomocí zpětného lomítka je leckdy poněkud nepraktické, zejména při zapisování cest ve file systému na Windows, kdy je nutné cesty zdvojovat. Ale existuje alternativa, které se říká [verbatim strings](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/tokens/verbatim). Pokud před uvozovky napíšete zavináč, bere se vše až po další uvozovky jako součást řetězce. Tyto dva řádky jsou tedy ekvivalentní:

```cs
var s = "C:\\Users\\Altair\\Documents";
var s = @"C:\Users\Altair\Documents";
```

Součástí řetězce pak může být i zalomení řádku. Jediné co je nutné escapovat jsou pak uvozovky - ty je nutné zdvojit:

```cs
var s = @"""Congrats"" to your baby.
Congrats to ""your"" baby.
Congrats to your ""baby"".";
```

## Metoda ToString

Všechny objekty v C# mají metodu `ToString()`, která je převede na řetězec. Tuto metodu má definovánu třída `object` (`System.Object`), od které jsou poděděné všechny ostatní typy. Standardně vrací název objektu, ale lze ji přepsat tak, aby vracela nějakou stringovou reprezentaci daného objektu. Třeba anonymní typy a záznamy (records) vypíší své vlastnosti, číselné typy svou hodnotu a podobně.

Ale co když potřebujeme výstup nějak formátovat? Od toho je v .NETu [rozhraní `IFormattable`](https://docs.microsoft.com/en-us/dotnet/api/system.iformattable), které nabízí jiný overload metody `ToString`, kde lze specifikovat podrobnější instrukce pro výsledek.

## String.Format a string interpolation

Pro skládání řetězců podle šablon slouží metoda `String.Format`. Ta umožňuje definovat šablonu, obsahující očíslované placeholdery `{0}`, `{1}` atd. a na jejich místo se doplní hodnoty dalších argumentů. Většina lidí ví, že za číslo můžete napsat dvojtečky a požadovaný formátovací řetězec právě pro `IFormattable`:

```cs
var t = 20;
var s = string.Format("Teplota {0:F2} °C", t); // Výsledek: Teplota 20,00 °C
```

Již méně lidí ale ví, že před dvojtečku lze napsat ještě čárku a číslo. Pokud je kladné, bude výsledek zleva doplněn mezerami, aby celkový počet znaků odpovídal zadanému číslu; pokud je číslo záporné, budou se doplňovat mezery zprava. To je velice užitečné při vytváření tabulek v podobě prostého textu, třeba při výpisu na konzoli.

Z podobného vrhu je i funkce [string interpolation](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/tokens/interpolated). Pokud před řetězec napíšete znak `$`, umožňuje to totéž jako `String.Format`, ale do složených závorek můžete napsat jakýkoliv C# výraz. I zde lze používat formátování pomocí čárky a dvojtečky:

```cs
var t = 20;
var s = $"Teplota {t:F2} °C"; // Výsledek: Teplota 20,00 °C
```

String interpolation a verbatim strings lze kombinovat, pokud před řetězec napíšete `@$"..."` nebo `$@"..."`.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/JUT47rjcLTI" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>