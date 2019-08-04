<!-- dcterms:title = Podepisování URL ještě jednou -->
<!-- dcterms:abstract = Nedalo mi to a ještě jednou jsem se podíval na podepisování URL, které bylo tématem včerejšího článku. Přidal jsem (částečnou) ochranu proti replay útokům a vše vyčlenil do samostatné knihovny a NuGet balíčku. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20190804-url-signer-jeste-jednou.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20190804-url-signer-jeste-jednou.jpg -->
<!-- x4w:coverCredits = Aron Visuals via unsplash.com -->
<!-- x4w:category = Bezpečnost -->
<!-- x4w:category = IT -->
<!-- dcterms:dateAccepted = 2019-08-04 -->

Nedalo mi to a ještě jednou jsem se podíval na podepisování URL, které bylo tématem [včerejšího článku](https://www.altair.blog/2019/08/url-signer). V jeho závěru jsem jako jednu z limitací tohoto řešení uvedl, že nenabízí ochranu proti replay útokům, tj. že podepsané URL lze použít opakovaně. To může být někdy vyloženě žádoucí, ale jindy to může být problém.

## Třída `TimedUrlSigner`

Při řešení tohoto problému jsem se inspiroval v _ASP.NET Data Protection_, kde existuje metoda `ToTimeLimitedDataProtector`, která přidá data protectoru funkcionalitu omezení časové platnosti. Funguje to tak, že se jako součást podepsaného payloadu zadá datum a čas, kdy má expirovat. Po ověření podpisu se prostě tento údaj porovná s aktuálním časem a pokud již tento čas uplynul, prohlásí se podpis za neplatný. Protože je expirace podepsaná, nemůže ji útočník modifikovat.

Vytvořil jsem tedy třídu `TimedUrlSigner`, která je jakýsi wrapper nad `IUrlSigner` a výše uvedené zajišťuje. 

Metoda `Sign` dostala ještě jeden parametr `ttl`, což je doba, po kterou má být podpis platný. K URL se před podepsáním ještě přidá parametr `exp`, který určuje čas expirace. Čas je udáván jako počet sekund od půlnoci 1. 1. 2019.

Metoda `Verify` pak nejprve ověří podpis jako takový a pak se podívá, jestli již neexpiroval.

Toto je zdrojový kód třídy `TimedUrl`:

```cs
public class TimedUrlSigner {
    private static readonly DateTime ZeroTime = new DateTime(2019, 1, 1, 0, 0, 0, DateTimeKind.Utc);
    public IUrlSigner Signer { get; }

    public TimedUrlSigner(IUrlSigner signer) {
        this.Signer = signer;
    }

    // Helper methods for working with URIs

    public Uri Sign(Uri url, TimeSpan ttl) => new Uri(this.Sign(url.ToString(), ttl));

    public bool Verify(Uri url) => this.Verify(url.ToString());

    // TTL-aware signing and verification

    public string Sign(string url, TimeSpan ttl) {
        if (url == null) throw new ArgumentNullException(nameof(url));
        if (string.IsNullOrWhiteSpace(url)) throw new ArgumentException("Value cannot be empty or whitespace only string.", nameof(url));

        // Append expiration timestamp
        var expTimeStamp = DateTime.UtcNow.Add(ttl).Subtract(ZeroTime).TotalSeconds;
        url += (url.Contains("?") ? "&" : "?") + "exp=" + expTimeStamp.ToString();

        // Sign value with configured signer
        return this.Signer.Sign(url);
    }

    public bool Verify(string url) {
        if (url == null) throw new ArgumentNullException(nameof(url));
        if (string.IsNullOrWhiteSpace(url)) throw new ArgumentException("Value cannot be empty or whitespace only string.", nameof(url));

        // Perform signature verification
        var result = this.Signer.Verify(url);
        if (!result) return false;

        // Get expiration timestamp
        var unsignedUrl = url.RemoveLastParameter("sig", out var _);
        unsignedUrl.RemoveLastParameter("exp", out var expString);

        // Compare with current time
        var expTime = ZeroTime.AddSeconds(double.Parse(expString));
        return expTime >= DateTime.UtcNow;
    }

}
```

Nad `IUrlSigner` jsem pak definoval extension metodu `ToTimedSigner`, která z libovolné implementace udělá časově omezenou. Při dobré paměti jsem ještě přidat pár testů pomocí xUnit frameworku.

## Projekt Altairis.Services.UrlSigner

Moje původní myšlenka byla, že celé řešení bude natolik jednoduché, že nebude třeba ho vyčleňovat do samostatné knihovny. Nyní se mi to ale poněkud zvrhlo, takže jsem veškerou funkcionalitu vyčlenil do samostatného projektu `Altairis.Services.UrlSigner`:

* GitHub: [`ridercz/Altairis.Services.UrlSigner`](https://github.com/ridercz/Altairis.Services.UrlSigner)
* NuGet: [`Altairis.Services.UrlSigner`](https://www.nuget.org/packages/Altairis.Services.UrlSigner)