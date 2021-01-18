<!-- dcterms:title = Validace rodného čísla v Altairis Validation Toolkitu -->
<!-- dcterms:abstract = Abych jenom nekritizoval, rozhodl jsem se ukázat, jak se tedy ta validace rodného čísla dělá správně. Do knihovny Altairis Validation Toolkit jsem doprogramoval nový atribut [RodneCislo], který umí číslo zvalidovat a ještě něco navíc. A to všechno živě v rámci live codingu. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:coverUrl = /cover-pictures/20210118-rodne-cislo.jpg -->
<!-- x4w:pictureUrl = /perex-pictures/20210118-rodne-cislo.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = IT -->
<!-- dcterms:dateAccepted = 2021-01-18 -->

Abych [jenom nekritizoval](https://tech.ihned.cz/c7-66870010-psms7-e882c2115d7c68a), rozhodl jsem se ukázat, jak se tedy ta validace rodného čísla dělá správně. Do knihovny [Altairis Validation Toolkit](https://github.com/ridercz/Altairis.ValidationToolkit/) jsem doprogramoval nový atribut `[RodneCislo]`, který umí číslo zvalidovat a ještě něco navíc. A to všechno živě v rámci live codingu.

## Záznam live streamu

Live stream byl dobrodružný, protože mi můj streamovací počítač pár minut před začátkem spadnul do BSOD, takže jsem musel improvizovat a odstreamovat to z jiného, který na to ale nebyl moc připravený a zlobil mi zvuk. Nicméně nakonec se to podařilo a záznam najdete na YouTube:

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/6wkMLS1roXw" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

## Základní ponaučení

**Spoléhejte se na autoritativní zdroje.** Popisů rodného čísla najdete na Internetu hodně a i na státních serverech jsou uvedeny chybně. Například [web Ministerstva vnitra](https://www.mvcr.cz/clanek/rady-a-sluzby-dokumenty-rodne-cislo.aspx) nepočítá s tím, že k měsíci lze přičítat nejenom 50, ale i 20 nebo 70. Stejnou chybou trpí též [katalog datových prvků](https://www.sluzby-isvs.cz/ISDP/DatovyPrvek/DetailDP.aspx?id_procesu=c35c0033-6d4f-4542-b415-dcf1f0c40266). 

Web ČSSZ nabízí [pěkný postup validace](https://www.cssz.cz/standardni-kontrola-rodneho-cisla-a-evidencniho-cisla-pojistence), ale ten zahrnuje i evidenční číslo pojištěnce zdravotního pojištění, což nemusí být jenom rodné číslo. Autoritativním zdrojem tak pro nás je [§ 13 zákona č. 133/2000 Sb. o evidenci obyvatel](https://www.zakonyprolidi.cz/cs/2000-133/zneni-20190424#p13).

**Nespoléhejte na autoritativní zdroje.** V přidělování rodných čísel v minulosti vládl chaos, protože se to dělalo ručně. A byla tedy přidělována duplicitní rodná čísla, čísla s chybnou kontrolní číslicí a podobně. Přišlo se na to až v devadesátých letech při kuponové privatizaci, kdy se poprvé rodná čísla masově zadávala do počítače. 

Naše aplikace tento problém neřeší a vychází striktně z platné zákonné definice rodného čísla. Nicméně u reálné aplikace může být - v závislosti na jejím určení a cílové skupině - rozumné umožnit i zadání nevalidního RČ a validaci použít pouze k upozornění.

**Vytvářejte logické datové typy.** Knihovna umí RČ nejenom validovat, ale také zpracovávat, pomocí [logického datového typu `RodneCislo`](https://github.com/ridercz/Altairis.ValidationToolkit/blob/master/Altairis.ValidationToolkit/LogicalTypes/RodneCislo.cs). Řetězcovou hodnotu můžete pomocí statických metod `Parse` a `TryParse` proparsovat a načíst. Poté máte k dispozici vlastnosti, které vám umožní zjistit datum narození osoby, její pohlaví apod. Pomocí metody `ToString` pak lze rodné číslo získat v normalizované řetězcové podobě s lomítkem nebo bez.

**Neškoďte uživateli příliš.** Logický datový typ (a tím pádem i validátor) si poradí s jakýmkoliv druhem zápisu. Rodné číslo může a nemusí obsahovat lomítko, mezery, cokoliv. Jediné co nás zajímá jsou desítkové číslice. Není tedy třeba uživatele šikanovat, že rodné číslo `600702/4826` nesmí zadávat jako `6007024826` nebo třeba `60 07 02/4826`. Aplikace si to inteligentně přebere. Myslete na to třeba při zadávání telefonního čísla nebo PSČ.

## Generování testovacích rodných čísel

Před začátkem streamu jsem si napsal jednoduchý náhodný generátor validních rodných čísel. Jeho kód si můžete prohlédnout níže, nebo přímo [spustit jako fiddle](https://dotnetfiddle.net/p6AQ6P).

```csharp
using System;

public class Program {
	public static void Main() {
		var rng = new Random();
		for (var i = 0; i < 50; i++) {
			// Datum narození
			var bd = new DateTime(1890, 1, 1).AddDays(rng.Next(365 * 150));
			var m = bd.Month;
			
			// Pohlaví a druhá řada
			var sex = rng.Next(2) == 1;
			var extra = rng.Next(10) == 1;
			m += extra ? (sex ? 20 : 70) : sex ? 0 : 50;
			
			// Pořadové číslo
			var seq = rng.Next(0, 1000);
			
			// Zkonstruovat kandidáta RČ
			var rcs = bd.Year.ToString()[2..] + m.ToString("00") + bd.Day.ToString("00") + seq.ToString("000");
			
			// Spočítat kontrolní číslici
			if(bd.Year > 1953) {
				var rc = long.Parse(rcs);
				var chs = rc % 11;
				if(chs == 10) continue;
				rcs = rcs + chs.ToString();
			}

            // Vypsat RČ
			Console.WriteLine(rcs[0..6] + "/" + rcs[6..]);
		}
	}
}
```

Obecně pro generování testovacích dat používám službu [Fake Name Generator](https://www.fakenamegenerator.com/), ale ta česká rodná čísla generovat neumí.

## Použití validátoru

Použití validátoru jako takového je jednoduché. Přidejte do projektu odkaz na NuGet balíček `Altairis.ValidationToolkit` a pak příslušnou vlastnost odekorujte atributem `[RodneCislo]`. Pro použití pak nepracujte přímo se stringem, ale s třídou `RodneCislo` pomocí jejich metod `Parse`/`TryParse` a `ToString`.