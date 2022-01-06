<!-- dcterms:title = Jak se uchovávají čísla v C# a jak to souvisí s chybou v Exchange serveru -->
<!-- dcterms:abstract = I úplní počítačoví laici vědí, že počítače počítají ve dvojkové soustavě - že přemýšlejí v jedničkách a nulách. Pojďme se podívat na to, jak je to doopravdy a jak funguje ukládání celých čísel se znaménkem i bez znaménka v jazyce C# a prostředí .NET. A jak to souvisí s tím, že mnoho Microsoft Exchange serverů přestalo na Nový rok 2022 úderem půlnoci doručovat poštu. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20220106-csharp-cisla.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20220106-csharp-cisla.jpg -->
<!-- x4w:coverCredits = Alexander Sinn via Unsplash.com -->
<!-- x4w:category = Z-TECH -->
<!-- x4w:category = IT -->
<!-- x4w:serial = C# pro mírně pokročilé -->
<!-- dcterms:dateAccepted = 2022-01-06 -->

I úplní počítačoví laici vědí, že počítače počítají ve dvojkové soustavě - že přemýšlejí v jedničkách a nulách. Pojďme se podívat na to, jak je to doopravdy a jak funguje ukládání celých čísel se znaménkem i bez znaménka v jazyce C# a prostředí .NET. A jak to souvisí s tím, že mnoho Microsoft Exchange serverů přestalo na Nový rok 2022 úderem půlnoci doručovat poštu.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/yHUF7msEyAM" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

Na té nejnižší úrovni ukládají počítače veškerá data jako sekvenci binárních číslic, jedniček a nul.

## Celočíselné datové typy

Jazyk C# nabízí řadu datových typů pro úschovu celých čísel. Nejjednodušší je datový typ `System.Byte` (v C# reprezentovaný klíčovým slovem `byte`), což je osmibitové (jednobajtové) číslo bez znaménka. Tento datový typ může uchovávat 2<sup>8</sup> (tj. 256) hodnot, tj. čísla od 0 do 255.

Pro případ, že potřebujeme uchovávat vyšší čísla bez znaménka, existují další datové typy, které mají více bitů a tedy i větší rozsah:

CLI datový typ  | C# keyword | Bity | Bajty | Max. hodnota (desítkově)
--------------- | ---------- | ---: | ----: | -----------------------:
`System.Byte`   | `byte`     | 8    |     1 | 255
`System.UInt16` | `ushort`   | 16   |     2 | 65 535
`System.UInt32` | `uint`     | 32   |     4 | 4 294 967 295
`System.UInt64` | `ulong`    | 64   |     8 | 18 446 744 073 709 551 615

Pokud chceme uchovávat čísla se znaménkem, používá se kódování zvané [_dvojkový doplněk_](https://cs.wikipedia.org/wiki/Dvojkov%C3%BD_dopln%C4%9Bk) (případně _doplňkový kód_). To funguje tak, že nejvyšší bit se používá pro určení, zda je číslo kladné (nula) nebo záporné (jednička). V případě záporného čísla se od jeho absolutní hodnoty odečte jednička a do zbylých bitů se zakóduje jeho inverzní hodnota (tj. prohodí se jedničky a nuly). 

Důsledkem tohoto postupu je, že minimální hodnota uchovatelná v n-bitovém datovém typu je -2<sup>n-1</sup> a maximální 2<sup>n-1</sup>-1. Rozsah je asymetrický, protože do kladné části se "musí vejít" i nula.

Datové typy pro čísla se znaménkem jsou v C# následující:

CLI datový typ | C# keyword | Bity | Bajty | Minimum                     | Maximum
-------------- | ---------- | ---: | ----: | --------------------------: | ------:
`System.Int16` | `short`    | 16   |     2 | - 32 768                    | 32 767
`System.Int32` | `int`      | 32   |     4 | - 2 147 483 648             | 2 147 483 647
`System.Int64` | `long`     | 64   |     8 | - 9 223 372 036 854 775 808 | 9 223 372 036 854 775 807

## Nativní datové typy

Jazyk C# a platforma .NET funguje všude výše popsaným způsobem. Jiné jazyky - např. C/C++ - ale mohou mít jiné chování v závislosti na hardware a použitém operačním systému. Typ `int` pak může uchovávat různou hodnotu. Dobře je to vidět třeba na [platformě Arduino](https://www.arduino.cc/reference/en/language/variables/data-types/int/). Na klasických ATmega deskách jde o typ čestnáctibitový (tj. odpovídající `short` v tabulce výše), zatímco na SAMD deskách jako je třeba MKR1000 jde o typ 32-bitový.

C# má speciální datové typy `nshort`, `nushort`, `nint`, `nuint`, `nlong` a `nulong`, u nichž je toto chování reflektováno. Prefix `n` znamená _native_ a daný typ má tedy velikost nativní pro danou platformu. V praxi ale tyhle typy nejspíš nevyužijete, protože se používají hlavně pro pointery a pointerovou aritmetiku, tedy unmanaged kód.

## Proč tedy spadl ten Exchange?

Bystřejším ze čtenářů to patrně došlo už při pohledu na nejvyšší hodnotu, kterou umí uchovávat datový typ `Int32`: 2147483647. Programátor modulu pro antimalware kontrolu se rozhodl ukládat datum a čas jako číselnou hodnotu ve formátu `YYYYMMDDhhmm`. Takže zatímco poslední sekunda starého roku měla hodnotu `2112312359` (což se do rozsahu `Int32` vejde), první sekunda roku nového je `2201010000`, což maximální kapacitu `Int32` přesahuje.

> Jsem si vědom toho, že podle chybové hlášky patřičný modul nejspíše nebyl programován v .NETu. Nehodlám si ale hezkou a poučnou historku kazit nudnou realitou ;-)

Morální ponaučení z toho plynoucí je, že byste datumové hodnoty neměli ukládat tímto způsobem do celočíselných datových typů. Jak byste je tedy měli ukládat? Typicky se používá počet nějakých intervalů od nějakého okamžiku. Klasický _unix time_ počítá počet sekund od půlnoci 1. 1. 1970. Což má ovšem taky svá úskalí: Pokud - jak je obvyklé - pro ukládání datumu a času použijete datový typ `Int32`, dojde vám místo 19. ledna 2038 krátce po třetí ráno. Říká se tomu [Problém roku 2038](https://cs.wikipedia.org/wiki/Probl%C3%A9m_roku_2038) a bude s tím myslím mnohem víc zábavy než se slavným [Y2K](https://cs.wikipedia.org/wiki/Probl%C3%A9m_roku_2000).

Platforma .NET na to jde od začátku docela fikaně: [ukládá datum](https://docs.microsoft.com/en-us/dotnet/api/system.datetime?view=net-6.0) jako počet _ticks_ ("tiknutí") od půlnoci 1. 1. roku 1 n. l., a to jako 64-bitové číslo se znaménkem. Jeden _tick_ je sto nanosekund, tedy jedna desetitisícina sekundy. Což nám vystačí až [do konce roku 9999](https://docs.microsoft.com/en-us/dotnet/api/system.datetime.maxvalue?view=net-6.0).

> Aby se programátoři nenudili, tak v databázích je to zase ještě jinak a rozsah i přesnost datumových funkcí se liší. Například v Microsoft SQL Serveru máme pro tento účel hned [šest datových typů](https://docs.microsoft.com/en-us/sql/t-sql/data-types/date-and-time-types?view=sql-server-ver15) s různou přesností i rozsahem.