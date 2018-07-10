<!-- dcterms:identifier = aspnetcz#81 -->
<!-- dcterms:title = Jak přiřadit tisková CSS pravidla stránce používající ASP.NET Themes? -->
<!-- dcterms:abstract = Mezi uživateli jsou i tací, kdo prahnou po tom, aby si mohli webové stránky tisknout. Nabídnout jim tiskovou verzi stránky je s použitím Themes poněkud komplikovanější, než předtím - není to nicméně nemožné. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Programování -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2006-03-14T20:47:06.903+01:00 -->
<!-- dcterms:dateAccepted = 2006-03-14T20:47:06.903+01:00 -->


		<p>Mezi uživateli jsou i tací, kdo prahnou po tom, aby si mohli webové stránky tisknout. A papír je médium s trochu jinou podstatou, než web a tisková verze stránky s tím musí počítat. Měla by se soustředit na to, co uživatel pravděpodobně chce vytisknout (např. text článku) a zanedbat věci, které vytištěné na papíře nemají smysl, například navigaci. Neměla by rovněž hýřit barvami. Dnes je sice barevný tisk podstatně dostupnější, než před lety, ale stále je tisk barevné stránky pomalejíší a nákladnější, než tisk černobílý.</p>
		<p>Lze vysledovat dva rozdílné přístupy, kterak tento problém řešit. První spočívá v tom, že se vytvoří zvláštní tisková verze stránky a z hlavní se na ni uvede v textu odkaz. Toto řešení osobně nepokládám za šťastné, protože znamená, že místo klepnutí na tlačítko "tiskni", které mám v prohlížeči stále na stejném místě, musím vědět, že takovou možnost tento tvůrce do stránky zahrnul a zjistit, jak se aktivuje.</p>
		<p>Druhý způsob využívá toho, že standard CSS umožňuje aplikovat různá pravidla pro různé způsoby zpracování - obrazovku, tisk, projekci atd. Jak už to u vznešených myšlenek bývá, z původně široce koncipovaného řešení bylo implementováno minimum, ale všechny dnes prakticky používané prohlížeče zvládají styly pro obrazovku (screeen) a tisk (print).</p>
		<p>Pokud se na soubory se styly odkazujeme přímo, je řešení jednoduché. Stačí do hlavičky zapsat cosi v duchu:</p>
		<pre class="sh-code-css">&lt;link rel="stylesheet" type="text/css" media="screen" href="screen.css" /&gt;<br>&lt;link rel="stylesheet" type="text/css" media="print" href="print.css" /&gt;	</pre>
		<p>Drobný problém nastane v okamžiku, kdy pro přiřazování stylů používáme novinku v ASP.NET 2.0: Themes. V takovém případě se odkazy na CSS soubory v hlavičce generují automaticky a nelze jednoduše určit, jaký soubor lze použít pro které médium.</p>
		<p>Naštěstí lze tuto výhybku realizovat i čistě v CSS pomocí direktivy <code>@media</code> následujícím způsobem:</p>
		<pre class="sh-code-css">@media screen {<br>  /* pravidla pro obrazovku */<br>  BODY { background-color: #cccccc; color: #333333; }<br>}<br><br><br>@media print {<br>  /* pravidla pro tisk */<br>  BODY { background-color: #ffffff; color: #000000; }<br>}</pre>
		<p>Pravidla můžete umístit do jednoho souboru a nebo do několika, jak je vám libo.</p>
