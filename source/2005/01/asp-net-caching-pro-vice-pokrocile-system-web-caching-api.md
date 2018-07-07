<!-- dcterms:identifier = aspnetcz#7 -->
<!-- dcterms:title = ASP.NET caching pro více pokročilé: System.Web.Caching API -->
<!-- dcterms:abstract = V předchozích dvou zápisech o cacheování jsem se věnoval ukládání hotových výstupů, ať už celých stránek nebo jenom jejich částí (user controls). To ovšem není jediná forma cachingu, jakou ASP.NET podporují. Prostřednictvím caching API (namespace System.Web.Caching.Cache) můžete ukládat v podstatě libovolné objekty. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Tipy, triky -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2005-01-07T06:16:35.437+01:00 -->
<!-- dcterms:dateAccepted = 2005-01-07T06:16:35.437+01:00 -->

V předchozích dvou zápisech o cacheování jsem se věnoval ukládání hotových výstupů, ať už [celých stránek](/entry/article-20050105.aspx) nebo jenom [jejich částí](/entry/article-20050106.aspx) (user controls). To ovšem není jediná forma cachingu, jakou ASP.NET podporují. Prostřednictvím caching API (namespace `System.Web.Caching.Cache`) můžete ukládat v podstatě libovolné objekty. Patřičné rozhraní je jednoduché, ale velmi užitečné.

Základní informace o tomto tématu sepsala [má milovaná](http://www.bestijka.cz/) před nějakým časem ve článku [System.Web.Caching – cachování objektů v ASP.NET](http://archive.aspnetwork.cz/art/clanek.asp?id=191), na který vás tímto odkazuji. Budu se věnovat několika záludnostem.

## Bezpečné načítání položek z cache

To že jste si něco uložili do cache ještě neznamená, že to tam najdete. Systém položky z cache odstraňuje nejen dle vámi explicitně určených pravidel (závislostí), ale též dle vlastního uvážení, příkladně pocítí-li nedostatek paměti. Obecně tedy možné na existenci cacheovaných dat spoléhat a pokud s nimi chcete pracovat, měli byste tak činit prostřednictvím nějakého wrapperu, který je buď načte z cache a nebo, neexistují-li, je vygeneruje a do cache uloží. Osobně používám přibližně následující kód:

Public Function GetCategories(Optional ByVal UseCache As Boolean = True) As DataTable ' Pokus se načíst hodnotu z cache Dim Cats As DataTable = DirectCast(Cache("Categories"), DataTable) If Cats Is Nothing Or Not UseCache Then ' Pokud nebyl objekt v cache nalezen, nebo bylo použití cache ' explicitně zakázáno, načti data z databáze Dim DA As New System.Data.SqlClient.SqlDataAdapter( _ "SELECT CategoryID, Name, Description FROM Categories ORDER BY Name", _ "SERVER=(local);UID=uzivatel;PWD=heslo") DA.Fill(Cats) DA.Dispose() ' ...a ulož je do cache Cache.Insert("Categories", Cats, Nothing, DateTime.Now.AddMinutes(15), TimeSpan.Zero) End If ' Vrať obstaranou hodnotu Return Cats End Function

Pomocí nepovinného parametru `UseCache` jest možno v odůvodněných případech vynutit obnovení cache (např. vím-li že se daná hodnota změnila).

## Záludnost jménem CacheItemRemovedCallback

ASP.NET teoreticky obsahují výtečnou funkci, která by shora uvedený problém mohla vyřešit. Tou je delegát `CacheItemRemovedCallback`, který může ukazovat na funkci, která se vykoná v okamžiku, kdy je objekt z cache odstraněn. V praxi je její použitelnost dosti omezená, protože volání probíhá tak, že se objekt *nejprve* odstraní z cache a až *potom* se zavolá callback, který by cache mohl eventuelně znovu naplnit. Což je úkon, který může jistou dobu trvat. Po tuto dobu objekt v cache nebude přítomen, což nás oklikou vrací zpět na začátek a na objekty uložené v cache není možno se spolehnout.

V praxi jsem zatím našel pro tuto funkci jediné využití, a to zaznamenávat případy odstranění objektu z důvodu nedostatku paměti. Pokud se to stává příliš často, měli byste uvažovat o tom, že svému serveru dopřejete víc RAMky.

## Sladká budoucnost

Cacheování získává nový rozměr v okamžiku, kdy lze specifikovat závislost uloženého objektu na něčem jiném. Současná verze ASP.NET 1.1 umí nastavovat závislost uložených objektů toliko na souborech nebo jiných cacheovaných objektech (prostřednictvím `System.Web.Caching.CacheDependency`). V případě, že je údaj závislý na něčem jiném, příkladně na obsahu databáze, máte smůlu - musíte se smířit s tím, že může nastat situace kdy bude objekt neaktuální a nastavit čas expirace tak, aby ta doba byla přijatelná pro vaše záměry.

ASP.NET 2.0 (Whidbey) ovšem slibují třídu `System.Web.Caching.SqlCacheDependency`, umožňující stanovit závislost cacheovaného prvku na SQL databázi. O důvod víc, proč se na Whidbey těšit.