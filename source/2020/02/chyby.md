<!-- dcterms:title = Globální ošetřování (a logování) chyb v ASP.NET aplikacích -->
<!-- dcterms:abstract = Aplikace obsahují chyby a nelze se tomu vyhnout. Nicméně pokud už chyba nastala, je třeba zařídit dvě věci: nějakým přiměřeným způsobem o ní informovat uživatele a nějakým přiměřeným způsobem o ní zaznamenat data pro programátora. Ukážeme si, jak tyto dvě věci realizovat v aktuální verzi ASP.NET Core. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:coverUrl = /cover-pictures/20200211-chyby.jpg -->
<!-- x4w:pictureUrl = /perex-pictures/20200211-chyby.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = Bezpečnost -->
<!-- dcterms:dateAccepted = 2020-02-11 -->

Aplikace obsahují chyby a nelze se tomu vyhnout. Musíme s nimi počítat a když k nim dojde, ošetřit je. Což znamená zejména zařídit dvě věci: nějakým přiměřeným způsobem o ní informovat uživatele a nějakým přiměřeným způsobem o ní zaznamenat data pro programátora. Ukážeme si, jak tyto dvě věci realizovat v aktuální verzi ASP.NET Core.

## Ošetřování HTTP chyb

První druhem jsou HTTP chyby, tj. chyby na web serveru. Zejména se jedná o neexistující stránky (populární HTTP status `404 Object Not Found`), v menší míře pak chyby týkající se autentizace a autorizace (stavy `401 Unauthorized`, `403 Forbidden`). Nejnověji pak třeba `451 Unavailable For Legal Reasons` dle RFC 7725, který se dočkal masivního rozšíření poté, co se EU ve své nekonečné moudrosti začala snažit nutit GDPR i subjektům mimo svou jurisdikci.

Ve výchozí konfiguraci Kestrel (HTTP server pro ASP.NET Core) v případě chyby vrátí prázdnou odpověď s odpovídajícím stavovým kódem, což se v prohlížeči zobrazí jako prázdná stránka. To z hlediska UX není úplně optimální a chceme dělat něco jiného. ASP.NET Core obsahuje několik middleware, které s HTTP chybami dokáží naložit jinak - stačí je aplikovat v metodě `Configure` třídy `Startup`.

### UseStatusCodePages

```csharp
app.UseStatusCodePages();
```

Toto prosté volání způsobí, že server vrátí čistě textovou (content-type `text/plain`) odpověď, např. `Status Code: 404; Not Found`.

Metoda `UseStatusCodePages` má několik overloadů, jeden z nich umožní určit, jaký má mít vrácená odpověď typ a obsah. Můžete použít placeholder `{0}`, na jehož místo se doplní číselný kód.Následující volání vygeneruje jednoduchou HTML stránku:

```csharp
app.UseStatusCodePages("text/html", "<html><head><title>HTTP {0}</title></head><body><h1>HTTP Error {0}</h1></body></html>");
```

### UseStatusCodePagesWithRedirects

```csharp
app.UseStatusCodePagesWithRedirects("/Errors/{0}.html");
```

Tento middleware způsobí přesměrování na zadanou adresu (i zde můžete použít placeholder `{0}`). **Velice důrazně doporučuji tento způsob nepoužívat**, neboť není strojově detekovatelné, že se jedná o chybu. Uživatel je prostě přesměrován (standardním redirectem) na stránku, která vrátí `200 OK`.

### UseStatusCodePagesWithReExecute

```csharp
app.UseStatusCodePagesWithReExecute("/Errors/{0}");
```

Lepší varianta je poslední middleware, který funguje velmi podobně, ale uživatele nepřesměruje. Interně přepíše požadavek na novou adresu, ale adresa na klientovi ani HTTP status se nezmění. Záleží na vás, co umístíte na adresu `/Errors/{0}` (kde placeholder opět odpovídá číslu chyby). 

Může to být MVC controller, který zobrazí vhodnou chybovou stránku. Já dávám přednost Razor Pages. Vytvořím jednoduchou Razor Page `~/Pages/Errors/Index.cshtml` (nemusí mít viewmodel) s přibližně následujícím obsahem:

```
@page "{statusCode}"
@{ ViewBag.Title = "HTTP Error " + this.RouteData.Values["statusCode"]; }
<h1>@ViewBag.Title</h1>
<p>V průběhu zpracování vašeho požadavku došlo k chybě.</p>
```

Pro obsluhu nejčastější chyby číslo `404` pak mám speciální stránku `~/Pages/Errors/404.cshtml`:

```
@page
@{ ViewBag.Title = "HTTP Error 404: Object Not Found"; }
<h1>@ViewBag.Title</h1>
<p>Požadovaná stránka neexistuje.</p>
```

Obojí předpokládá existenci layout page, která do titulku stránky vloží to, co najde ve `ViewBag.Title`.

## Ošetřování výjimek

Výše uvedené si poradí se všemi chybami, kromě vnitřní chyby aplikace - `500 Internal Server Error`. Pokud vaše aplikace vyhodí výjimku (exception), zobrazí se opět prázdná bílá stránka.

Pro ošetřování výjimek má ASP.NET Core zvláští middleware, Exception Handler. Aktivujete jej takto:

```csharp
app.UseExceptionHandler("/Errors/Internal");
```

Funguje podobně jako `UseStatusCodePagesWithReExecute` v případě HTTP chyb. Vnitřně se adresa přepíše na adresu, kterou jste zde uvedli.

## Logování výjimek v chybové stránce

Jak již bylo řečeno, chybová stránka by měla udělat dvě základní věci:

* **Informovat uživatele**, že došlo k chybě. Pokud možno nepříliš podrobně, protože detailní informace o chybě mohou být bezpečnostně kritické.
* **Zaznamenat podrobné informace o chybě** a informovat vývojáře.

Obecně lze pro sledování aplikace použít mnoho způsobů, od rozličného logování po sofistikované služby typu Application Insights. Mně se nicméně pro výjimky výtečně osvědčuje jednoduché posílání mailů nebo logování do souboru. Snahou je, aby programátor získal maximum informací ohledně okolností, za nichž se výjimka vyskytla (protože na smysluplný popis od uživatele spoléhat nelze).

Kromě základních informací (jako je čas, URL, kompletní chybová zpráva a stack trace) se hodí znát:

* Zda byl uživatel přihlášen a pokud ano, tak pod jakým účtem a s jakými claimy.
* Odeslaná formulářová data.
* Cookies.
* HTTP hlavičky.

Z těchto informací zpravidla dokážete vyčíst, co se v aplikaci stalo za průšvih. Zcela záměrně pro jejich zaznamenávání nepoužívám žádný sofistikovaný logovací framework, ale primitivní kód, který je uloží do textového souboru. Pokud aplikace spadla na exception, bude se nejspíš nacházet v nějakém divném stavu a kód pro jeho vyřešení by měl být pokud možno co nejjednodušší, protože pokud spadne i on, nikdo nepomůže.

Moje obvyklá chybová stránka obsahuje ještě jednu funkcionalitu: při každém pádu vygeneruje unikátní číslo a zobrazí ho uživateli. Pokud ten kontaktuje podporu, lze jeho konkrétní pád spojit se záznamem v logu.

Abychom zjistili informace o výjimce, musíme použít _HTTP Context Features_. Co to je, o tom detailně napíšu někdy jindy, ale nyní je podstatné, že potřebujeme získat informace o výjimce a také o té stránce, kde došlo k chybě (vlastnosti typu `Request.Path` odkazují na stránku, která ošetřuje chybu):

```csharp
var err = this.HttpContext.Features.Get<IExceptionHandlerPathFeature>();
var errUrl = new UriBuilder(this.Request.GetDisplayUrl()) { Path = err.Path };
```

V proměnné `err` budeme mít k dispozici vlastnost `Error`, která obsahuje odpovídající `Exception` a vlastnost `Path`, která obsahuje cestu původní stránky s chybou. Pomocí URI Builderu pak vytvoříme odpovídající kompletní adresu `errUrl`.

Kompletní zdrojový kód ViewModelu stránky `~/Pages/Errors/Internal.cshtml.cs` vypadá takto:

```csharp
public class InternalModel : PageModel {
    private readonly IWebHostEnvironment environment;

    public InternalModel(IWebHostEnvironment environment) {
        this.environment = environment;
    }

    public string LogId { get; set; }

    public async Task OnGet() {
        // Gather information
        this.LogId = $"{DateTime.UtcNow:yyyyMMddHHmmss}-{this.HttpContext.TraceIdentifier}";
        var err = this.HttpContext.Features.Get<IExceptionHandlerPathFeature>();
        var errUrl = new UriBuilder(this.Request.GetDisplayUrl()) { Path = err.Path };

        // Log basic info
        var sb = new StringBuilder();
        sb.AppendLine($"ID: {this.LogId}");
        sb.AppendLine($"Date: {DateTime.UtcNow:o}");
        sb.AppendLine($"Exception: {err.Error.Message}");
        sb.AppendLine($"URL: {errUrl}");
        sb.AppendLine($"Method: {this.Request.Method}");
        sb.AppendLine($"HTTPS: {this.Request.IsHttps}");
        sb.AppendLine($"Connection: {this.HttpContext.Connection.RemoteIpAddress} (:{this.HttpContext.Connection.RemotePort}) -> {this.HttpContext.Connection.LocalIpAddress} (:{this.HttpContext.Connection.LocalPort})");
        sb.AppendLine();

        // User
        if (this.User.Identity.IsAuthenticated) {
            sb.AppendLine("# Authenticated user");
            var cid = this.User.Identity as ClaimsIdentity;
            foreach (var item in cid.Claims) sb.AppendLine($"{item.Type} = {item.Value}");
        } else {
            sb.AppendLine("# No authenticated user");
        }
        sb.AppendLine();

        // Form data
        if (this.Request.HasFormContentType) {
            sb.AppendLine("# Form data");
            foreach (var item in this.Request.Form) sb.AppendLine($"{item.Key} = {item.Value}");
        } else {
            sb.AppendLine("# No form data");
        }
        sb.AppendLine();

        // Cookies
        if (this.Request.Cookies.Any()) {
            sb.AppendLine("# Cookies");
            foreach (var item in this.Request.Cookies) sb.AppendLine($"{item.Key} = {item.Value}");
        } else {
            sb.AppendLine("# No cookies");
        }
        sb.AppendLine();

        // Headers
        sb.AppendLine("# HTTP headers");
        foreach (var item in this.Request.Headers) sb.AppendLine($"{item.Key} = {item.Value}");
        sb.AppendLine();

        // Exception
        sb.AppendLine("# Exception");
        sb.AppendLine(err.Error.ToString());
        sb.AppendLine();

        // Write log file
        sb.AppendLine("# End of file");
        var logFileName = Path.Combine(this.environment.ContentRootPath, "App_Data/AppErrorLogs", this.LogId + ".log");
        Directory.CreateDirectory(Path.GetDirectoryName(logFileName));
        await System.IO.File.WriteAllTextAsync(logFileName, sb.ToString()).ConfigureAwait(false);
    }
}
```

Při pádu aplikace se veškeré informace uloží do souboru ve složce `App_Data/AppErrorLogs` v rootu aplikace. Název souboru je složen z aktuálního datumu a času a ID požadavku. Odpovídá tedy ID chyby, které je zobrazeno uživateli a podle něj lze odpovídající log dohledat.

Pro pořádek, soubor `~/Pages/Errors/Internal.cshtml`, který zobrazuje zprávu uživateli, vypadá takto:

```html
@page
@model InternalModel
@{ ViewBag.Title = "HTTP Error 500: Internal Server Error"; }
<h1>@ViewBag.Title</h1>
<p>V průběhu zpracování vašeho požadavku došlo k chybě.</p>
<p>Chyba byla zaznamenána pod následujícím ID: <code>@Model.LogId</code></p>
```

## Jiné nastavení pro vývoj a produkci

Shora uvedená nastavení jsou určena pro staging a produkci. Pro vývojovou verzi je samozřejmě rozumné zobrazovat informace o chybě přímo. Do metody `Configure` si tedy nechte nainjectovat `IWebHostEnvironment` a podle něj rozhodněte, jak se k ošetřování chyb postavíte:

```csharp
if (env.IsDevelopment()) {
    app.UseDeveloperExceptionPage();
    app.UseDatabaseErrorPage();
} else {
    app.UseExceptionHandler("/Errors/Internal");
    app.UseStatusCodePagesWithReExecute("/Errors/{0}");
}
```
