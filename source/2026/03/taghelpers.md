<!-- dcterms:title = Altairis Tag Helpers: nová verze knihovny -->
<!-- dcterms:abstract = Altairis Tag Helpers je knihovna pro ASP.NET MVC a Razor Pages, která rozšiřuje Razor o sadu užitečných tag helperů pro běžné scénáře. Jejím cílem je zkrátit opakující se kód ve views, zpřehlednit šablony a sjednotit chování UI prvků. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:date = 2026-03-18 -->
<!-- x4w:category = IT -->
<!-- x4w:pictureUrl = /perex-pictures/20220710-taghelpers.jpg -->
<!-- x4w:coverUrl = /cover-pictures/20220710-taghelpers.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->

Dnes jsem vydal novou verzi 2.1 knihovny [Altairis Tag Helpers](https://github.com/ridercz/Altairis.TagHelpers). To je knihovna pro ASP.NET MVC a Razor Pages, která rozšiřuje Razor o sadu užitečných tag helperů pro běžné scénáře. Jejím cílem je zkrátit opakující se kód ve views, zpřehlednit šablony a sjednotit chování UI prvků.

Knihovna obsahuje jak jednoduché helpery (zkracování textu, podmíněná viditelnost), tak pokročilejší komponenty (kalendář událostí, semantický bar chart, práce s rolemi, avatary). Je k dispozici zdarma pod otevřenou MIT licencí.

## Instalace a použití

Nainstalujte NuGet balíček:

    Install-Package Altairis.TagHelpers

Zaregistrujte tag helpery do Razor views (typicky do `_ViewImports.cshtml`):

    @addTagHelper *, Altairis.TagHelpers

Potom už můžete helpery používat přímo v `.cshtml` souborech.

## Dostupné tag helpery

Zde je stručný popis tag helperů se základními příklady použití. Kompletní dokumentaci najdete na [wiki projektu](https://github.com/ridercz/Altairis.TagHelpers).

### BarChartTagHelper

Sada helperů pro vykreslení sloupcového grafu pomocí sémantického HTML a CSS (bez canvas/SVG). Hlavní kontejner je `bar-chart`, jednotlivé hodnoty jsou `bar`.

```html
<bar-chart stacked="true">
    <title>My chart</title>
    <data-table values-format-string="0.0"
                percent-format-string="0.0 %"
                total-text="Total" />
    <bar label="Red" value="30.123" color="#f00" />
    <bar label="Green" value="20.456" color="#0f0" />
    <bar label="Blue" value="10.789" color="#00f" />
</bar-chart>
```

Podporuje stacked režim, popisky, vlastní barvy, tabulku hodnot i přístupnost přes ARIA atributy.

### CalendarTagHelper

Vytvoří kalendář s podobnou logikou a vzhledem jako měsíční zobrazení v Outlooku. Respektuje locale aplikace (názvy měsíců, dnů, první den týdne).

```html
<calendar class="calendar"
          date-begin="new DateTime(2020, 4, 1)"
          date-end="new DateTime(2020, 4, 30)"
          day-name-style="Full"
          events="this.Model.Events"
          selected-days="this.Model.SelectedDays"></calendar>
```

Události se předávají jako kolekce `CalendarEvent`, kde lze řešit celodenní i časové akce, odkazy, popisy i barevné odlišení.

### CheckboxListTagHelper

Alternativa k elementu `select`, která renderuje seznam checkboxů nebo radiobuttonů.

```html
<checkbox-list
    asp-for="Input.CheckboxSelectedValues"
    asp-items="Model.CheckboxListItems"
    control-type="CheckBox"
    class="checkboxlist" />
```

### ConditionalAttributeTagHelper

Řeší častý problém v Razor views: podmíněné přidání atributu, jehož samotná přítomnost mění chování (např. `open`, `disabled`, `readonly`).

```html
<details conditional-attribute-name="open"
         conditional-attribute-state="@Model.OpenDetails">
    ...
</details>
```

### ConfirmTagHelper

Přidá potvrzení akce přes JavaScript `confirm` dialog. Hodí se pro akce typu odhlášení, smazání nebo reset.

```html
<a href="/logout" confirm-message="Do you really want to logout?">Logout</a>
```

### DatalistTagHelper

Rozšiřuje `input` o atribut `items`, ze kterého vygeneruje `datalist` pro autocomplete hodnoty.

```html
<input asp-for="PropertyName" items="Model.PropertyValues" />
```

### DicebearAvatarTagHelper

Generuje avatar přes [DiceBear API](https://www.dicebear.com/). Vhodné tam, kde nechcete ukládat nahrané profilové obrázky, ale přesto chcete vizuální odlišení uživatelů.

```html
<dicebear seed="HelloWorld" sprites="pixel-art" />
```

### EditorTagHelper

Tag helper alternativa k `Html.EditorFor`.

```html
<editor asp-for="Model.Property" template-name="MyTemplate" />
```

### GravatarTagHelper

Vykreslí profilový obrázek ze služby [Gravatar](https://www.gravatar.com/) na základě e-mailu.

```html
<gravatar email="someone@example.com" size="80" />
```

### RolesTagHelper

Podmíněně zobrazí obsah podle role uživatele. Můžete kombinovat whitelist i blacklist rolí.

```html
<div include-roles="Users">...</div>
<div include-roles="Users,Admins">...</div>
<div exclude-roles="Admins">...</div>
```

### TimeTagHelper

Chytré vykreslení data/času v elementu `time` podle relativní vzdálenosti od aktuálního dne. Umí speciální formáty pro dnes/včera/zítra a automaticky doplňuje atribut `datetime` i tooltip `title`.

```html
<time value="@Model.SomeDateTimeProperty" null-text="Never"></time>
```

### TrimLengthTagHelper

Zkrátí textový obsah elementu na definovanou délku a doplní výpustek.

```html
<div trim-length="10">This text will be shortened.</div>
```

### VisibleTagHelper

Jednoduchá podmíněná viditelnost elementu pomocí bool atributu `visible`. Nahrazuje opakované `if` v šablonách a zvyšuje čitelnost Razor kódu.

```html
<div visible="Model.SomeBooleanProperty">...</div>
```