<!-- dcterms:identifier = aspnetcz#204 -->
<!-- dcterms:title = Pozvánka na dva semináře o šifrování a digitálních podpisech -->
<!-- dcterms:abstract = Pozvánka na prázdninové akce o šifrování a digitálních podpisech. Aneb když už to děláte, dělejte to pořádně! -->
<!-- np9:categoryId = 6 -->
<!-- x4w:category = Akce a události -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2008-07-03T09:00:00+02:00 -->
<!-- dcterms:dateAccepted = 2008-07-03T09:00:00+02:00 -->

[![New Orleans - D-Day Museum - Enigma Machine - 3-9-08](http://static.flickr.com/2295/2333133387_1e87ddba6e.jpg)](http://www.flickr.com/photos/14481705@N04/2333133387/ "New Orleans - D-Day Museum - Enigma Machine - 3-9-08")Poslední dobou se mi hned několikrát dostalo té pochybné cti pracovat s několika různými API a technologiemi, využívajícími technologie digitálního podpisu, případně šifrování. Smutné je, že většinou byla implementace těchto technologií do značné míry Potěmkinovou vesnicí: architektura systému byla navržena tak špatně, že i přes poměrně značné vynaložené úsilí byly diskutované systémy stále napadnutelné.

Pročež jsem se rozhodl o prázdninách uspořádat dva semináře, které se budou zabývat právě elektronickými podpisy a šifrováním. Z programátorsko-pragmatického hlediska (já také nejsem žádný kryptolog). Spíše než detaily fungování jednotlivých algoritmů se podíváme na možnosti jejich použití při psaní vlastních programů, API a komunikačních protokolů.

Nebudeme se bavit o certifikátech a zaručených a kvalifikovaných podpisech dle zvláštního zákona, ale spíše o tom, jak lze využít jednodušší kryptografické mechanismy při vytváření vlastních aplikací a jejich rozhraní. Neodpustím si samozřejmě pár výletů do historie, jak je možno poznat i z fotografie klávesnice jedné z verzí Enigmy, šifrovacího stroje používaného za druhé světové války ;-)

## Digitální podpisy: jak fungují a jak je správně použít

**Microsoft Praha, sál Aquarius, 31. 7. 2008 od 18:00, více informací a registrace na **[**akce.altairis.cz**](http://akce.altairis.cz/Events/190.aspx)

*V tomto semináři se podíváme na hashovací algoritmy a jejich využití pro digitální podepisování zpráv metodou HMAC (Hash Message Authentication Code). Podíváme se, jak můžete ve svých programech zabezpečit předávané zprávy proti úmyslné i neúmyslné manipulaci. Popisované mechanismy jsou hojně využívány v ASP.NET, například při zpracování ViewState nebo generování autentizačních ticketů pro Forms Authentication.*

## Šifrovací algoritmy: praktická implementace v .NET

**Microsoft Praha, sál Aquarius, 20. 8. 2008 od 18:00, více informací a registrace na **[**akce.altairis.cz**](http://akce.altairis.cz/Events/191.aspx)

*Navazující seminář se zaměří na utajení obsahu předávaných zpráv šifrováním. Podíváme se na symetrické a asymetrické šifry, jejich výhody a nevýhody. Vrátíme se také k tématu digitálních podpisů, tentokrát realizovaných prostředky asymetrické kryptografie.*

Vstup na oba semináře je zdarma, podmínkou je pouze předchozí registrace. Příklady kódu budu ukazovat v C# převážně v prostředí ASP.NET, nicméně nejedná se o téma čistě webové ani .NET-ové, popisované principy jest využít i v jakýchkoliv jiných technologiích.

Budou-li bohové milostiví, pořídím z obou akcí záznam a umístím ho na web. Dva záznamy už z předchozích akcí mám a připravuji jejich publikování, jenom tradičně nestíhám, tak se to vleče.