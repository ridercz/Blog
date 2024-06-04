<!-- dcterms:title = Zvu vás na IoT workshop pro .NET programátory -->
<!-- dcterms:abstract = IoT hype je za námi a je tedy čas se jím začít seriózně zabývat. Připravil jsem pro vás workshop o programování mikrokontrolerů, ale hlavně o tom, jak je využít v běžné praxi a propojit je s "velkými" .NET aplikacemi. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20240604-iot-workshop.jpg -->
<!-- x4w:coverUrl = /cover-pictures/20240604-iot-workshop.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = IT -->
<!-- x4w:category = Akce a události -->
<!-- dcterms:date = 2024-06-04 -->

Internet of things (IoT) úspěšně překonal svou hype fázi a nyní se postupně dostáváme do situace, kdy to začíná být k něčemu dobré a je na čase začít to brát vážně. Proto jsem pro vás připravil workshop, který se tohoto tématu týká.

> Stručně: Workshop se bude konat dne 20. 6. 2024 v Praze; pořádá ho počítačová škola Gopas. Jeho cena je 4990 Kč a objednat si ho můžete [na webu Gopasu](https://www.gopas.cz/workshop-altairovy-magicke-krabicky-aneb-hrajeme-si-s-iot_wamagbox).

## Komu je workshop určen

Cílová skupina jsou .NET programátoři, kteří se chtějí naučit programovat mikrokontrolery a propojit je se svými "velkými" aplikacemi v .NETu. Tutoriálů ve stylu "jak začít s Arduinem" je plný Internet, ale pokročilejší témata chybí. Navíc ve firemní praxi obvykle nestačí naprogramovat nějakou malou krabičku s procesorem, ale je ji třeba začlenit do většího systému, aby spolupracovala s existujícím softwarem a podobně.

Budu předpokládat, že máte základní znalosti programování v .NETu, že umíte napsat běžnou webovou nebo konzolovou aplikaci. Naopak se od vás neočekávají žádné předchozí znalosti programování mikrokontrolerů, elektroniky, pájení a drátování. Pokud je máte, nebudou vám překážet, ale mít je nemusíte.

Budete potřebovat jenom vlastní notebook s možností instalovat software (zejména Visual Studio Code a pluginy do něj). Všechno ostatní dostanete v ceně kurzu.

## Co se naučíte?

V první řadě vám ukážu základy obecného programování mikrokontrolerů. Nejprve vám ukážu použití vizuálního nástroje M5Flow, který sice působí trochu jako hračka pro děti, ale pro řadu scénářů je překvapivě dobře použitelný. Hlavně budeme ale používat [PlatformIO](https://platformio.org/). To je takové lepší Arduino IDE. To můžete použít taky, ale pokládám ho za dost omezené a pro již znalé programátory ne zcela pohodlné. Mnou představovaná platforma ESP32 se dá programovat i mnoha různými způsoby, pomocí jazyka Python, Lua, Rust a dokonce i v .NETu pomocí [.NET NanoFrameworku](https://www.nanoframework.net/), ale o tom možná někdy příště.

Pak se podíváme na to, jak propojit mikrokontroler s PC nebo serverovou aplikací:

* Lokálně, pomocí sériového portu nebo Bluetoothu. To se hodí ve chvíli, když potřebujete ke své lokálně bežící aplikaci přidat zařízení, které něco snímá nebo ovládá. Pomocí sériového rozhraní můžete komunikovat z .NETu, ale třeba i přímo z webového prohlížeče a naučit tak svou webovou aplikaci komunikovat s místním zařízením u uživatele.
* Po síti nebo přes Internet pomocí REST API. Schopnější mikrokontrolery mají podporu Wi-Fi nebo Ethernet rozhraní a můžete je připojit k síti. Jsou dostatečně schopné na to, aby uměly fungovat jako web server (se kterým může přímo komunikovat vaše aplikace) nebo jako klient (a vaší aplikace se budou ptát).
* Pomocí MQTT. To je protokol pro předávání zpráv pomocí front, hojně používaný (nejenom) v IoT světě. Nevyžaduje přímé propojení klienta a serveru, stačí když mají oba přístup k MQTT serveru. Ukážu vám, jak využít veřejné MQTT servery anebo jak si rozběhnout vlastní. Ukážu vám, jak s MQTT komunikovat z .NETu nebo přímo z webového prohlížeče.

**V důsledku se naučíte, jak propojit svět běžných (nejenom) webových aplikací se světem IoT a mikrokontrolerů. Můžete tak zařídit, že stisknutím tlačítka na webu se něco stane ve fyzickém světě, třeba se odemknou dveře. Nebo naopak, pokud se něco stane ve fyzickém světě, dozví se o tom váš server a může na to reagovat. Můžete tak malá a levná zařízení používat jako smysly a svaly a .NET jako mozek.**

## Jaké zařízení budeme používat

**V ceně workshopu dostanete M5Stack Core S3 a ENVIII senzor.** To obsahuje procesor (lépe řečeno SoC, system on chip) ESP32-S3. 

![M5Stack Core S3 a ENVIII senzor](/cover-pictures/20240604-iot-workshop.jpg)

ESP32 je řada čipů od společnosti Espressif, které jsou velmi populární jak pro hobby vývoj tak pro profesionální návrh zařízení. Existuje k nim výborná dokumentace a podpora pro řadu programovacích jazyků. Varianta [ESP32-S3](https://www.espressif.com/en/products/socs/esp32-s3) je v současnosti nejvýkonnější.

[M5Stack Core S3](https://docs.m5stack.com/en/core/CoreS3) je vývojový kit, který obsahuje řadu vstupních a výstupních zařízení a je součástí modulárního systému, kde můžete jednoduše propojit různé komponenty bez nutnosti něco pájet nebo laborovat se součástkami na breadboardu.

![M5Stack Core S3 + DIN Base](https://www.cdn.altairis.cz/Blog/2024/20240604-cores3.jpg)

* **MCU:** ESP32-S3@Xtensa LX7, 16MFLASH AND 8M-PSRAM, WIFI, OTG\CDC functions
* **Dotykvé LCD:** 2" 320*240 ILI9342C
* **Kamera:** GC0308, 0,3 mpix
* **Senzory:** Akcelerometr, gyroskop, magnetometr, proximity senzor; ENVIII modul obsahuje snímače teploty, tlaku a vlhkosti
* **Audio:** dva mikrofonní vstupy, zesilovač, reproduktor
* **Napájení:** přes USB-C konektor nebo souosý konektor 9-24 V, vestavěná baterie 500 mAh
* **Další:** Hodiny reálného času, čtečka MicroSD karet, základna k montáži na DIN lištu, rozšiřitelnost pomocí GPIO pinů, I2C, SPI a řada dalších

Tento vývojový kit představuje dobrý základ k tomu, abyste se mohli naučit programovat mikrokontrolery a nebyli omezováni tím, že vám něco chybí. Je na IoT svět relativně drahý (na RpiShopu stojí [1404 Kč](https://rpishop.cz/m5stack/6112-m5stack-cores3-esp32s3-lot-development-kit.html) + [156 Kč](https://rpishop.cz/498367/m5stack-env-iv-unit-se-senzorem-teploty-vlhkosti-a-tlaku-sht40-bmp280/) bez DPH), ale koncová zařízení jsou výrazně levnější (hotové vývojové desky lze koupit za cený v řádech desetikorun). U kitu platíte za pohodlnost a za možnost vyvíjet software bez nutnosti řešit hardware.

## Kdy a kde se bude workshop konat

> Pokud byste se workshopu rádi zúčastnili, ale v tomto termínu nemůžete, nezoufejte. Napište o svém zájmu mně nebo Gopasu. Pokud bude zájem, vyhlásíme další termín nebo najdeme nějaké jiné řešení.

* Kdy: **20. června 2024, 9-16 hodin**
* Kde: **Praha, Microsoft**, BB Centrum Delta, Vyskočilova 1561/4a, Praha 4
* Cena: **4990 Kč + DPH**, v ceně je hardware v ceně cca. 1600 Kč
* Pořádá: **Počítačová škola Gopas**
* **[Přihlašujte se na webu Gopasu](https://www.gopas.cz/workshop-altairovy-magicke-krabicky-aneb-hrajeme-si-s-iot_wamagbox)**

<iframe style="border:none" src="https://frame.mapy.cz/s/bupohupapo" width="100%" height="300" frameborder="0"></iframe>