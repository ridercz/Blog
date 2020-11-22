<!-- dcterms:title = .NET Core je mrtvý, ať žije .NET 5! -->
<!-- dcterms:abstract = Slavná fráze "Le roi est mort, vive le roi!" poprvé zazněla ve Francii v roce 1422, když po smrti Karla VI na trůn nastoupil Karel VII. Zdánlivě paradoxní výrok "Král je mrtev, ať žije král!" má hluboký smysl: sděluje, že ačkoliv konkrétní král zemřel, na jeho místo nastoupíl jiný a král jako instituce je věčný. Ve Francii to pravda s tou věčností úplně nevyšlo, tak uvidíme jak to dopadne s .NETem. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20201122-at-zije-dotnet.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20201122-at-zije-dotnet.jpg -->
<!-- x4w:coverCredits = Roman Synkevych via Unsplash.com -->
<!-- x4w:category = IT -->
<!-- dcterms:dateAccepted = 2020-11-22 -->

Slavná fráze "Le roi est mort, vive le roi!" poprvé zazněla ve Francii v roce 1422, když po smrti Karla VI na trůn nastoupil Karel VII. Zdánlivě paradoxní výrok "Král je mrtev, ať žije král!" má hluboký smysl: sděluje, že ačkoliv konkrétní král zemřel, na jeho místo nastoupíl jiný a král jako instituce je věčný. Ve Francii to pravda s tou věčností úplně nevyšlo, tak uvidíme jak to dopadne s .NETem.

Microsoft před pár dny vydal **.NET 5.0**, čímž ukončil éru frameworků označovaných jako **.NET Core**. Jde ale jenom o změnu názvu, neboť .NET 5.0 je to, co by jinak bylo označené jako ".NET Core 4.0". Jedná se o tradiční poněkud zmatený způsob, jakým Microsoft verzuje své produkty. Nicméně má ve skutečnosti docela smysl.

## Historie verzí .NETu

* **.NET Framework 1.0** (2002) byla první verze, která přinesla nový jazyk C#, koncept managed kódu a ASP.NET.
* **.NET Framework 1.1** (2003) přinesl zejména podporu mobilních ASP.NET server controls a IPv6.
* **.NET Framework 2.0** (2005) byla převratná verze s řadou novinek, jako generické a nulovatelné typy, anonymní metody, plnou podporu x64 a IA64 platforem a velká vylepšení ASP.NET jako obousměrný data binding, membership providers a nové server controls.
* **.NET Framework 3.0** (2006) byla v podstatě sada rozšíření běžících na runtime 2.0; přibyla čtveřice WPF, WCF, WF a CardSpace.
* **.NET Framework 3.5** (2007) také běžela na CLR 2.0 a hlavní novinkou v ní byl LINQ a v SP1 se objevila první verze Entity Frameworku.
* **.NET Framework 4.0** (2010) přinesla po pěti letech nový runtime, paralelní programování, pojmenované a volitelné parametry a code contracts.
* **.NET Framework 4.5** (2012) běžela na CLR 4.0 a přinesla například arynchronní programování, model binding v ASP.NET a nové validační skripty.
* **.NET Framework 4.6** (2015) také běžela na CLR 4.0 a přinesla hlavně aktualizaci kryptografických funkcí.
* **.NET Core 1.0** (2016/06) sdílela osud .NET Frameworku 1.0 v tom, že šlo spíš o technologické demo než reálně masově nasazenou platformu. Přinesla řadu nových konceptů (nový projektový systém, opravdovou multiplatformnost atd.), ale nedočkala se velkého rozšíření.
* **.NET Core 1.1** (2016/11) totéž se dá říct o verzi 1.1 - stejně jako NetFx přinesla spíš drobné změny.
* **.NET Framework 4.7** (2017/04) byla údržbová verze v době, kdy bylo jasné, že .NET Framework je konečná. Přinesla jenom pár drobností, jako podporu novějších kryptografických algoritmů a HighDPI monitorů.
* **.NET Core 2.0** (2017/08) je první verze .NET Core, která se zasadně ujala. Sdílí osud NetFx 2.0 v tom, že to je ta verze, ve které k platformě .NET Core přišla většina lidí a která byla lepší než předchozí generace.
* **.NET Core 2.1** (2018/05) lze přirovnat k NetFx 3.0...
* **.NET Core 2.2** (2018/12) ...a 3.5 - tedy inkrementální vylepšení bez dramatických změn.
* **.NET Framework 4.8** (2019/04) představuje finální verzi .NET Frameworku. Nebude nadále vyvíjen, pouze budou jako setinkové verze opravovány chyby.
* **.NET Core 3.0** (2019/09) je ekvivalentem verzí NetFx 4.0...
* **.NET Core 3.1** (2019/12) ...a 4.5 - tedy další evoluční vylepšení s podstatnými novinkami.

Pracovní název .NET Core 1.0 byl "ASP.NET 5", což byl docela logický krok. Nicméně budil dojem, že stejně jako u předchozích verzí bude stačit pro upgrade aplikací udělat pár změn v souboru `web.config` a jede se dál. Což byl dojem zásadně chybný, protože mezi .NET Frameworkem a .NET Core je spousta obrovských, koncepčních rozdílů. Z tohoto důvodu bylo tedy logické a správné, že název ".NET Core 1.0" jasně ukázal, že jde o generační změnu, o verzi jedna tečka nula něčeho nového.

V roce 2020 nicméně Microsoft stál před rozhodnutím, jak pojmenovat novou verzi. Logicky by se nabízelo ".NET Core 4.0", ale tam by docházelo ke konfliktům mezi 4.x verzí .NET Core a .NET Frameworku. U verzí 1.x-3.x to prakticky nehrozilo, protože totožně číslované verze .NET Frameworku byly více než deset let staré.

Logický krok proto byl jako číslo verze zvolit doposud nepoužitou pětku. No a designace "Core" se tím stává v podstatě zbytečnou. Verze uvedená 10. 11. 2020 se tedy jmenuje **.NET 5.0** a je přímým nástupcem verze .NET Core 3.1. Upgrade aplikací je velmi snadný a bezbolestný, hlavní novinky jsou z hlediska webového programátora spíše v jazyce C# než frameworku samotném.

Takže, .NET Core je mrtev, ať žije .NET 5.0!