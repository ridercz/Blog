<!-- dcterms:identifier = aspnetcz#361 -->
<!-- dcterms:title = Nainstalujte si mimořádnou bezpečnostní aktualizaci pro ASP.NET -->
<!-- dcterms:abstract = Microsoft zhruba před hodinou uveřejnil mimořádnou bezpečnostní aktualizaci pro ASP.NET, která zabraňuje možnému DoS útoku. -->
<!-- np9:categoryId = 2 -->
<!-- x4w:category = Bezpečnost -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2011-12-29T21:14:30.587+01:00 -->
<!-- dcterms:dateAccepted = 2011-12-29T21:14:33+01:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20111229-nainstalujte-si-mimoradnou-bezpecnostni-aktualizaci-pro-asp-net.png -->

Microsoft zhruba před hodinou uveřejnil mimořádnou bezpečnostní aktualizaci pro ASP.NET, která zabraňuje možnému DoS útoku. V čem je problém? Pokusím se jej vysvětlit velmi zjednodušeně, pro detailní vysvětlení doporučuji odkazy na konci článku.

Při vývoj software se velmi často používají různé typy kolekcí klíč – hodnota. V různých programovacích jazycích se nazývají různě, ale základem je vždy nějaká forma hashovací tabulky, v níž se ukládají klíče a podle které se vyhledává. 

Pokud vezmeme například klasickou C# kolekci se stringovým klíčem, nedochází při prohledávání z výkonových důvodů ke skutečnému porovnávání řetězců. Místo toho se spočítá hash, což je 32-bitové číslo, a dále se pracuje jenom s ním, což je výpočetně efektivnější. Každý objekt má metodu [GetHashCode](http://msdn.microsoft.com/en-us/library/system.object.gethashcode.aspx), která tento hash vypočítá. 

Hash v tomto ohledu nemá nic společného s algoritmy jako je MD5, SHA-1, SHA-256 a podobně, algoritmus je mnohem jednodušší a náchylnější ke konfliktům. Slouží ke zjednodušení interních procesů, [nikoliv k nějaké formě zabezpečení](http://blogs.msdn.com/b/ericlippert/archive/2005/10/24/482447.aspx) atd. Pro běžného programátora je tento mechanismus v podstatě neviditelný, hodnoty jsou pro něj nepoužitelné – [jsou závislé na platformě a mohou se kdykoliv změnit](http://blogs.msdn.com/b/ericlippert/archive/2011/07/15/the-curious-property-revealed.aspx). Pro porovnání ve většině případů tyto hashe stačí. Teprve v případě konfliktu se používají náročnější metody. Pravděpodobnost konfliktu je sice mnohonásobně větší, než v případě kryptografických hashovacích algoritmů, ale pro běžné použití postačuje. Nicméně, pokud by se kolekce naplnila klíči, které jsou speciálně navržené tak, aby tam ke konfliktům docházelo (a bude jich hodně), práce se dramaticky zpomalí, což může vést k Denial of Service útoku třeba u form fieldů při HTTP requestech. 

Tento problém se netýká jenom ASP.NET, právě naopak – stejně jako v případě "[padding oracle](http://www.aspnet.cz/articles/303-padding-oracle-chyba-v-asp-net-o-co-vlastne-slo)" problému se jedná o obecný návrhový problém, který mají prakticky všechny webové frameworky a řada dalšího software. Praktický útok byl otestován kromě ASP.NET i na PHP 5, Javu a V8 (JavaScriptový engine od Google) a za určitých okolností jsou napadnutelné i PHP 4, Python a Ruby.

*   Oficiální security bulletin: [Microsoft Security Bulletin MS11-100 – Critical](http://technet.microsoft.com/en-us/security/bulletin/ms11-100)
*   Článek o dostupné aktualizaci: [Scott Guthrie: ASP.NET Security Update Shipping Thursday, Dec 29th](http://weblogs.asp.net/scottgu/archive/2011/12/28/asp-net-security-update-shipping-thursday-dec-29th.aspx)
*   Původní článek popisující teoretické pozadí útoků: [Scott A. Crosby, Dan S. Wallach: Denial of Service via Algorithmic Complexity Attacks](http://www.cs.rice.edu/~scrosby/hash/CrosbyWallach_UsenixSec2003.pdf)
*   Demonstrace útoků na současné platformy: [n.runs-SA-2011.004 - web programming languages and platforms - DoS through hash table](http://www.nruns.com/_downloads/advisory28122011.pdf)

Dnes v 19:00 Microsoft uvolnil mimořádnou bezpečnostní aktualizaci (out-of-band security update), která tento problém řeší. Záplata je k dispozici na Windows Update a stačí tedy dát vyhledat dostupné aktualizace a budou nabídnuty patřičné balíčky (podle verzí .NET Frameworku):

[![Screenshot](https://www.cdn.altairis.cz/Blog/2011/20111229-oobsecurityupdate_thumb.png "Windows Update: záplaty pro .NET 3.5 a 4.0 na Windows 2008 R2")](https://www.cdn.altairis.cz/Blog/2011/20111229-oobsecurityupdate_2.png)

Problém není natolik kritický, aby bylo nutné záplatu bezpodmínečně instalovat teď hned a přijímat dramatická opatření. Není známo, že by v současné době takové útoky probíhaly a výsledkem může být jenom DoS po dobu trvání útoku, nedojde tedy k vyzrazení citlivých dat atd. Nicméně útok je principiálně velmi snadný a je jenom otázkou času, kdy někdo napíše nástroj použitelný i pro script kiddies, takže nedoporučuji s instalací ani příliš otálet.