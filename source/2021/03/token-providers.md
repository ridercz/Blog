<!-- dcterms:title = Proč chcete vlastního token providera pro ASP.NET Identity a jak ho napsat -->
<!-- dcterms:abstract = Potvrzení registrace nebo změna e-mailové adresy a reset hesla vyžadují zaslání potvrzovacího tokenu e-mailem, nejčastěji v podobě odkazu. Standardní implementace v ASP.NET Identity využívá kódování Base64, což s sebou nese jisté problému. Ukážu vám, jak místo toho použít kódování ZBase32 a k čemu je to vlastně dobré. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:coverUrl = /cover-pictures/20210308-token-providers.jpg -->
<!-- x4w:pictureUrl = /perex-pictures/20210308-token-providers.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = IT -->
<!-- x4w:category = Bezpečnost -->
<!-- dcterms:dateAccepted = 2021-03-08 -->

Pro řadu scénářů v ASP.NET Identity potřebujeme nějaký potvrzovací kód (token) který pošleme uživateli a on pomocí něj potvrdí, že je skutečně tím, za koho se vydává. V tomto článku budeme řešit tři takové situace:

* Potvrzení e-mailové adresy po prvotní registraci.
* Potvrzení nové e-mailové adresy při její změně.
* Reset hesla.

Ve všech zmíněných případech se postupuje následovně:

1. Pomocí metody např. `GeneratePasswordResetTokenAsync` vygeneruje `UserManager` patřičný token.
1. Vygenerujeme URL, která tento token obsahuje, typicky v query stringu, něco jako `https://www.example.com/reset-password?user=johndoe&token=XXXXX`.
1. Zašleme uživateli e-mailem zprávu s vygenerovanou adresou a instrukcí, že má tuto stránku navštívit, aby si zresetoval heslo.
1. Na této stránce zavoláme metodu např. `ResetPasswordAsync`, v níž ověříme kód a zresetujeme heslo nebo potvrdíme e-mail.

## Strategie generování tokenů

Existují v zásadě dvě možnosti (strategie) jak tokeny generovat.

První možnost je, že token je náhodně vygenerován (je bezvýznamový) a někde na straně serveru je uloženo, že token `ABCDEF` slouží třeba k potvrzení resetu hesla uživatele XYZ. Výhodou těchto tokenů je, že mohou být (relativně) krátké, protože stačí zařídit, aby nemohlo dojít k brute force útoku nebo konfliktu. Zásadní nevýhodou ovšem je nutnost udržovat na straně serveru odpovídající úložiště.

Druhá možnost je místo úložiště použít kryptografii. Token zaslaný uživateli obsahuje nějaké "hodnotné" informace (třeba že jde o reset hesla uživatele s ID 1234) a tato informace je digitálně podepsána a zašifrována. To zajistí, že token není možné podvrhnout.

Výchozí implementaci v ASP.NET Identity představuje třída `DataProtectorTokenProvider`, jejíž [zdrojový kód najdete na GitHubu](https://github.com/dotnet/aspnetcore/blob/main/src/Identity/Core/src/DataProtectorTokenProvider.cs). Ta pro ochranu tokenu používá druhý zmíněný způsob. Vygeneruje token obsahující účel a ID uživatele a poté ho ochrání (zašifruje a podepíše) pomocí ASP.NET Data Protection.

Výsledkem je hromádka binárních dat, které se zakódují pomocí Base64.

## Problémy s Base64

Base64 je jedna z mnoha možností, jak binární hodnoty zakódovat do tisknutelných znaků. Používá se přitom "šedesátičtyřková" číselná soustava, která obsahuje velká a malá písmena anglické abecedy, číslice a znaky plus a lomítko. Výhodou Base64 je, že jde o univerzální, standardizovaný mechanismus, který je dostupný na všech platformách. Má také relativně malý overhead (33 %).

Má ale i signifikantní nevýhody:

* Obsahuje znaky `+` a `/`, které mají v URL (kde se tokeny obvykle vyskytují) speciální význam. Je tedy nutné je buďto zakódovat, nebo použít speciální url-safe variantu, kde jsou nahrazeny znaky `-` a `_`. Tu ale .NET standardně nepodporuje.
* V závislosti na délce vstupních dat se může na konci vyskytnout jeden nebo dva znaky `=`, jako padding.

Tyto speciální znaky mohou představovat problém třeba v některých e-mailových programech, které nesprávně automaticky generují z odkazů hyperlinky nebo zalamují řádky.

## Base32 a ZBase32

Existují i různé jiné další možnosti kódování. Jedním z nich je Base32. To používá omezenější abecedu o 32 znacích. V závislosti na konkrétní implementaci může obsahovat různou kombinaci písmen a číslic. Často bývá použita kombinace, která neobsahuje znaky, které jsou vizuálně záměnné, jako například písmeno `O` a nulu `0`. To sice vede k většímu overheadu, ale řeší problém se "speciálními" znaky.

Variantou je kódování ZBase32, které jako ["human-oriented base-32 encoding"](https://philzimmermann.com/docs/human-oriented-base-32-encoding.txt) navrhl Phil Zimmermann. Používá pouze běžná písmena a číslice a nepotřebuje padding. Nevýhodou je, že výsledek je delší, než v případě Base64, ale s tím dokážeme žít.

## Vlastní implementace Token Providera

Výše zmíněnou implementaci lze nahradit vlastní. Zdrojový kód je k dispozici, takže bychom jej mohli prostě zkopírovat a Base64 kódování nahradit vlastním ZBase32. S licencí není problém, Apache licence takový postup umožňuje. Nicméně museli bychom duplikovat spoustu kódu, navíc implementace využívá interní extensions pro logování... A vlastně ani nechceme do funkce příliš zasahovat, jenom použít jiný druh kódování. Takže jsem napsal wrapper, který volá funkce výchozí implementace a jenom je překóduje do ZBase32.

Zdrojový kód mé třídy `ZBase32DataProtectorTokenProvider` vypadá takto:

```
public class ZBase32DataProtectorTokenProvider<TUser> : DataProtectorTokenProvider<TUser> where TUser : class {
    public ZBase32DataProtectorTokenProvider(IDataProtectionProvider dataProtectionProvider, IOptions<DataProtectionTokenProviderOptions> options, ILogger<DataProtectorTokenProvider<TUser>> logger)
        : base(dataProtectionProvider, options, logger) { }

    public async override Task<string> GenerateAsync(string purpose, UserManager<TUser> manager, TUser user) {
        var b64string = await base.GenerateAsync(purpose, manager, user).ConfigureAwait(false);
        var bytes = Convert.FromBase64String(b64string);
        return Base32Encoding.ZBase32.GetString(bytes);
    }

    public override Task<bool> ValidateAsync(string purpose, string token, UserManager<TUser> manager, TUser user) {
        var bytes = Base32Encoding.ZBase32.ToBytes(token);
        var b64string = Convert.ToBase64String(bytes);
        return base.ValidateAsync(purpose, b64string, manager, user);
    }
}
```

Pro vlastní kódování používám knihovnu [Wiry.Base32](https://github.com/wiry-net/Wiry.Base32). Metody `GenerateAsync` a `ValidateAsync` jenom obalují bázovou třídu a překódovávají token z/do Base32.

Dále pak je třeba ASP.NET Identity říct, že má náš token provider použít. To se děje při registraci identity, typicky tedy v metodě `ConfigureServices` třídy `Startup`:

```
services.AddIdentity<ApplicationUser, ApplicationRole>(options => {
    options.Tokens.ChangeEmailTokenProvider = "ZBase32";
    options.Tokens.EmailConfirmationTokenProvider = "ZBase32";
    options.Tokens.PasswordResetTokenProvider = "ZBase32";
})
    .AddDefaultTokenProviders()
    .AddTokenProvider<ZBase32DataProtectorTokenProvider<ApplicationUser>>("ZBase32");
```

V `options.Tokens` můžeme nastavit, pro jaké typy tokenů se má použít jaký provider. Používají se totiž různé, pro tokeny do URL je třeba jiný mechanismus než třeba pro tokeny zasílané SMSkou, které uživatel bude odesílat. Říkáme tedy, že se má použít provider jménem `ZBase32`.

Metodou `AddDefaultTokenProviders` přidáme výchozí implementace pro všechny účely a pak pomocí `AddTokenProvider` zaregistrujeme pod jménem `ZBase32` naši implementaci.

A to je celé. Aplikaci stačí restartovat a místo Base64 se pro generování tokenů použije jednodušší ZBase32.