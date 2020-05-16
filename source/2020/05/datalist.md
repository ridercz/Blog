<!-- dcterms:title = DATALIST - zapomenutý HTML5 element -->
<!-- dcterms:abstract = Součástí HTML5 je element datalist. Těší se široké podpoře v prohlížečích a jednoduše řeší typický UX problém. Přesto se s ním na webu setkáte jenom zřídka. Kromě vysvětlení k čemu je dobrý jsem pro vás připravil i užitečný tag helper. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:coverUrl = /cover-pictures/20200516-datalist.jpg -->
<!-- x4w:pictureUrl = /perex-pictures/20200516-datalist.png -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = IT -->
<!-- dcterms:dateAccepted = 2020-05-16 -->

Součástí HTML5 je element `datalist`. Těší se široké podpoře v prohlížečích a jednoduše řeší typický UX problém. Přesto se s ním na webu setkáte jenom zřídka. Kromě vysvětlení k čemu je dobrý jsem pro vás připravil i užitečný tag helper.

## K čemu slouží `datalist`

Element `datalist` je sám o sobě neviditelný (nevizuální) element, který slouží k "nakrmení" autocomplete pro textové vstupní pole, které je na něj navázáno pomocí atrubutů `id` a `list`. Celá konstrukce vypadá nějak takto:

    <input type="text" list="mujdatalist" />
    <datalist id="mujdatalist">
        <option value="aaa" />
        <option value="bbb" />
        <option value="ccc" />
    </datalist>

Hodnoty z `datalist`u budou uživateli nabídnuty při zadávání textu do prvku `input`. Jak konkrétně, to záleží na prohlížeči, ale typicky se po poklepání zobrazí úplný seznam (jako rozbalovací) a při psaní textu se zobrazí seznam filtrovaný, obsahující pouze položky odpovídající již napsanému.

Jedná se tedy o aproximaci prvku, kterému se při návrhu UI obvykle říká _ComboBox_, protože kombinuje běžné textové pole (textbox) a seznam (dropdown list). Uživatel si může buďto vybrat hodnotu ze seznamu nebo zadat vlastní.

Další informace [najdete příkladmo na MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/datalist).

## Kdy použít combobox

[Baymard Institute](https://baymard.com/blog/drop-down-usability) na svém webu publikoval studii použitelnosti výběru ze seznamů. Obecné závěry studie jsou následující:

* Pokud je položek, z nichž lze vybrat, méně než pět, zobrazte je všechny najednou, třeba jako radio buttony. K tomuto účelu jsem v knihovně Altairis.TagHelpers vytvořil [CheckboxListTagHelper](https://github.com/ridercz/Altairis.TagHelpers/wiki/CheckboxListTagHelper).
* Pokud je položek 5-10, použijte rozbalovací seznam (dropdown list, v HTML element `select`).
* Pokud je položek více, použijte volný text s nápovědou.

Typickým příkladem posledního typu je třeba seznam zemí při výběru adresy a podobně.

## Výhody a nevýhody použití prvku `datalist`

Výhody:

* Triviální na použití.
* Nativní vzhled prohlížeče.
* Nativní chování (ovládání z klávesnice apod.).
* Výborná přístupnost.
* Funguje bez JavaScriptu.

Nevýhody:

* Seznam položek musí být statický, je dán při načtení stránky, položky nelze dotahovat dynamicky na základě uživatelem zadaného textu. Lze nicméně [obejít pomocí JavaScriptu](https://www.raymondcamden.com/2012/06/14/example-of-a-dynamic-html5-datalist-control).
* Prakticky nelze ovlivnit vzhled (to ale pokládám spíše za výhodu z hlediska konzistence UI).
* Nefunguje ve [velmi starých prohlížečích](https://caniuse.com/#search=datalist) (IE 9 a nižších).

Výhodou i nevýhodou může být - v závislosti na způsobu použití - že uživatel si nemusí vybrat z nabízených možností ale může napsat libovolný vlastní text. Pokud je žádoucí výběr z pevného seznamu možností, je nutné provést validaci textové hodnoty.

## Tag helper

Od verze 1.8 je součástí mé knihovny [Altairis.TagHelpers](https://github.com/ridercz/Altairis.TagHelpers) nový helper [DatalistTagHelper](https://github.com/ridercz/Altairis.TagHelpers/wiki/DatalistTagHelper). Funguje tak, že se prvku `input` přidá nový atribut `list`, který odkazuje na vlastnost modelu nebo viewmodelu, která je typu `IEnumerable<string>` a obsahuje nabízené hodnoty. Tag helper automaticky vygeneruje odpovídajíci `datalist` a naváže ho na textové pole. 

Jeho ID bude vygenerováno automaticky podle ID textového pole, ale lze jej i explicitně určit pomocí atributu `datalist-id`.

Kompletní dokumentaci najdete tradičně na [wiki](https://github.com/ridercz/Altairis.TagHelpers/wiki/DatalistTagHelper).