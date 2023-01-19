<!-- dcterms:title = GitHub a privátní repozitáře zdarma: zrada myšlenek open source? -->
<!-- dcterms:abstract = Když Microsoft před půl rokem koupil GitHub, moje první myšlenka byla, že konečně budou privátní repozitáře zadarmo. Nyní na to konečně došlo. V myslích poněkud zpozdilejších geeků ovšem Microsoft stále zaujímá pozici arciďábla a vidí v tom zradu myšlenek open source. Je tomu skutečně tak? -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/logo-github.svg -->
<!-- x4w:coverUrl = /cover-pictures/20190108-github.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = IT -->
<!-- dcterms:date = 2019-01-08 -->

Když Microsoft před půl rokem koupil GitHub, moje první myšlenka byla, že konečně budou privátní repozitáře zadarmo. [Nyní na to konečně došlo.](https://blog.github.com/2019-01-07-new-year-new-github/) V myslích poněkud zpozdilejších geeků ovšem Microsoft stále zaujímá pozici arciďábla a vidí v tom zradu myšlenek open source. Je tomu skutečně tak?

Co je to GitHub? Pro neprogramátory budu po klausovsku [citovat sám sebe](/2018/11/jak-jsem-nepridal-komentare):

> [GitHub](https://github.com/) je služba (nedávno koupená Microsoftem), kterou používají vývojáři (zejména) open source aplikací. Nabízí jim celou řadu důležitých služeb:
> * Hostování a verzování zdrojových kódů. Technologie takzvaných Git repozitářů umožňuje na jednom projektu pracovat více lidem a to i současně. Nabízí také možnosti řešení případných konfliktů, když několik lidí edituje současně tentýž soubor. Zároveň udržuje historii všech změn a umožňuje se vrátit k libovolnému stavu z minulosti.
> * Umožňuje od libovolného projektu vytvořit vlastní větev (fork), která se může vyvíjet nezávisle na původní. Je však možné poslat tzv. _pull request_ a vlastník původního projektu do něj může změny zahrnout zpět.
> * Spravování databáze takzvaných _issues_, problémů. Kdokoliv narazí v projektu na chybu, může ji zadat do ticketovacího systému a tam může být dále zpracovávána a nakonec vyřešena a příslušný issue je uzavřen.
> * Provoz webových stránek projektu a nástroje pro zpracování dokumentace k němu atd.

Historicky platí, že všechny výše uvedené služby jsou zdarma, ovšem pouze za podmínky, že je váš repozitář veřejný. Tj. kdokoliv se může podívat do zdrojového kódu a může si vytvořit jeho kopii a pokračovat ve vývoji vlastním směrem (fork).

Repozitář může být i soukromý, skrytý očím veřejnosti. To ovšem je placená služba, stojí $ 7 za měsíc (existují i [pokročilejí tarify](https://github.com/pricing) s dalšími možnostmi, ale ty pro nás nejsou zajímavé).

Microsoft nyní přikročil ke změně, kdy každý uživatel GitHubu může mít zdarma neomezené množství privátních repozitářů a na každém mohou spolupracovat až tři lidé.

Kamarádka to na mém Facebooku okamžitě okomentovala takto:

> **Julie Koubová:** Slashdot clanek jak micro$oft zabiji open source in 3…2…1

Na Slashdot a podobné programátorské žumpy jsem neměl odvahu se podívat. Stačí mi, [co se urodilo pod postem](https://www.facebook.com/rider.cz/posts/10213542415578343), kde jsem na to upozornil:

> **David Icazo:** Tak uvidíme, jestli i GitHub projde tím klasickým MS procesem - Embrace, Extend, Extinguish.

> **Tomáš Kapler:** Já vlastně nevím, jestli je tohle dobře. Ta pravidla tak nějak nutila všechny implicitně mít všechno public free, takhle bych si tipnul, že spousta lidí bude začínat rovnou s private a do public si nepřepnout. Takže sice lepší pro bezpečnost, horší pro sdílení vědomostí a kódů.

Když už si v tomhle článku zjednodušuji práci tím, že cituji jiné, budu v tom pokračovat komentářem Martina Malého, který velice dobře shrnuje můj názor:

> **Martin Malý:** Dobrá zpráva. Doteď mám neveřejné na BitBucketu, tam jsou i ve variantě "zdarma", ale přesunu je na GitHub, kdybych chtěl něco z toho časem odemknout. GH se tak stane univerzálním serverem, už nebudu muset řešit, jestli to chci veřejně nebo privátně.

Podle mého názoru tento krok otevřenému software především pomůže. A to hned z několika důvodů.

První zmínil už Martin Malý. Není jenom GitHub a jeho konkurence se až dosud odlišovala právě soukromými repozitáři do určitého počtu uživatelů (obvykle 5) zdarma. To nabízí [BitBucket](https://www.bitbucket.com) nebo třeba vlastní služba od Microsoftu, která se dříve jmenovala Visual Studio Online a nyní byla v rámci akce s kódovým jménem "všichni jsme Azure" přejmenována na [Azure DevOps](https://azure.microsoft.com/en-us/services/devops/). Kdokoliv dosud chtěl soukromé repozitáře, měl k dispozici řadu bezplatných nástrojů, nebo holt GitHubu zaplatil ekvivalent dvou značkových kafí měsíčně.

Současná změna umožní zájemcům všechno převést na jednu platformu - GitHub - a když na to přijde, projekt zveřejnit jedním kliknutím, až nadejde jeho čas.

To je totiž ten druhý důvod. GitHub je v současné době zaplevelen hromadami projektů, které sice jsou formálně veřejné, ale v praxi jsou k ničemu, protože jsou to nějaké pokusné záležitosti, nedodělané, opuštěné... Pokud tyto věci budou soukromé, ničemu to neublíží, právě naopak. Většina projektů je v počáteční fázi nevhodná ke zveřejnění, protože jsou ve fázi pokročilejšího proof-of-conceptu, bez dokumentace, bez reálné šance na pochopení kýmkoliv kromě autora.

Některé z nich se z této fáze vymaní, jiné tiše zahynou. Škoda jich nebude.