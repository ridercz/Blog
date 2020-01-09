<!-- dcterms:title = Pár tipů pro konzolové aplikace -->
<!-- dcterms:abstract = Mám rád konzolové aplikace a často je píšu. Tedy aplikace spouštěné z příkazové řádky, bez grafického rozhraní, typicky ovládané pomocí přepínačů z příkazové řádky. Je jednoduché je psát (a jednoduché psát je tak, aby fungovaly na Windows, Linuxu i Mac OS). Hodí se pro jednorázové úkoly nebo naopak pro úkoly, které se spouštějí často a fungují automaticky. Dnes bych se s vámi rád podělil o několik triků, jak konzolové aplikace psát v .NETu. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:coverUrl = /cover-pictures/20200109-console.jpg -->
<!-- x4w:pictureUrl = /perex-pictures/20200109-console.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = IT -->
<!-- dcterms:dateAccepted = 2020-01-09 -->

Mám rád konzolové aplikace a často je píšu. Tedy aplikace spouštěné z příkazové řádky, bez grafického rozhraní, typicky ovládané pomocí přepínačů z příkazové řádky. Je jednoduché je psát (a jednoduché psát je tak, aby fungovaly na Windows, Linuxu i Mac OS). Hodí se pro jednorázové úkoly nebo naopak pro úkoly, které se spouštějí často a fungují automaticky. Dnes bych se s vámi rád podělil o několik triků, jak konzolové aplikace psát v .NETu.

## Parsování argumentů pomocí NConsoleru

Jak již bylo řečeno, konzolové aplikace jsou zpravidla neinteraktivní, ovládají se sbírkou argumentů z příkazové řádky. Takže je třeba onu příkazovou řádku nějak vyhodnotit, proparsovat, zjistit co tam je, protože některé parametry jsou volitelné a podobně.

Jednoduché leč elegantní řešení představuje **NConsoler**. To je knihovna, která slouží k parsování příkazového řádku a jednoduchému command dispatchingu. Najdete ji na [github.com/csharpus/NConsoler](https://github.com/csharpus/NConsoler). Je to projekt dosti letitý a už dlouho na něj nikdo pořádně nesáhl, ale ničemu to zásadně nevadí. Před nějakou dobou se mi podařilo se s původními autory spojit, zapojit se do vývoje a vyřešit licencování. NConsoler historicky neměl žádnou formálně stanovenou licenci, teď je licencován pod MIT.

Kód jednoduché aplikace může vypadat následovně:

```csharp
using System;
using NConsoler;

namespace ConsoleApp1 {
    class Program {
        static void Main(string[] args) {
            Console.WriteLine("Sample application using NConsoler in .NET Core");
            Console.WriteLine();

            Consolery.Run();
        }

        [Action("Does something")]
        public static void DoSomething() {
            Console.WriteLine("Doing something");
        }

        [Action("Counts from minimum to maximum")]
        public static void Count(
            [Required(Description = "Minimum value")] int min,
            [Required(Description = "Maximum value")] int max,
            [Optional(1, "s", Description = "Step")] int step,
            [Optional(false, "b", Description = "Count backwards")] bool backwards) {

            if (max <= min) {
                Console.WriteLine("FAILED! Maximum value must be greater than minimum value.");
                Environment.Exit(1);
            }
            if (step < 1) {
                Console.WriteLine("FAILED! Step must be greater or equal to 1.");
                Environment.Exit(1);
            }

            if (backwards) {
                for (var i = max; i >= min; i -= step) {
                    Console.WriteLine(i);
                }
            } else {
                for (var i = min; i <= max; i += step) {
                    Console.WriteLine(i);
                }
            }
        }

    }
}
```

Jednotlivé statické metody jsou odekorovány atributem `[Action]` a jejich argumenty atributy `[Required]` nebo `[Optional]`. Na základě těchto atributů NConsoler udělá command dispatching, načte příkazovou řádku a zadané argumenty použije při volání action metody. Zadané údaje - zejména hodnotu `Description` použije pro automatické vygenerování nápovědy.

> Můžete si stáhnout [kompletní ukázkový projekt](https://www.cdn.altairis.cz/Blog/2020/20200109-console-nconsoler.zip) aplikace využívající NConsoler.

## Komplexní konzolové aplikace pomocí CommandLineUtils

NConsoler je jednoduché řešení pro malé projekty. Kromě parsování příkazové řádky toho mnoho nenabízí a předpokládá, že všechny příkazy (akce) budou v jednom souboru, což je pro velké projekty nevhodné.

Ze zcela opačného konce je knihovna **CommandLineUtils**. Tu původně - jako `Microsoft.Extensions.CommandLineUtils` - začal vyvíjet Microsoft v rámci ASP.NET Core. Později ji opustil a chopil se jí Nate McMaster, který ji nadále udržuje na [github.com/natemcmaster/CommandLineUtils](https://github.com/natemcmaster/CommandLineUtils). Základním principem psaní aplikací pomocí tohoto frameworku je, že každý příkaz má svou vlastní třídu a argumenty příkazové řádky jsou předávány jako její vlastnosti. Příkazy mohou mít podpříkazy a tak dále. Na ukázku, zde je implementace příkazu `Count` z předchozího kódu:

```csharp
using McMaster.Extensions.CommandLineUtils;
using System;
using System.ComponentModel.DataAnnotations;

namespace ConsoleApp2 {
    [Command(Description = "Counts from minimum to maximum")]
    [CountCommandValidation]
    class CountCommand {

        [Argument(0, Name = "min", Description = "Minimum value")]
        [Required]
        public int Minimum { get; set; }

        [Argument(1, Name = "max", Description = "Maximum value")]
        [Required]
        public int Maximum { get; set; }

        [Option("-s:<step>", Description = "Count step")]
        [Range(1, int.MaxValue)]
        public int Step { get; set; } = 1;

        [Option("-b", Description = "Count backwards")]
        public bool Backwards { get; set; }

        public int OnExecute(CommandLineApplication app) {
            if (this.Backwards) {
                for (var i = this.Maximum; i >= this.Minimum; i -= this.Step) {
                    Console.WriteLine(i);
                }
            } else {
                for (var i = this.Minimum; i <= this.Maximum; i += this.Step) {
                    Console.WriteLine(i);
                }
            }
            return 0;
        }

    }
}
```

Na rozdíl od NConsoleru nabízí CommandLineUtils řadu způsobů, jak aplikace psát (použití atributů je jenom jeden z nich) a jde daleko za parsování příkazové řádky. Podporuje asynchronní příkazyt a řadu dalších věcí.

> Můžete si stáhnout [kompletní ukázkový projekt](https://www.cdn.altairis.cz/Blog/2020/20200109-console-extensions.zip) aplikace využívající CommandLineUtils.

## Zobrazování průběhu a ošetření chyb

Většina mých konzolových aplikací jsou utilitky, které vykonají sekvenčně nějakou sadu kroků, přičemž na konzoli vypisují, co dělají. Uživatel tedy ví co se právě děje a pokud dojde k nějakému problému, kde nastal. Typický kód vypadá nějak takhle:

```csharp
Console.Write("Doing someting...");
try {
    // Here is code that may fail, ie. I/O code
    Console.WriteLine("OK");
}
catch (Exception ex) {
    Console.WriteLine("Failed!");
    Console.WriteLine(ex.Message);
    Environment.Exit(1);
}
```

Tyto bloky se neustále opakují, pokaždé když je třeba udělat něco, co potenciálně může selhat, například načítání dat ze souboru (který nemusí existovat) atd.

Postupem času jsem vypracoval základní kostru aplikace (nad NConsolerem), která vypadá následovně:

```csharp
using System;
using System.IO;
using NConsoler;

namespace Altairis.Tmd.Compiler {
    internal class Program {
        private const int ERRORLEVEL_SUCCESS = 0;
        private const int ERRORLEVEL_FAILURE = 1;

        private static bool debugMode;

        private static void Main(string[] args) {
            var version = System.Reflection.Assembly.GetExecutingAssembly().GetName().Version;
            Console.WriteLine($"Utility that does something {version:4}");
            Console.WriteLine("Copyright (c) Michal Altair Valasek - Altairis, 2020");
            Console.WriteLine("www.altairis.cz | www.rider.cz | github.com/ridercz/");
            Console.WriteLine();
            Consolery.Run();
        }

        [Action("Do something")]
        public static void DoSomething(
            [Required(Description = "Input file name")] string inputFileName,
            [Optional(null, "o", Description = "Output file name")] string outputFileName,
            [Optional(false, Description = "Show detailed exception messages")] bool debug
            ) {

            debugMode = debug;

            // Read source
            var source = TryDo(
                $"Reading source from {inputFileName}...",
                () => File.ReadAllText(inputFileName)
            );

            // Save to output file
            if (string.IsNullOrWhiteSpace(outputFileName)) outputFileName = Path.Combine(Path.GetDirectoryName(inputFileName), Path.GetFileNameWithoutExtension(inputFileName) + ".out");
            TryDo(
                $"Saving to {outputFileName}...",
                () => File.WriteAllText(outputFileName, source)
            );

            Environment.Exit(ERRORLEVEL_SUCCESS);
        }

        // Helper methods

        private static T TryDo<T>(string message, Func<T> func) {
            try {
                Console.Write(message);
                var result = func();
                Console.WriteLine("OK");
                return result;
#pragma warning disable CA1031 // Do not catch general exception types
            } catch (Exception ex) {
                CrashExit("FAILED: {0}", ex);
                return default;
            }
#pragma warning restore CA1031 // Do not catch general exception types
        }

        private static void TryDo(string message, Action action) {
            try {
                Console.Write(message);
                action();
                Console.WriteLine("OK");
#pragma warning disable CA1031 // Do not catch general exception types
            } catch (Exception ex) {
                CrashExit("FAILED: {0}", ex);
            }
#pragma warning restore CA1031 // Do not catch general exception types
        }

        private static void CrashExit(string message, Exception ex = null) {
            if (ex == null) {
                Console.Error.WriteLine(message);
            } else {
                Console.Error.WriteLine(message, ex.Message);
                if (debugMode) {
                    Console.Error.WriteLine(new string('-', Console.BufferWidth));
                    Console.Error.WriteLine(ex.ToString());
                    Console.Error.WriteLine(new string('-', Console.BufferWidth));
                }
            }

            Console.Error.WriteLine("Program execution terminated.");
            Environment.Exit(ERRORLEVEL_FAILURE);
        }

    }
}

```

Metoda `Main` pouze vypíše základní informace o aplikaci a její verzi a spustí NConsoler command dispatching.

Akční metody (zde je jediná, `DoSomething`) dělají vlastní operace (zde se jenom zkopíruje obsah jednoho textového souboru do druhého). Kromě svých vlastních argumentů mají všechny ještě argument `debug` který, je-li nastaven na `true` (tj. v příkazové řádce je přítomen přepínač `/debug`) způsobí, že se v případě chyby zobrazí kompletní informace o exception, nikoliv jenom její `Message`.

Tuto logiku (a obecně zobrazení chyb) zajišťuje metoda `CrashExit`, která slouží k ukončení aplikace s návratovým kódem `ERRORLEVEL_FAILURE` (`1`) v případě chyby.

Hodně používané (i když trochu zvláštním způsobem) jsou dva overloady metody `TryDo`. Jde v podstatě o wrappery nad libovolnou akcí (která je definována jako `Func<T>` nebo `Action`, podle toho zda se má vracet návratová hodnota nebo nikoliv). Tyto wrappery vypíší, co aplikace zrovna dělá a pokud to dopadne špatně, aplikaci ukončí se zobrazením chyby.

Úplně první příklad z této sekce tedy můžeme snadno zapsat takto:

```csharp
TryDo("Doing something...", () => {
    // Here is code that may fail, ie. I/O code
});
```

Zde je srovnání s předchozím kódem:

<pre>
<del>Console.Write("Doing someting...");
try {</del>
<ins>TryDo("Doing something...", () => {</ins>
    // Here is code that may fail, ie. I/O code
    <del>Console.WriteLine("OK");</del>
<ins>});</ins>
<del>catch (Exception ex) {
    Console.WriteLine("Failed!");
    Console.WriteLine(ex.Message);
    Environment.Exit(1);
}</del>
</pre>

Zápis je to dle mého názoru podstatně přehlednější a elegantnější.