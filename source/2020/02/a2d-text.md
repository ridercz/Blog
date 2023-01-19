<!-- dcterms:title = A2D 1.1.0: Podpora pro práci s textem -->
<!-- dcterms:abstract = Do své OpenSCAD knihovny pro práci s 2D objekty jsem přidal dvě funkce pro práci s textem: text na kružnici a víceřádkový text. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:coverUrl = /cover-pictures/20200222-a2d-text.png -->
<!-- x4w:pictureUrl = /perex-pictures/20200222-a2d-text.png -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = 3D tisk -->
<!-- dcterms:date = 2020-02-22 -->

Do své [OpenSCAD knihovny pro práci s 2D objekty](https://github.com/ridercz/A2D) jsem přidal dvě funkce pro práci s textem: text na kružnici a víceřádkový text.

První je modul `circle_text`, který dokáže zobrazit text na kružnici. Bohužel jeho použití není zcela intuitivní, protože jsem se snažil držet konzistenci s _right hand rule_, které používá standardní transformace `rotate`, takže se úhel textu určuje poněkud netradičně hodnotami proti směru textu.

Druhý je modul `multiline_text`, který napravuje zásadní nedostatek OpenSCADu, totiž neschopnost pracovat s víceřádkovým textem.

Rovněž jsem při této příležitosti vylepšil [dokumentaci](https://github.com/ridercz/A2D/wiki/) a přidal nové [příklady](https://github.com/ridercz/A2D/tree/master/Samples).