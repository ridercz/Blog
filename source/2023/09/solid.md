<!-- dcterms:title = Co jsou SOLID principy v .NET a proč by vás měly zajímat? -->
<!-- dcterms:abstract = SOLID je sada pěti principů používaných při psaní objektově orientovaného kódu. Pro .NET programátory je podstatná především proto, že ji dodržuje samotný .NET. A proto ji musíte znát, i kdybyste ji nechtěli sami dodržovat. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:coverUrl = /cover-pictures/20230927-solid.jpg -->
<!-- x4w:pictureUrl = /perex-pictures/20230927-solid.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = IT -->
<!-- x4w:category = Z-TECH -->
<!-- dcterms:date = 2023-09-27 -->

SOLID je sada pěti principů, nebo chcete-li zásad, pro psaní kódu v objektově orientovaných jazycích (jako je třeba C#). Proč takové zásady potřebujeme? Pokud je program malý a jednoduchý, stačí jenom aby fungoval a příliš nezáleží na tom, jak bude napsaný. Nicméně u rozsáhlejších aplikací a systémů máme větší nároky. Například:

* Potřebujeme program napsat rychle. Ne nutně nejvýkonnějším možným způsobem, ale nechceme plýtvat časem. Protože to je v současnosti nejdražší zdroj při vývoji. Je tedy mnohdy efektivnější koupit do serveru víc paměti, než platit o měsíc déle vývojový tým, aby dělal výkonovou optimalizaci.
* Potřebujeme, aby na zadání mohlo jednoduše spolupracovat víc programátorů současně. A to i tehdy, pokud mají různou úroveň znalostí (junior/senior) nebo specializaci (frontend/backend).
* Potřebujeme aplikaci dlouhodobě rozvíjet a udržovat a potřebujeme tedy, aby byla srozumitelná i po delší době nebo novému programátorovi.
* Potřebujeme reagovat na změny zadání. Protože mnohdy je vývoj iterativní proces, kdy zákazník neví přesně co potřebuje, dokud se to nevyzkouší. A i pokud to ví, tak se mění svět kolem - business nebo třeba zákony.

Zásady SOLID se snaží vést programátora k tomu, aby tyto nároky jeho kód splňoval. Zároveň se tyto zásady vzájemně doplňují a podporují. Proč by je podle mého názoru měl znát každý .NET programátor? Za prvé, protože ačkoliv jejich dodržování není nezbytné či vhodné absolutně ve všech případech, je to dobrá cesta první volby. U těch typů aplikací, které se obvykle píší v .NETu jejich dodržováním zpravidla nic nezkazíte ale hodně získáte. Za druhé, na základě těchto zásad je navržen .NET sám a i když je vy sami ve svém kódu dodržovat nebudete, stejně je musíte znát, abyste pochopili fungování platformy jako takové.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/UCEE_arM8aQ" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

## SRP - Single Responsibility Principle

Tato zásada programátora v zásadě vede k tomu, aby vytvářel jednoduché, jednoúčelové třídy. Složité problémy se pak řeší kompozicí, spoluprací těchto tříd. To napomáhá srozumitelnosti a udržitelnosti systému, jakož i podporuje možnost spolupráce mezi více programátory. Porušování této zásady často vede ke vzniku "god class", složitých tříd na kterých závisí všechno a do kterých nelze sáhnout dílem protože jim už nikdo nerozumí a dílem protože nevíme, co všecho by se rozbilo.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/MDucpxyr1p8" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

## OCP - Open/Closed Principle

Tato zásada zjednodušeně říká, že by se neměl měnit způsob, pomocí kterého třídy komunikují se světem. Může se měnit co nebo jak třída dělá, ale měly by zůstat zachovány metody, jejich argumenty a podobně. Toho se často dosahuje použitím interfaces (rozhraní). Definuje se interface, který se později nemění, a třída toto rozhraní implementuje. Případně mohou přibývat nové implementace tohoto rozhraní, které je ale možné snadno použít ve stávajícím kódu. Děje se tak ve jménu opět snazší spolupráce mezi programátory, ale také dlouhodobé udržitelnosti a rozšiřitelnosti systému.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/QmHwi36FViA" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

## LSP - Liskov Substitution Principle

Tato zásada se zabývá správným použitím dědičnosti. Říká, že každý potomek by měl rozšiřovat schopnosti svého rodiče. Nebo také, že kdekoliv je použit rodič, mělo by být možné použít i jeho potomka. Ne vždy je dodržení této zásady možné ve chvíli, kdy jste v pozici toho, kdo vytváří onoho potomka a abstraktní bázová třída je vytvořena špatně. Porušování této zásady vede k obtížnosti spolupráce tříd, kdy se není možné spolehnout na rozhraní nebo bázovou třídu.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/0yY2NYp8ASk" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

## ISP - Interface Segregation Principle

Tato zásada je ideovým souputníkem SRP: říká, že nemáte vytvářet příliš složitá rozhraní. Podle mého názoru je logickou výslednicí předchozích zásad, protože vytvářením složitých rozhraní s mnoha členy se téměř nevyhnutelně dostaneme do konfliktu s nimi.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/tWlEA9O_Hdk" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

## DIP - Dependency Inversion Principle

Poslední zásada říká, že by si třídy neměly samy vytvářet instance tříd které potřebují, ale měly by je dostat připravené zvenčí. A to pokud možno jako rozhraní (viz OCP), ne jako konkrétní implementaci. V tomto případě máme nějakého "dispečera", který se stará o vytváření ale také likvidaci potřebných instancí a hlavně definuje překladovou tabulku typů. Jaká třída má odpovídat jakému rozhraní. Tomuto "dispečerovi" se říká IoC/DI kontejner. V důsledku masivně zjednodušuje psaní kódu a hlavně jeho údržbu a srozumitelnost.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/A4TYoiF-lEI" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>
