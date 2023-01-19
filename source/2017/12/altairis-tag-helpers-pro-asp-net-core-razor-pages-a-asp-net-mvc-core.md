<!-- dcterms:identifier = aspnetcz#5463 -->
<!-- dcterms:title = Altairis Tag Helpers pro ASP.NET Core Razor Pages a ASP.NET MVC Core -->
<!-- dcterms:abstract = Jako poněkud opožděný vánoční dárek jsem zveřejnil sadu užitečných tag helperů pro ASP.NET Core Razor Pages a ASP.NET MVC Core. -->
<!-- np9:categoryId = 7 -->
<!-- x4w:category = Software -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2017-12-26T19:04:07.563+01:00 -->
<!-- dcterms:date = 2017-12-26T19:00:00+01:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20171226-altairis-tag-helpers-pro-asp-net-core-razor-pages-a-asp-net-mvc-core.png -->

Jako poněkud opožděný vánoční dárek jsem zveřejnil sadu užitečných tag helperů pro ASP.NET Core Razor Pages a ASP.NET MVC Core. Je to sada drobných ale užitečných tag helperů, které přidávají nové pseudo-HTML elementy nebo atributy do Razor souborů. Mohou se vám hodit v praxi, případně jako inspirace pro tvorbu vlastních. Pokud vytvoříte nějaké další užitečné, budu rád pokud mi pošlete pull request.

## Instalace

Knihovna je šířena pomocí NuGetu jako balíček `Altairis.TagHelpers`. Nainstalujte si jej pomocí package manageru.

Poté je nutno tag helpery zaregistrovat, což jest učiniti přidáním direktivy `@addTagHelper *, Altairis.TagHelpers` do CSHTML souboru, kde je chcete používat, případně do `_ViewImports.cshtml`, pro registraci v celé aplikaci.

## Dostupné tag helpery

*   `GravatarTagHelper` přidává nový element `<gravatar>`, který zobrazí uživatelskou ikonu ze služby [Gravatar](https://www.gravatar.com/).
*   `RolesTagHelper` přidává všem elementům atributy `include-roles` a `exclude-roles`, pomocí kterých lze učinit element viditelný nebo neviditelný pro určité skupiny uživatelů.
*   `TimeTagHelper` rozšiřuje HTML5 element `<time>` o možnosti relativního formátování času.
*   `TrimLengthTagHelper` umožňuje zkrátit dlouhý obsah textu elementu.
*   `VisibleTagHelper` umožňuje podmíněně zakázat zobrazení elementu.

**Zdrojové kódy a příklad najdete na **[**GitHubu**](https://github.com/ridercz/Altairis.TagHelpers)** a dokumentaci na **[**tamní wiki**](https://github.com/ridercz/Altairis.TagHelpers/wiki)**.**