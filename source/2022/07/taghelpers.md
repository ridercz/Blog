<!-- dcterms:title = Nová verze Altairis Tag Helpers pro ASP.NET Core -->
<!-- dcterms:abstract = Po delší době jsem vydal novou verzi 1.12 své knihovny Altairis Tag Helpers. Využívá nových vlastností platformy .NET a jazyka C# a nabízí nový EditorTagHelper. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20220710-taghelpers.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20220710-taghelpers.jpg -->
<!-- x4w:category = IT -->
<!-- dcterms:dateAccepted = 2022-07-10 -->

**Po delší době jsem vydal novou verzi 1.12 své knihovny [Altairis Tag Helpers](https://github.com/ridercz/Altairis.TagHelpers).**

V první řadě využívá nových vlastností platformy .NET a jazyka C#:

* Upgrade ukázkové aplikace na ASP.NET 6.0.
* Využití implicit a global usings.
* Využití file-scoped namespaces.
* Využití nullable extensions.

Dále pak nabízí nový [`EditorTagHelper`](https://github.com/ridercz/Altairis.TagHelpers/wiki/EditorTagHelper). Jde o tag helper ekvivalent HTML helperu `@Html.EditorFor(...)`. Při jeho tvorbě jsem se hodně inspiroval stejnojmenným helperem z knihovny [TagHelperPack](https://github.com/DamianEdwards/TagHelperPack) od Damiana Edwardse.

Kromě toho jsem trochu aktualizoval dokumentaci. Doplnil jsem popis [možností konfigurace](https://github.com/ridercz/Altairis.TagHelpers/wiki/GravatarTagHelper#configuration) tag helperu pro Gravatar. Ta je sice možná už od verze 1.11, ale jaksi jsem ji zapomněl aktualizovat.

No a konečně, `RolesTagHelper` už nevyžaduje, abyste do IoC/DI zaregistrovali `IHttpContextAccessor` a místo toho využívá `ViewContext`.

Nová verze je [na GitHubu](https://github.com/ridercz/Altairis.TagHelpers) a samozřejmě na NuGetu jako balíček `Altairis.TagHelpers`.