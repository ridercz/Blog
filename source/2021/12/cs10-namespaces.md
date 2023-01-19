<!-- dcterms:title = C# pro mírně pokročilé: Namespaces v C# 10 -->
<!-- dcterms:abstract = Nejnovější verze C# 10 přináší novinky - zjednodušení - v práci s namespaces a tomu odpovídá i nová podoba výchozích šablon pro projekty. V tomto dílu seriálu o C# pro mírně pokročilé se na tyto novinky podíváme podrobněji. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/logo-csharp.svg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20200512-taghelpers.png-->
<!-- x4w:category = Z-TECH -->
<!-- x4w:category = IT -->
<!-- x4w:serial = C# pro mírně pokročilé -->
<!-- dcterms:date = 2021-12-27 -->

Nejnovější verze C# 10 přináší novinky - zjednodušení - v práci s namespaces a tomu odpovídá i nová podoba výchozích šablon pro projekty. V tomto dílu seriálu o C# pro mírně pokročilé se na tyto novinky podíváme podrobněji.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/ccaKwY9I5Bk" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

Na _konceptu_ namespaces se nic nezměnilo. Změnil se jenom způsob, jakým se mohou zapisovat a referencovat.

Tradičně C# používá konstrukci `namespace X.Y.Z { ... }`, kdy se kód (typicky tříd a dalších konstrukcí) zapisuje do složených závorek, jako všude jinde v C#. Ve většině případů ale platí, že všechny konstrukce definované v jednom souboru jsou v jednom namespace a tudíž tato "povinná" konstrukce jenom přidává jednu úroveň odsazení zcela zbytečně. Verze 10 pro tento případ umožňuje určit namespace jako `namespace X.Y.Z;`. Je to zjednodušení a zlé jazyky říkají, že to Microsoft udělal, aby ušetřil místo na disku na GitHubu - protože ušetří pár bajtů na každém řádku, podle toho jestli používáte tabulátor nebo mezery.

Další novinka spočívá v možnosti používat u namespaces konstrukci `global using`, referenci v projektovém souboru a výchozí reference v SDK. Prakticky v každém C# souboru máte na začátku import namespaces jako `System`, `System.Linq`, `System.Collections.Generic` a podobně. Global usings vám umožňují naimportovat namespaces na úrovni celého projektu. Buďto tak, že je do libovolného souboru napíšete jako `global using X.Y.Z;` nebo tím, že příslušnou referenci vložíte do projektového souboru.

Podle typu projektu/SDK (`Microsoft.NET.Sdk`, `Microsoft.NET.Sdk.Web`, `Microsoft.NET.Sdk.Worker`) jsou navíc některé namespaces naimportovány automaticky. Pro nejjednodušší šablonu konzolové aplikace (`Microsoft.NET.Sdk`) jsou automaticky importovány tyto namespaces:

* `System`
* `System.IO`
* `System.Collections.Generic`
* `System.Linq`
* `System.Net.Http`
* `System.Threading`
* `System.Threading.Tasks`

> Tento seznam jsem našel v [dokumentaci](https://docs.microsoft.com/en-us/dotnet/core/tutorials/top-level-templates#implicit-using-directives). Bohužel se mi nepodařilo zjistit seznam NS pro SDK Web a Worker. Pokud se to podaří vám, dejte mi prosím vědět, doplním to do článku.

S těmito změnami pak souvisí ještě jedna. A to, že výrazně ubylo ceremonií, které je nutné provést, aby jednoduchá aplikace fungovala. Takže u klasické _hello world_ aplikace stačí napsat do `Program.cs` jediný řádek:

```csharp
Console.WriteLine("Hello, World!");
```

Postará se o to kombinace global usings v SDK a již z verze C# 9 známá feature top-level commands, kdy může existovat nejvýše jeden soubor (typicky `Program.cs`), kde se příkazy mohou psát přímo na nejvyšší úroveň, bez nutnosti definovat třídy a metody.

## Krok dobrý nebo špatný?

Z těchto novinek v C# mám poněkud rozporuplný pocit. Z pohledu zkušeného C# programátora jsou dobré, protože zjednodušují kód. Není nutné psát pořád dokolečka `static void Main` a `using System;`. Z pohledu začínajícího programátora to je ale dvojsečná zbraň. Na první pohled je vše jednodušší a prostě stačí do `.cs` souboru příkazy a ono se to vykoná. Není to ještě tak jednoduché, jako třeba v Pythonu, kde není třeba ani ekvivalent `.csproj` souboru, ale věřím že postupem se i k tomu dopracujeme.

Nicméně vzrůstá počet věcí, které fungují a programátor neví proč a jak. A počet výjimek. Proč nemusím psát `System.IO`, ale třeba `System.Math` ano? Já vím proč -- práce se soubory se používá častěji než matematické funkce. Ale pro začátečníka to nemusí být tak jasné. Pro mne osobně je programování mimo jiné hledáním patternů, opakujících se vzorů, které pak mohu použít i v neznámých oblastech. C# mi v tomto směru přišel vždycky výborný, protože je konzistentní. Co se jednou naučím mohu používat opakovaně, do nekonečna. Přidané změny zavádějí různé výjimky z pravidel ve jménu jednoduchosti triviálních aplikací, což nemusí být dobře.