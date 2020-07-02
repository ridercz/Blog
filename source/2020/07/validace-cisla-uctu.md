<!-- dcterms:title = Novinka v knihovně Altairis Validation Toolkit: Validace čísla bankovního účtu -->
<!-- dcterms:abstract = Popis algoritmu pro validaci správnosti čísla českého bankovního účtu. Je také k dispozici jako validační atribut v knihovně Altairis Validation Toolkit -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:coverUrl = /cover-pictures/20200703-validace-cisla-uctu.jpg -->
<!-- x4w:coverCredits = Česká národní banka -->
<!-- x4w:pictureUrl = /perex-pictures/20200703-validace-cisla-uctu.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = IT -->
<!-- dcterms:dateAccepted = 2020-07-03 -->

Pokud vaše aplikace pracuje s číslem bankovního účtu, je dobré ověřit, že je zadané hodnota formálně validní. Pravidla pro tvorbu čísel českých bankovních účtů stanoví [vyhláška České národní banky číslo 169/2011 Sb](https://www.zakonyprolidi.cz/cs/2011-169).

> Tato vyhláška určuje i IBAN formát českých čísel účtů. Pokud chcete validovat IBAN (nejenom pro české účty), použijte knihovnu [IbanNet](https://github.com/skwasjer/IbanNet).

Číslo účtu sestává ze dvou nebo třech částí:

* Nepovinné předčíslí o maximální délce šesti číslic.
* Povinné číslo účtu o maximální délce deseti číslic.
* Povinný kód platebního styku (obecně známý jako "kód banky") o pevné délce čtyř číslic.

Zpravidla se zapisuje jako `předčíslí-číslo/kód`. 

Pro základní validaci je tedy možné použít regulární výraz `^(\d{1,6}-)?\d{1,10}/\d{4}$`. Tento výraz zkontroluje, zda číslo účtu neobsahuje nepovolené znaky a zda jednotlivé části jsou přítomny a mají správnou délku. Pomocí regulárního výrazu nicméně nelze spočítat kontrolní součet, který číslo účtu má.

## Výpočet kontrolního součtu předčíslí a čísla účtu

Předčíslí a vlastní číslo účtu musí být (každé zvlášť) vytvořeno tak, aby splňovalo níže popsanou validační podmínku. Cílem je, aby bylo možné jednoduše odhalit překlep v zadání.

Algoritmus pro výpočet je následující:

* Každá číslice se jednotlivě vynásobí svou vahou. Ta je určena jako _2<sup>n</sup> % 11_, kde _%_ je operátor modulo (tj. zbytek po celočíselném dělení) a _n_ je pozice číslice počítaná zprava od jedničky.
* Hodnoty se pro všechny číslice sečtou.
* Výsledek musí být beze zbytku dělitelný jedenácti.

Zapsán v jazyce C# vypadá tento algoritmus takto:

```c#
bool ValidatePart(string part) {
    if (string.IsNullOrEmpty(part)) return true;

    var chs = 0;
    for (var i = 0; i < part.Length; i++) {
        var num = int.Parse(part.Substring(i, 1));
        var weight = (int)Math.Pow(2, part.Length - i) % 11;
        chs += num * weight;
    }
    return chs % 11 == 0;
}
```

## Kontrola kódu banky (kódu platebního styku)

Tato část čísla účtu nemá žádný kontrolní algoritmus, ale je dána [seznamem, který vydává a zveřejňuje Česká národní banka na svém webu](https://www.cnb.cz/cs/platebni-styk/ucty-kody-bank/).

## Validační atribut

Do své knihovny [Altairis Validation Toolkit](https://github.com/ridercz/Altairis.ValidationToolkit) jsem přidal nový atribut `[CzechBankAccount]` ([zdrojový kód](https://github.com/ridercz/Altairis.ValidationToolkit/blob/master/Altairis.ValidationToolkit/CzechBankAccountAttribute.cs)), který validaci provádí. 

Ve výchozím nastavení validuje i kód banky, přičemž seznam kódů je napevno zadán ve zdrojovém kódu a když ČNB vydá novou verzi seznamu, bude nutné vydat novou verzi knihovny. Sáhl jsem k tomuto řešení, protože vlastní číselné kódy se příliš nemění. V seznamu se mění názvy subjektů a další údaje, ale vlastní seznam kódů je poměrně stabilní.

Validaci kódu platebního styku lze vypnout použitím `[CzechBankAccount(IgnoreBankCode = true)]`. V takovém případě projde jakákoliv čtyřmístná numerická hodnota.

Zdrojové kódy Altairis Validation Toolkitu si můžete [stáhnout na GitHubu](https://github.com/ridercz/Altairis.ValidationToolkit), knihovna je k dispozici jako NuGet balíček [Altairis.ValidationToolkit](https://www.nuget.org/packages/Altairis.ValidationToolkit/).