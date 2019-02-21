<!-- dcterms:title = Jak na aktuální adresář v InProcess režimu ASP.NET Core 2.2 -->
<!-- dcterms:abstract = ASP.NET Core 2.2 přinesl novinku: InProcess režim běhu webových aplikací. Došlo tam ovšem k jedné potenciálně breaking change, a to ke změně pracovního adresáře. Třeba EF migrace proti SQLite to nepřijaly úplně s nadšením. Náprava je naštěstí snadná. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20190221-inproc-cwd.png -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20190221-inproc-cwd.jpg -->
<!-- x4w:category = IT -->
<!-- x4w:category = Tipy, triky -->
<!-- dcterms:dateAccepted = 2019-02-21T01:00:00 -->

ASP.NET Core 2.2 přinesl jednu novinku. Webová aplikace nemusí běžet v Kestrelu, ale může být - stejně jako v klasickém .NETu - hostována přímo ve worker procesu IIS. Říká se tomu _in-process mode_, je to ve výchozím nastavení zapnuté a poznáte to podle následující konstrukce v `.csproj` souboru:

```xml
<AspNetCoreHostingModel>InProcess</AspNetCoreHostingModel>
```

Dokumentaci najdete na webu [docs.microsoft.com](https://docs.microsoft.com/en-us/aspnet/core/host-and-deploy/aspnet-core-module?view=aspnetcore-2.2) a skrývá se v ní nenápadná poznámka:

> `GetCurrentDirectory` returns the worker directory of the process started by IIS rather than the app's directory (for example, `C:\Windows\System32\inetsrv` for `w3wp.exe`).

To může být docela problém v případě, že se v aplikaci odkazujete na nějaký soubor určený relativní cestou, která je odvozena od aktuálního adresáře. Mne se to týkalo při použití SQLite embedded databáze. Její connection string vypadá nějak jako `Data Source=App_Data/ask.db` a při použití EF migrací je cesta odvozena od aktuálního adresáře.

Výše uvedená stránka s dokumentací obsahuje odkaz na [velice komplexní řešení](https://github.com/aspnet/Docs/blob/master/aspnetcore/host-and-deploy/aspnet-core-module/samples_snapshot/2.x/CurrentDirectoryHelpers.cs), které navíc nevypadá, že by fungovalo multiplatformně.

Já jsem použil řešení poněkud jednodušší. Nejsem si zcela jist, zda bude spolehlivě fungovat za všech okolností a se všemi providery, ale zatím jej hodnotím jako uspokojivé. Spočívá v tom, že někde na začátku třídy `Startup` nastavíte `Environment.CurrentDirectory = env.ContentRootPath`. Nastavíte tím aktuální adresář na content root, což je stav odpovídající použití Kestrelu.