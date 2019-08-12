<!-- dcterms:title = Tisk z webové aplikace na lokální tiskárně: jak na to? -->
<!-- dcterms:abstract = Svatý grál tisku z webových aplikací: uživatel klepne na tlačítko na webu a z tiskárny okamžitě, bez dalšího dialogu, začne lézt dokument, přesně tak, jak si ho programátor vysnil. Problém je, že to na webu nejde. Nebo ano? -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20190805-tisk-na-webu.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20190805-tisk-na-webu.jpg -->
<!-- x4w:coverCredits = Nimalan Tharmalingam via freeimages.com -->
<!-- x4w:category = IT -->
<!-- dcterms:dateAccepted = 2019-08-05 -->

Evergreenem webových aplikací je tisk. Svatým grálem je, aby uživatel klepnul na tlačítko v aplikaci a z jeho tiskárny okamžitě začal lézt dokument, vytištěný přesně tak, jak aplikace určila, na milimetr přesně. Hloupé je, že to prostředky webového prohlížeče nejde. Browsery prostě nebyly zrozeny pro tisk.

Z JavaScriptu můžete zavolat `window.print()`, ale to jenom otevře tiskový dialog a ten musí tisk potvrdit. Navíc prohlížeč s obsahem stránky pracuje... kreativně. Různě ho zmenšuje, v závislosti na nastavení obrázky a barvy pozadí tiskne nebo ne a navíc to každý prohlížeč dělá trochu jinak. Sice existuje možnost nastavovat vzhled pomocí tiskových stylů, ale ty prohlížeče berou spíše jako nezávazná doporučení, než jako přesné instrukce.

Moje konkrétní situace je ještě o to zábavnější, že nepotřebuji tisknout na obyčejné tiskárně na papír, ale pomocí speciální tiskárny na plastikové karty. Ta se sice pro Windows tváří jako normální tiskárna, ale potřebuji tisknout v přesném rozměru ISO karty.

## Principiální řešení

V případě, že má webová aplikace přímo spolupracovat s lokálním hardwarem, není jiné cesty, než aby na počítači byl nainstalovaný nějaký software, který tu komunikaci zajistí. Webová aplikace pomocí prohlížeče tisknout (nebo přímo spolupracovat třeba se čtečkou karet, RFID nebo čímkoliv podobným) prostě neumí.

Řešení tedy je, že si uživatel musí na počítač nainstalovat nějakou aplikaci, která zajistí vlastní komunikaci. Pak stačí zařídit, aby webová aplikace uměla komunikovat s touto aplikací. To se může dít mnoha způsoby, pomocí webového API, front nebo čehokoliv podobného. Já ale nechci, aby aplikace musela mít nějaký konkrétní backend, chci aby řešení bylo univerzální.

Moje aplikace je tedy navržena tak, že běží jako služba (Windows Service) a má lokální webové rozhraní, dostupné na adrese `http://localhost:8515`. Tisk pak lze spustit HTTP požadavkem na správnou URL. Tiskne se tedy "z web serveru", ovšem lokálně běžící aplikace.

## Konkrétní API

Moje řešení fugnuje následovně:

* Klientská aplikace vygeneruje obrázek, který obsahuje to, co je třeba vytisknout a má správné rozměry (v mém případě 1016&times;638 px, což odpovídá 86&times;54 mm při 300 dpi).
* Poté uživatele přesměruje na adresu `http://localhost:8515/print?src=https://www.example.com/obrazek.png&url=https://www.example.com/done`.
* Lokální webová aplikace si stáhne obrázek z adresy uvedené v parametru `src` a poté uživatele přesměruje na adresu uvedenou v parametru `url`.

V konfiguraci lokální aplikace je uvedeno, na jaké tiskárně má tisknout a jaký rozměr papíru má použít.

Toto řešení je velmi primitivní a neřeší situaci, kdy lokální aplikace není nainstalována nebo neběží. Elegantnější by bylo, kdyby lokální aplikace nabízela nějaké RESTové API, které by se volalo z JavaScriptu, což by umožnilo nějakou formu obsluhy chybového stavu. Ale v takovém případě bych zase musel řešit CORS a další podobné věci, proto jsem se pro tento účel rozhodl pro jednodušší variantu.

## Zabezpečení

Výše uvedené řešení přináší jistý bezpečnostní problém: na tiskárně může tisknout kdokoliv, kdo umí udělat odpovídající HTTP požadavek. Útočník by mohl snadno udělat DoS útok na tiskárnu, stačilo by, aby oběť navštívila jeho webovou stránku.

Proto jsem vytvořil [mechanismus pro podepisování URL](https://github.com/ridercz/Altairis.Services.UrlSigner), který jsem popisoval v [minulých](https://www.altair.blog/2019/08/url-signer) [dvou](https://www.altair.blog/2019/08/url-signer-jeste-jednou) článcích.

## Hotové řešení

Lokálně běžící aplikaci jsem napsal v ASP.NET Core 2.2. Začal jsem s běžnou MVC aplikací. Jádrem je jediný controller, jehož zdrojový kód vypadá následovně:

```cs
public class PrintController : Controller {
    private readonly AppSettings options;
    private readonly IUrlSigner signer;

    public PrintController(IOptions<AppSettings> options, IUrlSigner signer) {
        this.options = options.Value;
        this.signer = signer;
    }

    [Route("/print")]
    public async Task<IActionResult> Index(string src, string url, string sig) {
        // Verify URL signature
        var result = this.signer.Verify(this.Request.GetEncodedUrl());
        if (!result) return this.BadRequest();

        // Download image from given URL
        byte[] imageData;
        using (var wc = new WebClient()) {
            imageData = await wc.DownloadDataTaskAsync(src);
        }

        // Print image
        using (var ms = new System.IO.MemoryStream(imageData)) {
            using (var doc = new PrintDocument() {
                DocumentName = src,
                PrinterSettings = new PrinterSettings {
                    PrinterName = this.options.PrinterName
                }
            }) {
                doc.DefaultPageSettings.PaperSize = doc.PrinterSettings.PaperSizes.OfType<PaperSize>().Single(x => x.PaperName.Equals(this.options.PaperSize));
                doc.PrintPage += (s, e) => {
                    var image = Image.FromStream(ms);
                    var g = e.Graphics;
                    g.DrawImage(image, e.PageBounds);
                };
                doc.Print();
            }
        }

        return this.Redirect(url);
    }

}
```

Controller má jedinou akci `Print`, která provede výše uvedené, totiž:

* Ověří elektronický podpis na URL. Pokud nesedí, vrátí stavový kód 400 (_Bad Request_). Sémanticky správnější by bylo vrátit kód 401 (_Unauthorized_) nebo 403 (_Forbidden_), ale to není v ASP.NET tak jednoduché, koliduje to s autentizačním middlewarem, s čímž se mi nechtělo v daném okamžiku zabývat.
* Stáhne obrázek z adresy zadané jako parametr `src`.
* Vytiskne ho na tiskárně, jejíž název a velikost papíru jsou určeny konfigurací.
* Přesměruje uživatele na adresu zadanou jako parametr `url`, tedy zpět do volající aplikace.

Součástí aplikace je ještě `HomeController`, který umí vypsat seznam všech nainstalovaných tiskáren a v nich definovaných rozměrů papíru.

## Hosting jako Windows Service

Mým záměrem je, aby aplikace běžela na pozadí, jako Windows služba. To je velice snadné, postup je popsán v článku [Host ASP.NET Core in a Windows Service](https://docs.microsoft.com/en-us/aspnet/core/host-and-deploy/windows-service). V jeho duchu jsem upravil třídu `Program` takto:

```cs
public class Program {
    public static void Main(string[] args) {
        var isService = !(Debugger.IsAttached || args.Contains("--console"));

        if (isService) {
            var pathToExe = Process.GetCurrentProcess().MainModule.FileName;
            var pathToContentRoot = Path.GetDirectoryName(pathToExe);
            Directory.SetCurrentDirectory(pathToContentRoot);
        }

        var builder = CreateWebHostBuilder(args.Where(arg => arg != "--console").ToArray());
        builder.UseUrls("http://localhost:8515/");
        var host = builder.Build();

        if (isService) {
            host.RunAsService();
        } else {
            host.Run();
        }
    }

    public static IWebHostBuilder CreateWebHostBuilder(string[] args) {
        return WebHost.CreateDefaultBuilder(args).UseStartup<Startup>();
    }
}
```

Port je zde zadán napevno, obecně by bylo asi lepší, aby byl konfigurovatelný, nicméně pro účely proof of conceptu je toto dobré dost. Číslo portu `8515` jsem zvolil, protože na portu `515` tradičně naslouchá LPD (Line Printer Daemon), tiskový protokol specifickovaný v [RFC1179](https://tools.ietf.org/html/rfc1179). Přidal jsem k tomu `8000`, jak je u webových řešení tradiční.

Program lze spustit z příkazové řádky (ne jako službu) tím, že se mu předá parametr `--console`, což se hodí pro ladění a občasné použití. Má-li být použit jako služba, je třeba ho zaregistrovat a pak se spouští a zastavuje pomocí _Service Manageru_.

Pro tento účel je žádoucí, aby aplikace byla v EXE podobě, ne jako DLL. Použil jsem proto self-contained deployment pro `win-x64` a aplikaci vypublikoval.

Pro registraci služby a její spuštění jsem si napsal následující dávkový soubor `_start.cmd`:

```bat
@ECHO OFF

REM -- Register the service
SC CREATE AltairisLPS start= delayed-auto obj= "NT AUTHORITY\Network Service" binPath= "%CD%\Altairis.LocalPrinter.Server.exe" DisplayName= "Altairis Local Printer Server"

REM -- Start the newly created service
NET START AltairisLPS

REM -- Open web browser pointing to the service page
START http://localhost:8515/
```

> U příkazu `SC` je nutné přesně dodržet jeho poněkud zvláštní syntaxi, kde mezi `=` a hodnotou je mezera (naopak nesmí být před rovnítkem). Ve skutečnosti se jedná o argument jménem např. `start=` a další argument s hodnotou, což je poněkud nezvyklé.

Pro úplnost, zde je soubor `_stop.cmd`, který službu zastaví a odregistruje:

```bat
@ECHO OFF

REM -- Stop the service
NET STOP AltairisLPS

REM -- Unregister it
SC DELETE AltairisLPS
```

## Omezení a závěr

Hotovou ukázkovou aplikaci si můžete stáhnout [jako ZIP archiv](https://www.cdn.altairis.cz/Blog/2019/20190805-localprinter.zip). Funguje dobře, ale má určitá omezení:

* Ve své současné implementaci nechrání před replay útoky. Podepsané URL lze využít opakovaně a vytisknout tentýž dokument vícekrát. Tento problém lze omezit použitím třídy `TimedUrlSigner` popsané v [předchozím článku](https://www.altair.blog/2019/08/url-signer-jeste-jednou) nebo vyřešit tím, že se do podpisu přidá sekvenční počítadlo.
* Služba běží pod speciální identitou `NT AUTHORITY\Network Service` což znamená, že nejspíš nebude fungovat tisk na síťových tiskárnách. Pokud budete chtít tisknout na síťové tiskárně, je třeba buďto nastavit práva tak, aby na ní mohl tisknout computer account nebo rozjet službu pod jiným účtem.
* Pokud budete chtít tisk testovat na virtuální tiskárně (například _Microsoft Print to PDF_), bude vám to fungovat jenom v režimu konzolové aplikace, ne ve službě. Služba (tak jak je navržena a zaregistrována) neumí zobrazit dialog pro název výsledného souboru a aplikace vytuhne.
* Není tam žádná rozumná obsluha chybových stavů, např. pokud se z nějakého důvodu nepodaří stáhnout nebo proparsovat obrázek ze zadaného URL, aplikace prostě spadna na 500 (_Internal Server Error_).