<!-- dcterms:title = C# pro mírně pokročilé: Argumenty metod -->
<!-- dcterms:abstract = Metody (procedury, funkce...) a jejich argumenty jsou v C# základní jazykovou konstrukcí. Za dvacet let existence jazyka však doznaly změn a značného vývoje, již tradičně směrem ke zjednodušení a zpříjemnění práce programátora. V dnešním videu si ukážeme, k čemu slouží klíčová slova in a out, operátor nameof či caller info attributes. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20210916-csharp-arguments.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20210916-csharp-arguments.jpg-->
<!-- x4w:category = Z-TECH -->
<!-- x4w:category = IT -->
<!-- dcterms:dateAccepted = 2021-09-16 -->

Metody (procedury, funkce...) a jejich argumenty jsou v C# základní jazykovou konstrukcí. Za dvacet let existence jazyka však doznaly změn a značného vývoje, již tradičně směrem ke zjednodušení a zpříjemnění práce programátora. V dnešním videu si ukážeme, k čemu slouží klíčová slova `in` a `out`, operátor `nameof` či caller info attributes.

Co zajímavého metody a jejich argumenty umí?

* Overloads umožňují zapsat více "variant" metody s různými parametry. Která metoda se zavolá se rozhodne automaticky na základě typů předaných hodnot.
* Param arrays jsou syntaktický cukr, kdy lze s použitím klíčového slova [`params`](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/params) hodnotu typu jednorozměrného pole zadat též jako libovolné množství samostatných argumentů 
* Pomocí klíčových slov `out` a méně známého `in` lze definovat argumenty jako pouze vstupní nebo výstupní. U výstupních argumentů je lze pomocí `var` deklarovat až v okamžiku použití, případně lze jejich hodnotu ignorovat použitím znaku `_` (podtržítko) jako discard.
* Argumenty mohou být volitelné (tím že se jim určí výchozí hodnota) a při volání je lze pojmenovat, což přispívá ke srozumitelnosti kódu.
* Pomocí atributů `[CallerMemberName]`, `[CallerFilePath]` a `[CallerLineNumber]` lze zjistit, z jakého místa kódu byla vaše metoda volána; to se hodí zejména v případě logovacích metod, které tyto informace zaznamenávají pro diagnostické účely.
* Operátor `nameof` se striktně vzato argumentů metod netýká, ale přesto jsem ho sem zařadil. Umožňuje totiž vrátit název nějakého konstruktu jako string, což se hojně používá při validaci hodnot argumentů.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/KO2fzGmsuRE" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>
