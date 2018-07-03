<!-- dcterms:identifier = aspnetcz#5422 -->
<!-- dcterms:title = HTTPS už máte. Tak ještě aby vám k něčemu bylo. -->
<!-- dcterms:abstract = OpenSSL Heartbleed chyba, která bouří celým Internetem, se Microsoft platformě vyhnula. Ne tak řada implementačních problémů, které často způsobí, že web sice má zabezpečené spojení, ale to je efektivně k ničemu. Zvu vás na bezplatný seminář, v němž vám ukážu, jak HTTPS správně používat, když už ho máte. -->
<!-- np9:categoryId = 6 -->
<!-- x4w:category = Akce a události -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2014-04-17T17:26:50.8+02:00 -->
<!-- dcterms:dateAccepted = 2014-04-17T17:26:51+02:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20140417-https-uz-mate-tak-jeste-aby-vam-k-necemu-bylo.jpg -->

OpenSSL Heartbleed chyba, která bouří celým Internetem (popis z mé klávesnice [najdete na iHNed](http://tech.ihned.cz/geekosfera/c1-62006020-heartbleed-bezpecnostni-chyba-openssl), stejně jako [zamyšlení nad možnými důsledky](http://tech.ihned.cz/geekosfera/c1-62018560-otazky-a-odpovedi-jak-zmeni-heartbleed-chyba-openssl-a-internet)), se Microsoft platformě vyhnula. Ne tak řada implementačních problémů, které často způsobí, že web sice má zabezpečené spojení, ale to je efektivně k ničemu. 

Zvu vás na bezplatný seminář, v němž vám ukážu, jak HTTPS správně používat, když už ho máte.

Mluvit budu o dvou základních oblastech. Tou první je správné nastavení serveru, tedy pooužitých protokolů SSL, TLS, algoritmů… Budu mluvit o forward secrecy a dalších souvisejících tématech. Druhá oblast je zejména pro programátory, totiž jak vytvořit aplikaci tak, aby HTTPS správně využívala.

Velice často se lze setkat s tím, že web má sice HTTPS, ale buďto je nešťastně nastavený server, nebo nešťastně napsaná aplikace, takže je námaha s jeho implementací skoro zbytečná. A bohužel, platí to i u velkých a důležitých webů.

No a samozřejmě se zmíním i o tom Heartbleed útoku, protože to je za daných okolností skoro povinnost.

Ukázky budou sice prezentovány na IIS a ASP.NET, ale jádro tvoří obecné koncepty, které jsou nezávislé na platformě, programovacím jazyku a podobně. Přednáška bude užitečná i pro ty, kdo programují v PHP a aplikace jim běží na Apache.

**Akce se bude konat v úterý, 22. dubna 2014 od 18:00 v budově Microsoftu.** Vstup je zdarma, ale podmínkou je předchozí [registrace na GeekCore](https://www.geekcore.cz/events/5751).