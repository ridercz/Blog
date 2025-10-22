<!-- dcterms:title = Jak tisknout z .NETu na normální i pokladní tiskárně -->
<!-- dcterms:abstract = Po letech budování bezpapírové společnosti potiskneme víc papíru, než když předtím. Chcete se přidat? Naučím vás, jak z .NETu tisknout na běžné Windows tiskárně i jak komunikovat s pokladní tiskárnou pomocí ESC/POS sekvencí. -->
<!-- x4w:category = IT -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:date = 2025-10-22 -->
<!-- x4w:coverUrl = /cover-pictures/20251022-tisk.jpg -->
<!-- x4w:pictureUrl = /perex-pictures/20251022-tisk.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->

Po letech budování bezpapírové společnosti potiskneme víc papíru, než když předtím. Chcete se přidat? Naučím vás, jak z .NETu tisknout na běžné Windows tiskárně i jak komunikovat s pokladní tiskárnou pomocí ESC/POS sekvencí.

## Tisk na jakékoliv Windows tiskárně

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/fcvXAqruRBY" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

Chceme-li tisknout na jakékoliv tiskárně nainstalované ve Windows (tj. dostupné pomocí jeho tiskového subsystému), je třeba použít třídy z NuGet balíčku `System.Drawing.Common`. Ten je součástí .NETu, ale logicky funguje pouze na Windows. Hlavní je pro nás třída `PrintDocument`, která reprezentuje tiskovou úlohu. Pomocí eventu `PrintPage` lze získat objekt `Graphics` a do něj kreslit, psát texty a podobně.

<script src="https://gist.github.com/ridercz/d8ff46e8d6163186b22289d234f4662b.js"></script>

## Tisk na pokladní tiskárně pomocí ESC/POS

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/ewSwkoqVuJk" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

Pokladní tiskárny jsou posledními zástupci dnes již téměř vyhynulého druhu jehličkových tiskáren. Tisknou na úzký proužek teplocitlivého papíru (šíře buďto 58 mm nebo 80 mm). Můžeme na ně tisknout jako na jakoukoliv jinou Windows tiskárnu, nebo s nimi komunikovat přímo, textově. Jaký text jim pošleme, takový vytisknou, pomocí svého výchozího fontu. Výhodou tohoto přístupu je, že je většinou rychlejší, navíc můžeme využívat případné speciální funkce tiskárny.

Text můžeme doplnit řídícími kódy dle standardu ESC/POS (Epson Standard Codes for Point Of Sale), které mohou zařídit základní formátování písma, tisknout čárové nebo QR kódy anebo třeba řídit řezačku papíru nebo připojenou pokladní zásuvku. K vygenerování dat pro tiskárnu (nechceme-li kódy posílat ručně) lze použít třeba NuGet balíček `ESCPOS`.

Pokud je tiskárna dostupná pomocí síťového (TCP socket) nebo sériového (COM port) rozhraní, stačí prostě takto vygenerovaná data poslat. Pokud je ale tiskárna připojena jako standardní systémová tiskárna a my s ní chceme komunikovat přímo, potřebujeme balíček `RawPrint.NetStd`. Nezáleží přitom na tom, jak je tiskárna připojena fyzicky (USB, Bluetooth...), ale jak je nainstalována v systému logicky.

<script src="https://gist.github.com/ridercz/d9eb266c5530679eeaee0308710b40a5.js"></script>

## Tisk českých znaků

Používáme-li tisk přes grafický subsystém, můžeme používat jakékoliv písmo uznáme za vhodné, tiskne se graficky, a není tedy problém s českou diakritikou. Chceme-li tisknout v textovém režimu české znaky, musí to daná tiskárna podporovat. Je to (nepříliš) hezká vzpomínka na doby MS-DOSu a různé podivné hacky, které měly na obrazovce zobrazit nabodeníčka. Naštěstí se už nemusíme potýkat s kódováním dle bratrů Kamenických, ale vesměs si vystačíme s _ISO 8859-2_ nebo _Windows-1250_. Prý existují i pokladní tiskárny, které zvládají i _UTF-8_, ale tomu uvěřím, až takovou osobně dostanu do ruky. Bohužel, přesný postup (interní číselný kód patřičného kódování) je u různých modelů různý, takže nastavení se hodně liší.

![Tiskárna Cashino PTP-II](https://www.cdn.altairis.cz/Blog/2025/20251022-cashino.jpg)

Mám Bluetooth tiskárnu _Cashino PTP-II_, která se používá zejména v restauracích, a ta podporuje obě shora zmíněné znakové sady. V následujícím příkladu si můžete vyzkoušet, jak tisknout hezky česky:

<script src="https://gist.github.com/ridercz/9877be9c9f5f564a56a990ce2d6a9022.js"></script>

Pokud vaše tiskárna nepodporuje českou znakovou sadu (což je běžné zejména u levných čínských tiskáren, neuzpůsobených lokálnímu trhu), možná podporuje možnost nahrát vlastní znaky. Pak budete muset navrhnout jejich grafickou podobu a jako bitmapu (tedy jedničky a nuly v matici, ne soubor ve formátu BMP) je nahrát do tiskárny. Pokud na to nemáte nervy nebo to tiskárna nepodporuje, jedinou možností je tisknout bez diakritiky.