<!-- dcterms:identifier = aspnetcz#163 -->
<!-- dcterms:title = Čárové kódy na webu: Vlastní použití -->
<!-- dcterms:abstract = V minulém článku jsem se zabýval teoretickými aspekty použití čárových kódů na webu. Ve druhém pokračování se podíváme na praktickou stránku věci, tedy jak kódy reálně generovat a použít. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = IT -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- np9:serialId = 3 -->
<!-- x4w:serial = Čárové kódy na webu -->
<!-- dcterms:created = 2007-08-16T11:00:20+02:00 -->
<!-- dcterms:dateAccepted = 2007-08-16T11:00:20+02:00 -->

V minulém článku jsem se zabýval teoretickými aspekty použití čárových kódů na webu. Ve druhém pokračování se podíváme na praktickou stránku věci, tedy jak kódy reálně generovat a použít.

## Vytváření kódů

### Fonty na straně klienta

Některé kódy jsou atomické. To znamená, že konkrétní znak se vždy zakóduje stejným způsobem, bez ohledu na to, jaké další znaky ho obklopují. Lze tedy vytvořit font, kterým stačí napsat požadovaný text a máte vystaráno. Typickým případem takového kódu je Code39. Lze stáhnout fonty, v nichž stačí napsat např. **1234ABCDE** (hvězdička reprezentuje počáteční a koncovou sekvenci) a výsledkem bude platný čárový kód. Příkladem jsou např. fonty pro [Code39](http://www.codeware.cz/?lang=cze&oid=200) ke stažení na webu společnosti [CodeWare](http://www.codeware.cz/). 

To je nejsnazší způsob, jak generovat čárové kódy v desktopových aplikacích, ale na webu se příliš použít nedá. Vyžaduje totiž aby ten, kdo bude kódy tisknout, měl v systému nainstalovaný požadovaný font. Což u běžných uživatelů zajistit nelze a i v případě omezené skupiny uživatelů je to organizačně náročné.

Existují sice možnosti, jak prohlížeči naznačit, aby si požadovaný font stáhl, ale font embedding se mi zatím nepodařilo nikdy rozchodit k mé plné spokojenosti, protože je v různých prohlížečích implementován různě. Dále pak je nutné fonty konvertovat do speciálního formátu, nastávají problémy s právy a podobně.

### Fonty na straně serveru

Řešením je nespoléhat se na podporu na straně klienta a kód mu poslat jako obrázek, dynamicky vygenerovaný na straně serveru. Na server můžeme font nainstalovat snáze, navíc se dá za určitých okolností použít i bez instalace (tímto tématem se podrobněji zabývá například [článek na CodeProjectu](http://www.codeproject.com/cs/webservices/wsbarcode.asp)).

Ani toto řešení se mi ale nepodařilo rozchodit k mé plné spokojenosti. Je třeba na můj vkus příliš laborovat s antialiasingem a velikostí písma, rovněž máte malou kontrolu nad celkovou velikostí výsledného kódu a použití neinstalovaných fontů není právě paměťově efektivní.

### Ruční generování obrázku

Nakonec jsem se vydal jinou cestou, a to generováním obrázku kódu "čáru po čáře". To je také jediná metoda, která se dá použít i na fonty, které nejsou atomické, jako je např. EAN nebo Code 25 Interleaved.

Existuje poměrně hodně komponent, které toto nabízejí. Komerční komponenty mi přišly příliš drahé a komplikované, našel jsem i pár volně dostupných, ale ty zase nefungovaly příliš spolehlivě. Nakonec se ukázalo, že implementace čárových kódů vlastními silami není nijak náročná.

Specifikace jsou volně dostupné - obvykle stačí zadat do Google něco jako "názevkódu specification" a doberete se výsledku. Případně se můžete obrátit na server [OpenBarcode](http://www.openbarcode.org/), který je této problematice celý věnován.

Trváte-li na zdrojích v češtině, doporučuji knihu *Čárové kódy - automatická identifikace (A. Benadiková, Š. Mada, S. Weinlich, Grada 1994, ISBN 80-85623-66-8)*. Bohužel ale tato kniha vyšla před mnoha lety a budete možná mít problém ji sehnat (.

Mně osobně trvalo vytvoření základu komponenty s první implementovanou normou asi jeden den. Přidání dalších norem čárových kódů je pak práce na několik hodin. Pokud si je chcete ušetřit, pošlete mi mail a můžeme se dohodnout na prodeji ;-)

## Načítání kódů

K načítání čárových kódů potřebujete čtečku. Vyrábí se jich celá řada a různých provedeních. Pro webové aplikace budou asi nejvhodnější ruční čtečky, které se připojují buďto přes rozhraní PS/2 (mezi počítač a klávesnici) nebo přes USB. Ty umějí emulovat klávesnici, takže když přečtete kód, efekt je stejný, jako byste ho ručně opsali. Čtečky obvykle umějí před vlastním kódem nebo za ním vyslat naprogramovanou sekvenci znaků - typicky např. načtou kód a simulují stisk klávesy ENTER. Stačí tedy kurzor ručně nebo programově (viz ASP.NET a např. vlastnost *DefaultFocus*) nastavit do odpovídajícího pole a je vystaráno.

Pro desktopové aplikace je vhodnější komunikovat se čtečkou přímo (pak neinterferuje s použitím klávesnice), ale to u webové aplikace není možné.

Ruční čtečky se vyskytují ve dvou zásadních variantách: laserové a s CCD snímačem. CCD čtečky jsou levné (ceny začínají řádově mezi 1200-2000 Kč). Kódy neumějí číst na příliš velkou vzdálenost, řádově v jednotkách centimetrů, počítejte spíš s tím, že je nutné je fyzicky přiložit k papíru. Mají obvykle dost omezenou maximální šířku kódu, který umějí přečíst. Laserové čtečky jsou dražší (nejlevnější stojí cca. 3-5000 Kč), ale dokáží číst kódy na mnohem větší vzdálenost. Mohou být třeba pevně namontované na stojánku a kód stačí k nim přiblížit.

## Praktické zkušenosti

Načítání kódů samo o sobě je velice rychlé a technicky nenáročné. Ruční čtečku můžete připojit k jakémukoliv počítači i notebooku. Problém může nastat pouze máte-li PS/2 čtečku a notebook, který už PS/2 porty nemá. Nejsou potřeba žádné zvláštní ovladače ani SW. S dobře napsanou aplikací dokážte snímat kódy rychlostí zhruba jeden za sekundu.

Doufám, že se mi podařilo zodpovědět většinu běžných otázek. Máte-li další, můžete se na mne obrátit e-mailem nebo v komentářích k článku.