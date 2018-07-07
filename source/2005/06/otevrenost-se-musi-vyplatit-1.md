<!-- dcterms:identifier = riderweblog#208 -->
<!-- dcterms:title = Otevřenost se musí vyplatit (1) -->
<!-- dcterms:abstract = Aneb proč píšu free software i když si myslím, že je vcelku k ničemu. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Koně -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2005-06-15T03:02:12.893+02:00 -->
<!-- dcterms:dateAccepted = 2005-06-15T03:02:12.893+02:00 -->

*Nemám nic proti pánubohu, ale jeho fanklub mne štve. *Autora tohoto známého výroku se mi sice odhalit nepodařilo, ale velmi výstižně vyjadřuje můj vztah k open source a jisté části jeho propagátorů.

## Jemný úvod do problematiky softwarových licencí

Protože můj blog čtou v hojné míře i jedinci Svatou válkou počítačových licencí nepostižení, rád bych vysvětlil dva základní modely šíření počítačových programů.

První je „closed source“, běžná komerční distribuce. Program šířený tímto způsobem si musíte koupit. Lépe řečeno: kupujete si jeho licenci, tedy v podstatě souhlas autora s některými způsoby jeho využití. Důležité je slovo *některými*: nemáte (zpravidla) právo daný software jakýmkoliv způsobem měnit, dále jej šířit (ať už v původní nebo pozměněné verzi).

Pod tímto modelem je šířena valká část známých aplikací, typicky například operační systém Microsoft Windows, kancelářský balík Microsoft Office a další.

Druhým modelem je „open source“, někdy též nazývaný svobodný nebo otevřený software. Open source programy jsou většinou (ne nutně) šířeny zdarma, ale hlavní změnou proti předchozímu je, že je každému volně dostupný zdrojový kód programu a máte právo program dále upravovat a šířit jeho původní i vámi upravenou verzi.

Pravděpodobně nejznámějším produktem, který je šířen jako open source, je operační systém Linux. Z aplikací běžnému uživateli bližších je to například webový prohlížeč Mozilla Firefox nebo kancelářský balík Open Office.

## Proč to ti lidé dělají?

Motivace autorů, kteří používají closed source model je vcelku jasná: něco vyrábějí, za nějakou cenu prodávají a snaží se bránit tomu, aby to jiní dělali neoprávněně za jejich zády.

S motivací autorů open source je to trochu složitější, ale je nutné se s obvyklými důvody seznámit, pokud chceme do problematiky proniknout.

### Přece to nevyhodíme, aneb možná to budou chtít aspoň zadarmo, když už se nám to nepodařilo prodat

S trochou škodolibosti zde prezentuji jako první důvod, který ze stádia klinické smrti přivedl zpět k životu dvě vlajkové lodi open source: Mozillu a Open Office.

Příběh vzestupu a pádu společnosti Netscape Communications a jejího webového prohlížeče Netscape je myslím dostatečně známý. V době, kdy se tržní podíl jiných prohlížečů než Internet Exploreru pohyboval na hranici statistické chyby, se společnost Netscape Communications (resp. AOL, která ji koupila) vzepjala v předsmrtné křeči k do té doby nevídanému výkonu: do té doby žárlivě střežený zdrojový kód svého prohlížeče otevřela a vydala všanc veřejnosti. Sázka vyšla a Netscape (pod značkou Mozilla) vstal z mrtvých a znovu se stal hráčem, s nímž je třeba počítat.

Obdobnou historii má za sebou i Open Office: Společnost Sun Microsystems se poměrně dlouhou dobu snažila prodávat kancelářský balík a konkurovat Microsoft Office. Moc se jí to nedařilo a proto udělala obdobný krok jako Netscape. A Open Office ožil a rozšířil se.

Z poslední doby je možno zmínit pokus téže společnosti obnovit notně zašlou slávu operačního systému Solaris otevřením i jeho zdrojového kódu. Na hodnocení výsledků je ještě příliš brzy, ale zatím se zdá, že v tomto případě už nepomůže ani živá voda v podobě svobodného software. Reakce vývojářů je jen vlažná.

Podívejme se na příčiny úspěchu Mozilly a Open Office. Hlavní trik byl v tom, být ve správnou dobu na správném místě. V době uvolnění zdrojového kódu Netscape v podstatě neexistovala žádná rozumná alternativa k Internet Exploreru. Který někdo používat nechtěl, jiný nemohl, třeba protože na jeho operačním systému nefungoval. Totéž se týká Open Office: Před jeho příchodem se o konkurenci Microsoft Office téměř nedalo hovořit a mimo jím podporované platformy (Windows a MacOS) to byla bída s nouzí.

Co tímto krokem společnosti Netscape/AOL a Sun získaly? Především popularitu a dobrou pověst. Zbavily se též zodpovědnosti za osud produktu, do jehož vývoje sice investovaly velké peníze, ale nebyly je nijak schopny dostat zpět a zajistit pro tento produkt další rozvoj a podporu.

Mohu jenom odhadovat, že jistou roli v tom hrálo i škodolibé uspokojení, že tím alespoň trochu naštvou Microsoft, když už ho nemohou porazit.

### Když chceš, aby něco fungovalo pořádně, udělej si to sám

Zatímco většina uživatelů hledí na počítač jako na černou skříňku, která holt něco umí a něco ne, existuje skupina lidí, která věci vidí jinak. Mají velmi přesnou představu o tom, jak by měl vypadat software, který by jim vyhovoval. Jak by měly vypadat jeho funkce, jeho ovládání, jeho všechno.

Jednoho krásného dne se tedy naštvou, a hnáni především frustrací si ten software napíšou, brblajíce si přitom pod vousy něco jako „co si člověk neudělá sám, to nemá“. Tento postup je častý u malých, takříkajíc jednomužných programů. Webovou galerii napíše schopný programátor za jedno volné odpoledne, diskusní server za dvě a docela schopný mail server za pár měsíců. Komplexní databázový systém už takhle nevyvinete.

Jak jsem již byl pravil, přesně toto je případ geneze většiny mých open source programů. Vznikly tak, že jsem se usilovně snažil najít nějaký program, který by vyhovoval mým požadavkům, ale nic takového se mi prostě nepodařilo objevit.

Výsledkem takového pohnutí nutně *nemusí *být svobodný software. Řada autorů se po dokončení díla plácne do čela a nazná, že by se to mohlo třeba i podařit prodat, a pokusí se o to.

Pro signifikantní část těch ostatních (včetně mne) je účelem vytvoření daného programu uspokojení vlastních potřeb. Cokoliv dalšího – například finanční zisk z případného prodeje – je něco navíc. Pokud naznám, že daný SW je sice použitelný, ale želbohu neprodejný, klidně ho dám k dispozici širému světu. Psal jsem ho pro sebe, a pokud se bude hodit ještě někomu dalšímu, tak ať si ho pro mne za mne vezme.

K tomu se vážou další činnosti povahy obchodní a právní. Pokud někomu prodám nějaký software, jsem zpravidla povinen ho udržovat a mám přinejmenším morální povinnost ohlížet se na přání uživatele, pokud se týče jeho dalšího vývoje či nových funkcí. Pokud dám program k dispozici zdarma, mohu se těchto neradostných konsekvencí úspěšně zbavit: mně se to líbí *takhle *a pokud vám ne, přepište si to nebo táhněte do háje. A vůbec, darovanému koni na zuby nehleď.

### To se to píše, za cizí peníze

Pokaždé, když někdo přijde s objevným nápadem, že by státní správa měla používat open source programy, a to pokud možno povinně, ironicky přizvukuji. Však jsme si ten svobodný software z velké části také zaplatili.

Velká část vývoje a distribuce open source aplikací leží na bedrech lidí, kteří jsou placeni z peněz daňových poplatníků. Typicky se shromažďují na vysokých školách.

Často je software, nebo jeho jádro, výsledkem výzkumného projektu či podobné aktivity.

### Software vám dáme zadarmo a odrbeme vás na službách

Pořizovací cena programového vybavení je – zejména v případě rozsáhlejších informačních systémů – jenom vcelku malou částí všech nákladů. Na celkových nákladech na vlastnictví (TCO – total cost of ownership) se podepisují zejména položky jako je správa systému či jeho údržba.

Byla vypracována celá řada studií, jejichž cílem je zodpovězení otázky, zda jsou z hlediska TCO výhodnější systémy open source nebo closed source. Renomované konzultační firmy nejsou ve svém úradku jednotné – pravděpodobně na základě toho, kdo je právě platí. Užitečnost jejich vzájemně si protiřečících zpráv spočívá především v tom, že poskytují dostatek argumentační munice pro podporu jakéhokoliv názoru.

Jest nicméně skutečností, že existuje celá řada firem, které ochotně dávají svůj software zdarma a očekávají, že budou vydělávat na souvisejících službách. Obvykle dobře informované zdroje říkají, že se to několika z nich dokonce i daří.

### Brave new world a slova psaná s velkými písmeny na začátku

Nejhalasnější část open source komunity používá při argumentaci velkých slov s velkými písmeny na začátku. Nejoblíbenější jsou: Svoboda, Otevřenost, Zdrojový Kód a Bezpečnost. Možná se zde projevuje můj přílišný cynismus, ale zdá se mi, že s výjimkou několika extrémních případů platí nepřímá úměra mezi halasností projevu a skutečně odvedenou prací.

Kromě toho, pro praktický život je ideologie většinou příliš svazující – což nepochybně potvrdí ti, kdo pamatují léta reálného socialismu. Ano, v ideálním světě by se pro výměnu dokumentů *měly *používat otevřené a nezávislé formáty, v praxi vám to stejně všichni pošlou ve Wordu.

*([pokračování zde](/entry/article-20050724.aspx))*