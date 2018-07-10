<!-- dcterms:identifier = aspnetcz#36 -->
<!-- dcterms:title = Nové server controls: MultiView, Wizard a Substitution -->
<!-- dcterms:abstract = Naši prohlídku světa Whidbey započneme třemi jednoduchými ovládacími prvky -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Programování -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2005-04-30T16:50:03.817+02:00 -->
<!-- dcterms:dateAccepted = 2005-04-30T16:50:03.817+02:00 -->

<p __designer:dtid="1688849860263940">Na&#353;i prohl&#237;dku světa Whidbey započneme třemi jednoduch&#253;mi ovl&#225;dac&#237;mi prvky.</p>
<h2 __designer:dtid="1688849860263941">MultiView</h2>
<p __designer:dtid="1688849860263942">Pro zač&#225;tek něco lehč&#237;ho. Řada aplikac&#237; - alespoň m&#253;ch určitě - obsahuje str&#225;nky, kter&#233; sest&#225;vaj&#237; z několika č&#225;st&#237;, u kter&#253;ch je viditeln&#225; vždy pr&#225;vě jenom jedna. Ať už se jedn&#225; o obdobu "z&#225;ložek", nebo nějak&#233;ho průvodce... Ve verzi 1.x se tato situace ře&#353;&#237; tak, že se pod sebe naskl&#225;d&#225; vět&#353;&#237; množstv&#237; prvků <code __designer:dtid="1688849860263943">asp:Panel</code>, v&#353;em se nastav&#237; <code __designer:dtid="1688849860263944">visible="False"</code> a na straně serveru se programově zajist&#237;, že se zviditeln&#237; pr&#225;vě jeden.</p>
<p __designer:dtid="1688849860263945">V př&#237;padě verze 2.0 jest v obdobn&#233; situaci použ&#237;ti <code __designer:dtid="1688849860263946">asp:MultiView</code>. Ten obsahuje něco prvků <code __designer:dtid="1688849860263947">asp:View</code>, z nichž pr&#225;vě jeden je aktivn&#237; (viditeln&#253;). Kter&#233;mu z prvků bude svěřena tato v&#253;sada jest specifikovati vlastnost&#237; <code __designer:dtid="1688849860263948">ActiveViewIndex</code>.</p>
<p __designer:dtid="1688849860263949">Jednoduch&#253; př&#237;klad použit&#237; jest zde:</p><pre class="sh-code-xml" __designer:dtid="1688849860263950">&lt;%@ Page Language="VB" %&gt;

&lt;script runat="server"&gt;
    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Me.MultiView1.ActiveViewIndex = Int32.Parse(Me.DropDownList1.SelectedValue)
    End Sub
&lt;/script&gt;

&lt;html xmlns="http://www.w3.org/1999/xhtml"&gt;
    &lt;head id="Head1" runat="server"&gt;
        &lt;title&gt;MultiView example&lt;/title&gt;
    &lt;/head&gt;
    &lt;body&gt;
        &lt;form id="form1" runat="server"&gt;
            &lt;p&gt;
                &lt;asp:DropDownList ID="DropDownList1" runat="server"&gt;
                    &lt;asp:ListItem Value="0" Selected="true"&gt;Tab #1&lt;/asp:ListItem&gt;
                    &lt;asp:ListItem Value="1"&gt;Tab #2&lt;/asp:ListItem&gt;
                    &lt;asp:ListItem Value="2"&gt;Tab #3&lt;/asp:ListItem&gt;
                &lt;/asp:DropDownList&gt;
                &lt;asp:Button ID="Button1" runat="server" Text="Button" OnClick="Button1_Click" /&gt;
            &lt;/p&gt;
            &lt;asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0"&gt;
                &lt;asp:View ID="ViewTab1" runat="server"&gt;
                    Tab 1
                &lt;/asp:View&gt;
                &lt;asp:View ID="ViewTab2" runat="server"&gt;
                    Tab 2
                &lt;/asp:View&gt;
                &lt;asp:View ID="ViewTab3" runat="server"&gt;
                    Tab 3
                &lt;/asp:View&gt;
            &lt;/asp:MultiView&gt;
        &lt;/form&gt;
    &lt;/body&gt;
&lt;/html&gt;</pre>
<h2 __designer:dtid="1688849860263951">Wizard</h2>
<p __designer:dtid="1688849860263952">Takov&#253; prvek <code __designer:dtid="1688849860263953">MultiView</code> představuje mal&#253; krůček pro člověka, ale velk&#253; krok pro cel&#253; program&#225;torsk&#253; n&#225;rod. Ne př&#237;mou svou samostatnou existenc&#237;, leč skutečnost&#237;, že dal vzniknouti mnohem schopněj&#353;&#237;mu prvku jm&#233;nem <code __designer:dtid="1688849860263954">asp:Wizard</code>.</p>
<p __designer:dtid="1688849860263955">Je doporučeno, aby složitěj&#353;&#237; formul&#225;ře byly realizov&#225;ny formou průvodce, tedy několika na sebe navazuj&#237;c&#237;ch kroků. C&#237;lem je, aby uživatel nebyl hned na prvn&#237; pohled zmaten des&#237;tkami složit&#253;ch formul&#225;řov&#253;ch prvků, ale aby se předmětn&#233; zmaten&#237; dostavovalo postupně, v mal&#253;ch d&#225;vk&#225;ch. Zn&#225;te to: pokud ž&#225;bu hod&#237;te do vař&#237;c&#237; vody, vyskoč&#237; z hrnce. Pokud ji vlož&#237;te do studen&#233; vody a tu budete pomalu zahř&#237;vat, nech&#225; se klidně uvařit. Se ž&#225;bami jsem to nezkou&#353;el, s uživateli ano (želbohu toliko metaforicky): Pokud už se proklikaj&#237; do &#353;est&#233;ho kroku průvodce, je jim zatěžko to vzd&#225;t - zvl&#225;&#353;tě když se jim proz&#237;ravě zataj&#237; že před nimi je dal&#353;&#237;ch pět :-)</p>
<p __designer:dtid="1688849860263956">Napsat dostatečně komfortn&#237;ho průvodce, kter&#253; dovol&#237; přep&#237;nat se korektně pomoc&#237; tlač&#237;tek "<em __designer:dtid="1688849860263957">Předchoz&#237;</em>" a "<em __designer:dtid="1688849860263958">Dal&#353;&#237;</em>", neřku-li jednotliv&#233; kroky vyplňovat na přesk&#225;čku (je-li to ž&#225;douc&#237;) nen&#237; prostředky ASP.NET 1.x rozhodně trivi&#225;ln&#237;. Prostředky 2.0 ano. Použijete prvek <code __designer:dtid="1688849860263959">asp:Wizard</code> a podobn&#253;m způsobem jako u <code __designer:dtid="1688849860263960">MultiView</code> nadefinujete jednotliv&#233; kroky průvodce (VS.NET 2005 v&#225;m dokonce přičinlivě nab&#237;dne vhodn&#233; GUI pro tuto činnost).</p>
<p __designer:dtid="1688849860263961">Pak už zb&#253;v&#225; toliko o&#353;etřit ud&#225;lost <code __designer:dtid="1688849860263962">FinishButtonClick</code>, tedy dokončen&#237; průvodce. Dal&#353;&#237;mi prob&#237;haj&#237;c&#237;mi kroky netřeba se zaob&#237;rati.</p>
<p __designer:dtid="1688849860263963">Z důvodu jeho rozs&#225;hlosti uk&#225;zkov&#253; k&#243;d nen&#237; souč&#225;st&#237; čl&#225;nku, najdete ho v <a href="https://www.cdn.altairis.cz/Blog/2005/20050430-newwebcontrols.zip">přiložen&#233;m souboru př&#237;kladů</a>.</p>
<h2 __designer:dtid="1688849860263964">Substitution</h2>
<p __designer:dtid="1688849860263965">Předpokl&#225;d&#225;m, že vět&#353;ina program&#225;torů jest obezn&#225;mena s mechanismem cacheov&#225;n&#237; v ASP.NET 1.x (patř&#237;te-li mezi onu men&#353;inu, stručn&#233; pojedn&#225;n&#237; na toto t&#233;ma jest nal&#233;zti př&#237;kladně mezi <a href="/Fulltext.aspx?text=cacheov%C3%A1n%C3%AD&idx=a" __designer:dtid="1688849860263966">star&#353;&#237;mi čl&#225;nky na tomto serveru</a>).</p>
<p __designer:dtid="1688849860263967">Mnohdy vyhov&#237; prost&#253; z&#225;pis direktivy <code __designer:dtid="1688849860263968">@OutputCache</code> a cacheov&#225;n&#237; cel&#233; str&#225;nky. Často je ale třeba cache engine poněkud omezit v rozletu a ukl&#225;dat jenom <em __designer:dtid="1688849860263969">něco</em>. Toho jest dos&#225;hnouti ve verzi 1.x t&#237;m, že se č&#225;st str&#225;nky maj&#237;c&#237; podl&#233;hat uložen&#237; do cache realizuje co web user control a cacheuje se ten, zat&#237;mco str&#225;nka jako takov&#225; se vykon&#225; vždy znovu.</p>
<p __designer:dtid="1688849860263970">To je ře&#353;en&#237; elegantn&#237;, leč poněkud nepraktick&#233; v př&#237;padě, že ono shora zm&#237;něn&#233; <em __designer:dtid="1688849860263971">něco</em> je prakticky cel&#225; str&#225;nka, s v&#253;jimkou jedn&#233; či několika mal&#253;ch č&#225;st&#237;. Např&#237;klad z důvodu požadavku marketingov&#233;ho oddělen&#237;, že na webov&#253;ch str&#225;nk&#225;ch prostě <em __designer:dtid="1688849860263972">mus&#237;</em> b&#253;t aktu&#225;ln&#237; čas ;-)</p>
<p __designer:dtid="1688849860263973">V takov&#253;ch př&#237;padech je v nov&#233; verzi k dispozici ovl&#225;dac&#237; prvek <code __designer:dtid="1688849860263974">asp:Substitition</code>. M&#225; jedin&#253; smyslupln&#253; parametr, kter&#253;m je <code __designer:dtid="1688849860263975">MethodName</code>: n&#225;zev metody, kter&#225; se vykon&#225; při každ&#233;m požadavku, a jej&#237;ž v&#253;sledek bude vložen do jinak cacheovan&#233; str&#225;nky na m&#237;sto patřičn&#233;ho prvku <code __designer:dtid="1688849860263976">Substitution</code>.</p>
<p __designer:dtid="1688849860263977">Vizte n&#225;sleduj&#237;c&#237; př&#237;klad:</p><pre class="sh-code-xml" __designer:dtid="1688849860263978">&lt;%@ Page Language="VB" %&gt;

&lt;%@ OutputCache Duration="60" VaryByParam="none" %&gt;

&lt;script runat="server"&gt;
    
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        Me.Label1.Text = System.DateTime.Now.ToString()
    End Sub
    
    Shared Function RefreshSubstitution(ByVal Context As System.Web.HttpContext) As String
        Return System.DateTime.Now.ToString()
    End Function
    
&lt;/script&gt;

&lt;html xmlns="http://www.w3.org/1999/xhtml"&gt;
    &lt;head runat="server"&gt;
        &lt;title&gt;Substitution&lt;/title&gt;
    &lt;/head&gt;
    &lt;body&gt;
        &lt;form id="form1" runat="server"&gt;
            &lt;div&gt;
                &lt;asp:Substitution ID="Substitution1" runat="server" MethodName="RefreshSubstitution" /&gt;
                &lt;br /&gt;
                &lt;asp:Label ID="Label1" runat="server" Text="Label"&gt;&lt;/asp:Label&gt;
            &lt;/div&gt;
        &lt;/form&gt;
    &lt;/body&gt;
&lt;/html&gt;</pre>
<p __designer:dtid="1688849860263979">Cel&#225; str&#225;nka m&#225; povoleno cacheov&#225;n&#237; v&#253;stupu na dobu jedn&#233; minuty, jak jest vyzkou&#353;eti na obsahu prvku <code __designer:dtid="1688849860263980">Label1</code>, kter&#253; jest v <code __designer:dtid="1688849860263981">Page_Load</code> naplněn aktu&#225;ln&#237;m časem, ale nejčastěji jednou za minutu. Oproti tomu prvek <code __designer:dtid="1688849860263982">Substitution1</code> je vol&#225;n&#237;m metody <code __designer:dtid="1688849860263983">RefreshSubstitution</code> aktualizov&#225;n při každ&#233;m požadavku, cache necache.</p>
<blockquote __designer:dtid="1688849860263984">Můžete si st&#225;hnout <a href="https://www.cdn.altairis.cz/Blog/2005/20050430-newwebcontrols.zip">zdrojov&#233; k&#243;dy</a> k tomuto čl&#225;nku. K jejich rozběhnut&#237; budete potřebovat webov&#253; server podporuj&#237;c&#237; Microsoft .NET Framework 2.0 Beta 2.</blockquote>