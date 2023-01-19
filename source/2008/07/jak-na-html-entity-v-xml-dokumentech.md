<!-- dcterms:identifier = aspnetcz#205 -->
<!-- dcterms:title = Jak na HTML entity v XML dokumentech -->
<!-- dcterms:abstract = Všechny jazyky založené na SGML (zejména tedy HTML a XML) využívají k zápisu specifických, jinak obtížně definovatelných znaků, takzvané entity. Ty jsou v zásadě dvojího druhu: buďto se odkazují symbolickým jménem na určitý znak a nebo obsahují číselnou specifikaci dle normy ASCII či UNICODE. Z hlediska uživatele jsou samozřejmě nejjednodušší entity se symbolickým jménem. Ty ale XML nativně nepodporuje a je nutno použít speciální trik. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = IT -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2008-07-28T07:00:00+02:00 -->
<!-- dcterms:date = 2008-07-28T07:00:00+02:00 -->

<p>Všechny jazyky založené na SGML (zejména tedy HTML a XML) využívají k zápisu specifických, jinak obtížně definovatelných znaků, takzvané entity. Ty jsou v zásadě dvojího druhu: buďto se odkazují symbolickým jménem na určitý znak a nebo obsahují číselnou specifikaci dle normy ASCII či UNICODE.</p>
<p>Například znak pro copyright - © - lze entitou zapsat třemi způsoby:</p>
<ul>
    <li><code>&amp;copy;</code> – symbolické jméno </li>
    <li><code>&amp;#169;</code> – ASCII/UNICODE desítkově </li>
    <li><code>&amp;#x00A9;</code> – ASCII/UNICODE šestnáctkově </li>
</ul>
<p>Z hlediska uživatele je samozřejmě nejpříjemnější první varianta, tedy použití symbolického jména a konstrukcí jako například: </p>
<ul>
    <li><code>&amp;lt; &amp;gt; &amp;amp; &amp;quot; &amp;apos;</code> – &lt; &gt; &amp; “ ‘ </li>
    <li><code>&amp;nbsp;</code> - pevná mezera </li>
    <li><code>&amp;copy; &amp;reg; &amp;trade;</code> - © ® ™ </li>
    <li><code>&amp;laquo; &amp;raquo;</code> - « » </li>
    <li><code>&amp;deg; &amp;prime; &amp;Prime;</code> - ° ' ” </li>
    <li><code>&amp;frac12; &amp;frac14; &amp;frac34;</code> - 1 1 3 </li>
</ul>
<p>Kompletní seznam najdete například na <a href="http://en.wikipedia.org/wiki/List_of_XML_and_HTML_character_entity_references">Wikipedii</a>.</p>
<h2>Problém s XML</h2>
<p>Všechny shora uvedené formy zápisu vám budou bez problémů fungovat v HTML nebo XHTML dokumentu. V prostém XML však nikoliv. Pro XML jsou definovány pouze numerické entity (zapsané desítkově či šestnáctkově) a pětice entit pro speciální znaky: <code>&amp;lt; &amp;gt; &amp;amp; &amp;quot; &amp;apos;</code></p>
<p>Často ale chcete, aby součástí XML dokumentu byly i jiné entity. Patrně nejtypičtějším případem je entita <code>&amp;nbsp;</code>, která se nám bude hodit v případě psaní XSLT šablon pro konverzi XML do HTML.</p>
<p>Naivní (a nefunkční) zápis vypadá takto:</p>
<div style="font-size: 10pt; background: white; color: black; font-family: consolas, monospace">
<p style="margin: 0px"><span style="color: #0000ff">&lt;?</span><span style="color: #a31515">xml</span><span style="color: #0000ff"> </span><span style="color: #ff0000">version</span><span style="color: #0000ff">=</span>"<span style="color: #0000ff">1.0</span>"<span style="color: #0000ff"> </span><span style="color: #ff0000">encoding</span><span style="color: #0000ff">=</span>"<span style="color: #0000ff">utf-8</span>"<span style="color: #0000ff"> ?&gt;</span></p>
<p style="margin: 0px"><span style="color: #0000ff">&lt;</span><span style="color: #a31515">root</span><span style="color: #0000ff">&gt;</span><span style="color: #ff0000">&amp;nbsp;</span><span style="color: #0000ff">&lt;/</span><span style="color: #a31515">root</span><span style="color: #0000ff">&gt;</span></p>
</div>
<p>Při pokusu o zpracování XML se však potkáme s nemilou chybovou hláškou:</p>
<p style="text-align: center"><img width="507" height="320" style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" title="20080728-xml-bad" border="0" alt="20080728-xml-bad" src="https://www.cdn.altairis.cz/Blog/2008/20080728-20080728-xml-bad_6.png"></p>
<p>Entity můžeme v XML deklarovat i sami tak, že je zapíšeme pomocí něčeno, co XML už zná – pomocí numerických kódů. Druhý pokus využívá konstrukt <code>!ENTITY</code> a vypadá takto (<code>root</code> ve specifikaci DOCTYPE je název kořenového elementu, pokud se váš bude jmenovat jinak, je nutno ho změnit i zde):</p>
<div style="font-size: 10pt; background: white; color: black; font-family: consolas, monospace">
<p style="margin: 0px"><span style="color: #0000ff">&lt;?</span><span style="color: #a31515">xml</span><span style="color: #0000ff"> </span><span style="color: #ff0000">version</span><span style="color: #0000ff">=</span>"<span style="color: #0000ff">1.0</span>"<span style="color: #0000ff"> </span><span style="color: #ff0000">encoding</span><span style="color: #0000ff">=</span>"<span style="color: #0000ff">utf-8</span>"<span style="color: #0000ff"> ?&gt;</span></p>
<p style="margin: 0px"><span style="color: #0000ff">&lt;!</span><span style="color: #a31515">DOCTYPE</span><span style="color: #0000ff"> </span><span style="color: #ff0000">root</span><span style="color: #0000ff"> [</span></p>
<p style="margin: 0px"><span style="color: #0000ff">    &lt;!</span><span style="color: #a31515">ENTITY</span><span style="color: #0000ff"> </span><span style="color: #ff0000">nbsp</span><span style="color: #0000ff"> </span>"<span style="color: #ff0000">&amp;#160;</span>"<span style="color: #0000ff">&gt;</span></p>
<p style="margin: 0px"><span style="color: #0000ff">]&gt;</span></p>
<p style="margin: 0px"><span style="color: #0000ff">&lt;</span><span style="color: #a31515">root</span><span style="color: #0000ff">&gt;</span><span style="color: #ff0000">&amp;nbsp;</span><span style="color: #0000ff">&lt;/</span><span style="color: #a31515">root</span><span style="color: #0000ff">&gt;</span></p>
</div>
<p>&nbsp;</p>
<p>Tento zápis vyhoví, pokud je entit málo. Zapisovat takto všechny entity definované pro HTML v každém XML dokumentu by bylo poněkud nepraktické. S výhodou lze využít funkce DOCTYPE, která umožňuje odkaz na externí specifikaci. V našem případě se prostě odkážeme na specifikaci XHTML a seznam entit si vypůjčíme odtud:</p>
<div style="font-size: 10pt; background: white; color: black; font-family: consolas, monospace">
<p style="margin: 0px"><span style="color: #0000ff">&lt;?</span><span style="color: #a31515">xml</span><span style="color: #0000ff"> </span><span style="color: #ff0000">version</span><span style="color: #0000ff">=</span>"<span style="color: #0000ff">1.0</span>"<span style="color: #0000ff"> </span><span style="color: #ff0000">encoding</span><span style="color: #0000ff">=</span>"<span style="color: #0000ff">utf-8</span>"<span style="color: #0000ff"> ?&gt;</span></p>
<p style="margin: 0px"><span style="color: #0000ff">&lt;!</span><span style="color: #a31515">DOCTYPE</span><span style="color: #0000ff"> </span><span style="color: #ff0000">root</span><span style="color: #0000ff"> [</span></p>
<p style="margin: 0px"><span style="color: #0000ff">    &lt;!</span><span style="color: #a31515">ENTITY</span><span style="color: #0000ff"> </span>%<span style="color: #0000ff"> </span><span style="color: #ff0000">HTMLlat1</span><span style="color: #0000ff">    PUBLIC </span>"<span style="color: #0000ff">-//W3C//ENTITIES Latin 1 for XHTML//EN</span>"</p>
<p style="margin: 0px"><span style="color: #0000ff">                           </span>"<span style="color: #0000ff">http://www.w3.org/TR/xhtml1/DTD/xhtml-lat1.ent</span>"<span style="color: #0000ff">&gt;</span></p>
<p style="margin: 0px">    <span style="color: #0000ff">&lt;!</span><span style="color: #a31515">ENTITY</span><span style="color: #0000ff"> </span>%<span style="color: #0000ff"> </span><span style="color: #ff0000">HTMLspecial</span><span style="color: #0000ff"> PUBLIC </span>"<span style="color: #0000ff">-//W3C//ENTITIES Special for XHTML//EN</span>"</p>
<p style="margin: 0px"><span style="color: #0000ff">                           </span>"<span style="color: #0000ff">http://www.w3.org/TR/xhtml1/DTD/xhtml-special.ent</span>"<span style="color: #0000ff">&gt;</span></p>
<p style="margin: 0px">    <span style="color: #0000ff">&lt;!</span><span style="color: #a31515">ENTITY</span><span style="color: #0000ff"> </span>%<span style="color: #0000ff"> </span><span style="color: #ff0000">HTMLsymbol</span><span style="color: #0000ff">  PUBLIC </span>"<span style="color: #0000ff">-//W3C//ENTITIES Symbols for XHTML//EN</span>"<span style="color: #0000ff"> </span></p>
<p style="margin: 0px"><span style="color: #0000ff">                           </span>"<span style="color: #0000ff">http://www.w3.org/TR/xhtml1/DTD/xhtml-symbol.ent</span>"<span style="color: #0000ff">&gt;</span></p>
<p style="margin: 0px">    %HTMLlat1;%HTMLspecial;%HTMLsymbol;</p>
<p style="margin: 0px"><span style="color: #0000ff">]&gt;</span></p>
<p style="margin: 0px"><span style="color: #0000ff">&lt;</span><span style="color: #a31515">root</span><span style="color: #0000ff">&gt;</span><span style="color: #ff0000">&amp;nbsp;</span><span style="color: #0000ff"> </span><span style="color: #ff0000">&amp;copy;</span><span style="color: #0000ff">&lt;/</span><span style="color: #a31515">root</span><span style="color: #0000ff">&gt;</span></p>
</div>
<p>Posledně uvedenou konstrukci stačí vložit na začátek každého XML dokumentu, v němž chcete používat HTML entity a máte vystaráno.</p>
