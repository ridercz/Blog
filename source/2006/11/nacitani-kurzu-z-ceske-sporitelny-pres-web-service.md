<!-- dcterms:identifier = aspnetcz#119 -->
<!-- dcterms:title = Načítání kurzů z České spořitelny přes web service -->
<!-- dcterms:abstract = Před nějakým časem jsem zde zveřejnil kód pro načítání kurzů měn z různých bank. Krátce poté přestal fungovat modul pro načítání z ČS, protože banka změnila adresu, na níž se CSV data nacházejí. Funguje nicméně webová služba, která poskytuje tatáž data a odpovídající třídu lze snadno upravit tak, aby ji používala. -->
<!-- np9:categoryId = 6 -->
<!-- x4w:category = Akce a události -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2006-11-01T16:42:16.977+01:00 -->
<!-- dcterms:date = 2006-11-01T16:42:16.977+01:00 -->


		<p>Před nějakým časem jsem zde zveřejnil <a href="https://www.aspnet.cz/Articles/113-nacitani-kurzu-men-z-ruznych-bank-maly-exkurz-do-zakladu-objektoveho-programovani.aspx">kód pro načítání kurzů měn z různých bank</a>. Krátce poté přestal fungovat modul pro načítání z ČS, protože banka změnila adresu, na níž se CSV data nacházejí (funkční adresu se mi dosud nepodařilo odhalit).</p>
		<p>Na adrese <a href="http://www.csas.cz/csws/changerates/ChangeRates.jws">http://www.csas.cz/csws/changerates/ChangeRates.jws</a> nicméně funguje webová služba, která poskytuje tatáž data. Níže naleznete upravenou verzi třídy <em>CsasExchangeRateSource</em>:</p>
		<div style="FONT-SIZE: 11pt; BACKGROUND: white; COLOR: black; FONT-FAMILY: Consolas, Courier New, monotype">
				<p style="MARGIN: 0px">
						<span style="COLOR: blue">using</span> System;</p>
				<p style="MARGIN: 0px">
						<span style="COLOR: blue">using</span> System.Collections.Generic;</p>
				<p style="MARGIN: 0px">
						<span style="COLOR: blue">using</span> System.Text;</p>
				<p style="MARGIN: 0px">
						<span style="COLOR: blue">using</span> System.Globalization;</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">
						<span style="COLOR: blue">namespace</span> Altairis.Utils.MoneyExchange {</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">    <span style="COLOR: blue">public</span> <span style="COLOR: blue">class</span> <span style="COLOR: #2b91af">CsasExchangeRateSource</span> : <span style="COLOR: #2b91af">IExchangeRateSource</span> {</p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">public</span> <span style="COLOR: blue">enum</span> <span style="COLOR: #2b91af">MoneyTypes</span> { Devizy = 0, Valuty = 1 }</p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">public</span> <span style="COLOR: blue">enum</span> <span style="COLOR: #2b91af">OfferTypes</span> { Nakup = 0, Prodej = 1, Stred = 2 }</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">private</span> <span style="COLOR: #2b91af">DateTime</span> date;</p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">private</span> <span style="COLOR: #2b91af">ExchangeRateCollection</span> exchangeRates;</p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">private</span> <span style="COLOR: #2b91af">MoneyTypes</span> moneyType = <span style="COLOR: #2b91af">MoneyTypes</span>.Devizy;</p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">private</span> <span style="COLOR: #2b91af">OfferTypes</span> offerType = <span style="COLOR: #2b91af">OfferTypes</span>.Stred;</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">public</span> <span style="COLOR: #2b91af">OfferTypes</span> OfferType {</p>
				<p style="MARGIN: 0px">            <span style="COLOR: blue">get</span> { <span style="COLOR: blue">return</span> offerType; }</p>
				<p style="MARGIN: 0px">            <span style="COLOR: blue">set</span> { offerType = <span style="COLOR: blue">value</span>; }</p>
				<p style="MARGIN: 0px">        }</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">public</span> <span style="COLOR: #2b91af">MoneyTypes</span> MoneyType {</p>
				<p style="MARGIN: 0px">            <span style="COLOR: blue">get</span> { <span style="COLOR: blue">return</span> moneyType; }</p>
				<p style="MARGIN: 0px">            <span style="COLOR: blue">set</span> { moneyType = <span style="COLOR: blue">value</span>; }</p>
				<p style="MARGIN: 0px">        }</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">public</span> <span style="COLOR: blue">void</span> Load() {</p>
				<p style="MARGIN: 0px">            CsasExchange.<span style="COLOR: #2b91af">ChangeRates</span> ws = <span style="COLOR: blue">new</span> CsasExchange.<span style="COLOR: #2b91af">ChangeRates</span>();</p>
				<p style="MARGIN: 0px">            CsasExchange.<span style="COLOR: #2b91af">CHANGERATES</span> cr = ws.getCurrent();</p>
				<p style="MARGIN: 0px">            UpdateRates(cr);</p>
				<p style="MARGIN: 0px">        }</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">public</span> <span style="COLOR: blue">void</span> Load(<span style="COLOR: #2b91af">DateTime</span> date) {</p>
				<p style="MARGIN: 0px">            CsasExchange.<span style="COLOR: #2b91af">ChangeRates</span> ws = <span style="COLOR: blue">new</span> CsasExchange.<span style="COLOR: #2b91af">ChangeRates</span>();</p>
				<p style="MARGIN: 0px">            CsasExchange.<span style="COLOR: #2b91af">CHANGERATES</span> cr = ws.getArchive(date, <span style="COLOR: blue">true</span>);</p>
				<p style="MARGIN: 0px">            UpdateRates(cr);</p>
				<p style="MARGIN: 0px">        }</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">private</span> <span style="COLOR: blue">void</span> UpdateRates(CsasExchange.<span style="COLOR: #2b91af">CHANGERATES</span> cr) {</p>
				<p style="MARGIN: 0px">            <span style="COLOR: blue">this</span>.date = cr.DATE;</p>
				<p style="MARGIN: 0px">            <span style="COLOR: blue">this</span>.exchangeRates = <span style="COLOR: blue">new</span> <span style="COLOR: #2b91af">ExchangeRateCollection</span>();</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">            <span style="COLOR: blue">for</span> (<span style="COLOR: blue">int</span> i = 0; i &lt; cr.RATES.Length; i++) {</p>
				<p style="MARGIN: 0px">                CsasExchange.<span style="COLOR: #2b91af">CURRENCY</span> c = cr.RATES[i];</p>
				<p style="MARGIN: 0px">                CsasExchange.<span style="COLOR: #2b91af">Values</span> rv;</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">                <span style="COLOR: blue">if</span> (<span style="COLOR: blue">this</span>.MoneyType == <span style="COLOR: #2b91af">MoneyTypes</span>.Valuty) {</p>
				<p style="MARGIN: 0px">                    rv = c.CASH;</p>
				<p style="MARGIN: 0px">                }</p>
				<p style="MARGIN: 0px">                <span style="COLOR: blue">else</span> {</p>
				<p style="MARGIN: 0px">                    rv = c.CASHLESS;</p>
				<p style="MARGIN: 0px">                }</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">                <span style="COLOR: #2b91af">ExchangeRate</span> r = <span style="COLOR: blue">new</span> <span style="COLOR: #2b91af">ExchangeRate</span>();</p>
				<p style="MARGIN: 0px">                r.Country = c.COUNTRY;</p>
				<p style="MARGIN: 0px">                r.Currency = c.NAME;</p>
				<p style="MARGIN: 0px">                r.Measure = c.QUANTITY;</p>
				<p style="MARGIN: 0px">                r.Code = c.SHORT_NAME;</p>
				<p style="MARGIN: 0px">                <span style="COLOR: blue">switch</span> (<span style="COLOR: blue">this</span>.OfferType) {</p>
				<p style="MARGIN: 0px">                    <span style="COLOR: blue">case</span> <span style="COLOR: #2b91af">OfferTypes</span>.Nakup:</p>
				<p style="MARGIN: 0px">                        r.Rate = (<span style="COLOR: blue">decimal</span>)rv.BUY;</p>
				<p style="MARGIN: 0px">                        <span style="COLOR: blue">break</span>;</p>
				<p style="MARGIN: 0px">                    <span style="COLOR: blue">case</span> <span style="COLOR: #2b91af">OfferTypes</span>.Prodej:</p>
				<p style="MARGIN: 0px">                        r.Rate = (<span style="COLOR: blue">decimal</span>)rv.SEL;</p>
				<p style="MARGIN: 0px">                        <span style="COLOR: blue">break</span>;</p>
				<p style="MARGIN: 0px">                    <span style="COLOR: blue">case</span> <span style="COLOR: #2b91af">OfferTypes</span>.Stred:</p>
				<p style="MARGIN: 0px">                        r.Rate = (<span style="COLOR: blue">decimal</span>)rv.MID;</p>
				<p style="MARGIN: 0px">                        <span style="COLOR: blue">break</span>;</p>
				<p style="MARGIN: 0px">                    <span style="COLOR: blue">default</span>:</p>
				<p style="MARGIN: 0px">                        <span style="COLOR: blue">break</span>;</p>
				<p style="MARGIN: 0px">                }</p>
				<p style="MARGIN: 0px">                <span style="COLOR: blue">this</span>.exchangeRates.Add(r);</p>
				<p style="MARGIN: 0px">            }</p>
				<p style="MARGIN: 0px">        }</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">public</span> <span style="COLOR: #2b91af">DateTime</span> Date {</p>
				<p style="MARGIN: 0px">            <span style="COLOR: blue">get</span> { <span style="COLOR: blue">return</span> <span style="COLOR: blue">this</span>.date; }</p>
				<p style="MARGIN: 0px">        }</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">public</span> <span style="COLOR: #2b91af">ExchangeRateCollection</span> ExchangeRates {</p>
				<p style="MARGIN: 0px">            <span style="COLOR: blue">get</span> { <span style="COLOR: blue">return</span> <span style="COLOR: blue">this</span>.exchangeRates; }</p>
				<p style="MARGIN: 0px">        }</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">public</span> <span style="COLOR: blue">string</span> Name {</p>
				<p style="MARGIN: 0px">            <span style="COLOR: blue">get</span> { <span style="COLOR: blue">return</span> <span style="COLOR: #a31515">"Česká spořitelna"</span>; }</p>
				<p style="MARGIN: 0px">        }</p>
				<p style="MARGIN: 0px">    }</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">}</p>
		</div>
		<p>
				<!--EndFragment-->Třída předpokládá, že do svého projektu přidáte web referenci na adresu <a href="http://www.csas.cz/csws/changerates/ChangeRates.jws?WSDL">http://www.csas.cz/csws/changerates/ChangeRates.jws?WSDL</a> a pojmenujete ji <em>CsasExchange</em>.</p>
