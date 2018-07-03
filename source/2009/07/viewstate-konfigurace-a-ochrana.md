<!-- dcterms:identifier = aspnetcz#237 -->
<!-- dcterms:title = ViewState: Konfigurace a ochrana -->
<!-- dcterms:abstract = V předchozích dílech tohoto seriálu jsme se podívali na ViewState a ControlState. Nyní se budeme zabývat konfigurací celého systému a ochranou obsahu. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Tipy, triky -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- np9:serialId = 5 -->
<!-- x4w:serial = ViewState -->
<!-- dcterms:created = 2009-07-01T09:00:00+02:00 -->
<!-- dcterms:dateAccepted = 2009-07-01T09:00:00+02:00 -->

V předchozích dílech tohoto seriálu jsme se podívali na ViewState a ControlState. Nyní se budeme zabývat konfigurací celého systému a ochranou obsahu.

## Konfigurace

Konfigurace ViewState mechanismu se provádí v souboru `web.config`, pomocí standardního konfiguračního modelu. Element `/configuration/system.web/pages` má několik konfiguračních atributů, které se týkají ViewState:

*   **`enableViewState`** (`true`/`false`) povoluje nebo zakazuje použití celého ViewState mechanismu, jak již bylo popsáno dříve. Výchozí nastavení je `true`. 
*   **`enableViewStateMac`** (`true`/`false`) určuje, zda se mají data posílaná na klienta opatřit digitálním podpisem, který znemožní jejich modifikaci. Výchozí nastavení je `true`. 
*   **`viewStateEncryptionMode`** (`Always`/`Auto`/`Never`) určuje, zda se mají data posílaná na klienta zašifrovat. Výchozí nastavení je `Auto`.  

Zabezpečením, tedy digitálním podpisem a šifrováním, se budu zabývat v další části.

Všechny tři konfigurační vlastnosti lze nastavovat na úrovni celé aplikace (v souboru `web.config`, jak bylo popsáno výše) a nebo na úrovni konkrétní stránky či user controlu, jako atributy direktiv `@Page` či `@Control`, resp. jako vlastnosti příslušných tříd. Na úrovni jednotlivých ovládacích prvků lze ViewState pouze vypnout (pomocí nastavení `EnableViewState="false"`).

Pokud je ViewState na vyšší úrovni vypnuto, nelze ho na nižší zpětně zapnout. Pokud tedy chcete ViewState někde používat a někde ne, v současné verzi ASP.NET (3.5) ho musíte jednotlivě zakázat, ne jednotlivě povolit. Změnu v tomto směru přinese verze 4.0.

## Ochrana obsahu

ViewState se na klientovi vyskytuje v podobě Base64 kódovaného řetězce. Bez ohledu na svou zdánlivou nesrozumitelnost je [Base64](http://en.wikipedia.org/wiki/Base64) kódování, nikoliv šifra. Neslouží tedy k utajení obsahu, ale je jenom prostředkem, jak v textu (HTML kódu stránky) ukládat data, která jsou svou povahou binární. Onen "blob", skrytý v poli `__VIEWSTATE` je možné snadno dekódovat a deserializovat, po Internetu se potuluje spousta nástrojů, které to umí.

Obvykle chceme zabránit tomu, aby uživatel/útočník mohl ViewState modifikovat a v některých případech nechceme ani aby viděl obsah. Potřebujeme tedy obsah digitálně podepsat a/nebo zašifrovat.

Digitální podpis – lépe řečeno výpočet [HMAC](http://www.aspnet.cz/Articles/146-hmac-hash-message-authentication-code.aspx) – se řídí již výše zmíněnou vlastností `enableViewStateMac`. Pokud je nastavena na `true` (což je výchozí hodnota), je k ViewState připojen digitální podpis a pokud po odeslání hodnoty zpět nesouhlasí, ASP.NET vyhodí `ViewStateException`. Pro ověření se použijí hodnoty definované v konfigurační sekci `machineKey`: validační algoritmus určený atributem `validation` a klíč definovaný atributem `validationKey`. Výchozí nastavení je takové, že klíč se generuje náhodně a automaticky. Pokud máte cluster (webovou farmu), je nutné klíč nastavit na všech nodech stejně.

Šifrování dat je poněkud komplikovanější záležitost, ježto vlastnost `viewStateEncryptionMode` může nabývat třech hodnot. Hodnoty `Always` a `Never` jsou dosti jasné: šifrování se v prvním případě použije vždy, ve druhém nikdy. Výchozí hodnota je ale `Auto`. Při ní se šifrování použije pouze pokud stránka obsahuje prvky, které si to výslovně vyžádaly – tj. nejpozději v průběhu fáze `PreRender` zavolaly metodu `RegisterRequiresViewStateEncryption`. Pro šifrování se použije opět klíč definovaný v sekci `machineKey` – tentokráte je to `decryptionKey`. I zde platí, že klíč je generován automaticky, což vám může vadit zejména na webové farmě.

Občas se lze setkat s názorem, že ASP.NET je špatné a nedůvěryhodné, protože ViewState není dostatečně zabezpečené a vůbec. Ve skutečnosti, jako vždy, závisí na svéprávnosti správce. Z pohledu autora komponenty platí, že šifrování si můžete vyžádat, ale ne vynutit – pokud ho admin výslovně zakáže, máte smůlu. Z pohledu autora/správce aplikace platí, že nejlepší je moc se v tom nevrtat, pokud se mohu spolehnout na příčetnost autorů komponent. Nemohu-li, je možné za cenu zvýšení procesorové zátěže šifrovat všechno.

*V příštím a závěrečném článku se podíváme na změny, které v oblasti ViewState přináší ASP.NET 4.0.*