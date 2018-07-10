<!-- dcterms:identifier = aspnetcz#301 -->
<!-- dcterms:title = Skripty pro vytváření webů a uživatelů na IIS 7.0 -->
<!-- dcterms:abstract = Na Microsoft Days jsem slíbil zveřejnit skripty, které používám pro správu svých web hostingových serverů, jmenovitě pro zakládání nového uživatele a přidání webu k existujícímu uživateli. Tady jsou. -->
<!-- np9:categoryId = 4 -->
<!-- x4w:category = Programování -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2010-09-24T22:15:40.07+02:00 -->
<!-- dcterms:dateAccepted = 2010-09-24T22:24:29.617+02:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20100924-skripty-pro-vytvareni-webu-a-uzivatelu-na-iis-7-0.png -->

Na Microsoft Days jsem slíbil zveřejnit skripty, které používám pro správu svých web hostingových serverů, jmenovitě pro zakládání nového uživatele a přidání webu k existujícímu uživateli. Pokud jste na mé přednášce tamo nebyli, tak se jedná do jisté míry o logické pokračování video seriálu o konfiguraci hostingového serveru, kterou najdete na [MSTV.CZ](http://www.mstv.cz/). Vzhledem k tomu, že se jedná o úchylnou "rich internet application" v Silverlightu, nemohu vám poslat přímý odkaz na celý seriál, pouze návod: 

1.  Vyberte oblast "IT odborníci". 
2.  V seznamu autorú vyberte "Michal Altair Valášek" 
3.  V seznamu témat vyberte "Hostování"   

V archivu, který si můžete stáhnout na konci tohoto článku,  najdete dva soubory: `newcust.cmd` a `newsite.cmd`. Tyto soubory předpokládají, že budete mít architekturu podobnou, jako ve výše uvedeném seriálu, jenom nepočítají s během Application Poolu pod specifickým uživatelem, ale předpokládají automatickou identitu AP.

Před použitím je třeba nastavit některé systémové proměnné, které najdete na začátku skriptů:

*   `APPCMD` je cesta k souboru appcmd.exe (musíte mít nainstalované IIS Management Script and Tools). Výchozí cesta je `%SYSTEMROOT%\System32\inetsrv\appcmd.exe` a téměř jistě nebude nutné ji měnit. 
*   `ROOT_FOLDER` je cesta k adresáři, kde budou uloženy adresáře jednotlivých zákazníků. Výchozí hodnota je `D:\WWW-servers\LocalUser`. 
*   `FTP_GROUP` je název uživatelské skupiny, která má obsahovat jednotlivé zákazníky (uživatele) a slouží k nastavení FTP přístupu. Výchozí hodnota je `Customers`.   

Skripty obecně pracují pouze s lokálními účty a skupinami. Pokud byste je chtěli používat v doménovém prostředí, je nutná jejich úprava.

## NEWCUST.CMD – vytvoření nového uživatele

Syntaxe je: `newcust hostname username password`

Tento skript slouží k založení nového zákazníka web hostingu a vytvoření prvního webu. Vykoná následující činnosti:

1.  Vytvoří application pool jménem `AP_username`. 
2.  Vytvoří uživatele `username` s heslem `password`. 
3.  Přidá tohoto uživatele do skupiny nastavené proměnnou FTP_GROUP (standardně `Customers`). 
4.  Vytvoří pro tohoto uživatele datový adresář v cestě `ROOT_FOLDER`. Např. tedy `D:\WWW-Servers\LocalUser\username`. 
5.  Nastaví v tomto adresáři práva "full control" uživateli `username` a identitě `IIS APPPOOL\AP_username`. 
6.  Vytvoří adresář pro nový web, např. `D:\WWW-Servers\LocalUser\username\hostname`. 
7.  Vytvoří nový virtuální web server jménem "`username-hostname`" a nasměruje ho do adresáře vytvořeného v předchozím kroku. 
8.  Zařadí vytvořený web do application poolu "`AP_username`"   

## NEWSITE.CMD – vytvoření nového webu pro existujícího uživatele

Syntaxe je: newsite hostname username

Tento skript slouží k vytvoření nového webu pro existujícího uživatele (a přidání do jeho application poolu). Vykoná v zásadě pouze poslední tři kroky výše uvedeného skriptu, tj. vytvoří a nastaví nový web server.

## Implementační poznámka

Výše uvedené skripty předpokládají dost konkrétní nastavení web serveru a je pravděpodobné, že pro vaše konkrétní prostředí bude třeba je upravit a to předpokládá jisté znalosti jak tohoto prostředí, tak tvorby dávkových souborů. Skripty poskytuji "as is" a nebudu k nim poskytovat žádnou podporu v komentářích a podobně. Nicméně s radostí vám jako placenou konzultaci vytvořím skripty vhodné pro vaše prostředí.

**Skripty ke stažení zde: **[**20100924-iismgmt.zip**](https://www.cdn.altairis.cz/Blog/2010/20100924-iismgmt.zip)