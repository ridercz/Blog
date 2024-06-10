<!-- dcterms:title = SAPO: první československý počítač, v němž se o výsledku hlasovalo -->
<!-- dcterms:abstract = První univerzální československý počítač se jmenoval SAPO (Samočinný Počítač). Stavěl se sedm let a po dvou letech vyhořel. Zůstalo nám ale po něm dědictví v podobě technologie TMR (Triple Module Redundancy), kterou využívá třeba SpaceX. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20210317-sapo.png -->
<!-- x4w:pictureCredits = Teknad via Wikimedia Commons, CC BY-SA -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = IT historie -->
<!-- dcterms:date = 2024-06-10 -->

Název prvního československého počítače je velmi přímočarý: SAPO je zkratka ze "SAmočinný POčítač". Jeho konstrukce ovšem zdaleka tak přímočará nebyla a některými jejími aspekty se inspirujeme dodnes.

Počátky výpočetní techniky v Československu nelze oddělit od osoby Prof. Dr. Ing. Antonína Svobody (1907-1980). Za první republiky vystudoval strojní inženýrství a fyziku, což mu poskytlo ideální kvalifikaci pro práci na zařízeních, které jsou přímými předchůdci univerzálních počítacích strojů: nástrojích na řízení protiletecké palby. Při ní je nezbytné počítat s pohybem a dráhou střely i cíle, což je dosti náročná fyzikálně matematická úloha. S rostoucím významem letectva ve druhé světové válce bylo tomuto problému věnováno mnoho energie a peněz. Svoboda na této problematice ve třicátých letech pracoval pro české ministerstvo obrany a po obsazení československé republiky nacisty emigroval nejprve do Francie a pak za poměrně dramatických okolností do USA. Tam pracoval na vývoji zaměřovacího systému MARK 56 GFCS, což byl mechanický analogový počítač pro řízení palby. Do Československa se vrátil v roce 1946.

> „Matematický stroj nesmí být sensačním překvapením pro mladého člověka. Musí se s ním seznámit jako s obvyklým zařízením, které je jedním z běžných prostředků k dobývání obživy.“
> _-- Antonín Svoboda, I. celostátní konference v oboru výpočetní a organizační techniky, Praha 1958_

V roce 1950 založil Oddělení (později Laboratoř a ještě později Výzkumný ústav) matematických strojů a začal z vládního pověření pracovat na prvním československém počítači, nikoliv mechanickém, ale elektronickém. Práce na projektu šly docela rychle, dokončen byl už v roce 1951. S realizací to bylo v komunistickém československu padesátých let podstatně horší.

Z důvodů částečně politických a částečně praktických bylo požadováno, aby se československé počítače stavěly z československých součástek. Není-li zbytí, bylo možné použít součástkovou základnu zemí RVHP, ale ani to mnohdy možné nebylo. Tento problém historicky provázdel celou výrobu počítačů v Československu, až do jejího konce začátkem devadesátých let.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/PwQhixHdM_o" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

SAPO byl tedy zkonstruován z toho, co bylo k dispozici: z telefonních relé (které řešily logiku) a téměř čtyř stovek elektronek (byly použity jako zesilovače v periferiích). Relé je elektromechanická součástka, kde lze pomocí elektromagnetu přepínat další kontakty. Používají se dodnes tam, kde chceme pomocí malého napětí a proudu spínat větší napětí a proudy, například když domácí automatizace pomocí relé může spínat osvětlení nebo topení. Pro účely konstrukce počítačů byly postupně nahrazeny elektronkami, tranzistory a integrovanými obvody. Není se čemu divit, protože reléové počítače byly značně rozměrné a značně nespolehlivé (a pro jistotu také dost hlučné, spotřebovaly spoustu elektřiny a hodně se zahřívaly). Ale ve své době nic lepšího k dispozici nebylo.

Jenom pro představu: můj počítač má v sobě procesor AMD Ryzen 7, který obsahuje přibližně deset miliard tranzistorů.  Procesor Apple M2 Ultra, který pohání nejnovější Mac Pro, pak 134 miliard. SAPO měl sedm tisíc relé, zabíral plochu okolo stovky metrů čtverečních a když pracoval v noci, matky v širokém okolí domu na Loretánském náměstí 3 (kde tehdy VÚMS sídlil) si stěžovaly, že jim děti kvůli hluku nemohou usnout.

Relé, původně určená do telefonních ústředen, nebyla právě nejspolehlivější. Proto přišel profesor Svoboda s unikátní konstrukcí demokratického počítače, v němž se o správném výsledku hlasovalo. SAPO měl tři výpočetní jádra (řečeno moderní terminologií, tři ALU, aritmeticko-logické jednotky) a aby byl výsledek uznán za správný, musela se na něm shodnout nejméně dvě. Pokud počítač dospěl ke třem různým výsledkům, pokusil se operaci zopakovat a pokud se to nepodařilo ani na druhý pokus, pak se teprve výpočet zastavil.

SAPO byl první počítač, který tento koncept využíval. Je nicméně pravděpodobné, že se profesor Svoboda inspiroval starým námořnickým pravidlem "nikdy nevyrážej na moře se dvěma hodinami, měj jedny nebo troje". Zjištění co nejpřesnějšího času bylo důležité pro navigaci a pro případ, že by se rozbily hodiny, bylo dobré mít záložní. Nicméně pokud máte dvoje hodiny které ukazují různý čas, jak zjistíte, které jdou přesně?

Tento princip je znám pod zkratkou TMR (Triple Module Redundancy) a používá se dodnes tam, kde je třeba vysoká spolehlivost v nespolehlivém prostředí. Najdete ho například v některých ECC pamětech ("lepší" typ počítačové operační paměti, používaný typicky v serverech), protože ho lze poměrně jednoduše realizovat hardwarově a je tak rychlejší, než softwarové postupy zajišťující totéž. 

Aktuálně najdete TMR třeba v raketách Falcon 9 společnosti SpaceX. Klasická digitální technika se potýká s problémy, které působí kosmické záření. To může způsobit "bit flipping", kdy se hodnota v paměti změní z 0 na 1 nebo naopak, zcela náhodně a už od prvních družic se to musí řešit. Buďto náročným stíněním, nebo třeba právě redundancí.  Falcon 9 používá trochu modifikovanou verzi. Jeho řídící software běží na Linuxu na dvoujádrových x86 (32-bitových) procesorech, ve třech kopiích. Software spouští v každém počítači operaci na dvou jádrech a tato dvě jádra se musejí shodnout (pokud se neshodnou, nevydá se žádný příkaz). Mikrokontrolery, které řídí motory a další techniku, dostanou třemi nezávislými kanály tři povely od všech třech avionických počítačů. V případě že dojde k neshodě, provede se ten pokyn, na kterém se shodnou dva ze tří.

Trojitá redundance nebyl jediný způsob, jakým SAPO bojoval s inherentní nespolehlivostí součástek. Jak bylo tehdy obvyklé, počítač pracoval v desítkové soustavě (na binární se přešlo až později) a jednotlivé číslice ukládal v kódu "dva z pěti". To je způsob binárního kódování dat, kdy je pro každý znak použito pět bitů a zároveň platí, že právě dva z nich musejí mít hodnotu 1. To dává celkem deset možných kombinací a zajišťuje, že pokud dojde ke změně jednoho bitu, lze chybu okamžitě a na úrovni jedné číslice detekovat. Tento přístup používají dodnes třeba některé často používané čárové kódy.

SAPO byl - přes četné urgence i z vládní úrovně - uveden do provozu poměrně pozdě, až v roce 1958. Sedm let trvalo, než se v podmínkách komunistického centrálního plánování (a politických čistek) podařilo zařízení fyzicky vyrobit a zprovoznit. Vinou toho byl počítač už v okamžiku svého spuštění zastaralý. Nikoliv však neužitečný. Oslňující rychlostí tří operací za sekundu dokázal během pár hodin vyřešit matematické problémy, nad kterými by se lidské týmy namáhaly týdny nebo měsíce. Byl v provozu dva roky a za tu dobu pomohl zhruba 38 organizacím s vědeckými i ryze praktickými výpočty. Pomohl též vytvořit svého nástupce, protože byl použit při konstrukci logických obvodů elektronkového počítače EPOS 1 (Elektronický POčítací Stroj).

V únoru 1960 však přemíra prachu způsobila jiskru, která zapálila loužičku oleje a při následném požáru byl počítač SAPO zničen. Byla sice poškozena jenom dvě procenta jeho konstrukce, ale i tak byla oprava vyhodnocena jako nerentabilní, vzhledem k morální zastaralosti stroje, takže byl SAPO postupně rozmontován. Jeho část skončila v Národním technickém muzeu.

Společenská a politická situace v Československu však profesoru Svobodovi nepřála. Na konci padesátých let vznikl Výzkumný ústav matematických strojů (VÚMS), jehož vedení byl ovšem Svoboda brzo z politických důvodů zbaven. Neměl možnost svobodné komunikace se zahraničím a byl mu všemožně komplikován život.

V roce 1964 tak do USA emigroval - s několika nejbližšími spolupracovníky - profesor Svoboda podruhé. Do roku 1977 byl profesorem na UCLA a v roce 1980 zemřel. Zůstává však světlou postavou československých dějin, minimálně těch počítačových.

Další informace:

* [Samočinný počítač SAPO](https://www.historiepocitacu.cz/samocinny-pocitac-sapo.html)
* [Profesor Antonín Svoboda a historie VÚMSu](https://vums.datacom.cz/)
* [How SpaceX develops software](https://www.coderskitchen.com/spacex-software-development-and-testing/)