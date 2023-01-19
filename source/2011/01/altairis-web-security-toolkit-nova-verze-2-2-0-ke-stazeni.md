<!-- dcterms:identifier = aspnetcz#314 -->
<!-- dcterms:title = Altairis Web Security Toolkit – nová verze 2.2.0 ke stažení -->
<!-- dcterms:abstract = Vydal jsem novou verzi své knihovny Altairis Web Security Toolkit (dříve Simple ASP.NET SQL Providers), kterí se stala vcelku populární. Přináší oproti minulé verzi řadu vylepšení a nově také nezávislost na databází a ověřenou kompatibilitu s novým SQL Serverem Compact Edition. -->
<!-- np9:categoryId = 2 -->
<!-- x4w:category = Bezpečnost -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2011-01-24T01:15:18.867+01:00 -->
<!-- dcterms:dateSubmitted = 2011-01-24T01:15:55.723+01:00 -->
<!-- dcterms:date = 2011-01-24T00:00:00+01:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20110124-altairis-web-security-toolkit-nova-verze-2-2-0-ke-stazeni.png -->

Vydal jsem novou verzi své knihovny Altairis Web Security Toolkit (dříve Simple ASP.NET SQL Providers), kterí se stala vcelku populární. Přináší oproti minulé verzi řadu vylepšení a nově také nezávislost na databází a ověřenou kompatibilitu s novým SQL Serverem Compact Edition.

## Trocha historie

Verze ASP.NET 2.0 přinesla novinku v podobě membership, role a profile providerů. Bohužel, implementace providerů v .NET Frameworku je dost nešťastná: v zájmu maximální univerzálnosti použití jsou v podstatě nezkombinovatelné s čímkoliv jiným. Jejich tabulková struktura je dost nestandardní, nepřehledná a prakticky nepropojitelná se zbytkem databázové struktury, kterou aplikace může mít.

Proto jsem se rozhodl napsat si vlastní providery, využívající mnohem jednodušší strukturu tabulek. Protože základem byla jednoduchost, nazval jsem je Simple SQL Providers. Toto moje řešení se docela zalíbilo a stalo se dosti populárním. Postupně jsem do této knihovny přidal ještě nějaké další věci, třeba modul pro basic autentizaci v IIS a jednoduchého providera pro ukládání dat do textových souborů.

## Nová generace

Nyní jsem uvolnil masivně přepracovanou druhou verzi. Třídy *Simple*Provider* jsou sice nadále přítomny, ale novou generaci představují třídy Table*Provider. Základní změny jsou následující:

*   **Naprostá databázová nezávislost:** Původní verze podporovala jenom Microsoft SQL Server a ačkoliv bylo jednoduché ji upravit i pro jiné databáze, out-of-the-box to nešlo. Současná verze používá generické databázové třídy a měla by tedy fungovat s jakoukoliv databází, která rozumí jednoduchým SQL dotazům a má ADO.NET providera. Testoval jsem to proti SQL Servereu a SQL Compactu, budu vděčný, pokud otestujete i jiné databáze a případně dodáte přesný postup.
*   **Podpora SQL Serveru Compact Edition:** Microsoft před několika dny uvedl novou verzi svého embedded databázového nástroje. SQL CE 4.0 je – na rozdíl od předchozích verzí – přímo určena pro použití v rámci webových aplikací a hodí se pro nasazení v menším rozsahu. Nová verze mých providerů se SQL CE úspěšně funguje a je na to i příklad.
*   **Standardní výpočet hashe:** Původní verze stejně jako vestavěné providery pro výpočet HMAC používala stringové řetězení hesla se solí. Nová verze používá standardní třídu HMACSHA512. To má na jedné straně za následek nemožnost přímého upgradu z nižších verzí, na druhou stranu bude snadnější případný přechod na jiné providery nebo jiný hashovací algoritmus atd.
*   **Zefektivnění ukládání dat:** Původní verze ukládala hash hesla jako řetězec kódovaný pomocí Base64 (opět, v inspiraci vestavěným providerem). Aktuální verze ukládá hashe (a sůl) přímo v binárním tvaru.
*   **Možnost konfigurovat názvy tabulek:** Původní verze vyžadovala tabulky s pevnými jmény. Nová umožňuje tabulky *Users*, *Roles* a *RoleMemberships* pojmenovat libovolně.
*   Korektnější podpora zakazování a povolování uživatelů (původní implementace nesystémově míchala "enabled" a "locked out").
*   Podpora metody *GetNumberOfUsersOnline*, o jejíž smysluplnosti si ovšem stále myslím své.
*   Kompletní a úplná podpora impersonace v některých hostingových scénářích.

Zůstává zachována původní jednoduchost a také hojně využívaná možnost do tabulek přidávat libovolné vlastní sloupečky, pokud jsou nullable a nebo mají defaultní hodnotu, což zapojení do vlastní tabulkové struktury dále zjednodušuje.

Kromě "tabulkových" providerů obsahuje knihovna ještě *PlainTextMembershipProvider*, což je extrémně jednoduchý membership provider, ukládajicí svoje údaje do obyčejného textového souboru. Užitečný pro prozkoumání, jakže ten membershipping vlastně funguje a low-security scénáře.

Další třídou je **BasicAuthenticationModule**, což je autentizační modul pro IIS, který implementuje běžnou HTTP Basic autentizaci, ovšem ve spolupráci s membership infrastrukturou (a tedy libovolným membership providerem, včetně těch výše uvedených). Podrobnější informace je možné nalézt v článku [Modul pro 'basic' autentizaci v ASP.NET](http://www.aspnet.cz/articles/84-modul-pro-basic-autentizaci-v-asp-net).

## Dostupnost a instalace

**Altairis Web Security Toolkit** si můžete stáhnout z CodePlexu. Na adrese [http://altairiswebsecurity.codeplex.com/](http://altairiswebsecurity.codeplex.com/) si můžete stáhnout knihovnu, příklady, zdrojové kódy a je tam k dispozici i dokumentace. Pokud používáte NuGet (kterému se hodlám podrobněji věnovat v budoucnu), je komponenta i součástí [NuGet Gallery](http://www.nuget.org/), její ID je *Altairis.Web.Security*.

Knihovna je licencována pod Microsoft Public License (Ms-PL), což umožňuje její použítí ve všech druzích aplikací (včetně komerčních) a též modifikaci.