<!-- dcterms:title = Ambient route values a ASP.NET Core Endpoint Routing -->
<!-- dcterms:abstract = Upgradovali jste aplikace na ASP.NET 3.x s Endpoint Routingem a přestalo vám fungovat generování odkazů? Možná je to vinou breaking change, změnou zacházení s ambient route values. Ukážu vám, jak se v případě potřeby vrátit ke starému způsobu generování odkazů, aniž byste se museli vzdávat endpoint routingu. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:coverUrl = /cover-pictures/20200219-ambient-route-values.jpg -->
<!-- x4w:pictureUrl = /perex-pictures/20200219-ambient-route-values.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = IT -->
<!-- dcterms:date = 2020-02-19 -->

ASP.NET Core od verze 3.0 ve výchozím nastavení používá a předpokládám použití middleware pro endpoint routing. Co to je? V předchozích verzích si každý middleware řešil routing - tedy jaká akce se vyvolá v závislosti na vybrané URL adrese - vlastními silami a nezávisle na ostatních. Endpoint routing je middleware, který routing dělá sám, jednotně pro všechny.

## Co jsou ambient route values?

Ve verzích bez endpoint routingu jsou při generování URL routingem automaticky doplňovány hodnoty route parametrů z aktuálních. Tj. pokud máte např. Razor Page s route template `products/{productId}/detail` a chcete udělat odkaz na stránku `Edit` s template `products/{productId}/edit`, stačí ne view první stránky napsat `<a asp-page="Edit">` a není explicitně nutné specifikovat hodnotu `productId`. Stejně tak lze použít metody pro generování URL nebo přesměrování typu `RedirectToPage`.

Endpoint routing ambient route values nepodporuje a hodnoty parametrů je nutné specifikovat vždy explicitně, např. `<a asp-page="Edit" asp-route-productId="this.RouteData.Values["productId"]">`. Což některé scénáře docela komplikuje a jiné činí téměř nemožnými.

Hlavní problém ale tkví v tom, že jde o breaking change proti dosavadní logice, která se projevuje velmi zákeřně. Pokud totiž uděláte pomocí tag helperu pro `a` odkaz ne neexistující routu (chybějící parametry), nezahlásí se vám nikde žádná chyba, jen se odkaz vygeneruje jako `<a href="">` a prohlížeče prázdný řetězec odkazu vyhodnotí jako odkaz na sebe sama.

Oficiální zdůvodnění je, že použití ambient hodnot může vést k vygenerování syntakticky validní ale sémanticky chybné URL. Například budete-li mít route templates `products/{id}` a `categories/{id}`, může být při generování změněn význam parametru `id`. Podle mého názoru ovšem platí, že v tomto případě je léčba horší než nemoc, neboť vyhnout se tomuto typu chyb je v podstatě triviální: stačí používat různé názvy pro významově různé parametry, např. `productId` a `categoryId` místo prostého `id`.

## Jak z toho ven?

Nejjednodušší řešení je vypnout endpoint routing, což lze udělat v metodě `Startup.ConfigureServices`:

```csharp
services.AddMvc(options => {
    options.EnableEndpointRouting = false;
});
```

poté v metodě `Configure` tamtéž odstraňte všechny odkazy na routing middleware a místo toho použijte staré `app.UseMvc`.

Nicméně pokud chcete endpoint routing používat -- a v dlouhodobém horizontu vám nic jiného nezbude -- je třeba se z toho nějak vylhat.

## Ambient Anchor Tag Helper

Pokud chcete dosáhnout podobného chování jako v předchozích verzích i s použitím endpoint routingu, musíte si ho napsat sami. Může k tomu posloužit vlastní tag helper. Jeho kód je jednoduchý:

```csharp
using Microsoft.AspNetCore.Mvc.TagHelpers;
using Microsoft.AspNetCore.Mvc.ViewFeatures;
using Microsoft.AspNetCore.Razor.TagHelpers;

namespace Altairis.TagHelpers {

    [HtmlTargetElement("aa", Attributes = ActionAttributeName)]
    [HtmlTargetElement("aa", Attributes = ControllerAttributeName)]
    [HtmlTargetElement("aa", Attributes = AreaAttributeName)]
    [HtmlTargetElement("aa", Attributes = PageAttributeName)]
    [HtmlTargetElement("aa", Attributes = PageHandlerAttributeName)]
    [HtmlTargetElement("aa", Attributes = FragmentAttributeName)]
    [HtmlTargetElement("aa", Attributes = HostAttributeName)]
    [HtmlTargetElement("aa", Attributes = ProtocolAttributeName)]
    [HtmlTargetElement("aa", Attributes = RouteAttributeName)]
    [HtmlTargetElement("aa", Attributes = RouteValuesDictionaryName)]
    [HtmlTargetElement("aa", Attributes = RouteValuesPrefix + "*")]
    public class AmbientAnchorTagHelper : AnchorTagHelper {
        private const string ActionAttributeName = "asp-action";
        private const string ControllerAttributeName = "asp-controller";
        private const string AreaAttributeName = "asp-area";
        private const string PageAttributeName = "asp-page";
        private const string PageHandlerAttributeName = "asp-page-handler";
        private const string FragmentAttributeName = "asp-fragment";
        private const string HostAttributeName = "asp-host";
        private const string ProtocolAttributeName = "asp-protocol";
        private const string RouteAttributeName = "asp-route";
        private const string RouteValuesDictionaryName = "asp-all-route-data";
        private const string RouteValuesPrefix = "asp-route-";

        public AmbientAnchorTagHelper(IHtmlGenerator generator) : base(generator) { }

        public override void Process(TagHelperContext context, TagHelperOutput output) {
            // Make classic anchor tag
            output.TagName = "a";

            // Copy values from current route data
            foreach (var key in this.ViewContext.RouteData.Values.Keys) {
                if (!this.RouteValues.ContainsKey(key)) this.RouteValues[key] = this.ViewContext.RouteData.Values[key].ToString();
            }

            // Process standard anchor helper
            base.Process(context, output);
        }

    }
}
```

Tag helper je poděděný od standardní třídy `AnchorTagHelper`, jenom se váže k elementu `aa` a nikoliv `a`. Dělá vše co standardní, jenom před jejím voláním zkopíruje hodnoty současných route parametrů do vlastní kolekce `RouteValues`.

Obdobně lze pomocí pomocné statické třídy přidat třídě `PageModel` extension metodu `AmbientRedirectToPage`, která se opět chová stejně jako standardní `RedirectToPage` (a má stejné overloady), ale kopíruje hodnoty route parametrů:

```csharp
using System.Collections.Generic;
using System.ComponentModel;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace Altairis.TagHelpers {
    public static class PageModelExtensions {
        public static RedirectToPageResult AmbientRedirectToPage(this PageModel page) => page.AmbientRedirectToPage(pageName: null, pageHandler: null, routeValues: null, fragment: null);

        public static RedirectToPageResult AmbientRedirectToPage(this PageModel page, object routeValues) => page.AmbientRedirectToPage(pageName: null, pageHandler: null, routeValues, fragment: null);

        public static RedirectToPageResult AmbientRedirectToPage(this PageModel page, string pageName) => page.AmbientRedirectToPage(pageName, pageHandler: null, routeValues: null, fragment: null);

        public static RedirectToPageResult AmbientRedirectToPage(this PageModel page, string pageName, object routeValues) => page.AmbientRedirectToPage(pageName, pageHandler: null, routeValues, fragment: null);

        public static RedirectToPageResult AmbientRedirectToPage(this PageModel page, string pageName, string pageHandler) => page.AmbientRedirectToPage(pageName, pageHandler, routeValues: null, fragment: null);

        public static RedirectToPageResult AmbientRedirectToPage(this PageModel page, string pageName, string pageHandler, string fragment) => page.AmbientRedirectToPage(pageName, pageHandler, routeValues: null, fragment);

        public static RedirectToPageResult AmbientRedirectToPage(this PageModel page, string pageName, string pageHandler, object routeValues, string fragment) {
            // Copy values from routeValues object
            var newRouteValues = new Dictionary<string, object>();
            if (routeValues != null) {
                foreach (PropertyDescriptor descriptor in TypeDescriptor.GetProperties(routeValues)) {
                    newRouteValues.Add(descriptor.Name, descriptor.GetValue(routeValues));
                }
            }

            // Copy ambient values
            foreach (var key in page.RouteData.Values.Keys) {
                if (!newRouteValues.ContainsKey(key)) newRouteValues[key] = page.RouteData.Values[key];
            }

            // Call original method
            return page.RedirectToPage(pageName, pageHandler, newRouteValues, fragment);
        }
    }
}
```

Uvedené alternativní postupy fungují celkem dobře; i když je oproti verzi bez endpoint routingu vyžadována změna kódu, je docela jednoduchá a může být často učiněna částečně automaticky.

Jistá změna chování oproti předchozí verzi tam nicméně je: zatímco předchozí implementace "nadpočetné" parametry ignorovala, moje řešení je přidává jako query stringové parametry, což je standardní chování ASP.NET Core pro parametry "navíc".

Bohužel se mi nepodařilo přijít na způsob, jak změnit vlastní generování URL, nenašel jsem žádný extensibility point. Mimo jiné proto jsem tag helper napsal tak, že vyžaduje použití nestandardního elementu `aa` a tím jakýsi opt-in, nikoliv abych jím nahradil standardní `a`.

_Poznámka:_ moje řešení (extension metody nad třídou `PageModel`) počítá pouze s Razor Pages, nikoliv s ASP.NET MVC (tag helper je univerzální). To nemám v lásce a nepoužívám. Vytvoření obdobné třídy s extension metodami pro MVC by však mělo být triviální a budu rád, pokud mi pošlete pull request.

## Altairis Tag Helpers

Výše zmíněný Tag Helper ([a řadu dalších](https://github.com/ridercz/Altairis.TagHelpers/wiki)) a třídu s extension metodami najdete v knihovně Altairis Tag Helpers. Ta je open source a je k dispozici v [podobě zdrojového kódu na GitHubu](https://github.com/ridercz/Altairis.TagHelpers/) nebo jako NuGet balíček [Altairis.TagHelpers](https://www.nuget.org/packages/Altairis.TagHelpers/).