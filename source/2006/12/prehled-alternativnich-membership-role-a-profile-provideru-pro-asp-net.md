<!-- dcterms:identifier = aspnetcz#130 -->
<!-- dcterms:title = Přehled alternativních Membership, Role a Profile providerů pro ASP.NET -->
<!-- dcterms:abstract = Upozornění na novou verzi "Altairis Simple ASP.NET SQL Providers" a stručný přehled dalších alternativ k vestavěným providerům. -->
<!-- np9:categoryId = 7 -->
<!-- x4w:category = Software -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2006-12-19T02:52:22.573+01:00 -->
<!-- dcterms:dateAccepted = 2006-12-19T02:52:22.573+01:00 -->

Za jeden z nejlepších nápadů v ASP.NET 2.0 považuji provider model, zejména pak Membership, Profile a Role providery. Vestavěná sbírka providerů ovšem není moc použitelná pro složitější aplikace. Nabízím vám tedy přehled alternativ.

## Altairis Simple ASP.NET SQL Providers

Začnu samozřejmě svým vlastním dílkem, sbírkou Membership, Role a Profile providerů, jejichž cílem je poskytnout "minimální implementaci" založenou na jednoduché databázové struktuře. Jejich popis jsem zde již [zveřejnil před časem](https://www.aspnet.cz/Articles/115-altairis-simple-asp-net-sql-providers-ke-stazeni.aspx).

Nyní se tento produkt dočkal první "production" verze, kterou si můžete stáhnout na [CodePlexu](http://www.codeplex.com/AltairisWebProviders). Připomínky a chyby hlaste prosím tamtéž. Děkuji za spolupráci též Martinu Štěpánovi, který odhalil a promptně opravil několik chyb.

## XML

Pokud je na vás i jednoduchá DB struktura příliš, a rádi byste se obešli úplně bez databáze, mohla by vás zajímat sada providerů, kteři svá data ukládají do XML souborů. Najdete je v rámci projektu [My Web Pages Starter Kit](http://www.codeplex.com/MyWebPagesStarterKit).

Tento projekt je mimo jiné zajímavý sám o sobě. Mimochodem, vytvořil jsem jeho českou lokalizaci (včetně překladu dokumentace), měla by být v dohledné době dostupná na shora uvedeném webu.

## Microsoft Access (MDB)

K dispozici je i [implementace nad databází Microsoft Access](http://download.microsoft.com/download/5/5/b/55bc291f-4316-4fd7-9269-dbf9edbaada8/sampleaccessproviders.vsi) (potažmo MDB soubory). Osobně ale vřele nedoporučuji Access používat pro web, není na to stavěný a obvykle to dopadá špatně.

## MySQL

Pokud používáte MySQL, může vás zajímat implementace membershipu a rolí pro tento server. Najdete ji pro změnu na [CodeProjectu](http://www.codeproject.com/aspnet/MySQLMembershipProvider.asp). Víc o ní nevím, MySQL nepoužívám.

## ODBC

V MSDN najdete příklad implementace [Membership](http://msdn2.microsoft.com/en-us/library/6tc47t75.aspx), [Role](http://msdn2.microsoft.com/en-us/library/317sza4k.aspx) a [Profile](http://msdn2.microsoft.com/en-us/library/ta63b872.aspx) providerů proti jakémukoliv datovému zdroji, který je dostupný přes ODBC.

## Zdrojové kódy vestavěných providerů a dokumentace k nim

Pokud vás zajímá, jak providery obecně fungují a chcete se podívat na jejich zdrojové kódy, máte možnost. Obsáhlá dokumentace a zdrojáky jsou nyní [ke stažení na MSDN jako Provider Toolkit](http://msdn2.microsoft.com/en-us/asp.net/aa336558.aspx).