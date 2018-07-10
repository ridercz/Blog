<!-- dcterms:identifier = aspnetcz#28 -->
<!-- dcterms:title = Rozesílání hromadných e-mailových zpráv z prostředí .NET -->
<!-- dcterms:abstract = Jeden článek o mailování z ASP.NET jsem už svého času napsal. Dotazy v konferencích a v neposlední řadě můj téměř shozený mailový server jsou však důkazem toho, že toto téma je stále živé. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Tipy, triky -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2005-04-07T05:06:19.08+02:00 -->
<!-- dcterms:dateAccepted = 2005-04-07T05:06:19.08+02:00 -->

![Poštovní schránka](https://www.cdn.altairis.cz/Blog/letterbox.jpg "Poštovní schránka // via sxc.hu, used by permission")Jeden článek o mailování z ASP.NET jsem už svého času [napsal](/entry/article-20050103.aspx). Dotazy v konferencích a v neposlední řadě můj téměř shozený mailový server jsou však důkazem toho, že toto téma je stále živé.

## Co je mass-mailing

Nejprve definice: mass-mailing tak, jak jest pojednáván v tomto článku, je rozesílání velkého množství e-mailových zpráv. Velkým množstvím myslím cokoliv od řádově 500 mailů výše.

Občas se lze setkat s nesprávným, leč hluboce zakořeněným přesvědčením, že kdo rozesílá velké množství mailů, musí být nutně spammer. Mé zkušenosti hovoří o opaku. Poskytujete-li službu zasílání aktualizací e-mailem, snadno nasbíráte za nějakou dobu provozu tisíce uživatelů.

Pro ilustraci pár čísel z mých projektů (vždy se jedná o aktuální čísla představující počet adres, ze kterých se zprávy nevracejí jako nedoručitelné): Tento web (a jeho předchůdce ASP Network) nabízí službu [zasílání aktualizací e-mailem](/MailingList.aspx). Za necelých pět let činnosti se k odběru příspěvků přihlásilo přes tisíc uživatelů. Mailing list [o aktualizacích mých programů](http://software.altaircom.net/) má 3000 odběratelů.

V obou případech se jedná o poměrně specializované projekty, v případě tohoto webu navíc pouze v češtině. Pokud se jedná o projekt cílený na širší veřejnost a dostupný v nějakém běžnějším jazyce než je čeština, není žádným uměním časem nasbírat pár desítek tisíc uživatelů. Největší mass-mailing který jsem zatím dělal, byl na 250 000 adres.

## Fáze nultá: Příprava

Připravou se rozumí získání e-mailových adres. V souladu se zákonem a internetovými "dobrými mravy" (netiketou) je smíte získat pouze od uživatelů samých a musíte je informovat o tom, že je budete obšťastňovat opakovaným zasíláním pošty. 

Znakem serióznosti je výše uvedenou informaci nijak neskrývat a zapsáním do mailing listu nepodmiňovat např. možnost stažení zkušební verze software. Pokud budete uživatele příliš prudit, budete mít sice velký mailing list, ale plný adres buďto nesmyslných, odpadních, jednorázových a jiných (osobně u otravných firem tohoto typu používám službu [mailinator.com](http://www.mailinator.com/), nejdu-li rovnou jinam).

Zadané e-mailové adresy si zkontrolujte, zda odpovídají syntaktickým pravidlům. Pozoruhodné množství uživatelů je schopno za e-mailovou adresu vydávat adresu webové stránky nebo své jméno v adrese napsat včetně háčků a čárek.

Doporučuji též zkontrolovat e-mailovou adresu co do funkčnosti zasláním potvrzovacího mailu, například [postupem popsaným v mém starším článku](http://archive.aspnetwork.cz/art/clanek.asp?id=255). Ušetříte si tím starosti s nesmyslnými adresami v databázi (máte jistotu, že alespoň v okamžiku vložení byla adresa funkční) a zároveň se vyhnete problémům s tím, že někdo zadá do vašeho formuláře cizí adresu.

Čím více e-mailových adres máte, tím kritičtější je nutnost dohody s vaším poskytovatelem web hostingu či internetového připojení. Jednak kvůli zátěži serveru: Pokud bez varování z běžného produkčního serveru začnete rozesílat desítky tisíc mailů, je pravděpodobné, že vám jeho správce provede výplach mozku řitním otvorem (alespoň pokud je obdobné nátury jako já). Druhak proto, že se stoupajícím počtem adresátů stoupá i pravděpodobnost, že si některý z nich bude stěžovat na spam, protože zapoměl, že si zaslání před časem sám vyžádal. Včasnou dohodou s ISP et al zabráníte případným represáliím ještě předtím, než vzniknou.

## Fáze první: Rozesílání

Rozesílání vždy dělejte z počítače, který má dostatečnou konektivitu a výkon. Ideálem je samozřejmě dedikovaný páteřní server. Dobré je použít server, který standardně nemá nic moc do činění s pravidelně využívanými službami. Například server na který se kopírují zálohy a jinak zahálí. Naprosto nevhodné je použití "standardního" mail serveru, na který vám chodí běžná pošta. Máte velkou šanci ho zahltit a zkomplikovat doručování běžné pošty.

Mějte na paměti, že se jedná o časově náročnou činnost. Pro každou cílovou doménu musí odesílající server najít v DNS odpovídající mail exchanger, spojit se s ním a předat mu zprávu. Cílový server může mít výpadek nebo může používat technologii podobnou [greylistingu](http://projects.puremagic.com/greylisting/), takže se doručení zprávy nepovede na první pokus a musí se opakovat. V průměru budete odesílat zprávy rychlostí okolo 10 zpráv za sekundu.

**Pro generování zpráv nikdy nepoužívejte přímo SMTP!** Vytváříte tím další zbytečnou zátěž. Pokud je to možné, vyhněte se používání CDO (Collaboration Data Objects) potažmo služeb v .NET namespace *System.Web.Mail* (jedná se ve skutečnosti jenom o wrapper okolo COM rozhraní CDO).

Ideální je soubory v předepsaném formátu podstčit přímo do "pickup" adresáře mail serveru. Ten je potom podle svých možností postupně zpracuje. Podrobnější informace najdete například ve [shora odkazovaném článku](/entry/article-20050103.aspx#050135). Jste-li líní generovat datové soubory zpráv ručně, můžete použít mnou stvořenou knihovnu [QuickMailer](http://software.altaircom.net/software/quickmailer.aspx).

## Fáze druhá: Zpracování nedoručitelných zpráv

Ne všechny zprávy se podaří doručit. Spadlé poštovní servery, plné či zrušené schránky, v některých případech i překlepy (pokud jste v nulté fázi nezkontrolovali funkčnost zpráv) - to jsou příčiny nedoručitelnosti. A především zpráv o nedoručitelnosti, které budou v hojném množství chodit adresu odesílatele, tedy vaši.

Procento nedoručitelných zpráv závisí na typu mailing listu a frekvenci péče o něj. Pokud se jedná o pravidelně obesílaný a důkladně udržovaný list, bude se odúmrť pohybovat v jednotkách procent i méně. Pokud se jedná o výhružný mail hrozící zrušením účtu uživatelům, kteří se už rok nepřihlásili k vaší službě, může se jednat třeba i o 80%.

Přemýšlejte proto nad tím, kdo bude uveden jako odesílatel e-mailové zprávy, potažmo pak jakou adresu použijete pro hlavičky *Errors-To* a *Reply-To*. Na tu se budou zasílat chybová hlášení. V hojném množství. A vy je budete muset zpracovat a nefunkční uživatele z dalšího obesílání vyřadit. 

Pokud máte víc než padesát odběratelů, vzdejte se naděje, že to zvládnete ručně. Budete si muset napsat nějakého robotka, který to udělá za vás. Tuto bohulibou činnost vám zpestří skutečnost, že formát chybových zpráv není nijak standardizován. Svého času jsem byl jedním ze správců jedné z největších e-mailových konferencí, [gsm@sh.cvut.cz](mailto:gsm@sh.cvut.cz). Shora uvedená nedomyšlenost SMTP činí často z odhalení chybové adresy detektivní pátrání.

Často dostanete zprávu o nedoručitelnosti na adresu, kterou jste v životě neviděli, neřku-li na ní něco posílali. Na vině je roztomilá funkce automatizovaného forwardování mailů. Uživatel si nechá poštu přeposílat mezi pěti různými freemaily. V okamžiku, kdy mu na jednom z nich zruší účet, řetěz se přeruší a jste v háji, vydáni na milost zdravému rozumu správců všech mailových serverů cestou. Což není veličina, na kterou by se dalo spoléhat.

Mně se osvědčilo násedující řešení: Jako odesílatele e-mailové zprávy používám dynamicky generovanou adresu, která je jedinečná pro každou adresu příjemce. Tak se problémovou adresu dozvím podle toho, kam mi dojde zpráva o nedoručení. Pokud mi od uživatele dojde chybové hlášení, nastavím mu v databázi příznak. Pokud při příštím mailingu opět dojde k chybě, vyhodím ho z listu. Nedojde-li, příznak smažu (jednalo se o dočasný problém, třeba plnou schránku po dovolené).

To, co jsem psal o přetěžování běžného SMTP serveru při rozesílání zpráv platí pro doručování chybových zpráv dvojnásob. Jestliže platí, že odesílání si server zpravidla ještě nějak ukočíruje, u přijímání zpráv zvenčí to neplatí. 

Všechny mail servery mají omezený počet současných příchozích spojení. Tato hodnota je konfigurovatelná a většinou se pohybuje v řádově desítkách. Což pro běžný mailový provoz stačí. Pokud se ale najednou tisíce serverů z celého světa rozhodnou hlásit vám problémy s poštou kterou jste odeslali, mění se doručování pošty na přetížený server v ruskou ruletu. Zpráva se tu proboxuje, tu se odesílající server dočká v lepším případě hlášení "*Server too busy, try later*", v horším timeoutu. Dle Murphyho zákona vám samozřejmě bude doručen veškerý spam, zatímco důležitá zpráva na níž čekáte už týden zůstane viset hluboko ve frontě.

Pokud to je alespoň trochu možné, použijte jako adresu odesílatele cosi, co ukazuje na jiný mail server, než je váš standardní. Naše firemní adresy jsou ve tvaru *něco@altaircom.net*. Jako návratovou adresu pro mailing listy ale používám *něco@blackhole.altaircom.net*. 

Poštovní server pro doménu *blackhole.altaircom.net* je jiný, než pro běžné doručování a má zcela specifickou funkci: přijme úplně všechno, co mu kdo podstrčí, nezatěžuje se žádnými antispamovými či jinými kontrolami. Veškerou přijatou poštu syslí do fronty, resp. do jedné složky. Nad tou se v pravidelných intervalech spouští skript, který příchozí zprávy automagicky pojedná: pokud se jedná o nějakou návratovou adresu sestavenou dle principu popsaného výše, pojedná uživatele jak bylo řečeno. Pokud se jedná o něco čemu nerozumí, zprávu bez dalšího smaže dle hesla *nejdřív střílej, pak se ptej kdo tam*.

## Fáze třetí a poslední: Poučení z krizového vývoje, aneb nechte to na profesionálech

Správa opravdu velkých mailových seznamů je rozhodně netriviální. Je náročná na znalosti, technické vybavení i dostupnou konektivitu. Pro informaci, o elektronickou poštu pro mne a moje zákazníky se stará celkem pět serverů:

*   dva nezávislé front-endy slouží pro příjem zpráv z Internetu a prvotní antivirovou a antispamovou kontrolu,
*   jeden back-end slouží k ukládání pošty a odesílání zpráv autentizovanými uživateli (zákazníky),
*   další server zajišťuje rozesílání zpráv do mailing listů,
*   další server obsluhuje doménu *blackhole.altaircom.net* a zpracovává přijatá chybová hlášení.

Pokud jste odkázáni na služby hostingové firmy, která se živí převážně poskytováním služeb v ceně 50 Kč/měs. tisícům nenáročných zákazníků, je pravděpodobné, že nic z výše uvedeného nebudete schopni uvést do praxe.

**<reklama>**Pokud je to váš případ, kontaktujte mne a dohodneme se na výhodných podmínkách!**</reklama>**

Elektronická pošta je nejpoužívanější služba Internetu. S rozvojem počítačových virů a spamu hrozí nebezpečí, že parazit zahubí svého hostitele, neboť provoz větších poštovních systémů znamená velké starosti a náklady. Pokud chcete intenzivněji e-mail využívat ve svých aplikací, je nutné se naučit jak funguje a chovat se zodpovědně.