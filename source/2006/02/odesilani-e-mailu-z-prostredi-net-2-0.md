<!-- dcterms:identifier = aspnetcz#79 -->
<!-- dcterms:title = Odesílání e-mailů z prostředí .NET 2.0 -->
<!-- dcterms:abstract = Odesílání mailů z webových aplikací je tak často kladený dotaz, že jsem mu věnoval hned třetí článek, který na tomto serveru vůbec vyšel. Vzhledem k tomu, že .NET 2.0 přináší změny i v tomto oboru, je na čase vydat jeho novelizovanou verzi. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = IT -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2006-02-27T04:16:24.957+01:00 -->
<!-- dcterms:dateAccepted = 2006-02-27T04:16:24.957+01:00 -->


		<p>Odesílání mailů z webových aplikací je tak často kladený dotaz, že jsem mu věnoval hned <a href="https://www.aspnet.cz/Articles/3-mailovani-z-asp-net-vykon-a-specialitky.aspx">třetí článek</a>, který na tomto serveru vůbec vyšel. Vzhledem k tomu, že .NET 2.0 přináší změny i v tomto oboru, je na čase vydat jeho novelizovanou verzi.</p>
		<h2>Net místo Web</h2>
		<p>Vývojáři si konečně uvědomili, že nejenom webové aplikace posílají maily a přemístili tuto funkcionalitu z namespace <code>System.Web.Mail</code> do <code>System.Net.Mail</code>. Starý zápis bude samozřejmě fungovat nadále, ale při kompilaci vám vyhodí warning. Spolu s tím souvisí přejmenování některých dalších tříd a mírná změna přístupu.</p>
		<p>Jednoduchý kód pro odeslání e-mailové zprávy tak bude vypadat takto:</p>
		<pre class="sh-code-vb">Dim Msg As New System.Net.Mail.MailMessage()<br>Msg.From = New System.Net.Mail.MailAddress("john@example.com", "John Doe")<br>Msg.To.Add(New System.Net.Mail.MailAddress("jane@example.com", "Jane Doe"))<br>Msg.Subject = "Předmět zprávy"<br>Msg.Body = "Text zprávy"<br>Dim Sender As New System.Net.Mail.SmtpClient()<br>Sender.Send(Msg)<br>Msg.Dispose()</pre>
		<p>Nová třída <code>MailAddress</code> umožňuje systemizovaně zadat kromě e-mailové adresy i zobrazované jméno (s jistotou, že se správně zakóduje). V řadě metod můžete ovšem "postaru" psát jako string jenom e-mailovou adresu.</p>
		<p>Novinka je v odesílání, které se nadále naprovádí pomocí statické třídy <code>System.Web.Mail.SmtpMail</code>, ale pomocí třídy <code>SmtpClient</code>. Název není zvolen zcela šťastně, neb tato třída umožňuje i jiné metody než pouze SMTP. Z této třídy nás bude obvykle zajímat toliko metoda <code>Send</code>. Pomocí rozličných jejích vlastností sice můžeme procedurálně nastavovat, jak že se mail má odeslat, obvykle je ale podstatně lepší činit tak konfiguračně, jak probereme vzápětí.</p>
		<p>Pozitivní je rovněž možnost přidat attachment, který neexistuje v podobě fyzického souboru. Starou třídu <code>System.Web.MailAttachment</code> bylo možno vytvořit pouze z existujícího souboru. Nová třída <code>System.Net.Mail.Attachment</code> má konstruktor s overloadem, jemuž se předává objekt typu <code>Stream</code>.</p>
		<p>Nové rozhraní obsahuje i systémovou podporu pro posílání mailů v HTML. Vzhledem k tomu, že to považuji za druhý největší programátorský hřích před tváří boží, nebudu se o tom podrobněji rozšiřovat.</p>
		<h2>Konfigurace použité metody odesílání</h2>
		<p>V předchozích verzích .NET bylo nutné veškerou konfiguraci způsobů odesílání řešit procedurálně. Nadto některé věci (jako například SMTP autentizaci) nebylo možno nativně realizovat z prostředí .NET, ale musely se pracně nastavovat skrze CDO fields, jak jsem popisoval ve <a href="https://www.aspnet.cz/Articles/3-mailovani-z-asp-net-vykon-a-specialitky.aspx">shora linkovaném článku</a>. Pouhé tři verze stačily moudrým hlavám v Redmondu k tomu, aby dospěly k poznání, že konfigurační parametry jest vhodno určovat především konfiguračně.</p>
		<p>Pročež v konfiguračním souboru přibyla možnost nastavovat rozličné parametry odesílání e-mailových zpráv. Tyto se liší podle použité metody:</p>
		<ul>
				<li>
						<strong>PickupDirectoryFromIis</strong> - použije se mail pickup service lokálního IIS. Výchozí a obvykle též preferovaná metoda. Měl jsem nicméně problémy s tím, že na některých serverech nebyl .NET schopen si konfiguraci z IIS načíst, netuším proč.</li>
				<li>
						<strong>SpecifiedPickupDirectory</strong> - vhodné pro řešení shora uvedeného případu, stejně jako pokud žádné maily ve skutečnosti odesílat nechcete. Ve druhém případě stačí nastavit jako cílový adresář něco, co čas od času promažete (a nebo prozkoumáte, abyste zjistili, proč vám aplikace dělá co jste do ní napsali a ne to, co po ní chcete).</li>
				<li>
						<strong>Network</strong> - k odeslání se použije jakýkoliv SMTP server, k němuž se aplikace připojí po síti.</li>
		</ul>
		<p>Prvně zmiňovaná možnost žádnou specifickou konfiguraci nevyžaduje. Druhá možnost prahne po jediném konfiguračním parametru, jímž je název složky, kam se mají soubory se zprávami plivat - obvykle je to <code>C:\InetPub\MailRoot\pickup</code>.</p>
		<pre class="sh-code-xml">				<p>&lt;?xml version="1.0"?&gt;<br>&lt;configuration&gt;<br>  &lt;system.net&gt;<br>    &lt;mailSettings&gt;<br>      &lt;smtp from="odesilatel@example.com" deliveryMethod="SpecifiedPickupDirectory"&gt;<br>        &lt;specifiedPickupDirectory pickupDirectoryLocation="D:\TMP\SMTP"/&gt;<br>      &lt;/smtp&gt;<br>    &lt;/mailSettings&gt;<br>  &lt;/system.net&gt;<br>&lt;/configuration&gt;</p>
		</pre>
		<p>V případě, že použijete odesílání zpráv přes síť (SMTP), je třeba určit minimálně název serveru, který bude použit (výchozí nastavení je <code>localhost</code>), často také port a uživatelské jméno a heslo:</p>
		<pre class="sh-code-xml">&lt;?xml version="1.0"?&gt;<br>&lt;configuration&gt;<br>  &lt;system.net&gt;<br>    &lt;mailSettings&gt;<br>      &lt;smtp from="odesilatel@example.com" deliveryMethod="Network"&gt;<br>        &lt;network host="smtp.example.com" port="25" userName="user" password="pa@$$w0rd"/&gt;<br>      &lt;/smtp&gt;<br>    &lt;/mailSettings&gt;<br>  &lt;/system.net&gt;<br>&lt;/configuration&gt;</pre>
		<p>I nadále doporučuji používat pokud možno pickup directory IISka - je to nejrychlejší a zpravidla též nejspolehlivější. Pokud vám lehne SMTP service v IIS, zprávy se budou v adresáři štosovat a doručí se po restartu. Lépe pozdě, než nikdy.</p>
		<p>Posílání mailů přes SMTP doporučuji pouze jako "variantu Brod", pokud vám opravdu nic jiného nezbývá. Zejména pro její časovou a technologickou náročnost, která stoupá s počtem odesílaných mailů.</p>
		<p>Tolik tedy k odesílání mailů. V nepříliš vzdálené budoucnosti se snad dostanu k tématu podstatně komplikovanějšímu tématu, jímž je přijímání mailů.</p>
