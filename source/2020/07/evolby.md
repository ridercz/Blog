<!-- dcterms:title = Lesk a bída elektronických voleb -->
<!-- dcterms:abstract = Obsáhlý článek o elektronických volbách jsme s Vladimírem Smejkalem a Jindřichem Kodlem napsali před devíti lety, vyšel v DSM v roce 2011. Ačkoliv se od té doby dost změnilo, myšlenky v něm vyjádřené jsou platné stále. Vzhledem k tomu, že se nyní začíná o elektronizaci voleb znovu mluvit, se souhlasem spoluautorů jej (v původní podobě) vydávám znovu. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:creator = Vladimír Smejkal -->
<!-- dcterms:creator = Jindřich Kodl -->
<!-- x4w:coverUrl = /cover-pictures/20200723-evolby.jpg -->
<!-- x4w:coverCredits = @ajaegers via Unsplash.com -->
<!-- x4w:pictureUrl = /perex-pictures/20200723-evolby.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = IT -->
<!-- x4w:category = Bezpečnost -->
<!-- x4w:category = Politika -->
<!-- dcterms:date = 2020-07-23 -->

> Obsáhlý článek o elektronických volbách jsme s Vladimírem Smejkalem a Jindřichem Kodlem napsali před devíti lety, vyšel v DSM v roce 2011. Ačkoliv se od té doby dost změnilo, myšlenky v něm vyjádřené jsou platné stále. Vzhledem k tomu, že se nyní začíná o elektronizaci voleb znovu mluvit, se souhlasem spoluautorů jej (v původní podobě) vydávám znovu.

Elektronické volby jsou téma poměrně hojně skloňované skoro po celém světě. I do české kotliny již dorazily -- zatím nesmělé -- úvahy o elektronizaci orgií demokracie. Pojďme přispět k počínající diskusi několika optimistickými a několika chmurnými vyhlídkami.

Předtím ale musíme zodpovědt několik základních dotazů, abychom vykolíkovali prostor, v němž se budou naše úvahy pohybovat. Zásadní otázky jsou:

* Co si vlastně představujeme pod pojmem „elektronické volby"?

* Čeho chceme jejich zavedením vlastně dosáhnout?

* Jaké vlastnosti by měl systém pro elektronické volby mít?

Teprve dosáhneme-li alespoň rámcové shody ve shora uvedených otázkách, můžeme pozornost obrátit k prostředkům, jimiž lze elektronické volby (dále také jen e-volby) realizovat.

V závěru se pak budeme věnovat současné situaci v ČR, kde pro e-volby platí nyní klasický stav „jeden krok vpřed, dva kroky vzad".

## Současný stav

### Jak se volí dnes v České republice

Pro začátek nezaškodí si připomenout, jak se volí v České republice dnes. Budeme uvažovat volby do Poslanecké sněmovny,[^1] nicméně zde uvedené platí přiměřeně i pro všechny ostatní typy voleb, které se u nás konají.

#### Seznamy voličů

Základem všeho jsou seznamy voličů. Každý volič je zapsán v seznamu voličů podle svého trvalého bydliště, tak jak je zapsáno v informačním systému evidence obyvatel. Zvláštní volební seznamy vedou též zastupitelské úřady. Nemá-li volič nikde trvalé bydliště, má sice volební právo (pro účely voleb do PSP), ale nemá jak jej realizovat, protože není a nemůže být nikde zapsán do seznamu voličů -- na tento případ zákonodárce zapomněl, což první z autorů tohoto textu otestoval na vlastní kůži.

Ministerstvo vnitra považuje distribuci aktuálních volebních seznmů za jednu z klíčových otázek voleb. Zdá se tedy, že on-line seznam voličů by byl tím nejlepším řešením. Podle tvrzení MV ČR ale je problémem zajistit připojení k Internetu pro všech cca 7 000 volebních místností, jakkoliv se to autorům zdá v dnešní době neuvěřitelné.

Volič může bez dalšího volit pouze v jediné volební místnosti, stanovené podle jeho bydliště. Zde má volební komise vytištěnou příslušnou část seznamu a fyzicky si na něm odškrtává, kdo již odvolil.

#### Voličské průkazy

Hodlá-li volič hlasovat jinde, než v jemu přidělené volební místnosti, musí si s předstihem zažádat o voličský průkaz. Učiní-li tak, je (pro dané volby) vyškrtnut ze seznamu voličů a je mu vydán tištěný (listinný) voličský průkaz. S ním může hlasovat ve kterékoliv volební místnosti, přičemž je zapsán do tamního seznamu voličů na místě a průkaz je mu odebrán, takže nemůže hlasovat dvakrát.

Voličské průkazy jsou pozoruhodně slabým místem současné implementace voleb. V první řadě není nijak ošetřeno, jakým způsobem mají být voliči zaslány. Podle naší zkušenosti úřady obvykle používají obyčejnou listovní zásilku, u níž doručení nelze zajistit, vysledovat ani prokázat. Vzhledem k tomu, že za voličské průkazy se nevystavuje náhrada, může být občan o možnost volit připraven velmi snadno. Ve druhé řadě je voličský průkaz papírový dokument, který neobsahuje žádné ochranné prvky. Je tedy velmi snadno padělatelný. Doposud ale žádná aféra spojená s paděláním voličských průkazů nebyla zveřejněna.

#### Vlastní hlasování

Poté, co byl uživatel autorizován volební komisí na základě občanského průkazu a seznamu voličů nebo voličského průkazu, odebere se za plentu, kde vybere a patřičným způsobem označí hlasovací lístek a vhodí jej do urny.

Konkrétní hlas (obálku s papírovým lístkem) není možné spojit s konkrétním voličem. Lépe řečeno: teoreticky to možné je (kdyby člen volební komise obálku nějak neznatelně označil a při vyhodnocení ji našel), ale vzhledem k rozdělení práce v komisi je to prakticky nerealizovatelné. Tato anonymizace voleb je jedním z hlavních principů demokratických voleb a lpění na ni vytváří jednu ze základních premis pro hlasování elektronické.

I v elektronickém světě je však nutné řešit „omezenou anonymitu", tj. musíme mít možnost zpětné kontroly, např. že se uživatel chová řádně, v souladu s interní politikou a/nebo právními předpisy. U normálních voleb na proces dohlížejí volební komise, jakkoliv jejich faktická možnost on-line kontroly končí s přeměnou hlasů z listin na elektronické záznamy. Klíčová úloha volebních lístků a procesu odehrávajícího se ve volebních místnostech tkví tedy jednak ve vlastním dozorování průběhu hlasování a dále v možnosti zpětné kontroly sečtených hlasů. Proto zpětná kontrola u e-voleb je také nutná, což vede ke specifickému řešení na bázi kontrolovatelné anonymity.

#### Sčítání hlasů ve volebních místnostech

Po ukončení hlasování členové volební komise urnu otevřou a ručně spočítají jednotlivé hlasy. Nutno říci, že toto počítání v případě složitějších voleb -- typicky třeba v městě Praze -- je poměrně složité a lze předpokládat, že nikoliv zcela bezchybné. Souhrnné hodnoty potom hlásí nadřízené volební komisi, přičemž celý proces končí u Ústřední volební komise na celorepublikové úrovni, resp. u subjektu, který zpracování voleb provádí, jímž je Český statistický úřad.

Hlášení v současné době probíhá dvojí cestou. Data se předávají v elektronické podobě jako datový soubor a zároveň jako zpráva v listinné podobě, kterou členové volební komise podepíší. Dílčí výsledky jsou potom průběžně zveřejňovány podle toho, kdy na ČSÚ dorazí.

Hlasy jsou posléze na vyšších úrovních sečteny a přepočítány na mandáty. Tento proces je sice také pozoruhodný[^2], ale z hlediska vlastní elektronizace voleb je nepříliš podstatný.

### Elektronizace voleb v České republice 

V ČR dosud nebyly v elektronizaci vlastního hlasování provedeny žádné kroky, nepočítáme-li přípravná jednání mezi MV ČR a ČSÚ, jichž se účastnil i druhý autor tohoto článku. Výstupem bylo memorandum o spolupráci mezi Českým statistickým úřadem a Ministerstvem vnitra ČR při přípravě koncepce, řešení, testování a realizaci systému elektronických voleb v České republice z dubna 2008, které obsahovalo následující body:

* Systém elektronických voleb (dále e-voleb) přitom bude fungovat jako alternativa ke klasickému hlasování založeném na osobním odevzdání papírového hlasovacího lístku ve volební místnosti.

* Cílovým nástrojem pro řešení způsobu, jakým systém e-voleb ověří jedinečnou a nezaměnitelnou identitu voliče a zamezí dvojímu hlasování, bude využití elektronického identifikačního dokladu (elektronický občanský průkaz).

* Nutnou podmínkou zavedení systému e-voleb je vybudování centrálního Registru voličů s návazností na Základní registr obyvatel.

* Další základní podmínkou je zajištění vysokého zabezpečení systému e-voleb tak, aby byla zaručena tajnost hlasování a ochrana systému před zásahy zvenčí i zevnitř.

Obě státní instituce se shodly na tom, že bude nutno realizovat komplexní pilotní projekt, jehož výsledky, společně se zkušenostmi z obdobných projektů ze zahraničí, umožní zodpovědně připravit cílový koncept řešení e-voleb v České republice a jeho produkční nasazení. Bohužel, po pádu Topolánkovy vlády a nástupu vlády úřednické premiéra Fischera, jakkoliv byl tento v době předcházející aktivním účastníkem přípravy e-voleb, šly e-volby „k ledu" a doposud se z něj neprobudily.

### Elektronizace voleb v zahraničí

Státy světa lze ve vztahu k elektronickým volbám rozdělit na čtyři základní skupiny[^3]:

* **Země, ve kterých se používají hlasovací stroje:** Austrálie, Brazílie, Francie, Indie, Japonsko, Kanada, Kazachstán, Peru, Rusko, SAE, USA, Venezuela.

* **Země, ve kterých je možno hlasovat přes Internet:** Estonsko, Francie, Kanada, Švýcarsko. S výjimkou Estonska jsou ale na internetové volby kladena různá omezení. V Kanadě a Švýcarsku se takto dá hlasovat jenom v místních volbách. Ve Francii mohou na dálku volit pouze Francouzi žijící v zahraničí, a to pouze do speciálního orgánu[^4], který je reprezentuje.

* **Země, které projekty elektronických voleb zastavily:** Irsko, Německo, Nizozemí, UK.

* **Země, ve kterých proběhly pilotní projekty, plánování atd.** Těchto zemí je nejvíce[^5], ale jsou nejhůře definovatelné.

Například ve Finsku, které ACE Project řadí do této skupiny, proběhlo v roce 2008 testování v rámci třech volebních okrsků. Tamní nejvyšší správní soud pro chybně započítané hlasy nařídil ve všech třech okrscích volby opakovat[^6], přesto ovšem finské ministerstvo spravedlnosti pokládá experiment za úspěšný[^7]. Do stejné skupiny ovšem ACE Projekt řadí i Českou republiku, kde jsou elektronické volby pouze ve fázi vágních prohlášení -- viz výše.

## Co si vlastně představujeme pod pojmem „elektronické volby"?

Elektronické volby, to je pojem, vykazující takřka marketingové kvality. Ale co se pod ním vlastně skrývá?

Základní rozdíl mezi procesem u e-volby a klasickým způsobem volby je zejména ověření identity voliče a jeho oprávnění volit, kdy při e-volbách je nutno tuto identitu ověřit vzdáleně. Dálší otázkou, podobně jako v případě elektronického bankovnictví, na kterou je třeba odpovědět, je zajištění bezpečnosti, a to jak na úrovni komunikace, tak i v koncových stanicích. Zde je třeba podotknout, že „bezpečnost je nepřítelem uživatelské jednoduchosti". Samostatnou kapitolou je důvěryhodnost informačního systému, ve kterém se zpracovávají „volební lístky". To je ale již úkol pro podpůrné služby a vlastního procesu volení se až tak bezprostředně netýká, resp. nedotýká se procesu ve vztahu k voličům.

Základními atributy, které návrh systému e-voleb musí zvažovat a respektovat je deset bodů formulovaných N. Voutsisem a F. Zimmermanem.[^8] Uvedené požadavky jsou také zmíněny či rozpracovány ve většině rozvah o e-volbách:

1.  Volit smí pouze oprávněný volič
2.  Každý volič disponuje jedním a pouze jedním hlasem. *Není možné, aby např. někdo z rodiny vybral přístupové prostředky od ostatních členů a odvolil sám.*
3.  Každý volič musí být chráněn proti zneužití identity.
4.  Do doby sčítání hlasů je odevzdaný hlas voliče tajný a nesmí být znám.
5.  Volby jsou tajné. Nelze propojit voliče s jeho „lístkem".
6.  Musí být zajištěna evidence, že daný volič odvolil či nikoliv.
7.  Sčítání hlasů musí být auditovatelné.
8.  Proces volby musí být odolný vůči chybám náhodným i vůči aktivním útokům s cílem modifikovat nebo duplikovat výsledek volby. Tyto útoky musí být detekovatelné.
9.  Volební hlasy musí být platné jen v rámci vymezeného času.
10. Volební systém musí být odolný vůči útokům v komunikačním prostředí. Závažný může útok typu DoS (Denial of Service) a jiné útoky paralyzující službu systému).

Proces voleb lze rozdělit do třech fází:

1.  **Autorizace potenciálního voliče** -- zjišťujeme, zda je předmětné individuum oprávněno volit. Tedy zejména zda má volební právo a zda ho již v aktuálních volbách nevyužilo. Tradičně je v současnosti spojena i s autentizací, tedy ověřením totožnosti, ale to teoreticky není podmínkou. Autentizace je „nutné zlo" vyplývající ze současné implementace, není sama o sobě nutná a ani žádoucí, neboť hlasování má být anonymní. Jinými slovy, budeme-li umět provést autorizaci bez autentizace, není to na překážku, zatímco opačně ano.
2.  **Vlastní hlasování** -- autorizované individuum vyjádří svou vůli výběrem z několika možností. Pro účely elektronizace voleb není příliš podstatné, jaké konkrétně ty možnosti jsou, kolik jich je, jak fungují preferenční hlasy... atd.
3.  **Vyhodnocení výsledků** -- statistické zpracování odevzdaných hlasů, tedy agregace jednotlivých hlasování, z níž lze pak vyvodit jakési důsledky. Z hlediska e-voleb není podstatné, jaký je algoritmus přidělování mandátů, ale jak, tj. kde a s jakou důvěryhodností, resp. možní přezkumu vyhodnocení proběhne.

Jednotlivé fáze lze automatizovat a převádět do elektronické podoby v zásadě nezávisle na sobě a záleží na osobním vkusu laskavého čtenáře, od jaké míry elektronizace si volby zaslouží být označeny za „elektronické". Začneme z praktických důvodů od konce.

### Elektronizace vyhodnocení volebních výsledků

Tato fáze je ve většině zemí našeho civilizačního okruhu již automatizována a ČR není výjimkou. Jak již bylo řečeno, okrskové volební komise výsledky voleb předávají ve formě datového souboru a další zpracování pak probíhá elektronicky.

Technicky se jedná o úkol sice netriviální, ale také nijak zvlášť komplikovaný, který lze řešit bez větších obtíží běžně používanými technikami. Není také zpravidla zpochybňován a je široce akceptován.

Podstatné je, že součet hlasů na úrovni konkrétního okrsku je prováděn lidmi (volební komisí) a je velmi snadno zkontrolovatelný. Manipulacím je možné zabránit, resp. je možné je snadno odhalit a prokázat. Principem nezpochybnitelnosti voleb je možnost kdykoliv hlasy v listinném provedení přepočítat. Možná proto se v tomto smyslu nevyskytly nikdy žádné reklamace tvrdící, že vlastní zpracování bylo chybně spočítáno.

### Elektronizace vlastního hlasování

Dále pak lze elektronizovat vlastní proces odevzdání hlasu. V logisticky nejjednodušší podobě lze autorizaci uživatele provádět fyzickými prostředky a jenom hlasování probíhá pomocí nějakého více či méně sofistikovaného hlasovacího zařízení. Pokročilejší implementace si může klást za cíl i autorizaci uživatele provádět automaticky, ať už ve volební místnosti, nebo mimo ni.

Volební stroje (Electronic Voting Machines, EVM) se v různých zemích[^9] používají, a to se smíšenými reakcemi, řadou problémů a rizik, která budou rozvedena dále.

### Elektronizace autorizace voličů

Dalším úkonem, který je možné provádět elektronicky, je ověření oprávněnosti dané osoby volit. Má-li být prováděno plně automaticky, musejí být voliči vybaveni elektronickými průkazy totožnosti. Pokud takové průkazy existují, je autorizace sama o sobě relativně jednoduchá.

U nás zatím v této oblasti nebyly provedeny žádné kroky. Dá se nicméně očekávat, že bude-li někdy v budoucnu skutečně realizován projekt elektronických občanských průkazů, bude je možné využít i při volbách.[^10] Nebudeme-li moci počítat s elektronickými OP, pak bude třeba zajistit nějaký nástroj pro jednorázovou (volební) autorizaci. Vzhledem k dočasnosti certifikátů je třeba u voleb uvažovat s e-volebním lístkem anebo s kontrolou „platnosti" e-OP (při té pak zjistíme stav u certifikátů apod.); otázkou je složitost tohoto procesu pro voliče i systém.

Samy o sobě jsou jednotlivé kroky relativně snadné, byť nesou, zejména při elektronizaci hlasování, značná rizika. Složitost úkolu je nicméně vyšší hned o několik řádů ve chvíli, kdy je třeba je mezi sebou kombinovat, zejména autorizaci a vlastní provedení volby při zachování anonymity hlasujícího.

## Základní typy e-voleb

Fakticky existují dvě cesty, jimiž se státy vydávají při elektronizaci voleb:

* Elektronické hlasování ve volebních místnostech pomocí hlasovacích strojů.
* Elektronické hlasování na dálku (přes Internet, telefon nebo podobným způsobem).

### Použití hlasovacích strojů

Použití hlasovacích strojů je běžnější, ale prakticky všude, kde bylo nasazeno, se střetlo s protesty a na většině běžně používaných hlasovacích strojů byly objeveny závažné nedostatky a prakticky realizovány nejrůznější útoky. Reakce na tato odhalení jsou různé.

V Nizozemí se používaly hlasovací stroje místního výrobce Nedap. Bezpečnostní analýza tohoto stroje[^11] ukázala, že je možné celkem snadno realizovat prakticky všechny myslitelné typy útoků na proces voleb: změnit jejich výsledky, zjistit jak kdo hlasoval (a to i na dálku) a dokonce nahrát do stroje vlastní firmware a přimět ho, aby hrál šachy (i když v tomto autoři přiznávají mírné selhání, protože použité šachové algoritmy nejsou příliš dobré).

Mimo jiné na základě této analýzy byla v Nizozemí (domovské zemi Nedapu) idea volebních strojů v roce 2007 opuštěna a oznámen návrat k papírové podobě voleb[^12]. Irsko testovalo použití hlasovacích strojů Nedap, ale na základě výsledků testování byl nakonec celý projekt zrušen[^13]. V Německu bylo použití těchto hlasovacích strojů prohlášeno za neústavní tamním Ústavním soudem[^14]. Nedap nicméně své stroje dodává i do dalších zemí[^15], kde je jejich osud nejasný.

Zcela opačný přístup zvolila Indie. Používá vlastní model hlasovacího stroje, který má ovšem také velké množství bezpečnostních nedostatků a je možné na něj zaútočit mnoha způsoby[^16]. Nicméně indické úřady problém nehodlají nijak řešit. Místo toho zadržely autory studie[^17] a obvinili je ze spiknutí s cílem stát destabilizovat[^18].

Pro voliče v ČR může být ve světle těchto zpráv velmi uklidňující, že není známo, že by se kdy uvažovalo o zavedení hlasovacích strojů v České republice.

### Hlasování na dálku

Dalším stupněm je „vzdálené elektronické hlasování (remote e-voting)", tj. elektronické hlasování, při kterém se odevzdání hlasu uskutečňuje pomocí zařízení, na které nedohlíží volební orgán ve volební místnosti, ale koná se na dálku, distančně (přes Internet, pomocí SMS zprávy nebo hlasovou volbou).

Jak již bylo řečeno, jedinou zemí, která tento typ voleb na dálku uvedla v život, je Estonsko. O těchto volbách bylo napsáno již mnoho, proto laskavého čtenáře se zájmy o detaily odkazujeme na publikovanou literaturu[^19].

Je to také tento typ voleb, o jehož zavedení se -- byť pouze ve velmi nejasných obrysech -- uvažuje i v České republice. Budeme-li se tedy nadále zabývat systémem elektronických voleb, budeme tím rozumět právě toto vzdálené hlasování.

## Jaké jsou cíle zavedení elektronických voleb?

Chceme-li zavádět elektronické volby, musíme v první řadě určit cíle, kterých tím chceme dosáhnout. Následně se pak musíme zamyslet nad tím, zda elektronizace některých nebo všech částí volebního procesu může skutečně napomoci dosažení těchto cílů.

### Zvýšení účasti ve volbách

Největší popularitě se mezi českými voliči těší volby do Poslanecké sněmovny, a i u nich volebí účast setrvale klesá[^20], přičemž posledních voleb se zúčastnilo 62,6 % oprávněných voličů. Oněch zbylých 37,4 % představuje větší množství občanů, než kolik kdy volilo vítěze voleb[^21].

Cílem elektronického hlasování tedy může být zvýšení volební účasti, například:

* zjednodušením volebních úkonů,
* zpřístupněním voleb těm, kdo fyzicky volit nemohou (voliči v zahraničí, v nemocnicích...),
* zvýšení přitažlivostí voleb pro ty, kdo by jinak nevolili (mladí lidé, IT specialisté...).

Může elektronizace voleb tyto předpoklady splnit? Podle názoru prvního z autorů nikoliv, rozhodně nikoliv podstatně, protože pro drtivou většinu voličů budou úkony nutné k uplatnění volebního práva elektronicky mnohem náročnější, než dojít do nejbližší volební místnosti.

Ostatní autoři jsou názoru, že rozhodující u nového systému je rychlost provedení volby a zvýšení pohodlí voliče. Zvýšení pohodlí není spojeno se snížením složitosti. Většina uživatelů se naučila používat palce při rychlosti 300 úderů za minutu u mobilů a sofistikované prolézáni při vyhledávání tamtéž. Ovládání mobilů je složitější než např. PC, ale výsledky jsou rychle a pohodlně dosažitelné. A především -- e-volby by měly přilákat ty voliče, kteří se nejsou ochotni zvednout od svého počítače ani při zajišťování základních životních potřeb.

Pro srovnání: přiznání k některým daním lze již delší dobu podávat elektronicky. Podle údajů poskytnutých ministerstvem financí[^22] bylo tímto způsobem podáno pouze 2,94 % daňových přiznání. Z nich ovšem drtivou většinu (74 %) tvořila přiznání k DPH, tedy úkony prováděné převážně firmami a opakovaně. Fyzické osoby využily možnost podání daňových přiznání elektronicky jenom v 0,99 % případů. Lze argumentovat tím, že podání daňového přiznání elektronicky je složité a nákladné (poplatník musí zaplatit za kvalifikovaný certifikát). Elektronické volby by měly být bezplatné a jednodušší.

Podle ČSÚ má přístup k Internetu 56 % populace[^23], z nichž elektronické bankovnictví využívá[^24] 30 %. Celkem tedy elektronické bankovnictví využívá zhruba 17 % populace. Elektronické bankovnictví v tomto případě ale většinou představuje levnější a jednodušší alternativu, než jiné metody. Volby jsou zdarma, a zda bude proces elektronického hlasování jednodušší, než hlasování přímo ve volební místnosti, je velkou neznámou, nicméně toto by mělo být jedním ze základních, předem daných cílů.

Dá se tedy očekávat, že podíl elektronických hlasů bude někde mezi těmito hodnotami. Tomu odpovídá i estonská zkušenost, kdy v posledních volbách v roce 2009 možnost volit elektronicky využilo 9,5 % oprávněných voličů. Není ale známo, kolik z nich by jinak nevolilo vůbec.

Současný mechanismus voleb neumožňuje realizovat volební právo voličům, kteří se vyskytují mimo své bydliště neplánovaně -- např. byli převezeni do nemocnice mimo svůj volební okrsek a nestihli si zažádat o voličský průkaz, jakož i pro další, kdo si svoji nepřítomnost neuvědomili. Jim by elektronické volby mohly pomoci, pokud by ovšem byly realizovány tak, aby volič mohl volit elektronicky bez předchozí přípravy. Užitečný by mohl být bezkontaktní mechanismus voleb pro voliče v zahraničí, protože ti se musejí nyní osobně dostavit na zastupitelský úřad, což může představovat zejména v případě rozlehlejších zemí logistický problém[^25].

Kromě těch, kteří nejsou přítomni v místě voleb fyzicky, existuje řada lidí, kteří sice přítomni jsou, ale nezvládají se dostavit k volbám v daný čas. Výhodou e-voleb je nepřetržitě otevřená volební místnost. I pro tuto skupinu budou tedy přínosem.

### Zrychlení zpracování volebních výsledků

Ke zrychlení zpracování volebních výsledků nedojde, dokud budou současně probíhat „papírové" volby, které bude využívat většina voličů. Ke zrychlení sčítání hlasů by došlo, pokud by elektronicky volily řádově desítky procent populace, což se v dohledné době očekávat nedá.

Kromě toho, zpracování volebních výsledků při posledních volbách do Poslanecké sněmovy trvalo přibližně sedm hodin. Je otázkou, zda je při tomto čase další zrychlení zpracování podstatné.

### Úspora nákladů

K úspoře nákladů nedojde ze stejných důvodů, jako ve výše uvedeném případě: stávající náklady na „papírové volby" bude třeba zachovat v téměř nezměněné výši. Naopak dojde k navýšení nákladů o částky potřebné k realizaci elektronických voleb. A to i pomineme-li české národní specifikum, v rámci kterého většina megalomanských IT projektů státní správy zatím skončila obrovskými výdaji a diskutabilní funkčností.

Jiná je ovšem situace v momentu, kdy budou e-volby jedinou alternativou, což -- vzhledem k technologickému a demografickému vývoji jednou nastane. Řada našich úvah tedy směřuje spíše k tomuto okamžiku, nežli k současnosti. Plně elektronické volby mohou při dobré implementací být řádově daleko levnější, nežli stávající způsob.

### Odstranění nepřesností při ručním sčítání hlasů

Opět zde platí, že tato výhoda se projeví teprve ve chvíli, kdy bude elektronicky hlasovat podstatná část obyvatelstva.

### Návrhy pro budoucnost?

Splnění většiny shora uvedených cílů je podmíněné tím, aby elektronicky hlasovala podstatná část voličů, nejlépe pak všichni. Lze tedy argumentovat tím, že nějak se začít musí a že musíme být připraveni na budoucnost?

Podle názoru prvního z autorů je na to ještě příliš brzy. Elektronické hlasování zatím předbíhá svou dobu, a to natolik podstatně, že reálný náskok teď získat nemůžeme. Zásadní změnu v tomto ohledu nelze očekávat v horizontu let, ale spíše desítek let. A technologické zkušenosti ze současného stavu techniky nám v té době budou v zásadě k ničemu.

Druzí dva autoři jsou názoru opačného: je třeba začít a zkoušet, promýšlet, monitorovat technologickém možnosti a zmíněný stav techniky. Tak, jako se rýsuje možnost nahradit složité kryptografické elektronické podpisy dynamickými biometrickými podpisy, tak jistě přijdou nové možnosti pro autorizaci a komunikaci.

## Jaké vlastnosti musí volební systém mít?

Podívejme se, jaké vlastnosti musí mít volební systém, aby byl pro účely voleb použitelný. Zároveň se zaměříme na to, jak jsou tyto vlastnosti zajištěny současným hlasovacím mechanismem.

### Dostupnost pro voliče

Hlasování musí být pro voliče jednoduché a nesmí být spojeno s překonáváním zásadních překážek. Současný hlasovací mechanismus vytváří velké množství volebních místností, které jsou obvykle snadno fyzicky dostupné, snad jenom s výjimkou voličů žijících na samotě v hlubokých lesích. Jsou přijata opatření pro voliče zdržující se mimo domov (voličské průkazy) i pro voliče, kteří nemohou domov opustit (přenosné volební urny). Hlasování je nedostupné pouze pro malé a statisticky nepříliš významné skupiny voličů, které byly popsány dříve. Takovýto způsob hlasování nicméně způsobuje značné výdaje na organizaci voleb a elektronický systém by byl velkou úsporou. Ovšem až tehdy, byl-li by současný listinný způsob zcela opuštěn, což je zatím nepravděpodobné.

Elektronické hlasování, má-li mít smysl, musí být minimálně stejně jednoduché. Získání autentizačního prostředku musí být jednoduché -- a vymyslet jednodušší proces, než zajít pár set metrů do nejbližší volební místnosti bude dost problematické. Snad jenom pokud bychom zavedli všem povinně čipové karty s certifikáty, jako je to v Estonsku.

Současný stav podle zákona č. 328/1999 Sb., o občanských průkazech, ve znění platném od 1. 1. 2012 přepokládá, že bude vydáván občanský průkaz se strojově čitelnými údaji a s kontaktním elektronickým čipem (§ 2 odst. 2 písm. a) zákona). Podle § 3 odst. 2 písm. c) jsou strojově čitelnými údaji zapisovanými do občanského průkazu: 1. do strojově čitelné zóny v tomto pořadí: kód dokladu, kód vydávajícího státu, číslo dokladu, kontrolní číslice, datum narození, kontrolní číslice, pohlaví, datum platnosti, kontrolní číslice, státní občanství, celková kontrolní číslice, příjmení, jméno, popřípadě jména občana; kontrolní číslice a celková kontrolní číslice jsou číselným vyjádřením vybraných údajů ve strojově čitelné zóně, 2. do 2D kódu: agendový identifikátor fyzické osoby pro agendu občanských průkazů a číslo občanského průkazu; 2D kódem se rozumí dvoudimenzionální čárový kód s vysokou informační hodnotou a schopností detekce a oprav při jeho porušení. Zákon dále praví, že do kontaktního elektronického čipu lze zapsat údaje, jejichž zápis a rozsah stanoví zvláštní právní předpis. Nelze-li z důvodu nedostatku místa v kontaktním elektronickém čipu zapsat všechny požadované údaje, určí občan, které z nich se zapíší.

Výše uvedená dikce zákona je značně nejasná a v podstatě nebude-li vydán zmíněný další zvláštní předpis, nelze odhadnout, zda bude možno do elektronického OP ukládat certifikáty, jakkoliv by se to jevilo jednoznačně prospěšné a potřebné. Současně je třeba mít na paměti, že ukládání certifikátů s omezenou časovou platností se nesmí stát nástrojem „buzerace" občanů, odpovědných za jejich obnovování či inovaci.

Rozhraní elektronického volebního systému musí být jednoduché a snadno pochopitelné. Nebude-li, bude jednak voliče odrazovat (viz např. komplikovaný systém preferenčních hlasů v komunálních volbách) a také může vést k tomu, že volič bude hlasovat jinak, než chtěl, aniž by si toho byl vědom.

Tomuto tématu se obšírně věnuje dizertační práce Sarah P. Everett z Rice University[^26]. Vyčerpávajícím způsobem popisuje návrh rozhraní hlasovacích strojů v USA a problémy s ním spojené. Tytéž otázky bude muset nicméně řešit i rozhraní volebního systému.

Obecně aspekt přístupnosti a použitelnosti je v informačních systémech státní správy u nás zcela opomíjen. Prakticky ve všech případech stát předpokládá, že (často i nedobrovolní) uživatelé rozhraní jeho systémů budou dokonale vzděláni a pozorně si prostudují relevantní zákon, všechny prováděcí předpisy a obsáhlý návod k použití. Tomu odpovídá i grafická a ergonomická úroveň rozhraní, které patrně vytvářeli rukou společnou a nerozdílnou právníci a programátoři[^27], případně že jej o své vůli vytvářejí bez jakékoliv kontroly zadavatele zvlčilí pachatelé systému.

### Autorizace a anonymita

Musí být zajištěno, aby mohl hlasovat jenom oprávěný volič a aby nemohl hlasovat dvakrát. Zároveň ale nesmí být hlas po odevzdání vystopovatelný ke konkrétnímu voliči, resp. chceme-li vyhovět požadavku na kontrolovatelnost voleb, musíme realizovat princip omezené anonymity.

První požadavek se v současném volebním systému řeší označením ve fyzickém volebním seznamu a nebo odebráním voličského průkazu a fyzickým zajištěním přístupu k volební urně[^28] jenom pro autentizované (komisí předem prověřené) voliče.

Elektronická realizace téhož je podstatně komplikovanější a obvykle zahrnuje prvky institucionální důvěry. Přesto lze navrhnout mechanismy, které přinesou jistou úroveň kontrolovatelnosti. Estonská cesta spočívá v použití osobních certifikátů, kdy dochází k autentizaci voliče, ale jeho anonymita je zajištěna pouze institucionálně, nikoliv technicky[^29].

Situaci by bylo možné vyřešit například použitím jednorázových hesel. Volič by se pro účely elektronického hlasování zaregistroval na úřadě a obdržel by náhodně vybranou zalepenou obálku s jednorázovým a unikátním heslem. To by ovšem zásadně zkomplikovalo volební proces a fakticky by jej pro voliče učinilo náročnějším, než „papírové" volby. Existují ovšem možnosti zapojení mobilních telefonů, kdy bude volič dostávat jednorázový autentizační kód formou SMS.

Pokud se týče důvěrnosti hlasování, existují pro ni ovšem tři stavy, nikoliv pouhé dva, jak by se nabízelo. Existují dva extrémní a obvyklé stavy: buďto anonymita hlasování neexistuje vůbec a volba je zcela veřejná. Kdokoliv může snadno zjistit, jak někdo jiný hlasoval. A nebo je anonymita absolutní a nikdo nemůže zjistit, jak někdo hlasoval. To je situace, v jaké se náš volební mechanismus nachází v současnosti.

Třetí stav je, kdy je anonymita volby zajištěna institucionálně a organizačně, nikoliv čistě technickými prostředky. Jinými slovy: organizátor voleb by teoreticky mohl zjistit, jak kdo hlasoval, ale mechanismus voleb je zorganizovaný tak, aby to nebylo jednoduché, aby to vyžadovalo spolupráci více osob atd. To je stav, ve kterém se nacházejí všechny dosud známé systémy elektronických voleb na dálku.

Je to reálné východisko -- i v e-světě musí být vyřešena regulovaná anonymita, jinak by se navržený systém zhroutil. Podle našich informací se ale v USA podobný návrh setkal s odporem. Šlo o key escrow systém (KES), kdy bylo možné dohledat na základě použití údajů uložených u dvou státních organizací daného „autora". Neboť podle názorů američanů jsou byť dvě instituce stále součástí jednoho státního aparátu. Hned od počátku se u KES objevilo několik postupů, jak jej obejít a paralyzovat. Proto byl zrušen.

Je otázkou pro diskuzi, zda jsme ochotni takové riziko podstoupit, nebo nikoliv. Na jednu stranu je anonymita hlasování podstatnou náležitostí svobodných voleb. Na stranu druhou má význam spíše místní, jak bude probráno v následujících částech. V případě, že by se vlády nad státem zmocnila strana, která by chtěla občany s odlišnými politickými názory perzekvovat, nemusí k tomu mít identifikovatelné výsledky voleb[^30]. Na druhou stranu, přístup k údajům o hlasování by perzekuci mohl usnadnit. Proto se snažíme navrhnout i další možnosti, které by toto riziko, jakkoliv se nejeví vysoké -- co by měl kdo z možnosti zjistit a případně perzekuovat voliče demokratické politické strany?

### Svoboda volby

Volební mechanismus musí zajistit svobodu volby, tedy aby voliče nemohl nikdo přinutit ke konkrétnímu hlasování a nebo ho potrestat za to, že hlasoval jinak, než chtěl.

Současné volby tento problém řeší tak, že každý volič musí povinně jít za plentu a tam vložit do obálky volební lístek. Není možná „manifestační" nebo „otevřená" volba, k níž by mohl být volič donucen pohrůžkami nebo psychickým tlakem okolí, např. rodiny.[^31]

Elektronický systém může toto zajistit jenom velmi obtížně už jenom tím, že k hlasování nedochází na veřejném místě s vynucenou chvílí samoty, ale v soukromí domova. Tím napomáhá fenoménu „family votingu", kdy o hlasování celé rodiny rozhoduje osoba s největší autoritou nebo ekonomickou silou („přednosta domácnosti"), nebo „proxy votingu", což je obecnější varianta téhož -- že nějaká osoba obecně fakticky volí „za někoho jiného".

### Nemožnost prokázat, jak jsem volil

Volič nyní nemůže prokázat třetí osobě, jak volil. Ani dobrovolně, ani z donucení. Nikdo nemá možnost zkontrolovat, jak jiná osoba volila. Kdokoliv si může ve volební místnosti oficiálně vyžádat novou sadu volebních lístků (např. pokud mu byly „nežádoucí" lístky odebrány. Kromě toho volební lístek lze obdržet řadou „neoficiálních" a nedetekovatelných cest: obvykle se obálky s nimi volně válejí po chodbách domů.

Takové scénáře nejsou v současné ČR ani zdaleka z říše fantazie. Jeden z autorů článku je s podobným případem osobně obeznámen ze svého okolí. Rodina je řízena silně patriarchálním způsobem a „otec rodiny" osobně odebral všem členům domácnosti všechny volební lístky, s výjimkou lístku pro jím vybranou stranu a dohlížel i na samotný akt hlasování ve volební místnosti. Jeden ze synů si netroufal se otcovské autoritě otevřeně vzepřít, a to ani tím, že by otevřeně požádal o novou sadu volební komisi. Tajně si obstaral jiný volební lístek a ten v okamžiku soukromí za plentou použil.

Elektronické hlasování na dálku takové scénáře umožní a otevře cestu k podobným mechanismům vydírání a nebo kupování hlasů[^32]. Současné pokusy v tomto duchu[^33] jsou spíše úsměvné, protože ve větším měřítku neúčinné.

Pokud by volič měl možnost svůj hlas později změnit (ať už elektronicky a nebo osobně ve volební místnosti, jako je tomu v již zmiňovaném Estonsku), bude narušen princip anonymity voleb, protože v takovém případě už z principu musí být i po jeho odevzdání možnost hlas změnit nebo odvolat.

### Nemožnost manipulace s hlasy a volebními výsledky

Současný systém znemožňuje manipulaci s hlasy a volebními výsledky tím, že na kritickou část procesu dohlíží volební komise, složená ze zástupců různých stran. Manipulace by byla možná pouze tehdy, pokud by se na ní shodli členové volební komise, jejichž zájmy jsou ovšem protichůdné.

Výsledky voleb také musejí být přezkoumatelné. V případě současného systému existuje papírový záznam v podobě volebních lístků, které mohou být v případě potřeby znovu přepočítány.

V případě elektronického volebního systému by tento musel být navržen na podobných principech a nebo by opět musel být založen na institucionální důvěře.

Existují v podstatě tři možnosti, jak institucionální důvěru posílit:

1.  institucionální důvěra bude rozdělena na více subjektů (ÚOOÚ a ČSÚ) -- viz dále,
2.  volič obdrží kontrolní opis své volby podepsaný elektronickou značkou a časovým razítkem volebního serveru, takže jej může (bude-li chtít), kdykoliv předložit při přepočtu hlasů nebo reklamaci,
3.  volič obdrží zabezpečeným kanálem (mailem, SMS) jednorázově vygenerovaný přístupový kód do celostátní databáze hlasů, kde podle toho najde svoji volbu a ověří si, že byla zpracována.

### Volební mechanismus nesmí zahrnovat prvky institucionální důvěry

Již několikrát zde byl zmíněn prvek institucionální důvěry, a to obvykle v negativních konotacích. Proč vlastně? Protože volby mají v demokratické společnosti specifické a jedinečné postavení. Jedná se o jediný způsob, jakým mohou občané svrhnout stávající vládu a ovlivnit mechanismus fungování státní správy.

Za normálních okolností se na stát víceméně můžeme spolehnout a akceptovat jej jako garanta dodržení nějakých mechanismů. Ne však v případě voleb, protože v tomto jediném případě občané mohou rozhodnout o výměně své politické reprezentace. Té reprezentace, která má pod kontrolou celý státní aparát.

Z tohoto důvodu je většina volebních procesů předem daná zákonem a neexistuje mnoho mechanismů, jak by mohly libovolné orgány státu do voleb zasahovat. Dokonce i soudní přezkum voleb je velmi omezený.

Stát -- až už pod tímto pojmem myslíme cokoliv -- nemůže zfalšovat současné volby. Může podnikat rozličné kroky, které mohou výsledek tak či onak ovlivnit[^34], ale musí tak činit viditelně a možnosti jsou velice omezené.

Všechny dosud známé mechanismy elektronických voleb státu -- či některým jeho orgánům či subjektům -- takovou možnost dávají.

### Volební mechanismus musí být důvěryhodný a být obecně také jako důvěryhodný vnímán

Nejdůležitější parametr, který musí volební mechanismus splňovat, je jeho důvěryhodnost. A to jak objektivní, tak subjektivní. Je důležité, aby byl volební mechanismus navržen bezpečně, aby neumožňoval podvrhy hlasů a různé formy útoků popsané dříve. Je ale stejně tak důležité, aby občané, voliči, tomu systému subjektivně věřili a za důvěryhodný jej pokládali.

A to je největší problém elektronických voleb všeho druhu.

Průměrně inteligentní člověk bez zvláštního vzdělání dokáže pochopit současný volební mechanismus. Může se do něj dokonce snadno i osobně zapojit[^35]. Při troše zájmu jej dokáže pochopit a intelektuálně vstřebat. Jeho možnosti ovšem končí u zpracování informačním systémem ČSÚ, kterému věří, protože se domnívá, že zpětná kontrola (jakkoliv není známo, že by k ní v masovém měřítku někdy došlo), je možná.

Podle Valáška bude systém elektronických voleb pro absolutní většinu obyvatelstva zcela nepochopitelný, protože i když se podaří pomocí vymyslet a třeba i matematicky prokázat takovou kombinaci technických a kryptografických metod, které umožní realizovat důvěryhodné volby, téměř nikdo jej nepochopí. Smejkal s Kodlem jsou názoru, že tomu tak není, neboť se bude lišit pouze část nahrazující vlastní akt ve volební místnosti, a tedy není třeba propadat panice.

## Možný elektronický volební systém pro Českou republiku

Se znalostí požadovaných parametrů se můžeme nyní pokusit navrhnout volební systém pro elektronické volby v České republice. Je smutnou realitou, že se ještě nikdy a nikomu nepodařilo navrhnout takový systém elektronických voleb, který by všechny výše uvedené nároky splňoval beze zbytku. Autoři článku musejí sebekriticky konstatovat, že se to bohužel nepodařilo ani jim. Veškeré známé systémy jsou postavené na nějaké formě kompromisu.

Abychom vůbec mohli elektronický systém navrhnout, museli jsme ustoupit z požadavku jeho absolutní anonymity. Důvěrnost odevzdaného hlasu není zaručena čistě technologicky, ale kombinací technologických a organizačních pojistek. Zda to je nebo není příliš vysoká cena za e-volby je otázka k celospolečenské diskuzi a na odpovědi se nedokázali shodnout autoři mezi sebou. Zastávají nicméně názor, že bez kontroly a případné regulace nelze systém řešit. Vždy se musí jednat o regulovanou soustavu.

### Výchozí předpoklady

Náš návrh předpokládá, že každý, kdo chce elektronicky volit, bude vybaven svým certifikátem. Náš návrh neřeší, jaký ten certifikát bude, jak bude distribuován a kde bude uložen. Mohou to být klasické kvalifikované certifikáty, mohou to být speciální certifikáty distribuované nějak čistě pro účely voleb, nebo třeba nějaká zcela jiná třída certifikátů, které budou uloženy na elektronických občanských průkazech.

Alternativou mohou být jednorázová hesla, zasílaná na vyžádání již zmíněným zabezpečeným kanálem nebo SMS.

Náš mechanismus neřeší distribuci „volebních lístků". Předpokládáme, že distribuce údajů o kandidátech proběhne prostým širokým zveřejněním a doplňkově třeba zveřejněním elektronických seznamů kandidátů na serverech ministerstva vnitra nebo ČSÚ. Zaměřili jsme se tedy na vlastní odevzdání hlasu a jejich spočítání.

### Elektronické odevzdání hlasu

V této fázi je nutné řešit především autorizaci a anonymizaci. Předpokládáme, že se o volby budou starat dva subjekty:

* „Identity provider", nebo „autorizátor" -- ekvivalent okrskové volební komise ve chvíli, kdy ověřuje voliče proti volebnímu seznamu. Podle našeho názoru je vhodným kandidátem na tuto roli **Úřad pro ochranu osobních údajů** (ÚOOÚ).
* „Zpracovatel výsledků" -- tedy ten, kdo bude výsledky voleb počítat. Tím by z logiky věci měl nadále být **Český statistický úřad** (ČSÚ).

Oba dva subjekty v dostatečném předstihu před volbami vygenerují soukromý a veřejný klíč a své veřejné klíče, které budou v průběhu voleb používat, zveřejní. Dále pak zveřejní adresu, na které bude endpoint jejich informačního systému, který bude přijímat žádosti o níže popsané služby. Náš návrh neřeší, jak konkrétně to bude technologicky vyřešeno, ale může se jednat např. o URL endpointu webové služby.

Volič připraví svůj hlas (což budou fakticky data v nějakém definovaném formátu), zašifruje ho veřejným klíčem zpracovatele (ČSÚ) a elektronicky ho podepíše svým vlastním klíčem. A odešle ho autorizátorovi (ÚOOÚ). Autorizátor nezná obsah hlasu (protože je zašifrovaný pro klíč, který nemá), ale může ověřit totožnost hlasujícího.

Vlastní ověření závisí na tom, zda se podaří zprovoznit elektronické volební seznamy. Pokud ano, volič se pro elektronické volby nebude muset předem registrovat, prostě ve chvíli, kdy bude autorizován pro elektronickou volbu bude vyškrtnut ze seznamu pro volby fyzické. Pokud by se nepodařilo zpracovat elektronické volební seznamy, musel by svůj úmysl volit elektronicky vyjádřit předem, a byl by ze seznamu vyšrtnut. Postupovalo by se tedy podobně jako při žádosti o voličský průkaz.[^36] To by ovšem efektivitu a přitažlivost e-voleb pronikavě snížilo.

Pokud by byl volič úspěšně autorizován, ÚOOÚ by ze zprávy odstranil voličův elektronický podpis a přidal k ní vlastní „sériové číslo" (obecně jakýkoliv jedinečný bezvýznamový identifikátor). Výslednou zprávu by pak elektronicky podepsal a poslal jako odpověď voliči. Toto „sériové číslo" bude pro konkrétního voliče vždy stejné. Tj. volič může o podpis hlasu (i různého) požádat opakovaně. Případně by toto sériové číslo mohlo sloužit pro ověření započtení hlasu voliče do výše uvedené centrální databáze odevzdaných hlasů.

Volič by si mohl být jist, že jeho hlas nebyl modifikován (mohl by si ověřit, že jeho hlas se mu vrátil v té podobě, v jaké byl odeslán. Pak by tuto zprávu beze změny odeslal zpracovateli, tedy ČSÚ. Zpracovatel by nevěděl, od koho hlas obdržel (protože součástí zprávy není žádná identifikace odesílatele), ale věděl by, že byl odesílatel předtím prověřen ÚOOÚ a tedy že je oprávněným voličem. Podle „sériového čísla" také může identifikovat několik hlasů od téhož voliče a započítat jenom ten „nejnovější" (tj. volič může hlasovat opakovaně, ale započítá se jenom poslední hlas).

O přijetí hlasu pošle voliči ČSÚ elektronicky podepsané potvrzení, nebude tedy v budoucnu moci popřít, že hlas obdržel.

Anonymita hlasování bude v tomto případě zaručena nikoliv technologicky, ale organizačně. Aby bylo možno zjistit, jak kdo hlasoval, musely by se spojit údaje dvou různých úřadů -- ČSÚ a ÚOOÚ. Jde sice opět o institucionální důvěru, ovšem jednak rozdělenou na dvě instituce se zcela jiným vymezením v Ústavě, instituce stojící mimo exekutivu i mimo zastupitelské sbory, což tuto důvěru může posílit. Ještě podstatnější je ale možnost onoho následného přezkumu elektronických hlasů, jak je uvedeno výše -- otiskem volby, nacházejícím se v držení voliče, a možností ověření v centrální databázi odevzdaných hlasů.

Veškeré shora uvedené činnosti by vykonával nějaký hlasovací softwarový klient. Není ovšem žádoucí, aby existoval pouze jeden, aby bylo možné vyloučit podezření, že modifikuje hlasy. Ideální je, aby výše popsané rozhraní bylo veřejné a podle nějaké referenční „oficiální" implementace s otevřeným zdrojovým kódem mohl kdokoliv napsat vlastní.

### Elektronické počítání hlasů

Po „uzavření volebních místností" zpracovatel rozšifruje přijatá data a spočítá jednotlivé hlasy. Jeho konání je přezkoumatelné, protože tatáž data (nerozšifrovaná) má autorizátor (ÚOOÚ) a v případě potřeby je může vydat k nezávislému zkoumání.

Detekce, že zpracovatel (v našem modelu ČSÚ) data skutečně modifikoval a výsledky voleb podvrhl, je při běžném zpracování téměř nemožná. Je tedy téměř nemožné, aby někdo mohl získat podložené podezření, ale zcela vyloučit to nelze. Porovnání s daty autorizátora by přitom zřejmě musel nařídit nějaký nebo minimálně další orgán (Ústřední volební komise, případně soud) a ten by tak patrně nečinil lehkovážně, protože by to znamenalo nebezpečí narušení anonymity voleb.

Protože prokázat matematicky spolehlivost jakéhokoliv reálného počítačového programu je v podstatě nemožné, pro prosté zvýšení důvěryhodnosti ve vztahu k neúmyslným chybám by bylo nutné, aby systém byl nejméně zdvojený[^37], každá instance dodaná (a pokud možno i provozovaná) někým jiným, a jejich výsledky by se musely shodovat.

Nicméně i v případě obrany proti neúmyslné chybě je stále dosti otevřená možnost úmyslné manipulace voleb velmi malou skupinou osob. Přitom motivace je v tomto případě celkem vysoká.

## Otevřenost především

Pokud by měly být elektronické volby v nějaké formě skutečně realizovány, je pro odhalení chyb a posílení veřejnosti nezbytné, aby jejich implementace byla co možná nejotevřenější a pod veřejnou kontrolou. Veškeré pro volby specifické programové vybavení by mělo být v dostatečném předstihu zveřejněno ve formě zdrojových kódů a včetně úplné dokumentace, která by umožnila zájemcům funkčnost systému nasimulovat a otestovat.

Bohužel, v praxi se obvykle setkáváme s přístupem „security trough obscurity", kdy jsou s odkazem na „bezpečnostní důvody" skrývány postupy implementace, které jsou kritické pro posouzení, zda je ten který systém důvěryhodný nebo nikoliv. Zveřejňovány bývají zpravidla pouze velmi obecné dokumenty, ze kterých nelze vyvodit žádné specifické důsledky.

Důležité je nejenom zveřejnění zdrojových kódů samotných, ale také průvodní dokumentace k nim[^38]. Analýza prostých zdrojových kódů je sice možná, ale dosti obtížná a cílem státu by v tomto případě mělo být veřejné a nezávislé potvrzení důvěryhodnosti celého systému, ne jeho podrývání. Tento postup je ostatně v kryptografii běžný, že za bezpečné jsou považovány pouze ty algoritmy a postupy, které prošly otevřeným posuzováním.

Aby byl systém opravdu bezpečný a důvěryhodný, musí jeho bezpečnost spočívat nikoliv v utajené implementaci, ale v implementaci prokazatelně bezpečné.

## Nejsou jen jedny volby

V celém článku jsme se nijak nezabývali typem voleb, které by měly být elektronicky realizovány (ačkoliv implicitně jsme předpokládali volby do Poslanecké sněmovny).

Některá rizika spojená s elektronickými volbami by bylo možné do jisté míry snížit, kdyby se nepoužívaly pro celostátní volby do Parlamentu, ale pro volby nižší úrovně, např. komunální a krajské. Tam by byl větší spoleh na předpokládanou nezávislost celostátních orgánů na místních strukturách. Také se tyto volby těší menšímu zájmu voličů a není možné při nich volit na voličský průkaz, což snižuje jejich reálnou dostupnost pro voliče a posilovalo by výhody elektronické volby.

## Závěr

V našem článku jsme se snažili poměrně objektivně popsat výhody a nevýhody, jakož i přednosti a rizika e-voleb. Závěry z nich vyvozené nicméně odpovídají osobním sklonům autorů, z nichž první je pesimista, který vidí láhev způli prázdnou, druhý je spíše optimista, vidící tutéž láhev způli plnou a třetí se nachází někde mezi nimi.

Necháváme tedy na čtenáři, aby si vybral, se kterým ze dvou přístupů se ztotožní.

### Závěr optimistický

Optimisté (Kodl a Smejkal) zastávají názor, že přes všechny uvedené nevýhody je třeba začít elektronické volby připravovat. Technologická gramotnost obyvatelstva stále roste: uživatelů mobilního telefonu bylo v roce 2009 více než 90% obyvatel, u osobních počítačů v roce 2010 více než 64%, přičemž prakticky stejný počet občanů používá i Internet.

Protože příprava e-voleb je běh na několik let, není možné prohlásit, že nám to (právě teď) nic nepřinese a čekat na budoucnost. Domnívají se, že stále ještě nebyla vyřčena poslední slova v možnosti komunikovat a pro různé druhy voleb se mu jeví zajímavé použít i různé komunikační kanály: mobily, Internet, interaktivní televize. Proto je další odklad toho, co mělo být již provedeno, tj. pilotního projektu spojeného s jeho ověřením na vysokých školách, zásadně nepřípustný.

Výše popsané návrhy mohou být dle nich dostatečným východiskem pro úvahy, zda a jak e-volby vyzkoušet a v případě úspěšného průběhu realizovat. Jistá míra institucionální důvěry existuje dnes ve všech demokratických režimech na světě. O důvěře v technologie nemluvě; tu testujeme každý den nesčíslněkrát, ve výtahu, automobilu, letadla, v nemocnici a kdekoliv jinde.

### Závěr pesimistický

Pesimista (Valášek) je toho soudu, že dostupné technologie neumožňují uspokojivě vyřešit autorizaci hlasování při zachování plné anonymity. Za zcela zásadně nepřijatelný považuje v případě voleb prvek institucionální důvěry v ty instituce, které jsou na výsledku voleb přímo či nepřímo závislé. Bez takového prvku se žádná současná ani navržená implementace neobejde a nic nenaznačuje tomu, že by se tato situace měla v dohledné době změnit -- k tomu by bylo třeba revolučního, ne evolučního kroku.Možná ještě závažnějším problémem je ovšem výše zmíněné subjektivní vnímání důvěryhodnosti voleb laickou veřejností. I pro specializované odborníky, autory tohoto článku nevyjímaje, existuje hranice, za kterou rozumové pochopení vystřídala víra. Něco, co chápeme jako „černou skříňku", které sice nerozumíme, ale jejímuž fungování důvěřujeme. Lišíme se jenom velikostí oné černé skříňky. Pro někoho je definovaná jako „elektronický podpis", pro jiného jako „algoritmus RSA" a ještě pro dalšího to budou záludnosti násobení velkých prvočísel. Jistě existuje několik málo géniů, kteří plně rozumově pochopí veškeré použité techniky, ale mnoho jich nebude.

I bez elektronických voleb se důvěra v demokratický systém voleb obecně snižuje, stejně jako zájem občanů o politické dění. Neuvážená implementace elektronického hlasování by ji dále snížila posunutím rozumově odůvodněné důvěry do roviny náboženské zkušenosti: nemůžeš pochopit, musíš uvěřit.

A výhody elektronického hlasování nejsou takové, aby nás k přijetí takového rizika v této chvíli opravňovaly.

[^1]: Tak, jak je upravuje zákon č. 247/1995 Sb., o volbách do Parlamentu České republiky a o změně a doplnění některých dalších zákonů, ve znění pozdějších předpisů a vyhláška č. 233/2000 Sb., o provedení některých ustanovení zákona č. 247/1995 Sb., o volbách do Parlamentu České republiky a o změně a doplnění některých dalších zákonů, ve znění pozdějších předpisů.

[^2]: A je důkazem pravdivosti tvrzení, že není důležité, jak se volí, ale jak se počítají hlasy.

[^3]: Informace v této sekci pocházejí zejména z webu [ACE Project](http://www.aceproject.org/).

[^4]: [L'Assemblée des Français de l'étranger](http://www.assemblee-afe.fr/).

[^5]: ACE Project uvádí: Argentina, Azerbaijan, Belarus, Bulgaria, Chile, Czech Republic, Finland, Greece, Italy, Latvia, Lithuania, Mexico, Nepal, Nigeria, Norway, Poland, Portugal, Romania, Slovakia, Slovenia, South Africa, Spain, South Korea, Sweden

[^6]: http://www.hs.fi/english/article/1135245067013

[^7]: http://www.om.fi/Etusivu/Ajankohtaista/Uutiset/1224166604122

[^8]: Voutsis, N., Zimmerman, F. [Anonymous Code Lists For Secure Electronic Voting Over Insecure Mobile Channels](http://www.mgovernment.org/resurces/euromgov2005/PDF/45_R350ZF.pdf). In: Kushchu I., Kuscu M. (Eds.). The Proceedings of the First European Mobile Government Conference (Euro mGov 2005). Brighton, UK , 10-12 July, Mobile Government Consortium International Pub., UK. ISBN: 0-9763341-0-0.

[^9]: Zejména ve Spojených státech, ale i v Indii, Holandsku, Belgii, Brazílii atd.

[^10]: Podle aktuálního stavu začnou úřady elektronické občanské průkazy vydávat od 1. ledna 2012, nedojde-li ovšem k dalšímu odložení tohoto projektu, což nelze vyloučit.

[^11]: http://wijvertrouwenstemcomputersniet.nl/Nedap-en

[^12]: http://www.theregister.co.uk/2007/10/01/dutch_pull_plug_on_evoting/

[^13]: http://www.rte.ie/news/2009/0423/evoting.html

[^14]: http://www.bundesverfassungsgericht.de/pressemitteilungen/bvg09-019en.html

[^15]: např. Itálie, Francie

[^16]: Problematice se obšírně věnuje web indiaevm.org, celou zprávu lze nalézt na http://indiaevm.org/evm_tr2010-jul29.pdf.

[^17]: http://rop.gonggri.jp/?p=431

[^18]: http://timesofindia.indiatimes.com/india/Intel-background-check-on-EVM-thief/articleshow/6441674.cms

[^19]: Základní informace jest nalézti příkladně na http://www.vvk.ee/index.php?id=11178

[^20]: S jedinou výjimkou srovnání let 2002 a 2006, kde účast naopak vzrostla o šest procentních bodů.

[^21]: Pomineme-li poněkud specifickou situaci voleb v roce 1990, kdy Občanské fórum získalo 53 % hlasů.

[^22]: http://www.mfcr.cz/cps/rde/xchg/mfcr/xsl/info_zadost_58698.html

[^23]: http://www.czso.cz/csu/redakce.nsf/i/kolik_z_nas_pouziva_mobilni_telefon_osobni_pocitac_a_internet

[^24]: http://www.czso.cz/csu/redakce.nsf/i/k_cemu_vyuzivame_internet

[^25]: Čítající např. v Austrálii přepravu na vzdálenost bezmála čtyř tisíc kilometrů, z Perthu do Canberry nebo Sydney

[^26]: http://chil.rice.edu/research/pdf/EverettDissertation.pdf

[^27]: Nebo ufoni. Jako ukázku stačí jmenovat několik z IS státní správy, s nimiž byl první z autorů konfrontován při přípravě tohoto článku: volební server ČSÚ, „Veřejná databáze" téhož úřadu, web Ministerstva financí a webové rozhraní ISDS.

[^28]: Prostřednictvím členů volební komise, zpravidla v důchodovém věku. Nicméně v našem sociokulturním prostředí zatím nebyly zaznamenány situace jako v Indii, kde byly opakovaně volební místnosti přepadány ozbrojenými maskovanými muži, kteří násilím do volebních uren vecpali hlasovací lístky.

[^29]: Technicky je v Estonsku naopak pro odvolatelnost hlasu ve fyzické volební místnosti nezbytné, aby konkrétní hlas byl s voličem svázán až do skončení voleb.

[^30]: Jak se ostatně v historii českého státu ukázalo několikrát, efektivní teror lze rozpoutat i tak.

[^31]: V době totalitního státu byl československý volič stigmatizován před volební komisí už jen tím, že šel za plentu a tam cokoliv s obsahem obálky činil. Jediná přijatelná varianta bylo převzetí obálky od volební komise a její viditelné až demonstrativní bezprostředně následné vhození do urny.

[^32]: Obzvláště v případě, že by byla zvolena výše navrhovaná cesta jednorázových hesel -- stačilo by „vybrat obálky".

[^33]: Svážení a kupování voličů a akce typu „sleva za volební lístek té a té strany", což jsme viděli i u nás v posledních volbách do PSP.

[^34]: Příkladem toho budiž gerrymandering, tedy nové rozparcelování Prahy na volební obvody v místních volbách, které je v současné době předmětem sporu u Ústavního soudu.

[^35]: Jako člen volební komise, protože jich je obecně spíše nedostatek.

[^36]: Se stejnou nevýhodou, že by nemohl elektronicky hlasovat někdo, kdo se svou přítomností předem nepočítal a včas si nevyřídil „elektronický voličský průkaz".

[^37]: Lépe ztrojený, protože pak se lépe odhalí, ve kterém systému byla chyba. Ostatně, máme v tom národní tradici, protože na principu ztrojené výpočetní jednotky a demokratického hlasování o správném výsledku byl postaven první československý počítač SAPO, první fault-tolerant počítač na světě.

[^38]: Např. v Belgii byly zveřejněny zdrojové kódy firmware tamních volebních strojů, ale bez jakékoliv dokumentace.
