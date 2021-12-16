<!-- dcterms:title = C# pro mírně pokročilé: Kolekce a práce s nimi -->
<!-- dcterms:abstract = Kolekce v C# slouží k práci s větším množstvím objektů stejného typu. Je jich mnoho druhů a každý se hodí k něčemu trochu jinému. V dnešním videu z série C# pro mírně pokročilé se na ně podíváme trochu důkladněji. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20211007-csharp-collections.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20211007-csharp-collections.jpg-->
<!-- x4w:category = Z-TECH -->
<!-- x4w:category = IT -->
<!-- x4w:serial = C# pro mírně pokročilé -->
<!-- dcterms:dateAccepted = 2021-10-07 -->

Kolekce v C# slouží k práci s větším množstvím objektů stejného typu. Je jich mnoho druhů a každý se hodí k něčemu trochu jinému. V dnešním videu z série C# pro mírně pokročilé se na ně podíváme trochu důkladněji.

## Přijímáme kolekce

Pokud jsme na straně příjemce dat v podobě kolekcí, tj. dostáváme nějaký typ kolekce jako argument, je vhodné nepožadovat nějaký konkrétní typ, ale spokojit se s jedním ze tří rozhraní, které typy kolekcí implementují.

Nejjednodušší je rozhraní `IEnumerable<T>`. Pokud kolekce podporuje toto rozhraní, umožní nám enumerovat objekty, tedy projít jeden za druhým. Má jakýsi kurzor, který vrací aktuální objekt, metodu umožňující posunout ho na další prvek a metodu umožňující kurzor resetovat na začátek. Na jednotlivé členy kolekce se nelze přímo odkazovat ani nelze její obsah modifikovat. Ale pro řadu scénářů je prosté `IEnumerable<T>` zcela postačující.

O stupeň výše je rozhraní `ICollection<T>`. Kromě toho že implementuje `IEnumerable<T>`, umožňuje kolekci i modifikovat přidáváním (`Add`) a odebíráním (`Remove`) položek, případně všechny položky smazat (`Clear`). Také umí vrátit počet položek a pár dalších věcí.

Nejschopnější z této trojice je `IList<T>`. Umí vše co `ICollection<T>` a `IEnumerable<T>`, ale navíc umí k jednotlivým položkám přistupovat na základě jejich indexu, přidávat je na konkrétní pozici v seznamu atd.

Pro úplnost zmiňme rozhraní `IQueryable<T>`. To ovšem nemá nic společného s klasickými kolekcemi, ale umožňuje dotazovat se do externích zdrojů dat s využitím jejich vlastních metod filtrování, řazení apod. Např. do relační databáze, kdy se C# zápis převede do příslušného dialektu jazyka SQL.

## Používáme kolekce

Sami si pravděpodobně typy implementující shora uvedená rozhraní vytvářet nebudete, na výběr je z mnoha hotových možností. Liší se schopnostmi a zejména algoritmickou složitostí práce s jednotlivými položkami. Potřebné informace najdete v článku o nich na [docs.microsoft.com](https://docs.microsoft.com/en-us/dotnet/standard/collections/#choose-a-collection). Nejjednodušší kolekci nejspíše představuje `HashSet<T>`. Nejuniverzálnější a nejschopnější je `IList<T>`.

## Fronta a zásobník

Speciální druh kolekcí představuje fronta `Queue<T>` a zásobník `Stack<T>`. Fronta představuje úložiště typu FIFO (_first in, first out_). Do fronty se postupně metodou `Enqueue` přidávají položky a metodou `Dequeue` se odebírají v tom pořadí, v jakém přišly. Zásobník je naopak úložiště typu LIFO (_last in, first out_). Pomocí metody `Push` vložíme položku na vrchol zásobníku a pomocí metody `Pop` vyjmeme položku, která se na vrcholu nachází.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/1aJ34V8gSw8" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>