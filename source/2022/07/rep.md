<!-- dcterms:title = Aktualizace aplikace ReP: Rezervace prostředků -->
<!-- dcterms:abstract = Před časem jsem vytvořil open source (a částečně demo/ukázkovou) aplikaci ReP. Nyní jsem ji aktualizoval na ASP.NET Core 6.0 a přidal řadu praktických vylepšení a oprav chyb. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20210215-rep.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20210215-rep.jpg -->
<!-- x4w:category = IT -->
<!-- x4w:category = ReP -->
<!-- dcterms:dateAccepted = 2022-07-04 -->

Před časem jsem vytvořil open source (a částečně demo/ukázkovou) aplikaci ReP. Nyní jsem ji aktualizoval na ASP.NET Core 6.0 a přidal řadu praktických vylepšení a oprav chyb.

**Aplikace je licencována pod MIT licencí, je tedy zdarma dostupná každému. Najdete ji na [mém GitHubu](https://github.com/ridercz/ReP).**

## Upgrade na ASP.NET Core 6.0

Celou aplikaci jsem upgradoval na ASP.NET Core 6.0, včetně podpory různých jazykových vylepšení C# 10, jako jsou file-scoped namespaces, global usings a další podobné věci.

## Adresář členů

Členové mají možnost přidat své jméno a telefonní číslo a povolit zveřejnění v adresáři členů. Správci pak mohou přidat do adresáře další záznamy.

## Větší možnosti přizpůsobení

V konfiguraci je možné nastavit nejenom název aplikace, ale také obrázek v hlavičce nebo vlastní stylesheet. Také je možné jednotlivé části aplikace (novinky, otevírací dobu, adresář členů) povypínat.

## Podpora Sqlite

ReP byl původně psán pro Microsoft SQL Server a poněkud alibisticky jsem do dokumentace napsal, že případný přechod na jiný databázový systém je snadný. Nyní jsem tedy přidal podporu pro embedded databázi Sqlite, a to včetně migrací. Postup se nakonec ukázal nebýt úplně přímočarým, ale nesnesitelně složité to také není. Hodlám o tom vbrzku udělat video pro [Z-TECH](https://www.ztech.cz/).

> **Jedná se o breaking change.** Abych dosáhl parity mezi SQL Serverem a Sqlite, smazal jsem všechny migrace a začínám "s čistým štítem" první migrací, která je společná pro všechny ostatní. Je tedy nutné vytvořit novou databázi a přesypat data pomocí nástrojů SQL Server Management Studia.

## Podpora externího konfiguračního souboru

Pokud existuje soubor `ReP.json` v adresáři nadřazeném aplikačnímu, ReP ho načte a použije jako konfigurační soubor s nejvyšší prioritou.

> Tj. např. pokud je ReP nainstalován v `C:\WWW-servers\Rep\rep.domain.cz`, pokusí se načíst soubor `C:\WWW-servers\Rep\ReP.json`.

To umožní umístit veškerá data (včetně konfigurace a např. Sqlite databáze) mimo aplikační adresář, což zjednodušuje deployment.