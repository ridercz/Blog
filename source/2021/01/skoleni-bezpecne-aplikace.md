<!-- dcterms:title = Pozvánka na odpolední školení Bezpečné aplikace v .NET -->
<!-- dcterms:abstract = Kybernetická bezpečnost je s ohledem na přesun mnoha aktivit do online prostoru čím dál důležitější. Napsal jsem o jejím stavu mnoho kritických článků a snažím se též přiložit ruku k dílu. Zvu vás na nově aktualizované komplexní školení týkající se bezpečnosti webových aplikací v .NET. Toto školení je určeno jak programátorům, kteří webové aplikace vytvářejí, tak IT profesionálům, kteří se starají o infrastrukturu na níž běží. Při zabezpečení totiž musejí obě skupiny spolupracovat a rozhodně není na škodu, aby jedna strana věděla, co dělá druhá. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:coverUrl = /cover-pictures/20200716-odpoledni-skoleni.jpg -->
<!-- x4w:coverCredits = Charles Deluvio via Unsplash.com -->
<!-- x4w:pictureUrl = /perex-pictures/20200329-dalsi-plany.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = IT -->
<!-- x4w:category = Akce a události -->
<!-- dcterms:date = 2021-01-23 -->

Kybernetická bezpečnost je s ohledem na přesun mnoha aktivit do online prostoru čím dál důležitější. Napsal jsem o jejím stavu mnoho kritických článků a snažím se též přiložit ruku k dílu. Zvu vás na nově aktualizované komplexní školení týkající se bezpečnosti webových aplikací v .NET. Toto školení je určeno jak programátorům, kteří webové aplikace vytvářejí, tak IT profesionálům, kteří se starají o infrastrukturu na níž běží. Při zabezpečení totiž musejí obě skupiny spolupracovat a rozhodně není na škodu, aby jedna strana věděla, co dělá druhá.

## Kdy a jak se bude školení konat?

Termín školení je **od 22. do 24. února 2021**, tři půldny po-st **od 12:00 do cca. 17:00** hodin. Půldenní školení se mi v minulosti osvědčilo, protože účastníka nevyřadí z provozu na celý den.

Školení bude probíhat online, prostřednictvím video streamu lektora a textového chatu v [eLearningovém systému společnosti Altairis](https://elearning.altairis.cz/). Součástí školení jsou podrobné cvičení/laby, kde si teoretické znalosti ihned vyzkoušíte v praxi. Zároveň slouží jako návod pro řešení typických situací v praxi. Použité řešení nevyžaduje od účastníků instalaci žádného software ani specifický hardware - stačí běžný webový prohlížeč.

Ke všem materiálům a video záznamu školení účastníkům zůstane trvalý přístup.

## Kolik školení stojí?

Cena za jednoho účastníka je **9000 Kč** + DPH. V případě více účastníků z jedné firmy (na jednu objednávku/fakturu) je cena bez DPH **8000 Kč** za účastníka.

**Zaregistrovat se můžete prostřednictvím [webového formuláře](https://forms.office.com/Pages/ResponsePage.aspx?id=DQSIkWdsW0yxEjajBLZtrQAAAAAAAAAAAANAAaGd_xhUNFQ4V0ZYR01VWjNWWk83VzBXRFhYRVdaWC4u).**

## Co je obsahem školení?

Školení je rozděleno do čtyř logických bloků:

### Zabezpečení platformy a pohled do vnitřností IIS

V této části vám ukážu, jak bezpečným způsobem nainstalovat a zkonfigurovat webový server na platformě _Windows Server_ a _Internet Information Services (IIS)_. I přes velký rozmach PaaS služeb je stále v mnoha případech provozování vlastního serveru nutné nebo výhodnější. A i v případě hostování v PaaS cloudu je dobré vědět, jak to uvnitř funguje. 

Ukážeme si, jak fungují vnitřnosti IIS - worker procesy, application pooly, jejich identity a práce s nimi. Naučím vás, jak umožnit bezpečnou aktualizaci obsahu webu přes FTP, ale také deployment pomocí _Web Management Service (WMSvc)_, který jej úspěšně dokáže více než nahradit. Také si ukážeme, jak na jednom serveru bezpečně hostovat několik nezávislých aplikací a izolovat je od sebe. A v neposlední řadě, jak celý proces provisioningu automatizovat a výrazně si usnadnit obnovu v případě havárie serveru nebo migraci na jiný server.

### Zabezpečení komunikace s klientem, aneb HTTPS správně

Použití zabezpečeného protokolu HTTPS je dnes naštěstí již běžným standardem. Ale mnoho webů ho nemá použitý a nastavený správně. V dalším logickém bloku si tedy ukážeme, k čemu je HTTPS/SSL/TLS vlastně dobré a jak ho nasadit tak, aby vám také k něčemu bylo. Ukážeme si správná nastavení IIS, ale také jak by odpovídající podpora měla vypadat v aplikaci samé.

Vyzkoušíte si též pokročilejší technologie pro práci s certifikáty, jako je _Web Hosting Store_ a _Centralized Certificate Store_, což se hodí nejenom při práci s webovými farmami.

Naučím vás, jak si vytvořit vlastní certifikační autoritu. Rozhodně to nedělejte pro produkční prostředí, ale pro vývoj a testování složitějších řešení neexistuje rozumná alternativa. Produkční nasazení ale probereme také, včetně toho jakou certifikační autoritu si zvolit a proč právě _Let's Encrypt_ :). Kompletní postup pro nasazení, zálohu a obnovení certifikátu si také naostro vyzkoušíte.

Řeč bude i o zkratkách jako SNI, HSTS, FS a dalších. Řeknu vám co znamenají a proč jsou pro vás důležité.

### Bezpečnost webových aplikací z pohledu uživatele

Dále budeme věnovat pozornost zabezpečené webových aplikací z pohledu běžného uživatele. Na první pohled se zdá, že toto téma nemá na školení pro profesionály co dělat, ale opak je pravdou. V první řadě jsou autoři aplikací i jejich uživateli a dodržování jednoduchých zásad jim může jenom prospět. V řadě druhé pak správně napsané webové aplikace v dodržování těchto zásad mohou pomoci, některé lze dokonce i vynutit a rozhodně byste jim neměli aktivně překážet. To poslední se děje v některých případech z neznalosti, pro další ovšem nemám jiného vysvětlení, že čirou zlomyslnost.

### Bezpečnost webových aplikací z pohledu vývojáře

V poslední části probereme nejběžnější bezpečnostní aspekty, rizika a chyby ve webových aplikacích se vyskytující. Základem je známý žebříček _OWASP Top 10_, ovšem výrazně doplněný specifiky platformy .NET a mými praktickými zkušenostmi (a jako celé školení, též oblíbenými historkami z praxe). Budeme mluvit jak o problémech technických (aplikace dělá něco jiného, než si autor myslí), tak zejména o problémech logických (aplikace dělá přesně to, co autor chtěl, ale bohužel to špatně vymyslel).

## Jak se přihlásit

**Zaregistrovat se můžete prostřednictvím [webového formuláře](https://forms.office.com/Pages/ResponsePage.aspx?id=DQSIkWdsW0yxEjajBLZtrQAAAAAAAAAAAANAAaGd_xhUNFQ4V0ZYR01VWjNWWk83VzBXRFhYRVdaWC4u).**

Na základě odeslané registrace vás budu kontaktovat a pošlu vám zálohovou fakturu.

## Požadavky na účastníky a vybavení

Předpokládané znalosti:

* Povědomí o fungování webových aplikací jako takových - co je HTTP, DNS, HTML, JavaScript atd.
* Základní znalost fungování ASP.NET (jakékoliv části - Web Forms, MVC, Razor Pages...).
* Základní znalost Windows Serveru jako webového serveru.

Potřebné vybavení:

* Aktualizované Windows 10.
* Aktualizované Visual Studio 2019 libovolné edice, včetně bezplatné edice Community.
* Funkční účet v Microsoft Azure, kde si vytvoříte virtuální server pro laby. Stačí funkční bezplatná trial verze. V případě využití placených služeb jsou náklady v řádu desetikorun až malých stokorun. Pokud to není možné, vytvořím vám VM na svém účtu já, ale přijdete tak o část příkladu.
* Doporučuji mít nainstalovaný TeamViewer a mikrofon, pro případ potřeby vzdálené pomoci, ale není to nezbytné.

Máte-li jakékoliv dotazy, kontaktujte mne na e-mailu _michal.valasek (at) altairis.cz_.