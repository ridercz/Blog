<!-- dcterms:title = Raspberry Pi Imager 1.7: Jednodušší provisioning -->
<!-- dcterms:abstract = První dva díly seriálu o ASP.NET na Raspberry Pi jsem věnoval jeho prvotnímu nastavení, nebo chcete-li provisioningu. Jak nastavit parametry Wi-Fi, autentizace, povolení SSH... Nyní je všechno mnohem jednodušší. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20211104-dotnet-raspi-4.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20211104-dotnet-raspi-4.jpg -->
<!-- x4w:coverCredits =  Karminski-牙医 via Unsplash.com -->
<!-- x4w:category = Z-TECH -->
<!-- x4w:category = IT -->
<!-- x4w:serial = ASP.NET na Raspberry Pi -->
<!-- dcterms:dateAccepted = 2022-02-08 -->

[První](https://www.altair.blog/2021/10/dotnet-raspi-1) [dva](https://www.altair.blog/2021/10/dotnet-raspi-2) díly seriálu o ASP.NET na Raspberry Pi jsem věnoval jeho prvotnímu nastavení, nebo chcete-li provisioningu. Jak nastavit parametry Wi-Fi, autentizace, povolení SSH... Nyní je všechno mnohem jednodušší.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/lm7HZjTfQLs" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

Vyšla totiž nová verze 1.7 nástroje [Raspberry Pi Imager](https://www.raspberrypi.com/software/). Tato nová verze po vybrání image Raspberry Pi OS umožňuje nastavit základní parametry:

* Hostname
* Povolení vzdáleného shellu (SSH)
* Nastavení SSH autentizace pomocí veřejných klíčů
* Nastavení jména výchozího uživatele (nemusí být `pi`) a hesla
* Připojení k Wi-Fi
* Nastavení časové zóny
* Nastavení klávesnice

![](https://www.cdn.altairis.cz/Blog/2022/20220208-newimager.png)

Jde o první verzi s touto funkcionalitou a není dokonalá. GUI je dost spartánské a špatně se ovládá a nepočítá s ovládáním klávesnicí. Rovněž jsem nepřišel na to, jak nastavit českou QWERTY klávesnici. Ale to v zásadě nepředstavuje problém, protože tento mechanismus nastavování se typicky používá pro servery, kdežtě ničehož takového beztak není třeba.