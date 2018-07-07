<!-- dcterms:identifier = aspnetcz#335 -->
<!-- dcterms:title = Geografická data v .NET 2: Spatial typy v .NET -->
<!-- dcterms:abstract = Z minulého článku již víte, jakým způsobem můžete uchovávat v SQL Serveru prostorová data (jako například GPS souřadnice) a jak se na ně můžete dotazovat pomocí jazyka Transact-SQL. Používají se přitom datové typy geometry a geography, s nimiž lze samozřejmě pracovat i z prostředí ASP.NET, čemuž je věnován tento článek. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Tipy, triky -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- np9:serialId = 6 -->
<!-- x4w:serial = Geografická data v .NET -->
<!-- dcterms:created = 2011-09-13T02:39:04.457+02:00 -->
<!-- dcterms:dateAccepted = 2011-09-15T08:00:00+02:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20110915-geograficka-data-v-net-2-spatial-typy-v-net.png -->

> **Redakční poznámka:** Když jsem více než před rokem vydával první díl tohoto seriálu, byl jsem dohodnutý s Petrem Kaletou, který slíbil dopsat poslední díl, zahrnující zobrazování GeoRSS dat na Google Maps. Protože to je něco, co vážně neumím. Bohužel, přes několikeré urgence se mi jej nepodařilo k napsání článku přimět. Rozhodl jsem se tedy zbylé dva díly zveřejnit tak, jak jsou.
> 
> Pokud se mezi čtenáři ASPNET.CZ najde někdo, kdo se na rozdíl ode mne vyžívá v psaní mashupů a Google Maps API nemá kopřivku, budu velmi rád, když se o patřičný postup podělí s ostatními čtenáři.

Z [minulého článku](http://www.aspnet.cz/articles/285-geograficka-data-v-net-1-spatial-funkce-sql-serveru-2008) již víte, jakým způsobem můžete uchovávat v SQL Serveru prostorová data (jako například GPS souřadnice) a jak se na ně můžete dotazovat pomocí jazyka Transact-SQL. Používají se přitom datové typy `geometry` a `geography`, s nimiž lze samozřejmě pracovat i z prostředí ASP.NET.

Při práci s těmito datovými typy zapomeňte na LINQ-to-SQL nebo ADO.NET Entity Framework. Bohužel se mi nepodařilo tyto technologie ke spolupráci s prostorovými daotvými typy donutit (což samozřejmě neznamená, že to objektivně nejde – pokud na to přijdete, napište mi do komentářů). Budeme tedy muset použít klasické ADO.NET a psát SQL dotazy.

Začneme tím, že do projektu přidáme referenci na assembly `Microsoft.SqlServer.Types.dll` a v inkriminovaných třídách naimportujeme namespace `Microsoft.SqlServer.Types`. Ten obsahuje mimo jiné třídy `SqlGeography` a `SqlGeographyBuilder`. Ukážeme si, jak z .NET Frameworku řešit dříve uvedené příklady, tedy vyhledání bodů v okolí a vyhledání bodů v polygonu.

## Konstrukce SQL dotazu

SQL dotaz je jednoduchý a prakticky tentýž, který jsme už viděli v předchozím článku. Pro vyhledání bodů ve vzdálenosti nejvýše `@Delta` metrů od bodu `@Point` to bude `SELECT GeoPointId, Name, Class, ClassName, Location FROM vGeoPoints WHERE @Point.STDistance(Location) <= @Delta`. Trik spočívá v předání parametru `@Point` (s `@Delta` žádný problém nebude, to je klasický `int`).

Třída `SqlGeography` je CLR protějškem SQL typu `geography`. Umí reprezentovat bod, polygon nebo trasu. Pro účely shora uvedeného dotazu nám stačí nejprostší varianta, tedy bod. K vytvoření instance třídy reprezentující bod lze použít statickou metodu `Point`. Ta bere tři parametry: zeměpisnou šířku, délku a již z minula nám známé SRID, tedy číslo referenčního modelu – v našem případě je to 4326 pro WGS84.

Zdrojový kód bude vypadat následovně:

// Vytvořit bod, který reprezentuje střed hledání var point = SqlGeography.Point(16.607552, 49.199541, 4326); // Najít všechny položky ve vzdálenosti max. 10 km od @Point using (var db = new SqlConnection("SERVER=.\SqlExpress;TRUSTED_CONNECTION=yes;DATABASE=Geo") { using (var cmd = new SqlCommand("SELECT GeoPointId, Name, Class, ClassName, Location FROM vGeoPoints WHERE @Point.STDistance(Location) <= @Delta", db)) { db.Open(); cmd.Parameters.Add("@Delta", SqlDbType.Int).Value = 10000; cmd.Parameters.Add(new SqlParameter { ParameterName = "@Point", SqlDbType = SqlDbType.Udt, UdtTypeName = "geography", Value = point }); results = new DataTable(); using (var da = new SqlDataAdapter(cmd)) { da.Fill(results); } } }

V případě druhého typu dotazu, tedy vyhledávání bodu v polygonu, je vytvoření odpovídající `SqlGeography` poněkud komplikovanější. K dispozici máme statické metody známé ze SQL Serveru – třeba `STPolyFromText`. Systematičtější přístup nabízí třída `SqlGeographyBuilder`. Detailní popis jejích metod si najděte v dokumentaci, níže uvedený kód vytvoří nám známý obdélník (kde `lat1`/`lon1` a `lat2`/`lon2` jsou souřadnice protilehlých rohů). Na první pohled je zbytečně složitý, nicméně builder počítá s vytvářením výrazně komplikovanějších tvarů, čemuž odpovídá i jeho robustnost.

var rectBuilder = new SqlGeographyBuilder(); rectBuilder.SetSrid(4326); rectBuilder.BeginGeography(OpenGisGeographyType.Polygon); rectBuilder.BeginFigure(lat1, lon1); rectBuilder.AddLine(lat2, lon1); rectBuilder.AddLine(lat2, lon2); rectBuilder.AddLine(lat1, lon2); rectBuilder.AddLine(lat1, lon1); rectBuilder.EndFigure(); rectBuilder.EndGeography(); var rect = rectBuilder.ConstructedGeography;

Vlastní dotazování pak je prakticky stejné jako ve výše uvedeném příkladu:

using (var db = new SqlConnection("SERVER=.\SqlExpress;TRUSTED_CONNECTION=yes;DATABASE=Geo") { using (var cmd = new SqlCommand("SELECT GeoPointId, Name, Class, ClassName, Location FROM vGeoPoints WHERE Location.STIntersects(@Rect) = 1", db)) { db.Open(); cmd.Parameters.Add(new SqlParameter { ParameterName = "@Rect", SqlDbType = SqlDbType.Udt, UdtTypeName = "geography", Value = rect }); results = new DataTable(); using (var da = new SqlDataAdapter(cmd)) { da.Fill(results); } } }

## Práce s výsledkem

S výsledkem dotazu můžete pracovat obvyklým způsobem. Můžete použít například `SqlDataReader` a data zpracovávat po řádcích. Nebo můžete udělat totéž, co já v předchozím příkladu, a použít `SqlDataAdapter` k naplnění `DataTable`, se kterou budete dále pracovat. Požadovaný sloupec pak stačí přetypovat na `SqlGeography` a můžete s ním dále pracovat běžným způsobem:

var location = results.Rows[0]["Location"] as SqlGeography; double lat = location.Lat.Value; double lon = location.Long.Value;

V příštím pokračování se seznámíme s formátem GeoRSS, který umožní publikovat seznamy geotagged bodů, a který se nám bude náramně hodit pro zobrazování bodů na mapě pomocí Virtual Earth nebo Google Maps.

**Příklady k tomuto seriálu si můžete stáhnout na **[**http://www.aspnet.cz/files/20100603-GeoSamples.zip**](https://www.cdn.altairis.cz/Blog/2010/20100603-GeoSamples.zip)** (760 kB).**