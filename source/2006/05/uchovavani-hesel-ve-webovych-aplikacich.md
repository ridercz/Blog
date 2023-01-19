<!-- dcterms:identifier = aspnetcz#93 -->
<!-- dcterms:title = Uchovávání hesel ve webových aplikacích -->
<!-- dcterms:abstract = Ve většině případů jest povinností tvůrce aplikace, aby se ve vlastní režii postaral o bezpečné uložení přístupových hesel svých uživatelů. Tento článek se zabývá metodami jejich bezpečného ukládání a práce s nimi. -->
<!-- np9:categoryId = 2 -->
<!-- x4w:category = Bezpečnost -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2006-05-17T14:53:05.017+02:00 -->
<!-- dcterms:date = 2006-05-17T14:53:05.017+02:00 -->

Heslo francouzské revoluce „volnost, rovnost, bratrství“ se v případě webových aplikací příliš neujalo. Zpravidla je žádoucí, ne-li přímo nevyhnutelné, uživatele nějakým způsobem omezit a kastovat.

V této souvislosti se setkáváme se třemi základními pojmy: identifikace, autentizace a autorizace. Identifikace je prostá odpověď na otázku „kdo jsi?“ – pokud napíšete k tomuto článku komentář, budete požádáni, abyste prozradili své jméno. V tomto případě se vámi zadaná hodnota nijak neprověřuje, ale zpravidla bývá identifikace následována autentizací (někdy se tento proces nazývá též autentifikace). To je v podstatě odpověď na výzvu „dokaž to!“. Posledním krokem tohoto řetězce bývá proces autorizace, v němž se na základě známé identity uživatele a nějakého systému práv rozhoduje, jaké operace mu bude dovoleno vykonat.

V tomto článku nás bude zajímat autentizace, a to specificky autentizace pomocí hesla. Ve většině případů jest povinností tvůrce aplikace, aby se ve vlastní režii postaral o bezpečné uložení hesla. To lze zajistit různými způsoby.

Zdánlivě nejjednodušší způsob je prostě heslo tak jak je uložit do databáze. Jedná se také o způsob nejhorší a nejméně bezpečný. Vinou špatného zabezpečení serveru, chyby, podplacení správce nebo desítkami dalších způsobů může útočník získat přístup k databázi či jejím zálohám. 

V takovém případě došlo k totální kompromitaci nejenom vašeho systému, ale též k ohrožení dalších účtů vašich uživatelů v systémech, se kterými nemáte nic společného. Velká část uživatelů totiž používá pro všechny systémy stejné heslo. Což je z hlediska bezpečnosti sice smutná, leč vcelku pochopitelná realita. Proto byste i v případě aplikace která není sama o sobě příliš důležitá, měli věnovat bezpečnému uložení hesel pozornost.

## Šifrování

Jednou z možností je hesla před uložením do databáze zašifrovat. Tato možnost je jediná, kterou můžete použít v případě, že vámi používaný autentizační systém vyžaduje na serveru znalost hesla v otevřeném tvaru (například Digest authentication). S její implementací jsou ovšem spojeny značné obtíže, spočívající především v nezbytnosti nějak bezpečně uložit šifrovací klíč, který používáte. A nezapomenout ho pečlivě (a bezpečně) zazálohovat, protože pokud o něj přijdete, už nikdy žádného uživatele neověříte.

Bohužel, v podmínkách běžného komerčního hostingu je bezpečné uložení šifrovacího klíče v podstatě nemožné. ASP.NET sice má v tomto směru rozličné možnosti, leč ty jsou založeny na DPAPI (Data Protection API) a předpokládají možnost spuštění utility z příkazového řádku nebo možnost vykonání jistých poměrně privilegovaných operací.

Více informací:

*   [Rob Howard: Keeping Secrets in ASP.NET 2.0](http://msdn.microsoft.com/msdnmag/issues/06/05/ExtremeASPNET/)

*   [How to: Encrypt Configuration Sections in ASP.NET 2.0 Using DPAPI](http://msdn.microsoft.com/library/en-us/dnpag2/html/paght000005.asp)

*   [How to: Encrypt Configuration Sections in ASP.NET 2.0 Using RSA](http://msdn.microsoft.com/library/en-us/dnpag2/html/paght000006.asp)

## Hashování

Ve většině případů (například pokud používáte Basic nebo Forms autentizaci) nepotřebujete správné heslo znát. Potřebujete mít pouze možnost ověřit si, že heslo je stejné, jako to správné. K tomuto účelu můžete s výhodou využít hashování.

Hashování je v podstatě výpočet kontrolního součtu. Slyšel jsem pro tento proces označení „matematická ráčna“, protože je jednosměrný: z daných dat spočítáte vždy stejný kontrolní součet (hash), ale neexistuje způsob, jak z hashe rekonstruovat zpět původní data.

Nejznámější a nejrozšířenější hashovací algoritmy jsou SHA1 a MD5. Před nedávnem prolétla odbornými i mainstreamovými médii zpráva, že tyto algoritmy byly prolomeny. Je to pravda, ale ne úplně – objevený mechanismus neumožňuje rekonstruovat z hashe původní text, ale spíše umožňuje nalezení dvojic dat, majících stejný kontrolní součet. Pro náš účel jsou tyto algoritmy stále použitelné, i když s ohledem na budoucnost je vhodné zamýšlet se nad použitím pokročilejších algoritmů, jako například SHA512.

Celková idea použití hashe pro ukládání hesel je taková, že v databázi uchováváte nikoliv hesla, ale jenim jejich hashe – kontrolní součty. Ověření hesla pak probíhá tím způsobem, že vypočítáte hash zadané hodnoty a výsledek se musí shodovat s uloženou hodnotou. Pokud se vaše databáze dostane do nepovolaných rukou, nezíská útočník hesla, ale toliko jejich hashe, které jsou mu teoreticky k ničemu, protože by je musel prolomit hrubou silou, tedy vyzkoušet všechny možné kombinace a spočítat pro ně hashe.

Prakticky ale zneužít hashe lze. Oproti obecným bezpečnostním zásadám a doporučením uživatelé používají hesla krátká a odhadnutelná, případně nalezitelná ve slovníku. Na Internetu jsou volně ke stažení soubory, které obsahují seznamy obvyklých slov a hesel a k nim odpovídající hashe. Útočníkovi pak stačí porovnat tyto hashe s databází získanou útokem a slabá hesla odhalí.

## Hashování se solí

Z tohoto důvodu se obvykle doporučuje používat takzvaný hash se solí. Tato metoda spočívá v tom, že se k heslu přidá ještě nějaký další text, „sůl“ (anglicky „salt“) a teprve z toho se spočítá hash. Na rozdíl od šifrovacího klíče nevyžaduje sůl nijakou zvláštní ochranu a utajení. Sama o sobě je „sůl“ k ničemu, slouží pouze k zamezení možnosti použít předpočítané slovníky hesel.

Existují dva základní způsoby, jimiž lze „sůl“ použít. První je ten, že její hodnota je pro všechny uživatele v rámci aplikace stejná. Tak lze efektivně zabránit použití obecných slovníků předpočítaných hesel, ale pokud si útočník dá tu práci a spočítá si hesla s vaší solí, může pak takto vytvořený slovník použít proti všem uživatelským účtům.

Doporučený postup je tedy takový, že „sůl“ je generována zvlášť, pro každého uživatele. Náročnost prolomení jednoho konkrétního účtu tím sice zůstane nezměněna, ale případný úspěch nijak nepomůže útočníkovi v útoku na další uživatele.

### Implementace hashování se solí

Pokud tedy chcete používat posledně uvedenou metodu, použijte následující postup.

Při vytváření uživatelského účtu:

1.  Vygenerujte náhodný řetězec, který se použije jako sůl (použijte třeba metodu *Membership.GeneratePassword()*). Na jeho délce příliš nezáleží, já osobně používám pět znaků.
2.  Spočítejte si hash z řetězce *Heslo + Sůl*.
3.  Do databáze uložte uživatelské jméno, sůl a vypočtený hash.

Při ověření přihlášení:

1.  Načtěte z databáze sůl k danému uživatelskému jménu.
2.  Spočítejte si hash z řetězce *Heslo + Sůl*.
3.  Porovnejte, zda se vypočtená hodnota shoduje s hodnotou hashe, uloženou v databázi.

Tento postup je zcela univerzální, můžete ho použít nezávisle na zvoleném hashovacím algoritmu.

A dva malé tipy na konec:

*   Ačkoliv se s hodnotami hashů obvykle setkáte jako s řetězcem šestnáctkových číslic (Base16 encode), jedná se nativně o prostý proud bitů. Pokud hash zakódujete metodou Base64, bude kratší.
*   Navíc je hash vždycky stejně dlouhý (jeho délka vyplývá z použitého algoritmu). Můžete tedy po zakódování Base64 odstranit zbytečné výplňové znaky (padding, „=“) a k uložení v databázi použít pole typu char s pevnou délkou a ne obvyklý varchar.