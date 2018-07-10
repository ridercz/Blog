<!-- dcterms:identifier = aspnetcz#344 -->
<!-- dcterms:title = Local Storage: Sbohem cookies, sbohem session? -->
<!-- dcterms:abstract = Jedna z užitečných – a kupodivu i široce podporovaných – novinek v HTML 5 se jmenuje Local Storage. Nedostává se jí tolik pozornosti, jako videu nebo elementu canvas, nicméně podle mého názoru je podstatně užitečnější. Ukážeme si, jak funguje, k čemu je dobrá a na závěr vám nabídnu užitečný nástroj pro ladění. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Programování -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2011-10-13T04:06:55.72+02:00 -->
<!-- dcterms:dateAccepted = 2011-10-13T04:06:57+02:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20111013-local-storage-sbohem-cookies-sbohem-session.jpg -->

Celá idea je ve skutečnosti velmi jednoduchá: local storage je úložiště na klientovi (ve webovém prohlížeči), kam si stránka může skriptem uložit libovolná data a potom je skriptem zase načíst. Přístup z klientského skriptu je přitom jediný možný. Data žijí jenom na klientově počítači, nepřenášejí se na server (za předpokladu, že si takový přenos sami nenaskriptujete).

Webová aplikace si takto může uložit poměrně velké množství dat (současné prohlížeče umožňují 5 MB) a to na dlouhou dobu, prakticky na věky. Přesněji dokud si uživatel nesmaže data nebo nepřeinstaluje počítač, není mi známo, že by nějaký prohlížeč implementoval expiraci, ačkoliv [specifikace s ní volitelně počítá](http://dev.w3.org/html5/webstorage/#disk-space).

Tato feature se občas nazývá i **DOM storage** nebo **HTML5 storage**. Nezaměňovat prosím s [Web SQL Database](http://dev.w3.org/html5/webdatabase/) nebo [Indexed Database API](http://www.w3.org/TR/IndexedDB/),to je něco úplně jiného a s mnohem menší podporou.

A na začátek ještě jednu dobrou zprávu: podpora **Local Storage** je velmi široká, podporují ho následující prohlížeče:

*   Interner Explorer 8.0+ (včetně Windows Phone) 
*   Mozilla Firefox 3.5+ 
*   Apple Safari 4.0+ (iPhone 2.0+) 
*   Chrome 4.0+ (Android 2.0+) 
*   Opera 10.5+ 

## Nejsou to cookies?

Nejsou. Jedná se o zcela samostatnou technologii, která se cookies podobá v jednom jediném aspektu: ukládá si nějaká trvalejší data na klienta. Dva hlavní rozdíly jsou následující:

Velikost cookies je hodně omezená. Omezení nejsou úplně jednoduchá, ale obecně se jedná o několik kilobajtů. Local Storage má v současných prohlížečích 5 MB.

Cookies se posílají při každém HTTP požadavku na server. To je dobře i špatně. Dobře to je, protože s nimi můžete pracovat na serveru, třeba z ASP.NET. Špatně je to, protože tím narůstá objem přenášených dat, což v případě velkého objemu cookies a počtu návštěv může být velmi problematické (mimo jiné z tohoto důvodu se pro Content Delivery Networks používá jiná doména, než je mateřská, např. Facebook má `fbcdn.com`, Microsoft `aspnetcdn.com` atd.).

## Jak to funguje?

Prohlížeč, který podporuje Local Storage má ve třídě `window` dvě vlastnosti: `localStorage` a `sessionStorage`. O Session Storage tady ještě nebyla řeč a příliš ani nebude – jedná se totiž o Local Storage, jejíž obsah se ztratí při ukončení session, tedy při zavření okna prohlížeče (podobně jako u session cookies). Jinak úplně všechno, co budu psát o Local Storage platí i pro Session Storage.

Úložiště je oddělené pro každý server (host name), resp. doménu. Ještě přesněji, pro každý `origin`, tedy zdroj. [Obšírnější pojednání](http://www.whatwg.org/specs/web-apps/current-work/multipage/origin-0.html) na toto téma jest nalézti na webu WHAT WG.

Vlastnost `localStorage` je kolekce (nebo řečeno jazykem JavaScriptu asociativní pole), která má stringový klíč a stringovou hodnotu. Klíč může být jakýkoliv řetězec. Pamatujte na to, že jeho porovnávání je case sensitive. Hodnota je při vkládání automaticky převedena na string a jako takovou ji dostanete zpět. Pokud si tedy uložíte něco jiného, musíte to po načtení patřičně zpracovat.

Kód pro vložení hodnoty do kolekce je jednoduchý:

    var localStorageSupported = "localStorage" in window && window["localStorage"] !== null;
    if (!localStorageSupported) {
        window.alert("Prohlížeč nepodporuje Local Storage!");
    } else {
        window.localStorage["foo"] = "bar";
    }

Kód pro načtení hodnoty je velmi podobný:

    var localStorageSupported = "localStorage" in window && window["localStorage"] !== null;
    if (!localStorageSupported) {
        window.alert("Prohlížeč nepodporuje Local Storage!");
    } else {
        var foo = window.localStorage["foo"];
        window.alert("foo = " + foo);
    }

První řádek slouží k detekci podpory technologie prohlížečem. Pak je to obyčejná práce s kolekcí. Chcete-li, můžete použít i metody `getItem` a `setItem`. Pokud chcete odstranit položku z kolekce, použijte `removeItem`, pokud chcete smazat celé úložiště, použijte `clear`. Můžete využívat i [události](http://dev.w3.org/html5/webstorage/#event-storage), ale to je mimo rozsah tohoto článku.

## K čemu je to dobré?

Úložiště Local Storage je užitečné pro řadu věcí a při správném použití může velmi ulehčit vašemu serveru a zpříjemnit uživatelům práci s vaší aplikací.

Local Storage v některých případech můžete použít jako náhradu cookies. Když napíšete k tomuto článku komentář, uloží se údaje, které jste zadali, do cookie, abyste je nemuseli příště zadávat znovu (používám k tomu [CookieExtender](http://www.aspnet.cz/articles/244-zapamatovani-hodnoty-v-cookie-pomoci-control-extenderu)). To ale zbytečně zatěžuje linku (i když vzhledem k počtu ASP.NET programátorů v zemích království českého mne to asi nezruinuje ;-) i server – doplňování se musí dít na straně serveru, i když k tomu fakticky není žádný důvod, jde čistě o klientskou věc. Kdybych to psal dneska, použil bych místo cookie Local Storage.

Obecně, Local Storage se hodí k ukládání nedůležitých osobních nastavení, zejména anonymní povahy. Proč nedůležitých? Protože se na něj (jako na cokoliv na klientovi) nemůžete spolehnout. A anonymních? Local Storage žijí na straně klienta a na váš server se obecně nedostanou. Nemusíte řešit identifikaci a přihlašování uživatelů a podobně. Pokud jste nastavení schopni realizovat na straně klienta JavaScriptem, můžete to vyřešit takhle snadno.

Ještě jednou bych rád zdůraznil, že se na Local Storage nemůžete spolehnout, a to v podstatě v žádném ohledu:

*   **Local Storage nemusí fungovat.** Uživatel může mít starý prohlížeč, případně se tato funkce dá vypnout (ačkoliv to [není jednoduché](http://webdevwonders.com/clear-dom-storage/)). Také může mít vypnutý nebo z jiného důvodu nefunkční JavaScript. 
*   **Local Storage se může kdykoliv ztratit.** Uživatel ho může smazat, změnit prohlížeč, přeinstalovat systém… Jakmile se něco takového stane, k hodnotám se nedostanete a nastavení se ztratí. 
*   **Local Storage může kdokoliv modifikovat.** Kdokoliv znamená uživatele nebo někoho s přístupem k jeho počítači, případně k síti. Není tedy dobrý nápad ukládat data, která jsou z nějakého úhlu pohledu kritická. 

Přes tyto nevýhody může být local storage velmi platným pomocníkem, zejména pro "nedůležité" věci, které ale uživateli zpříjemní práci s vaší aplikací. Pokud si na klientovi napíšete patřičnou berličku, lze data poslat v nějak serializované podobě na server, což umožní obejít některé nevýhody. Například pokud se vaši uživatelé přihlašují, můžete jejich nastavení držet současně na serveru i v local storage a při přihlášení local storage synchronizovat. Tím zařídíte, že jakmile se uživatel přihlásí na "čistém" systému, dostane "svoje" data. Ta se přitom budou přenášet jenom jednou (při přihlášení), ne při každém požadavku, jako u cookies.

## Praktický příklad: nepřečtené komentáře

Praktický příklad implementace najdete na tomto serveru. V noci na dnešek jsem nasadil novou verzi Nemesis, která umí indikovat komentáře, které přibyly od vaší poslední návštěvy. Jak to funguje? Na stránce se zobrazením článku a komentářů k němu se do local storage pod kód článku uloží aktuální počet komentářů. Na stránkách s výpisem seznamu příspěvků (třeba na [homepage](/)) se potom JavaScriptem porovná aktuální počet komentářů s takto zapamatovanou hodnotou. Pokud jich je víc, tak se u článku zobrazí upozornění na nové komentáře.

Konkrétní implementace využívá ještě jednu vlastnost HTML 5, a to jsou data atributy. Nově může každý HTML element mít neomezené množství "vlastních" atributů, které se mohou jmenovat jakkoliv, jenom musí začínat řetězcem `data-`. Na straně serveru jsem si tedy uložil u panelu pojmenovaného `comments` do těchto atributů ID aktuálního článku a počet komentářů.

ASPX markup vypadá takto:

    <asp:Panel ID="comments" runat="server" 
        Visible='<%# Eval("AllowComments") %>' 
        ClientIDMode="Static" 
        data-article-id='<%# Eval("ArticleId") %>' 
        data-comment-count='<%# Eval("Comments.Count") %>'>
    ...
    </asp:Panel>

Vygenerované HTML na straně klienta pak takto:

    <div id="comments" data-article-id="334" data-comment-count="3">
    ...
    </div>

Nutno připodotknout, že nic z toho není nezbytně nutné. ID článku i počet komentářů bych mohl zjistit z jiných věcí na stránce. Nicméně koně jsou vesměs stvoření líná, takže jsem šel cestou menšího odporu. Na straně klienta se pak spustí JavaScript, který pod klíčem `NemesisPublishing.ArticleCommentCount[334]` uloží hodnotu `3`. Syntaxe klíče s tečkami a hranatými závorkami je můj výmysl, chci v tom udělat nějaký systém, pro případ, že bych v budoucnu Local Storage využíval intenzivněji, tak aby se mi to nepohádalo.

Příslušný úsek JavaScriptu vypadá takto (a využívá jQuery, není to čistý JavaScript):

    var comments = $("#comments");
    if (comments[0] != null && 'localStorage' in window && window['localStorage'] !== null) {
        var key = "NemesisPublishing.ArticleCommentCount[" + comments.data("article-id") + "]";
        window.localStorage[key] = comments.data("comment-count");
    }

Pokud element s požadovaným ID chybí, nic se neuloží (k článku jsou zakázané komentáře a tedy není pravděpodobné, že by nějaké přibyly).

Na stránce s výpisem seznamu článků používám stejnou techniku (`data-` atributy), abych si v odkazu poznamenal číslo relevantního článku a současný počet komentářů. HTML zdroják vypadá takto (ve skutečnosti to vypadá trochu jinak, ale to není pro náš výklad podstatné, tak jsem to zjednodušil):

    <a href="articles/334#comments" 
          data-comment-aid="334" 
          data-comment-count="3">3 komentáře</a>

Opět platí, že si usnadňuji práci, protože v JavaScriptu programuji nerad a nechce se mi moc se hrabat v HTML DOMu. JavaScript na dotyčné stránce vypadá takto:

    if ("localStorage" in window && window["localStorage"] !== null) {
        $("*[data-comment-aid]").each(function () {
            var key = "NemesisPublishing.ArticleCommentCount[" + $(this).data("comment-aid") + "]";
            if (window.localStorage[key] != null) {
                var currentCount = parseInt($(this).data("comment-count"));
                var readCount = parseInt(window.localStorage[key]);
                if (currentCount > readCount) {
                    var newCount = currentCount - readCount;
                    $(this).append(" <span class='new'>" + newCount + " new<span>");
                }
            }
        });
    }

Tento skript je trochu složitější, než ten předchozí, ale ne o mnoho. Nejprve si ověřím, že Local Storage funguje a pak najdu všechny elementy, které mají atribut `data-comment-aid`. U všech těchto elementů pak zjistím, jaký je aktuální počet komentářů a jaký je poslední počet komentářů, které uživatel četl (resp. měl je zobrazené). Pokud se liší, zobrazím počet nových komentářů v textu odkazu.

Toto řešení je velmi jednoduché a podle mého názoru velmi elegantní, a to z několika důvodů:

*   Nijak nezatěžuje server ani linky. Serverovou část bych – kdybych nebyl líný – nemusel upravovat vůbec, teď je upravená minimálně.
*   Neohrožuje soukromí uživatele. Veškeré zpracování se děje na straně klienta, uživatele nijak neindentifikuji a nespojuji si jeho požadavky.
*   Nereaguje na uživatelovy vlastní komentáře. Pokud uživatel přidá nové komentář, automaticky se zvýší počet "přečtených komentářů", protože se obnoví stránka.
*   Degraduje s grácií (nebo znáte někdo lepší překlad pojmu "degrade gracefully"? ;-). Pokud uživatel nemá Local Storage nebo se prostě někde jinde něco zblázní, nejhoší věc, která může nastat, je, že se uživateli nezobrazí indikace nového komentáře, což není žádná tragédie.

Celé řešení by šlo ještě dále vylepšit, například:

*   Systém se může zakuckat, pokud nějaké komentáře smažu. To ale dělám tak jednou za čtvrtletí, takže tento problém nehodlám řešit.
*   Server vám sice řekne, že přibyly nové komentáře, ale už vám neukáže, které to konkrétně jsou. Bylo by možné sledovat stav přečtení jednotlivých komentářů a reagovat na něj. To možná dopíšu, až nebudu mít nic lepšího na práci.
*   Záznamy nijak nepročišťuji a neošetřuji chyby. Pokud se tedy přidělená kvóta vyčerpá, dojde k chybě. Tento problém ignoruji, protože objem ukládaných dat je tak malý, že zahlcení fakticky nehrozí. Nicméně pokud byste ukládali větší objemy dat, je dobré vymyslet nějaký mechanismus, jakým se již nepotřebné záznamy budou odstraňovat. Zde bych třeba mohl napsat složitější kód, který by uchovával údaje jenom pro např. 100 nejnověji vydaných článků (u starších je nepravděpodobné, že je uživatel najde ve výpisech a zároveň se zapojí do diskuze).

## Local Storage Explorer a Session Storage Explorer

Nenašel jsem žádný nástroj, kterým bych mohl prohlížet a manipulovat obsah local storage. Tak jsem takový napsal. Sestává ze dvou HTML stránek (`lsexp.html` a `ssexp.html`), které se předpokládá, že si nahrajete na web, jehož storage chcete zkoumat. Když si tyto stránky zobrazíte, ukáže se vám seznam všech položek uložených v Local Storage (`lsexp.html`) nebo Session Storage (`ssexp.html`). Položky můžete odstraňovat, editovat a nebo celé úložiště vymazat. Oba soubory si můžete stáhnout a používat dle libosti.

V době psaní tohoto článku jsou oba soubory nahrané i v rootu serveru [www.aspnet.cz](http://www.aspnet.cz), takže si můžete pohrát třeba právě s indikací nových komentářů. Při nějakém dalším update ty živé verze zase odstraním, takže se na jejich existenci moc nespoléhejte.

*   [20111013-local-storage-explorer.zip](https://www.cdn.altairis.cz/Blog/2011/20111013-local-storage-explorer.zip) (4kB – download)
*   [Local Storage Explorer](/lsexp.html) (živý)
*   [Session Storage Explorer](/ssexp.html) (živý)