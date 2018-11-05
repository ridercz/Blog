<!-- dcterms:title = Zázraky se dějí -->
<!-- dcterms:abstract = Žijeme v turbulentní době a skutečnosti, dříve pokládány za neměnné, se hroutí jako domečky z karet. Naposledy se tímto stylem zhroutila jedna z konstant českého Internetu, když weby Ministerstva vnitra a Policie ČR začaly podporovat HTTPS. Samozřejmě, není všechno zlato co se třpytí, takže i když mají weby mvcr.cz a policie.cz ono magické "S" na konci protokolu, v testu kvality implementace dostaly od Qualysu známku F - tedy nejhorší možnou. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20181105-zazraky-se-deji.png -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = Bezpečnost -->
<!-- dcterms:dateAccepted = 2018-11-05T12:00:00 -->

Žijeme v turbulentní době a skutečnosti, dříve pokládány za neměnné, se hroutí jako domečky z karet. Naposledy se tímto stylem zhroutila jedna z konstant českého Internetu, když weby Ministerstva vnitra a Policie ČR začaly podporovat HTTPS. Samozřejmě, není všechno zlato co se třpytí, takže i když mají weby mvcr.cz a policie.cz ono magické "S" na konci protokolu, v testu kvality implementace dostaly od Qualysu známku F - tedy nejhorší možnou.

Princip "HTTPS Everywhere", tedy že pokud možno všechny weby by měly fungovat přes HTTPS, tady s námi je už nějakou dobu. Jeden čtenář serveru root.cz se [zeptal na důvod](https://www.root.cz/zpravicky/proc-nema-policie-ceske-repubiky-na-webu-https/). Odpověď vrchního komisaře kpt. Mgr. Michala Michálka je fascinující:

![Odpověď PČR](https://www.cdn.altairis.cz/Blog/2018/20181105-pcr-odpoved.jpg)

Je to samozřejmě naprostý blábol. Část tvrzení je prokazatelně lživá, část nesmyslná, část nesrozumitelná. Začal jsem tedy pátrat po tom, nakolik to s tou odpovědí myslí vážně.

Výsledkem byla zhruba hodinová schůzka, na které mi pět zaměstnanců ministerstva vnitra vysvětlovalo, proč HTTPS zavést prostě nelze, přesně podle hesla "kdo chce, hledá způsoby, kdo nechce, hledá důvody". Základní opakující se motivy byly zhruba stejné, jako vždy, když jsem v rámci státní správy řešil nějaký průšvih:

1. **Nedovedete si představit, jak to máme ve státní správě težké a komplikované.** Představivost mám myslím docela dobrou; nevylučuji nicméně, že i moje fantazie nestačí na drsnou realitu kruté džungle státní správy.
1. **My bychom rádi, ale nemáme na to peníze.** Účinnost tohoto argumentu poněkud snižuje skutečnost, že náklady na vypracování obsáhlých zdůvodnění proč něco nejde a uspořádání oné schůzky by pokryly náklady na certifikáty na přibližně deset let dopředu.

Nyní tedy peklo zmrzlo a před adresami `www.mvcr.cz` a `www.policie.cz` se objevilo ono magické `https://`. Samozřejmě první co jsem udělal, bylo zkusit na web MVČR poštvat [nástroj SSL Test](https://www.ssllabs.com/ssltest/analyze.html?d=www.mvcr.cz) od společnosti Qualys. Ten provede obsáhlé zhodnocení nastavení serveru a vystaví mu známku jako v (americké) škole. A+ je nejlepší a nejhorší je F - failed.

Jak dopadly weby MV a PČR? _(Pro screenshot úplného výsledku klepněte na obrázek.)_

[![Výsledek hodnocení SSL Testu](https://www.cdn.altairis.cz/Blog/2018/20181105-ssltest-mvcr-small.png)](https://www.cdn.altairis.cz/Blog/2018/20181105-ssltest-mvcr-full.png)

## Co je špatně

Problém se zabezpečením komunikace prostřednictvím HTTPS je, že nestačí jenom aby váš web byl dostupný, když se do adresního řádku prohlížeče napíše `https://`. To samo o sobě be skutečnosti znamená jenom málo. Aby vám všechny ty certifikáty a udělátka byla k něčemu dobrá, je ještě nezbytné zkonfigurovat značné množství parametrů.

V první řadě je nezbytné zakázat staré a nebezpečné protokoly, zejména pak všechny verze SSL a ponechat jenom aktuální verze TLS. Vnitro je v tomto ohledu na půl cesty: nepodporuje žádnou verzi SSL (což je dobře), ale podporuje zastaralé verze TLS 1.0 a 1.1. Což je... řekněme že v rozporu s best practices. Nepředstavuje bezprostřední ohrožení, ale nemá budoucnost (prohlížeče ho během cca. roku přestanou podporovat) a u nové instalace podle mého soudu nedává smysl.

V řadě druhé záleží na nastavení takzvaných cipher suites, tedy kombinací kryptografických algoritmů a parametrů, které se pro šifrování nakonec reálně použijí. Server MVČR důsledně preferuje ty kombinace šifer, které jsou pokládány za slabé a nedoporučované. 

To je také jádrem oné známky F, kterou si web vysloužil za napadnutelnost útokem [Return Of Bleichenbacher's Oracle Threat (ROBOT)](https://robotattack.org/). Web podporuje cipher suites rodiny `TLS_RSA_*`, které nejsou pokládány za bezpečné a jsou tímto útokem napadnutelné. Podporuje i modernější cipher suites, založené na Diffie-Hellman výměně klíčů, včetně varianty s eliptickými křivkami, ale implementace DHE je chybná. Nepodporuje forward secrecy, takže v případě prozrazení privátního klíče serveru lze zpětně dešifrovat zachycenou komunikaci.

Pokud se na to dobře dívám a na nic jsem nezapomněl, žádná ze zranitelností neznamená úplně bezprostřední a akutní ohrožení zásadního aspektu aplikace HTTPS na webu tohoto typu, kterým je autentizace serveru a zaručení integrity předávaných dat. Ale není to ani dobře nastavené. Rozhodně to není v souladu s best practices (o některých z nich a budoucnosti HTTPS jsem psal v [nedávném článku pro Hospodářky](https://tech.ihned.cz/c7-66303170-psms7-0b5ed1a1a1ded3c)).

Těžko říci, co je důvodem takovéhle zapeklité situace. Samozřejmě to může být prostá neznalost. Že státní správa nedokáže zaplatit špičkové IT odborníky, protože nabízí mizerné podmínky (nejen finanční) je všeobecně známo, tak si holt musí vystačit s tím, co na ni zbude. Možná je to nějaká zoufalá snaha o zpětnou kompatibilitu. Ovšem bavíme se o kompatibilitě s dávno zavrženými platformami jako Internet Explorer 8 na Windows XP nebo dvojkové verze Androidu.

Weby MVČR a Policie dnes připomínají někoho, kdo visí na útesu za konečky prstů. Sice se těší úplnému zdraví a technicky vzato mu skoro nic neschází... Stačí ale málo, aby se situace dramaticky změnila.