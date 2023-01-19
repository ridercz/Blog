<!-- dcterms:identifier = aspnetcz#139 -->
<!-- dcterms:title = UsersDataSource a RolesDataSource - deklarativní přístup k membership datům -->
<!-- dcterms:abstract = Za podstatnou nevýhodu membership modelu v ASP.NET považuji to, že nedává žádný prostředek, jak deklarativně pracovat s uživateli. Není možno si jednoduše vypsat třeba seznam uživatelů nebo rolí. Tuto nevýhodu lze odstranit napsáním vlastních data source prvků. -->
<!-- np9:categoryId = 7 -->
<!-- x4w:category = Software -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2007-02-02T16:43:22.69+01:00 -->
<!-- dcterms:date = 2007-02-02T16:43:22.69+01:00 -->


		<p>Za podstatnou nevýhodu membership modelu v ASP.NET považuji to, že nedává žádný prostředek, jak deklarativně pracovat s uživateli. Není možno si jednoduše vypsat třeba seznam uživatelů nebo rolí. </p>
		<p>Tento problém ale má řešení: napsat si vlastní DataSource. DataSource je nevizuální serverový ovládací prvek, který slouží jako univerzální rozhraní, umožňující bindovaným prvkům přistupovat k jakémukoliv datovému zdroji. Součástí .NET Frameworku jsou controly pro přístup k obecným datovým zdrojům (typicky SQL databáze), ale nic vám nebrání v tom, napsat si vlastní.</p>
		<p>Podrobnější informace o deklarativním data bindingu je jeho použití najdete mimo jiné i ve videoarchivu:</p>
		<ul>
				<li>
						<a href="http://videoarchiv.altairis.cz/Entry/7-cast-4-prace-s-daty-a-cacheovani.aspx">Novinky v ASP.NET 2.0, část 4: Práce s daty a cacheování</a>
				</li>
				<li>
						<a href="http://videoarchiv.altairis.cz/Entry/10-microsoft-developer-days-2006-asp-net-pro-skolu-urad-i-dum.aspx">Microsoft Developer Days 2006 - ASP.NET pro školu, úřad i dům</a>
				</li>
		</ul>
		<p>Výsledkem mého snažení budou dva controly. <code>RolesDataSource</code> a <code>UsersDataSource</code>. První jmenovaný bude vracet seznam rolí a počet uživatelů v nich, druhý všechny standardně dostupné údaje o uživatelích. Obojí využívá standardní strukturu membership providerů. Prvky tedy budou fungovat bez ohledu na to, jaký konkrétní provider bude použit.</p>
		<p>Prvky jsou implementované jako "read only", lze pomocí nich data pouze zobrazovat, nikoliv měnit. Deklarativní přístup k modifikacím dat tohoto typu mi nepřijde příliš šťastný. Nezabýval jsem se zatím ani parametrizací dotazů, i když u uživatelů to do budoucna plánuji.</p>
		<h2>RolesDataSource</h2>
		<p>Vývoj komponenty si popíšeme na prvku <code>RolesDataSource</code>:</p>
		<div style="FONT-SIZE: 11pt; BACKGROUND: white; COLOR: black; FONT-FAMILY: Consolas, Courier New, monospace">
				<p style="MARGIN: 0px">
						<span style="COLOR: blue">using</span> System;</p>
				<p style="MARGIN: 0px">
						<span style="COLOR: blue">using</span> System.Web;</p>
				<p style="MARGIN: 0px">
						<span style="COLOR: blue">using</span> System.Web.Security;</p>
				<p style="MARGIN: 0px">
						<span style="COLOR: blue">using</span> System.Web.UI;</p>
				<p style="MARGIN: 0px">
						<span style="COLOR: blue">using</span> System.Web.UI.Design;</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">
						<span style="COLOR: blue">namespace</span> Altairis.Web.UI.DeclarativeMembership {</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">    [<span style="COLOR: #2b91af">ToolboxData</span>(<span style="COLOR: #a31515">"&lt;{0}:RolesDataSource runat=server /&gt;"</span>)]</p>
				<p style="MARGIN: 0px">    <span style="COLOR: green">//[System.ComponentModel.Designer(typeof(RolesDataSourceDesigner))]</span></p>
				<p style="MARGIN: 0px">    <span style="COLOR: blue">public</span> <span style="COLOR: blue">class</span> <span style="COLOR: #2b91af">RolesDataSource</span> : <span style="COLOR: #2b91af">DataSourceControl</span> {</p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">private</span> <span style="COLOR: #2b91af">RolesView</span> roles;</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">protected</span> <span style="COLOR: blue">override</span> <span style="COLOR: #2b91af">DataSourceView</span> GetView(<span style="COLOR: blue">string</span> viewName) {</p>
				<p style="MARGIN: 0px">            <span style="COLOR: blue">if</span> (!<span style="COLOR: blue">string</span>.IsNullOrEmpty(viewName) &amp;&amp; !viewName.Equals(<span style="COLOR: #a31515">"MembershipRoles"</span>, <span style="COLOR: #2b91af">StringComparison</span>.OrdinalIgnoreCase)) <span style="COLOR: blue">throw</span> <span style="COLOR: blue">new</span> <span style="COLOR: #2b91af">ArgumentOutOfRangeException</span>(<span style="COLOR: #a31515">"viewName"</span>, viewName, <span style="COLOR: #a31515">"Specified view does not exists."</span>);</p>
				<p style="MARGIN: 0px">            <span style="COLOR: blue">if</span> (<span style="COLOR: blue">this</span>.roles == <span style="COLOR: blue">null</span>) <span style="COLOR: blue">this</span>.roles = <span style="COLOR: blue">new</span> <span style="COLOR: #2b91af">RolesView</span>(<span style="COLOR: blue">this</span>, viewName);</p>
				<p style="MARGIN: 0px">            <span style="COLOR: blue">return</span> <span style="COLOR: blue">this</span>.roles;</p>
				<p style="MARGIN: 0px">        }</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">protected</span> <span style="COLOR: blue">override</span> System.Collections.<span style="COLOR: #2b91af">ICollection</span> GetViewNames() {</p>
				<p style="MARGIN: 0px">            <span style="COLOR: blue">return</span> <span style="COLOR: blue">new</span> <span style="COLOR: blue">string</span>[] { <span style="COLOR: #a31515">"MembershipRoles"</span> };</p>
				<p style="MARGIN: 0px">        }</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">private</span> <span style="COLOR: blue">sealed</span> <span style="COLOR: blue">class</span> <span style="COLOR: #2b91af">RolesView</span> : <span style="COLOR: #2b91af">DataSourceView</span> {</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">            <span style="COLOR: blue">public</span> RolesView(<span style="COLOR: #2b91af">RolesDataSource</span> owner, <span style="COLOR: blue">string</span> ViewName) : <span style="COLOR: blue">base</span>(owner, ViewName) { }</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">            <span style="COLOR: blue">protected</span> <span style="COLOR: blue">override</span> System.Collections.<span style="COLOR: #2b91af">IEnumerable</span> ExecuteSelect(<span style="COLOR: #2b91af">DataSourceSelectArguments</span> arguments) {</p>
				<p style="MARGIN: 0px">                arguments.RaiseUnsupportedCapabilitiesError(<span style="COLOR: blue">this</span>);</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">                <span style="COLOR: blue">string</span>[] roles = <span style="COLOR: #2b91af">Roles</span>.GetAllRoles();</p>
				<p style="MARGIN: 0px">                <span style="COLOR: #2b91af">Role</span>[] r = <span style="COLOR: blue">new</span> <span style="COLOR: #2b91af">Role</span>[roles.Length];</p>
				<p style="MARGIN: 0px">                <span style="COLOR: blue">for</span> (<span style="COLOR: blue">int</span> i = 0; i &lt; roles.Length; i++) r[i] = <span style="COLOR: blue">new</span> <span style="COLOR: #2b91af">Role</span>(roles[i], <span style="COLOR: #2b91af">Roles</span>.GetUsersInRole(roles[i]).Length);</p>
				<p style="MARGIN: 0px">                <span style="COLOR: blue">return</span> r;</p>
				<p style="MARGIN: 0px">            }</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">        }</p>
				<p style="MARGIN: 0px">    }</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">    <span style="COLOR: blue">public</span> <span style="COLOR: blue">sealed</span> <span style="COLOR: blue">class</span> <span style="COLOR: #2b91af">Role</span> {</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">public</span> Role(<span style="COLOR: blue">string</span> name, <span style="COLOR: blue">int</span> users) {</p>
				<p style="MARGIN: 0px">            <span style="COLOR: blue">this</span>.roleName = name;</p>
				<p style="MARGIN: 0px">            <span style="COLOR: blue">this</span>.userCount = users;</p>
				<p style="MARGIN: 0px">        }</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">private</span> <span style="COLOR: blue">string</span> roleName;</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">public</span> <span style="COLOR: blue">string</span> RoleName {</p>
				<p style="MARGIN: 0px">            <span style="COLOR: blue">get</span> { <span style="COLOR: blue">return</span> roleName; }</p>
				<p style="MARGIN: 0px">            <span style="COLOR: blue">set</span> { roleName = <span style="COLOR: blue">value</span>; }</p>
				<p style="MARGIN: 0px">        }</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">private</span> <span style="COLOR: blue">int</span> userCount;</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">public</span> <span style="COLOR: blue">int</span> UserCount {</p>
				<p style="MARGIN: 0px">            <span style="COLOR: blue">get</span> { <span style="COLOR: blue">return</span> userCount; }</p>
				<p style="MARGIN: 0px">            <span style="COLOR: blue">set</span> { userCount = <span style="COLOR: blue">value</span>; }</p>
				<p style="MARGIN: 0px">        }</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">    }</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">}</p>
		</div>
		<!--EndFragment-->
		<p>Control sám je třída, odvozená od base class <code>System.Web.UI.DataSourceControl</code>. Implementuje dvě pro nás zajímavé metody:</p>
		<ul>
				<li>
						<code>GetViewNames</code> vrací seznam názvů podporovaných pohledů na data. V našem případě bude takový pohled pouze jeden.</li>
				<li>
						<code>GetView</code> pak vrací vlastní data. Naše implementace je velmi jednoduchá, stará se pouze o jistou formu cacheování, aby se data nenačítala z providera neustále dokola.</li>
		</ul>
		<p>Vlastní práci odvede třída <code>RolesView</code>, která je poděděná od <code>System.Web.UI.DataSourceView</code> a reprezentuje vlastní data. My zde implementujeme pouze metodu <code>ExecuteSelect</code>, která vrátí data. Obdobně existují i metody <code>ExecuteInsert</code>, <code>ExecuteUpdate</code> a <code>ExecuteDelete</code>, ty ale náš prvek nepodporuje.</p>
		<p>Metoda <code>ExecuteSelect</code> vrací kolekci (resp. <code>IEnumerable</code>) objektů, které představují vlastní položky. Vlastnosti objektů jsou pak použity jako hodnoty při data bindingu.</p>
		<p>V našem případě se jedná o třídu <code>Role</code>, která je význačná především tím, že nic neumí, je to jenom kontajner na dvě vlastnosti RoleName a UserCount.</p>
		<h2>Design-time support</h2>
		<p>Výše uvedený control je plně funkční. Přidáte-li jej do stránky, vrátí vám seznam rolí a počet uživatelů z nich. Z hlediska vývojáře ale postrádá jistý komfort, na který jsme u prvků tohoto typu zvyklí. Například si neumí zjistit schéma vrácených dat a podle toho upravit výchozí šablonu navázaných prvků. Musíte se tedy spolehnout na runtime autogenerování nebo vědět, že máte na vhodné místo napsat <code>&lt;%# Eval("RoleName") %&gt;</code>, což není právě pohodlné.</p>
		<p>Naštěstí, náprava je snadná. Stačí k prvku vytvořit takzvaný <code>Designer</code>. To je třída, kterou si volá vývojové prostředí (tedy typicky Visual Studio) při práci s daným controlem v GUI. Designer je jakási potěmkinova vesnice, třída, která dělá "jako" totéž, co vlastní control. Nevrací ale (obvykle) reálná data, jenom jejich strukturu a jakési demo.</p>
		<div style="FONT-SIZE: 11pt; BACKGROUND: white; COLOR: black; FONT-FAMILY: Consolas, Courier New, monospace">
				<p style="MARGIN: 0px">
						<span style="COLOR: blue">public</span> <span style="COLOR: blue">class</span> <span style="COLOR: #2b91af">RolesDataSourceDesigner</span> : <span style="COLOR: #2b91af">DataSourceDesigner</span> {</p>
				<p style="MARGIN: 0px">    <span style="COLOR: blue">private</span> <span style="COLOR: #2b91af">RolesView</span> roles;</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">    <span style="COLOR: blue">public</span> <span style="COLOR: blue">override</span> <span style="COLOR: #2b91af">DesignerDataSourceView</span> GetView(<span style="COLOR: blue">string</span> viewName) {</p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">if</span> (!<span style="COLOR: blue">string</span>.IsNullOrEmpty(viewName) &amp;&amp; !viewName.Equals(<span style="COLOR: #a31515">"MembershipRoles"</span>, <span style="COLOR: #2b91af">StringComparison</span>.OrdinalIgnoreCase)) <span style="COLOR: blue">throw</span> <span style="COLOR: blue">new</span> <span style="COLOR: #2b91af">ArgumentOutOfRangeException</span>(<span style="COLOR: #a31515">"viewName"</span>, viewName, <span style="COLOR: #a31515">"Specified view does not exists."</span>);</p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">if</span> (<span style="COLOR: blue">this</span>.roles == <span style="COLOR: blue">null</span>) <span style="COLOR: blue">this</span>.roles = <span style="COLOR: blue">new</span> <span style="COLOR: #2b91af">RolesView</span>(<span style="COLOR: blue">this</span>, viewName);</p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">return</span> <span style="COLOR: blue">this</span>.roles;</p>
				<p style="MARGIN: 0px">    }</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">    <span style="COLOR: blue">public</span> <span style="COLOR: blue">override</span> <span style="COLOR: blue">string</span>[] GetViewNames() {</p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">return</span> <span style="COLOR: blue">new</span> <span style="COLOR: blue">string</span>[] { <span style="COLOR: #a31515">"MembershipRoles"</span> };</p>
				<p style="MARGIN: 0px">    }</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">    <span style="COLOR: blue">private</span> <span style="COLOR: blue">sealed</span> <span style="COLOR: blue">class</span> <span style="COLOR: #2b91af">RolesView</span> : <span style="COLOR: #2b91af">DesignerDataSourceView</span> {</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">public</span> RolesView(<span style="COLOR: #2b91af">RolesDataSourceDesigner</span> owner, <span style="COLOR: blue">string</span> ViewName) : <span style="COLOR: blue">base</span>(owner, ViewName) { }</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">public</span> <span style="COLOR: blue">override</span> <span style="COLOR: #2b91af">IDataSourceViewSchema</span> Schema {</p>
				<p style="MARGIN: 0px">            <span style="COLOR: blue">get</span> {</p>
				<p style="MARGIN: 0px">                <span style="COLOR: #2b91af">TypeSchema</span> ts = <span style="COLOR: blue">new</span> <span style="COLOR: #2b91af">TypeSchema</span>(<span style="COLOR: blue">typeof</span>(<span style="COLOR: #2b91af">Role</span>));</p>
				<p style="MARGIN: 0px">                <span style="COLOR: blue">return</span> ts.GetViews()[0];</p>
				<p style="MARGIN: 0px">            }</p>
				<p style="MARGIN: 0px">        }</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">public</span> <span style="COLOR: blue">override</span> System.Collections.<span style="COLOR: #2b91af">IEnumerable</span> GetDesignTimeData(<span style="COLOR: blue">int</span> minimumRows, <span style="COLOR: blue">out</span> <span style="COLOR: blue">bool</span> isSampleData) {</p>
				<p style="MARGIN: 0px">            <span style="COLOR: blue">if</span> (minimumRows &lt; 5) minimumRows = 5;</p>
				<p style="MARGIN: 0px">            isSampleData = <span style="COLOR: blue">true</span>;</p>
				<p style="MARGIN: 0px">            <span style="COLOR: #2b91af">Role</span>[] r = <span style="COLOR: blue">new</span> <span style="COLOR: #2b91af">Role</span>[minimumRows];</p>
				<p style="MARGIN: 0px">            <span style="COLOR: blue">for</span> (<span style="COLOR: blue">int</span> i = 1; i &lt;= minimumRows; i++) r[i - 1] = <span style="COLOR: blue">new</span> <span style="COLOR: #2b91af">Role</span>(<span style="COLOR: #a31515">"Role #"</span> + i, i);</p>
				<p style="MARGIN: 0px">            <span style="COLOR: blue">return</span> r;</p>
				<p style="MARGIN: 0px">        }</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">    }</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">}</p>
		</div>
		<!--EndFragment-->
		<p>Designerem je třída <code>RolesDataSourceDesigner</code>, poděděná od <code>System.Web.UI.Design.DataSourceDesigner</code>. Namespace <code>System.Web.UI.Design</code> se nachází v assembly <code>System.Design</code>, kterou si musíte nareferencovat.</p>
		<p>Rozhraní designéru je velmi podobné rozhraní opravdového prvku, pouze vrací ukázková data vycucaná z prstu. Pro nás je zajímavá zejména vlastnost <code>Schema</code>, protože ta vrací popis struktury používaných dat. Využívám zde pomocnou třídu<code>TypeSchema</code>, která automaticky vygeneruje potřebné přes reflection. Pokud chcete mít nad výsledkem větší kontrolu, doporučuji vaší laskavé pozornosti článek linkovaný níže.</p>
		<p>Důležitým krokem je také sdělit systému, že pro control má použít vámi určený designer. To se dělá pomocí atributu <code>System.ComponentModel.Designer</code>. V prvním výpisu je již přítomen, stačí příslušný řádek odkomentovat.</p>
		<p>Po rekompilaci, kdykoliv přiřadíte bindovaný prvek ke svému DataSource, naplní se výchozí šablona podle vámi definované struktury. Upozorňuji, že testovací ASPX stránku je po rekompilaci dobré zavřít a znovu otevřít v editoru, jinak se změna nemusí projevit hned.</p>
		<h2>UsersDataSource</h2>
		<p>Prvek <code>UsersDataSource</code>, který vrací uživatele, je sice o něco komplikovanější, ale pouze z hlediska složitější struktury vráceného objektu. Na vývoj je dokonce o maličký kousek jednodušší, protože nemusíme vytvářet vlastní třídu, ale můžeme použít vestavěnou <code>System.Web.Security.MembershipUser</code>.</p>
		<h2>Závěr</h2>
		<p>Prvky DataSource umožňují deklarativní práci doslova s jakýmkoliv zdrojem dat a jejich implementace není příliš složitá. Příkladem může být třeba <a href="http://www.codeplex.com/ASPNETRSSToolkit">RSS toolkit</a>, který umožňuje tímto způsobem přistupovat k RSS feedům.</p>
		<p>Zdrojové kódy obou controlů si můžete stáhnout zde: <a href="https://www.cdn.altairis.cz/Blog/2007/20070202-DeclarativeMembership.zip">20070202-DeclarativeMembership.zip</a></p>
		<p>Při tvorbě tohoto článku (a controls :-) jsem používal následující články v MSDN:</p>
		<ul>
				<li>
						<a href="http://msdn.microsoft.com/asp.net/reference/data/default.aspx?pull=/library/en-us/dnvs05/html/DataSourceCon1.asp">Data Source Controls, Part 1: The Basics</a> </li>
				<li>
						<a href="http://msdn.microsoft.com/asp.net/reference/data/default.aspx?pull=/library/en-us/dnvs05/html/DataSourceCon2.asp">Data Source Controls, Part 2: Parameters</a> </li>
				<li>
						<a href="http://msdn.microsoft.com/asp.net/reference/data/default.aspx?pull=/library/en-us/dnvs05/html/DataSourceCon3.asp">Data Source Controls, Part 3: Async Data Access</a> </li>
				<li>
						<a href="http://msdn.microsoft.com/asp.net/reference/data/default.aspx?pull=/library/en-us/dnvs05/html/DataSourceCon4.asp">Data Source Controls, Part 4: Caching</a> </li>
				<li>
						<a href="http://msdn.microsoft.com/asp.net/reference/data/default.aspx?pull=/library/en-us/dnvs05/html/DataSourceCon5.asp">Data Source Controls, Part 5: Design-time functionality</a>
				</li>
				<li>
						<a href="http://msdn2.microsoft.com/en-us/library/aa478960.aspx">Adding Design-Time Support to ASP.NET Controls</a>
				</li>
		</ul>
		<p>Popisují tvorbu data source controls, a to do mnohem větší hloubky, než já.</p>
