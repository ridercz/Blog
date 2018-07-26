<!-- dcterms:identifier = aspnetcz#235 -->
<!-- dcterms:title = ViewState: K čemu je a jak ho správně používat -->
<!-- dcterms:abstract = Snad žádná jiná technologie v ASP.NET nezpůsobila tolik zlé krve jako právě ViewState. Hromady na první pohled zbytečných a nesmyslných Base64 kódovaných dat ve skrytém formulážovém poli __VIEWSTATE jsou to první, na co si obvykle odpůrci ASP.NET Web Forms vzpomenou, často s uštěpačnou poznámkou v duchu "nojo, co byste chtěli od Microsoftu". Jako u každé technologie ovšem i zde platí, že nejsou technologie dobré a špatné, ale pouze vhodně a nevhodně použité. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = IT -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- np9:serialId = 5 -->
<!-- x4w:serial = ViewState -->
<!-- dcterms:created = 2009-06-25T14:42:33.133+02:00 -->
<!-- dcterms:dateAccepted = 2009-06-25T14:42:33.133+02:00 -->

<p>Snad žádná jiná technologie v ASP.NET nezpůsobila tolik zlé krve jako právě ViewState. Hromady na první pohled zbytečných a nesmyslných Base64 kódovaných dat ve skrytém formulážovém poli <code>__VIEWSTATE</code> jsou to první, na co si obvykle odpůrci ASP.NET Web Forms vzpomenou, často s uštěpačnou poznámkou v duchu "nojo, co byste chtěli od Microsoftu". Jako u každé technologie ovšem i zde platí, že nejsou technologie dobré a špatné, ale pouze vhodně a nevhodně použité.</p>
<p>Technologie ViewState a její věrná sestřička ControlState jsou ve Web Forms přítomny proto, aby pomohly obcházet bezstavovost HTTP. Tomuto tématu jsem se již na stránkách ASP.NET věnoval, takže pro obecnější úvod do problematiky se můžete podívat na <a shape="rect" href="http://www.aspnet.cz/Articles/190-stavove-http-jak-funguji-cookies-session-a-viewstate-a-proc-je-nepouzivat.aspx" shape="rect">starší články</a>. Byla v nich řeč i o <a shape="rect" href="http://www.aspnet.cz/Articles/192-stavove-http-viewstate.aspx" shape="rect">ViewState</a>, ale spíše z pohledu autora stránky. V tomto seriálu se podíváme na ViewState poněkud detailněji, také z pohledu autora komponenty.</p>
<h2>ViewState</h2>
<p>Kolekce <code>ViewState</code> je úložiště, do nějž si programátor (typicky autor nějakého serverového ovládacího prvku) můýže uložit libovolnou serializovatelnou hodnotu. A budou-li bohové milostiví, při postbacku, tedy odeslání stránky, tam tuto hodnotu zase najde. Typicky se tato technika používá u složitějších prvků a formulářů, kde chceme zachovávat větší množství stavových hodnot u prvků, které za sebou nemají nativní formulářové pole.</p>
<p>Představme si například, že chceme z nějakého důvodu vědět, kdy byla zobrazena stránka, kterou posléze odesíláme. Tento čas prvního požadavku chceme zachovat na věky věkův – a pokud to nejde, tak alespoň tak, aby přežil postbacky tohoto formuláře. Zdatným pomocníkem v tomto směru nám bude třída, resp. server control <code>SampleStateControl</code>.</p>
<div style="font-family: consolas, 'courier new', monospace; background: white; color: black; font-size: 10pt;">
<p style="margin: 0px;"><span style="color: #0000ff;">using</span> System;</p>
<p style="margin: 0px;"><span style="color: #0000ff;">using</span> System.Web;</p>
<p style="margin: 0px;"> </p>
<p style="margin: 0px;"><span style="color: #0000ff;">namespace</span> MyControls {</p>
<p style="margin: 0px;"> </p>
<p style="margin: 0px;">    <span style="color: #0000ff;">public</span> <span style="color: #0000ff;">class</span> <span style="color: #2b91af;">SampleStateControl</span> : System.Web.UI.<span style="color: #2b91af;">Control</span> {</p>
<p style="margin: 0px;"> </p>
<p style="margin: 0px;">        <span style="color: #0000ff;">public</span> <span style="color: #2b91af;">DateTime</span> FirstLoadTimeVS {</p>
<p style="margin: 0px;">            <span style="color: #0000ff;">get</span> { <span style="color: #0000ff;">return</span> (<span style="color: #2b91af;">DateTime</span>)<span style="color: #0000ff;">this</span>.ViewState[<span style="color: #a31515;">"FirstLoadTimeVS"</span>]; }</p>
<p style="margin: 0px;">            <span style="color: #0000ff;">set</span> { <span style="color: #0000ff;">this</span>.ViewState[<span style="color: #a31515;">"FirstLoadTimeVS"</span>] = <span style="color: #0000ff;">value</span>; }</p>
<p style="margin: 0px;">        }</p>
<p style="margin: 0px;"> </p>
<p style="margin: 0px;">        <span style="color: #0000ff;">protected</span> <span style="color: #0000ff;">override</span> <span style="color: #0000ff;">void</span> OnLoad(<span style="color: #2b91af;">EventArgs</span> e) {</p>
<p style="margin: 0px;">            <span style="color: #0000ff;">base</span>.OnLoad(e);</p>
<p style="margin: 0px;"> </p>
<p style="margin: 0px;">            <span style="color: #0000ff;">if</span> (!<span style="color: #0000ff;">this</span>.Page.IsPostBack) {</p>
<p style="margin: 0px;">                <span style="color: #008000;">// Jedná se o první dotaz, ne o postback</span></p>
<p style="margin: 0px;">                <span style="color: #0000ff;">this</span>.FirstLoadTimeVS = <span style="color: #2b91af;">DateTime</span>.Now;</p>
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
<p style="margin: 0px;">            }</p>
<p style="margin: 0px;">        }</p>
<p style="margin: 0px;"> </p>
<p style="margin: 0px;">    }</p>
<p style="margin: 0px;"> </p>
<p style="margin: 0px;">}</p>
</div>
<p>Jádrem všeho jest vlastnost <code>FirstLoadTimeVS</code>. Ta se stará  práci s kolekcí <code>ViewState</code>. Zde uvedený kód je pro běžné "properties" server controls tak běžný, že jsem si na něj dokonce udělal code snippet, jak ho píšu často. Na názvu oné položky kolekce nezáleží, důležité je pouze aby byl unikátní v rámci jednoho konkrétního controlu. Obvykle se tedy používá název té které vlastnosti. Ve metodě <code>OnLoad</code> tuto vlastnost inicializujeme: nejedná-li se o postback, uložíme do ní aktuální datum a čas. Metoda <code>Render</code> pak vypíše příslušné hodnoty. </p>
<p>Ovládací prvek je hotov, takže si vytvoříme stránku, ve které ho použijeme:</p>
<div style="font-family: consolas, 'courier new', monospace; background: white; color: black; font-size: 10pt;">
<p style="margin: 0px;"><span style="background: #ffee62;">&lt;%</span><span style="color: #0000ff;">@</span> <span style="color: #a31515;">Page</span> <span style="color: #ff0000;">Language</span><span style="color: #0000ff;">="C#"</span> <span style="background: #ffee62;">%&gt;</span></p>
<p style="margin: 0px;"><span style="background: #ffee62;">&lt;%</span><span style="color: #0000ff;">@</span> <span style="color: #a31515;">Register</span> <span style="color: #ff0000;">TagPrefix</span><span style="color: #0000ff;">="sample"</span> <span style="color: #ff0000;">Namespace</span><span style="color: #0000ff;">="MyControls"</span> <span style="background: #ffee62;">%&gt;</span></p>
<p style="margin: 0px;"><span style="color: #0000ff;">&lt;!</span><span style="color: #a31515;">DOCTYPE</span> <span style="color: #ff0000;">html</span> <span style="color: #ff0000;">PUBLIC</span> <span style="color: #0000ff;">"-//W3C//DTD XHTML 1.0 Transitional//EN"</span> <span style="color: #0000ff;">"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"&gt;</span></p>
<p style="margin: 0px;"><span style="color: #0000ff;">&lt;</span><span style="color: #a31515;">html</span> <span style="color: #ff0000;">xmlns</span><span style="color: #0000ff;">="http://www.w3.org/1999/xhtml"&gt;</span></p>
<p style="margin: 0px;"><span style="color: #0000ff;">&lt;</span><span style="color: #a31515;">head</span> <span style="color: #ff0000;">runat</span><span style="color: #0000ff;">="server"&gt;</span></p>
<p style="margin: 0px;">    <span style="color: #0000ff;">&lt;</span><span style="color: #a31515;">title</span><span style="color: #0000ff;">&gt;&lt;/</span><span style="color: #a31515;">title</span><span style="color: #0000ff;">&gt;</span></p>
<p style="margin: 0px;"><span style="color: #0000ff;">&lt;/</span><span style="color: #a31515;">head</span><span style="color: #0000ff;">&gt;</span></p>
<p style="margin: 0px;"><span style="color: #0000ff;">&lt;</span><span style="color: #a31515;">body</span><span style="color: #0000ff;">&gt;</span></p>
<p style="margin: 0px;">    <span style="color: #0000ff;">&lt;</span><span style="color: #a31515;">form</span> <span style="color: #ff0000;">id</span><span style="color: #0000ff;">="form1"</span> <span style="color: #ff0000;">runat</span><span style="color: #0000ff;">="server"&gt;</span></p>
<p style="margin: 0px;">    <span style="color: #0000ff;">&lt;</span><span style="color: #a31515;">sample</span><span style="color: #0000ff;">:</span><span style="color: #a31515;">SampleStateControl</span> <span style="color: #ff0000;">ID</span><span style="color: #0000ff;">="SampleStateControl1"</span> <span style="color: #ff0000;">runat</span><span style="color: #0000ff;">="server"</span> <span style="color: #0000ff;">/&gt;</span></p>
<p style="margin: 0px;">    <span style="color: #0000ff;">&lt;</span><span style="color: #a31515;">asp</span><span style="color: #0000ff;">:</span><span style="color: #a31515;">Button</span> <span style="color: #ff0000;">ID</span><span style="color: #0000ff;">="Button1"</span> <span style="color: #ff0000;">runat</span><span style="color: #0000ff;">="server"</span> <span style="color: #ff0000;">Text</span><span style="color: #0000ff;">="Odeslat"</span> <span style="color: #0000ff;">/&gt;</span></p>
<p style="margin: 0px;">    <span style="color: #0000ff;">&lt;/</span><span style="color: #a31515;">form</span><span style="color: #0000ff;">&gt;</span></p>
<p style="margin: 0px;"><span style="color: #0000ff;">&lt;/</span><span style="color: #a31515;">body</span><span style="color: #0000ff;">&gt;</span></p>
<p style="margin: 0px;"><span style="color: #0000ff;">&lt;/</span><span style="color: #a31515;">html</span><span style="color: #0000ff;">&gt;</span></p>
</div>
<p>Když si stránku zobrazíme, při prvním požadavku se ukáže zpráva "Toto je první dotaz." a uloží se aktuální čas. Při postbacku se potom tento čas zobrazí a zůstává zachován i pro další postbacky, tlačítko "Odeslat" můžete mačkat opakovaně a hodnota se nezmění. Je uložena ve skrytém poli formuláře, v HTML kódu stránky, který si můžeme zobrazit v prohlížeči:</p>
<div style="font-family: consolas, 'courier new', monospace; background: white; color: black; font-size: 10pt;">
<p style="margin: 0px;"><span style="color: #0000ff;">&lt;!</span><span style="color: #a31515;">DOCTYPE</span> <span style="color: #ff0000;">html</span> <span style="color: #ff0000;">PUBLIC</span> <span style="color: #0000ff;">"-//W3C//DTD XHTML 1.0 Transitional//EN"</span> <span style="color: #0000ff;">"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"&gt;</span></p>
<p style="margin: 0px;"><span style="color: #0000ff;">&lt;</span><span style="color: #a31515;">html</span> <span style="color: #ff0000;">xmlns</span><span style="color: #0000ff;">="http://www.w3.org/1999/xhtml"&gt;</span></p>
<p style="margin: 0px;"><span style="color: #0000ff;">&lt;</span><span style="color: #a31515;">head</span><span style="color: #0000ff;">&gt;</span></p>
<p style="margin: 0px;">    <span style="color: #0000ff;">&lt;</span><span style="color: #a31515;">title</span><span style="color: #0000ff;">&gt;&lt;/</span><span style="color: #a31515;">title</span><span style="color: #0000ff;">&gt;</span></p>
<p style="margin: 0px;"><span style="color: #0000ff;">&lt;/</span><span style="color: #a31515;">head</span><span style="color: #0000ff;">&gt;</span></p>
<p style="margin: 0px;"><span style="color: #0000ff;">&lt;</span><span style="color: #a31515;">body</span><span style="color: #0000ff;">&gt;</span></p>
<p style="margin: 0px;">    <span style="color: #0000ff;">&lt;</span><span style="color: #a31515;">form</span> <span style="color: #ff0000;">name</span><span style="color: #0000ff;">="form1"</span> <span style="color: #ff0000;">method</span><span style="color: #0000ff;">="post"</span> <span style="color: #ff0000;">action</span><span style="color: #0000ff;">="default.aspx"</span> <span style="color: #ff0000;">id</span><span style="color: #0000ff;">="form2"&gt;</span></p>
<p style="margin: 0px;">    <span style="color: #0000ff;">&lt;</span><span style="color: #a31515;">div</span><span style="color: #0000ff;">&gt;</span></p>
<p style="margin: 0px;">        <span style="color: #0000ff;">&lt;</span><span style="color: #a31515;">input</span> <span style="color: #ff0000;">type</span><span style="color: #0000ff;">="hidden"</span> <span style="color: #ff0000;">name</span><span style="color: #0000ff;">="__VIEWSTATE"</span> <span style="color: #ff0000;">id</span><span style="color: #0000ff;">="__VIEWSTATE"</span> <span style="color: #ff0000;">value</span><span style="color: #0000ff;">="/wEPDwUJNjE0NDc2NzQ5D2QWAgIDD2QWAgIBDxYCHg9GaXJzdExvYWRUaW1lVlMG0Tw19qvAy4hkZLVVfrxY9sbfkkb51jVYKnmfQPMK"</span> <span style="color: #0000ff;">/&gt;</span></p>
<p style="margin: 0px;">    <span style="color: #0000ff;">&lt;/</span><span style="color: #a31515;">div</span><span style="color: #0000ff;">&gt;</span></p>
<p style="margin: 0px;">    <span style="color: #0000ff;">&lt;</span><span style="color: #a31515;">div</span><span style="color: #0000ff;">&gt;</span></p>
<p style="margin: 0px;">        <span style="color: #0000ff;">&lt;</span><span style="color: #a31515;">input</span> <span style="color: #ff0000;">type</span><span style="color: #0000ff;">="hidden"</span> <span style="color: #ff0000;">name</span><span style="color: #0000ff;">="__EVENTVALIDATION"</span> <span style="color: #ff0000;">id</span><span style="color: #0000ff;">="__EVENTVALIDATION"</span> <span style="color: #ff0000;">value</span><span style="color: #0000ff;">="/wEWAgL/18YvAoznisYGeTQeng+MgQTEfJxY5SSWGNJ7qds="</span> <span style="color: #0000ff;">/&gt;</span></p>
<p style="margin: 0px;">    <span style="color: #0000ff;">&lt;/</span><span style="color: #a31515;">div</span><span style="color: #0000ff;">&gt;</span></p>
<p style="margin: 0px;">    <span style="color: #0000ff;">&lt;</span><span style="color: #a31515;">p</span><span style="color: #0000ff;">&gt;</span>Toto je první dotaz.<span style="color: #0000ff;">&lt;/</span><span style="color: #a31515;">p</span><span style="color: #0000ff;">&gt;</span></p>
<p style="margin: 0px;">    <span style="color: #0000ff;">&lt;</span><span style="color: #a31515;">input</span> <span style="color: #ff0000;">type</span><span style="color: #0000ff;">="submit"</span> <span style="color: #ff0000;">name</span><span style="color: #0000ff;">="Button1"</span> <span style="color: #ff0000;">value</span><span style="color: #0000ff;">="Odeslat"</span> <span style="color: #ff0000;">id</span><span style="color: #0000ff;">="Submit1"</span> <span style="color: #0000ff;">/&gt;</span></p>
<p style="margin: 0px;">    <span style="color: #0000ff;">&lt;/</span><span style="color: #a31515;">form</span><span style="color: #0000ff;">&gt;</span></p>
<p style="margin: 0px;"><span style="color: #0000ff;">&lt;/</span><span style="color: #a31515;">body</span><span style="color: #0000ff;">&gt;</span></p>
<p style="margin: 0px;"><span style="color: #0000ff;">&lt;/</span><span style="color: #a31515;">html</span><span style="color: #0000ff;">&gt;</span></p>
</div>
<p>Obsahu skrytého pole <code>__VIEWSTATE</code> se budeme důkladně věnovat později, pro tento okamžik se spokojte s mým ujištěním, že aktuální čas je pečlivě zaznamenán právě zde.</p>
<h2>Vypnutí ViewState</h2>
<p>ViewState lze zakázat. Každý server control i stránka sama (která je jenom speciálním případem controlu) má vlastnost <code>EnableViewState</code>, kterou lze nastavit na <code>false</code> a v takovém případě se shora popsaný mechanismus nepoužije. ViewState můžete vypnout i pro celou akci pomocí <code>web.configu</code>, když nastavíte <code>/configuration/system.web/pages/@enableViewState</code> na <code>false</code>.</p>
<p>Pokud ViewState na úrovni stránky nebo aplikace vypneme a stránku si nově zobrazíme, skryté pole <code>__VIEWSTATE</code> sice nezmizí, ale jeho obsah se výrazně zmenší. Zbavit se tohoto pole úplně je civilizovanými prostředky téměř nemožné a především to není moc účelné. Kromě hodnot uložených způsobem popsaným výše se v něm skrývají i hodnoty ControlState (o tom budeme mluvit později) a také podle něj ASP.NET identifikují postback, tedy že vůbec došlo k odeslání formuláře. Naším cílem není se ViewState úplně zbavit, ale využívat ho smysluplně.</p>
<p>Smutnou skutečností je, že aktuální verze ASP.NET (3.5 SP1) umožňuje ViewState selektivně vypínat, ale už ne zapínat. Pokud ViewState na vyšší úrovni zakážete, už ho na nižší nepovolíte. Toto omezení bude odstraněno v nadcházející verzi 4.0.</p>
<p>Máme tedy zobrazenu stránku se zakázaným ViewState a stiskneme odesílací tlačíko. Stránka promptně vyhlásí populární <code>NullReferenceException</code> na následujícím kódu:</p>
<div style="font-family: consolas, 'courier new', monospace; background: white; color: black; font-size: 10pt;">
<p style="margin: 0px;"><span style="color: #0000ff;">return</span> (<span style="color: #2b91af;">DateTime</span>)<span style="color: #0000ff;">this</span>.ViewState[<span style="color: #a31515;">"FirstLoadTimeVS"</span>];</p>
</div>
<p>Pokud je funkce ViewState vypnutá, tak kolekce <code>ViewState</code> funguje dále (tj. v průběhu jednoho životního cyklu stránky ji můžeme nadále využívat), ale nepřežije postback, nebude mít po něm inicializované žádné položky a dotaz na libovolnou z nich vrátí <code>null</code>. Protože <code>DateTime</code> je struktura (<code>struct</code>), není možné null takto přetypovat a proto dojde k výše popsané výjimce. Do ViewState tedy ukládejte pouze nulovatelné typy (jako například <code>DateTime?</code> alias <code>Nullable&lt;DateTime&gt;</code>) a nebo v konstruktoru vlastnosti inicializujte na nějakou výchozí hodnotu, například takto:</p>
<div style="font-family: consolas, 'courier new', monospace; background: white; color: black; font-size: 10pt;">
<p style="margin: 0px;"><span style="color: #0000ff;">public</span> SampleStateControl() {</p>
<p style="margin: 0px;">    <span style="color: #008000;">// Nastavení výchozí hodnoty</span></p>
<p style="margin: 0px;">    <span style="color: #0000ff;">this</span>.FirstLoadTimeVS = <span style="color: #2b91af;">DateTime</span>.MinValue;</p>
<p style="margin: 0px;">}</p>
</div>
<p>Pokud chybu takto odstraníme, stránka úspěšně funguje, ale tvrdí, že první dotaz nastal 01. 01. 00001 v 00:00:00, což je hodnota <code>DateTime.MinValue</code> a tedy důkaz, že se prvotní čas nikde neuložil.</p>
<h2>Morální ponaučení</h2>
<p>Morální ponaučení ze shora uvedeného příběhu zní: do ViewState si ukládejte pouze to, co můžete postrádat. Co jste schopni získat v případě potřeby nějak jinak. ASP.NET se tak chová třeba při data bindingu: aby nemusel při odeslání formuláře zatěžovat databázový server, tak si dříve zjištrěné hodnoty uloží do ViewState a po postbacku je použije. Můžete si tedy vybrat mezi zvýšením zátěže databáze a nebo zvýšením objemu přenesených dat.</p>
<p><em>Co ale pokud si některé věci potřebujete uložit opravdu nutně? A chcete, aby control fungoval i při vypnutém ViewState? Existuje řešení? Dobrá zpráva je: ano, existuje a jmenuje se ControlState. Špatná zpráva je, že více se o něm dozvíte až v příštím článku.</em></p>
