<!-- dcterms:identifier = aspnetcz#325 -->
<!-- dcterms:title = Altairis Mail Toolkit: Nyní i s podporou mailing listů (a stále zdarma) -->
<!-- dcterms:abstract = Zhruba před rokem jsem představil svůj projekt Altairis Mail Toolkit, který slouží k jednoduchému a korektnímu mailování z ASP.NET. Po roce se tato knihovna dočkala nové verze 1.5, v níž řeší další častý problém, a tím je správa distribučních seznamů – mailing listů. -->
<!-- np9:categoryId = 7 -->
<!-- x4w:category = Software -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2011-06-13T17:06:15.14+02:00 -->
<!-- dcterms:dateSubmitted = 2011-06-13T17:06:54.173+02:00 -->
<!-- dcterms:date = 2011-06-13T00:00:00+02:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 130 -->
<!-- x4w:pictureUrl = /perex-pictures/20100608-altairis-mail-toolkit-mailovani-z-webovych-aplikaci-snadno-a-korektne.png -->

Zhruba před rokem jsem v článku [Altairis Mail Toolkit: mailování z webových aplikací snadno a korektně](http://www.aspnet.cz/articles/286-altairis-mail-toolkit-mailovani-z-webovych-aplikaci-snadno-a-korektne) představil svůj projekt [Altairis Mail Toolkit](http://altairismailtoolkit.codeplex.com/), který slouží k jednoduchému a korektnímu mailování z ASP.NET. Po roce se tato knihovna dočkala nové verze 1.5, v níž řeší další častý problém, a tím je správa distribučních seznamů – mailing listů.

Pokud jsou správně realizované, představují mailing listy (distribuční seznamy) velice efektivní způsob komunikace se zákazníky. E-mailový občasník může být velmi užitečná záležitost. Problém ale spočívá v tom, jak celou věc realizovat správně.

## Řešené problémy

### Bezpečné přihlášení a odhlášení

V první řadě je třeba řešit přihlašování a odhlašování uživatelů. Jakékoliv změny (tedy přidání e-mailu do seznamu nebo jeho odebrání) by měl potvrdit oprávněný uživatel této adresy. Za prvé si tím při přihlášení ověříme, že je zadaná adresa funkční a za druhé máme jistotu, že zprávy rozesíláme se souhlasem oprávněné osoby a tedy v souladu se zákonem.

Typicky se potvrzení děje tak, že uživateli na zadanou adresu pošleme nějaký kód, který musí sdělit zpět, zadat do formuláře na webu a nebo přejít na adresu, které je kód součástí. Má implementace využívá metodu [HMAC](http://www.aspnet.cz/articles/146-hmac-hash-message-authentication-code), kdy se kód generuje kryptografickým algoritmem s použitím tajného klíče, a tedy není nutné nepotvrzené údaje a kódy skladovat v databázi.

### Provider-based úložiště seznamu adres

Seznam přihlášených e-mailových adres je nutno někde skladovat. Pro tento úkol jsem zvolil svou oblíbenou architekturu providerů. Součástí knihovny je toho času jediný provider, který ukládá data do databáze (jakékoliv ADO.NET: MS SQL, SQL Compact, MySQL, Oracle…), ale můžete si snadno napsat vlastního providera. Stačí podědit třídu od *Altairis.MailToolkit.MailingListProvider* a přepsat pár metod.

Zároveň toto řešení umožňuje v rámci jedné aplikace provozovat několik mailing listů, se stejnými nebo různými providery – co instance providera, to samostatný mailing list.

### Rozeslání e-mailu

Vlastní rozeslání zpráv je už triviální, resp. je vyřešeno už v předchozí verzi knihovny. Dopsal jsem tedy jenom metodu, která propojí již existující infrastrukturu se seznamem příjemců.

## Implementace

Postup implementace je poměrně podrobně popsán v [dokumentaci](http://altairismailtoolkit.codeplex.com/wikipage?title=Mailing%20List%20Management) (anglicky). Zároveň je k dispozici příklad *SampleListManager* (je součástí downloadu), který představuje vzor, z něhož lze vycházet.

Knihovna sama nemá žádné uživatelské rozhraní, se světem komunikuje převážně pomocí třídy *MailingListManager*, která disponuje sbírkou statických metod pro odeslání mailu se žádostí o potvrzení přihlášení a odhlášení (*Subscribe*, *Remove*), ověření těchto akcí (*SubscribeConfirm*, *RemoveConfirm*) a rozeslání zpráv (*SendMessages*).

Texty zpráv a formát potvrzovacího URL je možné snadno změnit v resource souborech (jsou to šablony mailů jako každé jiné), je nutné napsat jenom stránku pro přihlašování a potvrzování – ty jsou velmi jednoduché, v podstatě jde jenom o načtení parametrů a zavolání příslušné metody.

**Aktuální verzi knihovny Altairis Mail Toolkit si můžete stáhnout na **[**http://altairismailtoolkit.codeplex.com/**](http://altairismailtoolkit.codeplex.com/)**.** Je zdarma, šířená pod Ms-PL, tedy otevřená dalším úpravám.