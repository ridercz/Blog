<!-- dcterms:identifier = aspnetcz#135 -->
<!-- dcterms:title = Novinky a budoucnost webu akce.altairis.cz -->
<!-- dcterms:abstract = Když jsem před zhruba půl rokem spouštěl web http://akce.altairis.cz/, byla moje představa o jeho smyslu a funkci jednoduchá. Chtěl jsem napsat systém, který by všem dal vědět, když se pořádaná akce, přesune nebo zruší. Počítal jsem s pár akcemi do roka. Jak už to bývá, trochu se to zvrhlo a shora uvedený web je prakticky největším kalendářem vývojářských akcí pro .NET. Rád bych vás seznámil s novinkami, které jsem na tomto webu spustil, a nebo které se plánují. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Tipy, triky -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2007-01-25T03:55:07.5+01:00 -->
<!-- dcterms:dateAccepted = 2007-01-25T03:55:07.5+01:00 -->

Když jsem před zhruba půl rokem spouštěl web [http://akce.altairis.cz/](http://akce.altairis.cz/), byla moje představa o jeho smyslu a funkci jednoduchá. Chtěl jsem napsat systém, který by všem dal vědět, když se pořádaná akce, přesune nebo zruší. Počítal jsem s pár akcemi do roka. Jak už to bývá, trochu se to zvrhlo a shora uvedený web je prakticky největším kalendářem vývojářských akcí pro .NET. Rád bych vás seznámil s novinkami, které jsem na tomto webu spustil, a nebo které se plánují.

## Co je nového

Na základě několika vašich žádostí jsem přidal možnost zobrazit si seznam všech akcí přímo v Outlooku. Dosud jste si mohli u každé akce klepnutím na ikonku "vložit do Outlooku" vložit do kalendáře informaci o termínu jejího konání. Jak se ale počet akcí rozrůstá, je těžké si v nich udržet přehled.

Novinkou v Outlooku 2007 je možnost zobrazit si kalendář publikovaný na webu. Ten se pak ukáže mezi ostatními kalendáři a můžete přehledně sledovat různé zdroje při plánování času.

 [ ![Screenshot](/Files/20070125_webcal_lq.png) ](/Files/20070125_webcal_hq.png) 

Pokud používáte Outlook 2007, klepněte v seznamu akcí na odkaz *[zobrazit v Outlooku 2007](webcal://akce.altairis.cz/WebServices/GetICS.ashx)* a tím se přihlásíte k automatické synchronizaci tohoto kalendáře. Bohužel mi není známo, jak by se nějakého podobného efektu dalo dosáhnout v předchozích verzích Outlooku.

Dále pak jsem do testovacího provozu spustil automatické mailovátko, které vám ráno před akcí připomene, že jste se na ni přihlásit ráčili a případně že si máte vytiskout pozvánku.

## Co se chystá

V první řadě geografická expanze a diverzifikace. Zhruba od poloviny roku bychom chtěli podobné akce jako v Praze pořádat i v Brně. Momentálně probíhá zajišťování prostor a obecně režimů spolupráce, protože v Brně bohužel Microsoft nemá pobočku, kterou bychom mohli okupovat.

S tím souvisí také úprava systému, ve kterém si budete moci zvolit, akce v jakém regionu si přejete zobrazovat a případně posílat pozvánky e-mailem. Jsem si vědom toho, že Pražáky asi pozvánka na akci v Hradci dvakrát nezaujme a vice versa.

## Záznamy budou a nebudou

Velice populární jsou záznamy z přednášek, které publikujeme na webu[videoarchiv.altairis.cz](http://videoarchiv.altairis.cz/). Nejčastější dotaz je, zda jsou a budou pořizovány ze stávajících a budoucích přednášek. Moje standardní odpověď je, že se je snažím pořizovat ze svých vlastních přednášek, ale nejsem schopen k tomu přimět ostatní. A ani v mém případě to není stoprocentní.

Problém spočívá především v tom, že softwarové nahrávání zvuku a obrazu je dost hardwarově náročné. Je náročné především na rychlost disku, což je obecně u notebooků problém. A programy jako SQL Server nebo Visual Studio nejsou také právě úsporné. Ve výsledku záznam způsobí, že můj notebook (Centrino Duo 1.8 GHz, 1 GB RAM) se plazí na hranici použitelnosti.

Nahrávání pomocí HW zařízení je komplikované, protože minimální rozumné rozlišení pro záznam je 1024x768 bodů. Většina cenově dostupného zařízení pro zpracování videa ovšem běží v PALu, což je rozlišení 720x576. Při převzorkování se detaily (jako třeba zdrojový kód) stanou téměř nečitelnými. Záznam pomocí videokamery je v tomto směru ještě horší.

Ve spolupráci s [Audiovizuálním centrem Silicon Hill](http://avc.siliconhill.cz/). se tento problém snažíme řešit a technologie kombinovat, ale bohužel to není triviální.

## O webu akce.altairis.cz

Mohlo by vás zajímat pár informací o webu akce.altairis.cz jako takovém. Momentálně je na něm registrováno 686 uživatelů, 60 akcí a 1834 registrovaných účastníků na akcích (nepočítaje v to situace, kdy náš systém nezajišťuje registrační služby a akce kde není registrace potřebná). Akce se konají na dvanácti místech a pořádá je celkem devět subjektů.

Tento web používám také pro testování nových technologií. Jako první web v ČR a jeden z prvních na světě jsme na něm implementovali pro přihlašování technologii Identity Metasystem / InfoCard / CardSpace. V den uvedení jsem na této aplikaci také zkoušel finální verzi ASP.NET AJAX Extensions.

Technologie, které na webu akce.altairis.cz používáme:

*   Microsoft ASP.NET 2.0, Microsoft IIS 6.0, Microsoft SQL Server 2005.
*   Microsoft Virtual Server 2005 R2.
*   Microsoft .NET Framework 3.0 (Windows CardSpace).
*   Microsoft AJAX Extensions + Futures + Control Toolkit (především v administraci).
*   RSS (s několika standardními i vlastními rozšířeními pro komunikaci s dalšími aplikacemi).
*   Řadu vlastních univerzálních HTTP modulů pro URL rewriting, odchytávání chyb, přepínání mezi šifrovanou a nešifrovanou komunikací a další.
*   Microsoft VirtualEarth (interaktivní mapy míst, kde se akce konají).
*   Vlastní membership, role a profile providery.
*   CSS Friendly Control Adapters a vlastní adaptéry pro renderování rozumného výstupního HTML.
*   Unikátní systém sledování účasti pomocí čárových kódů generovaných v .NETu. 

Ten seznam je dlouhý a myslím si, že ne nezajímavý. Vzpomínám si, že na TechEdu byla jedna z nejzajímavějších akcí "*How we built the TechEd web site*". Myslím si, že je vždy dobré vědět, jak vzniká reálný systém, s jakými problémy se autoři potýkali a jak je vyřešili. Kromě toho se z feedbacku mohou poučit i sami autoři. Měli byste zájem o "*how we built*" session v případě webu akce.altairis.cz? Pokud ano, přihlašte se v komentářích.

## Poděkování

Této příležitosti bych chtěl využít k poděkování lidem, kteří se o vznik a rozvoj tohoto projektu zasloužili. Zejména pak (v nahodilém pořadí):

*   *Štěpánovi Bechynskému* z Microsoftu za poskytnutí prostor, technického zázemí, propagaci, cen do soutěží a všeobecnou podporu.
*   *Počítačové škole Gopas*, která sponzoruje občerstvení pro účastníky.
*   Všem přednášejícím, zejména *Michalovi Bláhovi*, *Honzovi Šedovi* a *Tomáši Petříčkovi*.
*   A především své životní lásce a partnerce, *Michaele Myshi Judasové.* Za obětavou péči o smečku našich serverů a hlavně za nebetyčnou trpělivost, kterou s mými šílenými a zpravidla též dost prodělečnými projekty má.