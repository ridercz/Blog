<!-- dcterms:identifier = aspnetcz#184 -->
<!-- dcterms:title = Forms authentication a session state - proč nejsou synchronní? -->
<!-- dcterms:abstract = Ticket vystavení forms authentication modulem má danou platnost v minutách a lze nastavit, že bude "sliding", tedy že platnost bude prodlužována při každém požadavku. Stejně tak session timeout se udává v minutách a také se prodlužuje při každém požadavku. Zdravý rozum tedy říká, že pokud oba parametry nastavím na stejnou hodnotu, budou tickety i sessions platit vždy stejnou dobu. Leč, není tomu tak. Pojďme se podívat na to, jak tyto mechanismy vlastně fungují. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = IT -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2008-02-16T13:55:53.117+01:00 -->
<!-- dcterms:dateAccepted = 2008-02-16T13:55:53.117+01:00 -->

Ticket vystavení forms authentication modulem má danou platnost v minutách a lze nastavit, že bude "sliding", tedy že platnost bude prodlužována při každém požadavku. Stejně tak session timeout se udává v minutách a také se prodlužuje při každém požadavku. Zdravý rozum tedy říká, že pokud oba parametry nastavím na stejnou hodnotu, budou tickety i sessions platit vždy stejnou dobu. Leč, není tomu tak. Pojďme se podívat na to, jak tyto mechanismy vlastně fungují.

## Forms authentication

Mechanismus forms authentication funguje tak, že se uživateli při přihlášení vystaví "autentizační ticket", který pak předává s každým požadavkem serveru a server dokáže podle něj uživatele ověřit. Tento ticket má z bezpečnostních důvodů časově omezenou platnost. Délka platnosti se nastavuje pomocí konfiguračního atributu *timeout* a standardně je dlouhá 30 minut. 

Pomocí konfiguračního atributu *slidingExpiration* můžete určit, od kterého okamžiku se tento čas bude počítat. Ve výchozím nastavení (*true*) platí, že pokud uživatel pokládá požadavky na aplikaci, platnost ticketu se průběžně prodlužuje. Často se to zjednodušeně vykládá tak, že platnost autentizačního ticketu je *timeout* minut od posledního požadavku. Nastavíte-li *slidingExpiration* na *false*, platnost ticketu se neprodlužuje a platí *timeout* minut od přihlášení.

Implementace *slidingExpiration* je ovšem taková, že se ticket neobnovuje při každém požadavku, ale pouze tehdy, pokud již uplynula nejméně polovina jeho doby platnosti. Tato konstrukce tam je ze dvou důvodů: Internetový prohlížeč lze zpravidla nastavit tak, aby se při příchodu cookie (kde se autentizační ticket většinou ukládá) zeptal uživatele, zda ji chce přijmout, nebo nikoliv. Pokud by se při každém požadavku cookie obnovila, musel by uživatel tento dotaz zodpovídat neustále. Druhý důvod je výkonnostní: standardní implementace forms authentication funguje tak, že tvorba ticketu je relativně náročná, neboť je nutné ho zašifrovat a digitálně podepsat.

## Session state

Session state má timeout také. Standardně je nastaven na 20 minut a počítá se od posledního požadavku na stránku. Přesněji řečeno: od posledního požadavku na HTTP handler, který session vyžaduje (implementuje interface *IRequiresSessionState*). Což sice standardně jsou všechny web formy (*.aspx), ale nemusí to být třeba váš generický handler (*.ashx).

## Co z toho vyplývá

Následující diagram zobrazuje situaci, která může nastat, pokud nastavíme platnost autentizačního ticketu i session na stejnou dobu - 20 minut.  Při prvním požadavku v čase T = 0 se vystaví autentizační ticket, který vyprší v T+20 a stejně tak se vytvoří nová session, která bude platná stejnou dobu.

![](https://www.cdn.altairis.cz/Blog/2008/20080216-20080216-AuthMissing_3.png) 

Pokud přijde v čase T+5 požadavek na běžnou stránku, prodlouží se řádně platnost session, která tedy vyprší až v čase T+25. Nicméně platnost autentizačního ticketu se neprodlouží, protože dosud neuplynula polovina doby jeho platnosti. Pokud tedy další požadavek přijde v době T+20 až T+25 (zvýrazněna žlutě), session bude stále k dispozici, ale uživatel už bude odhlášen.

![](https://www.cdn.altairis.cz/Blog/2008/20080216-20080216-SessionMissing_3.png) 

Druhý diagram zachycuje opačnou situaci. Počáteční stav je stejný, platnost ticketu i session začala v čase T=0. V čase T+15 přijala aplikace požadavek na stránku, která ale nevyžaduje session - handler neimplemenuje *IRequiresSessionState*. V takovém případě se sice prodlouží platnost autentizačního ticketu, ale nikoliv session. Pokud přijde další požadavek v čase T+20 až T+35 (opět zvýrazněn žlutě), dojde k opačné situaci, než minule. Uživatel bude přihlášen, ale session již nebude k dispozici a založí se nová (na diagramu se tak stalo v čase T+25).

Mechanismy forms authentication a session state jsou na sobě naprosto nezávislé. Ukázali jsme si, že i při stejném nastavení hodnot *timeout* může nastat situace, kdy jedna z funkcí bude k dispozici a druhá nikoliv.

Řešení je nasnadě: nepoužívejte session. A pokud už se rozhodnete ji používat, tak se nespoléhejte na to, že bude s čímkoliv synchronní, bez ohledu na to, jak nastavíte timeout.