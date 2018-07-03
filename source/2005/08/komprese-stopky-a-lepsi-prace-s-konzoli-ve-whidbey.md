<!-- dcterms:identifier = aspnetcz#43 -->
<!-- dcterms:title = Komprese, stopky a lepší práce s konzolí ve Whidbey -->
<!-- dcterms:abstract = Jednoduchý prográmek ilustrující některé novinky v .NET 2.0 (Whidbey) -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Tipy, triky -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2005-08-05T22:37:54.79+02:00 -->
<!-- dcterms:dateAccepted = 2005-08-05T22:37:54.79+02:00 -->

Nový .NET framework přináší řadu funkcí, které předtím nebyly dostupné buď vůbec a nebo mnohem komplikovaněji. V dnešním příkladu se podíváme na tři z nich.
 <h2>GZIP a DEFLATE komprese</h2> 

Nový .NET nabízí podporu pro kompresi dat, metodou GZIP a DEFLATE. GZIP komprese je průmyslovým standardem a používá se například pro [kompresi přenosů přes HTTP](/entry/article-20050102.aspx). Ve stávající verzi 1.1 je možno s úspěchem použít open source knihovnu [SharpZipLib](http://www.icsharpcode.net/OpenSource/SharpZipLib/Default.aspx), ale zahrnutí této funkce do "core" frameworku je jistě výhodou.

Podotýkám, že GZIP se nerovná klasickému ZIP archivu, jedná se o sice podobnou, leč ne stejnou technologii. Dále je nutno si uvědomit, že GZIP ukládá pouze vlastní komprimovaná data, nikoliv další informace o nich (jako třeba název souboru a podobně). Tento formát je tedy vhodný pro vnitřní použití v rámci aplikace, ne pro poskytování dat běžným uživatelům.

Užití dojde zejména v souvislosti s XML soubory. Data ve formátu XML mají mnoho výhod a bezprecedentní podporu ze strany .NET. Na druhou stranu je ale XML formát neuvěřitelně "ukecaný". Dá se ovšem s výhodou komprimovat. Pomocí několika řádků nyní můžete XML dokument uložit ve zkomprimované podobě a při načtení ho zase dekomprimovat.

Z programátorského hlediska je komprese realizována formou streamu, konkrétně třídy `System.IO.Compression.GZipStream`. V jejím konstruktoru specifikujete underlying stream (tedy stream, do kterého se budou data fyzicky zapisovat, nebo se z něj číst, např. soubor) a  pak jenom zapisujete či čtete data a `GZipStream` funguje jako filtr - obdobnou implementaci najdete například u šifrování.
 <h2>Lepší práce s konzolí</h2> 

Ačkoliv se rozhraní příkazové řádky může zdát primitivní, pro řadu úkolů (zejména z praxe administrátora) je stále tou nejlepší volbou. .NET ve verzi 1.1 umí s textovou konzolí pracovat základním způsobem (také v podstatě jako se streamem).

Verze 2.0 přináší několik užitečných nových vlastností. Zejména pak vlastnosti `Console.ForegroundColor` a `Console.BackgroundColor`, sloužící k nastavení barev a nadmíru užitečné `Console.CursorLeft` a `Console.CursorTop`, sloužící.k nastavení pozice kurzoru.

Právě vlastnosti pro nastavení pozice kurzoru je možno použít například pro měnící se zobrazování stavu zpracování (průběh komprese/dekomprese v procentech).
 <h2>Stopky</h2> 

Často je třeba změřit, jak dlouho trvala určitá operace. V zásadě je k tomu možno použít obyčejnou proměnnou typu `DateTime` a odečíst rozdíl. Ve Whidbey je tato funkcionalita zapouzdřena do třídy `System.Diagnostics.Stopwatch`. Ovládá se pomocí metod `Start`, `Stop` a `Reset`, aktuální hodnotu zjistíte například pomocí vlastnosti `Elapsed`.
 <h2>Praktický příklad</h2> 

Následující procedura slouží ke zkomprimování souboru metodou GZIP. Měří čas zpracování a postupně zobrazuje průběh:

Sub CompressFile(ByVal InFileName As String, ByVal OutFileName As String) Const BufferSize As Int32 = 65536 ' 64 kB ' Start stopwatch Dim SW As New System.Diagnostics.Stopwatch() SW.Start() ' Prepare streams Dim InStream As New System.IO.FileStream(InFileName, IO.FileMode.Open, IO.FileAccess.Read) Dim OutStream As New System.IO.FileStream(OutFileName, IO.FileMode.Create, IO.FileAccess.Write) Dim ZipStream As New System.IO.Compression.GZipStream(OutStream, IO.Compression.CompressionMode.Compress, True) ' Compress Dim Data(BufferSize) As Byte Dim BytesRead As Int32 Do BytesRead = InStream.Read(Data, 0, BufferSize) ZipStream.Write(Data, 0, BytesRead) ' Show progress Console.Write("Progress: {0:N2}%", InStream.Position / InStream.Length * 100) Console.CursorLeft = 0 Loop While BytesRead = BufferSize ' Clean up SW.Stop() Console.WriteLine("Compression completed in {0:N2} seconds.", SW.Elapsed.TotalSeconds) ZipStream.Close() OutStream.Close() InStream.Close() End Sub

Můžete si stáhnout zdrojové kódy [kompletní konzolové aplikace](/files/20050805-cgz.zip) ve VB.NET umožňující kompresi a dekompresi dat metodou GZIP.