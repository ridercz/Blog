<!-- dcterms:identifier = aspnetcz#5452 -->
<!-- dcterms:title = Prezentace a příklady z mých přednášek na MS Festu -->
<!-- dcterms:abstract = Na pražském MS Festu jsem mluvil o kryptografii a fulltextovém vyhledávání v SQL Serveru. Nabízím vám prezentace a příklady ke stažení -->
<!-- np9:categoryId = 6 -->
<!-- x4w:category = Akce a události -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2016-11-27T18:02:21.357+01:00 -->
<!-- dcterms:dateAccepted = 2016-11-27T18:03:00+01:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20161127-prezentace-a-priklady-z-mych-prednasek-na-ms-festu.jpg -->

Na pražském MS Festu jsem mluvil o kryptografii a fulltextovém vyhledávání v SQL Serveru. Bohužel z technických důvodů nebylo možné z těchto přednášek udělat záznamy, takže se musíte spokojit s prezentacemi a příklady.

## Crypto 101: Praktická kryptografie pro .NET programátory

V této dvojpřednášce jsem se vám snažil ukázat pyramidu bezpečnosti - tu musíte vystavět, chcete-li ve své aplikaci používat kryptografii. Snažil jsem se vám vysvětlit, že v naprosté většině případů si ty kryptografické části nechcete vymýšlet a pokud možno ani programovat sami. 

Představil jsem vám kryptografickou knihovnu [Inferno](http://www.securitydriven.net/inferno), která poněkud v rozporu se svým názvem nepředstavuje peklo, ale naopak se vás toho pekla snaží uchránit. Je to high-level knihovna, která umí řešit typické problémy, aniž by po programátorovi vyžadovala odpovědi na nepohodlné otázky.

*   [Prezentace a příklady ke stažení (700 kB)](http://www.cdn.altairis.cz/Prednasky/20161127-MSFest-Crypto101.7z) 

## Jak na opravdové fulltextové vyhledávání s Microsoft SQL Serverem

Udělat opravdové fulltextové vyhledávání není jednoduché. Musí si umět poradit s různými tvary slov, logickými operátory, frázemi... Naštěstí pro nás je docela schopný fulltextový vyhledávací stroj s podporou češtiny součástí Microsoft SQL Serveru - a to včetně jeho bezplatné edice Express.

Ukázal jsem vám, jak se vytvářejí fulltextové katalogy a indexy a zejména několik různých způsobů, jak celou tu věc napojit na Entity Framework. V ukázkovém kódu také najdete jednoduchý překladač z AltaVista syntaxe do SQL fulltextu.

*   [Prezentace a příklady ke stažení (650 kB)](http://www.cdn.altairis.cz/Prednasky/20161127-MSFest-SqlFulltext.7z)