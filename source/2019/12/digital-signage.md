<!-- dcterms:title = Screenly OSE: Digital signage na Raspberry Pi jednoduše -->
<!-- dcterms:abstract = Reklamní a informační displeje všeho druhu - tomu se říká digital signage. Vytvářím teď jednu takovou věc pro svou veterinářku (resp. veterinářku mých psů, mne léčit nechce, že prej jsem antropomorfní) a zkoumal jsem, jak na to co nejsnáz. A objevil jsem projekt Screenly. V závěru článku najdete pozvánku na akci, kde se budu různému využití Raspberry Pi věnovat podrobněji. -->
<!-- x4w:category = Bastlení -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:date = 2019-12-27 -->
<!-- x4w:coverUrl = /cover-pictures/20191227-digital-signage.jpg -->
<!-- x4w:coverCredits = Omar Davis via Flickr, CC BY-ND -->
<!-- x4w:pictureUrl = /perex-pictures/20191227-digital-signage.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->

Reklamní a informační displeje všeho druhu - tomu se říká digital signage. Vytvářím teď jednu takovou věc pro svou veterinářku (resp. veterinářku mých psů, mne léčit nechce, že prej jsem antropomorfní) a zkoumal jsem, jak na to co nejsnáz. A objevil jsem projekt Screenly.

## Co je digital signage

Obrovské zlevnění displejů a související elektroniky vede k tomu, že LCD obrazovky najdete všude možně, i tam kde by dřív stačil list papíru. Pro účely tohoto článku definujme "digital signage" jako neinteraktivní zobrazení informací na displeji. Informace se ukazují samočinně, aniž by měl uživatel (divák) možnost to jakkoliv ovlivnit.

Digital signage mohou být reklamy, ale třeba i seznam odletů a příletů na letišti, zpravodajství nebo jakékoliv podobné informace, zpravidla v podobě obrázku, videa nebo webové stránky. Ve své nejjednodušší podobě to může být třeba powerpointová prezentace puštěná ve smyčce nebo něco takového.

Hledal jsem řešení, které bude co nejlevnější, snadno pochopitelné i pro laika a univerzální. Po hardwarové stránce bylo rozhodnuto - použiji Raspberry Pi, levný a jednoduchý ARM počítač s Linuxem a HDMI výstupem. K němu stačí jakýkoliv monitor nebo televize s digitálním vstupem.

Se softwarem to bylo o něco složitější. Moje původní myšlenka byla, že tam bude skutečně rotovat powerpointová prezentace, ale tento plán mi překazila skutečnost, že LibreOffice Impress, open source alternativa PowerPointu, mi každých pár minut padal, což se pro bezobslužný provoz příliš nehodí.

## Screenly a Screenly OSE

Specializovaných řešení pro digital signage na Raspberry Pi jsem našel několik. Nakonec jsem se rozhodl pro [Screenly OSE](https://www.screenly.io/ose/). Screenly (bez OSE) je komplexní placené řešení pro případ, že máte obrazovek hodně a potřebujete je spravovat centrálně a jednotně. Což není můj případ. Verze s přídavkem OSE (znamená _Open Source Edition_) toho umí méně, ale funguje bez nutnosti "cloudu" a je zadarmo.

Její schopnosti jsou pro naše případy více než dostačující:

* Umí zobrazovat obrázky (slideshow), video i webovou stránku.
* Pro každou položku lze nastavit libovolnou dobu zobrazení.
* Lze nastavit, kdy se má která položka ukazovat (např. nastavit, že se po určité době přestane zobrazovat neaktuální slide).
* Nevyžaduje připojení k Internetu (pokud nepoužijete živé webové stránky) a dokáže fungovat i zcela offline, pokud není potřeba obsah změnit.
* Veškeré nastavení, včetně nastavení obsahu, se provádí přes jednoduché webové rozhraní.
* Provisioning je velice jednoduchý.

## Jak funguje nastavení

Screenly OSE je přímo součástí prostředí NOOBS, takže ho lze automaticky stáhnout a nainstalovat přímo z výchozího setupu Raspberry Pi. Já jsem se nicméně vydal pro mne jednodušší cestou, totiž že jsem si stáhl přímo [aktuální image](https://github.com/Screenly/screenly-ose/releases) a pomocí [Rufusu](https://rufus.ie/) ho nahrál na paměťovou kartu.

Provisioning vyžaduje jenom připojení displeje a Wi-Fi, není třeba klávesnice a myš. Po prvním bootu se zařízení přepne do režimu Wi-Fi AP a na dipleji se ukáže název sítě a heslo. K AP se připojíte a přes webové rozhraní nastavíte, k jaké síti se má zařízení připojit. Mělo by to fungovat i přes drátovou síť bez nutnosti cokoliv nastavovat, ale to jsem nezkoušel.

Poté se lze připojit k webovému rozhraní. Jediné, co bych mu zásadně vytknul, je že ve výchozím nastavení není nijak chráněno, není třeba zadávat jméno a heslo a ochrana se musí explicitně zapnout:

![](https://www.cdn.altairis.cz/Blog/2019/20191227-digital-signage-settings.png)

Vlastní správa zobrazovaných dat ("assets") je jednoduchá. Stačí nahrát obrázky nebo video přes webové rozhraní, případně zadat webovou adresu. U videa je automaticky nastavena doba zobrazení na délku videa, u obrázků a webu lze zadat dobu v sekundách, po kterou se má daný asset zobrazovat.

![](https://www.cdn.altairis.cz/Blog/2019/20191227-digital-signage-assets.png)

U každého assetu je možné nastavit, jak dlouho má být aktivní - například abyste nedělali reklamu akci, která už skončila. Lze také nastavit, v jakém pořadí se mají motivy přehrávat.

![](https://www.cdn.altairis.cz/Blog/2019/20191227-digital-signage-date.png)

Ve výchozím nastavení je RasPi s výjimkou webového rozhraní úplně zavřené a z bezpečnostního hlediska tedy celá věc vychází docela dobře. Nic vám ovšem nebrání se k počítači připojit přes konzoli, zapnout možnost přístupu pomocí SSH a rozjet na něm cokoliv dalšího.

## Chcete vědět víc?

Podrobněji se budu vytváření digital signage a kiosků na bázi Raspberry Pi (apod.) věnovat v několika na sebe navazujících přednáškách na akci [TechFurMeet 2020](https://www.techfurmeet.org/), která se bude konat začátkem února. Co je to za akci, o tom jsem psal [před rokem](https://www.altair.blog/2019/01/jak-jsme-zviratka-naucili-pajet). 

Příští ročník TechFurMeetu se připravuje, ale [program](https://www.techfurmeet.org/cs/events) je už teď docela našlapaný. Moje témata budou:

* **Odroid GO** - open source platforma retro handheld herní konzole a jak pro ni vytvářet vlastní programy.
* **Příliš spořádaný svět, aneb Vesmír nehraje v kostky** - povídání o generování náhodných čísel s možností si vlastní elektronickou hrací kostku postavit.
* **.NET Core pro každého** - úvod do platformy .NET Core pro úplné začátečníky.
* **Digital Signage a kiosky pomocí Raspberry Pi** - na místě plánuji zprovoznit selfie kiosek s hodně zajímavým příslušenstvím.
* **OpenSCAD 2019.05: Co je nového?** - Dlouho očekávaná nová verze OpenSCADu přinesla řadu novinek, o kterých bude řeč. Všich účastníci TFM dostanou přístup do našeho eLearningového systému na školení 3D modelování v OpenSCADu.
* **Intranet of Things** - na IoT mi nejvíc vadí ten Internet. Jak si vyrobit chytrou domácnost bez nutnosti opustit bezpečí vnitřní sítě?

Tradičním hostem bude **Štěpán Bechynský**, který bude mluvit o nové tiskárně Prusa Mini a o tom, jak hlídat, že se nehýbe někdo, komu jste to zakázali, pomocí IoT platformy BigClown. Další položky programu jsou v jednání.

TFM není jenom pro furries, pokud vás obsah zajímá, neváhejte se [registrovat](https://www.techfurmeet.org/cs/reg).