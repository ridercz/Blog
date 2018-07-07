<!-- dcterms:identifier = aspnetcz#33 -->
<!-- dcterms:title = FreeTextBox: WYSIWYG editor pro ASP.NET -->
<!-- dcterms:abstract = Jedním z nejčastějších požadavků kladených na vývoj webových aplikací je možnost zadávat formátovaný (HTML) text pomocí uživatelsky přítulného WYSIWYG editoru. Já osobně používám k plné spokojenosti komponentu zvanou FreeTextBox. Ukázka jeho použití zároveň poslouží k předvedení všeobecné práce s ovládacími prvky třetích stran. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Tipy, triky -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2005-04-21T06:18:33.937+02:00 -->
<!-- dcterms:dateAccepted = 2005-04-21T06:18:33.937+02:00 -->

Jedním z nejčastějších požadavků kladených na vývoj webových aplikací je možnost zadávat formátovaný (HTML) text pomocí uživatelsky přítulného WYSIWYG editoru. Dříve doména a středobod činnosti publikačních systémů, dnes téměř nezbytná součást jakékoliv složitější aplikace. Komponent, které zajišťují takovou funkčnost, jest nepřeberné množství. Některé fungují výhradně na straně klienta v JavaScriptu, jiné umějí přímo spolupracovat s ASP.NET.

Já osobně používám k plné spokojenosti komponentu zvanou **[FreeTextBox](http://www.freetextbox.com/)**. Název není úplně přesný, protože "free" je jenom základní verze, za rozšířené či zdrojový kód si musíte připlatit. Nicméně i ona základní verze představuje pro většinu aplikací zcela postačující řešení. Osobně jsem toho názoru, že kreativitu uživatelů v oblasti zadávání formátování textu je třeba spíše krotit než podporovat.

FreeTextBox má několik užitečných vlastností, které vyčnívají nad řadu jiných řešení:

*   **Jednoduchá instalace:** Lze jej nastavit tak, že nevyžaduje kopírování žádných dalších souborů kromě vlastního DLL. Obrázky a JavaScripty umí načítat přes speciální handler tak, jak jsou uloženy v jeho assembly. **Plná nativní podpora ASP.NET:** Jedná se o standardní web user control, na který jest aplikovati standardní metody, jako například validaci a podobně. **Jednoduché uživatelské rozhraní:** Ovládá se přes panely nástrojů, které lze přimět aby kopírovaly styl Microsoft Office v různých verzích. **Podpora pro práci s obrázky:** Obsahuje správce souborů, přes kterého je možno do vyhrazené složky (galerie) možno uploadovat obrázky a pak je pohodlně vkládat do editovaného textu. **XHTML:** Umožňuje zajistit, že vkládaný kód bude vždy valid XHTML (pouze v placené verzi). 

Ukázka použití FTB zároveň poslouží k předvedení všeobecné práce s ovládacími prvky třetích stran.

## Přípravy

![Přidání reference ve VS.NET](https://www.cdn.altairis.cz/Blog/2005/20050421-add-reference.png "Přidání reference ve VS.NET")Jako první krok (pomineme-li stažení z [www.freetextbox.com](http://www.freetextbox.com/)) jest třeba přidat komponentu FreeTextBox do referencí daného webového projektu. V *Solution Exploreru* VS.NET klepněte pravým tlačítkem na složku *References* a z kontextového menu vyberte *Add Reference*. Objeví se nové okno, v němž na záložce *.NET* pomocí tlačítka *Browse* vyberte soubor `FreeTextBox.dll`.

Chcete-li používat výše zmíněnou funkci natahování všech potřebných souborů z assembly, musíte zaregistrovat HTTP handler, který se o to postará. Učiníte tak přidáním následujícího kódu do sekce `/configuration/system.web` v souboru `web.config`:

<httpHandlers> <add verb="GET" path="FtbWebResource.axd" type="FreeTextBoxControls.AssemblyResourceHandler, FreeTextBox" /> </httpHandlers>

Chcete-li používat samostatné soubory, nakopírujte do vhodné složky (standardně `/aspnet_client/FreeTextBox/`) dodané pomocné soubory (obrázky a JavaScripty). Použití samostatných souborů může být výhodné, pokud se jedná o vysoce zatěžovanou aplikaci. Stahování velkého množství souborů přes handler může server zbytečně zatěžovat.

## Použití ve stránce

Aby bylo možno control ve stránce použít, je nutno ho nejprve zaregistrovat. Tak jest činiti přidáním direktivy `@Register` na její začátek. V našem konkrétním případě bude tato direktiva vypadat ``. Místo běžného `asp:textbox` pak použijete pro vložení následující kód: ``. 

Standardně ASP.NET 1.1 vyhodí výjimku, pokud zaslané parametry (GET, POST) obsahují libovolné HTML formátování, přesněji znaky < a >. Toto bohulibé chování si klade za cíl zabránit možnosti *script injection*, tedy možnosti podvrhnout javascriptový kód do stránky, v níž bude spuštěn s vyšším stupněm oprávnění, či kde může získat citlivé údaje - např. hodnoty cookies. Pro náš účel je ovšem toto chování nevhodné, takže jej vypneme vložením atributu `validateRequest="false"` do direktivy `@Page`.

Nezapomínejte ovšem na nutnost vstup validovat vlastními prostředky. Pokud umožníte vkládání formátovaného textu běžným návštěvníkům, je třeba zajistit aby nemohli vkládat skripty ani další potenciálně nebezpečné konstrukce. Teoreticky by v tomto směru mělo stačit nastavení vlastnosti FTP `StripAllScripting` na `True`, nicméně proti mnou vyzkoušeným metodám podvržení textu to nezabralo.

Z code behind kódu se s instancí FreeTextBoxu zachází v zásadě stejně jako se standardním TextBoxem.

## Vkládání obrázků - práce s galerií

Jednou z výtečných funkcí FTB je možnost pracovat nativně s obrázky uploadovanými z klienta. Pokud ji chcete využít, je třeba učiniti několik dalších drobných úprav.

Jednak je třeba [přidat na panel nástrojů](http://wiki.freetextbox.com/default.aspx/FreeTextBoxWiki.ToolbarConfiguration) tlačítko `InsertImageFromGallery`.

Dále pak je třeba vytvořit pomocný soubor se stránkou, která se bude starat o vlastní vkládání obrázků. Příklad takové stránky najdete v distribučním archivu jako `ftb.imagegallery.aspx`. O vlastní činnost se stará specializovaná komponenta `FTB:ImageGallery`. Ta se vyznačuje mimi jiné tím, že kvůli nějaké záhadné chybě v JavaScriptu nefunguje v Internet Exploreru, je-li stránka zobrazena ve Strict modu (má `!DOCTYPE`). Postarejte se tedy o to, aby se stránka vykreslovala v Quirk mode.

Konečně pak je třeba nastavit několik parametrů u vlastního ovládacího prvku. V první řadě se jedná o `ImageGalleryUrl`. Standardně se předpokládá, že výše uvedená obslužná stránka bude dostupná jako `/ftb.imagegallery.aspx`. Chcete-li ji umístit jinam, uveďte příslušné umístění zde. Cestu ke složce, ve které se nacházejí obrázky, pak určete jako parametr `ImageGalleryPath`.

Další možnosti FreeTextBoxu objevíte po prostudování přiložené dokumentace, případně online [na webu](http://wiki.freetextbox.com/).