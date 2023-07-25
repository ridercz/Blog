<!-- dcterms:title = Cacheování v .NET i HTTP -->
<!-- dcterms:abstract = Dneškem končí dvanáctým dílem rozsáhlý seriál o cacheování v ASP.NET webových aplikací a soudím, že se asi jedná o nejrozsáhlejší informační zdroj na toto téma v češtině. Co všechno potřebujete vědět o cacheování? -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:coverUrl = /cover-pictures/20230725-cache.jpg -->
<!-- x4w:pictureUrl = /perex-pictures/20230725-cache.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = IT -->
<!-- dcterms:date = 2023-07-25 -->

Dneškem končí dvanáctým dílem rozsáhlý seriál o cacheování v ASP.NET webových aplikací a soudím, že se asi jedná o nejrozsáhlejší informační zdroj na toto téma v češtině. Co všechno potřebujete vědět o cacheování?

Kompletní seriál najdete na YouTube kanálu Z-TECH, který pro české programátory produkuje Zásilkovna, v **playlistu [ASP.NET Cache](https://www.youtube.com/playlist?list=PLFZurxJN0pMbTTXyhI7SQIEEr04YlylPG)**.

Cacheování je obecně ukládání do mezipaměti. Pokud aplikace získá nějaký výsledek (náročným výpočtem, databázovým dotazem) a očekává, že ho bude potřebovat v budoucnu znovu, může si ho uložit do dočasné paměti (cache) a příště ho nevytvářet znovu, ale vzít z tohoto úložiště.

## Elementy `cache` a `distributed-cache`

Tyto elementy jsou asi nejsnazší forma cacheování v ASP.NET. Umožňují uložit pro pozdější použití část vygenerovaného HTML v Razoru - tedy např. MVC View nebo Razor Page.

* **[Správné použití cache tag helperu: Nezapomeňte na backend](https://www.youtube.com/watch?v=vUpYcyUZwsc)** - ukážu vám, jak použít element `cache`, ale hlavně jak pomocí `Lazy<T>` zařídit, aby vám ta cache k něčemu byla.
* **[Atributy cache tag helperu: expirace a variace cache](https://www.youtube.com/watch?v=2RzuCACYkt8)** - pomocí různých atributů můžete uchovávat několik verzí (variací) cacheované položky, v závislosti na různých parametrech.
* **[Distribuovaná cache v ASP.NET](https://www.youtube.com/watch?v=fXwargs2oa4)** - element `cache` ukládá data v paměti worker procesu aplikace. Což se nehodí zejména na webových farmách, kde chceme aby cache byla sdílená mezi jednotlivými nody. Naštěstí je tu element `distributed-cache`, který tento problém řeší a umožňuje jednoduše využít různé varianty pokročilejších cache. A dobrá zpráva je, že ho můžete - ve jménu budoucí rozšiřitelnosti - používat i tehdy, pokud zatím žádnou pokročilejší cache nemáte.

## Objektová cache

Někdy nechcete cacheovat vygenerované HTML fragmenty, ale přímo objekty, objektové struktury, např. výsledky volání externího API nebo třeba databáze.

* **[Objektová in-memory cache](https://www.youtube.com/watch?v=Y5sDOSWTbGY)** - od toho je tu objektová cache, která vám umožní cacheovat v paměti jakékoliv CLR objekty.
* **[Distribuovaná objektová cache v ASP.NET](https://www.youtube.com/watch?v=-k9Rbpwh3ak)** - i objektová cache má svou distribuovanou variantu. Sice má - logicky - řadu omezení na to, co můžete cacheovat, ale i tak dokáže být velice užitečná.
* **[File dependency v ASP.NET Core Memory Cache](https://www.youtube.com/watch?v=u9BbMPM8xIA)** - tohle je způsob, jak vyhodit položku z cache v případě, že se stane něco, co ji zneplatní. Pomocí change monitorů můžete cacheované položky učinit závislými třeba na souborech nebo dokonce na sobě navzájem.

## HTTP a output cache

Cacheovat můžete nejenom HTML fragmenty, ale i celou odpověď na HTTP požadavek. A to buďto na straně serveru (kde si to můžete vynutit) nebo na straně klienta či mezilehlé proxy.

* **[Output cache v ASP.NET Core](https://www.youtube.com/watch?v=vzdE0DQnV5M)** - novinka v ASP.NET Core 7.0. Tento middleware umožňuje pro další použití nacacheovat na straně serveru celou HTTP response. Ukážu vám, jak ji použít v Minimal APIs, MVC i v Razor Pages.
* **[Podmíněné požadavky a HTTP hlavičky Last-Modified a If-Modified-Since](https://www.youtube.com/watch?v=LX-2lYxrs0w)** - HTTP umožňuje klientovi, aby se serveru zeptal na nějakou stránku a zároveň mu řekl, jakou poslední verzi má v cache. Server pak má možnost jednoduše odpovědět _Not Modified_ a neposlat nic (což šetří zdroje) anebo poslat novější verzi. Dokonce může poslat jenom rozdíly proti té poslední na klientovi.
* **[Podmíněné HTTP requesty v JavaScriptu](https://www.youtube.com/watch?v=MaLxlO2WXaY)** - podmíněné requesty lze dělat z browseru z JavaScriptu velice snadno. Možná  až moc snadno, protože takové Fetch API před vámi cacheování dovedně skrývá. Ukážu vám, jak si to celé ochočit.
* **[Podmíněné HTTP requesty v C#/.NET](https://www.youtube.com/watch?v=ZFVzMgbuVTQ)** - C# a .NET jsou na tom s podmíněnými požadavky přesně opačně než JavaScript: pokud je chcete podporovat, musíte tomu výrazně napomoci. Nicméně ani to není složité.
* **[HTTP cacheování - hlavička Cache-Control](https://www.youtube.com/watch?v=N6S7EsChv0I)** - Téma cacheování na klientovi jsme už nakousli těmi podmíněnými požadavky. Ale obecně cacheování na klientovi nebo mezilehlé proxy řídí HTTP hlavička `Cache-Control`. Vysvětlím vám, jaké má možnosti a omezení.
* **[Response Caching Middleware v ASP.NET Core](https://www.youtube.com/watch?v=Mnul6iTJ2aQ)** - Hlavičku `Cache-Control` nemusíte z ASP.NET Core nastavovat ručně. Je tu Response Caching Middleware, který zařídí dvě věci současně: zajistí cacheování na straně serveru a zároveň klientovi pošle odpovídající HTTP hlavičky.

## Co dál?

Téma cacheování tím zdaleka není vyčerpáno. Napadají mne témata jako podrobnější vysvětlení hlavičky `Vary` anebo třeba specifické určení různých verzí pomocí hlavičky `ETag`. Ale myslím si, že to už jsou možnápříliš specifické scénáře, než aby zajímaly běžné webové programátory. 

Nicméně máte šanci: pokud by vás ohledně cacheování něco zajímalo, napište mi to do komentářů k videu na YouTube a možná o tom vytvořím další díl.