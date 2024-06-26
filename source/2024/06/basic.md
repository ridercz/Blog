<!-- dcterms:title = Když BASIC vládnul světu -->
<!-- dcterms:abstract = Když startoval (tehdy se tomu ještě neříkalo “bootoval”) můj první počítač, na pár sekund zobrazil hlášku “Testing memory”. Pak pípnul a přivítalo mě hlášení “BASIC G /V3.0”. Ten počítač byl československé výroby a jmenoval se PMD 85-3. A stejně jako většina malých počítačů té doby – včetně populárnějších a světově rozšířenějších modelů typu Sinclair ZX Spectrum, Commodore C64 nebo třeba Atari 800 – po startu automaticky nabídl prostředí programovacího jazyka BASIC. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20210513-basic.png -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = IT historie -->
<!-- dcterms:date = 2024-06-26 -->

Když startoval (tehdy se tomu ještě neříkalo "bootoval") můj první počítač, na pár sekund zobrazil hlášku `Testing memory`. Pak pípnul a přivítalo mě hlášení `BASIC G /V3.0`. Ten počítač byl československé výroby a jmenoval se PMD 85-3. A stejně jako většina malých počítačů té doby - včetně populárnějších a světově rozšířenějších modelů typu Sinclair ZX Spectrum, Commodore C64 nebo třeba Atari 800 - po startu automaticky nabídl prostředí programovacího jazyka BASIC. Počítače tohoto typu neměly spouštěné aplikace tak jak je známe teď, ale očekávalo se, že se programy budou psát v BASICu nebo ve strojovém kódu a načítat typicky z kazet přes magnetofon.

Programovací jazyk BASIC vznikl před 57 lety, v roce 1964 na univerzitě Darthmoung College v USA. Jeho autory byli pánové John G. Kemeny a Thomas E. Kurtz. Název BASIC - kromě toho, že je to anglické slovo znamenající "jednoduchý" je zkratka z Beginners' All-purpose Symbolic Instruction Code, tedy všestranný programovací jazyk pro začátečníky. To bylo jeho hlavní určení. Programovací jazyky té doby byly typicky uživatelsky dost nepřívětivé a komplikované. BASIC měl sice často omezenější možnosti, ale zato byl jednoduchý, srozumitelný a dostupný uživatelům.

Ukázka programování v BASICu na počítači PMD 85-3 (natočeno v [softwarovém emulátoru od Romana a Martina Bórikových](https://pmd85.borik.net/wiki/Emulator)): 

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/ILvHAdSheAg" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

Jazyk BASIC vzal svět malých domácích počítačů útokem a v sedmdesátých a osmdesátých letech dvacátého století vznikly stovky jeho dialektů, běžící na stovkách modelů počítačů. Asi jenom těžko bychom hledali platformu té doby, na které by nějaká varianta BASICu neběžela. Býval základním - a mnohdy také jediným - programovým vybavením, které novopečený majitel počítače dostal. Většina z malých počítačů jej měla přímo v ROM, do jiných se dal nahrát, často vložením nějaké EPROM cartridge. Prostředí jazyka BASIC defacto nahrazovalo operační systém tak, jak ho dneska chápeme.

S rozšířením počítačů mezi uživateli samozřejmě nastala situace, že mnoho z nich programovat neumělo ani nechtělo umět. Na počítači hráli hry nebo používali nějaký jiný software. Jeden příkaz znal ale každý. Jmenoval se LOAD a sloužil k nahrání programu z kazety. 

Podívejte se, jak takové nahrání a spuštění programu v BASICu vypadalo. Na videu je také zachycen typický problém starší generace počítače PMD 85, totiž zasekávání kláves:

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/VxIJMGFXT9w" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

Pokud jste na počítači nechtěli programovat, ale používat existující software, byl typicky uložen na běžné magnetofonové kazetě. Pokud vám zvukový záznam ve videu výše připomíná o zhruba dekádu novější zvuk modemu pro dial-up připojení k Internetu, připomíná vám ho správně -- princip je v zásadě tentýž, včetně úvodního pískání na začátku. V některých zemích (typicky v UK) se programy vysílaly třeba i v televizi nebo v rozhlase. Očekávalo se, že uživatelé si pořad nahrají a poté ho pustí do počítače. V československu programy vycházely i tiskem, třeba v časopisech jako Amatérské rádio nebo ABC a očekávalo se, že si je uživatelé do počítače opíší. Ruční opisování byl proces pracný a náchylný k chybám, ale zase měl tu výhodu, že při něm zkušenější uživatel mohl program upravit pro konkrétní dialekt BASICu, používaný jeho počítačem. Jednotlivé modely totiž zpravidla nebyly kompatibilní natolik, aby mohly z kazety nahrát program určený pro jiný počítač, i když vlastní zdrojový kód byl totožný nebo velice podobný.

Klasický BASIC měl jednotlivé řádky číslované a číslovalo se obvykle po deseti - 10, 20, 30 atd., aby bylo možné v případě potřeby mezi řádky ještě jeden vložit (třeba 15). Pokročilejší verze pak uměly řádky automaticky přečíslovat (obvykle příkazem `AUTO`). Číslování řádků bylo nezbytné, protože tyto počítače neměly vestavěný textový editor, který by uměl editovat delší text. Vždy bylo nutné editovat jednu konkrétní řádku. Takže pokud jste chtěli upravit kód na řádku 100, napsali jste `LLIST 100` a řádek změnili a uložili.

BASIC byl milován i nenáviděn. Edsger W. Dijkstra kdysi prohlásil, že _"Je prakticky nemožné naučit dobrý programátorský styl studenty, kteří byli předtím vystaveni BASICu. Jako potenciální programátoři jsou mentálně zmrzačení tak, že není naděje na uzdravení."_ Pan Dijkstra byl ovšem znám svými kritickými názory a nebylo snadné ho uspokojit; ostatně, další z jeho známých výroků je, že výuka jazyka COBOL by měla být brána jako trestný čin. Ostatně, já jsem na Basicu začínal (stejně jako téměř celá generace mých vrstevníků) a myslím, že to na mně žádné nevratné mentální poškození nezanechalo.

Jenomže u programovacích jazyků je to tak, že jejich technologická kvalita je nepřímo úměrná jejich snadné pochopitelnosti (příkladem z novější doby je třeba PHP). A BASIC se dokázal naučit... no, ne úplně každý, ale dokázalo se ho naučit hodně lidí.

Programovací jazyk BASIC stál i za úspěchem společnosti Microsoft. V lednu 1975 vyšel v časopise Popular Electronics článek o počítači Altair 8800 (který se stal později prvním masově prodávaným modelem počítače v USA) a Paula Allena napadlo, že by pro něj šel napsat interpreter BASICu. Jeho kamarád Bill Gates zavolal výrobci s tím, že mají funkční program a jestli ho nechtějí koupit. Výrobce, společnost MITS, předběžně souhlasil a požádal o předvedení programu. Allen a Gates ovšem počítač Altair 8800 neměli k dispozici. Celý kód vyvinuli na emulátoru a na skutečném počítači běžel až v okamžiku předvedení u MITS. Běžel bezchybně a Altair Basic se stal prvním komerčně prodávaným produktem společnosti Microsoft (která se tehdy jmenovala Micro-Soft, jako Microcomputer Software). Microsoft potom dodával BASIC interpreter pro celou řadu dalších výrobců a modelů, například Commodore, IBM, NEC nebo Radio Shack/TRS.

Kromě počítačů se BASIC dostal i do programovatelných kalkulaček. Jeho dialekty najdeme v kalkulačkách od všech tří hlavních výrobců, TI, HP i Casio.

S vývojem počítačů se vyvíjel i Basic. Postupně přišel o čísla řádků a přibyly v něm pokročilejší konstrukty jako procedury a funkce, programování se změnilo z lineárního na procedurální. Součástí DOSu a starších verzí Windows bylo vývojové prostředí GW-BASIC a později QBasic od Microsoftu. GW-BASIC byl loni Microsoftem [zveřejněn jako open source na GitHubu](https://devblogs.microsoft.com/commandline/microsoft-open-sources-gw-basic/) a stále je k dispozici a aktivně vyvíjen [FreeBasic](https://www.freebasic.net/), open source kompatibilní alternativa QBasicu.

V roce 1991 společnost Microsoft vydala produkt jménem Visual Basic. Jednalo se o zcela nový programovací jazyk, určený pro tvorbu Windows aplikací, založený na klasickém BASICu. Motivace byla podobná jako u toho původního - nabídnout jednoduchý, snadno použitelný jazyk pro začátečníky a neprogramátory. Visual Basic umožňoval také jednoduchý vizuální návrh uživatelského rozhraní. A přestože se nad ním "opravdoví programátoři" ušklíbali, Visual Basic měl obrovský úspěch. Nebo přesněji, má obrovský úspěch. Protože jej dones jako VBA (Visual Basic for Applications) najdeme pro programování maker v Microsoft Office (a OpenOffice Basic je pro tentýž účel v Open Office). Existuje velké množství velkých firem, jejichž line of business systémy stále závisejí na komponentách napsaných ve Visual Basicu, včetně třeba některých českých bank.

<figure>
    <img src="https://www.cdn.altairis.cz/Blog/2024/20240626-basic-01.jpg" alt="Visual Basic 6.0 na Windows XP" />
    <figcaption>Visual Basic 6.0 na Windows XP</figcaption>
</figure>

Když v roce 2002 Microsoft přišel s platformou .NET, představil i nový programovací jazyk C#. Ale kromě něj nabídl i VB.NET (Visual Basic .NET), který měl umožnit snadný přechod VB programátorů na novou platformu. I v tom byl úspěšný. Většina programátorů (včetně autora tohoto článku) postupem času přešla na C#, který je výrazně protěžován a je, upřímně řečeno, podstatně elegantnější. Ale VB.NET je neustále vyvíjen a má sice malou, ale velmi věrnou skupinu uživatelů.

<figure>
    <img src="https://www.cdn.altairis.cz/Blog/2024/20240626-basic-02.jpg" alt="Visual Basic .NET ve Visual Studiu 2013" />
    <figcaption>Visual Basic .NET ve Visual Studiu 2013</figcaption>
</figure>

BASIC ukázal, že přístupnost a uživatelská přívětivost je nutná i u programovacích jazyků a že ne vše, nad čím se hardcore ajťáci ofrňují, si zaslouží zatracení. Ostatně, nejpopulárnější programovací jazyk pro začátečníky dnes je Python a přestože je výrazně mladší a modernější, jednoduchost a přístupnost staví na stejných principech, s jakými původně přišli pánové Kemeny a Kurtz.
