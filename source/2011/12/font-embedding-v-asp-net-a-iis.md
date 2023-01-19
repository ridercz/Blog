<!-- dcterms:identifier = aspnetcz#352 -->
<!-- dcterms:title = Font embedding v ASP.NET a IIS -->
<!-- dcterms:abstract = Nebaví vás pořád dokola používat ve svých stránkách těch několik málo fontů, které má nainstalovaný každý? Řešením je font embedding, tedy použití písma, které nemá uživatel nainstalované, ale pro účely zobrazení stránky si jej stáhne z vašeho serveru. Jedná se sice o čistě klientskou techniku, ale má i implikace na straně serveru, o kterých také bude řeč. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = IT -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2011-12-10T05:13:24.813+01:00 -->
<!-- dcterms:date = 2011-12-10T05:13:26+01:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20111210-font-embedding-v-asp-net-a-iis.png -->

Nebaví vás pořád dokola používat ve svých stránkách těch několik málo fontů, které má nainstalovaný každý? Řešením je font embedding, tedy použití písma, které nemá uživatel nainstalované, ale pro účely zobrazení stránky si jej stáhne z vašeho serveru. S technikou font embeddingu přišel úplně původně Microsoft, později byla standardizována a nyní je podporována všemi běžnými prohlížeči.

Font embedding je čistě klientská technika a existuje na ni spousta návodů. Tento článek píši proto, že na IIS má font embedding i serverové implikace a že většina mně známých článků pomíjí některé důležité aspekty.

## Krok první: Získání českých písem

Písem je na Internetu k dispozici nepřeberné množství, komerčních i volně dostupných. Pokud ovšem potřebujete písmo s českými znaky, výběr se značně zužuje, zejména pokud potřebujete písmo, které je zdarma. Pokud navíc potřebujete písmo s kvalitními českými diakritickými znaménky, která nevypadají, jako by je někdo přitesal sekyrou, je to ještě těžší. V některých případech tento problém samozřejmě řešit nemusíme: pokud píšeme web, který je v angličtině nebo v rozšířenějších jazycích a nebo pokud budeme používat font s piktogramy jako náhradu obrázků.

V každém případě, moje oblíbené zdroje písem jsou:

*   [**České fonty**](http://www.ceskefonty.cz/) – jak již název napovídá, jedná se o databázi českých fontů, které jsou k dispozici zdarma. 
*   [**Font Squirrel**](http://www.fontsquirrel.com/) – patrně největší databáze volně dostupných fontů. Bohužel, podporu češtiny má jenom menšina z nich a navíc nelze podle tohoto parametru vyhledávat. Font Squirrel má pro naše účely jednu podstatnou výhodu, a to že umí generovat *@font-face* balíčky, a to jak z vlastních, tak z vámi dodaných fontů, o čemž bude řeč později. 
*   [**Google Web Fonts**](http://www.google.com/webfonts) – databáze fontů od Google. Nabízí i [vlastní API](http://code.google.com/apis/webfonts/) a CDN, která vyřeší některé vaše problémy, ovšem za cenu závislosti na Google a možných problémů, pokud se návštěvníci brání šmírování třeba pomocí tracking protection v IE. Podporuje sice vyhledávání i podle skriptu (české znaky jsou v *Latin Extended*), ale faktická podpora v jednotlivých písmech může být nepoužitelná. 

Nepochybně existují i další servery podobného zaměření, nicméně já osobně používám shora uvedené tři. Záměrně jsem se také zaměřil pouze na zdroje dostupné zdarma. Pokud máte další tipy, napište je do komentářů.

[![Toto písmo má v podpoře nabodeníček ještě rezervy](https://www.cdn.altairis.cz/Blog/2011/20111210-font-nocs_thumb.png "Toto písmo má v podpoře nabodeníček ještě rezervy")](https://www.cdn.altairis.cz/Blog/2011/20111210-font-nocs_2.png)

Bohužel, na přítomnost českých znaků se nelze spolehnout a je nutné to otestovat. Naštěstí jak Font Squirrel tak Google Web Fonts umožňují zadat vlastní testovací text, takže hned vidíte, na čem jste. Doporučuji používat osvědčené "*Žluťoučký kůň úpěl ďábelské ódy*", neboť písmena **ť** a **ů** bývají problematická a dobře se na nich pozná, jak moc kvalitní práci autor odvedl.

Použití písem na webu musí být navíc v souladu s licenčními podmínkami. Pokud používáte Font Squirrel nebo Google Web Fonts, nemusíte si v tomto ohledu dělat starosti. U jiných zdrojů je nutné prostudovat licenční podmínky.

## Krok druhý: Konverze formátů

Fonty se pro účely instalace do počítače vyskytují typicky v jednom z formátů TrueType (přípona *.ttf*) nebo OpenType (*.otf*). Velmi výjimečně se setkáte s formátem PostScript Type 1 (přípona nejčastěji *.pfb*), nicméně to je formát dnes již poněkud exotický.

Pro vkládání do stránek se ovšem používají jiné formáty:

*   **Embedded Open Type** (přípona *.eot*) je formát původně vymyšlený Microsoftem, který vychází z OpenType. Je podporován Internet Explorerem od verze 6.0. 
*   **Web Open Font Format** (přípona *.woff*) je víceméně totéž, ovšem novější. Podporuje ho IE od verze 9.0 a některé další prohlížeče. 
*   **TrueType** (přípona *.ttf*) některé browsery umí taktéž, podstatný je zejména pro starší verze iOS. 
*   **Scalable Vector Graphics** (přípona *.svg*) má význam pro ještě starší verze iOS. 

V praxi obyvkle používám kombinaci EOT + WOFF + TTF, která pokrývá většinu současných prohlížečů. Podrobnosti najdete na úchvatném webu [caniuse.com](http://caniuse.com/#feat=fontface).

Pokud je vaším zdrojem písem Font Squirrel, můžete si stáhnout takzvaný **@font-face kit**, což je archiv, který obsahuje fonty ve vybraných formátech, CSS soubor a ukázkovou HTML stránku. Doporučuji ovšem změnit výchozí nastavení. V první řadě obsahuje i formát SVG, který nejspíš nebudete potřebovat, a ve druhé řadě je standardně zvolen subsetting pro angličtinu. Subsetting je funkce, která má za cíl zmenšovat velikost souboru s fontem tím, že se do výsledku vloží pouze znaky z potřebného jazyka. Pokud necháte výchozí nastavení, bude váš balíček obsahovat jenom anglické znaky, i když je třeba k dispozici čeština. V seznamu "Choose a Subset" tedy buďto vyberte češtinu (je-li k dispozici) nebo "Don't Subset". Nepoužívejte při stahování download manager, protože (alespoň ten můj) nastavení resetuje.

[![Doporučené nastavení Font Squirrel @font-face kitu](https://www.cdn.altairis.cz/Blog/2011/20111210-font-fsq_thumb.png "Doporučené nastavení Font Squirrel @font-face kitu")](https://www.cdn.altairis.cz/Blog/2011/20111210-font-fsq_2.png)

Pokud jste ke svému fontu přišli jinde, Font Squirrel vám pomůže rovněž. Obsahuje totiž **@font-face generator**, kam můžete nahrát soubory s fonty a vygeneruje vám shora určený balíček. Ani v tomto případě se nemůžete spolehnout na výchozí nastavení a musíte klepnout na rozšířené volby (*expert*) a vypnout či správně nastavit subsetting a formáty.

## Krok třetí: Správné nastavení IIS

Aby font embedding fungoval, musíte nahrát EOT/WOFF/TTF soubory na svůj web server. Drobná zákeřnost nicméně tkví v tom, že IIS ve výchozím nastavení přípony *.woff* a *.eot* nezná a jako takové tyto soubory z bezpečnostních důvodů odmítne browseru poslat, vyhodí chybu 404, i když soubor existuje. Aby vkládání fontů fungovalo, je nutné tyto přípony zaregistrovat. U IIS 7.x se to dělá v souboru *web.config* následující definicí:

    <configuration>
        <system.webServer>
            <staticContent>
                <remove fileExtension=".ttf" />
                <remove fileExtension=".eot" />
                <remove fileExtension=".woff" />
                <mimeMap fileExtension=".eot" mimeType="application/vnd.bw-fontobject" />
                <mimeMap fileExtension=".ttf" mimeType="application/x-font-ttf" />
                <mimeMap fileExtension=".woff" mimeType="application/x-woff" />
            </staticContent>
        </system.webServer>
    </configuration>

## Krok čtvrtý: Nastavení CSS

Součástí balíčku staženého z Font Squirrel je i soubor *stylesheet.css*, který obsahuje stylopis, který musíte přidat do svého CSS souboru, typicky na začátek. Vypadá nějak takto (pro demo jsem použil písmo [Bebas Neue](http://www.fontsquirrel.com/fonts/Bebas-neue)):

    @font-face {
        font-family: 'BebasNeueRegular';
        src: url('BebasNeue-webfont.eot');
        src: url('BebasNeue-webfont.eot?#iefix') format('embedded-opentype'),
             url('BebasNeue-webfont.woff') format('woff'), 
             url('BebasNeue-webfont.ttf') format('truetype');
        font-weight: normal;
        font-style: normal;
    }

Tato relativně složitá konstrukce zajišťuje, že se pro každý prohlížeč stáhne ten správný formát. Jakmile ji jednou máte, můžete v dalším stylopisu normálně používat zaregistrovaný název fontu, zde *BebasNeueRegular*. Je žádoucí i v tomto případě specifikovat "fallback" fonty, aby v případě nefunkčnosti embeddingu (prohlížeč nepodporuje, došlo k chybě při přenosu…) byla stránka zobrazena alespoň přibližně použitelně. Bebas je úzký, bezpatkový font, kterému je z těch běžných nebližší Impact. Pokud bychom chtěli všechny nadpisy první úrovně psát tímto písmem, můžeme zadat následující styl:

    h1 {
        font-family: BebasNeueRegular, Impact, Arial, Helvetica, sans-serif;
        font-size: 30pt;
        font-weight: normal;
    }

Obsah všech **<H1>** bude nyní zobrazen vloženým písmem.

## Krok pátý: Více řezů písma

Většina návodů končí u předchozího bodu, což je perfektně postačující ve chvíli, kdy potřebujete používat vložené písmo jenom na nadpisy nebo prostě výjimečně a v jednom jediném řezu (proto jsem ve výše uvedeném demu nastavil *font-weight: normal*, protože H1 je standardně tučně). Ale co když chcete používat i takové věci jako tučné (nebo naopak "lehké") písmo, kurzívu, případně jejich kombinace? 

[![Rodina písem Anonymous Pro](https://www.cdn.altairis.cz/Blog/2011/20111210-font-anonymous_thumb.png "Rodina písem Anonymous Pro")](https://www.cdn.altairis.cz/Blog/2011/20111210-font-anonymous_2.png)

Browser si poradí: písmo uměle "ztuční" nebo "skloní". Což je ovšem zpravidla velmi ošklivé a působí to ohavně a neprofesionálně. Některá písma se vyskytují ve více variantách, speciálně vytvořených pro tučné písmo, kurzívu atd. Typicky se jedná o písma, kterým se říká "chlebová", určená jako základní pro hlavní text, nejenom pro nadpisy. Příkladem takového písma z nabídky Font Squirrel je třeba zajímavé neproporcionální písmo [Anonymous Pro](http://www.fontsquirrel.com/fonts/Anonymous-Pro), které je k dispozici ve čtyřech řezech: základní, tučné, kurzíva, tučná kurzíva.

Pokud si stáhnete @font-face kit, budou v CSS souboru tyto varianty zaregistrované pod samostatnými názvy, např. *AnonymousProRegular*, *AnonymousProBold* atd. Nebude mezi nimi žádný vztah. Pokud použijete jako základní písmo *AnonymousProRegular* a potom ho ztučníte, nepoužije se správný tučný řez, ale prohlížeč bude interpolovat.

Řešení ovšem existuje, v podobě následujícího zápisu (ve kterém jsem pro přehlednost nechal jenom odkaz na *.eot* formát pro Internet Explorer, v praxi byste opět použili výše uvedenou konstrukci):

    @font-face {
        font-family: 'AnonymousPro';
        src: url('Anonymous_Pro-webfont.eot');
        font-weight: normal;
        font-style: normal;
    }
    @font-face {
        font-family: 'AnonymousPro';
        src: url('Anonymous_Pro_I-webfont.eot');
        font-weight: normal;
        font-style: italic;
    }
    @font-face {
        font-family: 'AnonymousPro';
        src: url('Anonymous_Pro_B-webfont.eot');
        font-weight: bold;
        font-style: normal;
    }
    @font-face {
        font-family: 'AnonymousPro';
        src: url('Anonymous_Pro_BI-webfont.eot');
        font-weight: bold;
        font-style: italic;
    }

Pod totožným názvem (*AnonymousPro*) jsme zaregistrovali čtyři různé fonty a kombinací parametrů *font-weight* a *font-style* jsme určili, jaké řezy se mají v jednotlivých kontextech použít.

Některá písma mohou mít variant ještě mnohem více. Příkladem budiž třeba [Open Sans](http://www.fontsquirrel.com/fonts/open-sans), který má celkem deset verzí. Pět různých variant tučnosti (light, regular, semibold, bold, extra bold) a každá i v kurzívě. Zde se hodí, že vlastnost font-weight může kromě pojmenovaných hodnot (*normal*, *bold*) nabývat i číselné hodnoty od 100 do 900. Přičemž 100 je nejméně tučné písmo (v našem případě *light*), 400 normální duktus (*regular*), 700 tučný duktus (*bold*) a 900 nejtučnější možná varianta (*extra bold*). Mezilehlé hodnoty lze použít, pokud je variant ještě více, například bychom mohli použít 500 pro semibold.

Pokud bychom chtěli zaregistrovat všech 10 řezů, použili bychom následující obsáhlý styl (opět pro přehlednost jenom v *.eot*):

    @font-face {
        font-family: 'OpenSans';
        src: url("OpenSans-Light-webfont.eot");
        font-weight: 100;
        font-style: normal;
    }
    @font-face {
        font-family: 'OpenSans';
        src: url("OpenSans-LightItalic-webfont.eot");
        font-weight: 100;
        font-style: italic;
    }
    @font-face {
        font-family: 'OpenSans';
        src: url("OpenSans-Regular-webfont.eot");
        font-weight: 400;
        font-style: normal;
    }
    @font-face {
        font-family: 'OpenSans';
        src: url("OpenSans-Italic-webfont.eot");
        font-weight: 400;
        font-style: italic;
    }
    @font-face {
        font-family: 'OpenSans';
        src: url("OpenSans-Semibold-webfont.eot");
        font-weight: 500;
        font-style: normal;
    }
    @font-face {
        font-family: 'OpenSans';
        src: url("OpenSans-SemiboldItalic-webfont.eot");
        font-weight: 500;
        font-style: italic;
    }
    @font-face {
        font-family: 'OpenSans';
        src: url("OpenSans-Bold-webfont.eot");
        font-weight: 700;
        font-style: normal;
    }
    @font-face {
        font-family: 'OpenSans';
        src: url("OpenSans-BoldItalic-webfont.eot");
        font-weight: 700;
        font-style: italic;
    }
    @font-face {
        font-family: 'OpenSans';
        src: url("OpenSans-ExtraBold-webfont.eot");
        font-weight: 900;
        font-style: normal;
    }
    @font-face {
        font-family: 'OpenSans';
        src: url("OpenSans-ExtraBoldItalic-webfont.eot");
        font-weight: 900;
        font-style: italic;
    }

Vkládání písem je velmi mocný nástroj, který dokáže ozvláštnit webové stránky a není mnoho důvodů, proč jej opomíjet.