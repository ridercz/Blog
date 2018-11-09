<!-- dcterms:identifier = aspnetcz#5413 -->
<!-- dcterms:title = Jak na automatické verzování v nových verzích .NET a VS -->
<!-- dcterms:abstract = Starší verze .NET Frameworku podporovaly automatické verzování, kdy se část informace o verzi vygenerovala automaticky podle datumu a času. Verze 4.5 nicméně přešla na sémantické verzování a tuto funkcionalitu ztratila. Jak ji vrátit zpátky? -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2013-11-08T19:54:51.947+01:00 -->
<!-- dcterms:dateAccepted = 2013-11-08T19:54:52+01:00 -->
<!-- dcterms:modified = 2018-11-08 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20131108-jak-na-automaticke-verzovani-v-novych-verzich-net-a-vs.png -->

> Obsah tohoto článku je již poněkud zastaralý. Pokud vás zajímá, jak tento problém vyřešit v aktuálním .NET Core, napsal jsem o tom [novější článek](/2018/11/automaticke-verzovani-v-core).

Starší verze .NET Frameworku podporovaly automatické verzování. Pokud jste verzi zapsali například jako 1.0.*, komponenty Build a Revision se vygenerovaly automaticky podle datumu a času buildu. Verze 4.5 nicméně přešla na sémantické verzování a tuto funkcionalitu ztratila.

Sémantické verzování (semantic versioning) si klade za cíl vnést logiku do procesu určování čísel verzí software. Má docela smysluplná pravidla, která lze nalézt na webu [SemVer.org](https://www.semver.org). Tento postup je velmi vhodný pro verzování komponent a dalších věcí, na kterých závisí široká skupina uživatelů.

Již méně je vhodný pro vývoj webových aplikací, které fungují v jedné nebo několika málo instancích a mění se velmi často. A přitom je dobré vědět, jaká verze je kde právě nasazená. Sémantické verzování vyžaduje, aby se verze měnila ručně a programátor ji ručně nastavil tak, jak odpovídá povaze provedených změn. V tom opačném případě je žádoucí, aby se alespoň část verze generovala automaticky a měnila se – při každém buildu, v závislosti na čase… To bohužel Visual Studio při práci s novými verzemi .NET Frameworku neumí.

Snažil jsem se to vyřešit pomocí různých add-inů, ale žádný z nich nefungoval dlouhodobě spolehlivě. Takže jsem add-iny zatratil a rozhodl se to vyřešit jinak, pomocí MS Build tasků.

Proces buildu je velmi dobře rozšiřitelný a lze v něm dělat v podstatě cokoliv, pokud máte správný task. Některé jsou přímo součástí instalace, další si můžete snadno napsat sami. Já budu používat úkoly z projektu [MS Build Community Tasks](https://github.com/loresoft/msbuildtasks/).

Prvním krokem je instalace MS Build Community Tasks. To se dá nainstalovat buďto ručně, nebo pomocí NuGet balíčku. Zvolil jsem cestu NuGet balíčku, protože pak je všechno potřebné součástí projektu a netřeba spoléhat na to, že bude nainstalován lokálně. Balíček nainstalujete následujícím příkazem:

```
Install-Package MSBuildTasks
```

Na tomto balíčku je zvláštní, že nemodifikuje konkrétní projekt, ale do solution přidá novou složku `.build`, která obsahuje potřebné soubory `MSBuild.Community.Tasks.dll` a `MSBuild.Community.Tasks.targets`. Také obsahuje ukázkový projekt `Build.proj`, který ale nebudeme potřebovat a je možné ho smazat. Balíček stačí nainstalovat do jednoho projektu v solution.

Dále pak je nezbytné modifikovat projektový soubor (`.csproj`) každého projektu, u něhož se má automatické verzování používat. Projektový soubor je obyčejné XML. Můžete ho editovat v libovolném textovém editoru, když nemáte ve Visual Studiu otevřený projekt, který obsahuje. Případně jej můžete editovat i ve Visual Studiu samém, když z kontextového menu zvolíte _Unload project_ a potom _Edit něco.csproj_.

Na konec souboru (před tag `</Project>`)  vložte následující kód (samozřejmě upravte metadata tak, aby vám vyhovovala):

```xml
<PropertyGroup>
  <MSBuildCommunityTasksPath>$(SolutionDir)\.build</MSBuildCommunityTasksPath>
</PropertyGroup>
<Import Project="$(MSBuildCommunityTasksPath)\MSBuild.Community.Tasks.Targets" />
<Target Name="BeforeBuild">
  <Time Format="yyyy.MM.dd.HHmm" Kind="Utc">
    <Output TaskParameter="Year" PropertyName="Year" />
    <Output TaskParameter="FormattedTime" PropertyName="TimeVersion" />
  </Time>
  <Message Text="$(AssemblyName) version $(TimeVersion)" Importance="high" />
  <AssemblyInfo CodeLanguage="CS"
                OutputFile="Properties\AssemblyInfo.cs"
                AssemblyTitle="My Assembly Title"
                AssemblyDescription="My Assembly Description"
                AssemblyCompany="My Company"
                AssemblyProduct="My Product Name"
                AssemblyTrademark="My Trademark"
                AssemblyCopyright="Copyright © $(Year)"
                AssemblyConfiguration="$(BuildConfiguration)"
                AssemblyVersion="$(TimeVersion)"
                AssemblyFileVersion="$(TimeVersion)" />
</Target>
```

Výše uvedené nasatvení při každém buildu dynamicky vygeneruje soubor `Properties\AssemblyInfo.cs` a nastaví v něm metadata dle zadání. Verzi přitom automaticky vygeneruje podle aktuálního datumu a času v UTC ve formátu `yyyy.MM.dd.HHmm`. Pokud tedy aktuální čas je `8. 11. 2013, 19:25 SEČ`, verze bude `2013.11.8.1825`. Rovněž se dynamicky doplní rok do aktuální informace o copyrightu.

MS Build Community Tasks nabízí i zvláštní task _Version_, který umí čísla verzí generovat sofistikovaněji, například "starým" algoritmem, kdy je Build rovno počtu dnů od 1. 1. 2000 a Revision počtu sekund od půlnoci děleno dvěma (vše lokálního času).

Berte prosím na vědomí, že výše uvedeným postupem se při každém buildu přegeneruje aoubor `AssemblyInfo.cs` a odstraní se všechno, co v něm bylo. Pokud tam tedy máte ještě nějaké další atributy, musíte je umístit do jiného souboru.Může být také dobrý nápad odstranit tento soubor z version controllingu, protože se vám bude neustále měnit pod rukama.

Knihovna MS Build Community Tasks obsahuje i celou řadu dalších užitečných tasků. Kvalita dokumentace se nicméně pohybuje mezi "mizerná" a "žádná", takže je lepší se podívat do zdrojáků.
