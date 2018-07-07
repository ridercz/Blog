<!-- dcterms:identifier = aspnetcz#5 -->
<!-- dcterms:title = Jemný úvod do cacheování v ASP.NET -->
<!-- dcterms:abstract = Vhodným použitím cache lze u webových aplikací mnoho získat: snížit objem přenášených dat, zrychlit načítání stránek a snížit zatížení serveru. ASP.NET v kombinaci s IIS 6 nabízejí řadu možností, jak cache využívat. O cacheování bylo napsáno mnoho tlustých knih a i prostředí .NET nabízí mnoho různých možností. Bez nároku na úplnost si dovolím zde načrtnout něco základů. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Tipy, triky -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2005-01-05T04:06:25.267+01:00 -->
<!-- dcterms:dateAccepted = 2005-01-05T04:06:25.267+01:00 -->

Vhodným použitím cache lze u webových aplikací mnoho získat: snížit objem přenášených dat, zrychlit načítání stránek a snížit zatížení serveru. ASP.NET v kombinaci s IIS 6 nabízejí řadu možností, jak cache využívat. O cacheování bylo napsáno mnoho tlustých knih a i prostředí .NET nabízí mnoho různých možností. Bez nároku na úplnost si dovolím zde načrtnout něco základů. Bude-li zájem, mohu se některým specifičtějším záležitostem věnovat později.

## Základní principy

Správný český výraz je "vyrovnávací paměť", případně "mezipaměť". Já budu nadále, i přes mírné problémy se skloňováním, používat pojmu cache (čti *keš*) a cacheování (čti *kešování*).

Bez cacheování fungují webové aplikace zhruba takto: klient pošle požadavek na server - řekněme na titulní stránku tohoto weblogu. Ta obsahuje tři dynamicky generované části: seznam rubrik v levé části, seznam posledních článků uprostřed a RSS feedy dalších webů vpravo. Vygenerování stránky tedy vyžaduje dotazy do databáze a v případě RSS feedů dokonce načítání dat přes síť z několika dalších webových serverů.

Jest zhola zbytečné, aby se tato stránka pracně generovala pokaždé, když se na ni někdo zeptá. Údaje na ní se nemění každým okamžikem. Je tedy možné jednou vygenerovanou stránku někam dočasně uložit a po nějakou dobu posytovat tuto kopii, místo čerstvých dat. A to je princip cacheování.

Ona dočasná kopie může být uložena ledaskde: přímo na serveru (čímž se ušetří výkon serveru), na počítači klienta (čímž se ušetří také na objemu přenesených dat) nebo někde mezi, na specializovaném proxy cache serveru. Principy jsou všude stejné, takže i ASP.NET používá pro přístup k serverovému i klientskému cacheování stejné metody.

S cacheováním jsou spojeny dva základní problémy:

*   Zajistit, aby se data neukládala příliš dlouho - aby klient dostal přiměřeně aktuální data. Zajistit, aby se ukládala správná data - protože stránka se stejnou adresou může mít různý obsah, třeba na základě toho jaký uživatel je přihlášen nebo jaký browser používá. 

## Jak dlouho ukládat

Existují dvě hlavní metody, jakými jest možno určit, zda mají být v daném čase použita data z cache nebo čerstvá kopie.

### Expirace

První metoda spočívá v tom, že s daty pošlu HTTP hlavičku `Expires`. V ní uvedu čas, kdy zaslaná informace ztratí platnost. Přesné nastavení závisí na typu informace. Pokud jsem banka, která každý den ve 14:00 publikuje kurzovní lístek, mohu z toho vycházet a nastavit expiraci dat na 14:00. Bude-li můj web vydávat články každou celou hodinu, nastavím expiraci na příští celou hodinu a tak dále.

Pokud nepublikuji v odhadnutelných časových intervalech, mohu přesto expiraci používat. Ve většině aplikací není nutné, aby se veškeré změny projevily okamžitě. Svět se nezboří, když budou údaje o počtu komentářů v článku o pět minut zpožděné. Například RSS feedy v pravém sloupci tohoto blogu se aktualizují každých patnáct minut - a i to je možná příliš často.

U hodně zatěžovaných aplikací mají význam i velmi krátké časy, třeba minuta nebo deset vteřin. Co zpravidla způsobuje výkonové problémy jsou současné požadavky. Pokud budu nějakou stránku generovat jednou za deset sekund, je to z hlediska výkonu lepší, než když se bude v každé chvíli generovat třikrát současně.

Expiraci jest v ASP.NET nastaviti pomocí metody `Response.Cache.SetExpires`. Jejím jediným parametrem jest datum a čas expirace. Nastavení "platné pět minut" lze tedy dosáhnouti takto:

Response.Cache.SetExpires(DateTime.Now.AddMinutes(5))

### Datum poslední změny

Druhou možností je specifikovat datum poslední změny. Klient pak může používat tzv. "conditional get" - tedy požadavek formulovaný nějak jako "pokud se data změnila od (čas mé lokální kopie), pošli je znovu, jinak neposílej nic". Tato metoda je obzvláště efektivní u statických souborů a jiných dat, která se sice nemění příliš často, ale když už se změní, je dobré s tím počítat.

Čas poslední modifikace je možno v ASP.NET nastavit pomocí metody `Response.Cache.SetLastModified`. V praxi se často stává, že obsah stránky je generován na základě obsahu jiného souboru. V takovém případě je možno použít *file dependency* (podrobnější popis níže) a nastavit automaticky datum podle data souboru na kterém záleží:

Response.AddFileDependency("C:\data.txt") Response.Cache.SetLastModifiedFromFileDependencies()

### Praktický příklad

Vytvořte ASPX stránku a umístěte na ni prvek Label pojmenovaný LabelControl. V backendu způsobte, aby se v něm zobrazoval aktuální čas (`Me.LabelTime.Text = DateTime.Now.ToString()`). Nyní po každém reloadu uvidíte aktuální čas na serveru.

Nastavíme, aby se stránka cacheovala po dobu patnácti sekund. To lze učinit buďto direktivně nebo programově. 

Direktivně - a velmi jednoduše - lze určit některé jednodušší typy cacheování. Stačí na začátek stránky přidat odpovídající direktivu `OutputCache`, takže její HTML kód bude vypadat nějak takto:

<%@ OutputCache Duration="15" VaryByParam="none" %> <html> <head> <meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5"> </head> <body> <asp:label id="LabelTime" runat="server"></asp:label> </body> </html> 

Zcela stejného efektu jest možno dosáhnouti z programového kódu nějak takhle:

Response.Cache.SetCacheability(Web.HttpCacheability.Public) Response.Cache.SetExpires(DateTime.Now.AddSeconds(15))

Pokud budete tuto stránku reloadovat, zjistíte, že se čas skutečně mění jenom jednou za patnáct vteřin. Pokud si zobrazíte i HTTP hlavičky odpovědi (třeba pomocí [této online služby](http://www.delorie.com/web/headers.html) nebo geniálního prográmku [WFETCH](http://support.microsoft.com/default.aspx?scid=kb;%5BLN%5D;Q284285)), uvidíte něco takového:

HTTP/1.1 200 OK\r\n Date: Wed, 05 Jan 2005 02:14:38 GMT\r\n Server: Microsoft-IIS/6.0\r\n X-Powered-By: ASP.NET\r\n X-AspNet-Version: 1.1.4322\r\n **Cache-Control: public\r\n Expires: Wed, 05 Jan 2005 02:14:53 GMT\r\n ** Content-Type: text/html; charset=utf-8\r\n Content-Length: 194\r\n \r\n \r\n <html>\r\n \t<head>\r\n \t\t<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">\r\n \t</head>\r\n \t<body>\r\n \t\t<span id="LabelTime">5.1.2005 3:14:38</span>\r\n \t</body>\r\n </html>\r\n

Všimněte si výše zmiňované hlavičky *Expires* a skutečnosti, že i pokud se klient touto hlavičkou neřídí (a stále zběsile reloaduje), nepomůže si, protože stránka se cacheuje i na serveru.

## Jak zajistit, aby se ukládala správná data

Jak již bylo řečeno, v případě webových aplikací stejné URL nutně neznamená stejný obsah stránky - s ohledem na personalizaci nebo úpravu podle použitého prohlížeče. Pracujeme navíc s ASPX stránkami, které mohou být volány s řadou různých parametrů, na kterých závisí co bude obsahem. Pročež ASP.NET umožňují určit v direktivě `OutputCache` několik parametrů, podle kterých se ukládá více verzí téže stránky.

*   `VaryByParam` - Parametry a pole formuláře zasílané přes GET nebo POST. Seznam oddělený středníky, `*`  znamená všechna pole, `none` pro žádné pole (tento parametr je poviiný). `VaryByHeader` - HTTP hlavičky, jako například `Accept-Language` a podobně, seznam oddělený středníky. `VaryByCustom` - Umožňuje definovat vlastní mechanismus závislosti. Viz níže. 

Představme si například stránku, která vypisuje proměnlivý počet článků (v závislosti na parametrech `Pocet` a `Rubrika`) a používá hlavičku `Accept-Language` k tomu, aby vygenerovala obsah v patřičném jazyce. Cacheování lze nastavit direktivně takto:

<%@OutputCache Duration="60" VaryByParam="Pocet;Rubrika" VaryByHeader="Accept-Language" %>

Programově takto:

Response.Cache.SetCacheability(Web.HttpCacheability.Public) Response.Cache.SetExpires(DateTime.Now.AddSeconds(60)) Response.Cache.VaryByParams("Pocet") = True Response.Cache.VaryByParams("Rubrika") = True Response.Cache.VaryByHeaders("Accept-Language") = True

### VaryByCustom

Zvláštní a nesmírně užitečné postavení zaujímá parametr `VaryByCustom`. Pokud ho nastavíte na hodnotu `browser`, bude vygenerována nová verze stránky podle toho, jak ASP.NET identifikuje typ a verzi prohlížeče. Pokud o tuto funkcionalitu stojíte, je lepší používat toho než `VaryByHeader="User-Agent"`, protože v tomto případě se nenechá engine ošálit různými rozšířeními, které přidávají parametry do User-Agent stringu a soustředí se jenom na typ a verzi prohlížeče.

Pokud ho nastavíte na nějakou jinou hodnotu, máte možnost stanovit si vlastní mechanismus ověřování tím, že přepíšete v `GLOBAL.ASAX` metodu  `GetVaryByCustomString`. Jako její parametr obdržíte vámi určený klíč a na základě hodnoty kterou vrátíte se bude rozhodovat o cache. Například pokud se stránka generuje podle přihlášeného uživatele, můžete vrátit jeho login. Pokud je pro všechny uživatele stejná (ale odlišná od stránky pro nepřihlášené), stačí vrátit `"True"` nebo `"False"` podle toho zda je uživatel přihlášen nebo ne. Posledně zmiňovaný případ můžeme realizovat například tak, že do stránky vložíme tuto direktivu:

<%@OutputCache Duration="60" VaryByParam="none" VaryByCustom="prihlaseni" %>

Do `GLOBAL.ASAX` pak umístíme následující backend kód:

Public Overrides Function GetVaryByCustomString(ByVal context As System.Web.HttpContext, ByVal custom As String) As String If custom = "prihlaseni" Then Return context.Request.IsAuthenticated.ToString() End Function

## A to není všechno

Ačkoliv nehodlám o cacheování psát další z tlustých knih zmiňovaných v úvodu, téma je příliš široké, než aby bylo možno ho zodpovědně pojmout v jediném článku. Příště nás tedy čeká cacheování jednotlivých částí stránky (user controls) a pokročilejší metody určování závislosti na dalších objektech.