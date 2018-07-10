<!-- dcterms:identifier = aspnetcz#192 -->
<!-- dcterms:title = Stavové HTTP: ViewState -->
<!-- dcterms:abstract = Web byl stvořen jako bezstavový a struktura HTTP a HTML tomu odpovídá. Pokud chceme tuto bezstavovost překlenout, existuje několik technik, které nám umožní toto omezení obejít. Poslední technikou, kterou budu v tomto seriálu zmiňovat, je ViewState. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Programování -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- np9:serialId = 4 -->
<!-- x4w:serial = Stavové HTTP -->
<!-- dcterms:created = 2008-03-23T08:00:00+01:00 -->
<!-- dcterms:dateAccepted = 2008-03-23T08:00:00+01:00 -->

V minulých dílech tohoto seriálu jsme se zabývali použitím [cookies](http://www.aspnet.cz/Articles/191-stavove-http-cookies.aspx) a [sessions](http://www.aspnet.cz/Articles/193-stavove-http-sessions.aspx) k překlenutí bezstavovosti HTTP. Poslední takovou technikou, o které se chci zmínit, je ViewState, která se od dříve uvedených dosti liší.

Sessions a cookies slouží k předávání údajů mezi různými stránkami nebo dokonce (v případě cookies) i různými servery v téže doméně. ViewState nic takového neumí, slouží k uchovávání údajů mezi různými odesláními téhož formuláře, téže stránky.

Pomocí ViewState si například GridView pamatuje, na které stránce se právě nachází a nebo jaká data byla nabindována z databáze. Obecně, veškeré hodnoty vlastností server controls se ukládají do ViewState

## Jak ViewState funguje?

Cokoliv, co uložíte do kolekce ViewState se při renderingu stránky zpracuje následujícím způsobem:

1.  **Serailizuje** se to - můžete tedy ukládat pouze serializovatelná data. 
2.  **Zkomprimuje** se to - jeden z rozdílů mezi ASP.NET verze 1.x a 2.0 je, že data se zkomprimují, což snižuje jejich objem. 
3.  **Zašifruje** se to - pokud to v konfiguraci explicitně nezakážete a control si to vyžádá, data se před uložením zašifrují pomocí symetrické šifry a machine key. 
4.  **Podepíše** se to - pokud to v konfiguraci explicitně nezakážete, výsledek se digitálně podepíše, aby se vyloučila možnost úmyslného nebo neúmyslného poškození dat při roundtripu přes klienta. 
5.  **Zakóduje** to to do Base64, čímž se celá ta věc převede na tisknutelné znaky.

Výsledek tohoto procesu je potom někam uložen. Kam konkrétně závisí na zvoleném ViewState providerovi. ASP.NET obsahuje dva. Výchozí nastavení je takové, že se celá tato záležitost uloží do skrytého pole formuláře - do hidden fieldu, který se jmenuje "*__VIEWSTATE*". Jiný provider umí ukládat tuto hodnotu do session.

U toho se na chvíli zastavme. Proč tyto dvě "konkurenční" technologie propojovat? Inu, ony zase tak konkurenční nejsou a ve skutečnosti je použití session pro ukládáni ViewState jediná věc, ke které jsem tuto techniku kdy využil. Použití ViewState totiž znamená nárůst objemu přenášených dat, a to v některých případech dost značný. Pokud vyvíjíte aplikace pro mobilní zařízení, je pro vás objem dat dost podstatný. 

Kapesní počítače a mobilní telefony se zhusta připojují přes GPRS a podobné, a objem přenášených dat znamená velký problém, protože tyto technologie jsou pomalé a navíc uživatel za objem přenesených dat platí. Použití session je v tomto konkrétním případě prostě menší zlo.

## ViewState vs. ControlState

V ASP.NET 1.x jste měli na výběr pouze ze dvou možností. Buď jste ViewState nechali zapnutý a v takovém případě vám sice všechny controly fungovaly bez problémů, ale na druhou stranu vám razantně narostl objem přenášených dat. Nebo jste viewstate vypnuli, a přestala vám fungovat většina složitějších formulářů a muselo se to komplikovaně obcházet. Od verze ASP.NET 2.0 se pod hlavičkou ViewState skrývají v podstatě technologie dvě a nejste postaveni před volbu "všechno nebo nic". Nově se objevuje pojem ControlState.

**ViewState** se používá pro ukládání těch dat, které by control sice rád po postbacku našel, ale dokáže se bez nich v případě nutnosti obejít. Tedy například data nabindovaná z databáze. Když je bude potřebovat, zeptá se na ně znovu. ViewState můžete, jako tvůrce aplikace, vypnout. Na úrovni celé aplikace, nebo na úrovni stránky či jednotlivého controlu.

**ControlState** vypnout nemůžete. Ukládají se tam údaje, které control nezbytně nutně potřebuje ke své činnosti - jako třeba číslo aktuální stránky u stránkovaného gridu. Autor controlu by měl tuto vlastnost využívat opravdu střídmě a v odůvodněných případech.

ViewState i ControlState se ukládají na stejné místo, nerozeznáte je od sebe. To je také důvod, proč ani po vypnutí ViewState všude, kde vás napadne, stejně ono skryté pole "__VIEWSTATE" nezmizí. Obsahuje sice méně dat, ale pořád tam je. Obsahuje totiž právě control state.

## Výhody a nevýhody

## 

### Proč ViewState používat?

*   Drží se filozofie HTTP, veškerá potřebná data jsou součástí requestu. 
*   Stejně se ho v podstatě nezbavíte. 
*   Je bezpečný, protože data jsou šifrovaná a digitálně podepsaná.

### Proč ViewState nepoužívat?

*   Zvyšuje objem přenášených dat, mnohdy velmi razantně. 
*   Zpracování objemných dat může být výkonově náročné.

### Doporučení

*   ViewState vypněte v celé aplikaci, pro drtivou většinou případů si vystačíte s ControlState, kterého se stejně nezbavíte. 
*   V odůvodněných případech u složitých formulářů ViewState explicitně zapněte, pro ty prvky, pro které ho potřebujete. 
*   Pokud je pro vás extrémně důležitý objem přenášených dat, např. u aplikací pro mobilní zařízení, zvažte ukládání ViewState/ControlState do session.

*V zítřejším dokončení seriálu celou problematiku shrneme a zaměříme se na doporučená řešení obvyklých problémů (bez)stavovosti.*