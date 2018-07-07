<!-- dcterms:identifier = aspnetcz#308 -->
<!-- dcterms:title = Async CTP, OData – prezentace a příklady z DevNetConu -->
<!-- dcterms:abstract = Pokud jde všechno podle plánu, tak právě v tomto okamžiku začínám v Bratislavě svou přednášku o podzimních novinkách pro webové vývojáře. Můžete si stáhnout mou prezentaci a příklady, které budu předvádět. -->
<!-- np9:categoryId = 6 -->
<!-- x4w:category = Akce a události -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2010-11-25T00:18:38.21+01:00 -->
<!-- dcterms:dateAccepted = 2010-11-25T14:00:00+01:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20101125-async-ctp-odata-prezentace-a-priklady-z-devnetconu.png -->

Pokud jde všechno podle plánu, tak právě v tomto okamžiku začínám v Bratislavě svou přednášku o podzimních novinkách pro webové vývojáře. Jak jsem již [zaznamenal na TechEdu](http://www.aspnet.cz/articles/306-teched-europe-2010-den-nula), Microsoft nyní zbožně obrací zraky k nebesům. Nebo to možná není zbožnost, ale prostá snaha prosadit svou cloud computing platformu Windows Azure. Většina aktivit Microsoftu jde tedy tímto směrem a skutečných vývojářských novinek není právě mnoho. Nicméně dvě věci, které by nás na podzim zajímat mohly, jsem najít dokázal.

## Visual Studio Async CTP

Asynchronní programování je oblast, se kterou programátoři často bojují (pokud píší desktopové aplikace a nic jiného jim nezbývá) a nebo kterou se ani neodvažují nakousnout (to pokud píší aplikace webové, kde se za normálních okolností radostem multithreadingu vyhnou). Což je v mnoha případech škoda, protože současné aplikace věčně na něco čekají – na odpověď ze sítě, z databáze… Vhodné použití asynchronních přístupů je může jednak zrychlit a především zprůchodnit, umožnit obsloužení ěvtšího množství uživatelů.

Microsoft přišel s [Visual Studio Async CTP](http://msdn.com/vstudio/async/), což je knihovna pro .NET Framework, která umožňuje pomocí nových klíčových slov *async* a *await* využívat asynchronní metody z kódu, který se jinak tváří jako běžný synchronní. Tj. lze na něm běžnými způsoby odchytávat výjimky, nemusíte se piplat s delegáty a podobně.

## Open Data Protocol (OData)

Jako by jich nebylo málo. OData je další způsob, jak přistupovat k datům přes web. Od dosud představených technik se liší tím, že je to konglomerát již existujících technologií – HTTP, ATOM, JSON a další. Jde tedy spíše o propojení již existujících technologií.

Ačkoliv OData lze publikovat i konzumovat mnoha různými způsoby, zajímavá je i .NET podpora pro ně – velmi jednoduchá a přímočará

## Prezentace a příklady

Prezentaci a příklady na výše uvedené si můžete stáhnout na [http://www.aspnet.cz/files/20101125-DevNetCon.zip](https://www.cdn.altairis.cz/Blog/2010/20101125-DevNetCon.zip "http://www.aspnet.cz/files/20101125-DevNetCon.zip") (800 kB).