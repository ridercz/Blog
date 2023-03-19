<!-- dcterms:title = Jak nastavit rozlišení pro obrázky exportované z PowerPointu -->
<!-- dcterms:abstract = PowerPoint umí snímky z prezentace uložit jako obrázky ve formátech PNG, JPEG nebo TIFF, což se občas hodí. Výchozí nastavení je ale generuje v příliš malém rozlišení (1280 × 720) a v GUI není způsob, jak to změnit. Naštěstí stačí jednoduchý zásah do registrů. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:coverUrl = /cover-pictures/20230319-powerpoint-dpi.jpg -->
<!-- x4w:pictureUrl = /perex-pictures/logo-powerpoint.svg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = Tipy, triky -->
<!-- dcterms:date = 2023-03-19 -->

PowerPoint umí snímky z prezentace uložit jako obrázky ve formátech PNG, JPEG nebo TIFF, což se občas hodí. Výchozí nastavení je ale generuje v příliš malém rozlišení (1280 × 720) a v GUI není způsob, jak to změnit. Naštěstí stačí jednoduchý zásah do registrů.

V registrech se nastavuje rozlišení v dpi (dots per inch), ze kterého se vypočítá rozměr exportovaného obrázku. Podporovány jsou následující hodnoty:

dpi | Rozměr 4:3  | Rozměr 16:9
--: | :---------: | :---------:
50  |   500 × 375 |  667 × 375
96  |   960 × 720 |  1280 × 720
100 |  1000 × 750 |  1333 × 750
150 | 1500 × 1125 | 2000 × 1125
200 | 2000 × 1500 | 2667 × 1500
250 | 2500 × 1875 | 3333 × 1875
300 | 3000 × 2250 | 4000 × 2250

Bohužel není možné jednoduše získat Full HD rozlišení (1920 × 1080), ale vždy lze vyexportovat rozlišení vyšší (150 dpi) a obrázek zmenšit.

Název klíče se liší podle verze PowerPointu:

Verze PowerPointu         | Název klíče
------------------------- | --------------------------------------------------------
2016, 2019, Microsoft 365 | `HKCU\Software\Microsoft\Office\16.0\PowerPoint\Options`
2013                      | `HKCU\Software\Microsoft\Office\15.0\PowerPoint\Options`
2010                      | `HKCU\Software\Microsoft\Office\14.0\PowerPoint\Options`
2007                      | `HKCU\Software\Microsoft\Office\12.0\PowerPoint\Options`
2003                      | `HKCU\Software\Microsoft\Office\11.0\PowerPoint\Options`

Vytvořte zde hodnotu jménem `ExportBitmapResolution` typu `REG_DWORD` a nastavte ji podle předchozí tabulky rozlišení.

Můžete k tomu použít i příkazovou řádku. Chcete-li v aktuální verzi PowerPointu nastavit maximální rozlišení exportu, použijte následující příkaz:

    REG ADD HKCU\Software\Microsoft\Office\16.0\PowerPoint\Options /v ExportBitmapResolution /t REG_DWORD /d 300 /f

Na rozlišení jsou (zejména ve starších verzích PowerPointu) kladena jistá omezení. Podrobnější popis najdete v článku [How to export high-resolution (high-dpi) slides from PowerPoint](https://learn.microsoft.com/en-us/office/troubleshoot/powerpoint/change-export-slide-resolution).