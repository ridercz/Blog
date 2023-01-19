<!-- dcterms:identifier = aspnetcz#113 -->
<!-- dcterms:title = Načítání kurzů měn z různých bank - malý exkurz do základů objektového programování -->
<!-- dcterms:abstract = Do jednoho systému, který právě píšu, potřebuji automatické přepočítávání měn pomocí právě platného kurzu, a to navíc hned několika bank. Což je výborná možnost jak ukázat zase trochu opravdového programování, aby mi na cizích blozích v komentářích nevyčítali, že ukazuji jenom klikání uživatelského rozhraní. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = IT -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2006-09-19T01:46:48.023+02:00 -->
<!-- dcterms:date = 2006-09-19T01:46:48.023+02:00 -->


		<p>Do jednoho systému, který právě píšu, potřebuji automatické přepočítávání měn pomocí právě platného kurzu, a to navíc hned několika bank. Což je výborná možnost jak ukázat zase trochu <em>opravdového programování,</em> aby mi na cizích blozích v komentářích nevyčítali, že ukazuji jenom klikání uživatelského rozhraní.</p>
		<p>Základní idea je následující: napsat komponentu, která umožní automatizovaně načítat z webů několika různých bank informace o právě platném směnném kurzu koruny. Rozhraní by mělo být jednotné a univerzální, abych nebyl vázán na to, kterou banku právě používám. Základní úkol není nijak složitý, neboť banky dávají tyto informace na web ve formátu, který je (podle nich) vhodný pro automatické zpracování, což je typicky nějaký textový formát s oddělovačem, nebo v případě pokročilejších ústavů XML soubor. Proparsovat tato data není nikterak obtížné, takže se zaměříme na jejich vhodnou reprezentaci.</p>
		<h2>Struktura</h2>
		<p>Základní strukturu tříd si můžete prohlédnout na následujícím diagramu:</p>
		<p>
				<img width="523" height="526" alt="Diagram tříd" src="https://www.cdn.altairis.cz/Blog/2006/20060919-MoneyExchange.gif"> </p>
		<p>Informace o kurzu konkrétní měny jsou reprezentovány strukturou <code>ExchangeRate</code>. Ta obsahuje informace o mezinárodním trojpísmenném kódu měny (např. <code>USD</code>, pole <code>Code</code>). Pole <code>Country</code> a <code>Currency</code> mohou obsahovat "lidsky čitelné" označení země a měny, nicméně jejich obsah závisí na libovůli banky. <code>Measure</code> je nominální množství měny, pro které je kurz stanoven a konečně <code>Rate</code> je vlastní kurz. </p>
		<p>Typicky se kurz stanovuje za jednotku cizí měny (1 USD = 22,445 CZK), ale pokud je kurz za jednotku nižší než kurz domácí měny, z důvodu přehlednosti se používá cena za 100 nebo 1000 nominálních jednotek (takže kurz se uvádí jako 100 SKK = 76,097 CZK, nikoliv 1 SKK = 0,76097 CZK). Tato reprezentace je vhodná pro lidské bytosti, ale ne pro automatizované přepočty. Proto má tato struktura též vlastnost <code>NormalizedRate</code>, což je automaticky přepočítaná cena za jednotku. </p>
		<p>Zdrojový kód vypadá takto:</p>
		<div style="FONT-SIZE: 10pt; BACKGROUND: white; COLOR: black; FONT-FAMILY: 'Courier New', monospace">
				<p style="MARGIN: 0px">
						<span style="COLOR: blue">public</span> <span style="COLOR: blue">struct</span> <span style="COLOR: teal">ExchangeRate</span> {</p>
				<p style="MARGIN: 0px">    <span style="COLOR: blue">public</span> <span style="COLOR: blue">string</span> Code, Country, Currency;</p>
				<p style="MARGIN: 0px">    <span style="COLOR: blue">public</span> <span style="COLOR: blue">int</span> Measure;</p>
				<p style="MARGIN: 0px">    <span style="COLOR: blue">public</span> <span style="COLOR: blue">decimal</span> Rate;</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">    <span style="COLOR: blue">public</span> <span style="COLOR: blue">decimal</span> NormalizedRate {</p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">get</span> { <span style="COLOR: blue">return</span> <span style="COLOR: blue">this</span>.Rate / <span style="COLOR: blue">this</span>.Measure; }</p>
				<p style="MARGIN: 0px">    }</p>
				<p style="MARGIN: 0px">}</p>
		</div>
		<!--EndFragment-->
		<p>Banka poskytuje seznam kurzů všech měn, se kterými běžně obchoduje. Kurzy pro všechny takové měny jsou reprezentovány kolekcí <code>ExchangeRateCollection</code>. Využívám zde novinky .NET 2.0 v podobě generické třídy <code>System.Collections.ObjectModel.KeyedCollection</code>, u které se zastavím poněkud podrobněji.</p>
		<p>Kolekcí se v případě .NET obecně rozumí sbírka prvků téhož typu (v našem případě jde o strukturu <code>ExchangeRate</code>). Prvky v kolekci lze procházet buďto sekvenčně pomocí cyklu For Each a nebo k nim adresně přistupovat pomocí klíče. Typickým příkladem použití kolekce je například přístup k parametrům předaným stránce metodou GET, kdy se zpravidla používá konstrukce <code>Request.QueryString("NázevParametru")</code> (resp. v C# <code>Request.QueryString["NázevParametru"]</code>).</p>
		<p>U měnových kurzů předpokládám, že se bude k hodnotám přistupovat pomocí klíče, který je obsažen v hodnotě samé, konkrétně jako její pole <code>Code</code>. Žádoucí je tedy možnost napsat věci jako <code>cenaUSD = cenaCZK / kurzy["USD"].NormalizedRate;</code>. Přesně k tomuto účelu slouží nová generická třída <code>KeyedCollection</code>. Ta umožňuje skladovat libovolné typy a určit, která že z jejích vlastností je klíčem. Vytvoříme si tedy novou třídu <code>ExchangeRateCollection</code>, kterou od shora uvedené podědíme. Přepíšeme metodu <code>GetKeyForItem</code>, v niž stanovíme pole <code>Code</code> jako klíč.</p>
		<p>Zdrojový kód vypadá takto:</p>
		<div style="FONT-SIZE: 10pt; BACKGROUND: white; COLOR: black; FONT-FAMILY: 'Courier New', monospace">
				<p style="MARGIN: 0px">
						<span style="COLOR: blue">public</span> <span style="COLOR: blue">class</span> <span style="COLOR: teal">ExchangeRateCollection</span> : System.Collections.ObjectModel.<span style="COLOR: teal">KeyedCollection</span>&lt;<span style="COLOR: blue">string</span>, <span style="COLOR: teal">ExchangeRate</span>&gt; {</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">    <span style="COLOR: blue">public</span> ExchangeRateCollection() : <span style="COLOR: blue">base</span>() { }</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">    <span style="COLOR: blue">protected</span> <span style="COLOR: blue">override</span> <span style="COLOR: blue">string</span> GetKeyForItem(<span style="COLOR: teal">ExchangeRate</span> item) {</p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">return</span> item.Code;</p>
				<p style="MARGIN: 0px">    }</p>
				<p style="MARGIN: 0px">}</p>
		</div>
		<!--EndFragment-->
		<p>Poslední část páteře aplikace představuje rozhraní <code>IExchangeRateSource</code>, které reprezentuje obecný kurzovní lístek libovolné banky či podobné instituce. Z hlediska objektově orientovaného programování jsou třídy obecně pokládány za "černé skříňky", o jejichž obsah se zbytek aplikace nezajímá a komunikuje přes definované rozhraní (angl. <em>interface</em>), tedy sbírku vlastností, metod a podobně. </p>
		<p>V řadě případů, včetně našeho, vyvstává potřeba mít několik různých tříd, s různým obsahem (protože každá banka zveřejňuje kurzy jiným způsobem), ale se stejným rozhraním, aby bylo možno k nim přistupovat systemizovaně stejným způsobem. V objektově orientovaném programování se taková věc zajišťuje zpravidla prostřednictvím konstrukce, která se v zájmu zmatení programátorů též nazývá interface, neboli česky rozhraní. Jedná se v podstatě o prázdnou obálku třídy, která definuje, jaké má mít metody a vlastnosti, ale sama o sobě neobsahuje žádnou funkčnost. Konvence praví, že název rozhraní by měl začínat velkým písmenem I - a v zájmu zachování zdravého rozumu vám doporučuji se této konvence držet.</p>
		<p>Zdrojový kód našeho interface <code>IExchangeRateSource</code> vypadá takto: </p>
		<div style="FONT-SIZE: 10pt; BACKGROUND: white; COLOR: black; FONT-FAMILY: 'Courier New', monospace">
				<p style="MARGIN: 0px">
						<span style="COLOR: blue">public</span> <span style="COLOR: blue">interface</span> <span style="COLOR: teal">IExchangeRateSource</span> {</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">    <span style="COLOR: blue">void</span> Load();</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">    <span style="COLOR: blue">void</span> Load(<span style="COLOR: teal">DateTime</span> date);</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">    <span style="COLOR: teal">DateTime</span> Date { <span style="COLOR: blue">get</span>; }</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">    <span style="COLOR: teal">ExchangeRateCollection</span> ExchangeRates { <span style="COLOR: blue">get</span>; }</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">    <span style="COLOR: blue">string</span> Name { <span style="COLOR: blue">get</span>; }</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">}</p>
		</div>
		<!--EndFragment-->
		<p>Kód praví, že každý zdroj kurzových informací musí implementovat metodu <code>Load</code>, a to ve dvou inkarnacích. Zavolána bez parametrů vrátí aktuální (poslední dostupný) kurz. Obdařena parametrem <code>date</code> vrátí kurz který byl aktuální pro definované datum. Ne všechny banky zveřejňují ve strojově čitelné podobě historické kurzy, může se tedy stát, že při druhém způsobu volání třída vyhodí výjimku <code>NotSupportedException</code>.</p>
		<p>Dále máme k dispozici tři vlastnosti, všechny jsou pouze pro čtení:</p>
		<ul>
				<li>
						<code>Name</code> vrací název zdroje (typicky tedy název banky).</li>
				<li>
						<code>ExchangeRates</code> vrací shora popsanou kolekci informací o kurzu jednotlivých měn.</li>
				<li>
						<code>Date</code> vrací datum (a event. čas, pokud ho banka uvádí) kdy byl kurz vydán. Banky kurzy nevydávají každý den, ale obvykle pouze ve dnech pracovních. V sobotu a neděli tedy platí kurz z pátku a hodnota <code>Date</code> se tedy může lišit od data zadaného jako parametr metody Load.</li>
		</ul>
		<h2>Využití dat</h2>
		<p>Shora uvedená architektura nám dává možnost napsat metodu, která dokáže získat a zobrazit kurzovní lístek libovolné banky, pro kterou máme k dispozici odpovídající třídu. Následující kód vypíše získané informace na konzoli:</p>
		<p>
				<!--StartFragment-->
		</p>
		<div style="FONT-SIZE: 10pt; BACKGROUND: white; COLOR: black; FONT-FAMILY: 'Courier New', monospace">
				<p style="MARGIN: 0px">
						<span style="COLOR: blue">private</span> <span style="COLOR: blue">static</span> <span style="COLOR: blue">void</span> Process(<span style="COLOR: teal">IExchangeRateSource</span> s) {</p>
				<p style="MARGIN: 0px">    <span style="COLOR: green">// Download data</span></p>
				<p style="MARGIN: 0px">    <span style="COLOR: teal">Console</span>.Write(<span style="COLOR: maroon">"Downloading data from {0}..."</span>, s.Name);</p>
				<p style="MARGIN: 0px">    s.Load();</p>
				<p style="MARGIN: 0px">    <span style="COLOR: teal">Console</span>.WriteLine(<span style="COLOR: maroon">"OK"</span>);</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">    <span style="COLOR: green">// Show data</span></p>
				<p style="MARGIN: 0px">    <span style="COLOR: teal">Console</span>.WriteLine(<span style="COLOR: maroon">"Exchange rates for {0:g}:"</span>, s.Date);</p>
				<p style="MARGIN: 0px">    <span style="COLOR: blue">foreach</span> (<span style="COLOR: teal">ExchangeRate</span> er <span style="COLOR: blue">in</span> s.ExchangeRates) {</p>
				<p style="MARGIN: 0px">        <span style="COLOR: teal">Console</span>.WriteLine(<span style="COLOR: maroon">"  {2} {0} {1} = {3} CZK"</span>, er.Measure.ToString().PadLeft(6), er.Code, er.Country.PadRight(20), er.Rate.ToString(<span style="COLOR: maroon">"N3"</span>).PadLeft(7));</p>
				<p style="MARGIN: 0px">    }</p>
				<p style="MARGIN: 0px">    <span style="COLOR: teal">Console</span>.WriteLine();</p>
				<p style="MARGIN: 0px">}</p>
		</div>
		<!--EndFragment-->
		<h2>Získání údajů z konkrétní banky</h2>
		<p>Zdrojový kód, který si můžete stáhnout, obsahuje čtyči třídy, které implementují rozhraní <code>IExchangeRateSource</code> a umožňují načítat data několika českých bank:</p>
		<ul>
				<li>
						<code>CnbExchamgeRateSource</code> - <a href="http://www.cnb.cz/cz/financni_trhy/devizovy_trh/kurzy_devizoveho_trhu/denni_kurz.txt">Česká národní banka</a></li>
				<li>
						<code>CsasExchamgeRateSource</code> - <a href="http://www.csas.cz/banka/application?pageid=exchangerates&tree=banka&navid=nav00012_Kurzovni_listek">Česká spořitelna</a></li>
				<li>
						<code>CsobExchamgeRateSource</code> - <a href="http://www.csob.cz/data/export/kurzynewcz.txt">Československá obchodní banka</a></li>
				<li>
						<code>ZibaExchamgeRateSource</code> - <a href="http://www1.zivnobanka.cz/cs/xml_info/kurzovni_listek.html">Živnostenská banka</a></li>
		</ul>
		<p>Zdrojový kód třídy pro načítání dat z ČNB vypadá takto:</p>
		<div style="FONT-SIZE: 10pt; BACKGROUND: white; COLOR: black; FONT-FAMILY: 'Courier New', monospace">
				<p style="MARGIN: 0px">
						<span style="COLOR: blue">public</span> <span style="COLOR: blue">class</span> <span style="COLOR: teal">CnbExchangeRateSource</span> : <span style="COLOR: teal">IExchangeRateSource</span> {</p>
				<p style="MARGIN: 0px">    <span style="COLOR: blue">private</span> <span style="COLOR: blue">const</span> <span style="COLOR: blue">string</span> DataLinePattern = <span style="COLOR: maroon">@"^[^\|]+\|[^\|]+\|\d+\|[A-Z]{3}\|\d+(,\d+)?$"</span>;</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">    <span style="COLOR: blue">private</span> <span style="COLOR: blue">string</span> dataUrl = <span style="COLOR: maroon">@"http://www.cnb.cz/cz/financni_trhy/devizovy_trh/kurzy_devizoveho_trhu/denni_kurz.txt?date={0:dd\.MM\.yyyy}"</span>;</p>
				<p style="MARGIN: 0px">    <span style="COLOR: blue">private</span> <span style="COLOR: teal">DateTime</span> date;</p>
				<p style="MARGIN: 0px">    <span style="COLOR: blue">private</span> <span style="COLOR: teal">ExchangeRateCollection</span> exchangeRates;</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">    <span style="COLOR: blue">public</span> <span style="COLOR: blue">string</span> DataUrl {</p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">get</span> { <span style="COLOR: blue">return</span> dataUrl; }</p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">set</span> {</p>
				<p style="MARGIN: 0px">            <span style="COLOR: blue">if</span> (<span style="COLOR: blue">string</span>.IsNullOrEmpty(<span style="COLOR: blue">value</span>)) <span style="COLOR: blue">throw</span> <span style="COLOR: blue">new</span> <span style="COLOR: teal">ArgumentNullException</span>();</p>
				<p style="MARGIN: 0px">            dataUrl = <span style="COLOR: blue">value</span>;</p>
				<p style="MARGIN: 0px">        }</p>
				<p style="MARGIN: 0px">    }</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">    <span style="COLOR: blue">public</span> CnbExchangeRateSource() { }</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">    <span style="COLOR: blue">public</span> CnbExchangeRateSource(<span style="COLOR: blue">string</span> url) {</p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">this</span>.DataUrl = url;</p>
				<p style="MARGIN: 0px">    }</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">    <span style="COLOR: blue">public</span> <span style="COLOR: blue">void</span> Load() {</p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">this</span>.Load(<span style="COLOR: teal">DateTime</span>.Now);</p>
				<p style="MARGIN: 0px">    }</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">    <span style="COLOR: blue">public</span> <span style="COLOR: blue">void</span> Load(<span style="COLOR: teal">DateTime</span> date) {</p>
				<p style="MARGIN: 0px">        <span style="COLOR: green">// Download data</span></p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">string</span> data = <span style="COLOR: blue">string</span>.Empty;</p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">using</span> (System.Net.<span style="COLOR: teal">WebClient</span> c = <span style="COLOR: blue">new</span> System.Net.<span style="COLOR: teal">WebClient</span>()) {</p>
				<p style="MARGIN: 0px">            c.Encoding = System.Text.<span style="COLOR: teal">Encoding</span>.UTF8;</p>
				<p style="MARGIN: 0px">            data = c.DownloadString(<span style="COLOR: blue">string</span>.Format(<span style="COLOR: blue">this</span>.DataUrl, date));</p>
				<p style="MARGIN: 0px">        }</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">        <span style="COLOR: green">// Parse data</span></p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">string</span>[] lines = data.Split(<span style="COLOR: blue">new</span> <span style="COLOR: blue">string</span>[] { <span style="COLOR: maroon">"\r\n"</span>, <span style="COLOR: maroon">"\r"</span>, <span style="COLOR: maroon">"\n"</span> }, <span style="COLOR: teal">StringSplitOptions</span>.RemoveEmptyEntries);</p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">if</span> (lines.Length &lt; 3) <span style="COLOR: blue">throw</span> <span style="COLOR: blue">new</span> <span style="COLOR: teal">FormatException</span>(<span style="COLOR: maroon">"Downloaded data are invalid -- not enough lines."</span>);</p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">this</span>.date = <span style="COLOR: teal">DateTime</span>.ParseExact(lines[0].Substring(0, 10), <span style="COLOR: maroon">@"dd\.MM\.yyyy"</span>, <span style="COLOR: blue">null</span>);</p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">this</span>.exchangeRates = <span style="COLOR: blue">new</span> <span style="COLOR: teal">ExchangeRateCollection</span>();</p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">for</span> (<span style="COLOR: blue">int</span> i = 2; i &lt; lines.Length; i++) {</p>
				<p style="MARGIN: 0px">            <span style="COLOR: blue">if</span> (!System.Text.RegularExpressions.<span style="COLOR: teal">Regex</span>.IsMatch(lines[i], DataLinePattern)) <span style="COLOR: blue">throw</span> <span style="COLOR: blue">new</span> <span style="COLOR: teal">FormatException</span>(<span style="COLOR: maroon">"Unexpected format of string - '"</span> + lines[i] + <span style="COLOR: maroon">"'."</span>);</p>
				<p style="MARGIN: 0px">            <span style="COLOR: blue">string</span>[] sa = lines[i].Split(<span style="COLOR: maroon">'|'</span>);</p>
				<p style="MARGIN: 0px">            <span style="COLOR: teal">ExchangeRate</span> r = <span style="COLOR: blue">new</span> <span style="COLOR: teal">ExchangeRate</span>();</p>
				<p style="MARGIN: 0px">            r.Country = sa[0];</p>
				<p style="MARGIN: 0px">            r.Currency = sa[1];</p>
				<p style="MARGIN: 0px">            r.Measure = <span style="COLOR: blue">int</span>.Parse(sa[2]);</p>
				<p style="MARGIN: 0px">            r.Code = sa[3];</p>
				<p style="MARGIN: 0px">            r.Rate = <span style="COLOR: blue">decimal</span>.Parse(sa[4], <span style="COLOR: blue">new</span> <span style="COLOR: teal">CultureInfo</span>(<span style="COLOR: maroon">"cs-CZ"</span>));</p>
				<p style="MARGIN: 0px">            <span style="COLOR: blue">this</span>.exchangeRates.Add(r);</p>
				<p style="MARGIN: 0px">        }</p>
				<p style="MARGIN: 0px">    }</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">    <span style="COLOR: blue">public</span> <span style="COLOR: teal">DateTime</span> Date {</p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">get</span> { <span style="COLOR: blue">return</span> <span style="COLOR: blue">this</span>.date; }</p>
				<p style="MARGIN: 0px">    }</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">    <span style="COLOR: blue">public</span> <span style="COLOR: teal">ExchangeRateCollection</span> ExchangeRates {</p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">get</span> { <span style="COLOR: blue">return</span> <span style="COLOR: blue">this</span>.exchangeRates; }</p>
				<p style="MARGIN: 0px">    }</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">    <span style="COLOR: blue">public</span> <span style="COLOR: blue">string</span> Name {</p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">get</span> { <span style="COLOR: blue">return</span> <span style="COLOR: maroon">"?eská národní banka"</span>; }</p>
				<p style="MARGIN: 0px">    }</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">} </p>
		</div>
		<!--EndFragment-->
		<h2>Závěr</h2>
		<ul>
				<li>
						<a href="https://www.cdn.altairis.cz/Blog/2006/20060919-MoneyExchange.zip">Zdrojové kódy a zkompilovaná knihovna ke stažení</a> (13 kB)</li>
		</ul>
