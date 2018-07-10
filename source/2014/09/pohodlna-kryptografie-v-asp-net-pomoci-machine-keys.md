<!-- dcterms:identifier = aspnetcz#5427 -->
<!-- dcterms:title = Pohodlná kryptografie v ASP.NET pomocí Machine Keys -->
<!-- dcterms:abstract = Vytvořit funkční a bezpečný kryptosystém z kryptografických primitiv je dosti komplikované. Proto ASP.NET obsahuje možnost jak zašifrovat a digitálně podepsat data pomocí dvou jednoduchých metod, na kterých v podstatě není co zkazit. -->
<!-- np9:categoryId = 2 -->
<!-- x4w:category = Bezpečnost -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2014-09-04T17:40:57.15+02:00 -->
<!-- dcterms:dateAccepted = 2014-09-04T17:40:57+02:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20140904-pohodlna-kryptografie-v-asp-net-pomoci-machine-keys.jpg -->

<p abp="325">Vytvořit funkční a bezpečný kryptosystém z kryptografických primitiv je dosti komplikované. Proto ASP.NET obsahuje možnost jak zašifrovat a digitálně podepsat data pomocí dvou jednoduchých metod, na kterých v podstatě není co zkazit.</p>
<h2 abp="326">Co jsou machine keys</h2>
<p abp="327">ASP.NET interně využívá algoritmy pro šifrování a elektronické podepisování na řadě míst. Například pro ochranu ViewState a ControlState nebo autentizačních ticketů pro Forms Authentication. Ve výchozím nastavení platí, že se chráněná data zašifrují symetrickým algoritmem AES a poté digitálně podepíší pomocí HMACSHA256. Klíče pro šifrování a podepisování jsou ve výchozím nastavení generovány náhodně, pro každou aplikaci zvlášť.</p>
<p abp="328">V praxi je často rozumné nenechat generování klíčů na hostujícím serveru. Toto nastavení dělá neplechu při nasazení na webovou farmu nebo při migraci webu na jiný server. Pokud se klíč přegeneruje, nebudete schopni ověřit a dešifrovat nic, co bylo podepsáno a zašifrováno starým klíčem. Klíče můžete nastavit i staticky v souboru <code abp="329">web.config</code>, v sekci <code abp="330">system.web/machineKey</code> a z výše uvedených důvodů vám důrazně doporučuji tak učinit.</p>
<p abp="331">Generování klíčů není úplně triviální: klíče musí být generovány kryptograficky bezpečným pseudonáhodným generátorem, správně zakódovány a mít patřičnou délku. Abych si usnadnil život, před lety jsem na to napsal a veřejně provozuji utilitku, kterou najdete na <a href="http://chaos.aspnet.cz/" abp="332">http://chaos.aspnet.cz/</a> (její zdrojové kódy jsou ke stažení pod záložkou <em abp="333">About</em>). Proč používat tu mou, když jsou jich na světě desítky? Všechny ostatní generátory, které jsem našel (minimálně v době psaní toho mého) zastydly v roce 2005 a ASP.NET 2.0. Novější runtime 4.0 přinesl podporu kvalitnějších algoritmů a delších klíčů, které moje utilita podporuje (a jsou přednastavené jako výchozí).</p>
<h2 abp="334">Jak je jednoduše využít?</h2>
<p abp="335">Po dlouhou dobu se machine keys používaly jenom pro infrastrukturu ASP.NET a neexistovalo žádné API, které by programátorům umožnilo využívat je ve vlastním kódu. To se změnilo s příchodem verze 4.0, kdy se objevila třída <code abp="336">System.Web.Security.MachineKey</code> a její metody <code abp="337">Encode</code> a <code abp="338">Decode</code>. Ty nicméně nepoužívejte, protože při nesprávném použití mohou představovat bezpečnostní riziko – ostatně, jsou označeny jako <code abp="339">Obsolete</code>. S příchodem verze 4.5 přibyly nové a dost blbuvzdorné metody <code abp="340">Protect</code> a <code abp="341">Unprotect</code>, o nichž bude řeč v následujícím textu.</p>
<h3 abp="342">Zašifrování a podepsání dat</h3>
<p abp="343">K zašifrování a podepsání dat slouží metoda <code abp="344">Protect</code>. Ta má dva argumenty. Prvním je pole bajtů, které má "ochránit". Druhé je pole stringů, které obsahuje jedem nebo více "účelů". U těch se zastavíme podrobněji.</p>
<p abp="345">Problém se staršími metodami <code abp="346">Encode</code> a <code abp="347">Decode</code> byl v tom, že prostě vzaly data a zašifrovaly/podepsaly je prostřednictvím klíče, který byl v konfiguraci. Tentýž klíč se v aplikaci používal pro ochranu různých typů údajů. Pokud tedy útočník dokázal nechat zašifrovat jím vybraný text, bylo možné jej využít v jiné části aplikace, pro jiný účel. Metody <code abp="348">Protect</code> a <code abp="349">Unprotect</code> tedy nepoužívají přímo klíč z konfigurace, ale klíč z něj odvozený s použitím ještě nějaké další informace – kterou je právě onen "účel" (purpose). To je prostý string, na jehož obsahu příliš nezáleží, jenom musí být pro různé způsoby použití různý.</p>
<p abp="350">Metoda <code abp="351">Protect</code> pracuje s polem bajtů na vstupu a pole bajtů také vrací. Pokud tedy chcete ochránit například <code abp="352">string</code>, musíte ho převést na pole bajtů pomocí nějakého kódování (nejspíše pomocí UTF-8). Pokud vrácenou hodnotu potřebujete nějak rozumně předávat, nejspíše ji budete muset zakódovat, typicky pomocí Base64.</p>
<h3 abp="353">Dešifrování dat a ověření podpisu</h3>
<p abp="354">Obrácený postup, tedy dešifrování a ověření podpisu, má na starosti metoda <code abp="355">Unprotect</code>. Její signatura je stejná, jako u <code abp="356">Protect</code>: na vstupu dostane pole bajtů, tedy šifrovaná data, a seznam "účelů", který musí být stejný, jako ten, s nímž byla data zašifrována. Pokud operace proběhne úspěšně, vrátí původní pole bajtů.</p>
<p abp="357">Pokud se data nepodaří dešifrovat, nebo pokud selže ověření podpisu, metoda vyhodí <code abp="358">CryptographicException</code>. Pokud se tak stane, je to způsobeno typicky následujícími důvody:</p>
<ul abp="359">
    <li abp="360">S chráněnými daty bylo nějak manipulováno, tj. byl poškozen elektronický podpis. </li>
    <li abp="361">Změnily se použité klíče (buďto přímo v konfiguraci, nebo máte aplikaci nasazenou na farmě a povolené automatické generování). </li>
    <li abp="362">Předaný účel (resp. seznam účelů) pro dešifrování je jiný, než jaký byl použit pro šifrování. </li>
</ul>
<h2 abp="363">Ukázka použití</h2>
<p abp="364">Ve svých aplikacích často potřebuji ochránit řetězec a ochráněná data předávat jako součást URL. Typicky například při ověřování platnosti e-mailové adresy nebo resetu hesla. Za tímto účelem jsem si vytvořil čtyři metody, které mi s tím pomáhají.</p>
<h3 abp="365">URL-safe Base64 kódování</h3>
<p abp="366">Pro kódování binárních dat do textové podoby se vesměs používá kódování Base64. Pro práci s ním jsou v .NETu statické metody třídy <code abp="367">System.Convert</code>. Base64 abeceda nicméně obsahuje znaky "+" a "/", které jsou problematické z hlediska předávání dat v URL. Proto existuje takzvaná URL-safe varianta, kter jsou tyto znaky nahrazeny "-" a "_". Jako první jsem si tedy vytvořil pomocné metody, které provedou URL-save Base64 kódování a dekódování:</p>
<pre class="csharp" abp="368">private static string ToUrlSafeBase64String(byte[] data) {
    if (data == null) throw new ArgumentNullException("data");

    var r = Convert.ToBase64String(data);
    r = r.Replace('+', '-');
    r = r.Replace('/', '_');
    return r;
}

private static byte[] FromUrlSafeBase64String(string s) {
    if (s == null) throw new ArgumentNullException("s");
    if (string.IsNullOrWhiteSpace(s)) throw new ArgumentException("Value cannot be empty or whitespace only string.", "s");

    s = s.Replace('-', '+');
    s = s.Replace('_', '/');
    return Convert.FromBase64String(s);
}</pre>
<h3 abp="369">Práce s MachineKey</h3>
<p abp="370">Jako poslední jsem si vytvořil dvě metody, které představují jednoduchý wrapper nad metodami <code abp="371">Protect</code> a <code abp="372">Unprotect</code>. Postarají se o kódování a dekódování vstupu a výstupu:</p>
<pre class="csharp" abp="373">public static string ProtectString(string s, params string[] purposes) {
    if (s == null) throw new ArgumentNullException("s");
    if (string.IsNullOrWhiteSpace(s)) throw new ArgumentException("Value cannot be empty or whitespace only string.", "s");
    if (purposes == null) throw new ArgumentNullException("purposes");
    if (purposes.Length == 0) throw new ArgumentException("Value cannot be empty.", "purposes");
    if (purposes.Any(x =&gt; string.IsNullOrWhiteSpace(x))) throw new ArgumentException("List of porposes cannot contain null, empty or whitespace only values", "purposes");

    // Convert string to UTF-8 byte array
    var data = System.Text.Encoding.UTF8.GetBytes(s);

    // Protect with machine key
    data = MachineKey.Protect(data, purposes);

    // Return encoded
    return ToUrlSafeBase64String(data);
}

public static string UnprotectString(string s, params string[] purposes) {
    if (s == null) throw new ArgumentNullException("s");
    if (string.IsNullOrWhiteSpace(s)) throw new ArgumentException("Value cannot be empty or whitespace only string.", "s");
    if (purposes == null) throw new ArgumentNullException("purposes");
    if (purposes.Length == 0) throw new ArgumentException("Value cannot be empty.", "purposes");
    if (purposes.Any(x =&gt; string.IsNullOrWhiteSpace(x))) throw new ArgumentException("List of porposes cannot contain null, empty or whitespace only values", "purposes");

    try {
        // Try to Base64 decode value
        var data = FromUrlSafeBase64String(s);

        // Try to unprotect
        data = MachineKey.Unprotect(data, purposes);

        // Return as UTF-8 string
        return System.Text.Encoding.UTF8.GetString(data);
    }
    catch (Exception) {
        // Something failed
        return null;
    }
}</pre>
<p abp="374">Metoda <code abp="375">UnprotectString</code> funguje tak, že v případě selhání (poškozená data apod.) nevyhodí výjimku, ale vrací <code abp="376">null</code>. To obecně nebývá dobrý nápad, ale pro můj konkrétní způsob použití to smysl dává. Ve vaší vlastní implementaci zvažte, zda to platí i pro váš případ.</p>