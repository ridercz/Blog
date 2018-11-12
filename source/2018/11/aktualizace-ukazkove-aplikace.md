<!-- dcterms:title = Aktualizace ukázkové aplikace ASKme -->
<!-- dcterms:abstract = Nedávno jsem publikoval ukázkové aplikace pro technologii ASP.NET Razor Pages. Dnes jsem aplikaci ASKme aktualizoval tak, že má i variantu napsanou v ASP.NET MVC Core. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20181024-ukazkove-aplikace.png -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = IT -->
<!-- x4w:category = Software -->
<!-- dcterms:dateAccepted = 2018-11-12 -->

Nedávno jsem zde zveřejnil [článek o svých ukázkových aplikacích](/2018/10/ukazkove-aplikace) pro ASP.NET Core.

Jednou z nich je AskMe a jde v podstatě o jednouživatelskou kopii služby [Ask.fm](https://ask.fm/ridercz). Tato služba umožňuje anonymní (nebo pseudo-anonymní) pokládání otázek (můžete se zeptat [i mne](https://ask.fm/ridercz)).

Nyní je aplikace k dispozici ve dvou variantách:

* **Altairis.AskMe.Web.RazorPages** je původní aplikace napsaná v Razor Pages, jenom přejmenovaná.
* **Altairis.AskMe.Web.Mvc** je přesně stejná aplikace, ovšem napsaná v ASP.NET MVC.

Obě dvě aplikace vypadají z pohledu uživatele úplně stejně a úplně stejně se i chovají, včetně stejných URL a podobně. Využívají i společnou vrstvu pro přístup k datům, vytvořenou pomocí Entity Frameworku Core, projekt **Altairis.AskMe.Data**.

Můžete tedy porovnat rozdíly a naopak společné části, které mají oba dva přístupy - MVC i MVVM (Razor Pages). Z tohoto důvodu oba webové projekty obsahují spoustu podobného a zkopírovaného kódu. V normálním případě by bylo správné onen sdílený kód vyčlenit do samostatného projektu a neduplikovat ho. Zde to záměrně nedělám, aby bylo možné porovnat obě řešení.

Ukázkové aplikace najdete na [mém GitHubu](https://github.com/ridercz/AskMe/).