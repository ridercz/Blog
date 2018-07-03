<!-- dcterms:identifier = aspnetcz#191 -->
<!-- dcterms:title = Stavové HTTP: Cookies -->
<!-- dcterms:abstract = Web byl stvořen jako bezstavový a struktura HTTP a HTML tomu odpovídá. Pokud chceme tuto bezstavovost překlenout, existuje několik technik, které nám umožní toto omezení obejít. Nyní se podrobněji podíváme na první z nich: cookies. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Tipy, triky -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- np9:serialId = 4 -->
<!-- x4w:serial = Stavové HTTP -->
<!-- dcterms:created = 2008-03-21T08:00:29+01:00 -->
<!-- dcterms:dateAccepted = 2008-03-21T08:00:29+01:00 -->

V [minulém díle tohoto seriálu](/Articles/190-stavove-http-jak-funguji-cookies-session-a-viewstate-a-proc-je-nepouzivat.aspx) jsme si řekli, že HTTP je protokol bezstavový a že jednou z technik, jak tuto bezstavovost obejít, je použití cookies.

Cookies jsou jediná technika v HTTP, která je přímo navržená k tomu, abyste si mohli něco na klienta "uložit" a při dalším požadavku zase "vyzvednout". Cookies fungují tak, že server pošle jako jednu z HTTP hlaviček odpovědi textový řetězec, který si prohlížeč uloží na disk a při dalším požadavku ho ve formě HTTP hlavičky pošle zpátky.

To byl velmi zjednodušený náhled na celou problematiku, podrobnější informace o použití cookies v ASP.NET najdete v článku **[Sušenky.NET](/Articles/8-susenky-net.aspx)** na tomto serveru.

Do cookies můžete uložit pouze omezené množství dat. Zabrání vám v tom jednak omezení na straně prohlížeče (maximální velikost cookie se obvykle počítá v jednotkách kB, přesné číslo si nepamatuji) a druhak by vám v tom měl zabránit i zdravý rozum. Obsah cookie se přenáší s úplně každým požadavkem na váš server, a to i tehdy, když ho server vůbec nepotřebuje a nevyužije. Například při požadavcích na obrázky a další statická data. Což zvyšuje objem přenášených dat, za která obvykle tou či onou formou platíte.

Cookies jsou v zásadě dvojího druhu: permanentní a per-session. 

## Permanentní cookies

Permanentní cookies obsahují čas expirace (nastavený serverem, tedy vaší aplikací) a jsou ukládány na disk. Přežijí tedy zavření okna prohlížeče, restart počítače atd. Budou se posílat s každým požadavkem na server, dokud nevyprší a nebo dokud je uživatel ručně nesmaže.

Pokud napíšete k nějakému článku na tomto serveru komentář, server si do cookie uloží údaje, které jste vyplnili do formuláře - jméno, e-mail, adresu webové stránky... Můžete si to ověřit, podívejte se na soubor, který je uložen ve vašem uživatelském profilu a jmenuje se nějak jako *vášlogin@www.aspnet[1].txt* (v mém případě - Windows Vista - je uložen v *C:\Users\Altair\AppData\Roaming\Microsoft\Windows\Cookies*).

Když si tento soubor otevřete, tak tam shora uvedené údaje najdete, můžete si je přečíst (v případě tohoto serveru je to poněkud komplikované, protože jsou Base64 enkódovaná kvůli diakritice) a můžete je též změnit, případně celý soubor smazat.

V tom spočívá hlavní slabost cookies: neměli byste do nich ukládat citlivé údaje a nemůžete se spolehnout na to, že je dostanete v pořádku a nepozměněná.

## Session cookies

Per-session cookies nemají určený čas expirace a prohlížeč si je drží v paměti. V okamžiku zavření okna se nenávratně ztratí. Konkrétní obsah pojmu "session" závisí na použitém prohlížeči. Například Internet Explorer funguje tak, že si údaje pamatuje do zavření okna. Pokud si v téže instanci prohlížeče otevřete nové okno (Ctrl+N), bude mít stejnou sadu per-session cookies, jako to předešlé. Pokud uživatel ale otevře novou instanci IE (poklepe třeba na ikonku na ploše), bude mít tato instance samostatnou sadu per-session cookies.

Druhý jmenovaný typ cookies je držen pouze v paměti, jeho neoprávněná změna je tedy o něco málo komplikovanější, není to tak jednoduché, jako přepsat TXT soubor (ne však nemožné). Na druhou stranu, jeho chování může být poněkud matoucí.

## Výhody a nevýhody

### Proč cookies používat

*   Je to standardizovaná technologie, kterou dnes podporují prakticky všichni klienti, včetně mobilních zařízení a podobně. 
*   Použití cookies minimálně zatěžuje server. 
*   Jsou nezávislé na platformě, prohlížeči, jednu cookie můžete přečíst z jakékoliv serverové technologie, pokud chcete.

### Proč cookies nepoužívat

*   Někteří uživatelé je mohou mít vypnuté. Pro vypínání first-hand cookies sice není žádný zásadní důvod a vypnout je je poměrně komplikované, ale přesto to někdo může udělat. 
*   Do cookie můžete uložit pouze celkem malé množství dat. 
*   Cookies se posílají s každým požadavkem, včetně požřadavků na statické stránky atd. V případě navštěvovaných webů a objemnějších cookies to může znamenat slušné zvýšení obejmu přenášených dat. 
*   Nemůžete se spolehnout na to, že se vám hodnota uložená v cookie vrátí v pořádku a nepoškozená. Uživatel nebo útočník ji může přečíst a modifikovat, pokud ji nějakým způsobem nezabezpečíte.

### Doporučení

*   Pokud máte malé množství dat, použijte cookie - je to cesta nejmenšího odporu. 
*   Pokud váš web cookie vyžaduje, upozorněte na to uživatele. A nebo ještě lépe, vyzkoušejte si to, a pokud má cookie zakázané, zobrazte mu upozornění. 
*   U navštěvovanějších webů si pohrajte s nastavením parametrů *Path* a *Domain*. Zvažte použití samostatné domény pro statický obsah (tak to dělá většina velkých internetových služeb typu Passport, eBay nebo Google).

*Zítra vyjde další díl tohoto seriálu, který se bude podrobněji věnovat technologii Sessions.*