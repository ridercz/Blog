<!-- dcterms:identifier = aspnetcz#265 -->
<!-- dcterms:title = IIS Network Diagnostic Tools: Ping a Traceroute pro váš server -->
<!-- dcterms:abstract = Neocenitelnými nástroji pro diagnostiku síťových problémů všeho druhu jsou příkazy ping a traceroute (tracert). Pro zjištění, ve které části síťové infrastruktury je ale obvykle žádoucí spustit je z několika různých míst. Existuje proto množství veřejných serverů, které vám tyto nástroje umožní spustit. Ukážeme si, jak takovou službu napsat v ASP.NET a provozovat na IIS. -->
<!-- np9:categoryId = 4 -->
<!-- x4w:category = Programování -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2010-05-22T18:03:17.313+02:00 -->
<!-- dcterms:dateAccepted = 2010-05-22T18:03:17.313+02:00 -->

Neocenitelnými nástroji pro diagnostiku síťových problémů všeho druhu jsou příkazy `ping` a `traceroute` (`tracert`). Pro zjištění, ve které části síťové infrastruktury je ale obvykle žádoucí spustit je z několika různých míst. Existuje proto množství veřejných serverů, které vám tyto nástroje umožní spustit. Jejich přehled najdete například na [www.traceroute.org](http://www.traceroute.org). Chce to ovšem trpělivost, řada serverů tamo uvedených je nefunkční.

V zájmu rozmnožení jejich řad jsem napsal webovou aplikaci (přesněji modul pro IIS), který umožňuje jednoduše nabídnout možnost pingu a traceroute na jakémkoliv serveru. Jmenuje se **IIS Network Diagnostic Tools** a je zdarma ke stažení na [http://iisnetdiag.codeplex.com/](http://iisnetdiag.codeplex.com/).

## Co umí PING

Příkaz `ping` funguje tak, že vygeneruje náhodná data (na Windows typicky 32 bajtů, neřeknete-li jinak) a jako ICMP echo request je pošle cílovému klientovi, tedy počítači, jehož dostupnost chcete ověřit. Ten tatáž data pošle v podobě ICMP echo reply zpátky. Pingající počítač pak dokáže zjistit, jak dlouho to trvalo, případně zda vůbec dostal odpověď.

Ping má následující podstatné parametry:

*   **Objem dat** – nezáleží na jejich obsahu, ale na objemu. V mezních situacích se mohou sítě chovat různě pro malé a velké pakety. 
*   **Timeout** – čas (obvykle udávaný v milisekundách) za který musí dorazit odpověď. Nedorazí-li, ping vypíše populární "Request timed out". 
*   **Počet požadavků** – vzhledem k povaze ICMP nemá zaslání jednoho paketu příliš velkou vypovídací hodnotu. Jeden ztracený ping nic neznamená. Typicky bych tedy pošleme větší množství a vyhodnocujeme je statisticky. 
*   **TTL** – zákeřná a často nepochopená hodnota "time to live". Nemá v zásadě nic společného s časem, ale je to počet "skoků", které může request vykonat, tj. přes kolik routerů může požadavek projít. Pokud nedosáhne svého cíle před vypršením tohoto čísla, zobrazí se stav "TTL expired in transit".   

Norma RFC1122 sice stanoví, že každý počítač musí ICMP echo request přijmout a také na něj odpovědět, ale v dnešní době je to bohapustá teorie a zbožné přání. Velké množství firewallů ping blokuje, z údajně bezpečnostních důvodů. Pokud vám tedy neznámý počítač neodpovídá na ping, samo o sobě to nic neznamená, klidně může běžet a fungovat.

## Co umí TRACEROUTE

Příkaz `traceroute` (na Windows `tracert`) představuje jenom komplikovanější formu použití příkazu ping. Jeho cílem je zobrazit cestu, jakou pakety šly. Ping vám řekne jenom, jestli se k danému cílovému počítači dostanete, ale už ne, kde je problém. Traceroute ano.

Postupuje tak, že opakovaně posílá `ping`, u kterého postupně zvyšuje parametr TTL. Tím vlastně "pingá" a odhaluje postupně všechny routery po cestě. Pokud některý neodpoví, nenechá se tím odradit a pošle další požadavek s TTL o jedna vyšším. Pokračuje, dokud mu neodpoví cílový stroj a nebo dokud není vyčerpán celkový počet pokusů (standardně 30).

## IIS Network Diagnostic Tools

Funkcionalita PINGu je v .NETu součástí třídy `System.Net.NetworkInformation.Ping`. Je tedy velmi snadné si obě dvě služby napsat.  IIS Network Diagnostic Tools sestávají ze čtyř tříd:

*   `FormHandler` je HTTP handler, který umí zobrazit úvodní HTML formulář. 
*   `PingHandler` je HTTP handler, který zobrazí výsledky PINGu. 
*   `TraceRouteHandler` je HTTP handler, který zobrazí výsledky TRACEROUTE. 
*   `ToolsHandlerFactory` je pomocná třída, handler factory, která rozděluje práci mezi tři výše uvedené handlery. Takže není nezbytné registrovat handlery samostatně, ale stačí zaregistrovat jednu factory.   

Aplikaci včetně zdrojového kódu si můžete stáhnout na [iisnetdiag.codeplex.com](http://iisnetdiag.codeplex.com/), naživo si  ji můžete vyzkoušet z našeho serveru v [ČR](http://www7.v.altairis.cz/iisnetdiag.axd) nebo v [USA](http://www6.v.altairis.cz/iisnetdiag.axd).