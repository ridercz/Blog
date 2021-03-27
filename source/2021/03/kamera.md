<!-- dcterms:title = Nový život pro staré harampádí pomocí 3D tisku -->
<!-- dcterms:abstract = Včera jsem se dozvěděl, že budu dneska něco točit. V místě, kde nejspíš nebude dost světla. Z různého harampádí, které mám doma, jsem se rozhodl operativně vyrobit světlo pro kameru. Stačí 3D tiskárna a pár šroubů. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:coverUrl = /cover-pictures/20210327-kamera.jpg -->
<!-- x4w:pictureUrl = /perex-pictures/20210327-kamera.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = Bastlení -->
<!-- x4w:category = 3D tisk -->
<!-- dcterms:dateAccepted = 2021-03-27 -->

Včera jsem se dozvěděl, že budu dneska něco točit. V místě, kde nejspíš nebude dost světla. Z různého harampádí, které mám doma, jsem se rozhodl operativně vyrobit světlo pro kameru. Stačí 3D tiskárna a pár šroubů.

# S čím začínáme

<figure>
    <img src="https://www.cdn.altairis.cz/Blog/2021/20210327-kamera-01.jpg" alt="Zdrojový materiál" />
    <figcaption>Základem je bateriové LED světlo bez držáku a rozbitý "céčkový" držák na kameru a příslušenství.</figcaption>
</figure>

Našel jsem bateriové LED světlo pro natáčení a fotografování, které mám už dlouho, ale někde vzal za své držák (asi stativový), který na něm byl přidělaný. Zůstaly jenom čtyři díry pro šrouby v plastu. Budu tedy muset vymyslet způsob, jak světlo přidělat ke kameře.

Dále mám "céčkový" držák pro kameru a příslušenství. Mám malou HD kameru, se kterou se mi obtížně manipuluje, protože mám velké ruce. Tato konstrukce slouží ke stabilizaci a montáži příslušenství jako je třeba mikrofon a právě světlo. Držák mi ovšem už došel poškozený, má ulomenou jednu z plastových nožiček, takže nestojí rovně. A někde jsem poztrácel příslušenství, takže v místě, kam se má namontovat světlo, mikrofon a podobné věci, mám jenom díru.

<figure>
    <img src="https://www.cdn.altairis.cz/Blog/2021/20210327-kamera-02.jpg" alt="Díra v rukojeti" />
    <figcaption>V místě, kam se má namontovat světlo, mikrofon a podobné věci, mám jenom díru.</figcaption>
</figure>

Vymyslel jsem jak na to, ale budu potřebovat nějaké drobnosti, které dílem beru ze svých zásob a dílem vyrobím, zleva:

* Chybějící nohu nahradím tištěným dílem přichyceným stativovým šroubem. Ten je jedinou netriviálně získatelnou součástí celého buildu.
* Do rukojeti vsadím tištěný díl, který bude držen šroubem M6, podložkou a čtvercovou maticí. Má držák kompatibilní s GoPro systémem, který vyžaduje další šroub (tentokrát M5), čtverhrannou matici a pro pohodlí vytištěnou rukojeť na hlavu šroubu.
* Jednoduchý tištěný díl pro GoPro systém a dva nerezové šroubky 2,1&times;9,5 mm.

<figure>
    <img src="https://www.cdn.altairis.cz/Blog/2021/20210327-kamera-03.jpg" alt="Tištěné díly a spojovací materiál" />
    <figcaption>Tištěné díly a spojovací materiál.</figcaption>
</figure>

## Držák na světlo

<figure>
    <img src="https://www.cdn.altairis.cz/Blog/2021/20210327-kamera-04.jpg" alt="Hotové LED světlo" />
    <figcaption>Hotové LED světlo s GoPro kompatibilním držákem.</figcaption>
</figure>

Změřil jsem si rozteč děr pro šrouby a vymodeloval jednoduchý díl, který se ke světlu přišroubuje. Na druhém konci má mount kompatibilní se systémem akčních kamer GoPro (a mnoha jiných). Ten má tu výhodu, že využívá standardizovaný šroub M5, dobře se modeluje, dobře se tiskne a je kompatibilní s mnoha různými držáky, redukcemi podobně. Nebudu tedy vymýšlet kolo. 

<script src="https://gist.github.com/ridercz/e7859259ff24d20d94539818926d7f79.js"></script>

## Třetí noha pro držák kamery

<figure>
    <img src="https://www.cdn.altairis.cz/Blog/2021/20210327-kamera-05.jpg" alt="Třetí noha" />
    <figcaption>"Přebývající" hohu vepředu jsem uřízl a nahradil tištěným dílem.</figcaption>
</figure>

Zbývající nohu vepředu jsem uřízl a ze čtvernožky udělal torjnožku. Vymodeloval jsem jednoduchý díl, který se zespodu přišroubuje na stativový šroub (který v sobě sám má stativový závit, aby celá konstrukce šla nejenom držet v ruce, ale též přidělat na stativ).

<script src="https://gist.github.com/ridercz/929ff45e7e0ad8fe03013ebdcff15268.js"></script>

## Držák pro GoPro systém

<figure>
    <img src="https://www.cdn.altairis.cz/Blog/2021/20210327-kamera-06.jpg" alt="Držák příslušenství" />
    <figcaption>Do díry v rukojeti jsem přidělal vlastní tištěný díl.</figcaption>
</figure>

Třetí tištěný díl je nejsložitější (a i se nejhůře tiskne, je třeba použít podpory). Ve spodní části má zaoblený tvar, který zapadá do díry v rukojeti. Nad ním je plochá část, na které je protikus GoPro systému. Celé je to k rukojeti přiděláno pomocí šroubu M6 a čtvercové matice. Proč čtvercové? To se dozvíte za chvíli.

<script src="https://gist.github.com/ridercz/32c749bc0ed30b7872b96dc70724ad34.js"></script>

Originální GoPro systém používá uzavřené šestiúhelníkové matice M5. Já místo toho použiju obyčejnou čtvercovou matici. Ty uzavřené za prvé nemám a za druhé jako "captive nuts" při 3D tisku preferuji ty čtvercové proti šestiúhelníkovým. Šestiúhelník se tvarem blíží víc kruhu a zejména při malých průměrech má malou oporu v plastu a nemusí být snadné ho dostatečně utáhnout. Čtvercové matice se vzhledem ke svému tvaru neprotáčejí.

<script src="https://gist.github.com/ridercz/2655fc43e1c85762322a0b20eb56b9db.js"></script>

Vytiskl jsem si i knoflík na M5 šroub se šestihrannou hlavou, aby se dal povolit a utáhnout prsty. Parametrický model jsem pro tenhle účel dělal už dřív, takže stačilo změnit parametry na odpovídající délku šroubu.

<figure>
    <img src="https://www.cdn.altairis.cz/Blog/2021/20210327-kamera-07.jpg" alt="Hotová sestava" />
    <figcaption>Hotová sestava, světlo namontované na rukojeti.</figcaption>
</figure>

## Závěr

Na následující fotografii vidíte kompletní výsledek. Vzal jsem pár rozbitých a v podstatě bezcenných věcí a díky asi půlhodině modelování v OpenSCADu a dvěma hodinám tisku jsem vyřešil problém, který jsem měl. Řešení je navíc díky použití standardního GoPro držáku zcela univerzální. LED světlo mohu namontovat na cokoliv, co je určeno pro GoPro kamery a na rukojeť mohu namontovat cokoliv, co má odpovídající protikus.

Celé řešení by bylo ještě univerzálnější, kdyby mělo na druhé straně možnost uchycení přes klasický stativový šroub. To je ale docela problém, protože není metrický. Pro tenhle účel se používá šroub 1/4" s Withworthovým závitem, které se mi nedaří v ČR běžně sehnat. Dají se koupit ve foto speciálkách, ale jsou dost drahé a většinou ne v požadovaném rozměru. Jeden takový (krátký) šroub jsem už v konstrukci použil, tady by ale byl třeba delší.

Všechny plastové části jsou vytišteny z nového materiálu Nonoilen od společnosti Fillamentum, který testuji a budu o něm psát článek. Lze ale použít cokoliv. Podle mého soudu by stačilo běžné PLA, i když z důvodu vyšší pevnosti bych asi použil spíš PETG nebo ASA.

<figure>
    <img src="https://www.cdn.altairis.cz/Blog/2021/20210327-kamera-08.jpg" alt="Kompletní výsledek" />
    <figcaption>Kompletní výsledek.</figcaption>
</figure>