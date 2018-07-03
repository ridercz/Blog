<!-- dcterms:identifier = aspnetcz#5447 -->
<!-- dcterms:title = Zpracování aktuálních a historických kurzů měn přes API ČNB -->
<!-- dcterms:abstract = Kamarád Michal Bláha se na Facebooku sháněl po API, které by mu dalo k dispozici kurzy měn včetně historie. Vzpomněl jsem si, že jsem něco takového napsal, tak jsem to oprášil, přeleštil a dávám k dispozici. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Tipy, triky -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2016-08-12T20:34:50.957+02:00 -->
<!-- dcterms:dateAccepted = 2016-08-13T10:00:00+02:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20160813-zpracovani-aktualnich-a-historickych-kurzu-men-pres-api-cnb.png -->

amarád [Michal Bláha](http://www.michalblaha.cz/) se na Facebooku sháněl po API, které by mu dalo k dispozici kurzy měn včetně historie. Vzpomněl jsem si, že jsem něco takového napsal, tak jsem to oprášil, přeleštil a dávám k dispozici nejenom jemu, ale i všem ostatním zájemcům..

Aplikace využívá [API České národní banky](https://www.cnb.cz/cs/financni_trhy/devizovy_trh/kurzy_devizoveho_trhu/denni_kurz.txt). Ta publikuje v jednoduchém textovém formátu (v podstatě CSV, jenom se pro oddělení používá svislítko) aktuální i historické kurzy. Nevím jak daleko do minulosti, ale minimálně do roku 2000. 

Napsal jsem tedy [třídu, která tato data stáhne, proparsuje a publikuje](https://gist.github.com/ridercz/66f22ce86d082f059d26cde05ac69f87).

Z programátorského hlediska je to kód dost přímočarý a jednoduchý. Pozoruhodných je pouze pár drobností:

*   Všechny čtyři třídy jsem vložil do jednoho souboru i s ukázkovou konzolovou aplikací. Což není obecně pro praxi příliš dobré řešení, ale pro ukázkový kód ideální. Vzhledem k jednoduchosti předpokládám, že si prostě třídy `CnbClient`, `CnbExchangeRateList` a `CnbExchangeRate` nakopírujete někam do svého projektu. Nedělal jsem z toho ani samostatné DLL s NuGet balíčkem, jak je to jednoduché. 
*   Obecně není dobrý nápad psát si vlastní parsování CSV, pokud dopředu neznáme přesný formát dat, může tam být quotování atp. Obvykle používám pro import a export knihovnu [CsvHelper](http://www.nuget.org/packages/CsvHelper/). Zde je ale formát natolik pevný, že jsem dal přednost jednoduchosti. 
*   Výsledek je předáván jako třída `CnbExchangeRateList`, což je potomek `ReadOnlyCollection`. Původně jsem chtěl vracet jenom `IEnumerable<CnbExchangeRate>`, ale pak jsem si uvědomil, že bych měl někde předávat i datum, k němuž byl vydán kurzovní lístek. Ten je obecně vydáván jenom v pracovních dnech a pokud se zeptáte na nepracovní den, vrátí API poslední platný. Datum, k němuž byl lístek vydán, je dostupný jako vlastnost `Date`. 
*   Klient je jednoduše napsaný jako asynchronní (metoda `GetRatesAsync`). Pro použití v synchronním prostředí jsem přidal wrapper `GetRates`, který se zeptá přímo na vlastnost `Result`. 
*   V testovací aplikaci lze vidět poměrně pokročilé využití string interpolation včetně zarovnávání a formátovacích řetězců, aby to vyrobilo hezkou tabulku. 
*   V přechodném období ČNB [publikovala](https://www.cnb.cz/cs/financni_trhy/devizovy_trh/kurzy_devizoveho_trhu/denni_kurz.txt?date=12.08.2000) kromě kurzu EUR i přepočítané kurzy tehdejších národních měn. Ty moje třída ignoruje (zastaví zpracování na prvním prázdném řádku). 
*   Ošetření chyb není příliš robustní, resp. kód na první chybě zhavaruje a nepokouší se ji nějak řešit (např. pokračovat zpracováním dalšího řádku). To je záměr. U aplikace tohoto typu mohou nastat v zásadě pouze dva druhy chyb: buďto se nepodařilo data načíst vůbec (server ČNB je nedostupný atd.) nebo se je nepodařilo správně proparsovat. Ve druhém případě se nejspíše změnil formát, v němž jsou publikována a v takovém případě je lepší rovnou zhavarovat, než se z toho pokoušet nějak vylhat, protože by mohlo dojít k chybné interpretaci dat. 