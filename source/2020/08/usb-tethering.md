<!-- dcterms:title = Zkuste to s drátem: USB tethering na Androidu -->
<!-- dcterms:abstract = Že se z telefonu z Androidem dá udělat Wi-Fi přístupový bod a připojit se z jiného zařízení, třeba PC, je všeobecně známo. Ale pomocí funkce USB Tethering, která je v Androidu standardně od verze 9.0, lze počítač připojit i pomocí USB kabelu, což má mnohé výhody. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:coverUrl = /cover-pictures/20200814-usb-tethering.jpg -->
<!-- x4w:coverCredits = Lucian Alexe via Unsplash.com -->
<!-- x4w:pictureUrl = /perex-pictures/20200814-usb-tethering.jpg -->
<!-- x4w:pictureCredits = Lucian Alexe via Unsplash.com -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = IT -->
<!-- dcterms:dateAccepted = 2020-08-14 -->

Že se z telefonu z Androidem dá udělat Wi-Fi přístupový bod a připojit se z jiného zařízení, třeba PC, je všeobecně známo. Ale pomocí funkce USB Tethering, která je v Androidu standardně od verze 9.0, lze počítač připojit i pomocí USB kabelu, což má mnohé výhody.

Bezdrátové technologie dobývají svět a leckdo se na propojení kabelem dívá jako na relikt historie. Ale ve skutečnosti kus drátu ničím nahradit nelze. V tomto konkrétním scénáři má použití kabelu následující výhody:

* Vyšší spolehlivost, zejména v zarušeném prostředí.
* S tím může souviset i vyšší rychlost, kterou ale oceníte až v případě, že bude skutečně pořádně fungovat 5G.
* Vyšší bezpečnost, protože kabel se odposlouchává podstatně hůř než Wi-Fi.
* Telefon lze zároveň dobíjet.

## Jak na to?

> Poznámka: Následující postup platí pro čistý Android 9 a vyšší.

1. Nejprve propojte počítač s mobilem USB kabelem s příslušnými koncovkami.
2. Odemkněte mobil.
3. Ve výchozím nastavení se mobil z USB pouze nabíjí a nepřenáší data, což je indikováno notifikací _Charging this device via USB_. Klepněte na ni.

![](https://www.cdn.altairis.cz/Blog/2020/20200814-usb-tethering-1.jpg)

4. Z možností v následném dialogu si vyberte _USB tethering_:

![](https://www.cdn.altairis.cz/Blog/2020/20200814-usb-tethering-2.jpg)

Na počítači se vám narodí nový RNDIS síťový adaptér a počítač se přes něj připojí k Internetu. Na Windows to funguje bez problémů. Na běžných distribucích Linuxu by to mělo také fungovat (ale nezkoušel jsem) a na Mac OS X musíte předem nainstalovat [software jménem HoRNDIS](https://joshuawise.com/horndis). Nicméně na jiném OS než na Windows jsem to nezkoušel.

## Přejmenování síťového profilu

Ve výchozím nastavení Windows se bude toto síťové připojení jmenovat nějak jako _Network 2_. Pokud chcete nějaký lepší název (v mém případě _otg.altair.is_), není na to ve Windows žádné GUI, musíte na to jít pomocí Local Security Policy. Postup pro přejmenování profilu je následující:

![](https://www.cdn.altairis.cz/Blog/2020/20200814-usb-tethering-3.png)

1. Spusťte `secpol.msc`.
2. V levé části okna klepněte na _Network List Manager Policies_.
3. V pravé části pak poklepejte na název profilu.
4. V dialogovém okně pak nastavte nový název. Lze zde nastavit též zda síť bude chápána jako privátní nebo jako veřejná (a tedy jaká sada pravidel firewallu se na ni použije) a lze nastavit i ikonu, ale není mi známo, že by ji Windows 10 někde využily.

## Nastavení omezeného objemu dat

V realitě českého "sepecifického" mobilního trhu se hodí nastavit toto spojení jako datově omezené - "Metered connection".

![](https://www.cdn.altairis.cz/Blog/2020/20200814-usb-tethering-4.png)

Přejděte ve Windows do _Settings_ > _Network & Internet_ > _Ethernet_. Pak poklepejte na příslušné připojení a zaškrtněte _Set as metered connection_. Tím bude připojení označeno jako datově omezené a aplikace to mohou (ale nemusejí) brát v potaz. Například Outlook a OneDrive se na takovém spojení nebudou automaticky aktualizovat -- aktualizaci musíte explicitně povolit.