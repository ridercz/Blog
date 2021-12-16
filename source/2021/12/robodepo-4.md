<!-- dcterms:title = Jak zastavit robotické depo Zásilkovny: Software -->
<!-- dcterms:abstract = Software pro Z-Button je ve skutečnosti docela jednoduchý, ostatně nechce se od něj nic jiného, než aby na stisk tlačítka udělal HTTP request plus nějaká konfigurační omáčka kolem. Ve skutečnosti je ta konfigurační omáčka v podstatě to nejsložitější. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20211211-robodepo-4.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20211211-robodepo-4.jpg -->
<!-- x4w:category = Z-TECH -->
<!-- x4w:category = IT -->
<!-- x4w:category = Bezpečnost -->
<!-- x4w:serial = Robotické depo -->
<!-- dcterms:dateAccepted = 2021-12-11 -->

Software pro Z-Button je ve skutečnosti docela jednoduchý, ostatně nechce se od něj nic jiného, než aby na stisk tlačítka udělal HTTP request plus nějaká konfigurační omáčka kolem. Ve skutečnosti je ta konfigurační omáčka v podstatě to nejsložitější.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/LVl0ZO_oYcM" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

Software je psaný pro [Arduino core for ESP8266](https://github.com/esp8266/Arduino). Kromě standardních knihoven [FS](https://github.com/esp8266/Arduino/blob/master/cores/esp8266/FS.h) a [ESP8266WiFi](https://github.com/esp8266/Arduino/tree/master/libraries/ESP8266WiFi) používám jenom dvě bežné platformně nezávislé knihovny, [Pushbutton](https://github.com/pololu/pushbutton-arduino) a [ArduinoJson](https://arduinojson.org/). První z nich se stará o debouncing stisku tlačítka a druhá o parsování JSON datové struktury. Obě používám čistě z pohodlnosti, jak debouncing tak ukládání konfigurace bych si dokázal napsat sám, ale tyhle knihovny mi ušetří práci a zdrojů má ESP8266 k dispozici dost, takže proč se utápět v sebemrskačství.

Kompletní popis kódu najdete ve videu výše, zdrojové kódy - včetně předchozích proof of concept verzí - pak [na GitHubu](https://github.com/ridercz/ZButton).

Asi nejsložitější kód se týká práce s konfigurací. Zařízení si musí pamatovat pár konfiguračních hodnot (jsou [popsány v dokumentaci](https://github.com/ridercz/ZButton/blob/master/Arduino/readme.md)), zejména pak vlastní identitu (client ID a secret), adresu kterou má volat v případě stisku tlačítka a samozřejmě název a heslo WiFi sítě. Nastavování konfiguračních hodnot pak probíhá přes sériovou linku. Dá se dělat buďto manuálně, anebo pomocí software pro provisioning, o kterém bude řeč v dalším pokračování.