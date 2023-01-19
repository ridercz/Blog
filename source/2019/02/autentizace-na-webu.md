<!-- dcterms:title = Autentizace na webu: Jak jsme došli k cookies? -->
<!-- dcterms:abstract = Na svém ASK.FM jsem dostal otázku, proč používáme pro autentizaci cookies místo vestavěných mechanismů v HTTP. Jednoduchá otázka a jednoduchá odpověď: protože tam žádné použitelné nejsou. Nicméně tohle téma si zaslouží hlubší úvahu. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20190225-autentizace-na-webu.png -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20190225-autentizace-na-webu.jpg -->
<!-- x4w:coverCredits = Mário Moreira via FREEIMAGES.COM -->
<!-- x4w:category = Bezpečnost -->
<!-- dcterms:date = 2019-02-25 -->

Na svém [ASK.FM](https://ask.fm/ridercz) jsem dostal otázku, proč používáme pro autentizaci cookies místo vestavěných mechanismů v HTTP. Jednoduchá otázka a jednoduchá odpověď: protože tam žádné použitelné nejsou. Nicméně tohle téma si zaslouží hlubší úvahu.

## Historický kontext

Komunikační protokol HTTP (HyperText Transfer Protocol vznikl na přelomu 80. a 90. let minulého století). O této době s oblibou říkám, že v ní počítače byly dřevěné a šlapací (což je jenom mírná nadsázka) a že si tehdy lidé navzájem věřili. To druhé je bolestně zřejmé z úrovně zabezpečení tehdy vzniknuvších protokolů a standardů, se kterými se začasté potýkáme dodnes.

První verze protokolu [HTTP/0.9 byla neformálně publikována v roce 1991](https://www.w3.org/Protocols/HTTP/AsImplemented.html) a jak bylo tehdy zvykem, je zcela prosta jakéhokoliv zabezpečení a nenabízí žádnou možnost autentizace.

První "oficiální" verze [HTTP/1.0 byla publikována jako RFC1945](https://tools.ietf.org/html/rfc1945) v květnu 1996. Nabízí i takzvanou [Basic autentizaci](https://tools.ietf.org/html/rfc1945#section-11), která umožňuje autentizaci uživatelů vůči serveru. Bohužel tím způsobem, že pošlou s každým autentizovaným requestem své uživatelské jméno a heslo v otevřeném tvaru. Že jde o... řekněme suboptimální řešení bylo jasné i autorům standardu, neboť o něm píší:

> The basic authentication scheme is a non-secure method of filtering unauthorized access to resources on an HTTP server. It is based on the assumption that the connection between the client and the server can be regarded as a trusted carrier. As this is not generally true on an open network, the basic authentication scheme should be used accordingly. In spite of this, clients should implement the scheme in order to communicate with servers that use it.
>
> ...
>
> HTTP/1.0 does not prevent additional authentication schemes and encryption mechanisms from being employed to increase security.

Dalšího autentizačního schématu _Digest_ se HTTP dočkal ve verzi 1.1 a poprvé byl popsán v [RFC2617](https://tools.ietf.org/html/rfc2617). A pravdu povědíc, moc si tím nepomohl, protože se jednalo o mrtvě narozené dítě. Pro své četné nevýhody se tento mechanismus nikdy masově neujal.

## Proč nechceme Basic autentizaci

Hlavní důvod byl zmíněn již v úvodu. Basic autentizace znamená, že s každým HTTP requestem jsou po síti přenášeny autentizační údaje v otevřeném tvaru. Jméno a heslo jsou jenom kódovány pomocí Base64, což neznamená utajení jejich obsahu, je to jenom pomůcka pro přenos osmibitových dat v sedmibitovém světě.

Jakési míry bezpečnosti lze dosáhnout při použití HTTPS protokolu, ale tak častý přenos hesla obecně nevidíme rádi.

Přesto se s Basic autentizací stále v některých případech setkáváme. Zejména:

* **U jednoduchých zařízení** jako jsou IP kamery a domácí routery. Je jednoduchá na implmentaci a autoři (zpravidla s neoprávněným optimismem) předpokládají, že tato zařízení budou používána v bezpečné síti.
* **Při volání některých API**, kde klientem není člověk, ale jiný počítač, přičemž autentizační hlavička často obsahuje nějaké customizované informace. Tento způsob přihlášení používá například [API služby Fakturoid](https://fakturoid.docs.apiary.io/#introduction/overeni).

Pro obecné přihlašování na webu se ale nehodí.

## Proč nechceme Digest autentizaci

Nevýhody Basic autentizace měla vyřešit metoda Digest. Ta funguje tak, že server pošle klientovi náhodně vygenerovanou _challenge_, klient vezme heslo, spojí ho s _challenge_ a vygeneruje hash, který pošle zpět serveru. Server udělá totéž a tak dokáže uživatele ověřit, aniž by muselo heslo v otevřeném tvaru jít po síti.

Myšlenka to byla dobrá, což o to, ale v praxi nebyla moc úspěšná. V první řadě, aby bylo lze užít tento mechanismus autentizace, musí mít server k dispozici hesla uživatelů v otevřeném tvaru. Což není dobrý nápad, uchovávat hesla v čitelném nebo šifrovaném tvaru.

Druhý důvod je, že ďábel se skrývá v detailech. Naimplementovat Digest autentizaci (zejména na straně serveru) není jednoduché. A naimplementovat ji _správně_, aby byla challenge generovaná tak, aby ji nebylo možné podvrhnout, aby obsahovala dostatečné množství entropie ale zároveň nespotřebovávala zbytečně moc entropie na serveru dostupné, je ještě mnohem obtížnější.

Z tohoto důvodu se Digest autentizace nikdy nedočkala velkého rozšíření a nelze ji doporučit.

## Co další autentizační schémata?

Ačkoliv HTTP obecně podporuje další autentizační schémata, žádná obecně použitelná a nasaditelná nevznikla, nejsou podporována na serverech ani na klientech. Existují různé alternativy pro intranetové sítě (například NTLM autentizace), ale ty se nedají použít na Internetu a obecně je dneska už ani pro ten intranet nepokládáme za vhodné.

## HTTPS a klientské certifikáty

Jedinou teoreticky použitelnou alternativu představuje přihlašování klientskými certifikáty přes HTTPS. Jejich použití je z technického hlediska velmi dobrý nápad. Správně naimplementované přihlašování klientskými certifikáty představuje nejvyšší možnou úroveň autentizace, kterou z hlediska bezpečnosti máme.

Problém je, že je velmi náročné na údržbu. Je nutné vybudovat nebo mít k dispozici PKI, vydávat uživatelům certifikáty, řešit jejich životní cyklus... Prostě je s tím příliš mnoho práce a ceremonií, než aby šlo o metodu obecně použitelnou pro každého. Proto se používá jenom výjimečně, často pro autentizaci ve vnitrofiremních aplikacích a také pro komunikaci přes různá API, kdy klientem není browser, ale specializovaná aplikace.

## Takže nám zbyly cookies

Odvrhnuvše pro nevhodnost "systémové" autentizační metody v HTTP, nezbývá nám, než si autentizaci nějak zbastlit sami. Tedy, chraň vás ruka Páně to bastlit sami, použijte ASP.NET Identity (průpovídku, že _ďábel se skrývá v detailech_ jsem v tomto článku už jednou použil a pořád platí).

V současnosti používané autentizační metody pracují jak, že webová aplikace, jsa uspokojena autentizačním úkonem uživatele, vystaví tomuto _autentizační token_, což je nějaký identifikátor s dočasnou platnostní (do jehož obsahu a implementačních detailů v této chvíli nehodlám zabrušovat). Uživatel se v následných požadavcích prezentuje tímto tokenem.

Kde ale tento token uchovávat? No kde jinde, než v cookies, které představují pro server možnost, jak si na klienta uložit malý kousek dat, která klient pošle s každým requestem. Existují sice i jiná, poněkud exotická řešení (příkladmo ukládání tokenu do query stringu nebo obecně do URL), ale faktickým standardem je dnes použití cookies.

A teď už víte proč.