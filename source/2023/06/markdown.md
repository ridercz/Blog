<!-- dcterms:title = Markdown pro uživatele i pro vývojáře -->
<!-- dcterms:abstract = Mám rád Markdown. Jednoduchý značkovací jazyk, který umožňuje do textu přidat formátování, odkazy a podobně. Nejsem sám, protože Markdown dneska používá kdekdo - GitHub, Reddit, Telegram, Facebook Messenger a další. Připravil jsem pro vás dvě videa, ve kterých se naučíte jak MD psát jako uživatelé a využívat jako vývojáři. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:coverUrl = /cover-pictures/20230608-markdown.jpg -->
<!-- x4w:pictureUrl = /perex-pictures/20230608-markdown.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = IT -->
<!-- dcterms:date = 2023-06-08 -->

Mám rád Markdown. Jednoduchý značkovací jazyk, který umožňuje do textu přidat formátování, odkazy a podobně. Nejsem sám, protože Markdown dneska používá kdekdo - GitHub, Reddit, Telegram, Facebook Messenger a další. Pro mne jako pro programátora je užitečný také tím, že do něj lze snadno přidávat ukázky zdrojového kódu v různých jazycích a podobně. Tento blog běží na Markdownu (resp. zdrojové texty článků píšu v Markdownu) a obecně ho používám kde to jenom jde. Připravil jsem pro vás dvě videa, ve kterých se naučíte jak MD psát jako uživatelé a využívat jako vývojáři.

## Markdown pro uživatele

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/B7zOCyB_3TI" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

První video je určeno pro běžné uživatele. Představuje markdown formát jako takový. Jakým způsobem lze dělat běžné formátování textu, odkazy, vkládat obrázky, tabulky a další. Na webu SimpleMDE je [dobrý cheat sheet s přehledem syntaxe](https://simplemde.com/markdown-guide). Ale MD je tak jednoduchý, že vám rychle přejde do krve, uživatelé s tím většinou nemívají problémy.

## Markdown pro programátory

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/WabP1W2K_6E" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

Druhé video je určeno programátorům v .NETu. Ukazuji v něm, jak pomocí knihovny [Markdig](https://github.com/xoofx/markdig/) renderovat MD do HTML. Ukazuji, jak to udělat bezpečně (třeba zakázat vkládání přímého HTML) a jak si rozšířit Markdown o vlastní příkazy, třeba když napíšete `@username`, tak se vytvoří odkaz na daného uživatele

## Další možnosti

* Nejlepší editor pro Markdown je podle mého názoru Visual Studio Code. Obecně VS Code miluju a používám ho skoro na všechno, s výjimkou .NET programování. Nabízí syntax highlighting, okamžitý preview (vhodný zejména když s MD začínáte) a je [dostupný i na webu](https://vscode.dev/), takže nemusíte nic instalovat.
* Markdown obecně nepodporuje WYSIWYG, z povahy věci -- je to sémantický jazyk, kde autor určuje význam a vzhled závisí na použitém renderování. Při zadávání MD textu na webu se ale může hodit pseudo-WYSIWYG editor [SimpleMDE](https://simplemde.com/), který umí vhodným způsobem zdůraznit jednotlivé konstrukce.