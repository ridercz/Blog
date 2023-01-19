<!-- dcterms:title = Novinky v projektu HoneyESP: Podpora ESP32 a nepotřebujete SD kartu -->
<!-- dcterms:abstract = Před časem jsem zde na blogu představil projekt HoneyESP - falešné AP pro sociálně inženýrské útoky za stovku. Od té doby jsem ho vylepšil. Obejde se bez SD karty a nově je podporován i na deskách s čipem ESP32, který je nástupcem ESP8266. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20190228-honeyesp32.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureCredits = Product picture by Expressif Systems -->
<!-- x4w:coverUrl = /cover-pictures/20190228-honeyesp32.jpg -->
<!-- x4w:coverCredits = Product picture by Expressif Systems -->
<!-- x4w:category = Software -->
<!-- x4w:category = Bezpečnost -->
<!-- x4w:category = Bastlení -->
<!-- dcterms:date = 2019-02-28 -->

Před časem jsem [zde na blogu představil](/2018/11/honeyesp) projekt HoneyESP - falešné AP pro sociálně inženýrské útoky za stovku. Od té doby jsem ho vylepšil. Obejde se bez SD karty a nově je podporován i na deskách s čipem ESP32, který je nástupcem ESP8266.

## Nově bez SD karty

Původně představená veze vyžadovala SD kartu, na níž byl uložen obsah web serveru a kam se také ukládala nastavení a nalovená hesla. Nyní je k dispozici i verze, která paměťovou kartu nepotřebuje. K ukládání dat využívá SPI flash paměť, která je přímo součástí čipu.

Výhodou tohoto řešení je, že celé řešení je jednodušší a levnější. Stačí vám doslova jakákoliv deska a napájení. Není třeba používat speciální desku se čtečkou karet nebo řešit propojení samostatné desky z hlavní.

Toto řešení má samozřejmě i nevýhody. Nahrávání dat do flash paměti je poněkud komplikovanější, nestačí jenom změnit soubory na SD kartě. Také je k dispozici méně paměti (v závislosti na konkrétní variantě čipo typicky 4, 8 nebo 16 MB), ale to zpravidla není problém, protože stejně potřebujeme řádově maximálně stovky kilobajtů.

## Podpora pro ESP32

Nástupcem populárního ESP8266 je čip jménem ESP32. Umí všechno co jeho starší bratříček, ale ještě mnoho věcí navíc. Má vestavěnou podporu pro Bluetooth, celou řadu dalších protokolů a rozhraní a je výkonnější.

HoneyESP v tomto okamžiku rozšířených možností nového čipu využít nepotřebuje. Nicméně může na něm běžet, což může být užitečné, protože desky s ním často mívají například vestavěnou podporu pro nabíjecí baterie a další podobné užitečnosti.

Varianta využívající SPIFFS je nyní naprogramovaná tak, že [běží jak na starším ESP8266 tak na novějším ESP32](https://github.com/ridercz/HoneyESP/wiki/ESP32_Notes). Varianta využívající SD kartu zatím ESP32 nepodporuje. Důvodem je, že se mi nějak nedaří rozběhnout práci s SD kartami.

## Plány do budoucna

Do budoucna bych rád vytvořil jedinou univerzální verzi, která bude podporovat (pomocí patřičných direktiv) jak SD kartu tak SPIFFS a to na obou platformách. Dále pak plánuji možnost definovat několik variant portálu a SSID, mezi kterými bude možné se přepínat a také možnost ovládat celý systém přes webové rozhraní.

## Download

**Projekt HoneyESP najdete [na mém GitHubu](https://github.com/ridercz/HoneyESP/).** Tamtéž je k dispozici i dokumentace [v podobě wiki](https://github.com/ridercz/HoneyESP/wiki).

Software je open source, licencován pod [MIT licencí](https://github.com/ridercz/HoneyESP/blob/master/LICENSE). Budu rád, pokud se zapojíte do vývoje a pošlete mi třeba nějaký pěkný pull request.