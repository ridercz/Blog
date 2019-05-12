<!-- dcterms:title = Nové tag helpery v knihovně Altairis Tag Helpers -->
<!-- dcterms:abstract = Do knihovny Altairis.TagHelpers jsem přidal několik nových tag helperů pro ASP.NET MVC Core a Razor Pages. Nová verze 1.4 obsahuje potvrzení akce, zobrazení verze aplikace a zejména žádaný ekvivalent komponent CheckBoxList a RadioButtonList. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:dateAccepted = 2019-05-12 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20171226-altairis-tag-helpers-pro-asp-net-core-razor-pages-a-asp-net-mvc-core.png -->
<!-- x4w:coverUrl = /cover-pictures/20190512-nove-tag-helpery.jpg -->
<!-- x4w:category = Software -->

Do knihovny [Altairis.TagHelpers](https://github.com/ridercz/Altairis.TagHelpers) jsem přidal několik nových tag helperů pro ASP.NET MVC Core a Razor Pages.

## ConfirmTagHelper

```html
<a href="/logout" confirm-message="Do you really want to logout?">Logout</a>
```

Umožňuje pomocí JavaScriptového okna (`window.confirm`) potvrdit klepnutí na odkaz.

## AssemblyVersionTagHelper

Zobrazí verzi entry assembly (tj. typicky vaší webové aplikace). Umí si poradit i se situací, kdy je verze automaticky generována podle času buildu (např. `2019.05.11.1902`) a zobrazit ji jako datum

```html
<assembly-version display="Revision" />
<assembly-version display="BuildTime" 
                  time-kind="Local" 
                  time-format="yyyy-MM-dd HH:mm" />
```

## CheckBoxListTagHelper

Umožňuje vygenerovat sbírku checkboxů nebo radiobuttonů, jde o ekvivalent ovládacích prvků `<asp:CheckBoxList>` a `<asp:RadioButtonList>` z ASP.NET Web Forms.

```html
<checkbox-list 
    asp-for="Input.CheckboxSelectedValues" 
    asp-items="Model.CheckboxListItems" 
    class="checkboxlist" />
```

## Instalace

Knihovna je šířena pomocí NuGetu jako balíček `Altairis.TagHelpers`. Nainstalujte si jej pomocí package manageru.

Poté je nutno tag helpery zaregistrovat, což jest učiniti přidáním direktivy `@addTagHelper *, Altairis.TagHelpers` do CSHTML souboru, kde je chcete používat, případně do `_ViewImports.cshtml`, pro registraci v celé aplikaci.

**Zdrojové kódy a příklad najdete na **[**GitHubu**](https://github.com/ridercz/Altairis.TagHelpers)** a dokumentaci na **[**tamní wiki**](https://github.com/ridercz/Altairis.TagHelpers/wiki)**.**