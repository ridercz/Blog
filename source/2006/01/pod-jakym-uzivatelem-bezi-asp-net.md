<!-- dcterms:identifier = aspnetcz#74 -->
<!-- dcterms:title = Pod jakým uživatelem běží ASP.NET? -->
<!-- dcterms:abstract = Odpověď na otázku kladenou v titulku není - bohužel - zcela triviální. Proto se pojďme na uživatelské účty webových aplikací podívat poněkud zevrubněji. -->
<!-- np9:categoryId = 2 -->
<!-- x4w:category = Bezpečnost -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2006-01-16T05:10:22.947+01:00 -->
<!-- dcterms:dateAccepted = 2006-01-16T05:10:22.947+01:00 -->

Odpověď na otázku kladenou v titulku není - bohužel - zcela triviální. Proto se pojďme na uživatelské účty podívat poněkud zevrubněji.

## Proč nás to vůbec zajímá?

Identita, pod níž náš kód běží, je důležitá, pokud přistupujeme k souborům, nebo nedejbože síťovým prostředkům. Přístupová práva musejí být nastavena tak, aby umožňovala požadovanou aplikaci.

Druhým zásadním důvodem je přístup k databázi na SQL Serveru, pokud se používá "trusted security", neboli Windows authentication. Pak je nutné nastavit SQL Server tak, aby umožnil přístup patřičnému uživateli.

Pod kterým uživatelem váš kód běží můžete zjistit následujícím způsobem:

Dim UserName As String = System.Security.Principal.WindowsIdentity.GetCurrent().Name

## ASP.NET a rozdvojení osobnosti

Před příchodem technologie ASP.NET, ve starých ASP, byla odpověď na tuto otázku jasná: ASP skripty běžely v rámci web serveru a pod jeho účtem také běžely. Onen účet je pro anonymní požadavky nastavený uživatel (obvykle `IUSR_názevserveru`), pro autentizované požadavky uživatel, jehož jméno a heslo bylo zadáno.

S příchodem ASP.NET už to tak jednoduché není, protože nyní ASP.NET aplikace neběží v rámci web serveru, ale v rámci svého vlastního "pracovního procesu" (worker process). V konečném důsledku tedy ASP.NET používá dvě identity, které mohou být stejné, nebo odlišné. Podívejme se na ně podrobněji

### Process Identity

Process Identity je účet, pod nímž běží worker process ASP.NET, tedy ASP.NET "jako takové". V jeho kontextu jsou zpracovávány události v aplikaci, jako například `Application_Start` (v `global.asax`) a podobně. Také se pod tímto účtem spouštějí operace, vyvolané z ASP.NET spuštěním nového threadu.

V případě IIS 5.0 (Windows 2000) a IIS 5.1 (Windows XP) je tímto účtem standardně uživatel `ASPNET`, vytvořený při instalaci .NET Frameworku. Toto nastavení lze změnit (pouze pro celý server) v souboru `machine.config`. Podrobnější informace na toto téma naleznete v [Q317012](http://support.microsoft.com/KB/Q317012/).

IIS 6.0 (Windows 2003) přináší nový koncept "Application Pools". Je možno založit několik poolů a každý z nich může běžet pod jiným uživatelským účtem. Standardně se používá speciální systémový účet `NETWORK SERVICE`.

### Request Identity

Pod účtem request identity se spouští kód v reakci na určitý konkrétní požadavek. Ve výchozím nastavení je request identity stejná, jako process identity - aplikace tedy běží pod uživatelem `ASPNET` nebo `NETWORK SERVICE`. Narozdíl od process identity ovšem může aplikace tuto hodnotu změnit, ve svém souboru `web.config` takzvanou impersonací. 

Pojem "impersonace" se česky překládá obvykle jako "zosobnění", ale příhodnější výraz by byl "vydávání se za (někoho)". Vaše aplikace se patřičným zápisem v konfiguračním souboru může vydávat buďto za konkrétního uživatele, nebo tuto hodnotu převezme z web serveru.

<?xml version="1.0"?> <configuration> <system.web> <identity impersonate="true" /> </system.web> </configuration>

Zapíšete-li do `web.configu` direktivu `<identity impersonate="true" />`, převezme váš kód identitu uživatele web serveru. Pro tu platí totéž, jako pro staré ASP 3.0. Pro přihlášeného uživatele se použije jeho identita, pro anonymního uživatele účet dle nastavení web serveru, standardně `IUSR_názevserveru`.

Můžete impersonovat též konkrétního uživatele, a to zadáním jeho uživatelského jména a hesla:

<?xml version="1.0"?> <configuration> <system.web> <identity impersonate="true" userName="JohnDoe" password="P@s$w0rd" /> </system.web> </configuration>

## Zvláštní případ: ASP.NET Development Server

Vše výše uvedené platí pro Microsoft Internet Information Services (IIS). Při vývoji aplikací pro ASP.NET 2.0 se ale často používá ASP.NET Development Server, který je součástí vývojového prostředí (Visual Studio 2005 nebo Visual Web Developer Express). Tento speciální vývojářský web server však běží v kontextu právě přihlášeného uživatele. Request identity i process identity je tedy vaše vlastní.

Toto mějte na paměti, protože většina vývojářů pracuje pod účtem s administrátorskými oprávněními - a to znamená, že vaše webová aplikace běží jako admin také. To samo o sobě nepředstavuje žádné bezpečnostní riziko (protože ASP.NET Development Server nepřijímá požadavky ze sítě, ale jenom z lokálního počítače), ale pokud si to neuvědomíte, můžete se při ostrém nasazení dočkat nepříjemných překvapení.

Ostatně - i mistr tesař se utne: tento článek píši pod dojmem několikahodinového zjišťování, proč mi jedna webová aplikace po nasazení na web server nefunguje jak má. Neuvědomil jsem si totiž, že spustím-li ze stránku nový thread, nespustí se pod request identity, ale pod process identity, která má v mém případě podstatně omezenější práva.