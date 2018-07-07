<!-- dcterms:identifier = aspnetcz#213 -->
<!-- dcterms:title = Podívejte se své cache na zoubek -->
<!-- dcterms:abstract = Robustní cacheovací mechanismus je jedna z nejužitečnějších technologií, jaké ASP.NET nabízí. Při vhodném použití může cacheování velmi zvýšit výkon aplikace, aniž by bylo nutné do ní příliš zasahovat. Pokud ale cacheování využíváte extenzivně, máte velkou šanci, že se v něm ztratíte. -->
<!-- np9:categoryId = 7 -->
<!-- x4w:category = Software -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2008-11-09T23:17:13.367+01:00 -->
<!-- dcterms:dateAccepted = 2008-11-09T23:17:13.367+01:00 -->

[![20081109-CacheManager](https://www.cdn.altairis.cz/Blog/2008/20081109-20081109-CacheManager_thumb_1.gif "20081109-CacheManager")](https://www.cdn.altairis.cz/Blog/2008/20081109-20081109-CacheManager_4.gif)Robustní cacheovací mechanismus je jedna z nejužitečnějších technologií, jaké ASP.NET nabízí. Při vhodném použití může cacheování velmi zvýšit výkon aplikace, aniž by bylo nutné do ní příliš zasahovat. Pokud ale cacheování využíváte extenzivně, máte velkou šanci, že se v něm ztratíte.

Na pomoc přochází **Cache Manager**. Malá ale šikovná aplikace, která umožňuje přímo z webu zobrazit cacheované položky a spoustu údajů, které jsou o nich dostupné. Položky také můžete z cache jednoduše odstranit.

Výhodou je jednoduchá instalace. Stačí do *bin* adresáře vaší aplikace přidat jednu assembly a zaregistrovat ve *web.config* jeden handler. No a pak se staší podívat na *cachemanager.axd* a máte vystaráno. To mimo jiné umožňuje nasadit aplikaci i na produkční server, když řešíte nějaké cacheovací problémy, které se vám nedaří bez reálné zátěže duplikovat.

CacheManager si můžete zdarma stáhnout na webu ASP Alliance: [http://www.aspalliance.com/CacheManager/](http://www.aspalliance.com/CacheManager/ "http://www.aspalliance.com/CacheManager/")