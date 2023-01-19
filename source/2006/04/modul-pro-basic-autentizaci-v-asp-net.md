<!-- dcterms:identifier = aspnetcz#84 -->
<!-- dcterms:title = Modul pro 'basic' autentizaci v ASP.NET -->
<!-- dcterms:abstract = Nativní HTTP autentizace (Basic Authentication) se v internetových aplikacích ASP.NET moc neuchytila, protože její přirozená implementace v IIS je vázána na systémové účty. Napsal jsem nicméně autentizační modul, který umožňuje Basic autentizaci používat v ASP.NET proti libovolnému membership providerovi, tedy např. proti SQL databázi. Řešení je zcela kompatibilní se všemi částmi ASP.NET infrastruktury. -->
<!-- np9:categoryId = 2 -->
<!-- x4w:category = Bezpečnost -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2006-04-04T13:23:36.07+02:00 -->
<!-- dcterms:date = 2006-04-04T13:23:36.07+02:00 -->


		<h2>Jak funguje 'basic authentication'</h2>
		<p>Metoda 'basic' je nejstarší a nejjednodušší metoda HTTP autentizace. Je přímo součástí HTTP protokolu a podporují ji všechny prohlížeče, proxy servery a podobně. Není tedy třeba podpora cookies a podobně. Pokud se pokusíte přistoupit na nějakou stránku chráněnou "basic" autentizací, zobrazí vám prohlížeč systémový dialog pro zadání jména a hesla - celá autentizace se tak děje zcela v jeho režii, vaše aplikace pro ni nevytváří žádné GUI.</p>
		<p>Technicky vzato funguje HTTP autentizace následovně.</p>
		<ol>
				<li>Klient se pokusí přistoupit na zabezpečenou stránku.</li>
				<li>Server odpoví chybovým kódem <code>401 Access Denied</code> a do odpovědi přidá hlavičku <code>WWW-Authenticate: Basic Realm="Název aplikace"</code>.</li>
				<li>Klient si od uživatele vyžádá jméno a heslo a pokus opakuje. Tentokráte ale přidá do požadavku hlavičku <code>Authorize: Basic <strong>username:password</strong></code>. Uživatelské jméno a heslo je odděleno dvojtečkou a celý tento řetězec je zakódován ve formátu Base64.</li>
				<li>Server ověří uživatelské jméno a heslo. Pokud je správné, vydá kýžený obsah. Není-li, opakuje se bod 2.</li>
		</ol>
		<p>Ze shora uvedeného vyplývají dvě hlavní nevýhody basic autentizace:</p>
		<ul>
				<li>S každým požadavkem na zabezpečenou stránku je zasíláno uživatelské jméno a heslo v nezašifrovaném tvaru (Base64 je přenosové kódování, nikoliv šifra). To představuje bezpečností riziko, a proto je obecně vhodné používat tuto formu autentizace pouze na šifrovaném kanále (na webu zabezpečeném pomocí HTTPS).</li>
				<li>Přihlášení je nutno si vynutit. Pokud o něj server explicitně nepožádá, klient mu ho nepošle. Není tedy možno vytvořit jednu stránku, která bude zobrazovat jiný obsah pro přihlášeného a jiný pro anonymního uživatele.</li>
		</ul>
		<h2>Implementace v ASP.NET</h2>
		<p>V prostředí internetových aplikací na platformě Windows se tato forma autentizace moc neuchytila. Hlavním důvodem je podle mého soudu skutečnost, že pomocí standardně dostupných prostředků je možno ověřovat se pouze proti systémovým účtům (uživatelům ve Windows nebo Active Directory), nikoliv např. proti vlastní databázi uživatelů.</p>
		<p>Je ale možné jednoduše napsat autentizační modul, který bude basic autentizaci podporovat. Technicky vzato se jedná o třídu implementující rozhraní <em>System.Web.IHttpModule</em> a obsluhující události <em>OnAuthenticateRequest</em> a <em>OnEndRequest</em>.</p>
		<p>Je důležité si uvědomit, že je nutné vypnout všechny ostatní formy autentizace. Tj. v Internet Information Services u webu povolit pouze anonymní přístup (jinak by se o ověřování snažilo IISko samo) a v konfiguraci ASP.NET (<em>web.config</em>) nastavit <em>/configuration/system.web/authentication/@mode</em> na hodnotu <em>None</em>.</p>
		<h2>Proof-of-concept</h2>
		<p>Vyzkoušíme si, zda popsaná metoda úspěšně funguje, níže najdete proof-of-concept kód, který vyžaduje uživatelské jméno <em>user</em> a heslo <em>password</em>. Protentokrát je napsaný v C#, aby se mi zase na VSNET-L nepošklebovali ;-)</p>
		<pre class="sh-code-cs">				<p>using System;<br>using System.Web;</p>
				<p>public class BasicPOC: IHttpModule {</p>
				<p>    public void Dispose() {<br>        // Nothing to dispose<br>    }</p>
				<p>    public void Init(HttpApplication application) {<br>        // Attach event handlers<br>        application.AuthenticateRequest += new EventHandler(this.OnAuthenticateRequest);<br>        application.EndRequest += new EventHandler(this.OnEndRequest);<br>    }</p>
				<p>    public void OnAuthenticateRequest(object source, EventArgs eventArgs) {<br>        HttpApplication Application = (HttpApplication)source;</p>
				<p>        // Get authentication data<br>        string AuthString = Application.Request.Headers["Authorization"];<br>        if (String.IsNullOrEmpty(AuthString)) return; // anonymous request<br>        if (!AuthString.StartsWith("Basic", StringComparison.InvariantCultureIgnoreCase)) return; // not basic auth</p>
				<p>        // Get username and password<br>        string UserName, Password;<br>        try {<br>            AuthString = System.Text.Encoding.UTF8.GetString(System.Convert.FromBase64String(AuthString.Substring(6)));<br>            string[] AuthData = AuthString.Split(new char[] { ':' }, 2);<br>            UserName = AuthData[0];<br>            Password = AuthData[1];<br>        }<br>        catch (Exception ex) {<br>            throw new System.Security.SecurityException("Invalid format of 'Authorization' HTTP header.", ex);<br>        }</p>
				<p>        // Validate user against currently configured membership provider<br>        if (UserName == "user" &amp;&amp; Password == "password") {<br>            // Success<br>            Application.Context.User = new System.Security.Principal.GenericPrincipal(new System.Security.Principal.GenericIdentity(UserName), new string[0]);<br>        }<br>        else {<br>            // Failure<br>            Application.Response.StatusCode = 401;<br>            Application.Response.StatusDescription = "Access Denied";<br>            Application.Response.Write("&lt;html&gt;\n&lt;head&gt;&lt;title&gt;401 Access Denied&lt;/title&gt;&lt;/head&gt;\n&lt;body&gt;&lt;h1&gt;401 Access Denied&lt;/h1&gt;&lt;/body&gt;\n&lt;/html&gt;");<br>            Application.CompleteRequest();<br>            return;<br>        }<br>    }</p>
				<p>    public void OnEndRequest(object source, EventArgs eventArgs) {<br>        // Add WWW-Authenticate header if access denied<br>        HttpApplication Application = (HttpApplication)source;<br>        if (Application.Response.StatusCode == 401) Application.Response.AppendHeader("WWW-Authenticate", "Basic Realm=\"Moje aplikace\"");<br>    }<br>}</p>
		</pre>
		<p>Bližší popis fungování HTTP modulů najdete v článku <a href="https://www.aspnet.cz/Articles/13-http-moduly-prakticky.aspx">HTTP moduly prakticky</a>. Veškerou špinavou práci dělají metody <em>OnAuthenticateRequest</em> a <em>OnEndRequest</em>. </p>
		<p>První jmenovaná dekóduje a ověří HTTP hlavičku <em>Authorization</em>, pokud je přítomna. Povšimněte si prosím, že v případě, že přítomna není (uživatel je anonymní) nic nedělá (nevrací žádnou chybu nebo stavový kód <em>401 Access Denied</em>). O tom, zda se bude přihlášení vyžadovat, totiž nerozhoduje náš modul, ale autorizační modul - typicky na základě nastavení v souboru <em>web.config</em>. Jediný případ, kdy náš modul proaktivně zakazuje přístup, je když uživatel sice zadá jméno a heslo, ale chybné.</p>
		<p>Metoda <em>OnEndRequest</em> zařizuje jedinou věc: pokud je na konci zpracování požadavku nastaven stavový kód <em>401 Access Denied</em>, přidá do výstupu zmiňovanou HTTP hlavičku <em>WWW-Authenticate</em>. Pokud kdokoliv (náš modul, autorizační modul, jiná část aplikace...) bude pomocí tohoto kódu vyžadovat přihlášení, bude k němu uživatel vyzván.</p>
		<p>Pomocí následujícího nastavení v souboru <em>web.config</em> modul aktivujeme a zároveň zakážeme do celé aplikace přístup anonymním uživatelům, takže se vynutí přihlášení:</p>
		<pre class="sh-code-xml">&lt;?xml version="1.0"?&gt;<br>&lt;configuration&gt;<br>  &lt;system.web&gt;<br>    &lt;httpModules&gt;<br>      &lt;add name="BasicPOC" type="BasicPOC" /&gt;<br>    &lt;/httpModules&gt;<br>    &lt;compilation debug="true" /&gt;<br>    &lt;authentication mode="None" /&gt;<br>    &lt;authorization&gt;<br>      &lt;deny users="?"/&gt;<br>    &lt;/authorization&gt;<br>  &lt;/system.web&gt;<br>&lt;/configuration&gt;</pre>
		<h2>Plná implementace</h2>
		<p>Mým cílem je vytvořit univerzální modul, který bude možno snadno nasadit a integrovat ho se strukturou membership providerů v ASP.NET a podobně. Zároveň chci, aby byl konfigurovatelný <em>Realm</em> a obsah stránky, která se zobrazí v případě chybného přihlášení.</p>
		<p>Vytvořil jsem proto následující strukturu tříd:</p>
		<p style="TEXT-ALIGN: center">
				<img width="475" height="318" alt="Class diagram" src="https://www.cdn.altairis.cz/Blog/2006/20060404-BasicAuthClasses.gif"> </p>
		<ul>
				<li>
						<strong>Altairis.Web.Security.BasicAuthentication.HttpModule</strong> je výše zmíněný autentizační modul. Jeho kód se změni jenom nepatrně: místo napevno zakódovaného jména a hesla volám metodu <em>Memebrship.ValidateUser()</em>, která mi ověří jméno a heslo proti aktivnímu membership providerovi. A místo pevně určeného názvu realmu a tetxu chybové stránky tyto hodnoty načítám z konfigurace.</li>
				<li>
						<strong>Altairis.Web.Security.BasicAuthentication.ConfigurationSectionHandler</strong> je handler konfigurační sekce, který mi umožní přidat si do souboru <em>web.config</em> vlastní konfigurační parametry. Podrobnější popis najdete v článku <a href="https://www.aspnet.cz/Articles/9-vytvoreni-vlastni-konfiguracni-sekce-ve-web-config.aspx">Vytvoření vlastní konfigurační sekce ve Web.Config</a>.</li>
				<li>
						<strong>Altairis.Web.Security.BasicAuthentication.ConfigurationSettings</strong> je strukura, která uchovává konfigurační informace a spolupracuje s předchozí třídou.</li>
		</ul>
		<h2>Odkazy a kód ke stažení</h2>
		<ul>
				<li>
						<a href="https://www.cdn.altairis.cz/Blog/2006/20060404-BasicAuthentication.zip">Zdrojové kódy</a> </li>
				<li>
						<a href="http://www.ietf.org/rfc/rfc2617.txt">RFC 2617: HTTP Authentication: Basic and Digest Access Authentication</a> </li>
				<li>UserLand Frontier: <a href="http://frontier.userland.com/stories/storyReader$2159">HTTP Authentication Schemes</a></li>
		</ul>
