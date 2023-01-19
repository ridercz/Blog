<!-- dcterms:title = Altairis Tag Helpers - nová verze s kalendářem -->
<!-- dcterms:abstract = O své knihovně Altairis.TagHelpers, která přidává různé tag helpery pro Razor v ASP.NET Core (MVC i Razor Pages) jsem zde již několikrát psal. Nyní je k dispozici verze 1.7, která přidává podporu pro zobrazení kalendáře s událostmi. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:coverUrl = /cover-pictures/20200512-taghelpers.png -->
<!-- x4w:pictureUrl = /perex-pictures/20200512-taghelpers.png -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = IT -->
<!-- dcterms:date = 2020-05-12 -->

O své knihovně Altairis.TagHelpers, která přidává různé tag helpery pro Razor v ASP.NET Core (MVC i Razor Pages) jsem zde již několikrát psal. 

* [Altairis Tag Helpers pro ASP.NET Core Razor Pages a ASP.NET MVC Core](https://www.altair.blog/2017/12/altairis-tag-helpers-pro-asp-net-core-razor-pages-a-asp-net-mvc-core)
* [Nové tag helpery v knihovně Altairis Tag Helpers](https://www.altair.blog/2019/05/nove-tag-helpery)
* [Ambient route values a ASP.NET Core Endpoint Routing](https://www.altair.blog/2020/02/ambient-route-values)

Nyní je k dispozici verze 1.7, která přidává podporu pro zobrazení kalendáře s událostmi.

## Vylepšený `TimeTagHelper`

Drobných vylepšení se dočkal [`TimeTagHelper`](https://github.com/ridercz/Altairis.TagHelpers/wiki/TimeTagHelper). Nyní můžete příslušné formátovací řetězce zadávat přímo jako atributy, nejenom je injectovat do konfigurace. To se hodí, pokud chcete na nějakém specifickém místě v aplikaci zobrazovat datum a čas jiným způsobem.

Hlavní změna ale spočívá v tom, že tag helper nyní umí (nepovinně) využívat [`IDateProvider`](https://www.altair.blog/2020/04/dateprovider) z knihovny [Altairis.Services.DateProvider](https://github.com/ridercz/Altairis.Services.DateProvider).

## Kalendář

Pro jeden projekt jsem potřeboval zobrazit kalendář. Zhruba takový jaký se ukazuje při měsíčním pohledu v Outlooku.

![](https://raw.githubusercontent.com/wiki/ridercz/Altairis.TagHelpers/CalendarTagHelper.png)

Hledal jsem hotové řešení a našel jsem jich spoustu. Všechna byla strašlivě složitá. Obvykle vyžadovala tunu JavaScriptu nebo nějaký specifický UI framework. Mnohdy navíc byla omezena na jeden kalendářní měsíc a vinou renderování v tabulce se nedala rozumně použít na mobilu.

Rozhodl jsem se tedy napsat kalendář, který má následující vlastnosti:

* Renderuje sémantické HTML, které lze libovolně nastylovat.
* Nevyžaduje JavaScript.
* Umí zobrazit libovolné datumové rozmezí.
* Podporuje zobrazení různých druhů událostí - celodenní, se zadaným začátkem a volitelně koncem, vícedenní...
* Podporuje internacionalizaci

Kompletní [dokumentaci najdete na wiki](https://github.com/ridercz/Altairis.TagHelpers/wiki/CalendarTagHelper) projektu.
