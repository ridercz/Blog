<!-- dcterms:identifier = aspnetcz#5429 -->
<!-- dcterms:title = Projekt Atropa (1): Jak vyrobit z Raspberry Pi zlé zařízení s .NETem -->
<!-- dcterms:abstract = Líbí se mi malé počítače, ASP.NET a jsem celkově zlé stvoření. Rozhodl jsem se tyto obory spojit a rozchodit na minipočítači Raspberry Pi nové ASP.NET 5 a udělat z něj wifi honeypot, který bude lákat z hloupých lidí jejich přihlašovací údaje. No a rozhodl jsem se postup dokumentovat a zveřejnit zde jako návod. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = IT -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- np9:serialId = 7 -->
<!-- x4w:serial = Projekt Atropa -->
<!-- dcterms:created = 2015-07-13T03:05:45.32+02:00 -->
<!-- dcterms:dateAccepted = 2015-07-13T00:00:00+02:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20150713-projekt-atropa-1-jak-vyrobit-z-raspberry-pi-zle-zarizeni-s-netem.jpg -->

> **Upozornění:** Tento text je několik let starý a spousta věcí se změnila. Zejména v ASP.NET Core (zde pod starým názvem ASP.NET 5). Článek ponechávám jako referenci, ale obecně doporučuji nalézt novější zdroje, jako napříkad [tento seriál](/serials/asp-net-na-raspberry-pi).

Líbí se mi malé počítače, ASP.NET a jsem celkově zlé stvoření. Rozhodl jsem se tyto obory spojit a rozchodit na minipočítači Raspberry Pi nové ASP.NET 5 a udělat z něj wifi honeypot, který bude lákat z hloupých lidí jejich přihlašovací údaje. No a rozhodl jsem se postup dokumentovat a zveřejnit zde jako návod. Nechávám na posouzení laskavého čtenáře, zda to vyhodnotí jako okolnost polehčující nebo přitěžující.

## Proč Atropa?

Raspberry Pi je miniaturní jednodeskový mikropočítač, který je levný a snadno dostupný. Může na něm běžet kdeco, třeba Linux nebo speciální edice Windows 10. Posledně jmenovaný systém je teprve v plenkách, takže pokud chcete na RPi něco vážnějšího dělat, tak vám toho času nezbude, než si začít s Linuxem. 

[![Celkový pohled na Raspberry Pi](https://www.cdn.altairis.cz/Blog/2015/20150713-atropa_rpihw_thumb_1.jpg "Celkový pohled na Raspberry Pi")](https://www.cdn.altairis.cz/Blog/2015/20150713-atropa_rpihw_4.jpg)

Abych se nemusel vzdávat své oblíbené technologie .NET, chtěl jsem vyzkoušet, jak je možné ASP.NET aplikace (psané pomocí nového ASP.NET 5) reálně provozovat na Linuxu za hranicemi dema.

A protože se zabývám počítačovou bezpečností, napadlo mne z Raspberry Pi udělat "zlý přístupový bod" (rogue AP). Bude vysílat Wi-Fi, ke které když se někdo připojí, zobrazí se mu captive portál (jak je u mnoha připojení k Internetu běžné), kde se z oběti pokusím vylákat citlivé přihlašovací údaje.

Nejsem sám, koho tato idea napadla. Na Raspberry Pi se dá nahrát kompletní Kali Linux včetně programu Mana Toolkit, který tohle všechno umí a ještě něco navíc. Nicméně, já si to chtěl zkusit naprogramovat v .NETu a navíc nastavit tak, aby celý program byl naprosto autonomní a fungoval bez obsluhy, jenom po připojení napájení, a aby fungoval i bez připojení k Internetu.

A proč se to celé jmenuje Atropa? *Atropa Belladonna* je latinský název pro rulík zlomocný, prudce jedovatou rostlinu, která se vyskytuje téměř po celé Evropě, včetně České republiky. Odhaduje se, že otravy rulíkem zlomocným tvoří zhruba polovinu všech vážných otrav rostlinného původu na našem území. Raspberry jsou maliny, ale moje variace na toto téma není zase až tak chutná.

Samozřejmě záleží na vás, jak se získanými informacemi naložíte. Drtivá většina postupů bude naprosto bez problémů použitelná pro vývoj jakékoliv, i mnohem hodnější, aplikace v ASP.NET pro RPi. "Zlé" věci budeme dělat jenom ve dvou dílech.

## Co budete potřebovat?

*   **Raspberry Pi.** Já pracuji s [RASPBERRY Pi 2 Model B](https://www.alza.cz/raspberry-pi-2-d2307258.htm), ale měl by vám stačít i [RASPBERRY Pi Model B+](https://www.alza.cz/raspberry-pi-model-b-d2141877.htm). (Linky vedou na Alza.cz, ale RPi lze na menších e-shopech koupit výrazně levněji). Doporučuji si k němu koupit i nějakou krabičku. 
*   **Dostatečně silný zdroj s MicroUSB konektorem.** Budete z něj napájet Raspberry a měl by mít alespoň 2 A. Já používám ke své spokojenosti 2 A zdroj od tabletu. Nabíječka na mobil vám téměř jistě stačit nebude. 
*   **MicroSD kartu.** Používám 16 GB Class 10, ale měla by vám, stačit i menší, 8 GB určitě, možná i 4 GB. Také budete potřebovat patřičnou čtečku pro vaše PC a případně redukci z MicroSD na velkou SD.  Redukce bývá u některých karet přímo součástí balení. 
*   **Monitor s HDMI vstupem.** To má většina novějších monitorů, případně vám stačí DVI nebo DisplayPort vstup a patřičná redukce/kabel. 
*   **USB klávesnice.** Jakákoliv standardní klávesnice postačí. 
*   **USB Wi-Fi karta.** Nejlépe se mi osvědčila karta [TP-LINK TL-WN722N](https://www.alza.cz/tp-link-tl-wn722n-lite-d155291.htm). Je levná, široce kompatibilní (Raspbian s ní umí pracovat automaticky), má všechny funkce potřebné i pro pokročilejší Wi-Fi škození a externí anténu, místo které je možné připojit jinou. 

Dále pak budete potřebovat běžný počítač s v podstatě libovolným operačním systémem. Já používám poslední preview Windows 10, ale nesejde na tom, protože z tohoto PC budeme potřebovat jenom kopírovat souboryu a používat terminálový program. Využívat budeme též různý volně dostupný software, na který vás postupně upozorním v průběhu návodu.

## Co se naučíte?

Seriál bude rozdělen do několika dílů, které budou vycházet postupně v týdenních intervalech. Cílovou skupinou jsou .NET programátoři, u kterých nepředpokládám žádnou zkušenost s Linuxem a podobnými věcmi, návody budou zcela konkrétní. 

Jednotlivé díly budou mít následující obsah:

1.  Úvod, který právě čtete. 
2.  Zprovoznění Raspberry Pi a Raspbian Linuxu. 
3.  Instalace a konfigurace Mono, ASP.NET 5 a rozchození první aplikace. 
4.  Instalace a konfigurace nginx jako proxy a nastavení ASP.NET pro ostrý provoz. 
5.  Instalace a konfigurace HostAPD, DnsMasq a captive portál pro WiFi. 
6.  Tvorba captive portálu v ASP.NET 5. 
7.  Návody, jak se útokům tohoto ražení bránit. 

Díly 1-4 jsou "hodné" a jejich výsledkem bude platforma, na které by měla běžet jakákoliv ASP.NET aplikace. Díly 5-6 jsou "zlé" a ukáží, jak uvedené technologie využívat k útokům na důvěřivé uživatele. Díl 7 je nejhodnější a ukáže vám, jak se bránit.

## Varování

**Píšu o věcech, kterým příliš nerozumím.** O Linuxu toho mnoho nevím a tento seriál je z velké části kompilátem návodů, které jsem našel někde jinde, upravil je a aktualizoval. Neříkám, že mnou zvolené řešení je nejlepší, nebo dokonce jediné možné. Rovněž se příliš nezabývám bezpečností, jelikož neočekávám, že by se na zařízení tohoto typu vyskytovala citlivá data provozovatele.

**Píšu o věcech, které se rychle mění.** Vycházejí nové verze knihoven, použitého software, ASP.NET je v betě… Možná vám něco nebude fungovat nebo se to bude chovat jinak, než mně. To byl můj největší problém, když jsem se řídil radami jiných. Odfiltrovat již neaktuální a zastaralé informace.

**Použití výsledného zařízení může být za určitých okolností nelegální.** Při reálném použití zařízení tohoto druhu se můžete dopustit široké škály trestných činů, příkladně neoprávněného přístupu k počítačovému systému a nosiči informací podle § 230 trestního zákona. 

Při – podle mého názoru nepřípadně extenzivním – výkladu zákona by se samotné vydání tohoto článku mohlo chápat jako trestný čin opatření a přechovávání přístupového zařízení a hesla k počítačovému systému a jiných takových dat dle § 231 TrZ. Já jsem přesvědčen, že se trestného činu nedopouštím. Jednak mým cílem není spáchat trestné činy dle § 182 a § 230 TrZ a také jsem přesvědče, že mé jednání má nulovou společenskou nebezpečnost. Naopak, jeho cílem je být společensky prospěšným.

Živím se tím, že uživatele i programátory učím chovat se a jednat bezpečněji. Mám v tom dlouholetou praxi a její důležitou součástí je poznání, že mi lidé prostě nevěří. Myslí si, že kybernetické útoky jsou něco, co se děje jenom v amerických filmech, co zvládnou jenom špičkoví hackeři, kterých je v republice pět, a že k tomu potřebují sofistikované speciální vybavení za drahé peníze. Že jejich data nikomu nebudou za takovou věc stát. Vím, že mne účastníci mých kurzů začnou brát vážně teprve ve chvíli, kdy jim ukážu, že škodit se dá i s věcmi, které jsem jen tak našel po kapsách.

Nic z toho, co zde popisuji, není novinka. Všechny tyto postupy jsou známé a používají se běžně, dlouhá léta a setkal jsem se s nimi jako s reálnými útoky "in the wild". Doufám, že až si je sami vyzkoušíte, začnete je brát vážně.