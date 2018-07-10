<!-- dcterms:identifier = aspnetcz#70 -->
<!-- dcterms:title = Programová práce s hlavičkou stránky -->
<!-- dcterms:abstract = Novinkou v ASP.NET 2.0 je nativní přístup k hlavičce (element HEAD) webových stránek. Je možno ho využít například k automatickému generování odkazu na RSS feed. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Tipy, triky -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2005-12-22T05:04:02.117+01:00 -->
<!-- dcterms:dateAccepted = 2005-12-22T05:04:02.117+01:00 -->

 

Novinkou v ASP.NET 2.0 je nativní přístup k hlavičce (element `head`) webových stránek. Je možno ho využít například k automatickému generování odkazu na RSS feed.

## RSS autodiscovery

S rozvojem technologie RSS se objevila nutnost nějakým systemizovaným způsobem ukázat, kde leží RSS feed dané stránky. Proto vznikl mechanismus *RSS autodiscovery*. Pokud si chcete přidat tento web do čtečky, stačí zadat adresu jeho domovské stránky ([http://www.aspnet.cz/](/)) a čtečka si sama iniciativně dohledá adresu RSS feedu jako takového ([http://www.aspnet.cz/WS/GetRSS.aspx](/WS/GetRSS.aspx)).

Celá technologie stojí na tom, že se do hlavičky stránky přidá následující kód:

    <link rel="alternate" type="application/rss+xml"
          HREF="/WS/GetRSS.aspx"
          title="Nejnovější články na ASPNET.CZ" />

Význam atributů je následující:

*   **rel="alternate"** určuje, že se jedná o alternativní verzi webu, o jinou možnost přístupu
*   **type="application/rss+xml"** určuje, že tato alternativa je v XML, konkrétně ve formátu RSS
*   **href="..."** je adresa, na níž se tato verze (feed) nachází
*   **title="..."** je textový popis feedu (nadpis)

## Dynamické generování odkazů

![Zobrazení více RSS feedů v IE7 Beta 1](https://www.cdn.altairis.cz/Blog/2005/20051222-IE7RSS.png)Pokud máte na webu jediný feed pro všechny články, je řešení snadné - prostě na všechny stránky vložíte jeden odkaz a je vystaráno. Nicméně pokud chcete u většího webu provozovat feedů více, například pro každou rubriku nebo autora, je to poněkud problém. RSS autodiscovery to umožňuje (můžete mít více feedů, rozlišíte je atributem *title*), ale odkazy na ně musíte generovat dynamicky.

Naštěstí třída `System.Web.UI.Page` disponuje v ASP.NET 2.0 vlastností `Head`. Ta reprezentuje právě sekci `head` v HTML kódu. A jako (skoro) všechny ovládací prvky disponuje kolekcí `Controls`, která obsahuje ovládací prvky které jsou její součástí. Pak už stačí jen vytvořit instanci třídy `System.Web.UI.HtmlControls.HtmlLink`, nastavit jí parametry a z backendového kódu ji přidat.

Napsal jsem si na to jednoduchou metodu nazvanou `AddRssFeed`:

    Public Shared Sub AddRssFeed(ByVal Page As System.Web.UI.Page, ByVal Title As String, ByVal Url As String)
        Dim L As New System.Web.UI.HtmlControls.HtmlLink()
        L.Attributes.Add("rel", "Alternate")
        L.Attributes.Add("type", "application/rss+xml")
        L.Attributes.Add("title", Title)
        L.Attributes.Add("href", Url)
        Page.Header.Controls.Add(L)
    End Sub

Ze stránky ji můžete zavolat jednoduše, například: `AddRssFeed(Me, "Články v rubrice " & CategoryName, "~/Rss.ashx?Category=" & CategoryID)`.