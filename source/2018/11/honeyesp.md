<!-- dcterms:title = HoneyESP: Falešné AP pro sociální útoky za stovku -->
<!-- dcterms:abstract = Ještě nepříliš dávno jste pro vytvoření falešného přístupového bodu pro sociálně-inženýrské útoky potřebovali aspoň notebook s ne zcela běžnou Wi-Fi kartou. O něco později vám stačilo Raspberry Pi. Teď stačí mikrokontroler za dva dolary. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20181115-honeyesp.jpg -->
<!-- x4w:coverUrl = /cover-pictures/20181115-honeyesp.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = Software -->
<!-- x4w:category = Bezpečnost -->
<!-- x4w:category = Bastlení -->
<!-- dcterms:date = 2018-11-15 -->

Ještě nepříliš dávno jste pro vytvoření falešného přístupového bodu pro sociálně-inženýrské útoky potřebovali aspoň notebook s ne zcela běžnou Wi-Fi kartou. O něco později vám stačilo Raspberry Pi. Teď stačí mikrokontroler za dva dolary a můj open source projekt **[HoneyESP](https://github.com/ridercz/HoneyESP)**.

Před třemi lety jsem vydal seriál o projektu [Atropa](/serials/projekt-atropa), kde jsem ukázal, jak udělat falešné AP s captive portálem pomocí Raspberry Pi a ASP.NET Core (tehdy se ještě nazývané ASP.NET 5). Idea HoneyESP je naprosto totožná, ale místo Raspberry s Linuxem používáme mikrokontroler ESP8266. Stojí desetinu, má menší odběr a nedá se hacknout.

Projekt jsem představil na včerejší přednášce v [PrusaLabu](https://www.prusalab.cz/). Zde se můžete podívat na její záznam:

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/Nx8krNOBnGw" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

Zdrojové kódy, licencované pod MIT licencí najdete na [GitHubu](https://github.com/ridercz/HoneyESP). Na tamní wiki najdete též [dokumentaci](https://github.com/ridercz/HoneyESP/wiki).