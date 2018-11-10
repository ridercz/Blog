<!-- dcterms:title = Jak jsem nepřidal na blog komentáře -->
<!-- dcterms:abstract = Lidé se zkušenostmi z publikování na Internetu se vesměs shodují, že komentáře u článků jsou žumpa. Na obecných serverech bývají trpěny dílem ze setrvačnosti, dílem z obchodních důvodů nebo více či méně pomýlené představě o těchto. U technických serverů nicméně komentáře mývají smysl. Takže jsem je zavedl. Pomocí GitHubu. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/logo-rider.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = Koně -->
<!-- dcterms:dateAccepted = 2018-11-10 -->

Lidé se zkušenostmi z publikování na Internetu se vesměs shodují, že komentáře u článků jsou žumpa. Na obecných serverech bývají trpěny dílem ze setrvačnosti, dílem z obchodních důvodů nebo více či méně pomýlené představě o těchto. Na menších serverech (jako je můj blog) jsou zase zdrojem spamu a dalších problémů. 

U technických serverů nicméně komentáře někdy mívají smysl. Ne že by tam nedocházelo k flamewarům a podobným nešvarům, ale mnohokrát jsem z komentářů získal užitečnou zpětnou vazbu. Tento blog víceméně technický je a proto chci dát čtenářům nějakou systematickou možnost zpětné vazby. Ne, komentáře to nebudou. Bude to GitHub.

## Co je GitHub?

_Programátoři tuto sekci laskavě přeskočí a pokud ne, nebudou frflat nad přemnohými zjednodušeními, jichž jsem se pro dobro laických čtenářů dopustil._

[GitHub](https://github.com/) je služba (nedávno koupená Microsoftem), kterou používají vývojáři (zejména) open source aplikací. Nabízí jim celou řadu důležitých služeb:

* Hostování a verzování zdrojových kódů. Technologie takzvaných Git repozitářů umožňuje na jednom projektu pracovat více lidem a to i současně. Nabízí také možnosti řešení případných konfliktů, když několik lidí edituje současně tentýž soubor. Zároveň udržuje historii všech změn a umožňuje se vrátit k libovolnému stavu z minulosti.
* Umožňuje od libovolného projektu vytvořit vlastní větev (fork), která se může vyvíjet nezávisle na původní. Je však možné poslat tzv. _pull request_ a vlastník původního projektu do něj může změny zahrnout zpět.
* Spravování databáze takzvaných _issues_, problémů. Kdokoliv narazí v projektu na chybu, může ji zadat do ticketovacího systému a tam může být dále zpracovávána a nakonec vyřešena a příslušný issue je uzavřen.
* Provoz webových stránek projektu a nástroje pro zpracování dokumentace k němu atd.

## Tento blog běží na GitHubu

Tento blog sám je provozován na GitHubu. Není za ním žádný redakční systém, je to hromada statických HTML souborů, generovaná pomocí Markdownu a XSLT šablon. Zdrojová data, šablony a vlastně všechno si kdokoliv může [prohlédnout na mém GitHubu](https://github.com/ridercz/Blog).

Výhodou je, že tento web je celý hostován v cloudu a to zdarma. Není nijak závislý na mé soukromé technologické architektuře, je provozován plně na serverech GitHubu (Microsoftu) a CloudFlare. Tím je zaručena jeho vysoká bezpečnost, dostupnost a v podstatě neomezená škálovatelnost.

A napadlo mne, že pro zpětnou vazbu vlastně také mohu využít GitHub. Nestojím o žádnou obsáhlou diskusi, ale rád se dozvím, že jsem někde udělal chybu (ať už věcnou nebo překlep), nebo že by technický článek měl obsahovat nějaké dodatečné informace. 

Na konci stránky najdete možnost vytvořit nový issue v ticketovacím systému. Pokud najdete nějakou chybu nebo chcete něco dodat, zadejte to do issue. GitHub mne upozorní a já budu mít možnost věc vyřešit a opravit. Případně to můžete udělat sami. Další odkaz vede na možnost vytvořit vlastní fork mého blogu a přímo editovat zdrojový text kteréhokoliv článku. Opravu chyby nebo doplnění tedy můžete vytvořit sami a poslat mi pull request. Pokud bude vaše změna v pořádku, pull request přijmu a oprava se objeví na tomto webu.

## Co si od toho slibuji

Na tomto webu publikuji v zásadě dva druhy článků. První jsou mé komentáře. Mé subjektivní názory u nichž mne v zásadě netrápí, nakolik se s nimi jako čtenáři ztotožňujete nebo ne a obecně nemám chuť nad nimi diskutovat a své názory obhajovat či vysvětlovat. Druhý typ článků však představují věci technické, kde je situace zcela jiná a pro které je tento mechanismus především určen.

Nutnost použití pro laika relativně komplikovaného GitHubu (včetně nutnosti se na něm registrovat) by snad mělo odfiltrovat většinu běžné internetové populace, které se udělal názor a má nutkání ho sdělovat prostřednictvím komentářů, místo aby si na to udělala vlastní web. Zároveň je GitHub vesměs srozumitelný pro programátory a podobnou verbež.

Tak uvidíme, jak se to osvědčí.