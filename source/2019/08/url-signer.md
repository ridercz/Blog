<!-- dcterms:title = Podepisování URL snadno a rychle -->
<!-- dcterms:abstract = Pro jeden svůj projekt jsem potřeboval udělat řešení na podepisování URL, resp. parametrů v něm. Napsal jsem na to univerzální řešení, které se může hodit i vám. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20190803-url-signer.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20190803-url-signer.jpg -->
<!-- x4w:category = Bezpečnost -->
<!-- x4w:category = IT -->
<!-- dcterms:dateAccepted = 2019-08-03 -->

Píšu aplikaci, ve které je třeba zajistit bezpečnou komunikaci pomocí odkazů: jedna volá druhou a je třeba zajistit, aby parametry v odkazu nemohl být modifikovány. Je tedy třeba je nějakým způsobem podepsat. Napsal jsem řešení, které to umí zařídit. Je psáno v ASP.NET Core a navrženo tak, aby se dalo zapojit do jeho IoC/DI infrastruktury.

## Interface `IUrlSigner`

Nejvyšší úroveň představuje rozhraní `IUrlSigner`. Vypadá takto:

```cs
public interface IUrlSigner {

    string Sign(string url);

    Uri Sign(Uri url);

    bool Verify(string url);

    bool Verify(Uri url);

}
```

Metoda `Sign` dostane na vstupu URL, které má být podepsáno, a vrátí jeho podepsanou verzi. Metoda `Verify` dostane podepsané URL a vrátí `true` nebo `false`, podle toho, jestli je podpis správný nebo ne. Každá z metod má dva overloady, které umožňují hodnoty předávat buďto jako `string` nebo jako `Uri` - někdy se hodí to, někdy ono.

Interface definuji protože se to hodí pro použití v rámci IoC/DI scénářů a protože to umožňuje mít několik implementací, které bude možné záměnně použít.

První implementace se jmenuje `NullUrlSigner` a je významná tím, že nic nedělá. URL nijak nemění a verifikace vždy vrátí `true`:

```cs
public class NullUrlSigner : IUrlSigner {

    public string Sign(string url) => url;

    public Uri Sign(Uri url) => url;

    public bool Verify(string url) => true;

    public bool Verify(Uri url) => true;

}
```

K čemu je taková implementace dobrá? Třeba pro prvotní fáze vývoje a testování, kdy chceme testovat funkčnost implementace s různými parametry a zatím neřešit podepisování. Až bude vše hotovo, můžeme nulovou implementaci nahradit něčím sofistikovanějším a funkčním.

## Abstraktní třída `UrlSigner`

Další stupeň je abstraktní třída `UrlSigner`, která implementuje `IUrlSigner` a dělá režii, v podstatě všechno kromě vlastního podepisování.

* Implementuje ty overloady metod `Sign` a `Verify`, které pracují s typem `Uri`. Ty jenom převedou tento typ na `string` a naopak a volají jiné overloady.
* Implementuje metodu `Sign` se stringovým parametrem. Předanou hodnotu podepíše a pak přidá query stringový parametr `sig`, jehož hodnotou je URL-safe Base64 kódovaný podpis. Pokud původní URL již query string obsahuje, přidá se na konec `&sig=hodnota`, pokud neobsahuje, použije se místo ampersandu otazník.
* Implementuje metodu `Verify` se stringovým parametrem. Ta proparsuje zadanou URL (odstraní z ní parametr `sig`), dekóduje podpis z URL-safe Base64 a ověří jeho platnost.
* Definuje abstraktní metody `GetSignature` a `VerifySignature`, které budou v poděděných třídách řešit vlastní vytváření a ověření podpisu.

> [Base64](https://en.wikipedia.org/wiki/Base64) je způsob kódování binárních dat. Umožňuje převést obecná binární data (jako třeba elektronický podpis) do textové podoby, vlastně do šedesát čtyřkové soustavy. Používá jako číslice znaky A-Z, a-z, 0-9 a znaky `+` a `/` (kromě toho se ještě používá znak `=` jako případný padding na konci). Problémem může být, že znaky `+` a `/` mají speciální význam v rámci URL. Proto [RFC4648](https://tools.ietf.org/html/rfc4648#section-5) definuje "URL-safe" variantu, která místo nich používá znaky `-` a `_`.

Zdrojový kód třídy `UrlSigner` vypadá takto:

```cs
public abstract class UrlSigner : IUrlSigner {

    // Abstract methods to be implemented in derived classes

    protected abstract byte[] GetSignature(byte[] data);

    protected abstract bool VerifySignature(byte[] data, byte[] sig);

    // Helper methods for working with URIs

    public Uri Sign(Uri url) => new Uri(this.Sign(url.ToString()));

    public bool Verify(Uri url) => this.Verify(url.ToString());

    // Public methods

    public virtual string Sign(string url) {
        if (url == null) throw new ArgumentNullException(nameof(url));
        if (string.IsNullOrWhiteSpace(url)) throw new ArgumentException("Value cannot be empty or whitespace only string.", nameof(url));

        // Convert string to array of bytes
        var data = Encoding.UTF8.GetBytes(url);

        // Compute signature
        var sigData = this.GetSignature(data);

        // Convert it to URL-safe Base64
        var sigString = Convert.ToBase64String(sigData).Replace('+', '-').Replace('/', '_');

        // Append signature
        url += (url.Contains('?') ? "&" : "?") + "sig=" + sigString;
        return url;
    }

    public virtual bool Verify(string url) {
        if (url == null) throw new ArgumentNullException(nameof(url));
        if (string.IsNullOrWhiteSpace(url)) throw new ArgumentException("Value cannot be empty or whitespace only string.", nameof(url));

        // Try to parse the signed URL
        var lastSeparatorIndex = url.LastIndexOfAny("?&".ToCharArray());
        if (lastSeparatorIndex < 1 || lastSeparatorIndex > url.Length - 6 || !url.Substring(lastSeparatorIndex + 1, 4).Equals("sig=")) return false;
        var urlString = url.Substring(0, lastSeparatorIndex);
        var sigString = url.Substring(lastSeparatorIndex + 5).Replace('-', '+').Replace('_', '/');
        var urlData = Encoding.UTF8.GetBytes(urlString);
        var sigData = Convert.FromBase64String(sigString);

        // Verify signature
        return this.VerifySignature(urlData, sigData);
    }

}
```

## Třída `HmacUrlSigner`

Rozhraní `IUrlSigner` definuje API. Abstraktní třída `UrlSigner` pak obsahuje funkcionalitu, která bude patrně společná prakticky všem implementacím - přidání podpisu do URL a mechanismus jeho ověření. Abstraktní třída však neřeší vlastní výpočet podpisu, jenom definuje metody které to mají dělat. Tyto metody musíme implementovat v poděděné třídě, aby byla implementace kompletní.

* Metoda `GetSignature` dostane na vstupu data která má podepsat, tedy podepisovanou URL. Vrací hotový podpis. 
* Metoda `VerifySignature` dostane na vstupu podepsaná data a hodnotu podpisu. Vrací `true` nebo `false`, podle toho zda podpis sedí nebo nikoliv.

Data se předávají jako `byte[]`, protože kryptografické algoritmy obecně pracují právě s polem bajtů, nikoliv třeba s řetězci.

Existují principiálně dva způsoby, jak URL podepisovat:

* Symetrické řešení na bázi [HMAC (Hash-based Message Authentication Code)](https://en.wikipedia.org/wiki/HMAC).
* Asymetrické řešení využívající algoritmy jako RSA nebo DSA.

Moje řešení využívá HMAC. Je jednodušší na implementaci, ale jeho nevýhodou je, že obě strany (podepisující i ověřující) používají tentýž klíč, který musí být držen v tajnosti a kdokoliv může podpis ověřit, může jej i padělat. To pro náš scénář nepředstavuje problém, takže se vydáme touto cestou.

HMAC zjednodušeně řečeno funguje tak, že se k podepisovaným datům přidá tajný klíč a spočítá se hash tohoto součtu. Lze použít jakýkoliv hashovací algoritmus, což v dnešní době znamená, že chceme použít něco z rodiny SHA-2, např. SHA-256 nebo SHA-512. Starší algoritmy jako MD5 nebo SHA-1 mohou být za určitých okolností pro HMAC účely stále použitelné, ale u nového řešení k tomu není důvod.

V .NETu existuje bázová třída `System.Security.Cryptography.KeyedHashAlgorithm`, od které jsou pak poděděné implementace využívající různé hashovací funkce, jako například `HMACSHA256`, `HMACSHA384` nebo `HMACSHA512`. Všechny můžeme používat, nabízejí pro většinu případů ekvivalentní úroveň bezpečnosti. Proto definujeme třídu `HmacUrlSigner` takto, jako generickou:

```cs
public class HmacUrlSigner<TAlg> : UrlSigner where TAlg : KeyedHashAlgorithm, new()
```

Typový parametr `TAlg` určuje použitý hashovací algoritmus. Constraint říká, že to musí být třída poděděná od `KeyedHashAlgorithm` a že musí mít bezparametrický konstruktor.

Třída `HmacUrlSigner<TAlg>` vypadá takto:

```cs
public class HmacUrlSigner<TAlg> : UrlSigner where TAlg : KeyedHashAlgorithm, new() {
    readonly TAlg hmac;

    public HmacUrlSigner(byte[] key) {
        this.hmac = new TAlg { Key = key };
    }

    protected override byte[] GetSignature(byte[] data) => this.hmac.ComputeHash(data);

    protected override bool VerifySignature(byte[] data, byte[] sig) {
        if (data == null) throw new ArgumentNullException(nameof(data));
        if (sig == null) throw new ArgumentNullException(nameof(sig));

        // Compute correct signature
        var correctSig = this.GetSignature(data);
        if (correctSig.Length != sig.Length) return false;

        // Constant time compare
        var result = 0;
        for (var i = 0; i < correctSig.Length; i++) {
            result |= sig[i] ^ correctSig[i];
        }
        return result == 0;
    }

}
```

Metoda `GetSignature` je přímočará, pouze volá metodu `ComputeHash` příslušné implementace `KeyedHashAlgorithm`. Metoda `VerifySignature` spočítá správnou signaturu a výsledek porovná. Je zajímavá jenom poněkud komplikovanou metodou porovnání. Nejjednodušší a obecně nejrychlejší by bylo porovnání napsat takto:

```cs
for (var i = 0; i < correctSig.Length; i++) {
    if (sig[i] != correctSig[i]) return false;
}
return true;
```

Takto zapsaný kód se ale nehodí pro kryptografické účely jako je např. porovnávání podpisu. Otevřel by naše řešení timing útoku, protože útočník by podle doby, jak dlouho kód běží, mohl poznat, "jak daleko se v podpisu trefil". Je žádoucí, aby proces porovnávání vždycky běžel stejně dlouho, bez ohledu na konkrétní hodnoty a jak moc se liší. 

Proto používáme specifickou konstrukci, kdy pomocí operátoru `^` spočítáme XOR obou hodnot a pak je pomocí operátoru `|=` logicky přičteme k hodnotě `result`, která je na začátku nula. Pokud je to nula i na konci je jasné, že se hodnoty shodují.

## Registrace a použití

Následujícím kódem v metodě `Configure` třídy `Startup` zaregistrujeme patřičnou implementaci `IUrlSigner` do IoC/DI kontejneru:

```cs
var keyString = this.configuration["SigningKey"];
if (string.IsNullOrEmpty(keyString)) {
    services.AddSingleton<IUrlSigner>(x => new NullUrlSigner());
} else {
    services.AddSingleton<IUrlSigner>(x => new HmacUrlSigner<HMACSHA512>(Convert.FromBase64String(keyString)));
}
```

Pokud je v konfiguraci zadána hodnota `SigningKey`, zaregistruje se `HmacUrlSigner<HMACSHA512>` a klíč se třídě předá jako argument konstrukturu. Pokud hodnota zadána není, podepisovat se nebude a použije se `NullUrlSigner`.

Použití je pak triviální. Na potřebné místo nainjectujeme `IUrlSigner` a zavoláme metody `Sign` nebo `Verify`.

## Omezení a neřešené problémy

Výše popsaná metoda, kdy při absenci klíče nic nešifrujeme, není z hlediska bezpečnosti ideální, protože při výchozí (prázdné) konfiguraci aplikace funguje, leč nikoliv bezpečně, takže uživateli nedojde, že má někam zadat nějaký klíč. To ale není problém UrlSigneru, ale jeho použití a je na programátorovi aplikace, jak jej do své aplikace začlení, pro potřeby dema je výše uvedený postup dobrý dost.

Druhým problémem může být, že uvedená implementace neřeší takzvaný replay attack. Tedy neřeší situaci, kdy bude tentýž (podepsaný) odkaz použit vícekrát. Což může a nemusí být problém, v závislosti na tom, jak konkrétně bude odkaz použit a k čemu bude sloužit. Někdy je možnost opakovaného použití naopak žádoucí. 

Pokud bychom chtěli replay attack řešit, je to možné udělat například tím, že se k podpisu přidá nějaké "počítadlo" a ověřující strana bude hlídat, zda nová zpráva má hodnotu počítadla větší než předchozí. To ale znamená, že si musí obě strany někde v trvalém úložišti držet poslední známou hodnotu počítadla.

Další řešení může spočívat v tom, že součástí podpisu bude časové razítko a bude mít omezenou platnost. To znamená, že obě strany musejí mít synchronizovaný čas a replay attack je sice možný, ale jenom po omezenou dobu (dokud podpis nevydrží).

Pokud vás zajímá, k čemu může být podepisování URL dobré, vyčkejte. Mám rozepsaný další článek, který představí praktický projekt, který ho využívá a z jehož projektu jsem převzdal ukázkový kód v tomto článku.