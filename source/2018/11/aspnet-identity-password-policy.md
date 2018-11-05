<!-- dcterms:title = Vlastní rozumná politika hesel v ASP.NET Identity -->
<!-- dcterms:abstract = ASP.NET Identity je nástupce Membership a Role providerů z .NET 2.0. Obecně se jedná o úkaz pozitivní, nicméně jeho výchozí politika hesel je dosti pomýlená. Naštěstí ji lze poměrně snadno změnit a dokonce si napsat vlastní, lepší. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20110103-reset-zapomenuteho-hesla-jak-to-delat-spravne.png -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = IT -->
<!-- x4w:category = Bezpečnost -->
<!-- dcterms:dateAccepted = 2018-11-06 -->

ASP.NET Identity je nástupce Membership a Role providerů z .NET 2.0. Obecně se jedná o úkaz pozitivní, nicméně jeho výchozí politika hesel je dosti pomýlená. Naštěstí ji lze poměrně snadno změnit a dokonce si napsat vlastní, lepší.

## Výchozí pravidla a jejich změna

Nejjednodušší inicializace ASP.NET Identity s výchozími hodnotami vypadá v metodě `ConfigureServices` nějak takto:

```csharp
services.AddDefaultIdentity<IdentityUser>()
    .AddEntityFrameworkStores<ApplicationDbContext>();
```

Výchozí politika říká, že heslo musí mít nejméně šest znaků a musí obsahovat nejméně jedno velké písmeno, jedno malé písmeno, jednu číslici a jeden nealfanumerický znak. Nepokládám ji za rozumnou. Myslím si, že minimální délka hesla by měla být delší (12, nebo ještě lépe 20 znaků), ale neměla by po uživateli vyžadovat zadávání specifických skupin znaků.

Jednotlivé komponenty politiky lze zapínat či vypínat v konfiguraci, příkladmo takto:

```csharp
services.AddDefaultIdentity<IdentityUser>(o => {
    o.Password.RequiredLength = 12;
    o.Password.RequireDigit = false;
    o.Password.RequireLowercase = false;
    o.Password.RequireNonAlphanumeric = false;
    o.Password.RequireUppercase = false;
})
    .AddEntityFrameworkStores<ApplicationDbContext>();
```

Kromě výše zmíněných parametrů lze ještě nastavit `o.Password.RequiredUniqueChars`, což je minimální počet různých znaků, které heslo musí obsahovat. Tato politika je nicméně ve výchozím nastavení vypnutá (hodnota je nastavena na `1`).

## Vytvoření vlastních pravidel

Pravidla definovaná výše uvedeným způsobem mi nepřijdou úplně vhodná. Na druhou stranu ale doporučuji přidat trochu jiná pravidla, která ASP.NET Identity neumí.

Za prvé je vhodné odmítout hesla, která v sobě obsahují uživatelské jméno, e-mailovou adresu nebo její podstatnou část, případně další údaje o uživateli (telefonní číslo, jméno...). Za druhé pak může být vhodné odmítnout hesla, která jsou na veřejně dostupných seznamech nejběžnějších hesel (najdete je příkladmo v repozitáři [SecLists](https://github.com/danielmiessler/SecLists/tree/master/Passwords/Common-Credentials)).

Jak vytvořit vlastní validátor hesel? Základ je jednoduchý: vytvořte třídu, která implementuje interface `IPasswordValidator<TUser> where TUser : class`. Přiznám se, že v daném okamžiku moc nechápu význam toho constraintu `class`; přišlo by mi logičtější použít constaint na `IdentityUser` a tak to ve svých implementacích i používám. Nicméně nevylučuji, že to má nějaký důvod, který jsem neodhalil.

Shora popsaný interface vás přiměje implementovat metodu `ValidateAsync`, která obdrží informace o uživateli, jeho hesle a `UserManager<TUser>`. V ní se rozhodnete, zda se vám heslo líbí nebo nikoliv a vrátíte příslušný `IdentityResult`.

Vytvořil jsem třídu `UserSpecificPasswordValidator`, kterou vám tímto dávám k dispozici:

```csharp
public class UserSpecificPasswordValidator<TUser>
    : IPasswordValidator<TUser> where TUser : IdentityUser {

    public Task<IdentityResult> ValidateAsync(UserManager<TUser> manager, TUser user, string password) {
        var errors = Validate(user, password);

        if (errors.Any()) {
            return Task.FromResult(IdentityResult.Failed(errors.ToArray()));
        } else {
            return Task.FromResult(IdentityResult.Success);
        }
    }

    private static IEnumerable<IdentityError> Validate(TUser user, string password) {
        // Check if password contains user name
        if (password.Contains(user.UserName, StringComparison.CurrentCultureIgnoreCase)) {
            yield return new IdentityError {
                Code = "PasswordContainsUserName",
                Description = "Password cannot contain user name."
            };
        }

        // Check if password contains e-mail or its part
        if (!string.IsNullOrWhiteSpace(user.Email)) {
            var emailParts = user.Email.Split('@', '.', '+', '-', '_');
            var longEmailParts = emailParts.Where(x => x.Length > 3);

            foreach (var s in longEmailParts) {
                if (password.Contains(s, StringComparison.CurrentCultureIgnoreCase)) {
                    yield return new IdentityError {
                        Code = "PasswordContainsEmail",
                        Description = "Password cannot contain e-mail address or part of it."
                    };
                    break;
                }
            }
        }
    }

}
```

Veškerá činnost se děje v metodě `Validate`, která vrací `IEnumerable<IdentityError>`. Poněkud netradičním způsobem využívá konstrukci `yield return`, ale přijde mi, že její použití v tomto případě zpřehledňuje kód.

V první řadě zkontrolujeme, zda heslo neobsahuje uživatelské jméno - to je triviální. Poté zkontrolujeme, zda heslo neobsahuje podstatnou část e-mailové adresy. "Podstanou část" jsem definoval tak, že jsem e-mailovou adresu rozdělil na části, přičemž jako oddělovač používám znaky `@.+-_`, a vybral jsem části delší než čtyři znaky. E-mail `neco+petr.novak@example.com` tedy nedovolí, aby se v hesle objevil jeden z řetězců `neco`, `petr`, `novak` a `example`.

Metodu `Validate` lze dále rozvíjet a kontrolovat v ní další údaje, které o uživateli můžeme mít - typicky jméno, telefonní číslo, možná datun narození.

Použití validátoru je snadné. V `ConfigureServices` použijeme metodu `AddPasswordValidator`. Její syntaxe je na první pohled poněkud divoká, protože jako typový parametr bere generický typ, ale v zásadě je to celé velice jednoduché:

```csharp
services.AddDefaultIdentity<IdentityUser>(o => {
    o.Password.RequiredLength = 12;
    o.Password.RequireDigit = false;
    o.Password.RequireLowercase = false;
    o.Password.RequireNonAlphanumeric = false;
    o.Password.RequireUppercase = false;
})
    .AddEntityFrameworkStores<ApplicationDbContext>()
    .AddPasswordValidator<UserSpecificPasswordValidator<IdentityUser>>();
```

Metoda skutečně _přidá_ další validátor (a lze ji volat i opakovaně), takže pro heslo budou současně platit pravidla o minimální délce (a případně další omezení nastavená politikou) a náš vlastní validátor.