<!-- dcterms:title = Pwned Passwords Validator pro ASP.NET Identity -->
<!-- dcterms:abstract = Včera jsem v živém streamu napsal validátor hesel, který využívá databázi z HaveIBeenPwned.com. K dispozici je záznam streamu, mírně aktualizovaný kód a NuGet balíček. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20190829-pwned-passwords-validator.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20190829-pwned-passwords-validator.jpg -->
<!-- x4w:category = Bezpečnost -->
<!-- x4w:category = IT -->
<!-- dcterms:dateAccepted = 2019-08-29 -->

Udělat validaci hesel správně, to je kumšt. Obvyklá pravidla - že heslo musí obsahovat velké písmeno, malé písmeno, číslici, sumerské klínové písmo a krev jednorožce - jsou obvykle spíše k vzteku než k užitku. Pokud jde o pravidla pro hesla, doporučuji používat následující:

1. Minimální délka hesla (`RequiredLength`) dvanáct znaků. S krátkým heslem dneska prostě parádu neuděláte a dvanáct znaků pokládám za rozumný kompromis.
2. Minimální počet různých znaků (`RequiredUniqueChars`) čtyři. Heslo by mělo mít nějakou entropii a dvacet znaků `X` není úplně to pravé.
3. Nemělo by být odvozeno od informací o uživateli (e-mail, uživatelské jméno).
4. Nemělo by být příliš běžné, nápadné.

O body 1 a 2 se dokáže postarat vestavěný validátor hesla. Stačí ho nastavit nějak takto:

```cs
services.AddIdentity<ApplicationUser, ApplicationRole>(options => {
    options.Password.RequiredLength = 12;
    options.Password.RequiredUniqueChars = 4;
    options.Password.RequireDigit = false;
    options.Password.RequireLowercase = false;
    options.Password.RequireNonAlphanumeric = false;
    options.Password.RequireUppercase = false;
})
```

S těmi dalšími body nám ovšem vestavěný validátor nepomůže. Pokud se týče informací o uživateli, tam obecné řešení napsat nelze. Záleží na tom, jaké informace máme k dispozici. [Andrew Lock napsal článek](https://andrewlock.net/creating-custom-password-validators-for-asp-net-core-identity-2/), ve kterém vytváří validátor, který kontroluje, že se heslo nerovná uživatelskému jménu. Osobně bych zašel ještě dál, kontroloval bych, zda heslo _neobsahuje_ uživatelské jméno, podstatné části e-mailové adresy, nebo třeba datum narození či telefonní číslo, pokud je u uživatele známe. Nicméně zde musíte napsat řešení na míru pro váš vlastní systém.

## Kontrola příliš často užívaných hesel

[Další řešení od stejného autora](https://andrewlock.net/creating-a-validator-to-check-for-common-passwords-in-asp-net-core-identity/) kontroluje, zda se heslo nenachází v seznamu nejběžnějších. Vychází přitom z [databáze deseti miliónů nejčastějších hesel](https://keepersecurity.com/blog/2017/01/13/most-common-passwords-of-2016-research-study/) z roku 2016. Součástí jeho knihovny jsou validátory, které zabrání použití hesla, které se nachází v top 100, 500, 1000, 10000 a 100000.

Zabránit použití takových hesel je dobré především kvůli brute force útokům. Stejnou databází disponuje i útočník, který v případě úniku (i kvalitně zahashovaných) hesel samozřejmě nejdřív vyzkouší ta nejběžnější.

## Kontrola přes Have I Been Pwned

Trou Hunt provozuje službu [Have I Been Pwned](https://www.haveibeenpwned.com/), která umožňuje hlídat, zda se vaše přihlašovací údaje neobjevily v nějakém z úniků. Jako přidruženou výrobu nabízí [Pwned Passwords API](https://www.troyhunt.com/ive-just-launched-pwned-passwords-version-2/). Tedy službu, která umožní ověřit si, že se potenciální heslo nenachází mezi běžně používanými a uniklými z mnoha zdrojů.

Kontrola je přitom udělána tak, že se službě nezasílá heslo ani jeho hash. Využívá přitom k-anonymity, která v tomto případě funguje následovně.

1. Z potenciálního hesla se spočítá SHA-1 hash a převede se do Base16. Tento hashovací algoritmus není dostatečně bezpečný pro úschovu hesel a většinu dalších užití, ale je dostatečně dobrý pro to naše.
2. Pošle se HTTPS GET požadavek na adresu `https://api.pwnedpasswords.com/range/12345`, kde je místo `12345` prvních pět znaků spočítaného hashe. Služba tedy neví, jaké heslo uživatel zvolil, ani jeho hash, jenom prvních pět číslic z jeho šestnáctkového zápisu.
3. Služba vrátí seznam hashů všech známých kompromitovaných hesel, jejichž hash začíná uvedenými pěti číslicemi.
4. Klient (náš validátor) se podívá, zda se v seznamu nachází zbytek hashe. Pokud ano, bylo heslo v minulosti kompromitováno. Pokud ne, je v pořádku.

## Projekt PwnedPasswordsValidator

Napsal jsem validátor, který využívá výše zmíněné API. A aby to bylo zábavnější, tak jsem to celé živě streamoval na YouTube. Zde je [záznam streamu](https://youtu.be/t_ZleMiX_z8):

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/t_ZleMiX_z8" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

Hotový validátor je k dispozici na [GitHubu](https://github.com/ridercz/Altairis.Services.PwnedPasswordsValidator) a jako NuGet balíček `Altairis.Services.PwnedPasswordsValidator`.

### Změny proti streamu

Po dokončení streamu jsem provedl ještě některá drobná vylepšení, kterými jsem nechtěl stream prodlužovat:

* Využívám asynchronní `System.Net.Http.HttpClient` místo starého `System.Net.WebClient`.
* Přidal jsem konfigurovatelný timeout.
* Přidal jsem logování a obsluhu chyb. Pokud by bylo API nedostupné (nebo včas neodpoví), aplikace heslo "propustí" a zaloguje chybu.
* Trochu jsem zefektivnil prohledávání vrácené odpovědi. Šlo by to napsat ještě lépe (s využitím vědomí, že hashe jsou v odpovědi seřazené), ale to už je úroveň optimalizace, která mi přijde zbytečná.