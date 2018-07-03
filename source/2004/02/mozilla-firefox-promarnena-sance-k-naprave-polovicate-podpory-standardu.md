<!-- dcterms:identifier = riderweblog#134 -->
<!-- dcterms:title = Mozilla Firefox: Promarněná šance k nápravě polovičaté podpory standardů -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Koně -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2004-02-23T04:53:46+01:00 -->
<!-- dcterms:dateAccepted = 2004-02-23T04:53:46+01:00 -->

Mnoho stránek již bylo popsáno úvahami o užitečnosti podpory webových standardů a o přístupnosti a snadné použitelnosti webů. Často z nich Microsoft se svým Internet Explorerem vychází co ten zlý tyran, pro jehož uživatele je vysvobozením z čirého světla open source pocházející Mozilla. Ve skutečnosti je to i ve své nejnovější verzi právě Mozilla, kdo minimálně na platformě Windows nabízí podporu standardů méně než polovičatou.

Předpokládám, že po přečtení titulku a abstraktu si nezanedbatelná část mých věrných čtenářů vyhrnula virtuální rukávy, hotova smést mne smrští argumentů, hojně doprovázených linky na stránky W3C. 

Vážení čtenáři, neodjišťujte revolverů svých, nebudu mluvit o podpoře HTML, DHTML, XHTML, CSS ani jiných webových standardů. Chystám se totiž mluvit u uživatelském rozhraní, nebo chcete-li <acronym title="Graphical User Interface">GUI.</acronym>
 <h2>Nakažlivé skiny</h2> 

Poslední dobou se mezi aplikacemi (alespoň pro Windows) začíná šířit možná ne zhoubná, ale o to více obtěžující nemoc: skinování. Zhusta můžete svou oblíbenou aplikaci proměnit v retro televizor, slunečnici nebo rozšlápnutou žábu - dle osobních preferencí a úchylek.

Zbaveni jha čtverhranných dialogových oken jste vtaženi do fascinujícího světa objevů a dobrodružství. Rozsáhlejší aplikace, zvláště pak v kombinaci s nějakým dostatečně kreativním skinem dokáží uživateli připravit celé hodiny zábavy. Je tohlencto <em>oné</em> funkční ovládací prvek nebo toliko výplod horečnaté představivosti grafika, sloužící ke zkrášlení pracovní plochy uživatele?

Obzvláště zábavné pocity budí podobné aplikace v jenom mém známém, který nosí brýle s asi jedenácti dioptriemi. Má svá Windows nastavena na zobrazování velkých ikon a fontů. Jeho výkřiky nadšení a obdivu autorů předmětných aplikací se za vlahých večerů nesou na kilometry daleko.

Nicméně, zanechme ironie.

Před deseti lety jsem pracoval v prostředí MS-DOSu. Používal jsem zejména DOS Navigator (něco jako Norton/Volkov Commander, ale podstatně schopnější), Text602 a Borland Pascal. Každý z těchto programů měl svoji logiku ovládání, svůj vlastní vzhled, klávesové zkratky... Jednou z hlavních výhod Windows proti MS-DOSu bylo to, že všechny aplikace vypadají stejně a ovládají se podobně. Se stejných kořenů vyrůstají i úspěchy Microsoft Office.

Existují doporučení, jak má vypadat uživatelské rozhraní aplikace pod Windows. Existují knihovny standardních ovládacích prvků, které lze k tomuto účelu snadno použít. Bohužel ale existují i programátoři, kteří jimi pohrdli a vydali se vlastní cestou.

Pokud má paměť sahá, první zásadně rozšířenou aplikací, která takto znásilnila Windows, bylo ICQ. Pak už to následovalo v rychlém sledu a skončilo o Mozilly, jejíž vývojáři - patrně z nedostatku lepší zábavy - přepsali <em>úplně všechny</em> standardní ovládací prvky Windows.

Myslím si, že schopnost skinování, tedy změny vzhledu, by měla zůstat vyhrazena window manageru, potažmo pak v případě Windows operačnímu systému. Všechny ostatní aplikace by měly tento vzhled akceptovat a přizpůsobit se mu.
 <h2>Veselá je teorie, smutně šedavá realita</h2> 

Pohleďte nicméně na dva následující obrázky. První zdařile vypodobňuje standardní ovládací prvek ListView v provedení odpovídajícím mému systémovému stylu:

![Systémový ListView](/files/lvw_system.gif)

Druhý obrázek ukazuje obdobný ovládací prvek v podání [Mozilly Firefox 0.8](http://www.mozilla.org/):

![ListView v Mozille Firefox](/files/lvw_firefox.gif)

Ponechme stranou drobné vzhledové chyby scrollbaru spočívající v nedorozumění se Mozilly s mým systémovým skinem. Systémový ListView umožňuje spoustu zajímavých věcí. Například dvojklikem na rozdělovač jednotlivých sloupců mohu šířku toho <em>vlevo</em> automaticky nastavit tak, aby odpovídala obsahu. Klávesovou zkratkou Ctrl-Num+ pak mohu totéž udělat pro všechny sloupce. Obě tyto funkce bych v Mozille hledal marně. Sloupečky lze rozšiřovat toliko manuálně, poslední z nich pak pro jistotu nijak.

Standardní dialogová okna Windows pro zobrazení vlastností - properties -mají ve spodní části tlačítka OK a Cancel (případně Apply) v uvedeném pořadí. Zobrazíte-li si ovšem například vlastnosti stránky v Mozille, najdete na místě předpokládaného zavíracího tlačítka vyvolání nápovědy.

Všechno jsou to drobnosti: podivné ikonky, v drobnostech jiné ovládání panelů nástrojů... Můžeme se přít o tom, zda logika představená Mozillou je lepší či horší, ale to je bezpředmětné. Je jiná. A to samo o sobě stačí ke zmatení uživatele, který prostě čeká něco a dostane něco jiného.

Rozmach skinování podle mého názoru úzce souvisí s masovým rozšířením uživatelů. Ubývá těch, pro které je počítač pracovním nástrojem, u kterého vyžadují pokud možno efektivitu. Naopak přibývají lidé, kterým na efektivitě práce s počítačem příliš nesejde, protože po něm chtějí, aby je bavil.

Podobnými nestandardnostmi jsou pak biti hlavně zkušení uživatelé, kteří už znají všechny triky, Windows ovládají převážně klávesnicí a pracují víceméně poslepu. Průměrný uživatel patrně vůbec netuší o existenci klávesové zkratky Ctrl-Num+, takže její ztráty neželí.

Ironické ovšem je, že napsat nestandardně se chovající aplikaci je podstatně náročnější, než držet se běžných postupů. Často se lze setkat s aplikacemi, které mají vyšperkované uživatelské rozhraní, ale obsahují - patrně z nedostatku času či zkušenosti - zásadní chyby funkčnosti.
 <h2>Mýtus platformní nezávislosti</h2> 

Častým argumentem zastánců nestandardního uživatelského rozhraní je platformní nezávislost. Taková Mozilla vypadá (prý, nezkoušel jsem to) stejně na Windows, Linuxu, MacOS...

Osobně se mi při vyslechnutí pojmů typu "platformní nezávislost" či "multiplatformní" dělá pěna u úst. Platformní nezávislost je totiž taková softwarová varianta na téma "one size fits all". Znamená, že daná aplikace pořádně nefunguje nikde, což nade vší pochybnost prokázala kdysi opěvovaná Java.

V případě uživatelského rozhraní situace není tak horká: většina chyb je hned vidět, což vede programátory k pečlivosti. Nicméně stejné uživatelské rozhraní na více systémech nepředstavuje přílišnou <em>skutečnou </em>výhodu.

Pravda, existují uživatelé, kteří střídají více operačních systémů a provozují v nich tutéž aplikaci. Ovšem existuje podstatně víc uživatelů, kteří mají jeden operační systém a v něm více aplikací. A pokud by každá z nich byla svou logikou ovládání originálem (byť multiplatformním), rychlosti práce na daném počítači by to příliš neprospělo.

Ostatně i přínos pro uživatele více operačních systémů je poněkud sporný: většinou přece nepoužívají jenom jednu aplikaci, takže zde stejně odlišnosti jsou.
 <h2>Závěrem</h2> 

Tenhle článek nemá být v žádném případě filipikou proti Mozille. Použil jsem tento program jenom jako jeden z nejviditelnějších příkladů. Musím říct, že s jistým smutkem, protože technologicky považuji Mozillu za podstatně vyspělejší browser, než Internet Explorer. A je to právě pochybné ovládání, na které si nehodlám zvykat, které mi brání v tom, abych ji začal používat.

Nejnovější verze, Mozilla Firefox, se tvářila ze začátku slibně - hlavní okno už nevypadá jako UFO z jiného světa, ale jako běžná aplikace. Zaradoval jsem se, leč nadšení mne přešlo poté, co jsem se jal Firefox blíže zkoumat - vnitřnosti jsou pořád ta stará špatná ještěrka.

Celou dobu mluvím pouze o systému Windows. Důvod je zcela prozaický: tento systém už nějaký pátek využívám, napsal jsem pro něj mnoho desítek aplikací se stovkami dialogových oken a vím jak jeho uživatelské rozhraní funguje. Předpokládám - nebo lépe řečeno v zájmu jejich uživatelů v to doufám - že i ostatní operační systémy mají nějaké ustálené konvence týkající se vytváření GUI aplikací.

Neříkám, že by všechny aplikace měly vypadat jako Windows. Říkám, že by všechny aplikace měly ctít systém, pod kterým běží.

Internet je plný článků o přístupnosti webů. A začínají se objevovat výsledky v podobě příjemných a přehledných stránek. V případě aplikací se mi zdá, že jde vývoj trochu opačným směrem a rád bych přiměl vývojáře, kteří budou číst můj článek, aby se zamysleli nad implementací předvídatelného rozhraní i do aplikací newebových.