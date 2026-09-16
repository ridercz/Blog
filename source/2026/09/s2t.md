<!-- dcterms:title = Dávkový přepis videa na text pomocí Azure Speech -->
<!-- dcterms:abstract = Potřebuji řešit přepis video záznamu na text a dává smysl použít clouduvou službu v Azure. Bohužel, API pro dávkový přepis nemá žádného pohodlného klienta, tak jsem jednoho napsal a dávám ho jako open source k dispozici. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:date = 2026-09-16 -->
<!-- x4w:category = Politika -->
<!-- x4w:pictureUrl = /perex-pictures/20260916-s2t.jpg -->
<!-- x4w:coverUrl = /cover-pictures/20260916-s2t.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->

Potřebuji řešit přepis video záznamu na text. Nemám k dispozici dostatečně nabušený hardware, abych to mohl dělat lokálně (ve skutečnosti celá aplikace běží v Azure) a proto jsem se rozhodl použít [Azure Speech](https://learn.microsoft.com/en-us/azure/ai-services/speech-service/index-speech-to-text), kde mi to udělají za pár korun bez námahy.

Tato služba funguje ve dvou režimech. První je blízký reálnému času a druhý je dávkový. Překlad v reálném čase stojí dolar za hodinu a chcete-li nějaké pokročilejší služby (diarizace atd.), stojí každá z nich dalších 30 centů za hodinu. Dávkové zpracování stojí méně než pětinu: 0,18 $/hod a pokročilejší služby jsou v ceně. Pokud potřebujete zpracovávat existující záznamy a ne živý přenos, není co řešit.

Bohužel, na živý přepis existuje od Microsoftu knihovna, na dávkový nikoliv. [Tak jsem si jednu napsal](https://github.com/ridercz/Altairis.Services.AzureSpeechToTextBatch/).

## Předehra: Extrakce audia z videa pomocí FFMpegCore

API si umí poradit pouze s audio soubory ([v řadě formátů](https://learn.microsoft.com/en-us/azure/ai-services/speech-service/batch-transcription-audio-data?tabs=portal#supported-audio-formats-and-codecs)), ale mým vstupem je video. Potřebuji tedy vyextrahovat audio stopu z videa.

K tomu používám knihovnu [FFMpegCore](https://github.com/rosenbjerg/FFMpegCore), což je C# wrapper okolo knihovny FFMpeg, která je defacto standardním nástrojem pro zpracování multimediálních dat. Kromě NuGet balíčku `FFMpegCore` se hodí i `FFMpegCore.Extensions.Downloader`, který umí stáhnout binárky, které tak nemusejí být na serveru, kde kód běží, nainstalované.

Kód pro přípravu vypadá takto:

```csharp
// Adresář s binárkami FFMpeg
var ffmpegBinDirInfo = new DirectoryInfo(Path.Combine(Path.GetTempPath(), "s2t\\bin"));
ffmpegBinDirInfo.Create();

// Adresář pro dočasné soubory
var ffmpegTmpDirInfo = new DirectoryInfo(Path.Combine(Path.GetTempPath(), "s2t\\data"));
ffmpegTmpDirInfo.Create();

// Nastavit cesty pro FFMpegCore
GlobalFFOptions.Configure(options => {
    options.BinaryFolder = ffmpegBinDirInfo.FullName;
    options.TemporaryFilesFolder = ffmpegTmpDirInfo.FullName;
});

// Stáhnout binárky, pokud je to pořeba
if (ffmpegBinDirInfo.GetFiles().Length == 0) {
    var results = await FFMpegCore.Extensions.Downloader.FFMpegDownloader.DownloadBinaries(binaries: FFMpegBinaries.FFMpeg);
}
```

Poté lze jednoduše provést extrakci audio stopy z videa. Konkrétní parametry záleží na povaze vašeho videa, já beru první kanál a v případě potřeby ho překóduji do AAC:

```csharp
var videoFilePath = @"D:\Downloads\demo.mp4";
var audioFilePath = Path.ChangeExtension(videoFilePath, ".aac");
await FFMpegArguments
    .FromFileInput(videoFilePath)
    .OutputToFile(audioFilePath, overwrite: true, options => options
        .WithCustomArgument("-vn")
        .WithCustomArgument("-ac 1")
        .WithCustomArgument("-c:a aac"))
    .ProcessAsynchronously();
return audioFilePath;
```

## Dějství první: Zpřístupnění audia službě

Audio soubor je třeba nahrát někam, kde ho služba může získat prostým HTTP GET požadavkem. Pokud vaše aplikace běží v Azure, stejně ho asi budete mít uložený v BlobStorage, takže stačí vygenerovat SAS URI pouze pro čtení s krátkou platností. Ale může být kdekoliv, i mimo Azure. 

## Dějství druhé: Vytvoření dávky

Dávka může obsahovat jeden nebo více souborů. Pokud máte opravdu hodně souborů a potřebujete výsledky co nejrychleji, je třeba vhodným způsobem sestavit dávky a třeba je rozhodit mezi více regionů, což je pojednáno [v dokumentaci](https://learn.microsoft.com/en-us/azure/ai-services/speech-service/batch-transcription#best-practices-for-improving-performance). Já jsem to ve svém scénáři nemusel řešit, takže jsem každý soubor dal do samostatné dávky, ale lze to dělat i jinak.

Začněte tím, že si po instanaci NuGet balíčku `Altairis.Services.AzureSpeechToTextBatch` vytvoříte instanci třídy `TranscriptionRequest`. Nastavíte parametry přepisu (zejména jazyk) a pomocí vlastnosti `ContentUrls` zadáte cesty k audio souborům, které chcete přepsat.

Alternativně můžete pomocí vlastnosti `ContentContainerUrl` dát SAS URI na blob container (s právy pro čtení a výpis seznamu souborů) a API zpracuje celý kontejner, což se také může hodit.

```csharp
var batch = new TranscriptionRequest {
    ContentUrls = [ "https://www.example.com/demo.aac" ],
    DisplayName = "Moje davka",
    Locale = "cs-CZ",
    Properties = new TranscriptionProperties {
        ProfanityFilterMode = ProfanityFilterMode.None,
        PunctuationMode = PunctuationMode.Automatic,
        DiarizationEnabled = false,
        DisplayFormWordLevelTimestampsEnabled = true,
        WordLevelTimestampsEnabled = true
    }
};
```

> Třída `TranscriptionProperties` zpřístupňuje volby z REST API, které jsou [popsány v dokumentaci](https://learn.microsoft.com/en-us/rest/api/speechtotext/transcriptions/create?view=rest-speechtotext-v3.2&tabs=HTTP#transcriptionproperties).

## Dějství třetí: Odeslání na server

Při vytváření služby si volíte klasicky Azure region (např. `WestEurope`) a je vám vygenerován API klíč, podobně jako třeba u Storage Accountu. Tyto údaje použijte pro vytvoření instance třídy `TranscriptionClient`. Potí zavolejte metodu `CreateTranscription`, která vám vrátí `TranscriptionResponse`. Pomocí metody `GetId()` pak získáte unikátní identifikátor dávky (je to GUID, ale nominálně je to obecný string):

```csharp
var tc = new TranscriptionClient("<your-speech-key>", "<your-speech-region>");
var response = await tc.CreateTranscription(batch, cancellationToken);
var batchId = response.GetId();
```

## Mezihra: Plynutí času

Dávkové zpracování může na základě vytížení služeb v daném regionu trvat až 24 hodin. U mne bylo při testech vždy rychlejší, než byla délka přepisovaného audia, ale zaručeno to není.

Máte několik možností, jak sledovat průběh a zpracovat výsledek:

* Můžete se periodicky ptát na stav dané dávky a když je hotová, stáhnout si výsledek.
* Můžete nastavit `Properties.DestinationContainerUrl` na SAS URI umožňující zápis do kontejneru a služba vám výsledek nahraje do tohoto kontejneru.
* Můžete nastavit webhook, který se zavolá až bude dávka dokončena, a pak si stáhnout výsledek nebo ho najít v kontejneru. Moje knihovna webhooky nepodporuje, ale je open source, takže pokud to využijete, budu rád když to tam dopíšete a pošlete mi pull request. Alternativně mi můžete zaplatit abych to tam doprogramoval já.

Třída `TranscriptionClient` nabízí metodu `ListTranscriptions`, pomocí které si můžete vypsat všechny dávky a jejich stavy (pozor, výpis je stránkovaný). Pokud znáte ID dávky, můžete použít metodu `GetTranscription`, která vám vráti informace pouze o ní. Pro vás je důležitá vlastnost `Status`, která může mít následující hodnoty:

* `NotStarted` - čeká ve frontě
* `Running` - zpracovává se
* `Succeeded` - dokončeno
* `Failed` - chyba

## Dějství čtvrté: Stažení výsledku

Pokud byla dávka úspěšně dokončena, můžete si vyžádat seznam souborů, které tvoří výsledek. Třída `TranscriptionClient` nabízí metodu `ListFiles`, která vám dá seznam souborů pro danou dávku. Je také stránkovaná, což vás bude zajímat ve chvíli, kdy budete mít v dávce hodně souborů. Pokud tam budete mít jenom jeden, může vám to být vesměs jedno.

Jeden vstupní audio soubor vytvoří několik výstupních souborů, které mohou obsahovat logy a další informace. Nás ale bude zajímat soubor, jehož `FileKind` je `Transcription`.

Takhle může vypadat kód, který stáhne výsledek a smaže hotový job:

```csharp
var transcriptionId = "00000000-0000-0000-0000-000000000000";

// Create instance of the client
var tc = new TranscriptionClient("<your-speech-key>", "<your-speech-region>");

// Get the status of the transcription job
var job = await tc.GetTranscription(transcriptionId);
if(job.Status != TranscriptionStatus.Succeeded) {
    Console.WriteLine($"Transcription status: {job.Status}");
    return;
}

// Download the results of the transcription job
Console.WriteLine($"Transcription succeeded. Downloading results...");
var files = await tc.ListFiles(transcriptionId);
using var httpClient = new HttpClient();
foreach(var file in files) {
    // Get SAS download URL for the file
    var downloadUrl = await tc.GetFileDownloadUrl(transcriptionId, file.GetId(), cancellationToken);

    // Download the file using HttpClient
    using var response = await httpClient.GetAsync(downloadUrl, cancellationToken);
    response.EnsureSuccessStatusCode();
    await using var fs = new FileStream(file.Name, FileMode.Create, FileAccess.Write, FileShare.None);
    await response.Content.CopyToAsync(fs, cancellationToken);
}

// Delete transcription job
await tc.DeleteTranscription(transcriptionId);
```

## Dohra: Zpracování výsledku

Výsledek jsou data ve formátu JSON. Popis formátu najdete [v dokumentaci](https://learn.microsoft.com/en-us/azure/ai-services/speech-service/batch-transcription-get?pivots=rest-api#transcription-result-file) a v zásadě se jedná o přepsaný text, který získáte buďto jako prostý string anebo rozsekaný na jednotlivé fráze s časovými razítky, což se může hodit pro účely třeba vytváření titulků.

Součástí mé knihovny je třída `Transcript`, do které můžete deserializovat získaný JSON a pracovat s ním objektovým způsobem.

Třída `TranscriptionClient` má utility metodu `GetTranscript`, která umí přímo stáhnout a proparsovat daný soubor anebo jenom proparsovat JSON, který dostane. Kompletní přepsaný text najdete v kolekci `CombinedRecognizedPhrases` (podle kanálů) jako vlastnost `Display`:

```csharp
var transcript = tc.GetTranscript(transcriptionId, file.GetId());
Console.WriteLine($"Duration:           {TimeSpan.FromMilliseconds(transcript.DurationMilliseconds)}");
Console.WriteLine($"Recognized phrases: {transcript.RecognizedPhrases.Sum(x => x.NBest.Length)}");
Console.WriteLine($"Recognized text:    {transcript.CombinedRecognizedPhrases.First().Display?[..60]}...");
```

Přepis anglického textu je výborný. Přepis češtiny je, jak už to bývá, o něco slabší, ale přijde mi, že je zhruba srovnatelný se všemi ostatními metodami, které jsem zkoušel.

> Na [GitHubu](https://github.com/ridercz/Altairis.Services.AzureSpeechToTextBatch/) najdete kromě samotné knihovny i ukázkovou aplikaci, která umožňuje vyzkoušet knihovnu pomocí konzolové aplikace.