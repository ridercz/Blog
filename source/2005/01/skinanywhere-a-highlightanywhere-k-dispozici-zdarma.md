<!-- dcterms:identifier = aspnetcz#11 -->
<!-- dcterms:title = SkinAnywhere a HighlightAnywhere k dispozici zdarma -->
<!-- dcterms:abstract = ...aneb HTTP moduly v praxi: skinování a syntax highlighting ve vaší aplikaci, bez nutnosti cokoliv instalovat -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = IT -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2005-01-11T22:38:16.657+01:00 -->
<!-- dcterms:date = 2005-01-11T22:38:16.657+01:00 -->

V rámci psaní článků o HTTP modulech jsem se rozhodl vydat dva své programy, [SkinAnywhere](http://software.altaircom.net/software/skinanywhere.aspx) a [HighlightAnywhere](http://software.altaircom.net/software/highlightanywhere.aspx). Oba dva jsou k dispozici zdarma včetně zdrojového kódu, pod licencí LGPL. Ta vám umožní je implementovat do svých aplikací, a to i pokud mají kód uzavřený.

## SkinAnywhere

Vzhledem ke schopnostem dnešních prohlížečů je velmi snadné nabízet tentýž web v několika vzhledových variantách (skinech). Není třeba modifikovat HTML kód, stačí jenom nahrát patřičný CSS stylesheet.

Praktický příklad jest možno viděti na mém [soukromém blogu](http://weblog.rider.cz/).

Prostřednictvím HTTP modulu je možno tuto funkcionalitu přidat do jakékoliv ASP.NET aplikace, aniž by bylo nutno ji modifikovat. Na základě konfigurace HTTP modul prohledá vygenerované HTML a nahradí odkaz na stylesheet svým vlastním.

Stahujte na [http://software.altaircom.net/software/skinanywhere.aspx](http://software.altaircom.net/software/skinanywhere.aspx)

## HighlightAnywhere

Publikujete-li na svých stránkách ukázky zdrojových kódů, je užitečné pokud mohou obsahovat tzv. *syntax highlighting*, tedy barevné zvýraznění určitých konstrukcí, jako například klíčových slov. Ať už je v HTML implementováno jakkoliv, učiní daný zdrojový kód dále víceméně needitovatelným, je-li vložen v nějakém článku, který by bylo později třeba upravit.

Proto na tomto blogu používám HTTP modul, který automaticky provede syntax highlighting na každém textu, který je uzavřen do tagu `<pre class="typ-zvyrazneni">...</pre>`.

Vlastní zvýrazňování je realizováno open source (LGPL) knihovnou [SquishySyntaxHighlighter](http://www.squishyweb.com/ware/products.asp?q=squishysyntax), já jsem jenom napsal vhodný wrapper.

Stahujte na [http://software.altaircom.net/software/highlightanywhere.aspx](http://software.altaircom.net/software/highlightanywhere.aspx)