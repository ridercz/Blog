<!-- dcterms:identifier = aspnetcz#334 -->
<!-- dcterms:title = Psaní databázově agnostických aplikací pomocí ADO.NET -->
<!-- dcterms:abstract = Většina aplikací potřebuje ke štěstí nějakou databázi. Někdy si můžeme svobodně vybrat, jaký typ databázového stroje budeme používat, jindy ne. Pro ten druhý případ je výhodné umět psát aplikace tak, aby uměly pracovat obecně s jakoukoliv databází, nebyly vázané na konkrétní produkt. O takových aplikacích pak říkáme, že jsou databázově agnostické. Ukážeme si jeden ze způsobů, jak takové aplikace psát. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Tipy, triky -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2011-09-13T02:24:42.313+02:00 -->
<!-- dcterms:dateAccepted = 2011-09-13T02:24:44+02:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20110913-psani-databazove-agnostickych-aplikaci-pomoci-ado-net.png -->

Většina aplikací potřebuje ke štěstí nějakou databázi. Někdy si můžeme svobodně vybrat, jaký typ databázového stroje budeme používat, jindy ne. Pro ASP.NET aplikace se nejčastěji využívá Microsoft SQL Server, ale pokud má firma větší zkušenosti třeba s Oraclem, může ho chtít využít. Nebo naopak, pokud bude daná aplikace malá, může se vyplatit místo "velkého" SQL Serveru použít "malý" SQL Compact, o kterém tady byla řeč nedávno. A nádavkem mít možnost přejí  zase na ten "velký" ve chvíli, kdy aplikace přestane být malou. Takovéhle otázky musíte často řešit ve chvíli, kdy jako independent software vendor píšete aplikaci nebo komponentu, která by měla být pokud možno univerzální a vyhovovat co nejširší škále zákazníků. Vaším cílem je napsat aplikaci, která bude fungovat s jakoukoliv databází, kterou bude mít k dispozici. Můžeme o ní říct, že je **databázově agnostická**.

Dokonalá databázová agnosticita je něco jako svatý grál a nebo dokonalá platformní nezávislost, přičemž ta druhá se obvykle překládá jako "pořádně nefunguje ani na jedné platformě". Za nezávislost zaplatíte neschopností využít funkce specifické pro tu kterou databázi a ztrátou možnosti optimalizovat váš kód pro tu kterou konkrétní databázi. Můžete totiž využít jenom tu podmnožinu databázových funkcí, které jsou společné všem vámi podporovaným databázím. Nicméně, to nemusí být často na závadu, například když píšete aplikaci rozsahem a zátěží menší, když databázi používáte jenom jako úložiště a nikoliv jako aplikační server atd.

Obecný princip psaní databázově nezávislých aplikací tkví v tom, že mezi databázi a svůj kód vložíte nějakého prostředníka. Typickým příkladem je použití O/R mapperů, jako je například ADO.NET Entity Framework. V jeho rámci definujeme konceptuální model (CSDL, zjednodušeně CLR třídy, které používá naše aplikace), storage model (SSDL, databázové tabulky, sloupečky a typy) a mapování jednoho na druhé (MSL). Při změně databáze pak stačí změnit SSDL a MSL, což se obejde bez změny a rekompilace vaší aplikace, jedná se pouze o změnu konfigurace.

Ne vždycky ale Entity Framework chceme nebo můžeme použít. Příkladem jsou třeba provideři, kteří jsou součástí mého balíku [Altairis.Web.Security](http://altairiswebsecurity.codeplex.com/). Každý využívá jednu až dvě tabulky, které navíc mají strukturu definovanou jenom velmi volně, protože chci maximálně usnadnit integraci své komponenty do stávajících aplikací. Ze stejného soudku je třeba i [SEWEN - Simple Embeddable Wiki Engine](http://sewen.codeplex.com/). V obou případech bych mohl EF využít, ale mám pocit, že by to věci zbytečně zkomplikovalo, spíše než zjednodušilo.

V tomto případě jsem využil toho, že samotné ADO.NET je jenom mezilehlou vrstvou, pomocí které lze snadno komunikovat s jakoukoliv databází, pro kterou existuje ADO.NET provider. A že s trochou námahy (a několika extension methods) můžeme napsat kód tak, aby uměl posílat naše SQL příkazy kterékoliv databázi. Druhou částí problému pak je, že musíme i ty SQL příkazy napsat tak, aby byly srozumitelné všem cílovým databázím. V tom nám ADO.NET už nijak nepomůže.

## *SqlConnection* a *SqlCommand* versus *DbConnection* a *DbCommand*

Při psaní aplikací, které využívají Microsoft SQL Server využíváme obvykle třídy *SqlConnection*, *SqlCommand*, *SqlParameter* a další z namespace *System.Data.SqlClient*. Pro jiné databáze existují obdobně pojmenované třídy v namespacech jako *System.Data.Odbc* nebo *System.Data.SqlServerCe*. Všechny tyto databázově specifické třídy jsou poděděné od společného základu, např. *SqlCommand* of *DbCommand* a podobně. Pokud budeme programovat pomocí těchto bázových tříd, dokážeme aplikaci napsat nezávisle na konkrétní databázi.

Následující kód je psaný specificky pro Microsoft SQL Server:

const string CONNECTION_STRING = @"SERVER=.\SqlExpress;TRUSTED_CONNECTION=yes;DATABASE=Northwind"; const string SQL_COMMAND = "SELECT * FROM Products WHERE UnitsInStock < @Units"; using (var db = new SqlConnection(CONNECTION_STRING)) using (var cmd = new SqlCommand(SQL_COMMAND, db)) { cmd.Parameters.Add("@Units", SqlDbType.Int).Value = 50; db.Open(); using (var r = cmd.ExecuteReader()) { while (r.Read()) { Console.WriteLine("{0,3}: {1,-40} {2,4} x", r["ProductId"], // 0 r["ProductName"], // 1 r["UnitsInStock"]); // 2 } } }

Jeho úprava pro obecné ADO.NET třídy je dost jednoduchá. Přibyla nám další konfigurační hodnota, kterou je název ADO.NET providera, který se má použít. Pro Microsoft SQL Server je to *System.Data.SqlClient*.

const string PROVIDER_NAME = "System.Data.SqlClient"; const string CONNECTION_STRING = @"SERVER=.\SqlExpress;TRUSTED_CONNECTION=yes;DATABASE=Northwind"; const string SQL_COMMAND = "SELECT * FROM Products WHERE UnitsInStock < @Units"; var factory = DbProviderFactories.GetFactory(PROVIDER_NAME); using (var db = factory.CreateConnection()) using (var cmd = db.CreateCommand()) { db.ConnectionString = CONNECTION_STRING; cmd.CommandText = SQL_COMMAND; var p = cmd.CreateParameter(); p.ParameterName = "@Units"; p.DbType = DbType.Int32; p.Value = 50; cmd.Parameters.Add(p); db.Open(); using (var r = cmd.ExecuteReader()) { while (r.Read()) { Console.WriteLine("{0,3}: {1,-40} {2,4} x", r["ProductId"], // 1 r["ProductName"], // 0 r["UnitsInStock"]); // 2 } } }

Kód se velmi podobá tomu předchozímu, jenom obsahuje daleko méně syntaktického cukru. Místo příjemných konstruktorů a metod s návodnými overloady musíme vše vytvářet "prázdné" a vlastnosti nastavit ručně. 

## Pomocné extension methods

Pro pohodlnější práci jsem si vytvořil statickou třídu *DatabaseExtensionMethods*, která obsahuje několik extension methods, které práci usnadní.

using System; using System.Configuration; using System.Data; using System.Data.Common; public static class DatabaseExtensionMethods { public static DbConnection CreateDbConnection(this ConnectionStringSettings settings) { // Validate arguments if (settings == null) throw new ArgumentNullException("settings"); if (string.IsNullOrEmpty(settings.ProviderName)) throw new ArgumentException("The ProviderName property cannot be empty.", "settings"); if (string.IsNullOrEmpty(settings.ConnectionString)) throw new ArgumentException("The ConnectionString property cannot be empty.", "settings"); var factory = DbProviderFactories.GetFactory(settings.ProviderName); var conn = factory.CreateConnection(); conn.ConnectionString = settings.ConnectionString; return conn; } public static void AddParameterWithValue(this DbCommand cmd, string name, string value) { var p = cmd.CreateParameter(); p.ParameterName = name; p.DbType = DbType.String; if (!string.IsNullOrEmpty(value)) p.Size = value.Length; p.Value = value; cmd.Parameters.Add(p); } public static void AddParameterWithValue(this DbCommand cmd, string name, int value) { var p = cmd.CreateParameter(); p.ParameterName = name; p.DbType = DbType.Int32; p.Value = value; cmd.Parameters.Add(p); } public static void AddParameterWithValue(this DbCommand cmd, string name, Guid value) { var p = cmd.CreateParameter(); p.ParameterName = name; p.DbType = DbType.Guid; p.Value = value; cmd.Parameters.Add(p); } public static void AddParameterWithValue(this DbCommand cmd, string name, DateTime value) { var p = cmd.CreateParameter(); p.ParameterName = name; p.DbType = DbType.DateTime; p.Value = value; cmd.Parameters.Add(p); } public static void AddParameterWithValue(this DbCommand cmd, string name, bool value) { var p = cmd.CreateParameter(); p.ParameterName = name; p.DbType = DbType.Boolean; p.Value = value; cmd.Parameters.Add(p); } public static void AddParameterWithValue(this DbCommand cmd, string name, byte[] value) { var p = cmd.CreateParameter(); p.ParameterName = name; p.DbType = DbType.Binary; p.Size = value.Length; p.Value = value; cmd.Parameters.Add(p); } }

První je metoda *CreateDbConnection*, která rozšiřuje poněkud netypicky třídu *ConnectionStringSettings*. Pro univerzální vytvoření a otevření spojení potřebujeme znát connection string a název providera. Tyto údaje jsou typicky součástí konfigurace, např. zhruba takto:

<configuration> <connectionStrings> <add name="Northwind" providerName="System.Data.SqlClient" connectionString="SERVER=.\SqlExpress;TRUSTED_CONNECTION=yes;DATABASE=Northwind"/> </connectionStrings> </configuration>

Druhá metoda se jmenuje *AddParameterWithValue*. Rozšiřuje *DbCommand* a funguje podobně, jako stejnojmenná metoda, kterou disponuje *SqlCommand*: na základě předaného názvu a hodnoty vytvoří patřičně otypovaný parametr. Tato metoda má šest overloadů, pro nejčastěji používané typy.

S použitím těchto extension metod je pak tvorba databázového kódu mnohem jednodušší a je stejně komfortní, jako při použití specifických tříd. Náš ukázkový kód by mohl vypadat takto:

const string SQL_COMMAND = "SELECT * FROM Products WHERE UnitsInStock < @Units"; var connectionString = ConfigurationManager.ConnectionStrings["Northwind"]; using (var db = connectionString.CreateDbConnection()) using (var cmd = db.CreateCommand()) { cmd.CommandText = SQL_COMMAND; cmd.AddParameterWithValue("@Units", 50); db.Open(); using (var r = cmd.ExecuteReader()) { while (r.Read()) { Console.WriteLine("{0,3}: {1,-40} {2,4} x", r["ProductId"], // 1 r["ProductName"], // 0 r["UnitsInStock"]); // 2 } } }

Výše uvedené metody psaní kódu zajistí, že vaše aplikace bude schopna komunikovat s jakoukoliv databází, pro níž existuje ADO.NET provider. Používám popsaný postup velmi úspěšně hned v několika svých programech, například v populární sadě membership a role providerů [Altairis Web Security Toolkit](http://altairiswebsecurity.codeplex.com/).