<!-- dcterms:title = Pozvánka na odpolední online školení Přístup k datům nejen z ASP.NET Core -->
<!-- dcterms:abstract = Připravil jsem pro vás nové, prakticky zaměřené školení o přístupu k nejrůznějším druhům dat. Bude se konat 27. - 29. 5. 2025, online. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20250427-data.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20250427-data.jpg -->
<!-- x4w:category = Akce a události -->
<!-- x4w:category = IT -->
<!-- dcterms:date = 2025-04-27 -->

Připravil jsem pro vás nové, prakticky zaměřené školení o přístupu k nejrůznějším druhům dat. Hlavní pozornost bude věnována datům relačním a Entity Frameworku Core, protože to je pořád majoritní druh dat, s nímž v .NETu pracujeme, ale bude řeč i o datech, která do databáze obvykle neukládáme. Kurz bude zaměřen velice prakticky, se spoustou cvičení (labů) na témata, se kterými se .NET vývojáři typicky setkávají. Toto školení vzniklo v podstatě na základě dotazů z mých ostatních kurzů. Školení bude používat aktuální verzi ASP.NET Core, ale používané techniky nejsou vhodné jenom pro web a ASP.NET, ale pro všechny aplikace v .NETu.

## Kdy a kde se bude školení konat

Školení se bude konat **online** pomocí systému [Altairis eLearning](https://elearning.altairis.cz), s přenosem videa lektora k účastníkům a chatem pro dotazy (s možností individuální pomoci a konzultací). Účastníkům bude k dispozici záznam a výukové materiály i po skončení školení.

Termín je **27. - 29. května 2025** vždy od 12:00 do 17:00. Tento termín umožňuje, aby účastník nebyl blokován celý pracovní den (resp. tři pracovní dny). Pokud byste se školení rádi zúčastnili, ale nevyhovuje vám termín, vyplňte [objednací formulář](https://forms.office.com/r/bvnEsCWBd3) a napište to do poznámky - pokusím se vám vyjít vstříc. Stejně tak, pokud byste měli zájem o prezenční školení nebo privátní jenom pro vaši firmu.

## Kolik školení stojí

Cena školení je **9 000 Kč** za jednoho účastníka + DPH. V případě tří a více účastníků z jedné firmy (na jedné objednávce) je sleva 10 %.

* **[Objednávkový formulář](https://forms.office.com/r/bvnEsCWBd3)**

## Plánovaná osnova školení

* .NET a relační databáze
    * Entity Framework Core - tvorba modelu
        * Code First
        * Database First
        * Code second - převzetí existujícího modelu do EF
        * Migrace
        * Migrace z příkazové řádky a Visual Studia
        * Migrace při spuštění aplikace, generování migrační SQL dávky
        * Úpravy migrací, transformace dat
        * Seeding dat, naplnění číselníků
        * EF Core jako databázová abstrakce
    * Představení embedded databáze Sqlite, kdy ji použít a kdy ne
        * Databázová nezávislost - aplikace fungující proti MS SQL i Sqlite
        * Zálohování Sqlite databázových souborů
    * Pokročilejší využití EF Core
        * Mapování na JSON struktury
        * Mapování na uložené procedury
        * Obecné využití uložených procedur z EF
    * Fulltextové vyhledávání v Microsoft SQL Serveru
        * Obecné fungování fulltextových indexů v MS SQL
        * Dotazovací jazyk pro fulltext
        * Překladač z Google-like syntaxe
        * Napojení na Entity Framework
* .NET a nerelační data
    * Ukládání binárních dat
        * Ukládání binárních dat do databáze
        * Ukládání binárních dat do file systému
        * Ukládání binárních dat do Azure Blob Storage
        * Využití SAS (Shared Access Signatures)
        * FluentStorage - abstrakce pro ukládání binárních dat a proč ji používat
    * Ukládání semistrukturovaných dat - Azure Table Storage
    * Práce s frontami - Azure Queue Storage

## Požadavky na účastníky

Po technické stránce se předpokládá, že účastníci budou mít k dispozici:

* Počítač s připojením k Internetu umožňujícím přehrávání video streamu
* Windows 10 a novější, Visual Studio 2022 libovolné edice (včetně bezplatné Community Edition), Microsoft SQL Server (včetně bezplatné edice Express). Lze používat i jinou platformu (Linux, Mac OS) a vývojové prostředí (VS Code, JetBrains Rider...), ale návody počítají s Windows a VS 2022.
* Libovolné předplatné Microsoft Azure (včetně aktivního trialu). Není absolutně nezbytné, ale část o nerelačních datech Azure hojně využívá.

Po stránce dovedností a vědomostí se očekává, že účastníci budou mít základní obecné povědnomí o programování v C#/.NET a ASP.NET Core, základní znalosti relačních databází (co je tabulka, primární klíč...) a základní povědomí o jazyku SQL.

## Objednávky a dotazy

Školení si můžete [objednat pomocí formuláře](https://forms.office.com/r/bvnEsCWBd3). V případě dotazů napište poznámku do formuláře nebo [mne kontaktujte jakkoliv jinak](https://www.rider.cz/#contact).