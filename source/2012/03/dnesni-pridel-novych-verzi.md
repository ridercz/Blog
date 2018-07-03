<!-- dcterms:identifier = aspnetcz#376 -->
<!-- dcterms:title = Dnešní příděl nových verzí -->
<!-- dcterms:abstract = Altairis Mail Toolkit, Altairis Web UI Toolkit a ASP.NET Chaos Generator mají nové verze. -->
<!-- np9:categoryId = 7 -->
<!-- x4w:category = Software -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2012-03-23T23:00:46.677+01:00 -->
<!-- dcterms:dateAccepted = 2012-03-23T23:00:49+01:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20120323-dnesni-pridel-novych-verzi.png -->

Dnes jsem publikoval nové verze několika svých programů a knihoven:

## Altairis Web UI Toolkit verze 2.1.8

*   Prvky *IconLinkButton* a *IconHyperLink* obsahují kromě sady Silk i Silk Companion 1 a Silk Companion 2.
*   Všechny PNG obrázky byly optimalizovány a jsou nyní ještě o kousek menší 

Zdrojové kódy najdete na [CodePlexu](http://altairiswebui.codeplex.com/), knihovnu můžete instalovat nebo aktualizovat též jako [NuGet balíček](http://www.nuget.org/packages/Altairis.Web.UI) *Altairis.Web.UI*.

## Altairis Mail Toolkit verze 1.7

Změny ve správě mailing listů:

*   *SqlMailingListProvider* nyní podporuje i SQL Server Compact
*   Přidány metody *SubscribeForce* a *RemoveForce*, které umožňují přidat a odstranit uživatele z mailing listu, aniž by bylo nutné to potvrzovat e-mailem.
*   Metodám *Subscribe*, *Remove* a *SendMessages* přibyl poslední volitelný parametr *additionalArguments*, který bude předán formátovacímu řetězci šablony jako placeholdery s čísly *{4}* atd.
*   Kromě ukázkových aplikací byl přidán kompletní webový mailing list manager, který umožňuje webové přihlašování, odhlašování, rozesílání zpráv a import adres. K vidění živě na [http://mailing.altairis.cz/](http://mailing.altairis.cz/).  

Zdrojové kódy najdete na [CodePlexu](http://altairismailtoolkit.codeplex.com/), knihovnu můžete instalovat nebo aktualizovat též jako [NuGet balíček](http://www.nuget.org/packages/Altairis.MailToolkit) *Altairis.MailToolkit*.

## ASP.NET Chaos Generátor

Do generátoru chaosu (pro klíče, hesla a podobně) jsem přidal funkci výpočtu hashů ze stringů v různých znakových sadách. Podporuje algoritmy MD-5, SHA-1, SHA-256, SHA-384, SHA-512 a RIPEMD-160. Výsledek může být kódován celou řadou různých způsobů.

Online verzi služby najdete na [http://chaos.aspnet.cz](http://chaos.aspnet.cz), ke stažení jsou i [zdrojové kódy](http://chaos.aspnet.cz/ChaosGenSource.zip).