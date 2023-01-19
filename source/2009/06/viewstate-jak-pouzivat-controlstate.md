<!-- dcterms:identifier = aspnetcz#236 -->
<!-- dcterms:title = ViewState: Jak používat ControlState -->
<!-- dcterms:abstract = V předchozím článku jsme se podívali na technologii ViewState a na to, jak se dá využívat ve vlastních ovládacích prvcích. A také jsem psal, že se na ni nemůžeme spolehnout, protože ji programátor může vypnout, na úrovni aplikace, stránky nebo konkrétního prvku. Pokud přesto chceme uchovávat nějaké údaje napříč postbacky, musíme použít technologii ControlState. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = IT -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- np9:serialId = 5 -->
<!-- x4w:serial = ViewState -->
<!-- dcterms:created = 2009-06-29T09:00:00+02:00 -->
<!-- dcterms:date = 2009-06-29T09:00:00+02:00 -->

<p>V předchozím článku jsme se podívali na technologii ViewState a na to, jak se dá využívat ve vlastních ovládacích prvcích. A také jsem psal, že se na ni nemůžeme spolehnout, protože ji programátor může vypnout, na úrovni aplikace, stránky nebo konkrétního prvku. Pokud přesto chceme uchovávat nějaké údaje napříč postbacky, musíme použít technologii ControlState.</p>
<p>V první generaci ASP.NET (1.0, 1.1) jste měli na výběr: ViewState zapnout a užívat si funkčnosti všech prvků a platit za to obrovským objemem dat a nebo ho vypnout a rozloučit se s mnohou pokročilou funkčností. Proto v ASP.NET 2.0 Microsoft ViewState rozdělil na dvě velmi podobné technologie. Tou druhou je tzv. ControlState. Technicky je to v zásadě totéž, co ViewState: data se serializují a uchovají ve skrytém poli formuláře. Význam ControlState spočívá v tom, že nejde vypnout.</p>
<p>Předpokládá se tedy, že do ViewState si uložíte hodnoty, které byste sice rádi měli, ale obejdete se bez nich. A může jich být v zásadě docela dost. Do ControlState byste měli ukládat jenom ty hodnoty, bez kterých se v žádném případě neobejdete – a mělo by jich být co možná nejméně.</p>
<h2>Jak ve svém prvku používat ControlState</h2>
<p>V případě ViewState je použití snadné – máme k dispozici kolekci ViewState a do ní ukládáme co se nám zlíbí. Control state je na použití poněkud komplikovanější. Umí uložit jenom jednu serializovatelnou hodnotu. Pokud chceme uložit hodnot více, musíme si vytvořit serializovatelnou třídu, která bude sloužit jako kontajner. Budu pokračovat v příkladu <code>SampleStateControl</code> z předchozího článku a budu tedy ukládat jenom jednu hodnotu – čas prvního načtení stránky – a bez kontajneru bych se v zásadě obešel, ale z výukových důvodů jej přesto vytvořím a použiji. Bude jím třída jménem <code>StateContainer</code>, s jedinou vlastností <code>FirstLoadTimeCS.</code></p>
<p>Pokud chce prvek využívat ControlState, musí o tom včas spravit svou hostitelskou stránku – a to tak, že ve fázi <code>Init</code> zavolá její metodu <code>RegisterRequiredControlState</code>. Potom můžete přepsat metody <code>SaveControlState</code> a <code>LoadControlState</code>, které jednoduše předají ke zpracování hodnotu vaší kontajnerové třídy.</p>
<p>Zde je rozšířený zdrojový kód třídy <code>SampleStateControl</code> z předchozího článku:</p>
<div style="font-family: consolas, 'courier new', monospace; background: white; color: black; font-size: 10pt;">
<p style="margin: 0px;"><span style="color: #0000ff;">using</span> System;</p>
<p style="margin: 0px;"><span style="color: #0000ff;">using</span> System.Web;</p>
<p style="margin: 0px;"> </p>
<p style="margin: 0px;"><span style="color: #0000ff;">namespace</span> MyControls {</p>
<p style="margin: 0px;"> </p>
<p style="margin: 0px;">    <span style="color: #0000ff;">public</span> <span style="color: #0000ff;">class</span> <span style="color: #2b91af;">SampleStateControl</span> : System.Web.UI.<span style="color: #2b91af;">Control</span> {</p>
<p style="margin: 0px;"> </p>
<p style="margin: 0px;"><span style="color: #0000ff;">        #region</span> ViewState implementation</p>
<p style="margin: 0px;"> </p>
<p style="margin: 0px;">        <span style="color: #0000ff;">public</span> SampleStateControl() {</p>
<p style="margin: 0px;">            <span style="color: #008000;">// Nastavení výchozí hodnoty</span></p>
<p style="margin: 0px;">            <span style="color: #0000ff;">this</span>.FirstLoadTimeVS = <span style="color: #2b91af;">DateTime</span>.MinValue;</p>
<p style="margin: 0px;">        }</p>
<p style="margin: 0px;"> </p>
<p style="margin: 0px;">        <span style="color: #0000ff;">public</span> <span style="color: #2b91af;">DateTime</span> FirstLoadTimeVS {</p>
<p style="margin: 0px;">            <span style="color: #0000ff;">get</span> { <span style="color: #0000ff;">return</span> (<span style="color: #2b91af;">DateTime</span>)<span style="color: #0000ff;">this</span>.ViewState[<span style="color: #a31515;">"FirstLoadTimeVS"</span>]; }</p>
<p style="margin: 0px;">            <span style="color: #0000ff;">set</span> { <span style="color: #0000ff;">this</span>.ViewState[<span style="color: #a31515;">"FirstLoadTimeVS"</span>] = <span style="color: #0000ff;">value</span>; }</p>
<p style="margin: 0px;">        }</p>
<p style="margin: 0px;"> </p>
<p style="margin: 0px;"><span style="color: #0000ff;">        #endregion</span></p>
<p style="margin: 0px;"> </p>
<p style="margin: 0px;"><span style="color: #0000ff;">        #region</span> ControlState implementation</p>
<p style="margin: 0px;"> </p>
<p style="margin: 0px;">        [<span style="color: #2b91af;">Serializable</span>]</p>
<p style="margin: 0px;">        <span style="color: #0000ff;">private</span> <span style="color: #0000ff;">class</span> <span style="color: #2b91af;">StateContainer</span> {</p>
<p style="margin: 0px;">            <span style="color: #0000ff;">public</span> <span style="color: #2b91af;">DateTime</span> FirstLoadTimeCS { <span style="color: #0000ff;">get</span>; <span style="color: #0000ff;">set</span>; }</p>
<p style="margin: 0px;">        }</p>
<p style="margin: 0px;"> </p>
<p style="margin: 0px;">        <span style="color: #0000ff;">private</span> <span style="color: #2b91af;">StateContainer</span> stateContainer = <span style="color: #0000ff;">new</span> <span style="color: #2b91af;">StateContainer</span>();</p>
<p style="margin: 0px;"> </p>
<p style="margin: 0px;">        <span style="color: #0000ff;">public</span> <span style="color: #2b91af;">DateTime</span> FirstLoadTimeCS {</p>
<p style="margin: 0px;">            <span style="color: #0000ff;">get</span> { <span style="color: #0000ff;">return</span> <span style="color: #0000ff;">this</span>.stateContainer.FirstLoadTimeCS; }</p>
<p style="margin: 0px;">            <span style="color: #0000ff;">set</span> { <span style="color: #0000ff;">this</span>.stateContainer.FirstLoadTimeCS = <span style="color: #0000ff;">value</span>; }</p>
<p style="margin: 0px;">        }</p>
<p style="margin: 0px;"> </p>
<p style="margin: 0px;">        <span style="color: #0000ff;">protected</span> <span style="color: #0000ff;">override</span> <span style="color: #0000ff;">void</span> OnInit(<span style="color: #2b91af;">EventArgs</span> e) {</p>
<p style="margin: 0px;">            <span style="color: #0000ff;">base</span>.OnInit(e);</p>
<p style="margin: 0px;"> </p>
<p style="margin: 0px;">            <span style="color: #008000;">// Zaregistrovat se k použtí control state</span></p>
<p style="margin: 0px;">            <span style="color: #0000ff;">this</span>.Page.RegisterRequiresControlState(<span style="color: #0000ff;">this</span>);</p>
<p style="margin: 0px;">        }</p>
<p style="margin: 0px;"> </p>
<p style="margin: 0px;">        <span style="color: #0000ff;">protected</span> <span style="color: #0000ff;">override</span> <span style="color: #0000ff;">object</span> SaveControlState() {</p>
<p style="margin: 0px;">            <span style="color: #0000ff;">return</span> <span style="color: #0000ff;">this</span>.stateContainer;</p>
<p style="margin: 0px;">        }</p>
<p style="margin: 0px;"> </p>
<p style="margin: 0px;">        <span style="color: #0000ff;">protected</span> <span style="color: #0000ff;">override</span> <span style="color: #0000ff;">void</span> LoadControlState(<span style="color: #0000ff;">object</span> savedState) {</p>
<p style="margin: 0px;">            <span style="color: #0000ff;">this</span>.stateContainer = (<span style="color: #2b91af;">StateContainer</span>)savedState;</p>
<p style="margin: 0px;">        }</p>
<p style="margin: 0px;"> </p>
<p style="margin: 0px;"><span style="color: #0000ff;">        #endregion</span></p>
<p style="margin: 0px;"> </p>
<p style="margin: 0px;">        <span style="color: #0000ff;">protected</span> <span style="color: #0000ff;">override</span> <span style="color: #0000ff;">void</span> OnLoad(<span style="color: #2b91af;">EventArgs</span> e) {</p>
<p style="margin: 0px;">            <span style="color: #0000ff;">base</span>.OnLoad(e);</p>
<p style="margin: 0px;"> </p>
<p style="margin: 0px;">            <span style="color: #0000ff;">if</span> (!<span style="color: #0000ff;">this</span>.Page.IsPostBack) {</p>
<p style="margin: 0px;">                <span style="color: #008000;">// Jedná se o první dotaz, ne o postback</span></p>
<p style="margin: 0px;">                <span style="color: #0000ff;">this</span>.FirstLoadTimeVS = <span style="color: #2b91af;">DateTime</span>.Now;</p>
<p style="margin: 0px;">                <span style="color: #0000ff;">this</span>.stateContainer.FirstLoadTimeCS = <span style="color: #2b91af;">DateTime</span>.Now;</p>
<p style="margin: 0px;">            }</p>
<p style="margin: 0px;">        }</p>
<p style="margin: 0px;"> </p>
<p style="margin: 0px;">        <span style="color: #0000ff;">protected</span> <span style="color: #0000ff;">override</span> <span style="color: #0000ff;">void</span> Render(System.Web.UI.<span style="color: #2b91af;">HtmlTextWriter</span> writer) {</p>
<p style="margin: 0px;">            <span style="color: #0000ff;">if</span> (!<span style="color: #0000ff;">this</span>.Page.IsPostBack) {</p>
<p style="margin: 0px;">                <span style="color: #008000;">// Jedná se o první dotaz, ne o postback</span></p>
<p style="margin: 0px;">                writer.Write(<span style="color: #a31515;">"&lt;p&gt;Toto je první dotaz.&lt;/p&gt;"</span>);</p>
<p style="margin: 0px;">            }</p>
<p style="margin: 0px;">            <span style="color: #0000ff;">else</span> {</p>
<p style="margin: 0px;">                <span style="color: #008000;">// Jedná se o postback</span></p>
<p style="margin: 0px;">                writer.Write(<span style="color: #a31515;">"&lt;p&gt;ViewState: první dotaz nastal v {0}.&lt;/p&gt;"</span>, <span style="color: #0000ff;">this</span>.FirstLoadTimeVS);</p>
<p style="margin: 0px;">                writer.Write(<span style="color: #a31515;">"&lt;p&gt;ControlState: první dotaz nastal v {0}.&lt;/p&gt;"</span>, <span style="color: #0000ff;">this</span>.FirstLoadTimeCS);</p>
<p style="margin: 0px;">            }</p>
<p style="margin: 0px;">        }</p>
<p style="margin: 0px;"> </p>
<p style="margin: 0px;">    }</p>
<p style="margin: 0px;"> </p>
<p style="margin: 0px;">}</p>
</div>
<p>Funkcionalitu, kterou jsme dříve realizovali pomocí ViewState jsme nyní zduplikovali pomocí ControlState. Vyzkoušejte si na testovací stránce z minulého příkladu, jak to celé funguje. ViewState můžeme vypnout (a část funkcionality na něm závislá přestane fungovat), ale ControlState vypnout nelze. Proto jej prosím používejte s mírou.</p>
<p><em>V příštím článku se ViewState a ControlState podíváme na zoubek poněkud důkladněji. Podíváme se na obsah oněch Base64 kódovaných polí a také na to, jak jej lze chránit před neoprávněnou modifikací a nebo dokonce i pouhým čtením.</em></p>
