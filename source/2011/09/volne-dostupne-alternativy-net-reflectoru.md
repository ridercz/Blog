<!-- dcterms:identifier = aspnetcz#333 -->
<!-- dcterms:title = Volně dostupné alternativy .NET Reflectoru -->
<!-- dcterms:abstract = V životě každého programátora dříve či později nastane situace, kdy musí sáhnout po dekompilačním nástroji, který z binární knihovny učiní čitelný kód ve vyšším programovacím jazyce. Po poměrně dlouhou dobu byla volba jasná – .NET Reflector. Nicméně firma Red Gate, která Reflector před časem koupila, už bezplatnou verzi Reflector nevyvíjí a neumožňuje používat a tedy nastal čas podívat se po alternativách. -->
<!-- np9:categoryId = 7 -->
<!-- x4w:category = Software -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2011-09-12T01:50:15.317+02:00 -->
<!-- dcterms:dateAccepted = 2011-09-12T01:50:16+02:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20110912-volne-dostupne-alternativy-net-reflectoru.jpg -->

V životě každého programátora dříve či později nastane situace, kdy musí sáhnout po dekompilačním nástroji, který z binární knihovny učiní čitelný kód ve vyšším programovacím jazyce. Důvody k tomu mohou být různé, i když se zveřejněním zdrojového kódu .NET Frameworku jich část ubyla. Často je ale třeba zjistit, jak věci fungují, když dokumentace chybí a nebo se prostě jenom inspirovat náhledem na to, *jak to sakra udělali*.

Po poměrně dlouhou dobu byla volba nástroje pro dekompilaci jasná – .NET Reflector, který před časem jako volně dostupný nástroj napsal a delší dobu vyvíjel Lutz Roeder. Nicméně tento nástroj před časem koupila firma Red Gate a poté, co se [nesplnila její očekávání stran synergických efektů](http://www.reflector.net/2011/04/why-we-reversed-some-of-our-reflector-decision/) v podstatě zrušila jeho bezplatnou verzi. $ 35 není nijak závratná částka, ale pokud dekompilaci používáte jenom občas a nestojíte o hromadu pokročilých funkcí, mohou vás zajímat alternativy. 

Našel jsem tři bezplatné a s radostí se o ně podělím. Všechny jsou postavené okolo open source knihovny [Mono.Cecil](http://www.mono-project.com/Cecil)

## DevExtras.CodeReflect

[http://www.devextras.com/decompiler/](http://www.devextras.com/decompiler/ "http://www.devextras.com/decompiler/")

[![Screenshot CodeReflect](http://www.aspnet.cz/Files/20110912-codereflect_thumb_1.png "Screenshot CodeReflect")](http://www.aspnet.cz/Files/20110912-codereflect_4.png)

Velice jednoduchý nástroj, rozhraním i funkcemi připomíná první verze .NET Reflectoru. Výbava je skutečně jenom velmi základní, umí načíst vybrané assemblies a postupně je procházet. Stažení je zdarma a bezproblémové, aplikaci není nutné instalovat, stačí rozbalit a spustit. Zásadně mi vadí absence vyhledávání a nemožnost dekompilovat a zobrazit celou třídu najednou – buďto to nástroj neumí a nebo nevím, jak ho k tomu donutit. Také syntax highlighting není nijak skvělý.

Aplikaci vyvíjí komerční firma, která mimo jiné vyvíjí obfuskátor, tedy nástroj, který má naopak dekompilaci zabraňovat.

## ILSpy

[http://wiki.sharpdevelop.net/ilspy.ashx](http://wiki.sharpdevelop.net/ilspy.ashx "http://wiki.sharpdevelop.net/ilspy.ashx")

[![Screenshot ILSpy](http://www.aspnet.cz/Files/20110912-ilspy_thumb.png "Screenshot ILSpy")](http://www.aspnet.cz/Files/20110912-ilspy_2.png)

Další jednoduchý nástroj postavený také na knihovně Mono Cecil. Vzhledově se od předchozího téměř neliší. Pokud se funkcí týče, obsahuje jich pár navíc, z nichž asi nejpodstatnější bude možnost vyhledávání v kódu. Ani v ILSpy jsem nenašel možnost pohodlně rozbalit dekompilovaný kód celé třídy, ale zase má ze všech posuzovaných asi nejlepší syntax highlighting.

ILSpy je open source, další z děťátek projektu [SharpDevelop](http://www.sharpdevelop.net/).

## Telerik JustDecompile

[http://www.telerik.com/products/decompiler.aspx](http://www.telerik.com/products/decompiler.aspx "http://www.telerik.com/products/decompiler.aspx")

[![Screenshot JustDecompile](http://www.aspnet.cz/Files/20110912-justdecompile_thumb.png "Screenshot JustDecompile")](http://www.aspnet.cz/Files/20110912-justdecompile_2.png)

Firma Telerik je vývojářům známa nejvíce jako výrobce komponent pro ASP.NET Web Forms, MVC, Windows Phone… Poslední dobou se snaží proniknout i do oblasti pomocných vývojových nástrojů programy jako JustMock a JustCode. Nově nabízí též program JustDecompile, který se mi i přes poněkud svébytné uživatelské rozhraní ze třech posuzovaných programů líbí nejvíc.

JustDecompile umí všechno, co předchozí programy (i když syntax highlighting by mohl být lepší). Líbí se mi na něm zejména možnost ukládat a načítat sady knihoven, se kterým pracujete. Užitečná je též možnost vytvořit z assembly zpět projekt pro Visual Studio (C#). Nečekejte od ní zázraky, ale rozhodně se jedná o užitečnou schopnost, která se hodí zejména ve chvíli, kdy potřebujete s dekompilovaným kódem dál pracovat.

Existuje pár dalších nástrojů, ale všechny, které jsem našel, jsou buď placené a nebo ve velmi raných fázích vývoje. Pro tento okamžik jsem si pro své dekompilační potřeby vybral JustDecompile od Teleriku, ale uvidíme, co přinese budoucnost.