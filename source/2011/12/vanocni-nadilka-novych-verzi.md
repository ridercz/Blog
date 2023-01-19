<!-- dcterms:identifier = aspnetcz#358 -->
<!-- dcterms:title = Vánoční nadílka nových verzí -->
<!-- dcterms:abstract = Abyste se mezi svátky nenudili, vydal jsem novou verzi své knihovny Altairis Mail Toolkit a aktualizované zdrojové kódy portálu GeekCore. -->
<!-- np9:categoryId = 7 -->
<!-- x4w:category = Software -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2011-12-24T21:32:45.133+01:00 -->
<!-- dcterms:date = 2011-12-24T21:32:46+01:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 130 -->
<!-- x4w:pictureUrl = /perex-pictures/20100608-altairis-mail-toolkit-mailovani-z-webovych-aplikaci-snadno-a-korektne.png -->

Abyste se mezi svátky nenudili, vydal jsem novou verzi své knihovny **Altairis Mail Toolkit** a aktualizované zdrojové kódy portálu **GeekCore**.

## Altairis Mail Toolkit

Tato knihovna slouží k rozesílání mailů a už jsem zde psal o jejích předchozích verzích:

*   [Altairis Mail Toolkit: mailování z webových aplikací snadno a korektně](http://www.aspnet.cz/articles/286-altairis-mail-toolkit-mailovani-z-webovych-aplikaci-snadno-a-korektne)
*   [Altairis Mail Toolkit: Nyní i s podporou mailing listů (a stále zdarma)](http://www.aspnet.cz/articles/325-altairis-mail-toolkit-nyni-i-s-podporou-mailing-listu-a-stale-zdarma)

Nová verze 1.6 přináší vylepšený *SqlMailingListProvider*. V předchozí verzi byly názvy sloupců v tabulkách zadané natvrdo, nová verze je má konfigurovatelné. Dále pak podporuje ukládání času přihlášení a IP adresy, z níš bylo potvrzeno, což se vám může hodit v případě sporu či [kontroly z Úřadu pro ochranu osobních údajů](http://www.lupa.cz/clanky/spam-a-urad-pro-ochranu-osobnich-udaju/).

Ke stažení je na [altairismailtoolkit.codeplex.com](http://altairismailtoolkit.codeplex.com/) nebo jako NuGet package *Altairis.MailToolkit*.

## Nová verze zdrojáků GeekCore

Kalendář akcí [GeekCore](http://www.geekcore.cz/) je open source a aktualizoval jsem publikované zdrojové kódy, které odpovídají aktuální verzi nasazené v produkci. Změny proti předchozí verzi zahrnují zejména:

*   Nový systém automatického verzování CSS souborů (bude o něm podrobněji řeč v samostatném článku).
*   Podporu pro akce, na které se platí vstupné (spolu s rozšířeními bezpečnostního modelu).
*   Aktuální verze použitých komponent.
*   Opravy drobných chyb předchozí verze.

Zdrojovké kódy najdete na [geekcore.codeplex.com](http://geekcore.codeplex.com/).