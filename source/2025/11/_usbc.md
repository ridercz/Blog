#  USB-C napájení: Chtěli jsme to udělat co nejlíp a dopadlo to jako vždycky

Je to už více než 22 let od chvíle, kdy  tehdejší ruský premiér Viktor Stěpanovič Černomyrdin pronesl nesmrtelný výrok "Хотели как лучше, а получилось как всегда." Chtěli jsme to udělat co nejlíp, a dopadlo to jako vždycky. A pamatujete na relativně nedávné oslavné posty dnes již bývalého pirátského europoslance o tom, jak nám EU zlepšila život tím, že všem výrobcům přikázala pro napájení a nabíjení používat USB-C? Tyto situace mají hodně společného. Uvidíme, zda dojde i na tu sebereflexi.

> Poznámka: Výjimečně píšu o něčem, k čemu mám formální kvalifikaci - jsem vzděláním slaboproudý elektrotechnik. Své kolegy prosím o shovívavost, protože jsem řadu věcí značně zjednodušil, aby byly pochopitelné pro elektromudly.

## Napětí, proud a výkon

Abychom mohli pochopit v čem je problém, musíme se vrátit do školních škamen a uvědomit si několik základních elektrických veličin.

Elektrické spotřebiče napájíme buďto stejnosměrným nebo střídavým proudem. Pro distribuci se z praktických důvodů zpravidla používá proud střídavý, v ČR ho máme v zásuvce o nominálním napětí 230 V a frekvenci 50 Hz. Většina současné drobnější elektroniky se nicméně napájí proudem stejnosměrným, takže je mezi zásuvku a zařízení zapojen napájecí nebo nabíjecí adaptér, který převádí střídavý proud na stejnosměrný. Dokonce i pokud se zařízení zapojuje přímo do zásuvky, má obvykle uvnitř modul zdroje, který vykonává totéž. Pro účely tohoto vyprávění se tedy budeme zabývat výhradně proudem stejnosměrným.

U něj se zpravidla setkáme se třemi veličinami:

* **Napětí** se uvádí ve voltech (V) a označuje se písmenem _U_. Běžně používané napájecí napětí se pohybuje u současné domácí a kancelářské elektroniky zpravidla v rozmezí 5-20 V.
* **Proud** se uvádí v ampérách (A) a označuje se písmenem _I_, případně jejich tisícinách, miliampérách (mA, 1 A = 1000 mA). U zařízení, která nás zajímají, se pohybujeme v rozmezí od řádově 100 mA (0,1 A) po 10 A.
* **Výkon** se uvádí ve wattech (W) a označuje se písmenem _P_. Pro nás jsou podstatné výkony v jednotkách až malých stovkách wattů.

Co tyto veličiny znamenají? Představme si vodní okruh, ve kterém čerpadlo pohání vodní mlýnek.

* Napětí je **tlak vody**, tedy síla která tlačí elektrony skrz vodič.
* Proud je **průtok vody**, tedy množství elektronů, které protečou za sekundu.
* Výkon je **síla proudu**, tedy kolik práce se vykoná.

Napětí, proud a výkon jsou spolu navzájem propojeny vzorečkem _P = U × I_, tedy výkon rovná se napětí krát proud, a můžeme je navzájem přepočítávat - známe-li dva, spočítáme snadno třetí. Potřebujeme-li výkon 100 W, můžeme ho přenést jako 5 V, 20 A nebo 20 V, 5 A. To bude důležité později.

Běžná malá elektronika, jako jsou mobily, tablety, domácí routery, bezdrátová sluchátka atd. se napájí napětím 5 nebo 12 V. Má to důvody dílem historické, dílem technické. Notebooky ze zpravidla napájejí napětím 19 nebo 20 V,  protože je třeba přenést větší výkon. Běžný notebook potřebuje dodat třeba 60 W a je technicky jednodušší mu je poslat jako 20 V, 3 A než jako 5 V, 12 A.

## Sugestivní zatáčka ke kapacitě baterií

Dnes je spousta spotřebičů napájena bateriemi nebo akumulátory a jejich kapacita se typicky uvádí v ampérhodinách (Ah) nebo miliampérhodinách (mAh). Například na mé powerbance je napsáno, že má kapacitu 10000 mAh (což je 10 Ah, ale obvykle se to píše v tisícinách, protože je to větší číslo a marketingově to působí lépe).

Co to znamená? Že obsahuje dostatek energie na to, aby mohla při svém konstrukčním napětí (např. 5 V) dodávat proud 10 A po dobu 1 hodiny. Nebo proud 1 A po dobu 10 hodin. Nebo 0,1 A (100 mA) po dobu 100 hodin atd. Samozřejmě teoreticky, jsou tam jisté ztráty a běžná powerbanka není schopna dodávat 10 A, to je na ni příliš silný proud, ale to nás v tomto okamžiku nezajímá.

Jenomže akumulátory je třeba i nabíjet. Což typicky chceme udělat co nejrychleji, ale bohužel tady jsou různá fyzikální omezení nabíjecích proudů atd., což také bude důležité později.

## Jak je to s napájecími adaptéry

Určitě máte doma spoustu napájecích adaptérů. Když se na ně podíváte, zpravidla na nich najdete výše uvedené údaje: proud a napětí (někdy výkon a napětí, ale to umíme přepočítat). Stejně tak na zařízení samotném (nebo v jeho dokumentaci) by mělo být napsané napájecí napětí a maximální proud, který vyžaduje.

Napětí využívané zařízením je totiž konstantní, ale proud se mění, podle toho co zařízení zrovna dělá. Proud, který ze svého akumulátoru odebírá váš mobilní telefon, bude výrazně nižší ve chvíli, kdy jen tak leží na stole a občas si pinkne se sítí a jinak nic nedělá, než když aktivně telefonujete, případně děláte něco náročného na procesor nebo máte zapnuté silné podsvícení displeje. Proto je tak těžké určit, jak dlouho bude zařízení fungovat na baterii: záleží na tom, co s ním děláte. Proto se třeba u mobilů udává kapacita v hodinách standby režimu a v hodinách hovoru. Skutečná vydrž bude někde mezi.

Co to pro nás znamená? Pokud sedí fyzický konektor a jeho zapojení, můžete jakékoliv zařízení napájet jakýmkoliv zdrojem, který dává stejné napětí a stejný nebo vyšší proud.

* Pokud bude mít zdroj menší napětí, nebude zařízení fungovat a nic se nestane.
* Pokud bude mít zdroj větší napětí, může při připojení zařízení zničit. Většina zařízení má nějakou formu ochrany, ale spoléhat se na to nedá.
* Pokud je schopen zdroj dodávat větší proud, než zařízení potřebuje, nic se neděje -- zařízení si vezme, kolik potřebuje.
* Pokud zařízení potřebuje větší proud, než kolik je ochoten zdroj dodat, může se to chovat různě. Zařízení může normálně fungovat (protože ho třeba používáte způsobem, který nezpůsobí maximální odběr), ale může se třeba náhodně restartovat, protože ve chvíli, kdy se pokusí získat potřebný proud se zdroj pro přetížení vypne. Nebo může dělat chyby atd.

## Jak to bylo

Historicky se zařízení dodávala se svým vlastním napájecím adaptérem pevně napojeným kabelem a konektorem, který se zapojil do zařízení. Jeho provedení záviselo na fantazii a schopnostech výrobce, nicméně naprostá většina zařízení používala několik málo napájecích konektorů.

Nejobvyklejší jsou souosé konektory podle normy IEC 60130-10. Hlavním problémem je jejich zaměnitelnost.

Dva nejrozšířenější standardy mají vnější průměr 5,5 mm a vnitřní buďto 2,1 mm nebo 2,5 mm. Aby toho nebylo málo, existuje i druhá dvojice s vnějším průměrem 6,0 mm a vnitřním opět 2,1/2,5 mm, ale ta se používá dost vzácně. Potíž je, že velikostní rozdíl půl milimetru prostým okem nepoznáte. Takže má-li zařízení zásuvku 5,5/2,5, konektor s vnitřním průměrem 2,1 tam nezasunete, i když to opticky odpovídá. Pokud je to opačně, tedy zásuvka s vnitřním průměrem 2,1 a zástrčka 2,5 mm, tak sice zasunete, ale nemusí to fungovat nebo ne spolehlivě, protože nemusí být dobrý kontakt.

Navíc není žádný vztah mezi typem/rozměrem konektoru a elektrickými veličinami. Konektory podle této normy jsou určeny pro napětí do 36 V a to je všechno. Takže je možné snadno zapojit 12 V zdroj do 5 V zařízení a zničit ho, pokud nemá ochranu proti přepětí.

U notebooků byla situace ještě divočejší. Někteří výrobci, zejména ti levnější, používali standardizované konektory, ale jiní výrobci (notoricky zejména Lenovo a Dell) měli svoje vlastní, nekompatibilní se zbytkem světa, ale občas i mezi jednotlivými modely téhož výrobce. Přitom většina zdrojů měla podobné elektrické parametry. Asi nejvíc na tom prosperovali výrobci univerzálních napájecích zdrojů, s nimiž se dodávala sbírka výměnných konektorů pro různé značky a typy notebooků.

## Universal Serial Bus: data, ne napájení

Práce na standardu USB začaly před třiceti lety, v roce 1995. Nebyl určen k tomu, aby se přes něj zařízení primárně napájela. První verze nabízela napájení 5 V a 500 mA, tedy 2,5 W. Dost na připojení klávesnice, myši a podobných jednoduchých zařízení, ale předpokládalo se, že USB bude sloužit ke komunikaci, nikoliv k napájení a že náročnější zařízení budou mít dva konektory, datový a napájecí.

Jenomže se ukázalo, že mít dva kabely je otrava, takže se s přibývajícími verzemi USB zvyšovala i přijatelná zátěž, nejprve na 7,5 W (1,5 A) u USB 2.0 a 3.0 a později na rovných 15 W (3 A) u USB-C bez Power Delivery.

To vše běželo vesměs na MiniUSB a později MicroUSB konektorech a ještě později na USB-C konektoru. Jedním z důvodů dobrovolné adopce bylo i to, že zařízení se zmenšují a zplošťují a MicroUSB i USB-C konektory jsou velmi tenké, což se o klasických souosých napájecích konektorech říct nedá. V zásadě jste si mohli být jisti napětím (vždy 5 V) a po vyhynutí první generace USB proudem, že dostanete svých 1,5 A. Což vedlo k obrovské explozi nabíječek a zařízení s tím či oním USB konektorem.

## Power delivery

Jenomže pak přišly výkonnější mobily s větší kapacitou baterií a pro jejich nabíjení bylo třeba vyššího výkonu, aby to netrvalo moc dlouho. Takže se objevily různé vzájemně nekompatibilní technologie různých výrobců, kdy se telefon uměl domluvit se "svojí" nabíječkou a ta mu dokázala poslat větší výkon, zpravidla pomocí vyššího napětí (jak již bylo řečeno, je jednodušší zvýšit napětí než proud).

Aby se to nějak ustálilo, vznikl v roce 2014 standard USB Power Delivery (USB PD). Ten umožňuje zařízení a zdroji, aby se mezi sebou domluvili na tom, jaké napájecí napětí (5, 9, 12 nebo 20 V) chtějí dodávat a to při proudu až 5 A. Maximální výkon je tedy 100 W a to je pro drobnou techniku docela dost.

Nejnovější verze USB PD EPR (Extended Power Range) umožňuje zvýšit napětí i na 36 nebo 48 V, takže lze přenést výkon až 240 W. To vše pomocí USB-C kabelu a konektoru.

To je super, ne? Jediný konektor, pomocí kterého lze napájet skoro všechno, snad kromě pračky a ledničky. 

Akorát že vůbec.

Ne každý zdroj musí podporovat Power Delivery a i pokud podporuje, nemusí podporovat zrovna ty parametry, které si vaše zařízení vysnilo. Vždycky by vám podle standardu měl dát alespoň 5 V, 1,5 A, ale tím notebook nenabijete a dnešní mobily sice ano, ale pomalu. Takže nabíječkou od notebooku mobil nabijete, ale opačně to fungovat nebude. Pokud výrobce se zařízením nabíječku dodá, dodá ji tak, aby nabila jeho zařízení, ale výkonnější ji zbytečně dělat nebude, protože je to drahé.

Navíc ne každé zařízení, které se přes USB-C konektor napájí, standardy dodržuje. Tradičním zdrojem problémů jsou třeba novější verze Raspberry Pi. Třeba aktuální verze RPi 5 se sice napájí přes USB-C konektor, ale chce zdroj, který při pěti voltech dodá 5 A, což je docela dost a většina běžných zdrojů to nepodporuje. Ne při pěti voltech a Raspberry Pi nepodporuje Power Delivery. Takže chcete-li u něj zajistit spolehlivou funkčnost, s univerzálním zdrojem si nevystačíte, i když má USB-C konektor.

## Není kabel jako kabel

Nejnovější regulace ještě navíc vyžaduje, aby kabel nebyl ke zdroji připojen napevno, ale aby zdroj měl zásuvku a propojoval se se zařízením pomocí USB-C na USB-C kabelu. Což je další zdroj problémů, jakkoliv i tato cesta do pekel byla dlážděna dobrými úmysly. Výměnný kabel je dobrý, protože při jeho poškození stačí vyměnit kabel a nemusí se vyhazovat celé zařízení. Navíc si můžete vybrat i délku, která vyhovuje vašim potřebám. Jenomže bohužel, není kabel jako kabel.

Pro klasické napájení vám stačí dva dráty, nebo správně řečeno vodiče: plus a mínus. USB má signálů více. U nižších verzí ještě D+ a D-, novější verze přidávají ještě další. Jenomže váš kabel je nemusí mít zapojené. Už v dobách MicroUSB se začaly objevovat problémy s tím, že někteří výrobci v rámci fiskální optimalizace businessu dodávali pouze dvoužilové kabely, které sice stačily pro napájení, ale už ne pro datovou komunikaci. Totéž se dá říct o USB-C kabelech.

I když máte všechny vodiče které potřebujete, ještě nemáte vyhráno. Možná jsou příliš tenké. On totiž po kabelu může téct jenom určitý proud, než kabel přestane stíhat a začne se zahřívat. Kolik toho zvládne přenést, to záleží na jeho materiálu a průřezu. Typicky se používá měď, ale zdá se, že výrobci jsou začasté potomky Ea-nāṣira, proslulého tím, že mu coby dodavateli nekvalitní mědi byla adresována nejstarší známá písemná stížnost (v sumerštině, psaná klínovým písmem na hliněné tabulce). A navíc, protože měď je drahá, se jí šetří. Takže mnohé honosně vypadající kabely jsou ve skutečnosti tenoučké jako tři zlaté vlasy děda Shenzena. Pokud bychom přes ně zkusili přenést vyšší proud, začaly by se nadměrně zahřívat a mohlo by v extrémním případě dojít třeba až k požáru.

Takže USB-C kabel je víc než jenom pár drátů. Má-li podporovat vyšší power delivery standardy, musí obsahovat speciální čip, který zdroji a zařízení řekne, na jaké parametry je kabel stavěný. A zdroj na základě toho pošle příslušné napětí a proud. Tak by nemělo dojít k přetížení vodičů.

Jenomže znáte to: čipy jsou drahé, takže někde chybí, jinde lžou a povolí větší proud v naději, že se to nějak zvládne a vodič se zahřeje jenom trochu...

## ...a dopadlo to jako vždycky

Temná zaostalost minulých let spočívala v tom, že jste se zařízením dostali nabíječku s odpovídajícím konektorem a kabelem a mohli jste si být jisti, že tato sestava bude fungovat. Byla to otrava v tom, že zdroje mezi sebou byly někdy nahraditelné, někdy ne a že nevyhnutelnou součástí dospělosti je mít krabici (v mém případě celý regál krabic) zdrojů, které přežily své zařízení. Co kdyby se někdy hodily?

Jak vypadá nová, zářivá budoucnost? Se spoustou zařízení zdroj nedostanete vůbec. Někde to vadí méně, někde více -- podle toho, jak velkou a dobře zásobenou krabici se zdroji již máte. Musíte si tedy koupit správný zdroj, což nemusí být úplně laciná záležitost. Kvalitní zdroj s několika výstupy, u kterého si můžete být jisti, že skutečně poctivě podporuje 100 W Power Delivery a zvládne třeba současně nabíjet notebook a mobil, vyjde klidně na více než dva tisíce.

Potřebujete i správný kabel, který také nemusí být laciný. Slušný metrový kabel s podporou 100 W a nejnovějších standardů může stát i pět stovek.

Navíc to všechno vypadá stejně a bez speciálního vybavení nepoznáte, co který kabel a který zdroj zvládne a na prohlášení prodejce se moc spoléhat nedá, zejména ne u těch levnějších. Součástí evropské regulace má být i povinné značení, ale znáte to: papír a sítotisk snese všechno. Ani renomovanější značka nemusí být zárukou kvality, protože stejně všechno vyrábí nějaký OEM v Číně a ti jsou známí tím, že kvalitu v čase postupně snižují a zkoušejí co jim projde ve vztahu k objednatelově kontrole kvality.

Stávající řešení bylo sice mírně nepohodlné, protože v případě náhrady originálního zdroje bylo nutné pohledem zkontrolovat, zda má správné elektrické parametry a vyzkoušet, zda má kompatibilní konektor. 

Nově je celá věc mnohem víc vzrušující: zdroj nedostanete vůbec a budete muset zjistit, zda tato konkrétní kombinace zdroje, zařízení a kabelu dává požadované výsledky. To vše nejspíše metodou pokus-omyl, protože tester parametrů USB-C zdrojů a kabelů nejspíš doma nemáte. Takže nezbude, než si v praxi pocvičit úlohy z kombinatoriky: máme li _a_ zdrojů, _b_ kabelů a _c_ zařízení, kolik možných kombinací tato sestava dává?

Speciálně u mobilů, tabletů a jiných nabíjených zařízení s vyšším výkonem pak platí, že i pokud se toto začne nabíjet, bude nutné zjistit, zda optimálním výkonem, jestli se třeba nenabíjí jenom 5 V, 1,5 A, což zabere mnoho hodin.

Situace má značný potenciál i z hlediska kybernetické bezpečnosti. Pokud není zařízení úplně hloupé a přes USB-C port kromě nabíjení i komunikuje, může na něj zloduch touto cestou zaútočit. Malý počítač se škodlivým kódem, který se dokáže dostat do vašeho mobilu nebo počítače se může skrývat v nabíječce ale i kabelu. To není teoretický koncept, ale každodenní realita O.MG cable je nevinně vypadající USB-C kabel, který v sobě má malý počítač, pomocí kterého lze dělat celou řadu zajímavých a vzrušujících útoků. Nebezpečí nedůvěryhodných, veřejných nabíječek je obecně známé a v současnosti se mu lze bránit pomocí "USB kondomů", což je jednoduchá a levná redukce, která zabrání datové komunikaci. Dosáhnout stejného efektu u Power Delivery nebude tak jednoduché a odpovídající zařízení bude muset být mnohem komplikovanější. Povinné zavedení USB-C napájení přitom rozšíří možnosti tohoto druhu útoku.

Inu, chtěli to udělat co nejlíp a dopadlo to jako vždycky.