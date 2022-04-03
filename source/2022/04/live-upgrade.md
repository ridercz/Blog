<!-- dcterms:title = Pozvánka na live coding: Upgrade aplikace z ASP.NET 5 na 6 -->
<!-- dcterms:abstract = Konec podpory .NET 5 se blíží a je třeba upgradovat na .NET 6. V úterním živém streamu budeme upgradovat aplikaci AskMe na ASP.NET 6.0 -->
<!-- x4w:category = IT -->
<!-- x4w:category = Z-TECH -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:dateAccepted = 2022-04-03 -->
<!-- x4w:pictureUrl = /perex-pictures/20220403-live-upgrade.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20220403-live-upgrade.jpg -->

Populární verze .NET 5.0 přestane být v květnu podporována. Je proto zapotřebí upgradovat aplikace na ní běžící na aktuální verzi 6.0. Na své ukázkové aplikaci AskMe vám ukážu, jakým způsobem lze upgrade provést. 

Nejprve se vydám snadnou cestou, kdy udělám jenom to nejnutnější, aby aplikace běžela na aktuální verzi. Poté aplikaci přepíšu tak, aby využívala nový hosting model v ASP.NET 6.0 a další features, které jsou k dispozici.

## Kdy a kde

**Live stream poběží v úterý 5. 4. 2022 od 18:00 na [YouTube kanále Z-TECH](https://www.youtube.com/watch?v=yenqGXdSa-w).**

V průběhu streamu budete mít možnost mi posílat otázky přes chat a já na ně budu odpovídat. Počítejte s tím, že live coding bude doopravdy. **Není to připravené uhlazené demo**, ale budu skutečně vymýšlet jak to udělat. Zatím jsem všechny aplikace upgradoval jenom tou snadnou cestou, ale neaplikoval jsem to existující aplikace nový hosting a startup model, takže budu muset vymyslet jak to dělat.

## Podpora .NET

Platforma .NET má dva druhy verzí (releases):

* **Current** verze jsou ty s lichými čísly (5.x a následně 7.x atd.). Jsou podporovány 18 měsíců od uvedení.
* **LTS** (long term support) verze mají čísla sudá (6.c, 8.x atd.). Jsou podporovány 36 měsíců (tři roky) od uvedení.

Platí také, že nová verze .NETu by měla vyjít vždy jednou za rok na podzim (plán je listopad). Znamená to tedy, že pokud vyvíjíte na _Current_ verzi, máte na upgrade půl roku od uvedení následné verze a čeká vás to jednou ročně. Pokud vyvíjíte na _LTS_ verzi, upgradujete jednou za dva roky a máte na to rok času.

Aktuálně podporované verze .NETu:

Verze         | Release | Datum GA     | Konec podpory
------------- | :-----: | :----------: | :----------:
.NET Core 3.1 | LTS     | 03. 12. 2019 | 03. 12. 2022
.NET 5        | Current | 10. 11. 2020 | 08. 05. 2022
.NET 6        | LTS     | 08. 11. 2021 | 08. 11. 2024

Podrobnější informace najdete na stránce [.NET and .NET Core Support Policy](https://dotnet.microsoft.com/en-us/platform/support/policy/dotnet-core)

## Aplikace AskMe

Ukázková aplikace AskMe je v podstatě jednouživatelská verze služby ASK.FM, která umožňuje anonymní pokládání otázek. Napsal jsem ji v roce 2018 v ASP.NET Core 2.1, abych ukázal rozdíly mezi MVC a tehdejší novinkou, Razor Pages. Aplikace je napsána dvakrát, jednou v MVC a jednou v Razor Pages, takže lze oba přístupy porovnat. AskMe je aplikace jednoduchá, ale řeší řadu reálných scénářů (přístup k datům, autentizace a podobně). Postupně jsem ji upgradoval na .NET Core 3 a momentálně běží na .NET 5.

**Zdrojové kódy aplikace [najdete na GitHubu](https://github.com/ridercz/AskMe/).**

## Doporučené odkazy

* [Migrate from ASP.NET Core 5.0 to 6.0](https://docs.microsoft.com/en-us/aspnet/core/migration/50-to-60)
* [Breaking changes in .NET 6](https://docs.microsoft.com/en-us/dotnet/core/compatibility/6.0)
* [Breaking changes in EF Core 6.0](https://docs.microsoft.com/en-us/ef/core/what-is-new/ef-core-6.0/breaking-changes)