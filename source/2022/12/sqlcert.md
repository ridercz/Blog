<!-- dcterms:title = Jak na chybu připjení k SQL Serveru po upgrade na .NET 7 -->
<!-- dcterms:abstract = Upgrade ASP.NET aplikací z 6.0 na 7.0 je snadný a téměř bezpracný. Ale můžete narazit na to, že se vám po upgrade databáze odmítne připojit k databázi s poněkud kryptickou chybou. Ukážu vám, jak tento problém vyřešit hned třikrát: dvakrát rychle a jednou správně. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:coverCredits = Midjourney AI -->
<!-- x4w:coverUrl = /cover-pictures/20221208-sqlcert.jpg -->
<!-- x4w:pictureUrl = /perex-pictures/20221208-sqlcert.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = Z-TECH -->
<!-- x4w:category = IT -->
<!-- dcterms:date = 2022-12-08 -->

Upgrade ASP.NET aplikací z 6.0 na 7.0 je snadný a téměř bezpracný. Ve většině případů stačí jenom změnit verzi runtime v `.csproj` souboru a upgradovat NuGet balíčky. Ale můžete narazit na to, že se vám po upgrade databáze odmítne připojit k databázi s poněkud kryptickou chybou:

> Unhandled exception. Microsoft.Data.SqlClient.SqlException (0x80131904): A connection was successfully established with the server, but then an error occurred during the login process. (provider: SSL Provider, error: 0 - The certificate chain was issued by an authority that is not trusted.)

Hláška je to trochu matoucí, protože z ní na první pohled vyplývá, že je něco špatně s přihlašováním uživatele. Ale není to pravda. Ta důležitá informace se skrývá v následující zprávě, že se jedná o nedůvěryhodnou certifikační autoritu.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/xG0OCG34kZE" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

Nová verze balíčku `Microsoft.Data.SqlClient` (na níž závisí třeba Entity Framework Core) totiž ve výchozím nastavení používá šifrované připojení k SQL Serveru. Což je nepochybně myšlenka dobrá a z hlediska vyššího principu mravního správná. Problém ovšem je, že většina serverů nemá platný certifikát, ale používá dynamicky vygenerovaný self-signed. A klient na to reaguje právě shora zmíněnou chybou.

## Dvě rychlá řešení

Nejrychlejší, ne ovšem nutně správná, řešení spočívají v prosté modifikaci connection stringu. 

Váš stávající connection string vypadá nejspíše nějak takhle:

```connectionstring
SERVER=.\SqlExpress;TRUSTED_CONNECTION=yes;DATABASE=Northwind
```

nebo:

```connectionstring
Data Source=db.example.com,1433; Initial Catalog=Northwind;User ID=Northwind;Password=Pass.word123
```

Možných podob a kombinací je celá řada.

Symptomy shora uvedeného problému vyřešíte tak, že k connection stringu přidáte `;ENCRYPT=no` nebo `;TRUSTSERVERCERTIFICATE=yes`.

* Přidání `ENCRYPT=no` řekne klientovi, že má používat nešifrované spojení, tak jak to bylo před popisovanou změnou výchozí.
* Přidání `TRUSTSERVERCERTIFICATE=yes` zase řekne, že sice má použít výchozí (šifrované) spojení, ale jakýkoliv serverem předaný certifikát má akceptovat jako důvěryhodný. I když bude self-signed nebo vydaný neznámou CA.

## Jedno správné řešení

Popisovaná řešení nejsou správná. Jedná se o léčbu symptomů, nikoliv příčiny. Příčinou je nedůvěryhodný certifikát na straně serveru.

Certifikát můžete (z PFX nebo PEM souboru) nainstalovat pomocí nástroje _Computer Management_, viz následující obrázek:

![Screenshot](https://www.cdn.altairis.cz/Blog/2022/20221208-sqlcert.png)

## Hraběcí rada

Ono správné řešení je ovšem poněkud hraběcí rada.

V první řadě, někdy je takový certifikát v podstatě nemožné od důvěryhodné autority získat, typicky pokud nepoužíváte pro připojení FQDN, ale lokální hostname, IP adresu nebo něco takového.

Ostatně nemusíme chodit daleko, třeba pro připojení k lokálnímu SQL Serveru Express na vývojářském stroji se jako název obvykle používá `.\SqlExpress` nebo `(local)\SqlExpress` a ani pro jedno z toho vám nikdo certifikát nevydá.

Obecně, pokud je databázový server a klient na jednom počítači (nekomunikují spolu po síti) není šifrované spojení z bezpečnostních důvodů nezbytné.

Další problém spočívá v tom, že se mi nepodařilo přijít na způsob, jak instalaci a aktualizaci serverového certifikátu automatizovat. Všechny návody počítají s nastavením pomocí GUI, jak bylo popsáno výše. Nepřišel jsem na to, jak tuto operaci udělat pomocí příkazové řádky nebo powershellu. 

> Pokud na takový způsob přijdete, dejte mi vědět, rád o tom napíšu článek nebo udělám video.

To prakticky vylučuje možnost použití bezplatných certifikátů od Let's Encrypt CA, které mají platnost pouze tři měsíce. A i komerční CA vám nevystaví certifikát na déle než rok.

Zbývá poslední cesta, a to vytvořit si vlastní CA a tu použít k vydání certifikátu s dlouhodobou platností. Nicméně krátká platnost certifikátů má své dobré důvody a provoz vlastní CA je ve většině případů cesta do pekel.
