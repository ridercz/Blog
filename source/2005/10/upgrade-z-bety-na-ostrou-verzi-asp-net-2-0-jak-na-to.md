<!-- dcterms:identifier = aspnetcz#56 -->
<!-- dcterms:title = Upgrade z bety na ostrou verzi ASP.NET 2.0 - jak na to -->
<!-- dcterms:abstract = Pokud jste si - stejně jako já - nadšeně hráli s pre-release verzemi Whidbey, možná uvítáte pár tipů, jak správně přejít na ostrou verzi. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = IT -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2005-10-31T13:25:50.5+01:00 -->
<!-- dcterms:dateAccepted = 2005-10-31T13:25:50.5+01:00 -->

Pokud jste si - stejně jako já - nadšeně hráli s pre-release verzemi Whidbey, možná uvítáte pár tipů, jak správně přejít na ostrou verzi.

## Jak nepokazit odinstalaci

Abyste mohli nainstalovat ostrou verzi, musíte odinstalovat verzi předchozí. Komponent, které musíte odstranit, je celkem třiadvacet a jejich seznam najdete v readme VS.NET (apod.).

Když už někdo čte manuály, nečte je *celé*, takže si patrně nevšimnete odkazu na nástroj, který tuto operaci provede za vás (je až *pod* seznamem produktů). Předmětný nástroj si můžete stáhnout na adrese [http://go.microsoft.com/fwlink/?linkid=47598](http://go.microsoft.com/fwlink/?linkid=47598) a vřele vám to doporučuji.

## Co dělat, když odinstalaci pokazíte

Hlavním důvodem je, že onen nástroj odinstaluje jednotlivé komponenty *ve správném pořadí*. A nedostanete se do situace, která se povedla včera mně, když jsem nemohl odinstalovat SQL 2005 Express. Ze seznamu nainstalovaných programů sice zmizel, ale fyzicky byl stále přítomen a přes msiexec odinstalovat nešel, neb to házelo nějakou podivnou runtime chybu.

Řešením bylo - alespoň v mém případě - nainstalovat znovu tutéž pre-release verzi .NET Frameworku a SQL Expressu (ta se musela nainstalovat jako samostatná instance) a poté použít shora uvedený nástroj.

## Změna struktury ASPNETDB.MDF

Mezi verzemi Beta 2 a Release Candidate (a ostrou) se změnila struktura databáze ASPNETDB.MDF, kam si ASP.NET v jistých konfiguracích ukládá rozličné údaje, zejména pak o uživatelích.

Změnily se zejména parametry uložených procedur. Osobně jsem nikde neměl žádnou databázi, na jejímž obsahu by mi záleželo, takže jsem databázi prostě vytvořil znovu a zadal do ní ty tři uživatele.