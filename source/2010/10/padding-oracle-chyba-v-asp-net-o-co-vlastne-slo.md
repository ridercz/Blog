<!-- dcterms:identifier = aspnetcz#303 -->
<!-- dcterms:title = "Padding Oracle" chyba v ASP.NET – o co vlastně šlo? -->
<!-- dcterms:abstract = Myšlenky těch zodpovědnějších ASP.NET programátorů a správců serverů v uplynulých dnech okupovala první pořádná bezpečnostní díra v ASP.NET. Upozorňoval jsem na ni i na tomto webu a nabízel i workaround. Microsoft již vydal i oficiální záplatu, nově dostupnou přes Windows Update. Myslím si, že je přesně ten správý okamžik podívat se, o co vlastně šlo, v čem útok spočívá. Nejedná se totiž ve své podstatě o chybu v ASP.NET, ale o obecný mechanismus kryptografického útoku, který může zasáhnout i vaše vlastní aplikace. -->
<!-- np9:categoryId = 2 -->
<!-- x4w:category = Bezpečnost -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2010-10-03T22:22:18.467+02:00 -->
<!-- dcterms:dateAccepted = 2010-10-03T22:22:19.717+02:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20101003-padding-oracle-chyba-v-asp-net-o-co-vlastne-slo.png -->

Myšlenky těch zodpovědnějších ASP.NET programátorů a správců serverů v uplynulých dnech okupovala první pořádná bezpečnostní díra v ASP.NET. [Upozorňoval jsem na ni](http://www.aspnet.cz/articles/298-kriticka-bezpecnostni-chyba-v-asp-net) i na tomto webu a nabízel i [workaround](http://www.aspnet.cz/articles/299-modul-pro-jednoduchy-workaround-bezpecnostni-chyby-v-asp-net). Microsoft již vydal i [oficiální záplatu](http://weblogs.asp.net/scottgu/archive/2010/09/28/asp-net-security-update-now-available.aspx), nově [dostupnou přes Windows Update](http://weblogs.asp.net/scottgu/archive/2010/09/30/asp-net-security-fix-now-on-windows-update.aspx). V tomto článku se pokusím vysvětlit, o co vlastně šlo. V čem daný problém spočívá, kde je problém v ASP.NET implementaci a jak se tomuto mechanismu vyhnout při tvorbě vlastních aplikací. 

Hned v úvodu bych rád upozornil, že kryptografie je sice mým koníčkem, ale nedisponuji takovým stupněm znalostí, který by mi umožnil všechny aspekty tohoto problému pochopit zcela do detailů. Tento článek je syntézou dostupných informací a mých vlastních kryptografických znalostí. Obsahuje úmyslná zjednodušení za účelem vysvětlení problematiky širšímu publiku a může obsahovat i zkreslení vzniklá mými nedostatečnými znalostmi. I přesto si myslím, že může být prospěšný a proto jej po jistém váhání publikuji.

## Padding a CBC operation mode

Dnes používané symetrické šifry, jako například AES (Rijndael) nebo starší DES/3DES, jsou blokové. O práci s nimi z .NETu jsem psal již před lety v článku [Symetrické šifrování AES/Rijndael v .NET](http://www.aspnet.cz/articles/147-symetricke-sifrovani-aes-rijndael-v-net). Blokové šifry jednom kroku zašifrují pevně daný počet bitů (typicky 128-256 bitů, tedy 16-32 bajtů). Pokud není délka zprávy beze zbytku dělitelná velikostí bloku, musíme vymyslet způsob, jak zaplnit zbylé "volné" místo. Tomuto mechanismu se říká padding. Pro další vyprávění je sice důležitý, ale není důležitý jaký konkrétní mechanismus se použije – jejich přehled najdete na [Wikipedii](http://en.wikipedia.org/wiki/Padding_(cryptography)).

Typicky chceme šifrovat větší objem dat, než je velikost bloku. Proto je nutné vymyslet mechanismus, kterým zprávu rozdělíme do bloků požadované velikosti. Tomu mechanismu se říká "block operation mode". Nejprimitivnější je samozřejmě bloky prostě klást za sebe, šifrovat každý zvlášť. Tomu se říká ECB (Electronic Codebook) mode a je to spíše teoretický koncept s mnohými problémy, z nichž nejobvyklejší je graficky demonstrován například na [Wikipedii](http://en.wikipedia.org/wiki/Block_cipher_modes_of_operation#Electronic_codebook_.28ECB.29). Nejjednodušším prakticky použitelným a tudíž nejvíce rozšířeným je režim CBC (Cipher Block Chaining), kdy se jednotlivé bloky propojí pomocí operace XOR.

## Problém s věštírnou

Již v roce 2002 Serge Vaudenay na konferenci EUROCRYPT přednesl příspěvek "[Security Flaws Induced by CBC Padding - Applications to SSL, IPSEC, WTLS...](http://lasecwww.epfl.ch/php_code/publications/search.php?ref=Vau02a)", v němž ukázal bezpečnostní riziko výše popisovaného postupu, tj. padding a CBC. Problém je nezávislý na použitém šifrovacím algoritmu, jedná se o tzv. "side channel attack", tedy útok, který není veden přímo proti šifrovacímu algoritmu (AES, DES…) samotnému, ale na podpůrné mechanismy kolem něj. Vaudenay dokazuje, že máme-li k dispozici "padding oracle", která nám umožní zjistit, zda daný blok ciphertextu obsahuje platný padding nebo ne, dokážeme data dešifrovat i bez znalosti šifrovacího klíče.

Slovo "oracle" v názvu útoku je zdroje mnohého zmatení, protože většina lidí neví, co vlastně znamená – a není úplně jednoduché to vysvětlit. Hned na úvod bych rád zdůraznil, že celá věc nemá v zásadě nic společného s Oracle Corporation ani s databázovým systémem Oracle. V kryptografii představuje "oracle" (v překladu *věštec*) myšlenkový konstrukt. Jakousi černou skříňku s definovanými vlastnostmi. Padding oracle v tomto případě představuje cokoliv, do čeho z jedné strany strčím zašifrovaná data a z druhé strany mi vypadne informace, jestli data obsahují správný padding nebo ne. Jedná se skutečně o tento jediný bit informace.

Oracle v tomto případě představuje abstrakci: výše popsaný mechanismus po technické stránce neřeší a pracuje s ním jako s černou skříňkou, o jejíž vnitřní fungování se nezajímá. Může se jednat o různou formu odpovědi (úspěch versus chybové hlášení), timing attack (informace je obsažena v době, kterou zabrala odpověď).

Z tohoto mechanismu v zásadě vyplývá omezení okruhu aplikací, které jsou tímto útokem ohroženy. Jedná se o aplikace komunikační povahy, které přijímají data a poskytují na ně odpovědi v předem neomezeném rozsahu. Nejsou tak ohroženy třeba aplikace, kde jsou data v šifrované podobě ukládána a na žádost dešifrována. Pokud tedy např. máte aplikaci , která prostě mechanismem AES+CBC zašifruje data a uloží je na disk, nejste tímto mechanismem omezeni. Kromě zašifrovaných dat útočník potřebuje získat ještě někoho, kdo data umí rozšifrovat a řekne mu, zda mají správný padding nebo ne, což v tomto případě nenastává.

Pro praktickou aplikaci tohoto útoku je tedy nezbytné najít aplikaci, která v sobě výše popsanou "věštírnu" obsahuje. Tím se zabývali Thai Duong a Juliano Rizzo a věnovali tomu své prezentace na konferencích [Ekoparty 2010](http://netifera.com/research/poet//PaddingOraclesEverywhereEkoparty2010.pdf) a [Black Hat Europe 2010](http://netifera.com/research/poet/PaddingOracleBHEU10.pdf). Podrobnější [článek](http://usenix.org/events/woot10/tech/full_papers/Rizzo.pdf) je součástí sborníku z konference WOOT'10.

Podle mého názoru výrazně srozumitelnější vysvětlení celého problému najdete v článku [Automated Padding Oracle Attacks with PadBuster](http://www.gdssecurity.com/l/b/2010/09/14/automated-padding-oracle-attacks-with-padbuster/). Týká se sice JSP a ne ASP.NET, ale idea je v zásadě pořád stejná.

## Šifrování není autentizace

Typickou ukázkou aplikací, pro které tento útok riziko *představuje*, jsou webové aplikace, které si na klienta "odloží" nějaká data, která při dalším požadavku bez dalšího zpracují a pro jejich ochranu používají pouze symetrické šifrování, ne elektronický podpis. Což jsou bohužel začasté webové frameworky všeho druhu. Zde přichází do hry i ASP.NET. Je nicméně v "dobré" společnosti, protože tytéž problémy mají i různé implementace Java Server Faces (Apache MyFaces a Sun Mojarra, pravděpodobně i jiné), Ruby on Rails a řada CAPTCHA implementací.

Společný jmenovatel je, že se v těchto případech šifrování používá jako forma autentizace. To je přitom úkol, ke kterému není určeno, šifrování slouží k utajení obsahu přenášené informace, od autentizace jsou tady jiné mechanismy, především elektronický podpis. Pokud je třeba zajistit obojí, je nezbytné oba postupy kombinovat. A to pokud možno ve správném pořadí, tedy data nejdřív zašifrovat, pak digitálně podepsat (a logicky tedy nejdřív ověřit podpis a potom dešifrovat). Zde ostatně leží i hlavní hřích ASP.NET v této věci.

## Problémy ASP.NET

Problém ASP.NET (kromě toho, že jde o velký a šťavnatý cíl) spočívá v tom, že chybně implementuje (nebo implementoval) šifrování jako autentizační mechanismus, a to hned na několika místech. V kombinaci s některými dalšími prvky jeho architektury to pak znamená, že problém narostl do nechutných rozměrů.

Za prvé, na řadě míst se sice používá kombinace šifrování s MAC (pro vysvětlení viz článek [HMAC - Hash Message Authentication Code](http://www.aspnet.cz/articles/146-hmac-hash-message-authentication-code) zde na ASPNET.CZ), ale bohužel v obráceném pořadí, tj. data se nejprve podepíší a pak zašifrují. Konkrétně se to týká ticketů pro Form authentication, cookies v nichž se cacheuje role, ViewState a cookies pro anonymní identifikaci při používání anonymních profilů. 

Za druhé, handlery *WebResource.axd* a *ScriptResource.axd* MAC nepoužívají vůbec a spoléhají se na šifrování jako formu autentizace, což mi přijde vpravdě nepochopitelné. A právě v těchto dvou handlerech je největší problém.

Podvržení forms authentication ticketu a dalších dříve zmíněných věcí sice představuje problém, ale jedná se o problém omezitelný vhodnou architekturou aplikace, s omezenými následky a podobně. Problém s handlery má nicméně důsledky dalekosáhlejší. V první řadě, jedná se o součást infrastruktury, která je přítomná všude, kde jsou ASP.NET nainstalované. Tyto handlery není možné žádným "civilizovaným" způsobem vypnout a i kdyby to možné bylo, dopad na funkčnost ASP.NET aplikací by byl příliš velký a proto to nikdo nedělá.

Ve druhé řadě má *ScriptResource* zvláštní schopnost: umí poslat žadateli jakýkoliv soubor z vašeho webu, když jej o to slušně požádáte – viz např. [článek na blogu Martina Hejtmánka](http://devnet.kentico.com/Blogs/Martin-Hejtmanek/September-2010/How-ASP-NET-Security-Vulnerability-affects-Kentico.aspx). Tato funkcionalita (Composite Scripts) slouží ke skládání více JavaScriptových souborů do jednoho, aby se ušetřily HTTP requesty. Není tam přítomen žádný obranný mechanismus, který by limitoval, jaké soubory můžete takto požadovat, např. podle jejich přípony, názvu, adresáře… Pokud tedy takto požádáte třeba o *web.config*, tak ho dostanete. Upřímně doufám, že pachatel tohoto architektonického zvěrstva byl odveden kamsi do hor za Redmondem a tam zastřelen.

Výše uvedený typ útoku lze totiž použít i obráceně, kdy vyrobím libovolný zašifrovaný text. Zde mi sice HMAC pomůže (ten padělat neumím), ale ten není u Web a Script Resource handlerů použit.

## Odhalený web.config

Odhalení souboru *web.config* představuje zásadní bezpečnostní problém. V tomto souboru se totiž nacházejí rozličné zajímavé konfigurační sekce. Například:

*   *connectionStrings* – connection stringy k databázi a tedy názvy serverů, uživatelská jména a hesla databázových uživatelů.
*   *machineKey* – klíč pro všechny výše popsané operace; principem útoku samotného jej sice získat nedokážu, ale pokud jej získám z web.configu, už mohu padělat i HMAC a celkově škodit mnohem elegantněji a s menším úsilím.
*   *identity* – uživatelské jméno a heslo Windows uživatele, kterého mají ASP.NET používat – impersonovat (používá se relativně zřídka).
*   *sessionState* – může obsahovat connection string, pokud session ukládáte do databáze; nechápu, proč si ho povinně nenačítá také ze sekce *connectionStrings* jako ostatní, ale možná to nějaký důvod má, technologií session dlouhodobě opovrhuji z ideových důvodů a v detailech její implementace jsem se nešťoural.  

Získání shora uvedených údajů umožňuje celou škálu zajímavého škození, jehož rozsah a formu nechávám na fantazii P. T. čtenářstva.

Můžeme debatovat o tom, nakolik rozumné je shora uvedené údaje uchovávat v konfiguračním souboru v rootu webu a zda není rozumnější zvolit nějakou sofistikovanější metodu. Faktem je, že to své opodstatnění má a běžně se to dělá.

## Konec dobrý, všechno dobré?

Na popisovanou bezpečnostní díru již existuje záplata a zodpovědný správce serveru ji má nainstalovanou (zeptejte se svého hostera!). Znamená to, že je všechno v pořádku? Zatím svůj optimismus držím na uzdě, nemaje čas efekty záplaty podrobněji zkoumat. Nevím tedy, zda byla odstraněna příčina (i když u forms auth tiketů a podobně to podle popisu možných problémů tak vypadá), nebo jenom tento konkrétní vektor útoku, což je podstatné zejména u resource handlerů. Jak mi čas dovolí, podrobněji prozkoumám chování opraveného frameworku a dám vědět, zda je dobré propadat optimismu nebo ne.