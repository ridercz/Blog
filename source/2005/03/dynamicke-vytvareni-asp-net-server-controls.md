<!-- dcterms:identifier = aspnetcz#27 -->
<!-- dcterms:title = Dynamické vytváření ASP.NET server controls -->
<!-- dcterms:abstract = ASP.NET umožňují programové vytváření serverových ovládacích prvků. U formulářových prvků ovšem může být problém s postbackem. Jednoduchý leč výživný příkládek -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Programování -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2005-03-29T04:51:42.85+02:00 -->
<!-- dcterms:dateAccepted = 2005-03-29T04:51:42.85+02:00 -->

V životě programujícího koně (a předpokládám, že i v životě lidském) se najde řada příležitostí, které vyžadují dynamické vytváření uživatelského rozhraní. V klasických ASP 3.0 bylo v tomto ohledu řešení snadné: prostě se do výsledného kódu vygenerovalo nějaké HTML. 

To výtečně funguje i v případě ASP.NET (nic vám nebrání dát si na stránku `asp:literal` a načítat hodnoty přes `Request.Form` či tak něco). Pro mnohé situace to může být dokonce nejlepší možné řešení. Jindy ale prahnete po využití inteligence ASP.NET server controls. Po možnosti užívat dobrodiní validace, postbacku a jiných radostí, které vám nabízí svět .NET.

## Vytváření

Serverový ovládací prvek je objekt jako kterýkoliv jiný: vznikne vytvořením instance třídy, zpravidla nacházející se v namespace `System.Web.UI.WebControls` nebo `System.Web.UI.HtmlControls`. Programově pak nastavíte všechny potřebné vlastnosti. Takto vytvořený prvek jest ovšem nutno umístit na vhodné místo stránky.

Všechny prvky odvozené od třídy `System.Web.UI.Control` (což se týká všech serverových ovládacích prvků) mají vlastnost `Controls`. Ta obsahuje kolekci podřízených ovládacích prvků. Obvykle najde využití v případě "kontajnerů", jako je třeba `asp:panel` nebo ještě lépe `asp:placeholder`. Posledně jmenovaný je přímo určený k hrátkám s dynamickými prvky - nic jiného v podstatě neumí. Do kolekce můžete nově vygenerovaný prvek přidat pomocí metod `Add` (na konec) nebo `AddAt` (na určenou pozici).

Pokud chcete mezi vygenerované prvky vložit něco statického HTML (což zpravidla chcete, byť by to mělo být prosté odřádkování), použijte k tomuto účelu vložení `System.Web.UI.LiteralControl`.

Následující kód vygeneruje deset textových polí oddělených odřádkováním a nastaví jim různé užitečné vlastnosti, příkladně `ID` (budeme ho potřebovat později) a obsah (`Text`).

    For I As Int32 = 1 To 10
        ' Vytvoř nový textbox
        Dim T As New System.Web.UI.WebControls.TextBox

        ' Nastav jeho vlastnosti
        T.ID = "DynamicTextBox" & I
        T.Text = "Dynamicky generovaný TextBox č. " & I
        T.Width = New System.Web.UI.WebControls.Unit(400, System.Web.UI.WebControls.UnitType.Pixel)

        ' Přidej ho na placeholder a odřádkuj
        Me.PlaceHolder1.Controls.Add(T)
        Me.PlaceHolder1.Controls.Add(New System.Web.UI.LiteralControl("<br>"))
    Next

## Přežití Postbacku

Obvyklým postupem (a začátečnickou chybou) je umístit shora uvedený kód do obsluhy události `Page.Load`. Funguje to skvěle, želbohu jenom do prvního Postbacku. Při něm se všechny pracně vytvořené prvky ztratí.

Pro vysvětlení tohoto jevu jest třeba nahlédnout podrobněji na způsob, jakým se při zpracování ASPX stránky volají jednotlivé události. V [článku o psaní HTTP modulů](/entry/article-20050116.aspx) jsem popisoval události, které nastanou při zpracování HTTP požadavku. Poměrně složitý proces volání ASPX stránky (Web Formu) jsem v něm shrnul do stručné věty "*V tomto okamžiku se zavolá příslušný HTTP handler a vykoná se vlastní kód stránky.*" Nyní nastal čas povědět si, co vlastně provádí HTTP handler při volání web formu.

Podrobný popis najdete v [MSDN](http://msdn.microsoft.com/library/default.asp?url=/library/en-us/cpguide/html/cpconcontrolexecutionlifecycle.asp), názorný obrázek na weblogu [Raymonda Lewallena](http://codebetter.com/blogs/raymond.lewallen/archive/2005/03/10/59583.aspx). Pro nás jsou v tomto okamžiku důležité první čtyři události:

*   `Init` - vůbec první událost volaná po vytvoření instance stránky. 
`LoadViewState` - načtení hodnot z ViewState. 
`LoadPostData` - zpracování dat z postbacku. 
`Load` - provedení vlastních operací společných pro všechny požadavky na stránku.

Ve většině případů ASP.NET programátor obslouží jako první událost `Load`. Ta ovšem v našem případě přichází příliš pozdě, až po zpracování ViewState a Postbacku. Dynamické vytváření prvků jest tedy třeba si odbýt už mnohem dříve, v handleru události `Init`.

Pokud stránky píšete ve VS.NET, je příslušná metoda již přítomna, leč skrytá v regionu *Web Form Designer Generated Code*. Standardně tento handler obsahuje pouze volání metody `InitializeComponent` a důtklivé doporučení, abyste ho neodstraňovali, neb ho k životu potřebuje designer VS.NET.

Přesuňte si metodu `Page_Init` kam je libo a zapište kód do ní (nezapomeňte tam ale nechat ono vyžadované volání `InitializeComponent`). Výsledek bude vypadat nějak takto:

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()

        ' Vygeneruj 10 textboxů a umísti je na stránku
        For I As Int32 = 1 To 10
            ' Vytvoř nový textbox
            Dim T As New System.Web.UI.WebControls.TextBox

            ' Nastav jeho vlastnosti
            T.ID = "DynamicTextBox" & I
            T.Text = "Dynamicky generovaný TextBox č. " & I
            T.Width = New System.Web.UI.WebControls.Unit(400, System.Web.UI.WebControls.UnitType.Pixel)

            ' Přidej ho na placeholder a odřádkuj
            Me.PlaceHolder1.Controls.Add(T)
            Me.PlaceHolder1.Controls.Add(New System.Web.UI.LiteralControl("<br>"))
        Next
    End Sub

Tímto postupem se controly vytvoří včas a úspěšně se na ně aplikují změny z ViewState a Postbacku.

## Načtení hodnot

V porovnání s předchozím kódem je poslední fáze, tedy načtení hodnot z controlu po Postbacku, procházkou růžovou zahradou. Není ovšem možné se na dynamicky vytvořený prvek odkazovat obvyklým voláním `Me.názevprvku`, ale je nutno použít elaborovanější postup.

V zásadě můžete využít již dříve popisovanou kolekci Controls a postupně procházet jednotlivé ovládací prvky a na základě definovaných charakteristik (příkladně typu) je rozpoznat a vhodně s nimi naložiti.

Druhou možností je použít u nadřazeného prvku (v našem případě je to `asp:placeholder`) metodu `FindControl`, která najde ovládací prvek s definovaným jménem (ID). My víme, jak se naše textboxy jmenují (`DynamicTextBox1` až `DynamicTextBox10`) a můžeme tuto metodu s výhodou použít, například k vypsání všech zadaných hodnot:

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        Dim SB As New System.Text.StringBuilder

        For I As Int32 = 1 To 10
            ' Najít TextBox podle jména
            Dim T As System.Web.UI.WebControls.TextBox
            T = DirectCast(Me.PlaceHolder1.FindControl("DynamicTextBox" & I), System.Web.UI.WebControls.TextBox)

            SB.Append(T.ID & ".Text = " & T.Text & "<br>")
        Next

        Me.Label1.Text = SB.ToString()
    End Sub