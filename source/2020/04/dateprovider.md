<!-- dcterms:title = Altairis.Services.DateProvider - jak na časové zóny a přílišnou přesnost času -->
<!-- dcterms:abstract = Kolik je hodin? Stačí se zeptat na DateTime.Now nebo GETDATE(). Jenomže ne tak docela. Často potřebujeme řešit přesnost poskytnutého časového údaje anebo převody časových pásem. Proto jsem napsal knihovnu Altairis.Services.DateProvider, která uvedené problémy řeší. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:coverUrl = /cover-pictures/20200421-dateprovider.jpg -->
<!-- x4w:coverCredits = Noor Younis via Unsplash -->
<!-- x4w:pictureUrl = /perex-pictures/20200421-dateprovider.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = IT -->
<!-- dcterms:date = 2020-04-21 -->

Kolik je hodin? Stačí se zeptat na `DateTime.Now` nebo `GETDATE()`. Jenomže ne tak docela. Často potřebujeme řešit přesnost poskytnutého časového údaje anebo převody časových pásem. Proto jsem napsal knihovnu [**Altairis.Services.DateProvider**](https://github.com/ridercz/Altairis.Services.DateProvider), která uvedené problémy řeší.

## Příliš velká přesnost

Odpověď na otázku "kolik je hodin" bude s velkou pravděpodobností mnohem přesnější, než jak ji potřebujete. Nechci tady zabíhat do detailů o ukládání datumu a času v .NETu a SQL serveru, jeho různých datových typech a [rozdílech mezi _precision_ a _accuracy_](https://devblogs.microsoft.com/oldnewthing/20050902-00/?p=34333). Nicméně téměř vždy (s výjimkou typu `smalldatetime` v SQL Serveru) je přesnost vyšší než jedna sekunda. Což zpravidla není třeba a naopak nám to přináší různé obtíže. Tím spíš, že tato hodnota je jiná v .NETu a jiná v databázi (a tam se liší podle toho, jaký datový typ zvolíte).

V praxi často potřebujeme ukládat pouze datum, a pokud datum tak s přesností nejvýše na sekundy, případně dokonce na minuty.

Knihovna Altairis.Services.DateProvider nabízí extension metody `TrimToSecond` a `TrimToMinute`, které dokáží přebytečné milisekundy odříznout. Přesnost na sekundy je také výchozím nastavením všech providerů.

## Časové zóny

Dalším zdrojem zábavy jsou časové zóny. Tato knihovna si _neklade_ za cíl vám pomoci v případě, že s časovými zónami aktivně pracujete a potřebujete o nich uchovávat údaje. V takovém případě použijte typ `DateTimeOffset` a hrajte si.

Nicméně často máte server jinde než uživatele (třeba v cloudu) a prosté volání `DateTime.Now` vám nestačí. Knihovna definuje rozhraní `IDateProvider`, které má vlastnosti `Now` a `Today`, které - stejně jako v případě standardního `DateTime` - vracejí aktuální čas, potažmo datum.

K dispozici jsou čtyři implementace:

* `LocalDateProvider` je jenom wrapper okolo `DateTime`, vrací lokální čas počítače. Můžete si nastavit přesnost (výchozí je sekunda). Toto je provider pro chvíli, kdy chcete jenom snížit přesnost časového údaje, případně chcete být připraveni na budoucí přesun do cloudu.
* `UtcDateProvider` funguje podobně, ale bez ohledu na místní časovou zónu vrací čas v GMT/UTC (a ve výchozím nastavení s přesností na sekundu). Hodí se ve chvíli, kdy máte zákazníky po celém světě (takže chcete používat UTC čas), ale server běží v místním čase.
* `TzConvertDateProvider` umí zkonvertovat čas do libovoné časové zóny. Hodí se například ve chvíli, kdy aplikace běží v cloudu (a hodiny jsou typicky nastavené na UTC), ale zákazníky máte převážně v Čechách, nebo nějakém konkrétním časovém pásmu.
* `FixedDateProvider` vrátí vždy přesně tu samou hodnotu, kterou dostal v konstruktoru. Hodí se pro testy, u nichž chete, aby měly predikovatelné výsledky nad nějakou fixní sadou testovacích dat.

Kompletní dokumentaci [najdete na GitHubu](https://github.com/ridercz/Altairis.Services.DateProvider).