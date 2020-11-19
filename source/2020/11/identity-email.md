<!-- dcterms:title = ASP.NET Identity: Přihlášení pomocí uživatelského jména nebo e-mailové adresy -->
<!-- dcterms:abstract = ASP.NET Identity při přihlášení vyžaduje uživatelské jméno a heslo. Jak ale zařídit, aby se uživatel mohl přihlásit i bez něj, pouze pomocí e-mailové adresy? Nebo aby separátní uživatelské jméno vůbec neměl? Ukážu vám třídy UserManager a SignInManager, jejichž změnou můžete v aplikaci udělat velké věci. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20201118-identity-email.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20201118-identity-email.jpg -->
<!-- x4w:category = IT -->
<!-- dcterms:dateAccepted = 2020-11-18 -->

ASP.NET Identity při přihlášení vyžaduje uživatelské jméno a heslo. Jak ale zařídit, aby se uživatel mohl přihlásit i bez něj, pouze pomocí e-mailové adresy? Nebo aby separátní uživatelské jméno vůbec neměl? Ukážu vám třídy UserManager a SignInManager, jejichž změnou můžete v aplikaci udělat velké věci.

Toto je jedna ze dvou změn, které jsem od [live streamu](https://www.youtube.com/playlist?list=PLoOpAe_g1x4IxYK9A8aT0To60DF6IHTFl) udělal v ukázkové aplikaci [FutLabIS](https://github.com/ridercz/FutLabIS) (tou druhou je přidání [modálních dialogů pomocí CSS](/2020/11/css-modal)). Změnu najdete jako commit [`ec797e8`](https://github.com/ridercz/FutLabIS/commit/ec797e8f2eb61a3e2091b99699af3fe5613b14d4).

## Vlastnosti identifikující uživatele

ASP.NET Identity o uživatelích schraňuje tři údaje, použitelné pro jejich jednoznačnou identifikaci: `Id`, `UserName` a `EmailAddress`.

**Vlastnost `Id`** je jedinečný automaticky generovaný identifikátor uživatele, který se po celou dobu jeho existence nemění. Ve výchozím nastavení je typu `string` (v MSSQL databázi má typ `nvarchar(max)`) a má hodnotu ve formátu GUID (ale uloženou jako řetězec). Typ lze snadno změnit, například na opravdový `Guid` nebo na `int`. Stačí podědit třídu reprezentující uživatele od `IdentityUser<TKey>` kde `TKey` je typ primárního klíče.

Například v ukázkové aplikaci [FutLabIS](https://github.com/ridercz/FutLabIS) kterou teď [v live streamu píšu](https://www.youtube.com/playlist?list=PLoOpAe_g1x4IxYK9A8aT0To60DF6IHTFl) je třída `ApplicationUser` definována takto:

```cs
namespace Altairis.FutLabIS.Data {
    public class ApplicationUser : IdentityUser<int> {

        public bool Enabled { get; set; } = true;

        [Required, MinLength(2), MaxLength(2)]
        public string Language { get; set; }

    }
}
```

Jako primární klíč používá automaticky generovaný `int` (a má navíc vlastnosti `Enabled` a `Language`). ID uživatele byste měli používat všude, kde potřebujete uživatele na cokoliv relačně navázat. ASP.NET Identity ho používá třeba pro přiřazení rolí, externích loginů a podobně. Zatímco ostatní dva identifikátory (uživatelské jméno a e-mailová adresa) se případně mohou v čase měnit, ID se měnit nikdy nebude.

**Vlastnost `UserName`** je přihlašovací jméno. Na rozdíl od některých jiných systémů ASP.NET Identity umožňuje, aby si uživatel své jméno změnil. Je samozřejmě na vás, zda mu to dovolíte a dáte mu k tomu odpovídající UI, ale API to umožňuje. Raději ve své aplikaci s možností změny počítejte na uživatelské jméno nepoužívejte pro vazbu na jiné objekty.

**Vlastnost `EmailAddress`** je e-mailová adresa, kterou ASP.NET Identity používá. Má specifické API pro potvrzení její změny a patrně budete chtít e-mailovou adresu využít třeba pro reset zapomenutého hesla. Pozor, ve [výchozím nastavení](https://docs.microsoft.com/en-us/aspnet/core/security/authentication/identity-configuration?view=aspnetcore-5.0) není adresa potvrzována a nemusí být unikátní, tj. pod jednou adresou se může zaregistrovat několik uživatelů.

Pokud to nepokládáte za dobrý nápad (třeba při použití dále popisovaných řešení), můžete nastavení změnit při registraci služby v `ConfigureServices`:

```cs
services.AddIdentity<ApplicationUser, ApplicationRole>(options => {
    options.User.RequireUniqueEmail = true;
    options.SignIn.RequireConfirmedEmail = true;
})
```

## Samostatný UserName: ano či ne?

Je otázkou, zda by vaše aplikace vůbec měla samostatné uživatelské jméno vyžadovat. Kloním se k závěru, že obecně nikoliv. Většina moderních systémů používá místo uživatelského jména e-mailovou adresu, vycházeje z premisy, že si uživatel nebude muset pamatovat další údaj.

Tento přístup má nicméně i dvě nevýhody:

* Mnoho uživatelů má několik e-mailových adres a nepamatuje si, kterou použili pro registraci ve vaší službě.
* Některé aplikace vyžadují interakci mezi uživateli a v takovém případě je dobré zobrazovat jejich přezdívky nebo něco podobného, ne e-mailové adresy. Uživatelské jméno pro tento účel vyhovuje výtečně.

### E-mailová adresa místo uživatelského jména

Chcete-li používat e-mailovou adresu místo uživatelského jména, můžete to v ASP.NET Identity vyřešit pomocí vlastní třídy poděděné od `UserManager<TUser>`. V ní přepište metody pro práci s uživateli tak, aby při jejich vytváření nebo změně prostě vygenerovaly uživatelské jméno na základě e-mailové adresy. Já jsem si udělal metodu `PrepareUser` a tu volám všude, kde se s uživateli pracuje. 

Třída `ApplicationUserManager` pak může vypadat třeba takto:

```cs
public class ApplicationUserManager : UserManager<ApplicationUser> {
    private readonly IDateProvider dateProvider;

    public ApplicationUserManager(IUserStore<ApplicationUser> store, IOptions<IdentityOptions> optionsAccessor, IPasswordHasher<ApplicationUser> passwordHasher, IEnumerable<IUserValidator<ApplicationUser>> userValidators, Enumerable<IPasswordValidator<ApplicationUser>> passwordValidators, ILookupNormalizer keyNormalizer, IdentityErrorDescriber errors, IServiceProvider services, ILogger<UserManager<ApplicationUser>> logger)
        : base(store, optionsAccessor, passwordHasher, userValidators, passwordValidators, keyNormalizer, errors, services, logger) {
    }

    public override Task<IdentityResult> CreateAsync(ApplicationUser user) {
        if (user is null) throw new ArgumentNullException(nameof(user));

        return base.CreateAsync(this.PrepareUser(user));
    }

    public override Task<IdentityResult> CreateAsync(ApplicationUser user, string password) {
        if (user is null) throw new ArgumentNullException(nameof(user));
        if (password == null) throw new ArgumentNullException(nameof(password));
        if (string.IsNullOrWhiteSpace(password)) throw new ArgumentException("Value cannot be empty or whitespace only string.", nameof(password));

        return base.CreateAsync(this.PrepareUser(user), password);
    }

    public override Task<IdentityResult> UpdateAsync(ApplicationUser user) {
        if (user is null) throw new ArgumentNullException(nameof(user));

        return base.UpdateAsync(this.PrepareUser(user));
    }

    public override Task<IdentityResult> ChangeEmailAsync(ApplicationUser user, string newEmail, string token) {
        if (user is null) throw new ArgumentNullException(nameof(user));
        if (newEmail == null) throw new ArgumentNullException(nameof(newEmail));
        if (string.IsNullOrWhiteSpace(newEmail)) throw new ArgumentException("Value cannot be empty or whitespace only string.", nameof(newEmail));
        if (token == null) throw new ArgumentNullException(nameof(token));
        if (string.IsNullOrWhiteSpace(token)) throw new ArgumentException("Value cannot be empty or whitespace only string.", nameof(token));

        return base.ChangeEmailAsync(this.PrepareUser(user, newEmail), newEmail, token);
    }

    private ApplicationUser PrepareUser(ApplicationUser user, string newEmail = null) {
        // Use e-mail as username
        if (string.IsNullOrEmpty(user.Email)) throw new ArgumentException("E-mail address must be specified.", nameof(user));
        user.UserName = newEmail?.ToLowerInvariant() ?? user.Email.ToLowerInvariant();
        return user;
    }

}
```

Pokud ji chcete použít všude, kde si necháte nainjectovat `UserManager<ApplicationUser>`, zaregistrujte ji do IoC/DI kontejneru pomocí metody `AddUserManager`:

```cs
services.AddIdentity<ApplicationUser, ApplicationRole>(...)
    .AddUserManager<Services.ApplicationUserManager>();
```

### Ponechání uživatelského jména, ale umožnění přihlášení i pomocí e-mailu

V ukázkové aplikaci FutLabIS výše uvedené řešení použít nechci, protože tam uživatelé budou v rámci systému vystupovat pod svými přezdívkami (uživatelé vidí cizí rezervace). Nicméně pokládám za vhodné, aby uživatelé mohli pro přihlášení použít i svou e-mailovou adresu, nejenom uživatelské jméno.

V takovém případě je řešení podobné: vytvoříme vlastního potomka třídy `SignInManager<TUser>` a dopíšeme do něj požadovanou funkcionalitu. Podívejte se, jak vypadá v ukázkové aplikaci třída [`ApplicationSignInManager`](https://github.com/ridercz/FutLabIS/blob/master/Altairis.FutLabIS.Web/Services/ApplicationSignInManager.cs):

```cs
namespace Altairis.FutLabIS.Web.Services {
    public class ApplicationSignInManager : SignInManager<ApplicationUser> {
        public ApplicationSignInManager(UserManager<ApplicationUser> userManager, IHttpContextAccessor contextAccessor, IUserClaimsPrincipalFactory<ApplicationUser> claimsFactory, IOptions<IdentityOptions> optionsAccessor, ILogger<SignInManager<ApplicationUser>> logger, IAuthenticationSchemeProvider schemes, IUserConfirmation<ApplicationUser> confirmation) : base(userManager, contextAccessor, claimsFactory, optionsAccessor, logger, schemes, confirmation) { }

        public override async Task<SignInResult> PasswordSignInAsync(string userName, string password, bool isPersistent, bool lockoutOnFailure) {
            var result = await base.PasswordSignInAsync(userName, password, isPersistent, lockoutOnFailure);

            // Allow sign-in using e-mail address, not only user name
            if (result == SignInResult.Failed && userName.Contains('@')) {
                var userFoundByEmail = await this.UserManager.FindByEmailAsync(userName);
                if (userFoundByEmail != null) result = await base.PasswordSignInAsync(userFoundByEmail, password, isPersistent, lockoutOnFailure);
            }
            return result;
        }

        public override async Task<bool> CanSignInAsync(ApplicationUser user) {
            if (user is null) throw new System.ArgumentNullException(nameof(user));

            return await base.CanSignInAsync(user).ConfigureAwait(false)
                ? user.Enabled
                : false;
        }

    }
}
```

Přepsal jsem v ní dvě metody. Metoda `CanSignInAsync` je mimo téma tohoto článku a zajišťuje, že se smí přihlásit pouze uživatel, jehož vlastnost `Enabled` je nastavena na `true`. ASP.NET Identity ve výchozím nastavení nepodporuje blokování uživatelů a tímto způsobem ho lze zařídit.

> Poznámka: Metoda `CanSignInAsync` je jednoduché API, které umožní zablokovat přihlášení uživatele tím, že vrátí `false`. Neumožňuje ale sdělit volajícímu kódu důvod proč nebyl uživatel přihlášen, vrátí prostě [`SignInResult.NotAllowed`](https://docs.microsoft.com/en-us/dotnet/api/microsoft.aspnetcore.identity.signinresult?view=aspnetcore-5.0). Pokud byste chtěli dál poslat zdůvodnění, přepište místo toho metodu [`PreSignInCheck`](https://docs.microsoft.com/en-us/dotnet/api/microsoft.aspnetcore.identity.signinmanager-1.presignincheck?view=aspnetcore-5.0), která umí vrátit konkrétní důvod ([vlastní `SignInResult`](https://github.com/aspnet/Identity/issues/938)).

Pro nás je podstatná metoda `PasswordSignInAsync`, která se pokusí uživatele přihlásit pomocí kombinace uživatelského jména a hesla. V ní se nejdříve pokusím uživatele přihlásit standardním systémem, voláním bázové metody. Pokud se mi to nepovede, výsledek je `Failed`. Což může být způsobeno několika příčinami, z nichž jednou je neexistence uživatele.

Pokud bylo přihlášení neúspěšné a uživatelské jméno obsahuje znak `@`, pojme můj kód podezření, že uživatel nezadal své jméno ale e-mailovou adresu. V takovém případě se pokusí najít uživatele s danou e-mailovou adresou voláním metody `FindByEmailAsync` a pokud se mu to podaří, pokusí se uživatele přihlásit se zadaným heslem.

Naši vlastní třídu pak samozřejmě musíme zaregistrovat do IoC/DI kontejneru:

```cs
services.AddIdentity<ApplicationUser, ApplicationRole>(...)
    .AddSignInManager<Services.ApplicationSignInManager>();
```

## Závěr

Vše výše uvedené můžeme udělat "jednodušeji" přímo v obsluze akce přihlášení, vytváření uživatele atd. Nicméně to není dobrý nápad, protože se může stát, že uživatele budeme zakládat nebo přihlašovat jinak, třeba při hromadném importu nebo tak něco, a aplikace se bude chovat nekonzistentně.

Mnohem vhodnější je použít předem připravené extensibility pointy, které nám ASP.NET Identity nabízí v podobě možnosti dědit z výše uvedených tříd.

* `UserManager<TUser>` je třída, pomocí které aplikace spravuje databázi uživatelů. Obsahuje metody pro jejich vytváření, změny, mazání a podobně. Je to vhodný extensibility point pro případy, kdy chceme měnit ukládané hodnoty. Zde například nastavením uživatelského jména podle e-mailu.
* `SignInManager<TUser>` pak řeší přihlašování a odhlašování uživatelů. Umožňuje přepsáním správných metod ovlivnit proces přihlašování, například implementací možnosti zakázání uživatele, nebo kreativní prací s uživatelským jménem.