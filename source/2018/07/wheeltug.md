<!-- dcterms:title = Divný hardware z mojí dílny - ovládání HDMI switche a kvadrátoru-->
<!-- dcterms:abstract = Po většinu své programátorské kariéry píšu "divné programy" - obvykle různé bezpečnostní podivnosti, na které si běžní smrtelníci netroufají. Na stará kolena jsem začal tvočit i "divný hardware" - různé specialitky, které se nedají koupit nebo velmi draho. Do téhle kategorie patří i ovládání HDMI switche pro projekt leteckého simulátoru. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20180719-wheeltug.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = Arduino -->
<!-- x4w:category = Bastlení -->
<!-- dcterms:date = 2018-07-19 -->

Po většinu své programátorské kariéry píšu "divné programy" - obvykle různé bezpečnostní podivnosti, na které si běžní smrtelníci netroufají. Na stará kolena jsem začal tvočit i "divný hardware" - různé specialitky, které se nedají koupit nebo velmi draho. Do téhle kategorie patří i ovládání HDMI switche pro projekt leteckého simulátoru.

Můj kamarád Horác taky dělá divné věci. Už léta. Toho času pracuje pro společnost WheelTug, která vyrábí elektricky poháněný přední podvozek pro letadla. Proudové letadlo je s ním schopno pojíždět bez použití vlastních motorů, což šetří palivo, životní prostředí a především peníze. Horác vyrábí simulátor, na kterém si piloti na modelu letadla mohou vyzkoušet, jak se WheelTug ovládá a pracuje se s ním. Celé to vypadá nějak takhle:

<video controls="controls" poster="https://www.cdn.altairis.cz/Blog/2018/20180719-wheeltug.png">
    <source src="https://www.cdn.altairis.cz/Blog/2018/20180719-wheeltug.mp4" type="video/mp4" />
    <source src="https://www.cdn.altairis.cz/Blog/2018/20180719-wheeltug.webm" type="video/webm" />
    <source src="https://www.cdn.altairis.cz/Blog/2018/20180719-wheeltug.ogg" type="video/ogg" />
    <p>Nepodařilo se přehrát video. Můžete si ho stáhnout jako:</p>
    <ul>
        <li><a href="https://www.cdn.altairis.cz/Blog/2018/20180719-wheeltug.mp4">MP4</a></li>
        <li><a href="https://www.cdn.altairis.cz/Blog/2018/20180719-wheeltug.webm">WEBM</a></li>
        <li><a href="https://www.cdn.altairis.cz/Blog/2018/20180719-wheeltug.ogg">OGG</a></li>
    </ul>
</video>

Součástí emulátoru je i několik kamer a je potřeba je mezi sebou různě přepínat, pomocí tlačítek. A zařídit to, to byl můj úkol. Běžně se prodává zařízení, které umožňuje přepínat několik vstupů, nebo je sloučit do jednoho - třeba video ze čtyř zdrojů naskládá na jednu obrazovku. Problém je, že tato zařízení mají svoje vlastní dálkové ovládání a v rozumné cenové kategorii se nepočítá s jejich programovým řízením.

Vyrobil jsem něco, čemu interně říkám "Rube Goldberg's HDMI Switch" a přestože je to řešení poněkud obskurní, je spolehlivé, univerzální a vesměs funkční.

## Jak na dálkové ovládání a Arduino

S mikrokontrolerem typu Arduino je poměrně snadné být ovládán nebo ovládat jiné zařízení za pomoci klasického infračerveného dálkového ovládání. Potřebujete k tomu jenom IR LEDku (na vysílání) nebo IR čidlo (na příjem, v mém případě šlo o `TSOP4838`).

Problém jsem tedy vyřešil tak, že jsem vytvořil zařízení, které se "naučilo" signál originálního dálkového ovládání a pak ho na základě stisku příslušného tlačítka umělo zase přehrát.

Infračervené dálkové ovládání funguje trochu jako morseovka. Ovladač zabliká pulzy v určité sestavě a zařízení je dekóduje a zachová se podle toho. Jednotlivých norem je celá řada, naštěstí existuje pro Arduino knihovna `IRemote`, se kterou je to snadné.

## Mechanické uspořádání

Navrhl jsem a na 3D tiskárně vytiskl držák, do kterého se zeshora zasune hotový switch a přesně proti jeho IR snímači je umístěna IR LED (na následujícím obrázku vpravo, je vidět 2x červená izolace):

![](https://www.cdn.altairis.cz/Blog/2018/20180719-rghdmi-1.jpg)

O řízení se stará Arduino Nano. Šlo by použít i menší a levnější Pro Mini, ale použil jsem Nano, protože to má vestavěný USB převodník a kdyby bylo třeba ho v terénu přeprogramovat, bude to snazší. To je ta malá destička na fotce úplně vpravo.

Dále bylo potřeba vyřešit napájení. Naštěstí Arduino je z hlediska napájení poměrně tolerantní a má malý odběr, takže jsem použil původní zdroj k HDMI switchi a jenom jsem si udělal odbočku - na obrázku vlevo.

Paradoxně nejkomplikovanější byly kabely a konektory. Ovládací rozhraní má osm tlačítek pro různé kombinace kamer a další funkce. Nechtěl jsem řešit nějaký multiplexing, protože se vše povede dlouhým kabelem v zarušeném prostředí a muselo to fungovat na první pokus, nebyl čas na ladění.

![](https://www.cdn.altairis.cz/Blog/2018/20180719-rghdmi-2.jpg)

Takže jsem potřeboval (nejméně) devítipinový konektor a kabel. A to pokud možno nějaký univerzální, který se dá snadno kdekoliv koupit, kdyby selhal. Plus další požadavek z konstrukčních důvodů zněl, že konektory musejí být šroubovací. Nakonec jsem použil klasické DB9 konektory a kabely, používané pro klasické sériové porty (RS-232).

![](https://www.cdn.altairis.cz/Blog/2018/20180719-rghdmi-3.jpg)

Na posledním obrázku vidíte hotové řešení. Ovládací konzole s osmi tlačítky je viditelně namontována na simulátoru (na videu je vidět jako černá krabička s nápisem WHEELTUG VISION). Držák je schovaný uvnitř konstrukce.

V době psaní tohoto článku je simulátor v provozu na velké letecké výstavě v Londýně a funguje dle zpráv bez problémů.

- - -

Řada lidí se na Arduino a podobné "hračky" dívá pohrdlivě a posmívá se jim. Je pravda, že mnohé konstrukce mají k praktičnosti daleko. Nicméně v tomto případě se mi díky Arduinu a pár laciným součástkám podařilo během velmi krátké doby vyřešit reálný konstrukční problém ke spokojenosti zadavatele.

Pokud máte nějaký zajímavý technický problém tohoto typu, rád ho pomohu vyřešit i vám.
