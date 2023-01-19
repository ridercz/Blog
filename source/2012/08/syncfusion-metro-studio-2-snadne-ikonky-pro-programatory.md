<!-- dcterms:identifier = aspnetcz#398 -->
<!-- dcterms:title = SyncFusion Metro Studio 2: Snadné ikonky pro programátory -->
<!-- dcterms:abstract = Prakticky každá webová aplikace potřebuje nějaké ikony. Ale kde je vzít a nekrást, zejména když vám Silk Icons už lezou krkem? Syncfusion nabízí program na generování ikon ve stylu Metro, s logikou přátelskou pro programátory a navíc zdarma. -->
<!-- np9:categoryId = 7 -->
<!-- x4w:category = Software -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2012-08-24T02:13:44.287+02:00 -->
<!-- dcterms:date = 2012-08-24T02:05:00+02:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20120824-syncfusion-metro-studio-2-snadne-ikonky-pro-programatory.jpg -->

Prakticky každá webová aplikace (a nejen webová, samozřejmě) potřebuje nějaké ikony. V ideálním světě je vytváří grafik, potažmo UI designér. Reálně je často valná část návrhu UI nechána na programátorech, kteří vesměs nemají na hraní s ikonkami čas, schopnosti a nástroje.

Existují hotové sady ikon (třeba [Silk Icons](http://www.famfamfam.com/lab/icons/silk/), které jsem zahrnul i do komponent v [Altairis.Web.UI](http://altairiswebui.codeplex.com)), ale co když vám už lezou krkem, případně se vám esteticky nehodí do krámu, protože chcete navrhnout něco v novém "Metro" stylu?

Společnost [SyncFusion](http://www.syncfusion.com/), známá především jako autor .NET komponent, relativně nedávno přišla s nástrojem pro generování a správu obrázků/ikon v jednoduchém Metro stylu. Nástroj propaguje jako "developer friendly" a je skutečně určen spíše pro programátory, než pro grafiky.

[![Hlavní rozhraní programu](https://www.cdn.altairis.cz/Blog/2012/20120824-metrostudio_thumb.png "Hlavní rozhraní programu")](https://www.cdn.altairis.cz/Blog/2012/20120824-metrostudio_2.png)

Program v sobě obsahuje 1700 základních symbolů, které jsou řazeny do kategorií a které lze fulltextově prohledávat. Všechny symboly jsou v jednotném, jednoduchém stylu a jsou vektorové, takže je možné je libovolně zvětšovat a zmenšovat. Program také obsahuje funkci pro vyváření symbolů ze znaků libovolného fontu.

Po výběru jednoho ze základních symbolů můžete editovat jeho velikost, barvu, úhel natočení, pozadí a další parametry:

[![Rozhraní pro editaci symbolu](https://www.cdn.altairis.cz/Blog/2012/20120824-iconedit_thumb.png "Rozhraní pro editaci symbolu")](https://www.cdn.altairis.cz/Blog/2012/20120824-iconedit_2.png)

Výslednou kompozici pak můžete kopírovat do schránky jako obrázek (vhodné pro další práci v nějakém grafickém programu), nebo vyexportovat v řadě formátů. Nejpoužívanější budou asi klasické PNG/ICO, ale program podporuje i přímý export v podobě XAML markupu, což ocení zejména WPF vývojáři.

U exportu zamrzí snad jenom nemožnost obrázek exportovat v nějakém běžném vektorovém formátu, nejlépe SVG. Je to překvapivé i vzhledem k tomu, že obrázky původně v SVG uloženy jsou.

[![Projekty](https://www.cdn.altairis.cz/Blog/2012/20120824-ilwp_thumb.png "Projekty")](https://www.cdn.altairis.cz/Blog/2012/20120824-ilwp_2.png)

Prostým přetažením symbolu do levého dolního rohu můžete vytvářet též kolekce ikon – projekty, třeba pro konkrétní aplikaci. Takovou kolekci je možno též uložit jako CSS sprite pro použití v HTML. Bohužel vygenerované css je chybné, protože u pozičních informací chybí jednotky (px) a je tedy nutné je upravovat.

Přes tyto drobné nevýhody ale Metro Studio doporučuji každému, kdo musí ikony tvořit či hledat a jejich kreslení nepatří mezi jeho koníčky. Aplikace je zdarma a můžete si ji stáhnout na adrese [http://www.syncfusion.com/downloads/metrostudio](http://www.syncfusion.com/downloads/metrostudio "http://www.syncfusion.com/downloads/metrostudio").