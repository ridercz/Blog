<!-- dcterms:identifier = aspnetcz#5445 -->
<!-- dcterms:title = Prezentace a příklady z mých přednášek na TechEdu 2016 -->
<!-- dcterms:abstract = Letos jsem měl na TechEdu sedm přednášek. Nebo spíše šest, protože přednáška o kryptografii byla rozdělena do dvou částí. Nyní vám nabízím prezentace a příklady ke stažení. -->
<!-- np9:categoryId = 6 -->
<!-- x4w:category = Akce a události -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2016-05-20T21:52:30.637+02:00 -->
<!-- dcterms:date = 2016-05-20T21:52:31+02:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20160520-prezentace-a-priklady-z-mych-prednasek-na-techedu-2016.jpg -->

Letos jsem měl na TechEdu sedm přednášek. Nebo spíše šest, protože přednáška o kryptografii byla rozdělena do dvou částí. Nyní vám nabízím prezentace a příklady ke stažení.

Microsoft ví, jak udělat speakerům život zajímavý. Takže zatímco jsem v pondělí ráno měl úvodní přednášku a povídání o hostingu, tentýž den večer (našeho času) Microsoft vydal novou verzi, RC2. V ní je dost věcí jinak, zejména pokud se týče toolingu a hostingu. Já jsem sice o tom, že ta verze bude, věděl dopředu (přesněji, dozvěděl jsem se to v neděli večer), ale nevěděl jsem, jaké přesně ty změny budou a především jsem o nich nesměl mluvit. 

Keynote je proto poněkud neurčitá a mluví o principech, které se nezměnily. Přednáška o hostingu je na tom hůře, protože probírá i technické detaily a můj konkrétní návod na zprovoznění .NET Core na IIS nebude v RC2 plně funkční. Přednáška o konfiguraci by měla být aktuální. Demo je napsané pro RC1, ale to je především proto, že jsem už neměl čas ho upgradovat.

## Developers Keynote

Všechno co nechcete vědět o ASP.NET Core Co je to černé, co klepe na dveře? Přece růžová budoucnost ASP.NET! No, ve skutečnosti to tak hrozné není. ASP.NET Core (dříve ASP.NET 5) přináší spoustu dobrých novinek, ale přechod na ně bude pro většinu .NET programátorů poněkud bolestný. Jedná se o kompletní restart platformy a velice podstatné množství vašich současných znalostí a dovedností není snadno přenositelných. Na druhou stranu, ASP.NET Core vám dává nové možnosti k rozletu, možnost vyvíjet na nových platformách a další. Neignorujte ho proto. I když vám nebude k užitku teď hned, vyplatí se ho mít na zřeteli a sledovat jeho postup. Kdyby už jenom proto, že pokud tak neučiníte, v novinkách se utopíte ve chvíli, kdy na něj budete muset přejít. 

*   [Prezentace](https://www.cdn.altairis.cz/Blog/2016/20160519-TechEd2016-01_DeveloperKeynote.pdf)

## ASP.NET Core: Hosting

Zapomeňte na HTTP handlery a moduly. Co všechno potřebujete k provozu ASP.NET Core aplikací? Jak takové aplikace běží na IIS, bez něj anebo třeba na serveru s Linuxem? Představím vám základní logiku ASP.NET Core aplikace a vše, co potřebujete k tomu, abyste ji mohli nasadit do ostrého provozu. 

*   [Prezentace](https://www.cdn.altairis.cz/Blog/2016/20160519-TechEd2016-02_Hosting.pdf)

## ASP.NET Core: Konfigurace aplikací

Zapomeňte na web.config. ASP.NET Core přináší zcela nový konfigurační model. V něčem lepší, v něčem horší, každopádně jiný a s mnoha možnostmi. Ukážeme si, jak načítat konfiguraci ze souborů v různých formátech, z proměnných prostředí, parametrů příkazové řádky nebo třeba z databáze. Jak k celému modelu přistupovat objektově a jak konfigurační hodnoty načítat pomocí IoC/DI principů. 

*   [Prezentace](https://www.cdn.altairis.cz/Blog/2016/20160519-TechEd2016-03_Config.pdf)
*   [Příklady](https://www.cdn.altairis.cz/Blog/2016/20160519-TechEd2016-03_ConfigSamples-RC1.7z) (RC1)

## ASP.NET Core: Úschova citlivých informací

Jak pracovat s citlivými údaji, jako jsou connection stringy, API klíče a podobně? Jak využívat základní kryptografické funkce v ASP.NET Core, když třeba chcete bezpečně roundtripovat data na klienta nebo uchovávat hesla uživatelů v systému? 

*   <div style="text-align: left;" abp="355">[Prezentace](https://www.cdn.altairis.cz/Blog/2016/20160519-TechEd2016-04_Secrets.pdf)</div>

*   [Příklady](https://www.cdn.altairis.cz/Blog/2016/20160519-TechEd2016-04_SecretSamples-RC2.7z)

## Praktická kryptografie pro programátory v .NET

Věcem jako je šifrování, elektronické podpisy, hashe a podobné věci se při programování nevyhnete. A pokud jste typickými aplikačními programátory, mnoho o nich nevíte a pokud se odvážně vrhnete do víru tříd .NET Frameworku, nejspíš naděláte více škody než užitku. Proto jsem pro vás připravil tuto dvoudílnou přednášku, na níž vám ukážu nejenom kryptografické schopnosti .NET Frameworku, ale především vysvětlím, jak je používat - a také proč to nedělat. 

*   [Prezentace](https://www.cdn.altairis.cz/Blog/2016/20160519-TechEd2016-05-06_Crypto101.pdf)
*   [Příklady](https://www.cdn.altairis.cz/Blog/2016/20160519-TechEd2016-05-06_CryptoSamples.7z)

## Jak na opravdové fulltextové vyhledávání s MS SQL Serverem

Chcete ve své aplikaci opravdové fulltextové vyhledávání a ne jenom LIKE '%něco%'? Takové, které vašim datům skutečně rozumí, dokáže si poradit s různými tvary slov a podobně? A to vše zdarma a v češtině? Pak jsou tu pro vás fulltextové schopnosti Microsoft SQL Serveru. Naučím vás, jak budovat, aktualizovat a používat fulltextové indexy. Ukážeme si, jak vypadá syntaxe fulltextových dotazů a protože ji vaši uživatelé nejspíš nepochopí, jak si vytvořit vlastní dotazovací jazyk (třeba podobný tomu od Google) a jak pro něj napsat parser. Podíváme se také, jak naučit fulltext zdvořilému chování k Entity Frameworku, který si s ním jinak příliš nerozumí. 

*   [Prezentace](https://www.cdn.altairis.cz/Blog/2016/20160519-TechEd2016-07_SqlFulltext.pdf)
*   [Příklady](https://www.cdn.altairis.cz/Blog/2016/20160519-TechEd2016-07_SqlFulltextSamples.7z)