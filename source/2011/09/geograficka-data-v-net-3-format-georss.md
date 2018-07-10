<!-- dcterms:identifier = aspnetcz#336 -->
<!-- dcterms:title = Geografická data v .NET 3: Formát GeoRSS -->
<!-- dcterms:abstract = V předchozích článcích jsem se zabýval zpracováním prostorových dat v prostředí Microsoft SQL Serveru 2008 a Microsoft .NET Frameworku. Víme už, jak zeměpisné souřadnice uchovávat v databázi, jak se na ně dotazovat a jak s výsledkem zacházet z prostředí ASP.NET. Nyní se podíváme na dva ze způsobů, jak lze geografická data publikovat uživateli – na geotagging a GeoRSS. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Programování -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- np9:serialId = 6 -->
<!-- x4w:serial = Geografická data v .NET -->
<!-- dcterms:created = 2011-09-13T02:43:54.503+02:00 -->
<!-- dcterms:dateAccepted = 2011-09-23T08:00:00+02:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20100603-geograficka-data-v-net-1-spatial-funkce-sql-serveru-2008.png -->

<p>V předchozích článcích jsem se zabýval zpracováním prostorových dat v prostředí Microsoft SQL Serveru 2008 a Microsoft .NET Frameworku. Víme už, jak zeměpisné souřadnice uchovávat v databázi, jak se na ně dotazovat a jak s výsledkem zacházet z prostředí ASP.NET. Nyní se podíváme na dva ze způsobů, jak lze geografická data publikovat uživateli – na geotagging a GeoRSS.</p>
<h2>Geotagging</h2>
<p>Geotagging je obecný název pro přiřazení GPS souřadnic k jiným datům. Typické aplikace jsou třeba přiřazení souřadnic místa vzniku k fotografii. Případně přidat zeměpisné souřadnice místa k článku, který o něm pojednává. Já třeba používám geotagging na webu <a href="http://akce.altairis.cz/">akce.altairis.cz</a> v RSS feedu. Pokud organizátor akce u místa konání uvedl GPS souřadnice, jsou uvedeny i v RSS feedu.</p>
<p>Pro tyto účely se používá namespace <a href="http://www.w3.org/2003/01/geo/wgs84_pos" title="http://www.w3.org/2003/01/geo/wgs84_pos#">http://www.w3.org/2003/01/geo/wgs84_pos#</a> a jeho elementy <em>lat</em> a <em>long</em>.</p>
<h2>GeoRSS</h2>
<p>Zatímco předchozí formát je určen k uvedení dodatečné informace o poloze k dalším zdrojům, "konkurenční" formát GeoRSS je přímo navržen k publikování seznamů geografických objektů. Kromě prostých bodů lze jeho prostřednictvím publikovat i informace o tvarch (polygonech) a cestách (polyline). U geotagovaného RSS feedu se počítá s tím, že bude konzumován především běžnými čtečkami, zatímco GeoRSS je určeno spíše pro specializované mapové aplikace (ačkoliv normální RSS čtečka ho načte taky).</p>
<p>Namespace GeoRSS je <a href="http://www.georss.org/georss">http://www.georss.org/georss</a> a na uvedeném serveru také najdete jeho specifikaci. My budeme používat jeho element <em>point</em>, ale jsou i další, pro složitější konstrukty</p>
<h2>Formát RSS feedu</h2>
<p>Budeme pracovat s daty z předchozího příkladu a publikujeme je formou RSS feedu. V zájmu široké kompatibility do feedu uvedeme souřadnice v obou formátech. Hotový feed bude vypadat například takto:</p>
<pre class="xml">&lt;rss version="2.0" xmlns:geo="http://www.w3.org/2003/01/geo/wgs84_pos#" xmlns:georss="http://www.georss.org/georss"&gt;
    &lt;channel&gt;
        &lt;title&gt;Výsledky dotazu&lt;/title&gt;
        &lt;item&gt;
            &lt;title&gt;Město Brno&lt;/title&gt;
            &lt;description&gt;&amp;lt;small&amp;gt;Územní celek&amp;lt;/small&amp;gt;&amp;lt;br/&amp;gt;GPS: 49,199541; 16,607552&lt;/description&gt;
            &lt;geo:lat&gt;49.199541&lt;/geo:lat&gt;
            &lt;geo:long&gt;16.607552&lt;/geo:long&gt;
            &lt;georss:point&gt;49.199541 16.607552&lt;/georss:point&gt;
            &lt;icon&gt;http://localhost:25566/GeoSamplesWeb/Images/IconA.png&lt;/icon&gt;
        &lt;/item&gt;
        &lt;item&gt;
            &lt;title&gt;Brno&lt;/title&gt;
            &lt;description&gt;&amp;lt;small&amp;gt;Sídlo&amp;lt;/small&amp;gt;&amp;lt;br/&amp;gt;GPS: 49,195223; 16,607959&lt;/description&gt;
            &lt;geo:lat&gt;49.195223&lt;/geo:lat&gt;
            &lt;geo:long&gt;16.607959&lt;/geo:long&gt;
            &lt;georss:point&gt;49.195223 16.607959&lt;/georss:point&gt;
            &lt;icon&gt;http://localhost:25566/GeoSamplesWeb/Images/IconP.png&lt;/icon&gt;
        &lt;/item&gt;
        &lt;item&gt;
            &lt;title&gt;Jihomoravský kraj&lt;/title&gt;
            &lt;description&gt;&amp;lt;small&amp;gt;Územní celek&amp;lt;/small&amp;gt;&amp;lt;br/&amp;gt;GPS: 49,201224; 16,613388&lt;/description&gt;
            &lt;geo:lat&gt;49.201224&lt;/geo:lat&gt;
            &lt;geo:long&gt;16.613388&lt;/geo:long&gt;
            &lt;georss:point&gt;49.201224 16.613388&lt;/georss:point&gt;
            &lt;icon&gt;http://localhost:25566/GeoSamplesWeb/Images/IconA.png&lt;/icon&gt;
        &lt;/item&gt;
        &lt;item&gt;
            &lt;title&gt;sady Osvobození&lt;/title&gt;
            &lt;description&gt;&amp;lt;small&amp;gt;Park, rezervace&amp;lt;/small&amp;gt;&amp;lt;br/&amp;gt;GPS: 49,198784; 16,610899&lt;/description&gt;
            &lt;geo:lat&gt;49.198784&lt;/geo:lat&gt;
            &lt;geo:long&gt;16.610899&lt;/geo:long&gt;
            &lt;georss:point&gt;49.198784 16.610899&lt;/georss:point&gt;
            &lt;icon&gt;http://localhost:25566/GeoSamplesWeb/Images/IconL.png&lt;/icon&gt;
        &lt;/item&gt;
        &lt;item&gt;
            &lt;title&gt;Moravské náměstí&lt;/title&gt;
            &lt;description&gt;&amp;lt;small&amp;gt;Budova, místo&amp;lt;/small&amp;gt;&amp;lt;br/&amp;gt;GPS: 49,199037; 16,607938&lt;/description&gt;
            &lt;geo:lat&gt;49.199037&lt;/geo:lat&gt;
            &lt;geo:long&gt;16.607938&lt;/geo:long&gt;
            &lt;georss:point&gt;49.199037 16.607938&lt;/georss:point&gt;
            &lt;icon&gt;http://localhost:25566/GeoSamplesWeb/Images/IconS.png&lt;/icon&gt;
        &lt;/item&gt;
    &lt;/channel&gt;
&lt;/rss&gt;</pre>
<p>Ve feedu používaný element <em>icon</em> sice není standardizovaný, ale zato ho podporují jak Google Maps tak Virtual Earth.</p>
<h2>Generování RSS feedu</h2>
<p>RSS feed budeme generovat ručně, pomocí HTTP handeru. Podporuje, stejně jako v předchozím příkladu, dva druhy dotazů:</p>
<ul>
    <li><strong>Seznam objektů ve vyznačeném obdélníku</strong>
    <ul>
        <li>Adresa feedu bude <em>GeoRss.ashx?rect=lat1;lon1;lat2;lon2</em>. </li>
        <li>Například URL <em>GeoRss.ashx?rect=51.869708;11.381836;47.613570;19.621582</em> vrátí objekty v obdélníku vyplněným přibližně ČR. </li>
    </ul>
    </li>
    <li><strong>Seznam objektů do udané vzdálenosti od zadaného bodu</strong>
    <ul>
        <li>Adresa feedu bude <em>GeoRss.ashx?rect=latitude;longitude;distance</em>. </li>
        <li>Vzdálenost je v metrech, takže <em>GeoRss.ashx?point=49.199541;16.607552;500</em> vrátí body ve vzdálenosti do 500 metrů od středu Brna. </li>
    </ul>
    </li>
</ul>
<p>Následující kód kombinuje dříve popsané techniky dotazování a zpracování výsledku s generováním RSS:</p>
<pre class="csharp">using System;
using System.Web;
using System.Xml;
using System.Data;
using System.Data.SqlClient;
using Microsoft.SqlServer.Types;

public class GeoRss : IHttpHandler {
    private const int MAXIMUM_ITEM_COUNT = 200;
    private const int SRID_WGS84 = 4326;
    private const string NAMESPACE_GEO = "http://www.w3.org/2003/01/geo/wgs84_pos#";
    private const string NAMESPACE_GEORSS = "http://www.georss.org/georss";

    public void ProcessRequest(HttpContext context) {
        // Zjistit, o jaký typ vyhledávání se jedná
        DataTable results = null;
        if (!string.IsNullOrEmpty(context.Request.QueryString["rect"])) {
            GetRectangleSearchResults(context.Request.QueryString["rect"], out results);
        }
        else if (!string.IsNullOrEmpty(context.Request.QueryString["point"])) {
            GetPointSearchResults(context.Request.QueryString["point"], out results);
        }

        // Připravit strukturu RSS feedu
        var feed = new XmlDocument();
        feed.AppendChild(feed.CreateElement("rss"));
        feed.DocumentElement.SetAttribute("version", "2.0");
        feed.DocumentElement.SetAttribute("xmlns:geo", NAMESPACE_GEO);
        feed.DocumentElement.SetAttribute("xmlns:georss", NAMESPACE_GEORSS);
        var channel = feed.DocumentElement.AppendChild(feed.CreateElement("channel"));

        if (results == null) {
            // Něco je špatně - asi syntaxe parametrů
            channel.AppendChild(feed.CreateElement("title")).InnerText = "Chybné parametry volání GeoRSS handeru";
        }
        else if (results.Rows.Count == 0) {
            // Nic jsme nenašli
            channel.AppendChild(feed.CreateElement("title")).InnerText = "Nebyly nalezeny žádné výsledky";
        }
        else {
            // Něco bychom měli...
            channel.AppendChild(feed.CreateElement("title")).InnerText = "Výsledky dotazu";
            for (int i = 0; i &lt; results.Rows.Count; i++) {
                var itemId = (int)results.Rows[i]["GeoPointId"];
                var itemName = results.Rows[i]["Name"] as string;
                var itemClass = results.Rows[i]["Class"] as string;
                var itemClassName = results.Rows[i]["ClassName"] as string;
                var location = results.Rows[i]["Location"] as SqlGeography;

                var description = string.Format("<small>{0}</small><br>GPS: {1:N6}; {2:N6}",
                                                itemClassName,
                                                location.Lat,
                                                location.Long);

                var baseUrl = GetBaseUrl(context);

                var item = channel.AppendChild(feed.CreateElement("item"));
                item.AppendChild(feed.CreateElement("title")).InnerText = itemName;
                item.AppendChild(feed.CreateElement("description")).InnerText = description;
                item.AppendChild(feed.CreateElement("geo", "lat", NAMESPACE_GEO)).InnerText = XmlConvert.ToString(location.Lat.Value);
                item.AppendChild(feed.CreateElement("geo", "long", NAMESPACE_GEO)).InnerText = XmlConvert.ToString(location.Long.Value);
                item.AppendChild(feed.CreateElement("georss", "point", NAMESPACE_GEORSS)).InnerText = XmlConvert.ToString(location.Lat.Value) + " " + XmlConvert.ToString(location.Long.Value);
                item.AppendChild(feed.CreateElement("icon")).InnerText = string.Format("{0}/Images/Icon{1}.png", baseUrl, itemClass);
            }
        }

        // Poslat dokument na klienta
        context.Response.ContentType = "text/xml";
        feed.Save(context.Response.OutputStream);
    }

    private static string GetBaseUrl(HttpContext context) {
        var baseUrl = new UriBuilder(context.Request.Url);
        baseUrl.Path = context.Request.ApplicationPath.TrimEnd('/');
        baseUrl.Query = string.Empty;
        baseUrl.Fragment = string.Empty;
        return baseUrl.ToString();
    }

    private static void GetRectangleSearchResults(string query, out DataTable results) {
        results = null;

        // Validovat vstupní data
        if (string.IsNullOrEmpty(query)) return;
        var parts = query.Split(';');
        if (parts.Length != 4) return;

        // Načíst souřadnice obdélníku
        double lat1 = XmlConvert.ToDouble(parts[0]);
        double lon1 = XmlConvert.ToDouble(parts[1]);
        double lat2 = XmlConvert.ToDouble(parts[2]);
        double lon2 = XmlConvert.ToDouble(parts[3]);

        // Vytvořit obdélník, v němž se budeme dotazovat
        var rectBuilder = new SqlGeographyBuilder();
        rectBuilder.SetSrid(SRID_WGS84); // Použít WGS84
        rectBuilder.BeginGeography(OpenGisGeographyType.Polygon);
        rectBuilder.BeginFigure(lat1, lon1);
        rectBuilder.AddLine(lat2, lon1);
        rectBuilder.AddLine(lat2, lon2);
        rectBuilder.AddLine(lat1, lon2);
        rectBuilder.AddLine(lat1, lon1);
        rectBuilder.EndFigure();
        rectBuilder.EndGeography();
        var rect = rectBuilder.ConstructedGeography;

        // Najít všechny položky v tomto obdélníku
        using (var db = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["GeoConnectionString"].ConnectionString)) {
            using (var cmd = new SqlCommand("SELECT TOP " + MAXIMUM_ITEM_COUNT + " GeoPointId, Name, Class, ClassName, Location FROM vGeoPoints WHERE Location.STIntersects(@Rect) = 1", db)) {
                db.Open();
                cmd.Parameters.Add(new SqlParameter {
                    ParameterName = "@Rect",
                    SqlDbType = SqlDbType.Udt,
                    UdtTypeName = "geography",
                    Value = rect
                });
                results = new DataTable();
                using (var da = new SqlDataAdapter(cmd)) {
                    da.Fill(results);
                }
            }
        }
    }

    private static void GetPointSearchResults(string query, out DataTable results) {
        results = null;

        // Validovat vstupní data
        if (string.IsNullOrEmpty(query)) return;
        var parts = query.Split(';');
        if (parts.Length != 3) return;

        // Načíst souřadnice bodu a vzdálenost v metrech
        double lat = XmlConvert.ToDouble(parts[0]);
        double lon = XmlConvert.ToDouble(parts[1]);
        long delta = XmlConvert.ToInt64(parts[2]);

        // Vytvořit bod, který reprezentuje střed hledání
        var point = SqlGeography.Point(lat, lon, SRID_WGS84);

        // Najít všechny položky ve vzdálenosti max @Delta metrů od @Point
        using (var db = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["GeoConnectionString"].ConnectionString)) {
            using (var cmd = new SqlCommand("SELECT TOP " + MAXIMUM_ITEM_COUNT + " GeoPointId, Name, Class, ClassName, Location FROM vGeoPoints WHERE @Point.STDistance(Location) &lt;= @Delta", db)) {
                db.Open();
                cmd.Parameters.Add("@Delta", SqlDbType.Int).Value = delta;
                cmd.Parameters.Add(new SqlParameter {
                    ParameterName = "@Point",
                    SqlDbType = SqlDbType.Udt,
                    UdtTypeName = "geography",
                    Value = point
                });
                results = new DataTable();
                using (var da = new SqlDataAdapter(cmd)) {
                    da.Fill(results);
                }
            }
        }
    }

    public bool IsReusable {
        get {
            return true;
        }
    }

}</pre>
<p>Takto vzniklý GeoRSS feed lze konzumovat pomocí Bing Maps (Virtual Earth) nebo Google Maps a zobrazit nalezené body na mapě.</p>