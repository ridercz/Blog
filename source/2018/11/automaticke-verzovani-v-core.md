<!-- dcterms:title = Automatické verzování projektu v ASP.NET Core -->
<!-- dcterms:abstract = Trendem při určování nových verzí je v současnosti sémantické verzování. To má význam zejména u knihoven a komponent, která jsou využívána v dalších aplikacích. V případě vývoje koncových aplikací nicméně může být lepší používat automatické generování verzí podle datumu. V .NET Core to jde překvapivě snadno. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20181109-automaticke-verzovani-v-core.png -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = IT -->
<!-- dcterms:date = 2018-11-09 -->

Trendem při určování nových verzí je v současnosti [sémantické verzování](https://semver.org/). To má význam zejména u knihoven a komponent, která jsou využívána v dalších aplikacích. V případě vývoje koncových aplikací nicméně může být lepší používat automatické generování verzí podle datumu.

První verze .NETu (&lt;4.5) a Visual Studia měly tuto funkci vestavěnou. Stačilo ve specifikaci verze použít symbol hvězdičky (např. `1.0.*.*`) a část verzování se vygenerovala automaticky podle systémového času.

To se změnilo v .NET Frameworku 4.5, který přinesl podporu výše zmíněného sémantického verzování. Před pěti lety jsem napsal článek popisující, jak na automatické verzování pomocí [MS Build Community Tasks](/2013/11/jak-na-automaticke-verzovani-v-novych-verzich-net-a-vs).

## Automatické verzování v .NET Core

Chcete-li téhož efektu dosáhnout v .NET Core, je k dispozici mnohem jednodušší a elegantní řešení.

Verze projektu (případně jeho NuGet balíčku) se určuje pomocí elementu `Version` v `.csproj` souboru. Ten může obsahovat přímo text verze, např. `1.2.3` nebo `1.2.3-beta1` a podobně, v souladu se zásadami sémantického verzování.

Já nicméně v některých aplikacích dávám přednost verzování na základě aktuálního datumu a času komplilace. Např. verze zkompilovaná 7. 11. 2018 v 8:30 UTC bude mít číslo `2018.11.7.830` (doporučuji používat hodnoty v UTC, abyste se vyhnuli problémům s časovými pásmy a změnami času).

V .NET Core na to nepotřebujete žádnou zvláštní podporu nebo task, stačí do `.csproj` souboru zadat verzi takto:

```xml
<Version>$([System.DateTime]::UtcNow.ToString('yyyy.MM.dd.HHmm'))</Version>
```

Podobným způsobem můžete nakládat i s elementy `AssemblyVersion` a `FileVersion`, ale pokud je neuvedete, převezmou hodnotu z `Version`.

U každé assembly můžete určovat tři verze, přičemž hodnota každé z nich může být zcela jiná (ne že by to byl dobrý nápad):

* `Version` je verze NuGet balíčku a její hodnota by mělo být to, jak je produkt označován v běžné komunikaci, dokumentaci atd.
* `AssemblyVersion` je hodnota, se kterou pracuje .NET interně, např. pro určování kompatibility a podobné účely.
* `FileVersion` pak může sloužit k unikátní identifikaci konkrétního buildu.

V praxi je dobré s tím příliš nelaborovat, nastavit hodnotu jednotně ve `Version` a ta se pak použije pro všechny uvedené účely. K dispozici jsou též [podrobnější informace](https://docs.microsoft.com/en-us/dotnet/standard/library-guidance/versioning) o významu jednotlivých verzí přímo od Microsoftu.