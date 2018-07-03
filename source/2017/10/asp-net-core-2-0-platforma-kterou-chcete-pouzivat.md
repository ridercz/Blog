<!-- dcterms:identifier = aspnetcz#5461 -->
<!-- dcterms:title = ASP.NET Core 2.0: platforma kterou chcete používat -->
<!-- dcterms:abstract = Budoucností platformy ASP.NET jsem se na tomto webu zabýval již několikrát. Uspořádali jsme na toto téma i několik akcí: loni v létě konferenci CORESTART, před měsícem Budoucnost ASP.NET a 2. a 3. 11. nás čeká CORESTART 2.0. Co vlastně je ten .NET Core 2.0 a proč ho chcete používat? -->
<!-- np9:categoryId = 6 -->
<!-- x4w:category = Akce a události -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2017-10-10T00:36:52.127+02:00 -->
<!-- dcterms:dateAccepted = 2017-10-10T00:00:00+02:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20171010-asp-net-core-2-0-platforma-kterou-chcete-pouzivat.jpg -->

Budoucností platformy ASP.NET jsem se na tomto webu zabýval již několikrát. Uspořádali jsme na toto téma i několik akcí: loni v létě konferenci CORESTART, před měsícem Budoucnost ASP.NET a [2. a 3. 11. nás čeká CORESTART 2.0](https://www.corestart.cz/). Co vlastně je ten .NET Core 2.0 a proč ho chcete používat?

## Druhá verze 2.0

Platforma Microsoft .NET je stará zhruba patnáct let. Jsem už dost starý na to, abych si pamatoval její začátky. Verze 1.0 přinesla různé převratné koncepty, ideu managed code, nový jazyk C# a podobně. Moc k praktickému použití to nebylo, spíš takové technologické demo se slibným potenciálem, ale mnoha problémy. Verze 1.1 pak byl spíše “service pack”, opravy chyb a dodělání toho, co sice mělo být ve verzi 1.0, ale nějak se to nestihlo. Jedničkové verze .NETu se nikdy příliš neujaly, protože platforma byla příliš nová, příliš mladá, programátoři měli zajetý VBScript a klasické ASP stránky… Vše se změnilo, když Microsoft vydal Visual Studio 2005 a s ním .NET Framework 2.0. Ten stavěl na základech položených jedničkou a přinesl věci, které jste najednou chtěli používat, protože vám reálně usnadnily práci. Naprostá většina ASP.NET programátorů se k platformě dostala právě ve verzi 2.0 a později.

Dnes to vypadá, že se historie bude opakovat. ASP.NET Core 1.0 přinesl různé převratné koncepty, jako třeba open source přístup, multiplatformní kód, zcela novou architekturu runtime a další. A zažíváme deja vu: je to spíš technologické demo, než prakticky použitelný stack. Po krátké době přišel ASP.NET Core 1.1, což je opět spíše “service pack”, dodělávky toho, co verze 1.0 nestihla.

Nyní je k dispozici verze 2.0 a myslím si, že stejně jako u .NET Frameworku 2.0, i u ASP.NET Core je druhá verze něco, co doopravdy chcete používat.

## Cesta do hlubin .NET Core

Výše uvedené je v zásadě poselství, které jsme se vám snažili předat na předchozích akcích, na loňské CORESTART a samozřejmě na konferenci Budoucnost ASP.NET, kterou jsme dělali v říjnu. Doufáme, že základy již znáte a proto akce CORESTART 2.0, kterou jsme pro vás připravili na začátek listopadu, půjde víc do hloubky.

[Kompletní program](https://www.corestart.cz/#page-program) najdete na webu akce a dali jsme si záležet na to, aby nabídl ucelený pohled na platformu ASP.NET Core a aby se přednášky navzájem doplňovaly. Nová platforma je **open source** a Microsoft je v této chvíli na open source scéně jedním z nejaktivnějších subjektů. To je pro něj i jeho zákazníky nezvyklá role a tak trochu kulturní šok a bude to tématem úvodní přednášky prvního dne, kterou bude mít náš zahraniční host Matt Warren. Po něm bude Tomáš Jecha popisovat **Microsoft Extensions** v .NET Core, vestavěné nástroje pro logování, konfiguraci atd. ASP.NET Core je založen na **dependency injection** a obsahuje i vlastní IoC/DI kontejner, který je ovšem možná až příliš jednoduchý. Tomáš Herceg vám ukáže jak funguje, a také jak jej nahradit nějakým schopnějším. ASP.NET Core 2.0 přináší též **novou verzi MVC** s novinkami jako jsou tag helpers a view components, o které bude mluvit zase Tomáš Jecha.

## Razor Pages: MVVM Framework, na který jste čekali

Po přestávce přijde má chvíle: budu mluvit o Razor Pages. To je nástupce ASP.NET Web Pages, mého oblíbeného a neprávem opomíjeného toolkitu. Web Pages jsou skvělá technologie pro začátečníky a menší a jednoduché weby. Uznávám ovšem, že na větší projekty se opravdu nehodí.

Jejich nová inkarnace se jmenuje Razor Pages a ačkoliv si zachovává jednoduchost svého předchůdce, jedná se o plnohodnotný MVVM (Model-View-ViewModel) framework. To znamená, že se hodí i na větší projekty. Ačkoliv se jedná o platformu novou, je postavena na osvědčeném ASP.NET MVC, postrádá ovšem jeho přílišně striktní přístup.

Razor Pages jsou podle mého názoru výborný způsob vývoje aplikací a může to být právě to, proč budete chtít ASP.NET Core 2.0 používat.

## C# 7 a druhý den

Poslední přednáška prvního dne se bude týkat **C# verze 7 a verzí následujících**. Jirka Činčura vám ukáže aktuální verzi jazyka, který se za oněch patnáct let hodně proměnil. Z imperativního jazyka se stal miltiparadigmatický, velice silný nástroj a rozhodně se vyplatí ho znát a nezůstávat u starých verzí.

Druhý den zahájí náš druhý zahraniční host, Ben Adams. Jeho tématem bude **výkonnost ASP.NET Core 2.0**. Následuje druhá přednáška JIrky Činčury, a to o **Entity Frameworku Core 2.0**. Ač zůstává poněkud ve stínu ASP.NET Core, podobného “restartu” se dočkal i Entity Framework. I ten má svou “core” verzi a rozdílů mezi EF 6  a EF Core je - řečeno s Markem Twainem – tolik, že mít Entity Framework matku, nepoznala by ho. Po obědě se obvyklí podezřelí Herceg a Jecha vrátí na pódium s věcně souvisejícími tématy Docker a kontajnerizace a Deployment a distribuce.

## Raspberry Pi a zapomenuté knihovny

Jednou ze skvělých novinek .NET Core je možnost rozběhnout aplikaci na Linuxu. To nám, .NET programátorům, otevírá celé nové světy. Zejména pokud si uvedomíme, že je podporována i ARM platforma, takže naše aplikace mohou běžet na miniaturních počítačích typu Raspberry Pi, které stojí jenom několik stokorun. V předposledním slotu vám ukážu, **jak ASP.NET aplikaci rozjet na Linuxu a Raspberry Pi**.

Úplně poslední přednáška se bude týkat “zapomenutých knihoven”. ASP.NET Core neumí některé věci, které ty předchozí verze zvládaly, a nechává to na autorech knihoven třetích stran. S Tomášem Hercegem vám ukážeme, jak z prostředí ASP.NET Core pracovat s obrázky a jak odesílat e-maily.

#

**Podrobnější informace o konferenci najdete na **[**www.corestart.cz**](https://www.corestart.cz)**, tamtéž se také můžete zaregistrovat.**