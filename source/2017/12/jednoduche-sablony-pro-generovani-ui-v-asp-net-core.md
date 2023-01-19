<!-- dcterms:identifier = aspnetcz#5464 -->
<!-- dcterms:title = Jednoduché šablony pro generování UI v ASP.NET Core -->
<!-- dcterms:abstract = Další z mých mezisvátkových open source projektů je sada šablon pro dynamické generování UI v ASP.NET Razor Pages a MVC Core. -->
<!-- np9:categoryId = 7 -->
<!-- x4w:category = Software -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2017-12-27T01:52:35.187+01:00 -->
<!-- dcterms:date = 2017-12-27T01:53:52.03+01:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20171227-jednoduche-sablony-pro-generovani-ui-v-asp-net-core.png -->

Další z mých mezisvátkových open source projektů je sada šablon pro dynamické generování UI v ASP.NET Razor Pages a MVC Core. Jedná se o ideového nástupce mého NuGet balíčku [Altairis.Mvc.EditorTemplates](https://www.nuget.org/packages/Altairis.Mvc.EditorTemplates/), který jsem vytvořil pro ASP.NET MVC 5.

Píšete-li aplikace v ASP.NET MVC nebo Razor Pages, téměř s jistotou používáte dynamické generování uživatelského rozhraní. Buďto na úrovni jednotlivých polí (`@Html.EditorFor(m => m.Field)` nebo `asp-for="Model.Field"`) nebo na úrovni celého modelu (`@Html.EditorForModel()`). V takovém případě ASP.NET standardně pro generování HTML použije své vestavěné šablony, které jsou připraveny na použití UI frameworku Bootstrap a obsahují tedy patřičné HTML a CSS třídy.

Já Bootstrap nepoužívám a nemám rád. Dávám přednost sémantickému, čistému HTML. Proto jsem hledal jednodušší šablony, které by bootstrapové konstrukce neobsahovaly. ASP.NET použité šablony umožňuje modifikovat. Stačí nahrát soubory s názvem odpovídajícím logickému typu pole do `~/Views/Shared/EditorTemplates/*název_typu*.cshtml` (pro MVC) nebo do `~/Pages/EditorTemplates/*název_typu*.cshtml` pro Razor Pages.

Vytvořil jsem tedy sadu šablon pro minimální implementaci. Obsahují opravdu jenom ten minimální markup, který obsahuje pouze minimální formátování. Pro staré MVC (5.0) je k dispozici jako NuGet balíček [Altairis.Mvc.EditorTemplates](https://www.nuget.org/packages/Altairis.Mvc.EditorTemplates/). 

## Instalace šablon

Pro Core verzi jsem zvolil poněkud jiný způsob distribuce. U šablon se totiž předpokládá, že je budete hojně modifikovat dle potřeb svých a podle typu aplikace. Tj. jednou se nakopírují, ale nejspíše je nebudete nikdy aktualizovat. NuGet balíčky jsou tedy pro tento případ dosti nevhodné.

Inspiroval jsem se proto u projektu IdentityServer, který [šablony pro svůj quickstart](https://github.com/IdentityServer/IdentityServer4.Quickstart.UI/) instaluje pomocí PowerShellu (na Windows) nebo Bashe (na Linuxu a Mac OS). Pro instalaci tedy stačí z příkazové řádky spustit kód, který z GitHubu stáhne soubory a nakopíruje je na patřičná místa.

Samozřejmě vše můžete udělat i ručně. V zásadě jde pouze o stažení souborů ze složky [EditorTemplates](https://github.com/ridercz/Altairis.RazorPages.EditorTemplates/tree/master/Pages/EditorTemplates) a jejich nakopírování do správného adresáře. Nicméně instalační skript dokáže celou záležitost značně zjednodušit.

**Zdrojové kódy projektu i návod k jeho instalaci najdete na **[**GitHubu**](https://github.com/ridercz/Altairis.RazorPages.EditorTemplates)**.**