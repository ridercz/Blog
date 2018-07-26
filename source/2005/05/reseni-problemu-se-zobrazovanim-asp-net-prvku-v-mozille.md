<!-- dcterms:identifier = aspnetcz#37 -->
<!-- dcterms:title = Řešení problémů se zobrazováním ASP.NET prvků v Mozille -->
<!-- dcterms:abstract = Tzv. adaptivní renderování představené v ASP.NET jest idea teoreticky dobrá, v praxi spíše škodlivá. Ukážeme si, jak ji využít v náš prospěch. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = IT -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2005-05-05T14:42:07.37+02:00 -->
<!-- dcterms:dateAccepted = 2005-05-05T14:42:07.37+02:00 -->

<p __designer:dtid="281474976710658">ASP.NET představily technologii <em __designer:dtid="281474976710659">adaptivn&#237;ho renderov&#225;n&#237;</em>. Jedn&#225; se v z&#225;sadě o to, že si runtime zjist&#237;, kter&#253; browser uživatel použ&#237;v&#225; a podle toho uprav&#237; generovan&#253; k&#243;d. Což o to, my&#353;lenka je to dobr&#225;, ale poněkud zpozdil&#225;. Tato funkce by se hodila v době, kdy nezanedbateln&#225; č&#225;st uživatelů použ&#237;vala př&#237;&#353;ern&#253; bazmek jm&#233;nem <em __designer:dtid="281474976710660">Netscape Communicator</em>. </p>
<p __designer:dtid="281474976710661">Teď je sp&#237;&#353; pro zlost, neboť ve standardn&#237;m nastaven&#237; nepozn&#225; Mozillu jako "advanced browser". Takže nab&#253;v&#225; dojmu, že nepodporuje CSS a podobně a pos&#237;l&#225; mu jin&#253; k&#243;d, než IE, č&#237;mž &#250;spě&#353;ně rozhod&#237; zobrazen&#237;.</p>
<h2 __designer:dtid="281474976710662">Ře&#353;en&#237; hrubou silou</h2>
<p __designer:dtid="281474976710663">Hrubou silou lze cel&#253; shora uveden&#253; cirkus vypnout t&#237;m, že se do direktivy <span __designer:dtid="281474976710664"><code __designer:dtid="281474976710665">@Page</code></span> uvede atribut <code __designer:dtid="281474976710666">clientTarget="uplevel"</code>. T&#237;m se runtime vnut&#237; my&#353;lenka, že se v&#253;sledek m&#225; renderovat pro "pokročil&#233;" prohl&#237;žeče, bez ohledu na to, co klient použ&#237;v&#225;.</p>
<h2 __designer:dtid="281474976710667">Ře&#353;en&#237; učen&#237;m</h2>
<p __designer:dtid="281474976710668">Cel&#253; komplikovan&#253; proces adaptivn&#237;ho renderingu je z&#225;visl&#253; na technologii <em __designer:dtid="281474976710669">browser capabilities</em>. Ta funguje tak, že identifikuje klienta a podle vlastn&#237; datab&#225;ze schopnost&#237; jednotliv&#253;ch zař&#237;zen&#237; urč&#237;, kter&#233; technologie podporuje a kter&#233; ne. Bliž&#353;&#237; informace najdete např&#237;klad na str&#225;nk&#225;ch společnosti <a href="http://www.cyscape.com/browsercaps/" __designer:dtid="281474976710670">Cyscape</a>.</p>
<p __designer:dtid="281474976710671">Tato datab&#225;ze je samozřejmě uživatelsky modifikovateln&#225;. Přislu&#353;n&#225; pravidla najdete v souboru <em __designer:dtid="281474976710672">machine.config</em> v sekci <code __designer:dtid="281474976710673">&lt;browserCaps&gt;</code>. Jedn&#225; se o standardn&#237; souč&#225;st .NET konfigurace. V r&#225;mci autora jedn&#233; aplikace tedy můžete probl&#233;m s Mozillou vyře&#353;it t&#237;m, že do sekce <code __designer:dtid="281474976710674">/configuration/system.web</code> souboru <em __designer:dtid="281474976710675">web.config</em> přid&#225;te n&#225;sleduj&#237;c&#237;:</p><pre class="sh-code-xml" __designer:dtid="281474976710676">&lt;browserCaps&gt;
	&lt;case match="Gecko/[-\d]+"&gt;
		browser=Netscape
		frames=true
		tables=true
		cookies=true
		javascript=true
		javaapplets=true
		ecmascriptversion=1.5
		w3cdomversion=1.0
		css1=true
		css2=true
		xml=true
		tagwriter=System.Web.UI.HtmlTextWriter
		&lt;case match="rv:1.0[^\.](?'letters'\w*)"&gt;
			version=6.0
			majorversion=6
			minorversion=0
			&lt;case match="^b" with="${letters}"&gt;
				beta=true
			&lt;/case&gt;&lt;/case&gt;&lt;case match="rv:1(\.\d+)(\.\d)?(?'letters'\w*)"&gt;
			version=7.0
			majorversion=7
			minorversion=0
			&lt;case match="^b" with="${letters}"&gt;
				beta=true
			&lt;/case&gt;&lt;/case&gt;&lt;/case&gt;
&lt;/browserCaps&gt;</pre>