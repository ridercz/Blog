<!-- dcterms:title = Jakým způsobem používat statické soubory v ASP.NET 5? -->
<!-- dcterms:abstract = Prakticky všechny webové aplikace potřebují pracovat se statickými soubory. Některé jsou součástí aplikace samotné, jako například obrázky, styly a skripty. Jiné představují data, nahraná do aplikace - třeba obrázky v článcích nebo přílohy. Jakým způsobem s nimi zacházet, kde je ukládat a jak je zpřístupňovat? -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20210225-files.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20210225-files.jpg -->
<!-- x4w:category = IT -->
<!-- dcterms:dateAccepted = 2021-02-25 -->

Prakticky všechny webové aplikace potřebují pracovat se statickými soubory. Některé jsou součástí aplikace samotné, jako například obrázky, styly a skripty. Jiné představují data, nahraná do aplikace - třeba obrázky v článcích nebo přílohy. Jakým způsobem s nimi zacházet, kde je ukládat a jak je zpřístupňovat?

Webové aplikace historicky vznikly jako rozšíření převážně statických webů. Klasické ASP nebo ASP.NET &leq; 4.x, PHP a řada dalších technologií nemají pro statické soubory žádné zvláštní mechanismy, jednoduše protože je nepotřebují. Pokud někam do WWW rootu umístíte soubor bez speciálně zaregistrované přípony (`.aspx` apod.), prostě se vezmou a pošlou klientovi, když o ně požádá.

S příchodem ASP.NET Core/5.0 se situace změnila.

## Soubory jsoucí součástí aplikace

V první řadě je třeba se zaměřit na soubory, které jsou součástí aplikace. Nasazují se společně s ní a nemění se, jenom při nasazení nové verze aplikace. Aplikace je tedy nijak nemodifikuje ani nepřidává nové. Typicky se jedná o obrázky, styly, skripty, favicon a podobné soubory.

V ASP.NET 5.0 je aplikace hostována zcela jiným způsobem a chcete-li podporu pro statické soubory musíte ji explicitně přidat pomocí _static files middleware_. Což je speciální middleware, který umí zpřístupnit konkrétní složku.

Návod pro práci s tímto middlewarem v angličtině najdete na [docs.microsoft.com](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/static-files?view=aspnetcore-5.0) a v češtině jsem udělal následující [krátké video demo](https://youtu.be/6C9wCIAe6_Y):

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/6C9wCIAe6_Y" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

## Pracovní soubory aplikace

Druhou rodinu představují soubory, které jsou pracovními daty aplikace. Například v případě publikačního systému se může jednat o nahrané obrázky k článkům, v jiných případech o přílohy nahrané jedním uživatelem určené ke stažení dalšími uživateli a podobně.

Pro tento účel je použití static files middleware naprosto nevhodné a soubory tohoto typu by neměly být ukládány do webového prostoru aplikace (do složky `wwwroot`) ale někam mimo a zpřístupněny jiným způsobem. Důvodů pro to je několik:

* Static files middleware záměrně neobsahuje žádný mechanismus kontroly přístupu, autentizaci a autorizaci. Znalost názvu/adresy souboru je dostatečná pro to, aby soubor získal kdokoliv.
* Nahrávání souborů do WWW rootu komplikuje nasazení a aktualizaci aplikace. Při deploymentu nové verze si musíte pamatovat, že _tyhle_ soubory nesmíte přepsat nebo smazat, protože s nimi aplikace pracuje.
* Při hostování aplikace v cloudu (např. Azure App Service, dříve Azure Web Apps) zpravidla klasického diskového prostoru nemáte k dispozici příliš mnoho a nepočítá se s tím že byste si lokálně ukládali nějaká trvalá pracovní data.

Je tedy rozumnější obecné soubory ukládat někam jinam, mimo WWW root a možná zcela mimo váš web server a aplikaci na to připravit. Možná úložiště jsou:

* Lokální server, ale adresář mimo vlastní aplikaci.
* Dedikovaný file server ve vlastní infrastruktuře.
* Databázový BLOB.
* Cloudové úložiště s přímým odkazem.
* Cloudové úložiště s vlastní publikací.

## Lokální souborové úložiště

Nejjednodušší varianta, použitelná zejména u on-premises řešení nebo na klasickém hostovaném serveru/vm. Data jsou uložena buďto na tom samém serveru jako web nebo na separátním file serveru.

Např. typické fyzické umístění rootu vašeho webu může být v IIS na cestě `D:\www-servers\example\www.example.com`. Datový adresář pak můžete mít třeba v `D:\www-servers\example\files`. Pak si napíšete jednoduchý MVC controller, který na základě předaného parametru najde správný soubor a pošle ho klientovi.

Příslušný zdrojový kód může vypadat třeba takto:

```cs
public class FilesController : Controller {
    // In real world app, the hardcoded values will be replaced with a configuration option
    private const string FolderPath = @"D:\www-servers\example\files";
    private static readonly TimeSpan CacheMaxAge = TimeSpan.FromDays(365);

    [Route("/files/{filename:regex(^[[a-zA-Z0-9-_]]+\\.[[a-zA-Z0-9-_]]+$)}")]
    public IActionResult SendFile(string fileName) {
        // Construct the physical file name
        var physicalPath = System.IO.Path.Combine(FolderPath, fileName);

        // Check if file exists
        if (!System.IO.File.Exists(physicalPath)) return this.NotFound();

        // Get content type
        var ep = new FileExtensionContentTypeProvider();
        var isKnownType = ep.TryGetContentType(Path.GetExtension(physicalPath), out var contentType);
        if (!isKnownType) contentType = "application/octet-stream";

        // Enable caching
        this.HttpContext.Response.Headers.Add("Cache-Control", $"public, max-age={CacheMaxAge.TotalSeconds}");

        // Send the file
        return this.PhysicalFile(physicalPath, contentType);
    }
}
```

Metoda `SendFile` dělá následující věci:

1. Spočítá fyzickou cestu k souboru na disku (`physicalPath`). Název souboru se načítá z route parametru, který kontroluje, zda název souboru obsahuje pouze písmena, číslice, pomlčku, podtržítko a právě jednu tečku a příponu. **Je z bezpečnostního hlediska kritické zajistit, aby byl název souboru validován,** aby například nebylo možné pomocí sekvence znaků `..` vyskočit o úroveň výše a nechat si poslat libovolný soubor z disku, k němuž má aplikace přístup, a který může obsahovat potenciálně citlivá data (např. connection string v konfiguračním souboru).
1. Ověří si, že soubor existuje. Pokud ne, vrátí chybu _404 Not Found_.
1. Pomocí třídy `FileExtensionContentTypeProvider`, která je součástí Static Files Middleware se pokusí zjistit Content-Type, který odpovídá dané příponě souboru. Pokud se jedná o neznámý typ souboru, použije se hodnota `application/octet-stream`, což znamená obecný proud bajtů bez známého typu.
1. Povolí cacheování souboru na nastavenou dobu, zde jeden rok. V reálné aplikaci by možná bylo vhodné aplikovat nějakou sofistikovanější logiku ohledně toho, jak se má cacheovat, v zásadě na povaze zasílaných dat.
1. Voláním metody `PhysicalFile` odešle daný soubor na klienta. Tento overload se postará o vše potřebné, např. nastavení hlaviček `Content-Length` a `Last-Modified` v odpovědi nebo o zpracování požadavků obsahujících hlavičku `Range` a požadujících zaslání pouze části souboru.

Route je nastavená tak, že pokud se zeptáte na adresu např. `http://localhost:5000/files/soubor.jpg`, pošle se soubor jsoucí na disku v cestě `D:\www-servers\example\files\soubor.jpg`.

Samozřejmě zde můžete mít nějakou sofistikovanější logiku - uvedený kód je v podstatě minimální možný. V reálné aplikaci budete obvykle implementovat alespoň některé z následujících funkcí:

* Autentizaci a autorizaci - ověření, že uživatel má právo si daná data stáhnout.
* Podporu podmíněných požadavků na základě hlavičky `If-Modified-Since`.
* Nějakou sofistikovanější logiku určení cesty k souboru. Reálná cesta k souboru může být uložena například v databázi a uživatel může požadovat soubor bez znalosti jeho názvu, jenom například podle ID. K určení názvu souboru při downloadu můžete pooužít jiné overloady metody `PhysicalFile`.

## Databázový BLOB

Relační databáze umožňují ukládat do polí tabulky i obecná binární data, kterým se v tomto kontextu říká BLOBy, přičemž tato zkratka znamená _Binary Large OBject_. V Microsoft SQL Serveru je k tomu určen zejména datový typ `varbinary` potažmo `varbinary(max)`.

**Obecně není dobrý nápad ukládat binární soubory do databáze**, a to zejména z důvodů výkonových a finančních. Nicméně každé pravidlo má své výjimky. Výhodou ukládání binárních dat do databáze je, že se s nimi snadno pracuje, snadno se udržuje referenční integrita, snadno se zálohují a podobně.

Pokud se jedná o objemově malá data (v řádu jednotek megabajtů per záznam) a není jich mnoho, může být ukládání do databáze cesta nejmenšího odporu. Typickým příkladem může být například ikona uživatele. To je typicky obrázek o velikosti pár kilobajtů, který je typicky nejsnazší nacpat do dalšího pole v tabulce, než jenom kvůli němu budovat nějakou storage infrastrukturu.

## Cloudové úložiště s přímým odkazem

Existují cloudové služby, které umožňují ukládat data, která jsou pak dostupná přímým odkazem. Například Microsoft Azure Blob Storage nebo [Backblaze B2](https://www.backblaze.com/b2/cloud-storage.html) (je podstatně lacinější než Azure). I pokud vaše aplikace neběží v cloudu, můžete chtít ukládat binární data do tohoto druhu storage, protože je to zpravidla levné a velice spolehlivé.

Storage lze nastavit tak, že prostě stačí zadat správnou adresu a soubor se stáhne. Ideální v případě, že nechcete řešit autentizaci a autorizaci a je vám jedno, jak adresa vypadá.

Pokud autentizaci potřebujete, můžete v Azure vytvořit speciální URL, obsahující takzvanou SAS - _Shared Access Signature_. Pomocí ní můžete omezit (věcně i časově) právo s blobem nakládat, aniž byste museli cokoliv zvláštního programovat. Podrobnější informace o SAS najdete v mém [starším článku](https://www.altair.blog/2013/05/windows-azure-storage-a-shared-access-signatures).

Poslední možnost je, že si data ze storage stáhnete na web server a pošlete klientovi. To budete dělat zejména ve chvíli, kdy vám záleží na tom, jaká bude URL "souboru" a nechcete tam mít systémovou adresu storage.

> _Poznámka:_ Tento článek je inspirován dotazem, který jsem dostal na školení. Účastník se zmiňoval i o tom, jak to dělám na tomto blogu. Tento blog je zvláštní případ, protože se nejedná o webovou aplikaci v .NET. Tento blog je sbírka statických stránek, které jsou hostované ve službě _GitHub Pages_. Statické soubory jsou generovány pomocí nástroje [XML4web](https://github.com/ridercz/XML4web) a celý repozitář blogu je [volně dostupný](https://github.com/ridercz/Blog). Část obrázků je uložena na GitHubu (pozadí článku, malé čtvercové obrázky u perexů apod.), obrázky v článcích jsou [linkovány z CDN](https://www.cdn.altairis.cz/).