<!-- dcterms:title = SCSS mixin pro responzivní menu -->
<!-- dcterms:abstract = Responzivní menu, které se na menších obrazovkách změní v rozbalovací, je běžnou funkcí webových aplikací. Je součástí každého klientského UI frameworku. Ale co když klientské UI frameworky nepoužíváte? A chcete sémantické řešení bez JavaScriptu? Stačí na to jeden SCSS mixin.  -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:coverUrl = /cover-pictures/20200102-scss-menu.jpg -->
<!-- x4w:pictureUrl = /perex-pictures/20200102-scss-menu.png -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = IT -->
<!-- dcterms:dateAccepted = 2020-01-02 -->

Responzivní menu, které se na menších obrazovkách změní v rozbalovací, je běžnou funkcí webových aplikací. Je součástí každého klientského UI frameworku. Ale co když klientské UI frameworky nepoužíváte? A chcete sémantické řešení bez JavaScriptu? Stačí na to jeden SCSS mixin.

## Princip triku

Celý princip menu, které je na širokých obrazovkách horizontální a na úzkých rozbalovací vertikální, spočívá ve dvou technikách. První jsou standardní CSS media queries, které umožní aplikovat různé styly v závislosti na velikosti viewportu. Druhý je obyčejný staromódní `<input type="checkbox" />` a na něj navázaný `<label>`. Ten umožní změnu a zapamatování stavu, aniž by bylo nutné používat JavaScript.

Celý tento postup je vcelku standardní a dobře je popsaný třeba v [článku na webu Code Cut Down](https://cutcodedown.com/tutorial/mobileMenu), který mě inspiroval.

## Moje řešení: SCSS mixin a sémantické HTML

Mým cílem bylo vytvořit jednoduchý SCSS mixin, který nebude předpokládat použití žádného UI frameworku nebo jakýchkoliv dalších závislostí. Bude ho tedy možné použít kdekoliv. HTML kód by měl být co možná nejjednodušší a sémantický.

HTML kód potřebný pro menu vypadá následovně:

```html
<input type="checkbox" id="mtoggler" hidden="hidden" />
<label for="mtoggler" class="open" hidden="hidden"><span>&#x2630;</span></label>
<label for="mtoggler" class="close" hidden="hidden"><span>&#x1F5D9;</span></label>
<ul>
    <li><a href="#">Lorem</a></li>
    <li><a href="#">Ipsum</a></li>
    <li><a href="#">Dolor</a></li>
    <li><a href="#">Sit</a></li>
    <li><a href="#">Amet</a></li>
</ul>
```

Prvek `input` není vidět (což je zařízeno jednak atributem `hidden` a pro starší prohlížeče ještě umístěním mimo viewport v CSS) a slouží jenom k zapamatování stavu rozbalovacího menu.

Elementy `label` se používají pro rozbalovací menu. Ten s `class="open"` má obsah, který menu otevírá (v našem případě Unicode trigram pro nebe, který se používá pro "hamburgerové" menu - "&#x2630;"). Ten s `class="close"` má obsah, který se zobrazí v případě, že je menu rozbalené (v našem případě křížek "&#x1F5D9;" pro zavření menu). Bohužel se mi nepodařilo se obejít bez jednoho sémanticky prázdného `span`u navíc, ale asi s tím dokážu žít.

Tyto elementy jsou vzájemně propojeny pomocí atributů `id` a `for`, aby aktivace `label`u ovládala `input`.

Vlastní menu je klasický seznam vytvořený pomocí `ul` a `li`.

To celé musí být uzavřeno v nějakém elementu. Sémanticky se nabízí `nav`, ale může to být i `div`.

SCSS mixin vypadá takto:

```scss
@mixin rnav($WidthStop: 40em, $Padding: .5em, $ItemSpacing: 2em, $Color: #fff, $BackColor: #000, $HoverColor: #fd0, $HoverBackColor: #333, $WideAlign: center, $NarrowAlign: left) {
    input[type=checkbox] {
        position: absolute;
        left: -9999em;

        ~ label {
            display: none;
        }
    }

    ul {
        list-style: none;
        text-align: $WideAlign;
        margin: 0;
        padding: $Padding;
        background: $BackColor;

        li {
            display: inline;
        }

        a {
            display: inline-block;
            padding: $Padding $ItemSpacing / 2;
            text-decoration: none;
            color: $Color;

            &:active, &:focus, &:hover {
                color: $HoverColor;
                background: $HoverBackColor;
            }
        }
    }

    @media (max-width:$WidthStop) {
        ul {
            display: none;
            overflow: hidden;

            li {
                text-align: $NarrowAlign;
            }

            a {
                display: block;
            }
        }

        input[type=checkbox] {
            ~ label {
                padding: $Padding;
                text-align: $NarrowAlign;
                background: $BackColor;
                color: $Color;

                span {
                    padding: $Padding;
                    display: block;

                    &:active, &:focus, &:hover {
                        background: $HoverBackColor;
                        color: $HoverColor;
                    }
                }

                &.open {
                    display: block;
                }

                &.close {
                    display: none;
                }
            }



            &:checked {
                ~ label {
                    margin: 0;

                    &.open {
                        display: none;
                    }

                    &.close {
                        display: block;
                    }
                }

                ~ ul {
                    display: block;
                }
            }
        }
    }
}
```

Pro popis jeho funkčnosti si přečtěte dříve odkazovaný článek. Já jsem tamo uváděné CSS jenom převedl do SCSS a parametrizoval. Parametry a jejich výchozí hodnoty jsou následující:

* `$WidthStop: 40em` - maximální šířka, při níž se zobrazí sbalovací vertikální menu.
* `$Padding: .5em` - padding použitých prvků.
* `$ItemSpacing: 2em` - vzdálenost mezi položkami horizontálního menu.
* `$Color: #fff` - barva textu v normálním stavu.
* `$BackColor: #000` - barva pozadí v normálním stavu.
* `$HoverColor: #fd0` - barva textu aktivní položky.
* `$HoverBackColor: #333` - barva pozadí aktivní položky.
* `$WideAlign: center` - zarování horizontálního menu.
* `$NarrowAlign: left` - zarovnání vertikálního menu.

Výše uvedený kód lze uložit do samostatného souboru `_rmenu.scss`.

## Použití

V SCSS kódu stačí mixin použít v selektoru, který chcete proměnit v menu. Například:

```scss
@import "_rnav.scss";

nav {
    @include rnav();
}
```

Zde si můžete vyzkoušet jednoduché, čistě textové menu:

<iframe height="450" style="width: 100%;" scrolling="no" src="https://codepen.io/ridercz/embed/Jjopray?height=265&theme-id=light&default-tab=result" frameborder="no" allowtransparency="true" allowfullscreen="true">
</iframe>

Zde je trochu sofistikovanější varianta, která používá ikonky z Font Awesome:

<iframe height="450" style="width: 100%;" scrolling="no" src="https://codepen.io/ridercz/embed/yLyvzRY?height=265&theme-id=light&default-tab=result" frameborder="no" allowtransparency="true" allowfullscreen="true">
</iframe>

Kompletní zdrojové soubory jsou [k dispozici ke stažení](https://www.cdn.altairis.cz/Blog/2020/20200102-scss-menu.zip).