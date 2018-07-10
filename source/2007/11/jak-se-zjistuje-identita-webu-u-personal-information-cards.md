<!-- dcterms:identifier = aspnetcz#171 -->
<!-- dcterms:title = Jak se zjišťuje identita webu u Personal Information Cards? -->
<!-- dcterms:abstract = Zajištění soukromí uživatelů je jedním z hlavích cílů technologie Information Cards (CardSpace). V případě osobních (unmanaged) karet jsou různým webům zaslány různé údaje, takže provozovatelé těchto webů je nemohou spojit nebo zneužít. Proces zjišťování identity webů je ale dosti komplikovaný. Pojďme se na něj podívat podrobně a zabývejme se důsledky, které z něj plynou. -->
<!-- np9:categoryId = 2 -->
<!-- x4w:category = Bezpečnost -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2007-11-27T14:37:48.947+01:00 -->
<!-- dcterms:dateAccepted = 2007-11-27T14:37:48.947+01:00 -->

## Pozor, tento článek je již neaktuální

Problém popisovaný v tomto článku byl vyřešen v ISIP 1.5. Podrobnější informace najdete v [novém článku](https://www.aspnet.cz/Articles/216-reseni-problemu-s-identitou-webu-u-personal-information-cards.aspx).

## Jemný úvod do Information Cards

Technologie Information Cards, ve Windows implementována pod názvem CardSpace, si klade za cíl vyřešit různé dosud přetrvávající problémy autentizace na Internetu - převážně v případě webových aplikací. Drtivá většina současných webů používá jednofaktorovou autentizaci, založenou na sdíleném tajemství, nebo chcete-li na znalosti hesla.

Tento přístup má ale jednu velkou nevýhodu: protože uživatelé typicky používají totéž uživatelské jméno a heslo ve více systémech, může kompromitace jednoho z nich ohrozit i ostatní. Pokud se svým obvyklým loginem a heslem zaregistrujete na webu, jehož provozovatel je neschopný (a útočník získá jeho databázi) nebo zločinný (sám se stane útočníkem), budou ohroženy i další weby, jejichž provozovatelé v tom ovšem budou celkem nevinně.

Řešení tohoto problému spočívá v použití směrových (domain-specific) identifikátorů. Tedy takových údajů, které jsou platné jenom v rámci jednoho systému a mimo něj jsou bezcenné. Triviální implementace spočívá například v tom, že bychom pro jeden každý web náhodně vygenerovali unikátní uživatelské jméno a heslo.

To je ovšem pro běžné smrtelníky nereálná, pročež nám musí přijít na pomoc technologie, příkladně v podobě Information Cards. Použití osobních (unmanaged) karet probíhá následujícím způsobem:

Služba ke které se přihlašujete (relying party, RP) si vyžádá zaslání údajů o vás. Osobní karty umožňují předání kontaktních údajů (jako je jméno, e-mail atd.), ale tyto údaje nejsou nijak ověřovány, nelze je použít pro autentizaci uživatele. Pro tento účel slouží váš veřejný klíč a PPID - private personal identifier. Podle vašeho veřejného klíče, případně kombinace klíče a PPID, vás RP identifikuje a autentizuje.

Váš veřejný klíč a PPID je ale pro každý web jiný. Tyto údaje nejsou využitelné jinde, než na webu, pro který byly vygenerovány. Kdokoliv je libovolným způsobem získá, nemůže je použít k přihlášení k jinému webu, byť vy se k němu přihlašujete toutéž kartou. Pokud dají provozovatelé dvou webů dohromady své databáze, v každé budete mít jiné PPID a jiný veřejný klíč. Nebudou tedy schopni tyto databáze mezi sebou propojit. To je žádoucí efekt - chrání vaše soukromí. Pokud je žádoucí databáze propojovat, máme možnost použít managed karty a vlastního identity providera, kde jsou pravidla hry jiná.

## Zjištění totožnosti webu

Proces probíhá tak, že se zjistí, k jakému webu se připojujete - identifikuje se, a v některých případech (při SSL připojení) též autentizuje pomocí certifikátu serveru. Zjištěné údaje se potom použijí k vygenerování vašeho klíče a PPID, který se pak webu pošle. Tím je zaručeno, že tentýž web dostane vždy tytéž údaje, ale různé weby vždy různé.

Nejdůležitějším místem celého mechanismu tedy je, na základě čeho weby prohlásíme za totožné či různé. V tomto směru mohou nastat tyto možnosti:

1.  připojení přes HTTPS (SSL) a je použit EV (Extended Validation) certifikát, 
2.  připojení přes HTTPS (SSL) a je použit běžný (non-EV) certifikát s uvedením údajů o žadateli, 
3.  připojení přes HTTPS (SSL) a je použit běžný (non-EV) certifikát bez uvedení údajů o žadateli, 
4.  připojení přes HTTP, žádný certifikát není k dispozici.

V každém z těchto případů se postupuje jinak a každé z těchto řešení má svá úskalí.

### HTTPS s EV certifikátem

Certifikáty s rozšířenou validací (Extended Validation, EV) jsou relativní novinkou. Při jejich vydání je žadatel podrobně prověřován: ověřuje se název firmy, sídlo, zda je žádající osoba oprávněna jednat za společnost atd. Celý proces je poměrně komplikovaný, administrativně náročný a drahý - ceny EV certifikátů se pohybují řádově ve stovkách dolarů a jejich získání může trvat i několik měsíců.

![EV certifik&aacute;t](https://www.cdn.altairis.cz/Blog/2007/20071127-20071124-EVCert_5.png) 

Vizuálně se EV certifikát projeví tak, že se adresní řádek zbarví do zelena (v IE a Mozille) a v jeho pravé části se střídá název společnosti, které certifikát patří (na shora uvedeném obrázku je to Microsoft) a název certifikační autority, která jej vydala (VeriSign).

V tomto případě se z certifikátu vezmou údaje o názvu společnosti (O), místě (L), státu (S) a zemi (C). Výsledný řetězec u certifikátu na obrázku by byl: `|O="Microsoft Corporation"|L="Redmond"|S="Washington"|C="US"|`. Z něj se pak spočítá SHA256 hash a ten se použije jako identifikátor relying party.

### HTTPS s běžným (ne-EV) certifikátem, kde ale jsou uvedeny údaje o žadateli

Nižším stupněm, dnes ale zřídkakdy viděným, jest standardní certifikát, který sice nemá EV příznak, ale obsahuje údaje o žadateli - název společnosti, sídlo atd. Tyto certifikáty jsou levnější a jejich získání je jednodušší. Prohlížeč vám v takovém případě zobrazí jenom ikonku se zámečkem, s podbarvováním se IE neunavuje vůbec, Firefox použije decentní a nenápadnou žlutou.

V tomto případě se k výše uvedenému identifikátoru přidá ještě distinguished name všech certifikačních autorit, které CA vydaly a výsledný řetězec, ze kterého se bude počítat SHA256 hash, bude vypadat nějak takto: `|ChainElement="OU=Contoso Trust, Inc., O=Contoso Corporation, C=US"|ChainElement="OU=Contoso Internet Authority"|O="Microsoft"|L="Redmond"|S="Washington"|C="US"|`.

### HTTPS s certifikátem, kde nejsou uvedeny údaje o žadateli

Nejlevnější a nejběžnější typ SSL certifikátu. Stojí řádově desítky dolarů a jejich získání je téměř okamžité. Neověřuje se totiž vůbec identita žadatele ale jenom zda má kontrolu nad serverem, jehož název je uveden v Common Name (CN) certifikátu. Zpravidla tak, že žadateli CA pošle soubor s ověřovacím kódem, který je nutno na server nahrát na určené místo a na základě toho je ověřeno, že žadatel má nad serverem kontrolu. 

Údaje jako název společnosti a adresa nejsou v certifikátu uvedeny, obvykle tam najdete jenom poznámku ve smyslu "Domain control validated" nebo něco podobného. 

V tomto případě se jako identifikátor použije SHA256 hash veřejného klíče, další údaje v certifikátu se ignorují.

### HTTP, žádný certifikát není k dispozici

V budoucnu nás čeká možnost používat InfoCards i pro přihlašování na weby, které neběží přes SSL. Potřebná podpora na straně serveru je součástí Microsoft .NET Frameworku 3.5, u klienta bude podle [blogu CardSpace týmu](http://blogs.msdn.com/card/archive/2007/09/25/deploy-cardspace-on-your-site-without-a-ssl-certificate.aspx) součástí Windows Vista SP1 a speciálního patche na IE7. V takovém případě se jako identifikátor použije SHA256 hash z názvu serveru (hostname, případně IP adresy).

## Problémy ze shora uvedeného vyplývající

Ze shora uvedeného popisu vyplývají situace, kdy bude jeden web po změně certifikátu (třeba při jeho obnovení) považován za web jiný než předtím a dostane tedy jiný PPID a veřejný klíč. Pokud se tak stane, web najednou nedokáže své uživatele identifikovat a bude nutné provést přiřazení karet k uživatelským účtům znovu. Kdy se tak stane, závisí na vlastnostech připojení, viz výše.

**Pokud získáte EV certifikát, nesmíte se přejmenovat nebo přestěhovat.** To je omezení vcelku přijatelné, i když může poněkud zaskočit některé firmy, které mají ve zvyku každou chvíl se přejmenovat (zdravíme Credit Suisse aka Winterthur aka AXA). Je nicméně otázkou, nakolik bude EV certifikační procedura dostupná pro české společnosti. V tomto okamžiku mi není známo, že by nějaká česká společnost EV certifikát měla, a návody na webech CA většinou nepočítají se společnostmi mimo USA, UK a podobně.

**Pokud máte běžný certifikát s údaji o žadateli, jste na věky svázáni se svou certifikační autoritou.** Pokud ji změnite, změní se i vaše identita. Stejně tak pokud se vaše CA přejmenuje, sloučí nebo osamostatní, což je jev poměrně častý.

**Pokud máte běžný certifikát bez údajů o žadateli, přijdete o údaje při vypršení jeho platnosti.** Certifikát sice lze obnovit (renew) bez změny klíče, ale zatím všechny certifikační autority, se kterými jsem se setkal, chtěly vystavit při obnovení certifikátu novou žádost s novým klíčem, což je z hlediska bezpečnosti i obecně výhodnější.

**Pokud nemáte certifikát žádný, jste na tom paradoxně skoro nejlépe.** Dokud nezměníte název (hostname) svého webu, je identifikován vždy stejně. Zaplatíte ale sníženou bezpečností a dostupností. Data nejsou při přenosu šifrována, takže je kdokoliv může odposlechnout. Možnost zneužití odposlechnutých údajů je snížena, protože podle toho co jsem slyšel, je platnost zprávy omezena na několik minut (přesně nevím, specifikaci nemám), ale ne vyloučena. Rovněž není nijak zajištěno ověření vaší identity. Zatímco použití SSL vás ochrání proti útokům typu DNS hijacking a cache poisoning, při běžné HTTP komunikaci vás InfoCards ochrání pouze proti přehlédnutí na straně uživatele (typu "překlepové" adresy atd.).

V současné době je ale tato poslední možnost spíše teoretická, protože chybí podpora na straně klienta a očekává se až za celkem dlouhou dobu.

## Jak z toho ven?

Nastíněný problém lze řešit v zásadě dvěma způsoby. Buďto se mu můžeme snažit předejít a nebo se s ním smíříme a z občasné ztráty asociace karty s uživatelem učiníme běžný stav.

Pokud budeme chtít tomuto stavu předcházet, je klíčovým parametrem vhodná volba certifikátu, CA, potažmo dostatečně dlouhá doba jeho platnosti, pokud mám to naše CA umožní. Nejbezpečnější cesta je v tomto ohledu EV certifikát, což ale nebude pro většinu firem cesta přijatelná. Ve všech ostatních případech jsme do jisté míry vydáni na milost certifikační autoritě, nebo nemáme SSL.

Druhá možnost je přijmout tento proces a naučit se s ním žít. A po každé změně certifikátu (tedy nejčastěji jednou za rok) si prostě přiřadit kartu znovu. Pokud systém uvidí neznámé PPID, ale známou mailovou adresu, může nabídnout uživateli, že tuto kartu e-mailem ověří a přiřadí k jeho účtu, stejně jako se tak děje při registraci, případně u normálního hesla v okamžiku, kdy ho uživatel zapomene. V podstatě automatizovat proces, který stejně v systému musí být přítomen pro případ, že uživatel o kartu přijde, například při havárii počítače. Ostatně, jednou za rok si ověřit, že je mailová adresa stále funkční a stále patří uživateli, není zase tak špatný nápad.

## Radosti pionýrů

Byl jsem první v republice a jeden z prvních na světě, kdo CardSpace na svém webu ([http://akce.altairis.cz/](http://akce.altairis.cz/)) v ostrém provozu naimplementoval. Je tedy logické, že jsem jeden z prvních, kdo si na tom nabije čumák. Ostatně, to už je osud early adopterů.

Na druhou stranu: výše uvedený postup identifikace webu příliš nechápu. Očekával jsem, že klíčovým parametrem pro běžné (ne-EV) scénáře bude common name, tedy název web serveru, a že nebude záležet na certifikační autoritě, která certifikát vydala. Ostatně, takové byly i mé informace v dobách bety a jako takové jsem je šířil dál, za což se tímto postiženým omlouvám. Myslím si, že shora uvedený postup má nějaké radionální vysvětlení, ale zatím se mi ho nepodařilo zjistit.