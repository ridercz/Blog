<!-- dcterms:title = Jak zastavit robotické depo Zásilkovny: Hardware -->
<!-- dcterms:abstract = V minulém videu jsem vám představil robotické depo Zásilkovny a svůj úkol: vytvořit tlačítko, které při stisku dokáže přes Wi-Fi kontaktovat řídící backend a roboty zastavit. Ve druhém pokračování si ukážeme, jaký hardware jsem pro projekt Z-Button zvolil a proč. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20211126-robodepo-2.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20211126-robodepo-2.jpg -->
<!-- x4w:category = Z-TECH -->
<!-- x4w:category = IT -->
<!-- x4w:category = Bastlení -->
<!-- dcterms:dateAccepted = 2021-11-26 -->

V [minulém videu](https://www.altair.blog/2021/11/robodepo-1) jsem vám představil robotické depo Zásilkovny a svůj úkol: vytvořit tlačítko, které při stisku dokáže přes Wi-Fi kontaktovat řídící backend a roboty zastavit. Ve druhém pokračování si ukážeme, jaký hardware jsem pro projekt Z-Button zvolil a proč.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/7rJuuVYUSQE" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

## Použitá platforma

Potřebou je Wi-Fi konektivita a schopnost udělat HTTP (resp. HTTPS) dotaz. Kromě toho potřebujeme jenom jeden GPIO port pro připojení tlačítka. Pro řešení zadání tohoto typu jsou v zásadě dvě možné cesty. V té první se použije počítač s Linuxem, typicky něco malého s ARM, v duchu Raspberry Pi, třeba [Zero 2](https://www.altair.blog/2021/11/dotnet-raspi-5), o kterém byla řeč nedávo. V té druhé se použije mnohem jednodušší a omezenější mikrokontroler.

Pro tento problém jsem zvolil cestu mikrokontroleru. Je to mnohem jednodušší a levnější varianta, počítač s Linuxem je na obsluhu jednoho tlačítka a jednoho HTTP requestu skutečně zbytečně moc. Použití počítače by vyřešilo jediný problém: ověření certifikátu serveru. Nicméně za hodně vysokou cenu. Ani ne tak finanční, jako organizační. Bylo by třeba sofistikovaně řešit deployment, zabezpečení, aktualizace... Proto jsem se rozhodl pro druhou cestu a zabezpečení komunikace vlastními prostředky (o tom bude další díl seriálu).

![Wemos D1 Mini](https://www.cdn.altairis.cz/Blog/2021/20211126-d1mini.jpg)

Rozhodl jsem se použít procesor (nebo spíše SoC, system on chip) **ESP8266** na vývojové desce **Wemos D1 Mini**. Bastlířům není třeba ESP8266 nijak extra představovat. Je to stejná platforma, na které jsem postavil svůj projekt HoneyESP a v [článku o něm](https://www.altair.blog/2018/11/honeyesp) je odkaz na mou přednášku, kde mluvím i o hardware.

Ve zkratce: ESP8266 nabízí 32-bitový RISC procesor běžící na 80 MHz, až 16 GPIO pinů, SPI, I2C, 2x UART a hlavně podporu pro 2,4 GHz Wi-Fi /IEEE 802.11 b/g/n). Dá se programovat v mnoha jazycích, mimo jiné jako Arduino v C, což je přesně to, co budu dělat.

Tento modul k činnosti potřebuje nějaké podpůrné obvody, třeba řízení napájení a podobně. Buďto bych si musel navrhnout vlastní desku (což za prvé neumím a za druhé se to pro tak malý počet zařízení nevyplatí) anebo musím použít nějakou hotovou. Vývojových desek nad ESP8266 je spousta, se všemi možnými parametry. Asi nejmenší z nich se jmenuje Wemos D1 mini. Je snadno dostupná, stojí v Číně desetikoruny, mám jich plný šuplík a hlavně - je maličká, což se mi bude hodit.

## Tlačítko a krabička

![První prototyp](https://www.cdn.altairis.cz/Blog/2021/20211126-prototyp.jpg)

Trochu paradoxně (ale zdaleka ne výjimečně) bude mechanická část (tlačítko s krabičkou) dražší než vlastní elektronika. První prototyp (vycházející ještě z poněkud jiného zadání a mající vlastní napájení v podobě baterií) jsem dal do běžné elektroinstalační krabičky, kam jsem nainstaloval jakési malé tlačítko, které se mi válelo v šuplíku (mám v šuplících _spoustu_ nejrůznějších tlačítek).

![Box od Schneider Electric](https://www.cdn.altairis.cz/Blog/2021/20211126-box-schneider.jpg)

Další prototyp byl od Schneider Electric. To je známá firma vyrábějící kvalitní zboží. Také bohužel drahé, krabička s tlačítkem vyjde skoro na tisícovku. A co je horší, uvnitř není moc místa. Což je pochopitelné, protože do krabiček tohoto typu se obvykle nic nemontuje, jenom se tam natáhne kabel, který se připojí k tlačítku. Nicméně já tam potřebuju schovat i tu desku D1 mini.

![Box z GME](https://www.cdn.altairis.cz/Blog/2021/20211126-box-gme.jpg)

Nakonec si mé srdce získal jednodychý noname box z GM Electronic. Sice nemá tak sexy design, ale je výrazně levnější (celé řešení stojí několik stokorun) a v krabičce je více místa, kam se pohodlně vejde D1 mini i USB konektor.

## Mechanické provedení

Celou dobu je řeč o stop tlačítku, ale součástí zadání je i varianta s několika tlačítky, která dokáže roboty třeba znovu rozběhnout a podobně. Naštěstí se ovládací skříňky dělají v mnoha vícetlačítkových variantách a celý systém je modulární, takže je možné kombinovat mezi sebou různé varianty a barvy tlačítek a podobně.

Elektrické zapojení je jednoduché. Tlačítko se zapojí mezi GPIO pin a zem. Na D1 mini jsem se rozhodl použít vstupy `D5` až `D7`:

* `D5` - stop (červená), NC
* `D6` - žlutá, NO
* `D7` - zelená, NO

Tlačítka se vyskytují ve variantách _NO_ (normally open, tlačítko je normálně rozpojené a stiskem se kontakty spojí) a _NC_ (normally closed, tlačítko je normálně spojené a stiskem se rozpojí). Moje řešení počítá s tím, že stop tlačítko bude NC (protože obvykle bývají) a ostatní budou NO. Ale protože se vše vyhodnocuje softwarově je to vlastně jedno, případná změna si vyžádá jednu řádku v kódu.

Napájel jsem tedy krátké drátky do desky a zašrouboval je do šroubovacích kontaktů tlačítek.

## Vývod kabelu

Paradoxně největším problémem byla průchodka pro USB kabel, protože běžná řešení nepočítají s tím, že z boxu povede tak tenký kabel (běžně se používají mnohem silnější). Vyřešil jsem to tím, že jsem si [vymodeloval vlastní průchodku](https://www.altair.blog/2021/10/pruchodka) a vytiskl ji na 3D tiskárně. To se ale nakonec ukázalo zbytečné, protože jsem našel průmyslově vyráběný model, který splnil všechny mé požadavky.
