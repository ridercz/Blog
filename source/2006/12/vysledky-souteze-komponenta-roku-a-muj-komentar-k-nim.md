<!-- dcterms:identifier = aspnetcz#129 -->
<!-- dcterms:title = Výsledky soutěže Komponenta roku a můj komentář k nim -->
<!-- dcterms:abstract = Před malou chvílí jsem na webu publikoval oficiální výsledky soutěže Komponenta roku 2006, kterou vyhlásily společnosti Altairis, Gopas a Microsoft. Srdečně gratuluji výhercům! -->
<!-- np9:categoryId = 6 -->
<!-- x4w:category = Akce a události -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2006-12-18T04:00:00+01:00 -->
<!-- dcterms:dateAccepted = 2006-12-18T04:00:00+01:00 -->

Před malou chvílí jsem na webu publikoval oficiální výsledky soutěže[Komponenta roku 2006](http://komponenta-roku.aspnet.cz/), kterou vyhlásily společnosti Altairis, Gopas a Microsoft. Srdečně gratuluji výherci, kterým se stal Jiří Kanda a jeho control Scriptlet.

Výhercem soutěže uživatelů, kterou laskavě sponzorovala firma Rebex, se stal Pavel Zaruba a jeho FineGraph.

Rád bych poděkoval všem, kdo se na soutěži jakkoliv podíleli za jejich snahu a čas. Doufám také, že pro autory konec soutěže neznamená konec vývoje dané komponenty, v řadě případů by to byla škoda.

## Moje komentáře k přihlášeným dílkům

Porotci (kromě mne jimi byli Michal Bláha z Vývojáře a Štěpán Bechynský z Microsoftu) hodnotili tak, že z přihlášených komponent vybral každý svých pět favoritů a přidělil jim body od 5 do 1 (čím více, tím lépe). 

Níže najdete mé hodnocení jednotlivých komponent, včetně pořadí, jaké jsem jim přisoudil ve svém hodnocení. Publikuji ho proto, abych poskytl jednotlivým autorům feedback a inspiroval je k možnému dalšímu vylepšení jejich děl.

### Blink (Pavel Růžička)

 [http://pavel-ruzicka.net/komponentaRoku/Blink.html](http://pavel-ruzicka.net/komponentaRoku/Blink.html) 

Můj vztah k této komponentě je z velké části predestinován tím, že blikání čehokoliv kdekoliv nesnáším. Sama idea mi tudíž přijde poněkud pochybená. Komponenta sama je nicméně funkční, ač svou podstatou triviální. Neobsahuje žádnou dokumentaci, což alůe nahrazuje[článkem na Intervalu](http://interval.cz/clanky/nahrada-js-alertu-blikajicim-textem-jako-server-control-v-asp-net/).

### Bot Discover (Dušan Janošík)

 [http://dealer-software.qsh.cz/produkty/botdiscover/default.aspx](http://dealer-software.qsh.cz/produkty/botdiscover/default.aspx) 

Komentářový spam a jemu podobné techniky učinily z CAPTCHA validátoru, který umí oddělit uživatele od robotů, prakticky nutnost. Přihlášená komponenta si po stránce generování obrázku zaslouží úctu: má řadu možných stylů a vždy generuje čitelný kód (vyhýbá se například matoucím kombinacím jako O/0 nebo I/1). Rozhodně se jedná o jeden z nejlepších CAPTCHA generátorů, který jsem viděl.

Bot Discover je dodáván včetně setupu a dokumentace. To je na první pohled dobré, na druhý mi setup pro tanto jednoduchou aplikaci přijde poněkud jako overkill, obecně nemám dobrý pocit, když mám na svém počítači spouštět nějaké EXE, přivítal bych i možnost stažení pouhého ZIPu.

Chválím přítomnost dokumentace ve formátu CHM, méně pak už její obsah. Je jistě přínosné, když je v ní napsáno, že vlastnost AuthorizationEnabled "*Specifies whether the referer url authorization is enabled.*" Ještě přínosnější by však bylo, kdyby autor někde vysvětlil, co že to umí (předpokládám že kontrolu HTTP hlavičky 'Referer', proti externím odkazům). "URL Authorization" ale v .NETu znamená něco jiného. Dokumentace také obsahuje odkazy na vlastnosti, které komponenta nemá (typu BackColor a podobně).

Jako menší nevýhodu komponenty vidím, že se nedá nastavit adresa handleru pro generování obrázku, což může v některých ohledech dost vadit.

Daleko větším problémem je ale způsob, jakým se předává údaj mezi komponentou ve stránce a validátorem. První problém je v tom, že se k tomu využívá session. Pokud session ve svých aplikacích máte vypnutou, komponenta nejenom že nefunguje, ale navíc se tiše zhroutí s všeobecně oblíbenou *NullReferenceException *- autor zjevně nepředpokládal, že by někdo mohl session vypnout.

Problémů nejste ušetřeni ani v případě, že vaše aplikace Session umí. Pro identifikaci jednotlivých CAPTCHA požadavků se totiž využívá ID prvku, u nějž autor předpokládá, že bude vždy unikátní a že uživatel bude mít otevřenou vždy jenom jednu stránku. Pokud budete mít ve své aplikaci CAPTCHA prvků několik a uživatel si otevře víc oken, nehne se z místa, nepozná se, který obrázek k čemu patří.

Třetí nevýhodou je, že Bot Discover nelze zapojit do standardního validačního procesu stránky, nechová se jako validátor. Validaci správbně zadaného kódu tedy musíte provádět zvlášť.

Bot Discover má výborně zvládnutou část generování ověřovacího kódu. Bohužel, nezvládnutý zbytek znamená, že je prakticky nepoužitelný pro složitější aplikaci. Pokud se ale autor poučí a vývoj neskončí s koncem soutěže, může být výsledek skvělý.

 *Pro nadějnost jsem tento prvek umístil na páté místo svého hodnocení.* 

### Canvas Control (Jan Joska)

 [http://www.prevozy.cz/canvas/](http://www.prevozy.cz/canvas/) 

Canvas Control si klade za cíl překlenout problém daný přímo v principech HTML: že obrázek nemůže být součástí stránky, lze se na něj jenom odkázat a nelze ho tedy generovat ve stránce samé. Využívá velmi vtipné řešení, spočívající v zavolání správného delegáta ve stránce, což znamená že generování je velmi efektivní.

Výtečná je též dokumentace: je přiložen podrobný popis činnosti (včetně UML diagramů) a příklady jsou bohatě komentovány.

Jedinou nevýhodou je, že vyžaduje v IIS registraci přípony **.img* na ASP.NET. Tato komponenta je tedy nepoužitelná v podmínkách běžného hostingu. Tato nevýhoda je díky konstrukci komponenty triviálně odstranitelná, stačí přidat konfigurovatelný odkaz na handler.

 *V mém soukromém hodnocení tato komponenta obsadila první místo za dobrý nápad a profesionální implementaci.* 

### EnhancedHtmlForm (Pavel Růžička)

 [http://pavel-ruzicka.net/komponentaRoku/EnhancedHtmlForm.html](http://pavel-ruzicka.net/komponentaRoku/EnhancedHtmlForm.html) 

Druhá z pěti komponent přihlášených nejproduktivnějším účastníkem Pavlem Růžičkou. Řeší problém opakovaného odeslání formuláře a umožňuje nastavit jinou "action" pro form. 

Řešení opakovaného odeslání je funkční, i když na můj vkus příliš komplikované (místo zakázání odesílacího tlačítka stornuje klik v JavaScriptu a efektu "disabled" dosahuje pomocí filtru dostupného jenom v Internet Exploreru. Ideu změny "action" formuláře pokládám za dost diskutabilní, s ohledem na věci jako ViewState a podobně. Autorem specifikované využití při URL rewritingu je sice možné, ale existují mnohem jednodušší metody, jak dosáhnout téhož. Přestože použitý JavaScript je v podstatě statický, komponenta ho generuje pokaždé znovu a vkládá přímo do stránky, mnohem elegantnější by bylo načítat ho pomocí *WebResource.axd*, jak to ostatně dělají vestavěné prvky.

Komponenta neobsahuje žádnou dokumentaci. Výhodou je, že je dodána včetně zdrojového kódu, i ten je však prost jakýchkoliv komentářů.

### FineGraph (Pavel Záruba)

 [http://paza.aspweb.cz/](http://paza.aspweb.cz/) 

FineGraph je dobrá idea, které bohužel podráží nohy nedomyšlená implementace. Ona dobrá idea spočívá v tom, že není lehké v ASP.NET generovat jednoduché grafy. Existují sice obsáhlé balíky schopných komponent, ale pokud chcete nakreslit jednoduchý čárový graf, je zbytečně drahé si je kupovat. A psát si je sám je obtížné. FineGraph generuje grafy celkem pěkné a přehledné, umí si sám určit měřítko a tak dále.

Na druhou stranu, komponenta sama je nepříliš povedeným hybridem server controlu a backendové třídy. Využívá ke generování dočasné soubory (takže ASP.NET musí mít právo zápisu do svého adresáře). Nepodporuje deklarativní databinding. Omezené jsou i možnosti nastavení zobrazení (nelze třeba zrušit okraj okolo obrázku), ani neumí v jednom grafu zobrazit několik řad.

Nevýhodou je též absence jakékoliv dokumentace. Je k dispozici zdrojový kód, ani ten však není komentován.

Jedná se o slibný koncept a pokud na něm autor zapracuje, může být úspěšný, ale ve své stávající podobě je obtížně použitelný. *Proto jsem ho ve svém hodnocení umístil na čtvrté místo.*

### GpsTextBox (Stanislav Tvrz)

 [http://traininfo.aspweb.cz/GpsTextBox/Default.aspx](http://traininfo.aspweb.cz/GpsTextBox/Default.aspx) (adresa je v době psaní článku nedostupná)

Odpověď na můj "wish", toužící po komponentě, která by dokázala civilizovaným způsobem načítat GPS souřadnice. TextBox toto dělá způsobem zcela odpovídajícím, umí převádět jednotlivé reprezentace mezi sebou a další.

### ImageViewLink (Pavel Růžička)

 [http://pavel-ruzicka.net/komponentaRoku/ImageViewLink.html](http://pavel-ruzicka.net/komponentaRoku/ImageViewLink.html) 

Tento control generuje odkaz pro zobrazení obrázku v novém okně definované velikosti. Celá tato operace je (logicky) generována jednoduchým klientským skriptem a balit ji do server controlu mi přijde zbytečně komplikované.

### IntelliSoft Error Mapping Module (Jan Aubrecht)

 [http://www.intellisoft.cz/ErrorMapping/](http://www.intellisoft.cz/ErrorMapping/) 

Modul umožňuje reagovat na běhové chyby v aplikacích. Sestává ze dvou základních částí: jedna umožňuje zobrazovat různé chybové hlášky různým uživatelům a druhá zasílat zprávy o chybách e-mailem. 

První část je dle mého soudu zcela zbytečná. Základní zpracování chyb včetně zobrazení různých chybových hlášek pro různé chyby umí ASP.NET nativně pomocí nastavení Custom Errors. Nemá pravda tak široké možnosti nastavení různých reakcí na různé chyby, ale to upřímně řečeno nepokládám za vlastnost, kterou by většina autorů nějak zásadněji využila.

Odesílání zpráv o chybě je druhá, užitečnější část tohoto modulu. Generování zpráv se komponenta zhostí s úspěchem, horší je to s jejich odesíláním. Modul umí rozesílat zprávy pouze pomocí SMTP, mail pickup service nepodporuje. SMTP je pomalé a nespolehlivé, takže pokd si šikovně nastavíte posílání zpráv, máte zaděláno na pěkný DoS útok.

Parametry pro odesílání pošty (název serveru, uživatel, heslo...) se musí konfigurovat zvlášť, nikoliv pomocí k tomuto účelu určené konfigurační sekce přímo v .NETu. Znamená to, že konfiguraci budete muset do web.configu ve většině případů napsat dvakrát, jednou pro standardní aplikace, jednou pro tento modul.

Přítomna je kvalitní a přehledná dokumentace.

### Stránkovací komponenty

Stránkování záznamů je úkolem častým a právě proto tento úkon přitáhl pozornost hned třech účastníků, jejichž díla si dovolím zhodnotit společně:

 **Pager (Jan Záruba): ** [ **http://dzonny.asp2.cz/** ](http://dzonny.asp2.cz/) 

Velmi pěkná stránkovací komponenta, která přináší komfort stránkování GridView i do dalších prvků. Výhodou je, že dobře zapadá do ASP.NET infrastruktury, podporuje deklarativní binding atakdále. Nevýhodou je, že jeho přístupnost je stejně mizerná, jako jeho vzoru, vše je založeno na JavaScriptových postback odkazech.

 **Pagination (Pavel Růžička): ** [ **http://pavel-ruzicka.net/komponentaRoku/Pagination.html** ](http://pavel-ruzicka.net/komponentaRoku/Pagination.html) 

Komponenta, která může se ctí nahradit standardní. Má obdobné vlastnosti jako standardní stránkování, ale funguje i bez JavaScriptu - využívá RadioButtony a tlačítka pro formuláře. To je rozhodně lepší než nic, na druhou stranu ani tato komponenta neřeší neindexovatelnost takto stránkovaných dat.

 **PagingRepeater (Jakub Malý): ** [ **http://trupik.aspweb.cz/PagingRepeater.aspx** ](http://trupik.aspweb.cz/PagingRepeater.aspx) 

Tato komponenta je jakýmsi křížencem SqlDataSource, Repeateru a pageru. Aktuální číslo stránky si předává pomocí QueryStringu, což je nepochybně plus. Na druhou stranu je ovšem hodně omezená na určitý scénář použití, protože si dynamicky dogenerovává části SQL příkazů. Je také použitelná výhradně proti SQL databázi, nepodporuje standardní data binding.

### Převod IP adresy na skutečné umístění (Jan Vilášek)

 [http://hans.aspweb.cz/IpToAddress.aspx](http://hans.aspweb.cz/IpToAddress.aspx) (adresa je v době psaní článku nedostupná)

Implementace zajímavé služby [GeoIP](http://www.maxmind.com/). Bohužel ukradená a navíc mizerně. Autor vzal[referenční C# aplikaci](http://www.maxmind.com/app/csharp) dostupnou na webu výrobce, vymazal z ní polovinu kódu a zbytek přihlásil do soutěže. Referenční aplikace je dostupná pod GNU GPL, což autor jaksi zapomněl ve výsledku uvést, stejně jako zdrojový kód zveřejnit.

### Scriptlet (Jiří Kanda)

 [http://www.kanda.eu/programming/scriptlet/](http://www.kanda.eu/programming/scriptlet/) 

Tato komponenta slouží k pomoci při generování JavaScriptů v ASP.NET stránkách. Ukázky vypadají slibně a dostupný a rozumně komentovaný zdrojový kód taktéž. Projektu ale podráží nohy neexistující dokumentace, což je u takto složité komponenty docela problém.

 *Scriptlet soutěž vyhrál, já jsem ho umístil na druhé místo.* 

### ScheduledAdrotator (Pavel Růžička)

 [http://pavel-ruzicka.net/komponentaRoku/ScheduledAdRotator.html](http://pavel-ruzicka.net/komponentaRoku/ScheduledAdRotator.html) 

Rozšíření standardního prvku AdRotator o možnost omezit datum a čas v němž se má určitý banner zobrazovat. Poměrně elegantní řešení, škoda jen, že k rozšíření standardního XML souboru nevyužívá vlastní namespace a v XML obvyklý ISO formát datumu.

### Simple RichTextBox (Tomáš Herceg)

 [http://simplerichtextbox.asp2.cz/](http://simplerichtextbox.asp2.cz/) 

Komponenta umožňuje zadávání textu, formátovaného pomocí textových pomůcek, podobně jako např. ve Wiki systémech (typicky Wikipedia). Tato myšlenka je zajímavá a užitečná, bohužel implementace je dle mého soudu poněkud nešikovná, protože míchá textový zápis s klientským JavaScriptovým rozhraním. 

### SQL lokalizace ASP.NET (Jaroslav Jirava)

 [http://jirava.net/blog/pages/sql-lokalizace-aspnet.aspx](http://jirava.net/blog/pages/sql-lokalizace-aspnet.aspx) 

Snadná lokalizace webových aplikací je jednou z velkých novinek v ASP.NET 2.0. Jako řada jiných součástí .NET Frameworku i tato je implementována pomocí provider modelu. Tato komponenta představuje náhradu vestavěných RESX souborů tabulkou v databázi. Jedná se o řešení organizačně složitější a výkonově náročnější, zato však snáze udržovatelné pomocí webové administrace.

 *SQL lokalizace se v mém soukromém hodnocení umístila na třetím místě.* 

### Texy.net (Aleš Roubíček)

 [http://www.rarous.net/clanek/196-texy-net-release-candidate.aspx](http://www.rarous.net/clanek/196-texy-net-release-candidate.aspx) 

 [Texy!](http://texy.info/cs/) je další značkovací jazyk, umožňující zápis sémanticky členěného textu pomocí symbolických konstrukcí v textu. Svou koncepcí docela dobrý a "blbuvzdorný". 

Texy.net je wrapper okolo webové služby (resp. XMLRPC endpointu) na stránkách*texy.info*. Nejedná se tedy o samostatně fungující kód, potřebuje k životu přístup na toto rozhraní, což je jeho hlavní nevýhoda. Ne všude je takový přístup možný, ne všude je výkonově udržitelný a ne každý chce být závislý na dobré vůli jeho provozovatele.

Druhou nevýhodou jsou absentující příklady, je sice k dispozici dokumentace k rozhraní tříd, ta sama o sobě u takto komplexního prvku ale nestačí.