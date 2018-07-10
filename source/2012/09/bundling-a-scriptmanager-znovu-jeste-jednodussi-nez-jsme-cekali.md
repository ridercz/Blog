<!-- dcterms:identifier = aspnetcz#402 -->
<!-- dcterms:title = Bundling a ScriptManager znovu: ještě jednodušší, než jsme čekali -->
<!-- dcterms:abstract = Na své přednášce o práci s JavaScriptem a v CSS jsem tvrdil, že mezi bundlingem a ScriptManagerem není žádné propojení a představil jsem dva způsoby, jak jej realizovat. Ukázalo se, že jsem se mýlil a že v nejnovější dostupné verzi takové propojení je a dokonce je automaticky funkční. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Tipy, triky -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2012-09-02T15:40:29.68+02:00 -->
<!-- dcterms:dateAccepted = 2012-09-02T15:30:00+02:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20120902-bundling-a-scriptmanager-znovu-jeste-jednodussi-nez-jsme-cekali.png -->

Na své [přednášce o práci s JavaScriptem a CSS v ASP.NET](http://www.aspnet.cz/articles/401-novinky-v-asp-net-4-5-novy-pristup-k-praci-s-javascriptem-a-css-zaznam-a-priklady) jsem tvrdil, že mezi bundlingem a ScriptManagerem není žádné propojení a představil jsem dva způsoby, jak jej realizovat. 

Ukázalo se, že jsem se mýlil a že v nejnovější dostupné verzi takové propojení je a dokonce je automaticky funkční – děkuji Adamovi Hörzenbergerovi, že mne na to upozornil.

Stačí prostě vytvořit bundle a zaregistrovat jeho ScriptResourceDefinition, například takto:

    // Local JavaScript files
    BundleTable.Bundles.Add(new ScriptBundle("~/bundles/SiteJs").Include(
        "~/Scripts/site/*.js"));

    // Register script resource mapping for local JavaScript files
    ScriptManager.ScriptResourceMapping.AddDefinition("SiteBundle",
        new ScriptResourceDefinition { Path = "~/bundles/SiteJs" });

Poté se na něj můžete odkázat ze stránky pomocí ScriptManageru:

    <asp:ScriptManager runat="server">
        <Scripts>
            <asp:ScriptReference Name="SiteBundle" />
        </Scripts>
    </asp:ScriptManager>

To je vše. Hash pro cache busting se dopočítá automaticky.