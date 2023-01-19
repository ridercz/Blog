<!-- dcterms:title = AskMe a ShirtShop: ukázkové aplikace pro Razor Pages a Identity -->
<!-- dcterms:abstract = Aktualizoval jsem dvě ukázkové aplikace, které používám na školeních a přednáškách. Ukazují možnosti využití ASP.NET Core Razor Pages 2.0 a ASP.NET Identity. Najdete je na mém GitHubu. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20181024-ukazkove-aplikace.png -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = IT -->
<!-- x4w:category = Software -->
<!-- dcterms:date = 2018-10-24 -->

Pro účely svých školení a prezentací používám dvě ukázkové aplikace, které jsou postavené na aktuálních Microsoft technologiích. Tedy na ASP.NET Core, Razor Pages a ASP.NET Identity.

## AskMe

První z nich se jmenuje AskMe a jde v podstatě o jednouživatelskou kopii služby [Ask.fm](https://ask.fm/ridercz). Tato služba umožňuje anonymní (nebo pseudo-anonymní) pokládání otázek (můžete se zeptat [i mne](https://ask.fm/ridercz)).

AskMe je jednoduchá, ale kompletní aplikace, která ukazuje zejména:

* Obecný princip tvorby aplikací v ASP.NET Core Razor Pages.
* Použití Entity Frameworku Core pro přístup k datům, včetně migrací a seedingu výchozích dat.
* Použití vestavěných tag helperů a tvorbu vlastních.
* Tvorbu a použití view components.
* Pokročilejší využití viewmodelů v Razor Pages pro zjednodušení stránkování.
* Kombinaci Razor Pages a MVC v jedné aplikaci.
* Základy autentizace uživatelů pomocí ASP.NET Identity.
* Konfigurace a použití `IOptions` v IoC/DI.

Jako datové úložiště aplikace využívá SQLite, takže je multiplatformní a funguje třeba i na Linuxu.

**Zdrojové kódy najdete na [https://github.com/ridercz/AskMe](https://github.com/ridercz/AskMe).**

## ShirtShop

Aplikace Shirt Shop je objednávkový formulář pro objednávání triček. Je opět postaven na Razor Pages, ale jeho hlavním účelem je ukázat možnosti ASP.NET Identity. Jedná se nejspíš o nejlépe zabezpečený objednávkový formulář na světě, protože podporuje například:

* Základní přihlašování pomocí jmen a hesel.
* Dvoufaktorovou autentizaci pomocí jednorázových hesel generovaných mobilní aplikací.
* Generování a použití recovery kódů.
* Přihlašování pomocí externích identity providerů jako je Facebook, Google, Microsoft Account a řada dalších.
* Správně implementovanou změnu e-mailové adresy s ověřením.
* Správně implementovaný reset hesla.
* Použití rolí pro autorizaci v rámci aplikace.

**Zdrojové kódy najdete na [https://github.com/ridercz/ShirtShop](https://github.com/ridercz/ShirtShop).**

> Tyto ukázkové aplikace jsou volně dostupné pro každého a můžete se z nich inspirovat a učit svépomocí. Používám je i na svých školeních .NET Core, která dělám pro [Gopas](https://www.gopas.cz/) a [DotNetCollege](https://www.dotnetcollege.cz/) (případně se se mnou můžete domluvit osobně). Na těchto školeních se vám dostane podrobných instrukcí co se v nich děje a proč.