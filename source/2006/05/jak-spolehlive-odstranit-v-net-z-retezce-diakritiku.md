<!-- dcterms:identifier = aspnetcz#92 -->
<!-- dcterms:title = Jak spolehlivě odstranit v .NET z řetězce diakritiku -->
<!-- dcterms:abstract = V praxi často nastává situace, kdy je třeba z nějakého textu odstranit písmenka s háčky a čárkami. A to pokud možno tak, aby se tato písmena neztratila, ale byla převedena na "neokrášlené" ekvivalenty, aby text zůstal i nadále čitelný. Nabízíme vám řešení tohoto úkolu, který je složitější, než na první pohled vypadá. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = IT -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2006-05-10T23:32:05.487+02:00 -->
<!-- dcterms:dateAccepted = 2006-05-10T23:32:05.487+02:00 -->


		<p>Již léta opakuji, kdykoliv přijde řeč na česká "nabodeníčka", že Jana Husa upálili po právu a bohužel pozdě. Historicky se většina pokroku v počítačových technologiích odehrávala v anglosaských zemích. Národy, mající ve zvyku okrašlovat nudná písmenka háčky, čárkami, ocásky a podobně jsou tedy v řadě případů poněkud diskriminovány.</p>
		<p>V praxi často nastává situace, kdy je třeba z nějakého textu odstranit písmenka s háčky a čárkami. A to pokud možno tak, aby se tato písmena neztratila, ale byla převedena na "neokrášlené" ekvivalenty, aby text zůstal i nadále čitelný. Řešení tohoto úkolu je složitější, než na první pohled vypadá.</p>
		<p>První co většinu programátorů napadne, je vytvořit seznam písmen s diakritikou a jemu odpovídajících písmen bez háčků a čárek. Toto řešení není zcela špatné - a ve verzích 1.x je pokud vím jediné možné. Záludnost tohoto řešení spočívá v tom, že onen seznam písmen zpravidla vzniká tak, že se programátor hluboce zamyslí a napíše něco jako <em>"äáčďéěëíňóöřšťůúüýž"</em>. Jenomže rozličnými přívěsky okrášlených písmenek je mnohem víc, než si většina z nás myslí. Stačí se podívat na Slovensko a písmenka jako <em>Ľ</em> nebo <em>Ĺ</em>.</p>
		<p>Naštěstí pro nás umí .NET ve verzi 2.0 pracovat s takzvanými Unicode kategoriemi. Unicode je sada norem, které si vzaly za cíl učinit počítače použitelnými pro včechny jazyky a definitivně zlomit prokletí původně osmibitové znakové sady.</p>
		<p>Jedním z prostředků je zakódování textu tak, že se oddělí "mateřské" písmeno a jeho modifikátor. Je to trochu jako když jste na starém mechanickém psacím stroji chtěli napsat velké písmeno s háčkem: nejdříve jste na papíře vytvořili háček a pak pod něj dodali písmenko. A přesně této funkce nyní využijeme:</p>
		<div style="FONT-SIZE: 10pt; BACKGROUND: white; COLOR: black; FONT-FAMILY: 'Courier New', monospace">
				<p style="MARGIN: 0px">
						<span style="COLOR: green">// using System.Globalization</span>
				</p>
				<p style="MARGIN: 0px">
						<span style="COLOR: blue">public</span> <span style="COLOR: blue">static</span> <span style="COLOR: blue">string</span> RemoveDiacritics(<span style="COLOR: blue">string</span> s) {</p>
				<p style="MARGIN: 0px">    s = s.Normalize(NormalizationForm.FormD);</p>
				<p style="MARGIN: 0px">    StringBuilder sb = <span style="COLOR: blue">new</span> StringBuilder();</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">    <span style="COLOR: blue">for</span> (<span style="COLOR: blue">int</span> i = 0; i &lt; s.Length; i++) {</p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">if</span> (<span style="COLOR: teal">CharUnicodeInfo</span>.GetUnicodeCategory(s[i]) != <span style="COLOR: teal">UnicodeCategory</span>.NonSpacingMark) sb.Append(s[i]);</p>
				<p style="MARGIN: 0px">    }</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">    <span style="COLOR: blue">return</span> sb.ToString();</p>
				<p style="MARGIN: 0px">}</p>
		</div>
		<p>Pomocí metody <em>Normalize</em> převedeme náš řetězec právě do shora popsané podoby. Následně pak projdeme všechny znaky v řetězci a ponecháme si pro další použití jenom ty, které nejsou typu <em>NonSpacingMark</em>, což jsou právě naše nabodeníčka. V závislosti na požadované aplikaci lze samozřejmě konkrétně určit, jaké že <a title="Seznam kategorií znaků na webu Unicode.org" href="http://www.unicode.org/Public/UNIDATA/UCD.html#General_Category_Values">Unicode kategorie</a> mají být odstraněny či zachovány.</p>
