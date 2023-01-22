<!-- dcterms:title = API klient pro Fio banku -->
<!-- dcterms:abstract = Napsal jsem C#/.NET klienta pro načítání seznamu plateb z Fio banky přes její API. Je k dispozici jako open source na GitHubu a NuGetu. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:coverUrl = /cover-pictures/20230123-fio.jpg -->
<!-- x4w:coverCredits = Midjourney AI -->
<!-- x4w:pictureUrl = /perex-pictures/logo-fio.svg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = Software -->
<!-- x4w:category = IT -->
<!-- dcterms:date = 2023-01-23 -->

Napsal jsem C#/.NET klienta pro načítání seznamu plateb z Fio banky přes [její API](https://www.fio.cz/bankovni-sluzby/api-bankovnictvi). Je k dispozici jako open source na [GitHubu](https://github.com/ridercz/FioBanka-API) a [NuGetu](https://www.nuget.org/packages/Altairis.FioBankApi/).

* Logika pojmenování i chování metod vychází z (ne vždy zcela srozumitelné) logiky API Fio banky.
* Pokud API vrátí chybu, vyhodí příslušná metoda `HttpRequestException`.
* Všechny metody jsou asynchronní a vracejí `Task` nebo `Task<T>`.

## Třída `FioClient`

Pro načtení dat z API slouží metody třídy `FioClient`. Tato třída má jeden konstruktor, který jako argument dostává `token`, přístupový token k API.

> Tato třída spravuje instanci `System.Net.Http.HttpClient`. Vzhledem k předpokládanému režimu použití (API bude voláno relativně zřídka a ne z několika vláken současně) nepředpokládám problémy popsané v článku [HttpClient Guidelines for .NET](https://learn.microsoft.com/en-us/dotnet/fundamentals/networking/http/httpclient-guidelines). Postačuje před použitím vytvořit instanci a po použití ji zase zlikvidovat.

### Metoda `GetTransactions`

Načte seznam transakcí za zvolené období. Všechny overloady jsou asynchronní a vracejí `Task<TransactionList>`.

* `GetTransactions()` - vrací seznam transakcí od poslední zarážky.
* `GetTransactions(DateOnly dateBegin)` - vrací seznam transakcí od určitého data.
* `GetTransactions(DateOnly dateBegin, DateOnly dateEnd)` - vrací seznam transakcí od-do určitého data.

Na volání této metody je uplatňován rate limiting a mezi jednotlivými voláními musí být přestávka nejméně 30 sekund. Jinak je vrácen stavový kód `409 Conflict` a vyhozena `HttpRequestException`. Typické ošetření tohoto stavu:

```csharp
try {
    var tl = await api.GetTransactions();
    Console.WriteLine($"OK, account IBAN {tl.Iban}");
} catch (HttpRequestException ex) when (ex.StatusCode == System.Net.HttpStatusCode.Conflict) {
    Console.WriteLine("Too many requests - API supports only one request per 30 seconds.");
}
```

### Metoda `SetCursor`

Nastaví zarážku na určenou hodnotu. Je asynchronní a vrací `Task`.

* `SetCursor(string lastKnownId)` - nastaví zarážku na ID posledního úspěšně načteného pohybu.
* `SetCursor(DateOnly lastFailedDate)` - nastaví zarážku na datum posledního neúspěšně načteného dne.

## Třída `TransactionList`

Obsahuje informace o seznamu transakcí (pohybů).

Vlastnost        | Typ        | Význam
---------------- | ---------- | ------
`AccountId`      | `string`   | Číslo účtu
`BankId`         | `string`   | Kód platebního styku (kód banky)
`Currency`       | `string`   | Kód měny (např. `CZK`)
`Iban`           | `string`   | Číslo účtu ve formátu IBAN
`BIC`            | `string`   | Kód banky ve formátu BIC
`IdFrom`         | `string`   | ID první transakce v seznamu
`IdTo`           | `string`   | ID poslední transakce v seznamu
`OpeningBalance` | `decimal`  | Počáteční zůstatek (za období v seznamu)
`ClosingBalance` | `decimal`  | Konečný zůstatek (za období v seznamu)
`DateStart`      | `DateOnly` | Počáteční datum
`DateEnd`        | `DateOnly` | Konečné datum
`IdLastDownload` | `string?`  | ID posledního staženého pohybu; je `null` při volání s určenými datumy
`Items`          | `ICollection<TransactionInfo>` | Seznam pohybů

## Record `TransactionInfo`

Obsahuje informaci o konkrétní transakci (pohybu).

Vlastnost              | Typ        | Význam
---------------------- | ---------- | ------
`Id`                   | `string`   | ID pohybu
`Date`                 | `DateOnly` | Datum
`Amount`               | `decimal`  | Částka
`Currency`             | `string`   | Kód měny (např. `CZK`)
`OtherAccountNumber`   | `string`   | Číslo protiúčtu
`OtherAccountName`     | `string`   | Název protiúčtu
`OtherAccountBankCode` | `string`   | Kód platebního styku (kód banky) protiúčtu
`OtherAccountBankName` | `string`   | Název banky protiúčtu
`KS`                   | `string`   | Konstantní symbol
`VS`                   | `string`   | Variabilní symbol
`SS`                   | `string`   | Specifický symbol
`UserIdentification`   | `string`   | Uživatelská identifikace
`MessageForRecipient`  | `string`   | Zpráva pro příjemce
`Type`                 | `string`   | Typ operace
`Person`               | `string`   | Osoba, která operaci provedla
`Details`              | `string`   | Detaily operace
`Comments`             | `string`   | Poznámka
`BIC`                  | `string`   | BIC kód banky protiúčtu
`OrderId`              | `string`   | ID příkazu
