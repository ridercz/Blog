<!-- dcterms:title = Americký zákaz cizích routerů: dobrý začátek, který ale sám o sobě nic neřeší -->
<!-- dcterms:abstract = Americká FCC dne 23. března zakázala schvalování nových domácích routerů z dovozu, s odkazem na to, že představují neúnosné riziko kompromitace dodavatelského řetězce a hrozbu pro národní bezpečnost. Rozhodnutí i jeho důvody jsou poněkud kontroverzní, ale jisté meritum jim nelze upřít. Přesto jde v důsledku spíš o prázdné gesto než co jiného. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:date = 2026-03-28 -->
<!-- x4w:category = Bezpečnost -->
<!-- x4w:category = IT -->
<!-- x4w:coverUrl = /cover-pictures/20260328-routery.jpg -->
<!-- x4w:coverCredits =  Stephen Phillips - Hostreviews.co.uk via Unsplash -->
<!-- x4w:pictureUrl = /perex-pictures/logo-fcc.svg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->

Americká FCC dne 23. března zakázala schvalování nových domácích routerů z dovozu, s odkazem na to, že představují neúnosné riziko kompromitace dodavatelského řetězce a hrozbu pro národní bezpečnost. Rozhodnutí i jeho důvody jsou poněkud kontroverzní, ale jisté meritum jim nelze upřít.
 
Federal Communications Commission je orgán americké federální státní správy, srovnatelný v českých podmínkách zhruba s Českým telekomunikačním úřadem. Jeho pravomoci jsou ale mnohem širší a mimo jiné zahrnují i typové schvalování telekomunikačních zařízení pro použití v rámci USA. Také udržuje takzvaný [Covered List](https://www.fcc.gov/supplychain/coveredlist), což je černá listina výrobců, zařízení a poskytovatelů služeb, které jsou podle zákona Secure and Trusted Communications Networks Act z roku 2019 hrozbou pro národní bezpečnost spojených států.
 
Najdeme na něm obvyklé podezřelé, zejména čínské společnosti Huawei a ZTE, ale třeba i jednoho z největších výrobců bezpečnostních kamer, společnost Hikvision (také čínskou) a další. S účinností od 23. března 2026 tam přibyla stručná položka „routery vyrobené v zahraničí“.
 
## Proč domácí routery představují bezpečnostní riziko?
 
Naprostá většina uživatelů je doma k Internetu připojena prostřednictvím nějakého domácího routeru (česky se routeru říká směrovač, ale tento pojem prakticky nikdo nepoužívá). Zařízení, které umožní k jedné internetové přípojce (přes DSL, kabelovou televizi, mobilní síť nebo cokoliv jiného) připojit více než jedno zařízení, prostřednictvím drátové nebo dnes častěji bezdrátové sítě. Může se jednat buďto o samostatné zařízení nebo zařízení kombinované s modemem pro příslušného poskytovatele (např. kabelový nebo DSL modem). Podle okolností může bát router dodán poskytovatelem připojení (typicky u kabelové televize) nebo si ho může uživatel pořídit samostatně.
 
Router je ve své podstatě počítač, srovnatelný třeba s populárním Raspberry Pi: mají většinou ARM počítač a běží na nich firmware na bázi Linuxu s nějakou nadstavbou a webovým administračním rozhraním. Z hlediska kybernetické bezpečnosti se jedná o klíčový prvek. Je přes něj vedena veškerá síťová komunikace mezi zařízeními vnitřní sítě a Internetem, ale zpravidla také mezi zařízeními vnitřní sítě navzájem. Pokud by došlo ke kompromitaci tohoto routeru, může útočník převzít kontrolu nad touto komunikací. Současné moderní šifrované protokoly na bázi TLS dokáží ochránit před některými riziky tohoto druhu, ale bohužel zdaleka ne přede všemi.
 
Bezpečnost těchto zařízení ale není na příliš vysoké úrovni. Protože se jedná o zařízení určená pro spotřebitele, je samozřejmě velký tlak na co nejnižší cenu. Takže se šetří úplně na všem. Na hardware, na software… Hardware, zejména u levnějších kousků, zvládá jenom naprosté minimum a není mnoho prostoru pro budoucí vylepšení software. Software je často postaven na zastaralých verzích softwarových komponent a výrobce o něj nedbá a nevydává aktualizace.
 
Nutno říci, že zde v minulých letech došlo k mnohým vylepšením. Konečně byla vyslyšena varování odborníků na kybernetickou bezpečnost a současná zařízení už nemají do administrace a do Wi-Fi sítí statcká hesla jako „admin“ nebo „1234“. Serióznější výrobci také lépe dbají na vydávání nových verzí firmware a zejména jejich automatickou aktualizaci. Představa, že běžný koncový uživatel bude ručně kontrolovat, zda náhodou nevyšla nová verze firmware pro jeho domácí router a jme se ji dobrovolně instalovat, je samozřejmě zcela nereálná. Nicméně to nestačí, protože na hardwarově ořezaném zařízení nejste schopni provozovat třeba dostatečně kvalitní kryptografii a podobně.
 
Koupit v dnešní době kvalitní domácí router je dosti problematické. Trh je zaplaven levnými čínskými značkami, které se od sebe liší především logem a designem plastové krabičky. Jejich alternativou je třeba domácí Turris z produkce CZ.NIC, litevský výrobce MikroTik nebo americký Ubiquiti, ale jejich produkty mají zpravidla řádově vyšší cenu, což většinu zájemců spolehlivě odradí.
 
Mnohdy navíc nemají na výběr vůbec. Například pokud si pořídíte připojení přes kabelovou televizi od Vodafone, nezbude vám než jako koncové zařízení použít jimi dodávaný router neznámé OEM provenience. Pokud přesně víte, co chcete a co máte dělat, můžete dosáhnout toho, že jej přepnete do režimu bridge, vypnete naprostou většinu jeho funkcí a bezprostředně za něj postavíte svůj vlastní důvěryhodný router. Ale stejně doma máte černou skříňku, které musíte důvěřovat).
 
Zdálo by se, že bezpečnost domácích uživatelů není až tak kritická, jenomže opak je pravdou. Za prvé, stejné technologie používají i menší a střední firmy. Velké firmy budou mít symetrickou linku na profesionální technologii, ale menší a střední firmy typicky běží na stejném hardware, který je určen pro domácnosti. A i skuteční domácí uživatelé jsou důležití. Jde i o jejich soukromí, nebo třeba zneužití jejich přípojek ke kybernetickým útokům. Ale také o to, že dnes bezpečnostní perimetr firem nekončí hranicí firemní sítě. Zaměstnanci běžně používají firemní zařízení doma a domácí ve firmě, v rámci trendů práce na dálku a BYOD (Bring Your Own Device). Takže z domácí sítě přistupují k firemním informačním systémům, e-mailu, file serverům a podobně.
 
Kromě toho, až dosud jsme předpokládali absenci zlé vůle na straně výrobce routeru a počítali jsme toliko s jeho případnou neschopností či laxností. Pokud ale budeme připustíme zlou vůli výrobce routeru, dostáváme se do zcela neřešitelné situace. Naprostá většina těchto zařízení přitom pochází z Číny nejenom fyzicky, ale byla tam i vyvinuta po hardwarové i softwarové stránce. U nás nejpopulárnější výrobci routerů a modemů jsou TP-Link, Huawei, Tenda nebo Mercusys – všechno z Číny. A platí, že každá čínská firma je povinna napomáhat čínské vládě ve věcech národní bezpečnosti, takže z tohoto pohledu výrobky např. TP-Linku nejsou o nic lepší, než výrobky démonizovaných Huawei nebo ZTE.
 
## Co se vlastně v USA stalo?
 
Je to primárně jednoduché: FCC nebude schvalovat do provozu nové modely domácích routerů, které mají zahraniční výrobce.
 
Nařízení se týká pouze domácích routerů, dokument [National Security Determination on the Threat Posed by Routers Produced by Foreign Countries](https://www.fcc.gov/sites/default/files/NSD-Routers0326.pdf), na který se FCC odkazuje, definuje pro tento účel routery jako _consumer-grade networking devices that are primarily intended for residential use and can be installed by the customer_, tedy _síťová zařízení pro běžné spotřebitele, která jsou určena především pro domácí použití a může je nainstalovat samotný zákazník_. Poněkud paradoxně se tedy netýká zařízení pro firemní využití, páteřní sítě a podobně. Ta mohou pokrývat jiné normy, ale nejedná se o blanketní zákaz jako u domácích zařízení.
 
Nařízení se netýká routerů, které jsou již schválené pro provoz v USA. Ty lze nadále provozovat, prodávat, a dokonce i nově dovážet.
 
## Je to snazší říct než udělat
 
[Zdůvodnění FCC](https://docs.fcc.gov/public/attachments/DOC-420034A1.pdf) se opírá o Trumpovu Národní bezpečnostní strategii z loňského roku, kterou se spojené státy otevřeně přihlásily k ideji izolacionismu a soběstačnosti: 

> Spojené státy nesmí být nikdy závislé na žádné vnější moci, pokud jde o klíčové komponenty, od surovin přes součástky až po hotové výrobky, které jsou nezbytné pro obranu nebo ekonomiku země. Musíme znovu zajistit svůj vlastní nezávislý a spolehlivý přístup ke zboží, které potřebujeme k naší obraně a k zachování našeho způsobu života.
 
To je prohlášení svým způsobem logické, leč bohužel dosti obtížně přetavitelné v praxi, zejména v krátkodobém horizontu, a to i pro zemi jako jsou Spojené státy. Protože prostě nemají dostatek výrobních kapacit, aby tohle mohly dokázat, a jejich vybudování je práce v lepším případě na léta, v horším na desetiletí.
 
Konkrétně v případě domácích routerů se z rozhodnutí Trumpovy administrativy mohou radovat domácí výrobci jako Cisco, Linksys nebo Netgear. Nicméně i ti jsou dnes závislí na komponentách z Číny a vybudovat kompletní výrobní řetězec v USA je běh na dlouhou trať.
 
Krátkodobě tak tento zákaz povede spíše ke stagnaci a američtí spotřebitelé si tak zažijí to, na co jsou občané Evropské unie zvyklí již dlouhá léta: z regulatorních důvodů se k nim nedostanou nejnovější zařízení a technologie ze zahraničí a budou odkázáni na to, co bylo schváleno před letošním třiadvacátým březnem. Jak rychle se domácím výrobcům podaří díru zaplnit je velká neznámá.
 
Domácí původ zařízení navíc řeší jenom část problematiky, a to tu dle mého názoru tu méně významnou: zlou vůli výrobce zařízení. Implikace, že domácí výrobci dělají zařízení z bezpečnostních hledisek kvalitnější, je falešná.
 
Zdůvodnění FCC správně připomíná, že nedokonale zabezpečené routery se podílely na řadě nedávných rozsáhlých kybernetických útoků, z nichž asi nejznámější je Salt Typhoon. Problém je, že útoky se rozhodně neomezovaly pouze na routery zahraničních výrobců. V rámci kampaně byly zneužity zranitelnosti v produktech prakticky všech výrobců, včetně amerických firem Cisco, Palo Alto Networks, Ivanti, Microsoft, Fortinet nebo Citrix. A jádrem útoku nebyly zranitelnosti v domácích routerech, ale naopak ve firemních a páteřních zařízeních. Zákaz cizích domácích routerů sám o sobě tedy opakování podobných útoků nezabrání.
 
## Jenom routery nestačí
 
Domácí routery jsem definoval jako malý počítač s ARM procesorem, na kterém běží operační systém založený na Linuxovém jádře a nějaká nadstavba. Tutéž definici lze ale použít pro desítky dalších typů zařízení. Protože úplně stejně fungují síťová úložiště (NASy), digitální video rekordéry (DVR, NVR), IP kamery, tiskárny, set top boxy, chytré televize, chytré ledničky… S jistou mírou zjednodušení lze říct, že pokud se domácí spotřebič připojuje k Internetu nebo drátové či bezdrátové síti, má v sobě s největší pravděpodobností počítač s linuxovým jádrem a nejspíš byl zcela nebo alespoň částečně vyroben v Číně. 
 
Míra rizika, kterou taková zařízení představují z hlediska bezpečnosti, je jenom o málo menší než v případě routerů. Sice přes ně nejde veškerá komunikace, ale jsou připojena do stejné sítě a škála útoků, kterou mohou provádět na ostatní zařízení je nepříjemně široká.
 
Americký zákaz dovozu domácích routerů se prezentuje jako rozhodný bezpečnostní krok, ale ve skutečnosti řeší jen nepatrný výsek mnohem širšího problému. Routery jsou jen nejviditelnější špičkou ledovce. Stejný hardware, stejné operační systémy a stejné potenciální zranitelnosti dnes najdeme v chytrých televizích, kamerových systémech, DVR/NVR rekordérech, přístupových bodech, domácích asistentech, IoT senzorech i v celé řadě zařízení, která mají k páteři digitální infrastruktury mnohem blíž než obyčejná „krabička na Wi‑Fi“. Pokud je cílem skutečná bezpečnost, pak je absurdní tvářit se, že riziko končí u routeru v obýváku.
 
Zákaz tak působí spíš jako politická deklarace technologické suverenity než jako promyšlené opatření. Bez důsledné kontroly dodavatelských řetězců, povinných bezpečnostních auditů, transparentního firmware a jasných standardů pro celou kategorii síťových a IoT zařízení zůstává celé gesto prázdné. Národní bezpečnost se nedá zajistit tím, že se zakáže jedna třída produktů – zvlášť když desítky dalších, stejně rizikových, dál proudí na trh bez povšimnutí. Pokud má mít podobná regulace smysl, musí být systémová, ne symbolická. To by si měla uvědomit zejména Evropa, pokud se bude chtít americkým krokem inspirovat. Měla by, ale chce to méně rozmáchlých gest a více seriózního uvažování.
