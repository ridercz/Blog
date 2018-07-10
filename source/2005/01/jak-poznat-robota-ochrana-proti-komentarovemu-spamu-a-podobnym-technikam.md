<!-- dcterms:identifier = aspnetcz#4 -->
<!-- dcterms:title = Jak poznat robota - ochrana proti komentářovému spamu a podobným technikám -->
<!-- dcterms:abstract = ASP.NET a ochrana proti robotům pomocí opisování kódu z generovaného obrázku -->
<!-- np9:categoryId = 2 -->
<!-- x4w:category = Bezpečnost -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2005-01-04T02:53:54.547+01:00 -->
<!-- dcterms:dateAccepted = 2005-01-04T02:53:54.547+01:00 -->

Nafouknutá bublina optimalizace pro vyhledávače (<acronym title="Search Engine Optimization">SEO</acronym>) přinesla fenomén *komentářového spamu* - tedy robotů, kteří automatizovaně vkládají odkazy na své weby do každého diskusního fóra, na které narazí, a které se jim podaří objevit. To vedlo k nebývalému rozšíření technik, které slouží k odhalení, který z návštěvníků je robot. Nejedná se samozřejmě o jedinou oblast využití - stejnou metodu používají mobilní operátoři aby zabránili automatizovanému rozesílání SMS přes své webové brány nebo [Úřad pro ochranu osobních údajů](http://www.uoou.cz/int/spam_stiznost.php3) na rozhraní pro elektronické podání stížnosti na spammery.

## Principy fungování

Základním principem je položit takovou otázku, na kterou člověk dokáže snadno odpovědět, ale robot ne. Příkladem může být například systém komentářů na [Game Blogu](http://blog.czhannes.com/index.php?p=575&c=1#comments). Na něm musíte pro odeslání komentáře doplnit logickou dvojici "*kočka a ???*". Už přidaná poznámka *není to "kocour" ani "myš"* ukazuje na jednu ze slabin tohoto systému: ne každý pochopí, co jste chtěli sdělit - třeba z jazykových nebo kulturních důvodů. Další nevýhodou je skutečnost, že otázka a odpověď je vždy stejná (nebo se maximálně střídá několik málo otázek). Obrana je účinná proti generickým spamovacím robotům, ale nikoliv proti útoku cílenému na tento web.

Mnohem častěji se používá techniky, kdy je uživateli zobrazen automaticky generovaný obrázek s nějakým slovem či kódem. Člověk ho snadno přečte a opíše do textového pole, robot ale nikoliv. Není to ale nemožné - pokud je text napsán běžným způsobem, lze vcelku jednoduše napsat <acronym title="Optical Character Recognition - optické rozpoznávání písma">OCR</acronym> algoritmus, který obrázek analyzuje a text přečte. Proto se v praxi obvykle přidává jistý prvek náhodnosti - různé fonty, barvy, velikosti či přidání šumu - který složitost tvorby takového algoritmu výrazně zvyšuje.

## Konkrétní řešení

Nabízím vám implementaci obrázkového generátoru v prostředí ASP.NET. Vyznačuje se následujícími vlastnostmi:

*   Barva, typ písma a jeho velikost se určují náhodně. 
Do obrázku je přidáván šum, který znesnadňuje automatickou analýzu. 
Implementace je provedena formou *web user controlu* a validátorů takže stačí tento prvek umístit na formulář a testovat validitu stránky jako obvykle (`Page.IsValid`). 
Pokud uživatel zadá kód nesprávně, pro další pokus se vygeneruje nový obrázek. Za prvé to znesnadňuje práci případným robotům (mají jenom jeden pokus). Za druhé, je-li shodou náhod vygenerován obrázek který je obtížně čitelný pro člověka, je při dalším pokusu vygenerováno něco jiného, pravděpodobně čitelnějšího.

Řešení sestává ze dvou částí. První část je zmiňovaný web user control (`HumanFilter.ascx`), který obsahuje odkaz na obrázek, textové pole a logiku validace. Druhou komponentou je ASPX stránka (`HumanFilterImageGenerator.aspx`), která na požádání vygeneruje náhodný obrázek.

Drobný problém spočívá v propojení user controlu a obrázkového generátoru. Generátoru je třeba sdělit, jaký kód má zobrazit (a to se v nějaké formě musí posílat přes klienta v počítači srozumitelném tvaru), ale zároveň klient nesmí být ze zadání schopen automaticky vygenerovat odpověď. Jako nejjednodušší řešení jsem zvolil své oblíbené [hashování se solí](http://archive.aspnetwork.cz/art/clanek.asp?id=255). Zcela veřejně a nezakrytě (jako součást URL) posílám číselný kód. K němu na straně serveru připojím tajný řetězec ("sůl") a poté spočítám MD5 hash. Prvních několik jeho znaků pak musí uživatel opsat. Bez znalosti "soli" nelze hash spočítat.

### Konfigurace

Konfigurace jest prováděna prostřednictvím čtyř konfiguračních proměnných, které jest ukládati do sekce `configuration/appSettings` souboru `Web.Config`: 

    <add key="HumanFilter.CodeLength" value="5" />
    <add key="HumanFilter.Salt" value="demo" />
    <add key="HumanFilter.ImageGenerator" value="HumanFilterImageGenerator.aspx" />
    <add key="HumanFilter.Fonts" value="Arial;Arial Black;Palatino;Comic Sans;Courier;Georgia;Impact;Lucida Console;Tahoma;Times;Trebuchet;Verdana" />

Význam proměnných je následující:

*   `HumanFilter.CodeLength` - délka opisovaného řetězce, doporučuji 4-8 znaků. 
`HumanFilter.Salt` - znění "soli", řetězce přidávaného při hashování. 
`HumanFilter.ImageGenerator` - URL stránky, která generuje obrázek. 
`HumanFilter.Fonts` - Středníkem oddělený seznam názvů písem, které se mají použít při vytváření obrázku. V příkladu výše uvedený seznam obsahuje fonty standardně distribuované s Windows 2003. Rozhodl jsem se výběr fontů nechat na uživateli, místo abych náhodně vybíral ze všech instalovaných fontů, protože některé obskurnější fonty nemusejí být pro tento účel vhodné.

### Web user control - HumanFilter.ascx, HumanFilter.ascx.vb

Zdrojový kód HTML části je jednoduchý:

    <table>
      <tr>
        <td><asp:image id="ImageCode" runat="server"></asp:image></td>
        <td><asp:textbox id="TextBoxCode" runat="server"></asp:textbox></td>
        <td>
          <asp:regularexpressionvalidator id="RegularExpressionValidator1" runat="server" errormessage="Ověřovací kód obsahuje jiné než povolené znaky (pouze 0-9, A-F)" display="Dynamic" controltovalidate="TextBoxCode" validationexpression="[0-9A-Fa-f]{1,}">*</asp:regularexpressionvalidator>
          <asp:requiredfieldvalidator id="RequiredFieldValidator1" runat="server" errormessage="Není zadán ověřovací kód" display="Dynamic" controltovalidate="TextBoxCode">*</asp:requiredfieldvalidator>
          <asp:customvalidator id="CustomValidator1" runat="server" errormessage="Ověřovací kód je zadán chybně" display="Dynamic" controltovalidate="TextBoxCode">*</asp:customvalidator>
        </td>
      </tr>
    </table>

Control obsahuje tabulku, ve které se nachází v řadě obrázek, textové pole a trojice validátorů. První dva jsou tam spíše pro komfort uživatele, kontrolují zda je pole vyplněno a zda obsahuje jenom povolené znaky (0-9 a A-F). Veškerou "špinavou práci" odvádí třetí, CustomValidator, který na straně serveru porovnává zadaný kód s tím správným. Také v případě chybně zadaného kódu generuje nový. Obslužný programový kód vypadá takto:

    Private Rnd As New System.Random

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        If Page.IsPostBack Then Return

        ' Generate base for random code and save it to viewstate
        Dim Code As Int32 = Me.Rnd.Next()
        Me.ViewState.Add("Code", Code)

        ' Setup image display
        Me.ImageCode.Width = New System.Web.UI.WebControls.Unit(Int32.Parse(System.Configuration.ConfigurationSettings.AppSettings("HumanFilter.CodeLength")) * 20)
        Me.ImageCode.Height = New System.Web.UI.WebControls.Unit(30)
        Me.ImageCode.ImageUrl = System.Configuration.ConfigurationSettings.AppSettings("HumanFilter.ImageGenerator") & "?Code=" & Code
    End Sub

    Friend Shared Function GetVerificationString(ByVal Code As Int32) As String
        ' Compute hash with salt
        Dim R As String = System.Configuration.ConfigurationSettings.AppSettings("HumanFilter.Salt") & Code.ToString()
        R = System.Web.Security.FormsAuthentication.HashPasswordForStoringInConfigFile(R, "MD5").ToUpper()
        R = R.Substring(0, Int32.Parse(System.Configuration.ConfigurationSettings.AppSettings("HumanFilter.CodeLength")))
        Return R
    End Function

    Private Sub CustomValidator1_ServerValidate(ByVal source As System.Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles CustomValidator1.ServerValidate
        args.IsValid = args.Value.ToUpper() = GetVerificationString(CType(Me.ViewState("Code"), Int32))
        If Not args.IsValid Then
            ' If code is not correct, generate new
            Dim Code As Int32 = Me.Rnd.Next()
            Me.ViewState("Code") = Code
            Me.ImageCode.ImageUrl = System.Configuration.ConfigurationSettings.AppSettings("HumanFilter.ImageGenerator") & "?Code=" & Code
            Me.TextBoxCode.Text = ""
        End If
    End Sub

Za zmínku stojí funkce `GetVerificationString()` která na základě předaného čísla spočítá ověřovací řetězec. Ta je pak volána ze stránky generující obrázek.

### Generátor obrázku - HumanFilterImageGenerator.aspx, HumanFilterImageGenerator.aspx.vb

Tato stránka zcela samostatně zajišťuje generování obrázku. Metodou GET je jí předán parametr `Code`, což je numerický kód použitý pro tvorbu ověřovacího řetězce. Veškerou práci odvádí backend, protože stránka negeneruje HTML kód, ale jenom obrázek ve formátu PNG:

    Private Rnd As New Random

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        ' Get verification string
        Dim Code As String = HumanFilter.GetVerificationString(Int32.Parse(Request.QueryString("Code")))

        ' Create bitmap
        Dim BMP As New System.Drawing.Bitmap(Code.Length * 20, 30)
        Dim GPH As System.Drawing.Graphics = System.Drawing.Graphics.FromImage(BMP)
        GPH.FillRectangle(New System.Drawing.SolidBrush(System.Drawing.Color.White), 0, 0, BMP.Width, BMP.Height)

        ' Draw noise
        For I As Int32 = 1 To BMP.Width * BMP.Height \ 15
            BMP.SetPixel(Me.Rnd.Next(0, BMP.Width), Me.Rnd.Next(0, BMP.Height), Me.GenerateRandomColor)
        Next

        ' Draw letters
        For I As Int32 = 0 To Code.Length - 1
            ' Random font 
            Dim F As System.Drawing.Font = Me.GenerateRandomFont()
            Dim S As System.Drawing.Size = GPH.MeasureString(Code.Chars(I), F).ToSize()
            Dim P As New System.Drawing.PointF(20 * I + 10 - S.Width \ 2, 15 - S.Height \ 2)

            ' Random color
            Dim B As New System.Drawing.SolidBrush(Me.GenerateRandomColor())

            ' Write to image
            GPH.DrawString(Code.Chars(I), F, B, P)
        Next

        ' Generate PNG from image
        Dim MS As New System.IO.MemoryStream
        BMP.Save(MS, System.Drawing.Imaging.ImageFormat.Png)
        BMP.Dispose()
        GPH.Dispose()

        ' Disable all caching
        Response.Cache.SetCacheability(Web.HttpCacheability.NoCache)
        Response.ExpiresAbsolute = DateTime.MinValue

        ' Flush image to client
        Response.Clear()
        Response.ContentType = "image/png"
        MS.WriteTo(Response.OutputStream)
        MS.Close()
        Response.End()
    End Sub

    Private Function GenerateRandomColor() As System.Drawing.Color
        Return System.Drawing.Color.FromArgb(Me.Rnd.Next(200), Me.Rnd.Next(200), Me.Rnd.Next(200))
    End Function

    Private Function GenerateRandomFont() As System.Drawing.Font
        Dim Fonts() As String = System.Configuration.ConfigurationSettings.AppSettings("HumanFilter.Fonts").Split(Char.Parse(";"))
        Return New System.Drawing.Font(Fonts(Me.Rnd.Next(Fonts.Length)), Me.Rnd.Next(16, 36), Drawing.FontStyle.Regular, Drawing.GraphicsUnit.Pixel)
    End Function

Princip generování obrázku je předpokládám zřejmý z předchozího textu a komentářů v kódu. Kód obsahuje dvě obslužné funkce, které vygenerují náhodný font a náhodnou barvu. Funkce pro generování barvy je sestavena tak, že žádná z RGB barevných složek nemůže mít hodnotu vyšší než 200, čímž je zajištěno, že barvy budou čitelné na bílém pozadí (nebudou příliš světlé).

Teoreticky korektnější postup by byl použít místo RGB barevného modelu HSL (dá se v něm přímo regulovat sytost barvy), ale na to jsem příliš líný. Odhadologicky stanovená hodnota 200 se v praxi osvědčila, stejně jako patnáctiprocentní zastoupení šumu o pár řádek výše.

## Ukázka použití

V případě použití se nevyžaduje nižádná větší aktivia, než umístění prvku do kontrolovaného formuláře a použití standardní validace, vše funguje zcela samostatně. Ukázkový kód (`Default.aspx`) je níže.

ASPX - frontend:

    <%@ Register TagPrefix="uc1" TagName="HumanFilter" Src="HumanFilter.ascx" %>
    <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
    <html>
      <head>
        <title>Default</title>
        <meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
        <meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
        <meta name="vs_defaultClientScript" content="JavaScript">
        <meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
      </head>
      <body>
        <form id="Form1" method="post" runat="server">
          <asp:label id="LabelPrompt" runat="server">Opište ověřovací kód do textového pole. Pokud kód nedokážete přečíst, zkuste ho odhadnout - bude-li chybný, zobrazí se po odeslání jiný obrázek.</asp:label>
          <asp:panel id="PanelForm" runat="server">
            <p>
              <uc1:humanfilter id="HumanFilter1" runat="server"></uc1:humanfilter></p>
            <p>
              <asp:validationsummary id="ValidationSummary1" runat="server"></asp:validationsummary></p>
            <p>
              <asp:button id="ButtonSubmit" runat="server" text="Odeslat"></asp:button></p>
          </asp:panel>
        </form>
      </body>
    </html>

VB.NET - backend:

    Private Sub ButtonSubmit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ButtonSubmit.Click
        If Not Page.IsValid Then Return

        Me.PanelForm.Visible = False
        Me.LabelPrompt.Text = "Formulář byl úspěšně odeslán"
    End Sub

## Upozornění na závěr

Technologii máte k dispozici, odkaz na kompletní zdrojový kód ke stažení jest níže. Než se ji ale rozhodnete na některém svém webu nasadit, mějte na paměti dvě věci.

**Dobrého pomálu.** Kontrolu používejte jenom v případech, kdy je to opravdu nutné. Pokud se stanete cílem spamu nebo ve výjimečných případech (registrace apod.). Pokud z opisování kódu učiníte atrakci každého formuláře, uživatele to bude silně otravovat. To je důvod, proč až na další nenajdete tuto formu ověřování na tomto weblogu.

**Pozor na přístupnost.** Splnění tohoto testu je jednoduché pro zdravého člověka. Nevidomý s hlasovou čtečkou je v koncích úplně, špatně vidící uživatelé s ním mohou mít problémy. Pokud je váš web důležitý a takto chráněná funkce pro jeho užití nezbytná, měli byste poskytnout alternativní formu ověření - třeba telefonickou.

## Odkazy

*   [Zdrojové kódy ke stažení](https://www.cdn.altairis.cz/Blog/2005/20050104-HumanFilter.zip) (9 kB) 
[Inaccessibility of Visually-Oriented Anti-Robot Tests](http://www.w3.org/TR/turingtest/) - obsáhlejší teoretické pojednání o tomto typu testů na webu W3C se zřetelem na přístupnost