<!-- dcterms:identifier = aspnetcz#162 -->
<!-- dcterms:title = Čárové kódy na webu: Základy -->
<!-- dcterms:abstract = Od doby, co jsem na webu akce.altairis.cz spustil tisk pozvánek s čárovým kódem, byl jsem opakovaně dotazován na zkušenosti. Tento článek popisuje souhrnně zkušenosti a poznatky, ke kterým jsem dospěl. Může být užitečný všem, kdo chtějí implementovat čárové kódy ve svých webových aplikacích. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Tipy, triky -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- np9:serialId = 3 -->
<!-- x4w:serial = Čárové kódy na webu -->
<!-- dcterms:created = 2007-08-14T22:05:36.997+02:00 -->
<!-- dcterms:dateAccepted = 2007-08-14T22:05:36.997+02:00 -->

Od doby, co jsem na webu [akce.altairis.cz](http://akce.altairis.cz/) spustil tisk pozvánek s čárovým kódem, byl jsem opakovaně dotazován na zkušenosti. Tento článek popisuje souhrnně zkušenosti a poznatky, ke kterým jsem dospěl. Může být užitečný všem, kdo chtějí implementovat čárové kódy ve svých webových aplikacích.

## Co jsou čárové kódy

Obecně čárové kódy představují možnost, jak zakódovat sekvenci číslic (případně i písmen a jiných znaků) do grafického symbolu. Ten je možné speciálním zařízením (čtečkou) přečíst. Výhoda spočívá v tom, že načtení čárového kódu je rychlejší než jeho ruční opisování a zároveň je méně náchylné k chybám.

Norem pro generování čárových kódů existuje celá řada a zabývají se v zásadě třemi otázkami:

1.  **Definice kódování znaků do čar.** Neboli jak daná data převést na čáry a mezery. To je část normy, kterou je nutné se bezpodmínečně zabývat. **Definice technických podmínek čitelnosti.** Určuje minimální a maximální rozměry kódu, velikost ochranného pásma (prázdné plochy, která by kolem kódu měla zůstat, aby čtečka dokázala kód najít a přečíst), kontrast světlého a tmavého bodu a podobně. Tato část se obecně na webu zajišťuje nejhůře, zvláště pokud se předpokládá, že si uživatelé budou kódy tisknout sami obecně na tiskárnách, které mají k dispozici, a tisk nebude probíhat v kontrolovaném prostředí a prověřeném hardware. **Definice obsahu informace.** Popisuje formát dat, která mají být kódována. Některé čárové kódy v sobě mají vestavěné mechanismy výpočtu kontrolního součtu, případně jsou určeny pro speciální aplikace, které určují formát uchovávaných dat. 

## Typy čárových kódů

Existuje celá řada norem, ať už specializovaných nebo univerzálních. Mám zkušenosti s implementací třech hlavních norem: EAN13, Code 2/5 a Code39.

### Kódy EAN

Čárové kódy dle normy GS1 (dříve EAN) najdete dnes téměř na čemkoliv, co se prodává v maloobchodě. GS1 je rozsáhlá sada standardů, jejichž cílem je zjednodušit logistiku při prodeji zboží. Popisuje metody pro označování spotřebitelských balení, velkoobchodních balení, formáty výměny dat atd. Nás bude pro tento okamžik zajímat pouze velmi malá část z celého tohoto systému - čárové kódy pro označování spotřebitelského balení zboží.

Ty se vyskytují ve dvou variantách: EAN8 a EAN13. Obě umožňují zaznamenat číselný údaj o pevné délce - 7 nebo 12 číslic plus jedna kontrolní. Tato norma je konstruována jako velmi robustní, kombinace použitého kódování a povinného výpočtu kontrolní číslice prakticky znemožňuje jeho chybné načtení, i když je kód hodně poškozen. Výpočet kontrolní číslice při čtení obvykle provádí přímo sama čtečka, takže se kód načte buď správně, nebo vůbec ne.

Norma stanovuje nejenom způsob kódování, ale velmi striktně též obsah kódovaných dat. Obsahuje kód země, kód výrobce a pak vlastní kód produktu, přičemž o přidělení kódu výrobce je třeba žádat zastřešující organizaci. 

Speciální případ představuje kódování ISBN (číselné kódy pro knihy), ISSN (totéž pro periodické publikace) a ISMN (hudební nosiče).

Pro vnitřní použití norma povoluje použití EAN13 kódů, které začínají "999". Nikdo vám samozřejmě nemůže technicky zabránit v tom, abyste generovali kódy jaké chcete, ale doporučuji vám, abyste toto doporučení respektovali.

Kód EAN 13 používám právě na shora uvedeném webu [akce.altairis.cz](http://akce.altairis.cz/). Jeho struktura je následující: *999nnnnxxxxxc*. Začíná shora uvedenými třemi devítkami. Následující čtyři číslice (v obecné normě EAN slouží obecně k identifikaci výrobce) slouží k identifikaci konkrétní instance programu Nemesis Calendar, která kód vydala. Následujících pět číslic je pořadové číslo registrace, které odpovídá klíči v databázi. Poslední je kontrolní číslice, vypočítaná dle normy EAN.

### Kódy rodiny 2/5

Velmi často používané jsou kódy z rodiny "dva z pěti". Označují se jako "Code25", "Code 2/5", "Code 2 of 5" a podobně. Tyto kódy mají sPokpolečné to, že každý znak je tvořen pěti moduly (čárami nebo mezerami), z nichž vždy právě dva jsou široké a tři úzké. Tyto kódy umožňují zakódovat pouze číslice 0-9 a jsou univerzálně použitelné.

*   **Code 25 Industrial** je dle mého názoru nejjednodušší norma pro pochopení principu čárových kódů: každý znak je reprezentován sekvencí silných a slabých čar. Čáry jsou odděleny mezerami, které jsou vždy stejně široké a nenesou žádnou informaci. **Code 25 Interleaved** je úspornější variantou téhož. Pro kódování informace využívá nejenom čáry, ale též mezery. Jedná se v podstatě o "dva kódy v sobě". 

### Kódy rodiny Code39

Tato rodina umožňuje kódovat nejenom číslice, ale i písmena. Klasický kód **Code39** umožňuje kódovat číslice 0-9, písmena A-Z a některé speciální znaky (mezeru, -, ., $, /, + a %). 

Existuje i varianta **Code 39 Full ASCII**, která umožňuje kódovat všechny znaky základní sedmibitové ASCII tabulky (tedy ne diakritiku). Činí tak tím způsobem, že speciální znaky zapisuje jako kombinaci shora uvedených - např. "*+B*" znamená "*b*". Jistá nevýhoda tohoto přístupu spočívá v tom, že z kódu samotného není poznat, zda se jedná o prostý Code39 nebo jeho Full ASCII variantu. Obvykle se nastavením čtečky určuje, zda má být Full ASCII podporováno nebo nikoliv.

## Jaký kód použít?

V řadě případů nemáte na vybranou a musíte generovat kód podle určité normy (např. pokud tisknete přepravní doklady k zásilkám pro kurýrní služby a podobně). Pokud záleží čistě na vás, musíte zodpovědět následující otázky:

**Co chci kódovat?** Záleží na povaze informace (číslice, písmena) a její délce. Pokud chcete kódovat pouze číslice, máte na výběr z většího množství norem.

**Co zvládne moje čtečka?** Pokud se týče podporovaných norem, tak většina běžně dostupných čteček zvládá všechny shora uvedené formáty a řadu dalších, zde neuvedených (třeba Code128 a další). Důležitým parametrem ale může být maximální šířka čtecího pole, tedy jak velký kód (bavíme se o fyzických rozměrech) dokáže čtečka přečíst.

**Jak bude kód tisknut a jak bude s vytištěným materiálem dále zacházeno?** Obecně platí, že čím více dat zakódujeme, tím bude výsledný kód delší (nejedná-li se o kód typu EAN, který má pevně danou délku). Na druhou stranu platí, že čím jemnější kód bude (tj. čím tenčí bude jednotková šířka čáry a mezery), tím hůře se bude číst a dekódovat.

Pokud budete kód tisknout na speciální tiskárně čárových kódů nebo kvalitní laserovce a výsledek se buďto hned použije a nebo třeba zalaminuje, lze použít jemný kód. Pokud se očekává, že kódy budou tisknuty na roztodivných tiskárnách pochybné kvality a posléze delší dobu nošeny po kapsách, je třeba použít hrubší kód a větší jednotkový rozměr. Pak ale naroste celková fyzická délka kódu a může se stát, že bude pro použitou čtečku příliš široký a nebude možné kód přečíst. To hrozí zejména u levných CCD čteček, které mívají maximální šířku kódu okolo 8 cm.

## Zkušenost z praxe

V praxi tedy bude volba kódu kompromisem shora uvedených parametrů. V praxi se mi osvědčilo použití robustního kódu EAN13 o maximálním fyzickém rozměru (cca. 7 cm). I obyčejná laciná čtečka dokázala přečíst kódy vytištěné rozličným pochybným způsobem. Tedy např. s docházejícím tonerem (světlý tisk), na neseřízených inkoustových nebo jehličkových tiskárnách (roztřesené čáry), na recyklovaném neběleném papíře (šedý, nižší kontrast) i s tisky různě zmačkanými a natrženými.

Z mnoha stovek pozvánek jsme měli problémy pouze v asi čtyřech případech, kdy byl kód zcela nečitelný a bylo nutné opsat číslice ručně.

V dalším pokračování tohoto seriálu se podíváme na praktické aspekty generování čárových kódů a možnosti, které se nabízejí.