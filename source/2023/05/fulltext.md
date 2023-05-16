<!-- dcterms:title = Napište si vlastní Google: Fulltextové vyhledávání v SQL Serveru -->
<!-- dcterms:abstract = Mirosoft SQL Server obsahuje docela schopné fulltextové vyhledávání. Google se sice nevyrovná, ale zase nad ním máte úplnou kontrolu. Využil jsem ho k tomu, že jsem si napsal vlastní software pro prohledávání statického webu, jako je třeba tento blog. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:coverUrl = /cover-pictures/20230516-fulltext.jpg -->
<!-- x4w:pictureUrl = /perex-pictures/20230516-fulltext.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = IT -->
<!-- dcterms:date = 2023-05-16 -->

Po více než dvaceti letech psaní publikačních systémů je bytostně nenávidím všechny. Proto je většina mých nových webů jenom hromada statických souborů v Markdownu, které nějaká utilitka přežvýká do HTML. Má to spoustu výhod: můžete to jednoduše hostovat kdekoliv (tento web je hostovaný na GitHubu), většinou zadarmo, dost dobře se to nedá hacknout, nulová údržba... Ale nevýhodou je, že se na takovém webu špatně dělá vyhledávání.

Od počátku existence tohoto blogu jsem zde používal Google Custom Search (dnes [Programmable Search Engine](https://programmablesearchengine.google.com/about/)). To ale mělo několik nevýhod. Indexovalo si to co chtělo a kdy chtělo, neměl jsem nad tím kontrolu, vkládalo to reklamy a bylo to od Google.

Co kdybych si napsal vlastní fulltextový vyhledávač? Není to tak těžké, jak to na první pohled vypadá, protože heavy lifting, vlastní fulltextové vyhledávání, za mne může udělat Microsoft SQL Server. Stačí napsat nějaký crawler, který nacpe statické texty do databáze a nějaké API, které umožní zobrazit výsledky.

## Projekt Incitatus

Tak vznikl projekt s označením Incitatus. Je to custom indexovací engine pro web. Na rozdíl od běžného vyhledávače vychází z předpokladu, že s ním prohledávaný web bude aktivně spolupracovat:

* **Řekne mu, jaké stránky má indexovat.** K tomu používám [Sitemaps](https://www.sitemaps.org/). To je [XML dokument](/sitemap.xml), který obsahuje seznam stránek daného webu a datumů jejich poslední aktualizace. Není tedy nutné psát crawler, který prochází odkazy na webu. Stačí napsat mnohem jednodušší software, který si stáhne sitemap, zjistí nové nebo změněné stránky a stáhne je.
* **Řekne mu, jaké části stránky má indexovat.** Není žádoucí, aby se indexoval celý web, včetně hlaviček, patiček, menu... V nastavení lze určit XPath výraz, který určuje kterou část HTML dokumentu má prohledávat.
* **Řekne mu, kdy má indexovat změny.** Sitemap soubor obsahuje datum poslední změny a proces načtení sitemap spustíte tím, že po aktualizaci webu zavoláte webhook, nějakou URL.

Celá ta věc se bude ovládat přes API. Nemá žádné lidsky čitelné rozhraní, jenom REST API, pomocí kterých lze spravovat jednotlivé prohledávané weby a také posílat fulltextové dotazy a číst výsledky.

Statický web pak potom bude toto API volat z JavaScriptu. Můžete si to vyzkoušet [na tomto blogu](/search).

Zdrojové kódy najdete na [mém GitHubu](https://github.com/ridercz/Incitatus). Na YouTube kanálu Z-TECH najdete [playlist](https://www.youtube.com/playlist?list=PLFZurxJN0pMaEzNvfyDMB5eiECURGh5D5), který tento projekt popisuje ve čtyřech videích.

## Stahování dat

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/TcOjcRNc9aY" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

V prvním dílu seriálu vám předvedu část na stahování prohledávaných webů. Nejprve stáhneme (a proparsujeme) sitemap soubory, abychom zjistili jaké stránky budeme indexovat (které se změnily nebo nově přibyly od posledního indexování). Poté stáhneme konkrétní stránky a jejich obsah uložíme do databáze.

## Fulltext v SQL Serveru

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/9w5LxlrU32c" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

Ve druhém dílu vám ukážu, jak napasovat fulltext v Microsoft SQL Serveru na Entity Framework Core. Také napíšu překladač z lidsky pochopitelné syntaxe dotazů do té, které rozumí SQL Server.

## Zabezpečení API

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/ecvAZw9EP8Q" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

Třetí díl seriálu o tvorbě vlastního fulltextového vyhledávače popisuje, jak dosud anonymní API pro správu indexovaných webů zabezpečit pomocí API klíče předávaného jako bearer token.

## JavaScript klient a CORS

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/PjOdcfb230A" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

V závěrečném dílu seriálu o tvorbě vlastního fulltextového vyhledávače konečně napojíme indexovaný statický web na náš vyhledávací server pomocí klientského JavaScriptu. Také si ukážeme, jak pomocí CORS nastavit, z jakých domén lze API volat.

## Omezení a možnosti rozšíření do budoucna

* V současnosti si musí aktualizaci sitemap web vyžádat, nikdy neproběhne automaticky. Chci tam dopsat možnost pravidelného indexování v nastavených intervalech.
* K jednotlivým stránkám nelze přidávat metadata (např. rubriky, perex obrázek...), které by mohly být součástí výsledků vyhledávání.
* Není možné sledovat stav systému - třeba počet indexovaných stránek, počet stránek čekajících na indexaci atd. Není na to API nebo dashboard.