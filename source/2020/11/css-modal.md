<!-- dcterms:title = Modální dialog čistě pomocí CSS -->
<!-- dcterms:abstract = Jsem stará konzerva a s radostí se obejdu bez JavaScriptu, pokud je to možné. Před časem jsem popisoval, jak pomocí CSS udělat responzivní menu. Dnes vám ukážu, jak udělat modální dialogové okno pomocí CSS. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20201117-css-modal.png -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20200512-taghelpers.png -->
<!-- x4w:category = IT -->
<!-- dcterms:dateAccepted = 2020-11-17 -->

Jsem stará konzerva a s radostí se obejdu bez JavaScriptu, pokud je to možné. Před časem jsem popisoval, jak [pomocí CSS udělat responzivní menu](/2020/01/scss-menu). Dnes vám ukážu, jak udělat modální dialogové okno pomocí CSS, k čemuž mě inspirovalo [toto demo Timothy Longa](https://codepen.io/timothylong/pen/HhAer).

## Ukázková aplikace

Ukázková aplikace je [informační systém pro FutLab](https://github.com/ridercz/FutLabIS), který píšu a [naživo se u toho streamuju](https://www.youtube.com/playlist?list=PLoOpAe_g1x4IxYK9A8aT0To60DF6IHTFl).

Tuto konkrétní změnu jsem neprogramoval při streamu, ale po jeho skončení. Ale ve streamu se párkrát zmiňuji o tom, že akci skončivší úspěchem (např. reset hesla) ukončuji pro jednoduchost tím, že přesměruji uživatele na úvodní stránku a že to později udělám líp. Nyní nastalo to _později_.

Kompletní změnu najdete na GitHubu v commitu [`e1e013f`](https://github.com/ridercz/FutLabIS/commit/e1e013fe7573848c13712d97ffdd6b0d93ea08f7).

## Kouzlo selektoru :target

Součástí URL může být též část za znakem `#`, označovaná jako _hash_ nebo _fragment_, např. `http://www.example.com/path/#neco`. Tato část je určena čistě pro klienta a vůbec se neposílá při HTTP requestu na server (server výše uvedený příklad uvidí jenom jako `/path/`). Často se používá pro různé účely v klientských skriptech, ale její primární účel je jiný. Jedná se o ID elementu ve stránce obsaženého a prohlížeč na dlouhé stránce umí nascrollovat tak, aby byl označený element viditelný. Například [tento odkaz](https://en.wikipedia.org/wiki/Penrose_tiling#Features_and_constructions) vás na stránce Wikipedie věnované Penroseovu dláždění nasměruje na nadpis s ID `Features_and_constructions`.

No a pomocí CSS selektoru `:target` můžete pro daný element zařídit speciální stylování v případě, že byl tímto způsobem vybrán. Budete-li například v souboru `index.html` definovat element `<h1 id="nadpis">Toto je nadpis</h1>` a jemu odpovídající stylopis `h1:target { color: red; }`, bude při odkazu na `index.html#nadpis` element zobrazen červeně.

Můžeme dokonce zařídit, že ve výchozím stavu nebude prvek vidět vůbec (bude mít nastaveno `visibility: hidden`) a zobrazí se teprve ve chvíli, kdy na něj odkazuje fragment.

> Pozor, není možné použít `display: none`, protože v takovém případě není element dostupný ani pro fragmentové odkazy.

## Modální dialog

Toho lze využít pro zobrazní modálního informačního okna a jeho zavření, například kliknutím na tlačítko. Mějme jako součást stránky následující HTML fragment:

```html
<div id="sent" class="modal">
    <article>
        <header>Info</header>
        <p>Password reset instructions were sent to e-mail address registered for this account.</p>
        <p>Please follow the instructions in the message.</p>
        <footer>
            <a href="#" class="button">OK</a>
        </footer>
    </article>
</div>
```

a k němu následující kousek CSS, resp. SCSS:

```scss
.modal {
    visibility: hidden;
    opacity: 0;
    position: absolute;
    top: 0;
    right: 0;
    bottom: 0;
    left: 0;
    display: flex;
    align-items: center;
    justify-content: center;
    background: rgba(0, 0, 0, .5);

    &:target {
        visibility: visible;
        opacity: 1;
    }

    article {
        position: relative;
        min-width: 30%;
        max-width: 50%;
        background-color: #fff;
        text-align: center;

        header {
            text-align: left;
            padding: 5px;
            background-color: #c00;
            color: #fff;
            font-size: 150%;
        }

        p {
            margin: 20;
        }

        footer {
            margin: 20px;
        }
    }
}
```

Element `div.modal` a v něm dlící `article` atd. je nastylován tak, aby působil dojmem modálního okna - celé okno zakryje poloprůhledný `div` a v jeho středu bude `article` nastylovaný jako okno s hlavičkou. Celé to ale nebude vidět, protože `div.modal` má nastaveno `visibility:hidden`. Teprve ve chvíli, kdy je aktivní i selektor `target` se vše zobrazí. 

![Ukázka dialogového okna](https://www.cdn.altairis.cz/Blog/2020/20201117-css-modal.png)

Okno lze skrýt klepnutím na odkaz _OK_, který vede na adresu `#` - tedy aktuální stránku s prázdným fragmentem. Pokud bychom chtěli okno znovu zobrazit, lze tak učinit třeba po klepnutí na `<a href="#sent">odkaz</a>`.

To vše se děje čistě na straně klienta pomocí CSS, není třeba žádná serverová interakce nebo skripty.

## Serverová strana

Na straně serveru sice k fragmentu nemáme přístup, ale můžeme uživatele na stránku a fragmentem přesměrovat. ASP.NET Core má u metod typu `RedirectToPage` k dispozici overloady, které s fragmentem pracují, stejně tak je v Razoru tag helper `asp-fragment` který slouží stejnému účelu.

Podívejte se například na [změnu v souboru `ForgotPassword.cshtml.cs`](https://github.com/ridercz/FutLabIS/commit/e1e013fe7573848c13712d97ffdd6b0d93ea08f7#diff-9bf1856ac4acfe88a8c6e88bf489d34b1b621b593848764b03cee42f877dac5a). Původně tam byl řádek, který uživatele přesměroval na úvodní stránku webu:

```csharp
return this.RedirectToPage("/Index");
```

Nahradil jsem ho přesměrováním na jinou stránku (`/Login/Index.cshtml`) s fragmentem `sent`:

```csharp
return this.RedirectToPage("Index", null, "sent");
```

Na této stránce se pak nachází výše uvedený HTML kód, který zobrazí potvrzovací dialog.

## ModalBox tag helper

Abych si psaní modálních boxů usnadnil, napsal jsem si na to [ModalBoxTagHelper](https://github.com/ridercz/ReP/blob/master/Altairis.ReP.Web/TagHelpers/ModalBoxTagHelper.cs). Jedná se o tag helper, který mi vygeneruje výše zmíněné HTML, přičemž v Razoru pak stačí napsat

```html
<modal-box id="nejakeid" message="Text zprávy" />
```

Využití tag helperu je vidět na [přihlašovací stránce](https://github.com/ridercz/ReP/blob/master/Altairis.ReP.Web/Pages/Login/Index.cshtml), kde jich na konci mám hned několik, pro zobrazení různých zpráv souvisejících s procesem přihlašování, odhlašování, resetu zapomenutého hesla atd.

## K čemu je to dobré?

Užitečnost této konstrukce spočívá zejména ve zjednodušení aplikace. Buďto bychom potvrzovací zprávu zobrazili přímo ve stránce vzniklé po POST požadavku, což by ale znamenalo značnou komplikaci view a navíc obecně není vhodné vracet přímou odpověď na POST požadavky, protože to dělá nepořádek v historii a při použití tlačítka _Zpět_ v prohlížeči. Při klasickém _POST and redirect_ zase musíme vytvářet speciální potvrzovací stránku.

Toto řešení je elegantní, protože fakticky používá metodu _POST and redirect_, ale uživatele přesměruje ne na speciální stránku, ale na nějakou přibližně logickou (zde přihlašovací) kde zobrazí dialogové okno, které lze snadno zavřít.