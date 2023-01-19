<!-- dcterms:title = Kompletní průvodce ASP.NET na Raspberry Pi: Základní instalace -->
<!-- dcterms:abstract = Raspberry Pi je miniaturní počítač za pár korun, který pravidelným čtenářům tohoto blogu jistě nemusím představovat. A bez problémů na něm můžete spouštět aplikace napsané v .NETu, včetně webových aplikací v ASP.NET. Připravil jsem pro vás nový seriál, který vám ukáže, jak ASP.NET aplikaci na Raspberry rozchodit. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/logo-raspberry-pi.svg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20211015-dotnet-raspi-1.jpg-->
<!-- x4w:category = Z-TECH -->
<!-- x4w:category = IT -->
<!-- x4w:serial = ASP.NET na Raspberry Pi -->
<!-- dcterms:date = 2021-10-15 -->

Raspberry Pi je miniaturní počítač za pár korun, který pravidelným čtenářům tohoto blogu jistě nemusím představovat. A bez problémů na něm můžete spouštět aplikace napsané v .NETu, včetně webových aplikací v ASP.NET. Když jsem o .NETu na Raspberry [psal před šesti lety naposledy](https://www.altair.blog/serials/projekt-atropa), byla to ještě betaverze pod jménem ASPNET 5.

Od té doby se toho hodně změnilo (a zjednodušilo), takže jsem pro vás na kanálu Z-TECH připravil nový seriál, který vám ukáže, jak ASP.NET aplikaci na Raspberry rozchodit.

## Co budete potřebovat

* **Raspberry Pi** 2 nebo novější. Platforma .NET potřebuje k běhu procesory ARMv7 nebo novější a proto _nebude_ fungovat na prvním Raspberry Pi nebo na Raspberry Pi Zero a Zero W. Funguje - byť nepříliš rychle - na novém Zero 2.
* **Napájecí zdroj** s MicroUSB (RPi 3 a starší) nebo USB-C (RPi 4) konektorem, který dá alespoň 2 A, lépe 3 A.
* **MicroSD kartu** o velikosti 8 GB a větší. Také budete potřebovat patřičnou čtečku pro vaše PC a případně redukci z MicroSD na velkou SD. Redukce bývá u některých karet přímo součástí balení.

> Prodám (i jednotlivě) 2 ks Raspberry Pi 2 Model B V 1.1. Starší generace, ale na řadu věcí stále v pohodě stačí. Cena za kus 600 Kč. Zdarma přidám krabičku (jednu tištěnou na 3D tiskárně, jednu průmyslově vyráběnou). K odběru ihned na Praze 7 nebo kamkoliv přes Zásilkovnu za 65 Kč. V případě zájmu mě [kontaktujte](https://www.rider.cz/#contact).

Raspberry budeme instalovat jako server a ukážeme si variantu provisioningu, kdy nebudete potřebovat klávesnici, myš a monitor.

## Obsah seriálu

Celý proces jsem rozdělil do čtyř dílů, které postupně najdete každý čtvrtek na kanálu Z-TECH v [playlistu Raspberry Pi](https://www.youtube.com/playlist?list=PLFZurxJN0pMb5AlcI9vwBAEiI_V3hDCYa). Budeme nasazovat mou ukázkovou aplikaci [AskMe](https://github.com/ridercz/AskMe), ale postup je stejný pro všechny aplikace.

1. **Základní instalace a headless provisioning.** Ukážu vám jak vytvořit bootovací kartu se serverovou variantou Raspberry Pi OS a jak ji nakonfigurovat tak, aby se připojila do sítě. Připojíte se na dálku přes SSH a nebudete potřebovat klávesnici a monitor.
2. **Zapnutí SSH autentizace pomocí klíče.** Ve druhém dílu vám ukážu, jak SSH zkonfigurovat tak, aby používalo pro autentizaci asymetrický klíč a nikoliv heslo. Je to výrazně bezpečnější a pohodlnější.
3. **Nasazení ASP.NET aplikace.** Ukážu vám, jak aplikaci zkompilovat a nasadit jako Self-Contained Deployment (SCD). Tj. na RPi nebudeme muset instalovat žádný runtime ani nic podobného, vytvoříme nativní binárku, kterou stačí pouze spustit. Také vám ukážu, jak aplikaci spustit jako daemona: aby běžela na pozadí a automaticky se spustila při startu systému. A v neposlední řadě, jak to celé udělat bezpečně.
4. **Publikace pomocí Nginxu a zabezpečení firewallem.** V (zatím?) posledním dílu vám ukážu, jak Kestrel (vestavěný webový server v .NET 5) publikovat do sítě pomocí software Nginx a jak RPi základně zabezpečit pomocí firewallu UFW.

## Základní instalace

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/ROtpqqaNXZ0" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

Nejjednodušší způsob jak vyrobit bootovací kartu s Raspberry OS představuje [Raspberry Pi Imager](https://www.raspberrypi.com/software/). Ten si umí sám stáhnout odpovídající image a "vypálit" ho na MicroSD kartu. Pro server nám stačí Raspberry Pi Lite, tedy verze bez grafického uživatelského rozhraní.

### Headless provisioning - SSH

Výchozí image počítá s tím, že se k Raspberry připojí HDMI monitor, klávesnice a myš a pracuje se s ním z konzole. To se nám u serveru úplně nehodí, tam chceme takzvaný headless provisioning - bez konzole, připojíme se rovnou přes SSH.

Jako první musíte povolit automatické spouštění SSH, tedy vzdáleného shellu. To je něco jako Remote Desktop (RDP) na Windows, ale bez grafického rozhraní, pouze příkazová řádka.

Vytvořená MicroSD karta má dva logické oddíly (uvidíte ji jako dva disky) a jeden z nich se jmenuje `boot`. V něm vytvořte soubor jménem `ssh` (bez přípony, ne třeba `ssh.txt`). Může být prázdný nebo mít jakýkoliv obsah, při první spuštění bude stejně smazán, jenom se počítač zkonfiguruje tak, že spustí SSH daemona pro vzdálený přístup.

### Headless provisioning - Wi-Fi

Pokud budete Raspberry připojovat do počítače drátovou sítí, nemusíte dělat nic dalšího. Pokud ho budete připojovat přes Wi-Fi, musíte ještě nastavit název sítě a heslo.

Vytvořte v partition `boot` soubor jménem `wpa_supplicant.conf` a zadejte do něj následující obsah:

```
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=CZ

network={
    scan_ssid=1
    ssid="název_sítě"
    psk="heslo"
    proto=RSN
    key_mgmt=WPA-PSK
    pairwise=CCMP
    auth_alg=OPEN
}
```

Hodnoty `ssid` a `psk` upravte tak, aby obsahovaly název vaší bezdrátové sítě a heslo.

### První spuštění a vzdálené připojení

Pak stačí MicroSD kartu vložit do RPi a zapojit napájení (případně síťový kabel). Buďte trpěliví, protože první start může trvat i několik minut, v závislosti na velikosti a rychlosti SD karty. Bohužel, na počítači nijak vizuálně nepoznáte, že proces úspěšně doběhl. Běžte si uvařit kafe nebo se podívejte na [nějaké moje video](https://www.youtube.com/ztechcz).

Dále pak musíte zjistit, jakou IP adresu ve vaší síti Raspberry Pi dostalo. Přesný postup záleží na tom, jak máte síť udělanou, ale obecně je nejjednodušší se podívat na router a v seznamu zařízení najít to nejnovější. Já jsem dostal IP adresu `10.7.2.126`.

Pro vzdálené připojení potřebujete SSH klienta. Ten je součástí Windows 10, takže nemusíte nic instalovat (ale pokud jste zvyklí používat třeba PuTTY, klidně tak čiňte nadále). Z příkazové řádky spusťte následující příkaz (samozřejmě s IP adresou platnou pro váš případ):

```bash
ssh pi@10.7.2.126
```

Budete vyzváni k zadání hesla, které je `raspberry`. Výchozí heslo uživatele `pi` můžete změnit příkazem `passwd`. V následujícím dílu seriálu vám ukážu, jak přihlašování heslem zakázat úplně a použít místo toho asymetrický klíč.

Poté zadejte následující příkaz:

```bash
sudo apt-get update && sudo apt-get upgrade -y
```

Tím spustíte aktualizaci software, něco jako Microsoft Update na Windows. Tento proces může nějakou dobu trvat, v závislosti na množství aktualizací a rychlosti vaší linky. Běžte si uvařit další kafe a podívejte se na další video, nějaké delší, třeba [záznam live streamu o volebním systému u nás](https://www.youtube.com/watch?v=nY6cDvpSUHw).

Jakmile aktualizace doběhnou, máte připravený čistě nainstalovaný server s Raspberry OS. Co s ním dál se dozvíte příští týden ve čtvrtek na kanálu [Z-TECH](https://www.youtube.com/ztechcz).
