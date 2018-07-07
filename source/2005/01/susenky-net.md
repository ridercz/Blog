<!-- dcterms:identifier = aspnetcz#8 -->
<!-- dcterms:title = Sušenky.NET -->
<!-- dcterms:abstract = Ačkoliv ASP.NET samy řeší řadu úloh, ke kterým se zpravidla používají cookies, představují HTTP sušenky užitečný způsob, jak si klienta "označkovat" a příště ho zase poznat. Implementace práce s cookies v ASP.NET ovšem neskrývá jisté záludnosti. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Tipy, triky -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2005-01-08T23:59:57.61+01:00 -->
<!-- dcterms:dateAccepted = 2005-01-08T23:59:57.61+01:00 -->

Ačkoliv ASP.NET samy řeší řadu úloh, ke kterým se zpravidla používají cookies, představují HTTP sušenky užitečný způsob, jak si klienta "označkovat" a příště ho zase poznat. Implementace práce s cookies v ASP.NET ovšem neskrývá jisté záludnosti. Pokud se chcete dozvědět něco málo o základních principech fungování cookies, přečtěte si [článek](http://archive.aspnetwork.cz/art/clanek.asp?id=151) dříve vydaný na ASP Network. Týká se sice klasických ASP 3.0, ale princip je pořád stejný.

## Request.Cookies vs. Response.Cookies

Cookies jsou v prostředí .NET reprezentovány třídami `System.Web.HttpCookie` a `System.Web.HttpCookieCollection`. Kolekce cookies jsou dostupné jako vlastnosti `Request.Cookies` a `Response.Cookies` - a v tom je právě kámen úrazu. Rozumný člověk by předpokládal, že kolekce dostupná pomocí `Request` bude read only obsahovat přijaté cookies, a že do `Response` se tyto jaksi iniciálně přepíší a následně se modifikovány pošlou na klienta.

V praxi je tomu tak, že s kolekcí v `Request` sice manipulovat můžete do alelujá, ale neuloží se, a kolekce v `Response` je prázdná a když s ní něco provedetem, občas se to do Request zpropaguje a občas ne  (pokud přidáte cookie tak ano, pokud jenom změníte hodnotu tak ne).

## Path, Domain a Expires

Kromě vlastnosti `Value` (resp. kolekce `Values`) má `HttpCookie` ještě tři užitečné vlastnosti:

`Path` - cestu v rámci webu, ve které je cookie čitelná. Standardně je hodnota nastavena na `/`, což znamená, že hodnotu může číst kterákoliv stránka v rámci webu. Pokud vaše aplikace běží v podadresáři, můžete chtít aby ostatní aplikace tuto cookie číst nemohly.

`Domain` - platnost cookie je standardně omezena na server, který ji zaslal. Můžete ovšem nastavit platnost v rámci celé domény druhé a nižší úrovně. To lze, pokud má vaše doména druhé úrovně alespoň čtyři znaky (aby nebylo možno nastavit domain-wide cookie pro ty TLD, které neumožňují přímou registraci domén druhé úrovně, např. `co.uk`). Pokud tedy chcete, aby hodnota cookie byla sdílena mezi více stroji v jedné doméně (např. [*www.aspnet.cz*](vid:/) a *necojineho.aspnet.cz*), nastavte vlastnost `Domain` na hodnotu "`aspnet.cz`".

`Expires` - pokud necháte hodnotu prázdnou (potažmo `DateTime.MinValue`), cookie bude tzv. *per-session*. Neuloží se na disk klientského počítače, ale jenom do paměti a bude při zavření okna prohlížeče odstraněna. Pokud chcete cookie smazat, nastavte její hodnotu Expires do minulosti.

## Užitečné funkce

Následujících několik funkcí vám zpříjemní práci s cookies a ošetřování chybových stavů (když cookie neexistuje). Předpkládám, že kód nepotřebuje komentář

Public Shared Function GetCookie(ByVal Key1 As String, ByVal Key2 As String, Optional ByVal DefaultValue As String = "") As String Try Return System.Web.HttpContext.Current.Request.Cookies(Key1).Item(Key2) Catch Return DefaultValue End Try End Function Public Shared Sub SetCookie(ByVal Key1 As String, ByVal Key2 As String, ByVal Value As String, Optional ByVal DaysToExpire As Int32 = 90) Dim C As System.Web.HttpCookie C = System.Web.HttpContext.Current.Request.Cookies.Get(Key1) If C Is Nothing Then C = New System.Web.HttpCookie(Key1) Try C.Values.Item(Key2) = Value Catch C.Values.Add(Key2, Value) End Try C.Expires = DateTime.Now.AddDays(DaysToExpire) System.Web.HttpContext.Current.Response.Cookies.Add(C) End Sub Public Shared Sub DeleteCookie(ByVal Name As String) Dim C As System.Web.HttpCookie = System.Web.HttpContext.Current.Request.Cookies.Get(Name) If C Is Nothing Then Return C.Expires = DateTime.Now.AddDays(-1) System.Web.HttpContext.Current.Response.Cookies.Add(C) End Sub