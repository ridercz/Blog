<!-- dcterms:identifier = aspnetcz#5438 -->
<!-- dcterms:title = Projekt Atropa (7): Jak se bránit? -->
<!-- dcterms:abstract = V předchozích šesti dílech tohoto seriálu jsme si ukázali, jak za pomoci Raspberry Pi, Raspbian Linuxu a ASP.NET 5 rozjet honeypot. Závěrečný díl ukáže, jak se podobným útokům bránit. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Tipy, triky -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2015-09-06T20:24:31.683+02:00 -->
<!-- dcterms:dateAccepted = 2015-09-07T00:00:00+02:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20150907-projekt-atropa-7-jak-se-branit.jpg -->

V předchozích šesti dílech tohoto seriálu jsme si ukázali, jak za pomoci Raspberry Pi, Raspbian Linuxu a ASP.NET 5 rozjet honeypot. Tedy "zlé" Wi-Fi AP, ke kterému se kdokoliv může připojit, ale bude vyzván k zadání hesla do některé z populárních služeb. Heslo bude zaznamenáno, ale uživatel se nikam nepřipojí - zařízení ani nemusí mít přístup k Internetu.  Závěrečný díl ukáže, jak se podobným útokům bránit.

## Obrana z pozice provozovatele serveru

Tento útok je zákeřný tím, že útočí na maso, nikoliv na křemík. Snažíme se zmást uživatele, ne počítač. A z toho vyplývá, že v podstatě jediný, kdo se může bránit, je uživatel, nikoliv provozovatel cílové služby (tedy té, jejíž heslo se snažíme vylákat). Po čistě technologické stránce provozovatel služby, jejíž heslo se snažíme získat, nemůže udělat vůbec nic, aby nám v tom zabránil. Jedinou obranou je zavedení nějaké jiné formy autentizace, než je jméno a heslo. Např. klientské certifikáty přes HTTPS. Ale to je u služeb, na které se tímto stylem dá útočit, v podstatě nemožné.

Mohou zde pomoci jednorázová hesla, ale jenom omezeně. V první řadě, program není navržen na to, aby se na jednorázová hesla psal, ale je možné jej takto snadno upravit. Zneužitelnost takto získaného hesla je však dosti omezená, neboť heslo platí typicky jenom desítky sekund až jednotky minut. Honeypot tedy nebude možné použít stylem "nasadit, zapomenout a pak si přijít pro úlovky". Pro zneužití včetně jednorázových hesel by musel být vytěžován průběžně. Takže jednorázová hesla je možné považovat za docela dobrou obranu.

Jedinou skutečně spolehlivou obranou je vzdělat uživatele, aby prostě nezadávali heslo jinde, než na té správné doméně a aby si zkontrolovali, že na něj přistupují přes HTTPS, nejlépe podpořené HSTS. Třeba tak, jak to dělá slovenský Azet.sk:

[![atropa-obrana-azet-1](https://www.cdn.altairis.cz/Blog/2015/20150906-atropa-obrana-azet-1_thumb.png "atropa-obrana-azet-1")](https://www.cdn.altairis.cz/Blog/2015/20150906-atropa-obrana-azet-1_2.png)

To ovšem může být trochu komplikované. Za prvé, vizuální podoba notifikací se v jednotlivých verzích prohlížečů mění a jak vidíte, třeba s Microsoft Edge si Azet.sk ještě úplně neporadil. A za druhé, když to uživatele naučíte, musíte to dodržet. Což se Azet.sk nedaří už vůbec. Dá se předpokládat, že spousta uživatelů bude zadávat jmého a heslo na homepage, která je ovšem dostupná výhradně přes HTTP (pokud se připojíte na HTTPS, budete přesměrováni na nezabezpečenou verzi):

[![atropa-obrana-azet-2](https://www.cdn.altairis.cz/Blog/2015/20150906-atropa-obrana-azet-2_thumb.png "atropa-obrana-azet-2")](https://www.cdn.altairis.cz/Blog/2015/20150906-atropa-obrana-azet-2_2.png)

Český Seznam.cz na to jde zase poněkud opačně. Na homepage (konečně, hurá) již nějakou dobu zelený certifikát, HTTP a HSTS má, ovšem přihlašovací formulář odesílá na nepříliš důvěryhodně vypadající doménu szn.cz:

[![atropa-obrana-seznam-1](https://www.cdn.altairis.cz/Blog/2015/20150906-atropa-obrana-seznam-1_thumb.png "atropa-obrana-seznam-1")](https://www.cdn.altairis.cz/Blog/2015/20150906-atropa-obrana-seznam-1_2.png)

Na tutéž doménu budete přesměrováni též, pokud se pokusíte přistoupit třeba přímo k e-mailové službě na doméně email.seznam.cz:

[![atropa-obrana-seznam-2](https://www.cdn.altairis.cz/Blog/2015/20150906-atropa-obrana-seznam-2_thumb.png "atropa-obrana-seznam-2")](https://www.cdn.altairis.cz/Blog/2015/20150906-atropa-obrana-seznam-2_2.png)

Všechny uvedené adresy jsou sice zabezpečené přes HTTPS, ale jenom [www.seznam.cz](http://www.seznam.cz) má EV certifikát, přihlašovací server nikoliv a chybí v něm ta známá značka "seznam.cz".

## Jak se bránit z pozice uživatele?

Základní pravidlo je, zadávat jméno a heslo ke službě pouze v případě, že jste si jisti, že se díváte na web dané služby. Tedy vidíte tu správnou doménu druhé úrovně a zároveň komunikace běží přes HTTPS. Pokud se někde používá přihlašování pomocí externích identity providerů, tak se dnes užívá výhradně protokolů jako je OAuth, které zajistí, že heslo zadáváte přímo u cílové služby a ne na stránkách nějaké třetí strany.

Je pravděpodobné, že útoků na uživatele bude přibývat, protože je to prostě jednodušší a snazší. Obrana je, obecně, jenom jedna. Jak říkal Mad-Eye Moody, "constant vigilance".