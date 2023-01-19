<!-- dcterms:title = DETAILS a SUMMARY: zapomenuté HTML 5 elementy -->
<!-- dcterms:abstract = Ve specifikaci HTML 5 se najde řada užitečných elementů, které nejsou příliš známé a weboví programátoři je nevyužívají nebo nevyužívají dostatečně a zbytečně pak používají složité CSS konstrukce nebo JavaScript. Jedním z takových elementů je details a jeho průvodce summary. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20220113-html5-details.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20220113-html5-details.jpg -->
<!-- x4w:category = Z-TECH -->
<!-- x4w:category = IT -->
<!-- dcterms:date = 2022-01-13 -->

Ve specifikaci HTML 5 se najde řada užitečných elementů, které nejsou příliš známé a weboví programátoři je nevyužívají nebo nevyužívají dostatečně a zbytečně pak používají složité CSS konstrukce nebo JavaScript. Před časem jsem [psal o elementu `DATALIST`](/2020/05/datalist), který umožňuje nativní autocomplete. Nyní přišla řada na element `DETAILS` a jeho druha `SUMMARY`.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/aUI0hfKfRs0" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

## HTML

Tyto dva elementy slouží k zobrazení stručného obsahu (`summary`), po kliknutí na který se zobrazí obsah rozsáhlejší (zbytek elementu `details`). Konstrukce připomíná elementy `fieldset` a `legend`:

```html
<details>
    <summary>Lorem Ipsum</summary>
    Lorem ipsum dolor sit amet...
</details>
```

Element `details` může mít atribut `open` (bez hodnoty nebo v XHTML syntaxi zapsaný jako `<details open="open">`), který říká, že při prvním zobrazení má být obsah rozbalen.

Tato konstrukce může být použita libovolně, ale je předurčena pro rozbalovací seznamy. Tomu napovídá i to, že ve výchozím nastavení se před obsahem `summary` zobrazí trojúhelníková šipka. Doprava (&#9656;), pokud je obsah skrytý a dolů (&#9662;), je-li zobrazen.

Prohlédněte si základní použití této konstrukce:

<iframe height="300" style="width: 100%;" scrolling="no" title="Details/Summary (simple)" src="https://codepen.io/ridercz/embed/XWePqwj?default-tab=html%2Cresult&editable=true&theme-id=light" frameborder="no" loading="lazy" allowtransparency="true" allowfullscreen="true">
  See the Pen <a href="https://codepen.io/ridercz/pen/XWePqwj">
  Details/Summary (simple)</a> by Michal Altair Valasek (<a href="https://codepen.io/ridercz">@ridercz</a>)
  on <a href="https://codepen.io">CodePen</a>.
</iframe>

## CSS

Rozhodně doporučuji prvku `summary` přidat kurzor typu odkaz, protože jinak uživatel netuší, že má smysl na něj klikat:

```css
summary {
    cursor: pointer;
}
```

Dále pak je možné standardním způsobem stylovat oba prvky. Pomocí selektoru `open` pak lze nastavit styl pro otevřený stav:

```css
details[open] summary {
    color: red;
}
```

Pokud chcete ovlivnit, jak bude vypadat šipka v rozbaleném či sbaleném stavu, lze použít standardní prvky pro seznamy, tj. zejména `list-style-type`.

Prohlédněte si obsáhlejší demo, které nabízí pokročilejší customizaci:

<iframe height="300" style="width: 100%;" scrolling="no" title="Details/Summary (simple)" src="https://codepen.io/ridercz/embed/NWaLMZV?default-tab=html%2Cresult&editable=true&theme-id=light" frameborder="no" loading="lazy" allowtransparency="true" allowfullscreen="true">
  See the Pen <a href="https://codepen.io/ridercz/pen/NWaLMZV">
  Details/Summary (simple)</a> by Michal Altair Valasek (<a href="https://codepen.io/ridercz">@ridercz</a>)
  on <a href="https://codepen.io">CodePen</a>.
</iframe>