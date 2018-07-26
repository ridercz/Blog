<!-- dcterms:identifier = aspnetcz#31 -->
<!-- dcterms:title = Emulátor enigmy v C# a webserveříček ve VB.NET -->
<!-- dcterms:abstract = Můj oblíbený server CodeProject jest zdrojem všeliké zábavy a poučení. V poslední sobě mne zaujaly dva projekty tamo se vyskytnuvší. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = IT -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2005-04-13T17:46:25.75+02:00 -->
<!-- dcterms:dateAccepted = 2005-04-13T17:46:25.75+02:00 -->

Můj oblíbený server [CodeProject](http://www.codeproject.com/) jest zdrojem všeliké zábavy a poučení. V poslední sobě mne zaujaly dva projekty tamo se vyskytnuvší.

## Emulátor šifrovacího stroje Enigma v C#

Historie německého šifrovacího stroje Enigma je plná zvratů a neuvěřitelných událostí. Původně byl tento stroj určen pro šifrování důvěrné obchodní korespondence, ale neujal se. Nacistický režim v Německu ho ale vyzvedl na výsluní, vylepšil a rozhodl se z něj udělat tajnou zbraň, se kterou vyhraje druhou světnovou válku. Kvůli Enigmě ji ale prohrál - polským a anglickým kryptologům se podařilo kód prolomit a téměř celou válku četli veškeré tajné zprávy německé armády.

Tajemství Enigmy mělo pro Brity takovou hodnotu, že v zájmu jeho zachování obětovali město Coventry, které podlehlo ničivému bombardování. Enigma se nepřímo zasloužila i o rozvoj výpočetní techniky: kvůli ní Alan Turing postavil supertajný stroj Ultra (údaje o něm jsou dodnes předmětem utajení).

Nyní se na CodeProjectu objevil v C# napsaný [emulátor](http://www.codeproject.com/csharp/Enigma_emulator.asp) tohoto stroje. Ačkoliv si dovolím upřímně nesouhlasit s autorem článku že šifrovací algoritmus Enigmy je použitelný pro "non-critical" úkoly i dnes, rozhodně stojí za prohlédnutí.

## Webserver ve VB.NET

Napsat si v .NET vlastní webserver s podporou ASP.NET je celkem snadné. Ovšem ne tak snadné, aby jeden neocenil, když to někdo udělá za něj. V zásadě je možno použít [Cassini](http://www.asp.net/Projects/Cassini/Download/Default.aspx?tabindex=0&tabid=1), ukázkový .NET projekt od Microsoftu, ale ten je psaný v C# a moc toho neumí.

Projekt [xNetServer](http://www.codeproject.com/aspnet/xNetServer.asp) je psaný ve VB.NET a oproti Cassini má řadu výhod: umí běžet jako služba, nastavení se ukládá do XML souboru a má širší možnosti nastavení než Cassini.