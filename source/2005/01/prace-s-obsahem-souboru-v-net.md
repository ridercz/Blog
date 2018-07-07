<!-- dcterms:identifier = aspnetcz#19 -->
<!-- dcterms:title = Práce s obsahem souborů v .NET -->
<!-- dcterms:abstract = Jedním z námětů, které jsem obdržel v rámci své minulé výzvy, byla žádost o vysvětlení práce s textovými soubory. Zadání jsem si rozšířil na práci s obsahem souborů obecně - nebo chcete-li se streamy. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Tipy, triky -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2005-01-28T00:39:37.31+01:00 -->
<!-- dcterms:dateAccepted = 2005-01-28T00:39:37.31+01:00 -->

Jedním z námětů, které jsem obdržel v rámci své výzvy [ptejte se mne na co chcete, já na co chci odpovím](/entry/article-20050125.aspx), byla žádost o vysvětlení práce s textovými soubory. Zadání jsem si rozšířil na práci s obsahem souborů obecně - nebo chcete-li se streamy.

## Co je stream

Většina vstupně/výstupních operací se v .NET děje prostřednictvím nějaké formy streamu. Stream představuje obecně jakýkoliv objekt, ze kterého lze číst nebo do něj zapisovat bajty. Tato abstrakce je velmi široce použitelná: v tomto článku se budu zabývat toliko soubory, ale tentýž přístup je možno aplikovat na TCP/IP síťové spojení, komunikaci přes sériový port, kryptografické operace a řadu dalších věcí.

Základní třídou je v tomto případě `System.IO.Stream`. Jeho základní metody jsou `ReadByte`, `Read`, `WriteByte` a `Write`. Ty umožňují přečíst nebo zapsat jeden či více bajtů. Steam může umožňovat čtení, zápis nebo obojí. To lze zjistit z vlastností `CanRead` a `CanWrite`. Metodou `Close` lze stream zavřít (a v případě souborů zapsat provedené změny na disk).

Tato třída je abstraktní a musí být tedy v praxi implementována pomocí specializovaných tříd jako je například `FileStream`, `NetworkStream` nebo `MemoryStream`.

## Textové soubory

Možnosti samotného streamu nejsou moc velké. Zapsat nebo přečíst hromádku bajtů sice *v zásadě* stačí, ale pro praktickou práci by bylo potřeba napsat spoustu věcí okolo. Pro práci s textovými soubory proto .NET obsahuje třídy `System.IO.StreamReader` a `System.IO.StreamWriter`. Ty umožňují pohodlně ze streamu číst nebo do něj zapisovat řetězcová data v požadovaném kódování. Disponují přitom metodami jako `ReadLine` nebo `WriteLine`, které umožňují zpracování souboru po řádcích.

Následující kód tedy vytvoří textový soubor a zapíše do něj dva řádky textu:

Dim Soubor As New System.IO.StreamWriter(Server.MapPath("/StreamDemo/demo.txt")) Soubor.WriteLine("První řádek") Soubor.WriteLine("Druhý řádek") Soubor.Close()

Vcelku podobným způsobem je možno soubor i číst. Zde se uplatní též metoda `Peek`. Ta "nakoukne" na další bajt v souboru a aniž by posunula pomyslný kurzor, vrátí jeho hodnotu. V případě, že narazí na konec souboru, vrátí `-1`. Toho lze s úspěchem využít při řešení úloh typu "načítej dokud nenarazíš na konec souboru. Následující kód přečte po řádcích obsah zdrojového souboru a vypíše ho na výstup:

Dim Soubor As New System.IO.StreamReader(Server.MapPath("/StreamDemo/demo.txt")) Do While Soubor.Peek() > -1 Dim Radek As String = Soubor.ReadLine() Response.Write(Radek & "<br>") Loop Soubor.Close()

V tomto konkrétním případě je víceméně zbytečné číst soubor po řádcích. Mnohem jednodušší by bylo použít metodu `ReadToEnd` a poté prostě nahradit konce řádků tagem `<br>`.

## Různá kódování

.NET Framework vnitřně pracuje se všemi daty v kódování UNICODE, resp. UTF-8. I jeho výše uvedené třídy tedy implicitně předpokládají, že veškerá data jsou k dispozici v UTF-8. Ačkoliv vám vřele doporučuji, aby vaše programy tuto logiku přejaly (ušetříte si tím spoustu práce a problémů), může se stát, že data dostanete v kódování jiném. 

Ani to nepředstavuje zásadní problém. Obšírnější [pojednání o kódování řetězců v .NET](http://archive.aspnetwork.cz/art/clanek.asp?id=212) jsem napsal již před časem, detaily si přečtěte v něm. Pro účely čtení nebo zápisu pomocí `StreamReaderu` a `StreamWriteru` stačí prostě požadované kódování specifikovat jako další volitelný parametr. Máte-li tedy vstupní data například v kódování Windows 1250, stačí příslušný řádek modifikovat takto:

Dim Soubor As New System.IO.StreamReader(Server.MapPath("/StreamDemo/demo.txt"), _ System.Text.Encoding.GetEncoding("Windows-1250"))

## Pohodlný přístup

V příkladech výše jsem soubory volal přímo pomocí odpovídajícího `StreamReaderu` či `StreamWriteru`. Zcela stejných výsledků, někdy pohodlnější cestou, lze dosíci použitím rozličných statických metod v `System.IO.File`. Například `CreateText`, `AppendText` a `OpenText`.