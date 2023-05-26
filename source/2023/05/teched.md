<!-- dcterms:title = Prezentace a příklady z TechEdu 2023 -->
<!-- dcterms:abstract = V tomto týdnu se konal TechEd 2023 a já na něm měl sedm přednášek. Nabízím vám ke stažení prezentace, příklady a odkazy. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:coverUrl = /cover-pictures/20230525-teched.jpg -->
<!-- x4w:pictureUrl = /perex-pictures/20230525-teched.png -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = IT -->
<!-- x4w:category = Akce a události -->
<!-- dcterms:date = 2023-05-26 -->

## Keynote: .NET pro (zejména) webové vývojáře v roce 2023

Tradiční úvodní přednáška shrnující novinky v aktuální verzi C#, .NETu a Visual Studia pro (zejména) webové vývojáře.

* **[Prezentace](https://www.cdn.altairis.cz/Blog/2023/20230526-01_Keynote.pdf)**
* **[Příklady](https://www.cdn.altairis.cz/Blog/2023/20230526-Demo_01_Keynote.zip)**
* [Z-TECH video: Dev Tunnels ve Visual Studiu 2022](https://www.youtube.com/watch?v=UPNaCg3sFZQ)
* [Z-TECH video: Dev Tunnels ve Visual Studiu 2022 - vylepšení v update 17.5](https://www.youtube.com/watch?v=vTVCfrT6Sf8)
* [Z-TECH video: Rate limiting middleware v ASP.NET Core](https://www.youtube.com/watch?v=yZzyPR4rd0Q)

## Cacheování v .NETu a HTTP

Správně použité cacheování je jedním z důležitých nástrojů jak zvýšit výkon webové aplikace. Správně použít cacheování je ale těžké, a nesprávné použití udělá víc škody než užitku. Ukážu vám tři způsoby cacheování v ASP.NET Core: Response Cache, Output Cache a Object Cache. Ukážu vám i jak zařídit závislost na externích zdrojích (typicky na souborech) anebo jak zařídit cacheování na webové farmě.

* **[Prezentace](https://www.cdn.altairis.cz/Blog/2023/20230526-02_Cacheovani.pdf)**
* **[Příklady](https://www.cdn.altairis.cz/Blog/2023/20230526-Demo_02_Caching.zip)**
* [Z-TECH seriál: Cacheování v ASP.NET](https://www.youtube.com/playlist?list=PLFZurxJN0pMbTTXyhI7SQIEEr04YlylPG)

## Syntakticky úžasné CSS

Kaskádové styly jsou fajn, pokud jich máte málo. Ale co když jsou pro složitější weby pravidel stovky nebo tisíce? Pak pomůže preprocesor SASS/SCSS. Ten do jazyka CSS přináší věci, které v něm chybí: přehlednější zápis pravidel, vizuální dědičnost, proměnné, funkce matematické i jiné a řadu dalších. Představím vám jak jazyk SASS/SCSS samotný, tak nástroje. Jak s ním pracovat ve Visual Studiu, VS Code a dalších vývojových prostředích.

* **[Prezentace](https://www.cdn.altairis.cz/Blog/2023/20230526-03_SCSS.pdf)**
* **[Příklady](https://www.cdn.altairis.cz/Blog/2023/20230526-Demo_03_SCSS.zip)**
* [Z-TECH seriál: SCSS/SASS](https://www.youtube.com/playlist?list=PLFZurxJN0pMZE53l5QYowXnNb8xcXBwcb&pp=iAQB)

## Health checks pro mírně pokročilé

ASP.NET Core Health Checks jsou způsob, jakým může aplikace otestovat sama sebe a externímu monitoringu ukázat, že se těší dobrému zdraví. Ukážu vám také, jak Health Checks používat za hranicemi obvyklého Hello World: jak sledovat služby běžící na pozadí v rámci aplikace, ale i jak využít veřejné sledovací nástroje pro sledování stavu služeb, které jsou schované ve vnitřní síti a nelze se na ně dostat zvenčí.

* **[Prezentace](https://www.cdn.altairis.cz/Blog/2023/20230526-04_HealthChecks.pdf)**
* **[Příklady](https://www.cdn.altairis.cz/Blog/2023/20230526-Demo_04_HealthChecks.zip)**
* [Z-TECH seriál: Health checks in ASP.NET Core](https://www.youtube.com/playlist?list=PLFZurxJN0pMbFy_R9q7MQwPAwA_bwIZyG)

## MQTT nejen pro IoT

O komunikačním protokolu MQTT se hodně mluví v souvislosti s IoT zařízeními. Je pravda, že je pro ně extrémně vhodný. Ale zdaleka to není jeho jediné využití. MQTT je výtečnou volbou i pro "velké" aplikace, které potřebují elegantní, jednoduchý a zároveň robustní systém pro předávání zpráv v pub/sub architektuře. Ukážu vám, jakým způsobem lze využívat MQTT z prostředí .NET, ale třeba i z jednoduchých mikrokontrolerů za desetikoruny. A třeba jak tyto dvě věci jednoduše propojit.

* **[Prezentace](https://www.cdn.altairis.cz/Blog/2023/20230526-05_MQTT.pdf)**
* **[Příklady](https://www.cdn.altairis.cz/Blog/2023/20230526-Demo_05_MQTT.zip)**

## Autentizace ASP.NET Web API pomocí API klíčů

V souvislosti s autentizací REST API se často mluví o OData, JWT a podobně. Ale pro mnoho (zejména M2M) API jsou pořád nejlepší variantou staré dobré API klíče. Ukážu vám postup, jakým to celé naimplementovat správně, rozšiřitelně a kompatibilně jak s obecnými standardy, tak s ASP.NET Core infrastrukturou.

* **[Prezentace](https://www.cdn.altairis.cz/Blog/2023/20230526-06_ApiKeyAuth.pdf)**
* **[Příklady](https://www.cdn.altairis.cz/Blog/2023/20230526-Demo_06_ApiKeyAuth.zip)**
* [Projekt Incitatus - GitHub](https://github.com/ridercz/Incitatus)
* [Z-TECH seriál: Napište si vlastní Google](https://www.youtube.com/playlist?list=PLFZurxJN0pMaEzNvfyDMB5eiECURGh5D5)


## Sqlite - neviditelná databáze i pro web

Na svém počítači ji nejspíš máte v desítkách kopií a ani o tom nevíte. Řeč je o embedded databázi Sqlite, kterou používá velké množství desktopových i mobilních aplikací. V mnoha případech je ale vhodná i pro web. Je malá, elegantní, zdarma a překvapivě výkonná. Ve své přednášce vám ukážu, co Sqlite umí, jak se dá použít na webu v ASP.NET (včetně návodu jak napsat univerzální datovou vrstvu fungující proti Microsoft SQL Serveru i proti Sqlite), jak databáze spravovat a zálohovat.

* **[Prezentace](https://www.cdn.altairis.cz/Blog/2023/20230526-07_Sqlite.pdf)**
* **[Příklady](https://www.cdn.altairis.cz/Blog/2023/20230526-Demo_07_Sqlite.zip)**
* [Z-TECH seriál: SQLite](https://www.youtube.com/playlist?list=PLFZurxJN0pMZl_W9qflSsUzcCSPYb_93P)