<!-- dcterms:identifier = aspnetcz#246 -->
<!-- dcterms:title = Mnoho tváří ASP.NET: Používané identity a účty v průběhu věků -->
<!-- dcterms:abstract = Často kladená otázka je: pod jakým účtem běží ASP.NET? Protože je často kladena, je i často zodpovídána, leč bohužel ne vždy správně a protože se odpověď s časem (a verzemi IIS) mění, odpověď může být neaktuální. Pojďme se podívat na vývoj a současný stav. -->
<!-- np9:categoryId = 4 -->
<!-- x4w:category = IT -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2009-11-04T22:32:25.06+01:00 -->
<!-- dcterms:dateAccepted = 2009-11-04T22:32:25.06+01:00 -->

Často kladená otázka je: pod jakým účtem běží ASP.NET? Protože je často kladena, je i často zodpovídána, leč bohužel ne vždy správně a protože se odpověď s časem (a verzemi IIS) mění, odpověď může být neaktuální. I já jsem na toto téma napsal před lety [článek](http://www.aspnet.cz/Articles/74-pod-jakym-uzivatelem-bezi-asp-net.aspx). Pojďme se na problematiku podívat poněkud hlouběji, včetně historického vývoje.

## Request a Process identity

Web server a ASP.NET při své činnosti využívá tři identity:

*   **Request Identity** je identita, pod níž běží kód, který je bezprostřední reakcí na konkrétní požadavek. Zjednodušeně řečeno, všechno mezi událostmi `BeginRequest` a `EndRequest`. Většina vaší aplikace a kódu, který napíšete, běží pod request identity.
*   **Process Identity** je identita worker procesu jako takového. Pod touto identitou běží vše, co není bezprostřední reakcí na konkrétní požadavek. Například události typu ukončení session nebo start a shutdown aplikace. Také callbacky všeho druhu – odstranění položky z cache, například.
*   **Identita anonymního uživatele** (IUSR) web serveru se ASP.NET jako takových netýká, ale použije se pro požadavky na všechno ostatní, tedy zejména na statické soubory, jako třeba obrázky nebo CSS styly. Použije se v případě, že je webový uživatel z hlediska Windows neznámý, tj. není například Basic autentizací přihlášen doménový nebo lokální uživatel.  

Níže v článku používám pojmy "uživatel" a "identita". Jaký je mezi nimi rozdíl? Uživatel má klasický uživatelský účet, tak jak ho známe. Má také takzvaný uživatelský profil, což je adresář, akm se ukládají jeho nastavení. Má heslo a lze se jako on obvykle interaktivně přihlásit, prostě někam zadám jméno a heslo. Serverová Windows mají po instalaci typicky dva uživatele, první se jmenuje Guest a druhý Administrator. Uživatel může být buďto lokální (`NÁZEV_POČÍTAČE\jméno_uživatele`) nebo doménový (`NÁZEV_DOMÉNY\jméno_uživatele` nebo zřídka `jméno_uživatele@NÁZEV_DOMÉNY`).

Identita je obsažnější pojem. Kromě uživatelů, zmíněných výše, jsou ještě speciální vestavěné systémové identity. Ty se poznají podle toho, že jejich authority (tj. část před zpětným lomítkem) je speciální řetězec, který obsahuje mezeru. Takže například `NT AUTHORITY\LOCAL SYSTEM`. Poslední dobou panuje (níže dokumentovaný) odklon od tendence používat pro služby speciální dedikované uživatele a místo toho se rojí právě tyto systémové identity. Na rozdíl od běžného uživatelského účtu nemají profil, nemají heslo a nelze se na ně interaktivně přihlásit. Při komunikaci s jinými počítači po síti pak daný požadavek vystupuje pod identitou počítače samotného. Lze tedy říct, který počítač požadavek vyslal, ale už ne jaká konkrétní systémová identita na něm je za něj zodpovědná.

Tyto systémové identity také "nejsou vidět". Nenajdete je v seznamu uživatelů v user manageru, nenajdete je ani při vyhledávání třeba při nastavení práv k souborům, musíte prostě vědět, jak se jmenují.

Jaké konkrétní identity jsou pro request a process použity, záleží na verzi IIS a nastavení.

## IIS 5.x (Windows 2000, Windows XP 32-bit)

Tato verze IIS nezná application pooly (více o nich dále). Obecně běží rozšíření web serveru jeho identitou. V případě běžných veřejně přístupných aplikací pod účtem anonymního uživatele, který se defaultně jmenuje `IUSR_názevserveru`.

ASP.NET je výjimkou, která předznamenává application pooly, které se objeví v IIS 6.0. Neběží v rámci web serveru, ale v samostatném worker procesu, nezávislém na IIS. Jmenuje se `aspnet_wp.exe` a běží pod uživatelem jménem `ASPNET`, kterého vytvořil při instalaci setup .NET Frameworku.

Výchozí nastavení je tedy:

*   Identita anonymního uživatele je uživatel `IUSR_názevserveru`. Tuto identitu je možno změnit v nastavení IIS a to pro každou aplikaci (virtuální web server nebo web aplikaci) zvlášť. 
*   ASP.NET Process identity je uživatel `ASPNET`. Tuto identitu je možno změnit v `machine.config`u a nastavení je jednotné pro celý server, všechny aplikace mají tuto identitu stejnou. 
*   ASP.NET Request identity je, pokud neřeknete jinak, stejná jako process identity. Říct jinak lze pomocí impersonace ve `web.config`u, v elementu `/configuration/system.web/identity`. Pokud nastavíte atribut `impersonate` na `"true"`, podědí se identita od hostujícího webu, tj. např. na uživatele `IUSR_názevserveru`. Případně lze pomocí atributů `userName` a `password` zadat jméno a heslo jiného uživatele.   

Z důvodů popsaných výše je na IIS 5.x v podstatě nemožné provozovat bezpečný hosting více nezávislých aplikací, protože všechny mají stejnou process identity a nelze je od sebe oddělit.

## IIS 6.x (Windows Server 2003, Windows XP Professional 64-bit)

Zásadní změnou v této verzi IIS byl koncept worker processů a application poolů. Výše naznačená idea, že aplikace nepoběží v rámci web serveru, ale v samostatném worker procesu se osvědčila a byla rozšířena z ASP.NET i na další rozšíření. Nově tedy vše kromě statických souborů běží v procesu `W3WP.EXE`. A objevují se takzvané application pooly, což je organizačně-správní jednotka, prostřednictvím které IIS dokáže oddělovat aplikace, resp. skupiny aplikací, od sebe navzájem i od IIS samotného. Každý application pool má svůj vlastní `W3WP.EXE` (v rámci jednoho AP jich může být i více, ale to je nad rámec tohoto článku).

Kromě mnoha jiných nastavení lze každému application poolu určit i pod jakou identitou mají běžet jeho worker procesy a tím i process identity ASP.NET aplikace.

Výchozí nastavení a možnosti u těchto verzí tedy jsou:

*   Identita anonymního uživatele je stále IUSR_názevserveru, zde se nic nemění. 
*   ASP.NET Process Identity je standardně `NT AUTHORITY\NETWORK SERVICE`. To je speciální identita (nikoliv běžný uživatel), pod kterou nově běží velká část služeb. Process Identity lze změnit v nastavení application poolu, a to pro každý pool zvlášť. Aby mohl být uživatel použit pro identitu AP, musí být členem skupiny `IIS_WPG` (IIS Worker Process Group). 
*   ASP.NET Request Identity je opět standardně stejná, jako process identity a lze ji změnit stejným postupem jako u předchozí verze.   

Na této verzi je tedy možný bezpečný hosting více zákazníků (resp. nezávislých aplikací) na jednom serveru, pokud má každý zákazník svůj application pool.

## IIS 7.0 (Windows Vista, Windows Server 2008) a IIS 7.5 (Windows 7, Windows Server 2008 R2)

Mezi verzemi 6 a 7 doznal IIS zcela zásadních změn, ale základní systém worker processů a application poolů zůstal zachován – byl jenom rozšířen.

*   Identita anonymního uživatele se změnila. Výchozí nastavení je, že se používá speciální identita `NT AUTHORITY\IUSR`. Impersonace se nově nastavuje zde, lze nastavit konkrétního uživatele a nebo že se použije identita application poolu. 
*   ASP.NET Process Identity je opět identita application poolu a platí, že může být změněna. Výchozí nastavení je ovšem jiné. Nepoužívá se již identita `NT AUTHORITY\NETWORK SERVICE` (ačkoliv je možné ji ručně nastavit), ale speciální smečka skrývající se v konfiguraci pod názvem `ApplicationPoolIdentity`. Pro každý application pool je automaticky vytvořena speciální identita jménem `IIS APPPOOL\názevpoolu`. Tj. pokud vytvoříte AP jménem `MujAP`, bude se automaticky použitá identita jmenovat `IIS APPPOOL\MujAP`. To znamená, že jednotlivé AP jsou od sebe automaticky izolovány, bez nutnosti pro ně vytvářet samostatné uživatele. Tato možnost zůstala samozřejmě zachována, pouze se změnil název skupiny, které by tento uživatel měl být členem: jmenuje se `IIS_IUSRS`. 
*   ASP.NET request identity je pro anonymní požadavky výše uvedené identita anonymního uživatele, tj. dle nastavení buď IUSR (výchozí) nebo identita AP.   

## Typická použití, rady a doporučení

Aplikace lze rozdělit do dvou základních skupin, které z nedostatku lepších pojmů nazvu "intranetové" a "internetové", s vědomím toho, že se najdou výjimky oběma směry.

Internetové aplikace mají z hlediska systému anonymní uživatele. Tj. identitu uživatele neznáme vůbec a nebo ji zpracováváme vlastními prostředky a OS o nich "neví". Typický příklad je databáze uživatelů v SQL Serveru a přihlašování pomocí Forms Authentication. U těchto aplikací identitu aplikace nepředáváme dál (třeba na databázovou vrstvu) a je obvykle praktické, aby request identity a process identity ASP.NET aplikace byla totožná.

Aplikace, které nazývám intranetovými, jsou zpravidla určeny omezenému a předem známému okruhu uživatelů, např. zaměstnanců. Jako uživatelskou databázi používají Active Directory nebo podobný systém a jejich uživatelé nejsou z hlediska systému anonymní. Zde máme v podstatě dvě možnosti, jakým můžeme přistupovat k bezpečnostní architektuře aplikace. Buďto postupujeme stejně jako ve výše uvedeném případě, tj. uživatele sice ověříme pomocí systémového účtu, ale aplikace sama pak běží pod nějakou vlastní identitou. Druhá možnost je, že identitu uživatele převememe a aplikace běží pod účtem toho uživatele, který se přihlásil a pod tímto účtem také přistupuje k dalším zdrojům, typicky k databázi. Zde se tedy request identity podědí od autentizovaného uživatele  (zakážeme anonymní přístup) a process identity bude jiná, speciální identita pro tu kterou aplikaci.

Doufám, že se mi toto nepříliš jednoduché téma podařilo podat způsobem srozumitelným a pochopitelným. Chcete-li se v tomto oboru vzdělat hlouběji, vřele vám doporučuji svůj kurz o zabezpečení, který školím v Gopasu. Jeho kód je [GOC36](http://www.gopas.cz/kurzy/GOC36/) a stále platí, že pokud uvedete při objednávce kód ASPNET.CZ, získáte slevu (a já provizi ;-).