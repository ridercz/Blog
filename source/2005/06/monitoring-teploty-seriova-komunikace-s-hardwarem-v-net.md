<!-- dcterms:identifier = aspnetcz#41 -->
<!-- dcterms:title = Monitoring teploty: Sériová komunikace s hardwarem v .NET -->
<!-- dcterms:abstract = Přiklad desktopové aplikace, která sériově komunikuje s teplotním čidlem a jinak využívá schopností nové verze .NET Frameworku -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Programování -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2005-06-18T17:52:04.293+02:00 -->
<!-- dcterms:dateAccepted = 2005-06-18T17:52:04.293+02:00 -->


		<p>Jednou z velmi užitečných vlastností platformy .NET je, že se neomezuje jenom na jeden typ aplikací. Ve stejném jazyce, vývojovém prostředí a stejnými technologiemi lze psát aplikace webové (Web Forms), desktopové (Windows Forms) i pro kapesní počítače (Compact Framework).</p>
		<p>Ač to na první pohled nemusí být zřejmé, tato vlastnost je velice výhodná i pro čistokrevného webového programátora. Webové rozhraní prostě má svoje omezení a není vhodné pro všechny typy úkolů. Lze-li očekávat, že klient bude vybaven .NET Frameworkem, je možné řadu těchto omezení vyřešit napsáním jednoduché aplikace, která požadované operace provede. Se svým webovým protějškem pak může komunikovat například přes web service rozhraní.</p>
		<p>Microsoft .NET 2.0 (Whidbey), toho času dostupný jako Beta 2, přináší řadu novinek, a to i pro vývoj desktopových aplikací. Rozhodl jsem se napsat v něm aplikaci, která bude schopna zobrazit aktuální teplotu, přičemž informace o ní bude čerpat jednak z veřejně dostupné webové služby, jednak z teplotního čidla připojeného na sériový port.</p>
		<h2>Použité technologie</h2>
		<ul>
				<li>Komunikace s hardwarovým zařízením přes COM port a protokol RS-232. Obsluha sériových portů je novinkou ve verzi 2.0. </li>
				<li>Komunikace s webovou službou třetí strany. </li>
				<li>Využití <em>application frameworku</em>, tedy funkcí Whidbey pro snazší vývoj desktopových aplikací. </li>
				<li>Využití <em>settings frameworku</em>, nástroje pro snadnou práci s konfigurací.</li>
		</ul>
		<h2>Teplotní čidlo TM</h2>
		<p>Jako lokální teplotní čidlo jsem použil modul "TM" od firmy Papouch s. r. o. (viz <a href="http://www.papouch.com/shop/scripts/_detail.asp?katcislo=0038">papouch.com</a>). Stejný výrobce nabízí i celou řadu dalších čidel (nejen teplotních), včetně připojení na <a href="http://www.papouch.com/?cislo=0188">USB</a> nebo <a href="http://www.papouch.com/shop/scripts/_detail.asp?katcislo=0201">Ethernet</a>, ale pro naše účely bohatě postačí toto nejjednodušší a nejlacinější.</p>
		<h3>Komunikační protokol a proof-of-concept</h3>
		<p>Zapojuje se na sériový port a funguje tak, že po připojení (s parametry 9600-8-N-1) a nahození signálu DTR změří teplotu a pošle ji na výstup jako jednoduchý ASCII řetězec (např. <code>+025.5C</code>). Proof-of-concept kód pro načtení aktuální teploty do numerické proměnné vypadá takto:</p>
		<pre class="sh-code-vb">' Connect to serial port
Dim Port As New System.IO.Ports.SerialPort()
Port.PortName = "COM1"
Port.BaudRate = 9600
Port.DataBits = 8
Port.StopBits = IO.Ports.StopBits.One
Port.Parity = IO.Ports.Parity.None
Port.ReadTimeout = 1000
Port.DtrEnable = True
Port.Open()
' Get current value
Dim S As String = Port.ReadTo("C")
Dim T As Single = Single.Parse(S.Substring(0, 6), _
                  New System.Globalization.CultureInfo("en-US"))
MsgBox(String.Format("Current temperature is: {0:N2} °C", T))
Port.Close()
Port.Dispose()</pre>
		<h2>Webová služba GlobalWeather</h2>
		<p>Vzhledem k významu počasí pro leteckou dopravu jsou ideálním zdrojem informací o počasí letecké systémy. Přístup do nich lze získat příkladně pomocí webové slyžby GlobalWeather, jejíž popis najdete na <a href="http://live.capescience.com/GlobalWeather/">http://live.capescience.com/GlobalWeather/</a>. Tato služba je zároveň důkazem interoperability technologie Web Services, protože neběží na platformě .NET, ale lze ji bez problémů z .NETu využívat.</p>
		<p>Informace o počasí (nejen teplotě) je k dispozici pro každé mezinárodní letiště. Pro ČR lze využít následující:</p>
		<ul>
				<li>Praha (kód <code>LKPR</code><code></code>) </li>
				<li>Karlovy Vary (kód <code>LKKV</code>) </li>
				<li>Brno (kód <code>LKTB</code>) </li>
				<li>Holešov (kód <code>LKHO</code>) </li>
				<li>Ostrava (kód <code>LKMT</code>)</li>
		</ul>
		<p>Chcete-li tuto službu využívat, přidejte si <em>Web reference</em> na adresu <a href="http://live.capescience.com/wsdl/GlobalWeather.wsdl">http://live.capescience.com/wsdl/GlobalWeather.wsdl</a> a nazvěte ji <code>GlobalWeather</code>. Tato webová služba vystavuje dvě třídy, které nás budou zajímat, a to <code>StationInfo</code> a <code>GlobalWeather</code>.</p>
		<h3>Zjištění informací o lokaci</h3>
		<p>Ke zjištění informací o lokaci jest možno využít metodu <code>getStation</code> třídy <code>StationInfo</code>. Tato třída obsahuje ještě další zajímavé metody, jimiž jest možno prohledávat seznam stanic. Budete-li chtít, můžete s jejich použitím rozšířit aplikaci tak, aby umožňovala např. výběr ze seznamu či prohledávání.</p>
		<p>V této fázi se spokojím s tím, že pomocí webové služby získám pro danou lokaci její název a zemi, kde je umístěna. V okně nastavení (<code>FormServiceOptions</code>) tak identifikuji, zda byl zadán platný kód letiště:</p>
		<pre class="sh-code-vb">Dim StationWS As New GlobalWeather.StationInfo()
Dim Station As GlobalWeather.Station = StationWS.getStation(Me.TextBoxWebLocationCode.Text)
If Station Is Nothing Then
    MsgBox("Location not found - check code", MsgBoxStyle.Exclamation)
Else
    MsgBox(String.Format("{0} is {1}, {2}", Me.TextBoxWebLocationCode.Text, Station.name, Station.country), MsgBoxStyle.Information)
End If
StationWS.Dispose()</pre>
		<h3>Zjištění aktuální meteo situace na lokaci</h3>
		<p>Chceme-li na dané lokaci zjistit aktuální meteorologickou situaci, jejíž součástí je i teplota, použijete k tomu metodu <code>getWeatherReport</code> třídy <code>GlobalWeather</code>. Ta vrátí informace o lokaci a její meteorologické situaci:</p>
		<pre class="sh-code-vb">Dim WeatherWS As New GlobalWeather.GlobalWeather()
Dim Report As GlobalWeather.WeatherReport = WeatherWS.getWeatherReport(My.Settings.ServiceLocationCode)
If Not Report Is Nothing Then
    Me.LabelService.Text = String.Format("{0:N1}°C", Report.temperature.ambient)
    Me.GroupBoxService.Text = String.Format("{0} ({1})", Report.station.name, Report.station.country)
    Me.LabelUpdateService.Text = Report.timestamp.Value.ToShortDateString() &amp; " " &amp; Report.timestamp.Value.ToShortTimeString()
End If
WeatherWS.Dispose()</pre>
		<h2>Application Framework</h2>
		<p>Okno vlastností projektu (ukáže se po dvojkliknutí na "<em>My Project</em>" v Solution Exploreru) je ve Whidbey mnohem zajímavější, než tomu bylo v předchozích verzích. Zastavme se pro tento ukamžik u záložky "<em>Application</em>":</p>
		<p style="TEXT-ALIGN: center">
				<img width="500" height="400" title="Okno'My Project - Application" alt="Screenshot" src="https://www.cdn.altairis.cz/Blog/2005/20050618-myproject-application.png"> </p>
		<p>Po povolení <em>Enable Application Framework</em> máte možnost pro svou aplikaci jednoduše nastavit způsob, jakým se celkově má chovat. Po klepnutí na <em>View Application Events</em> se vám otevře soubor <code>ApplicationEvents.vb</code> (standardně skrytý ve složce <code>My Project</code>), ve kterém můžete definovat event handlery pro události týkající se celé aplikace. Připomíná to mechanismus <em>Global Application Class</em> (alias <code>global.asax</code>) známý z webových ASP.NET aplikací.</p>
		<p>Můžete například reagovat na neošetřenou výjimku a pokud ve vaší aplikaci nastane, nějak ji vyřešit - například zobrazit chybové hlášení a vygenerovat log:</p>
		<pre class="sh-code-vb">Namespace My
    Class MyApplication
        Private Sub MyApplication_UnhandledException(ByVal sender As Object, ByVal e As Microsoft.VisualBasic.ApplicationServices.UnhandledExceptionEventArgs) Handles Me.UnhandledException
            If MsgBox("The follofing exception occured:" &amp; vbCrLf &amp; e.Exception.Message &amp; vbCrLf &amp; "Do you want to create log file?", MsgBoxStyle.Critical Or MsgBoxStyle.YesNo) = MsgBoxResult.Yes Then
                Dim LogFileName As String = My.Computer.FileSystem.GetTempFileName()
                My.Computer.FileSystem.WriteAllText(LogFileName, e.Exception.ToString(), False)
                System.Diagnostics.Process.Start("notepad.exe", LogFileName)
            End If
            e.ExitApplication = True
        End Sub
    End Class
End Namespace</pre>
		<h2>Application Settings</h2>
		<p>Téměř každá aplikace má nějaká nastavení, která jest třeba někde ukládat. Obvykle v nějakém konfiguračním souboru, případně v registrech. Což s sebou nese nutnost se o tyto údaje starat a validovat je. Whidbey disponuje technologií, která tyto operace provádí transparentně a vystavuje je pro programátora ve formě strongly-typed třídy, dostupné jako <code>My.Settings</code>.</p>
		<p>Předtím, než začneme experimentovat s nastaveními, doporučuji ještě na záložce <em>Application</em> klepnout na tlačítko <em>Assembly Information</em> a nastavit metadata týkající se aplikace. V předchozí verzi se zapisovaly do souboru <code>AssemblyInfo.vb</code> (ten je přítomen stále, ale je generován automaticky a skryt v adresář <code>My Project</code>), nyní je na to i GUI. </p>
		<p style="TEXT-ALIGN: center">
				<img width="390" height="372" title="Okno Assembly Info" alt="Screenshot" src="https://www.cdn.altairis.cz/Blog/2005/20050618-myproject-assemblyinfo.png"> </p>
		<p>Konfigurace totiž rozeznává dva druhy parametrů: per user a per application. Ty aplikační jsou uloženy klasicky v souboru <code>jménoassembly.config</code>, ale uživatelské jsou uloženy do souboru v uživatelově profilu. Přesná cesta k němu se generuje právě na základě shora uvedených metadat.</p>
		<p>Po dokončení nezbytných příprav jest nám vrhnouti se na genervání vlastních nastavení. Za tímto účelem se v okně <em>My Project</em> přepneme na záložku Settings, <em>kdežtě</em> můžeme určovat konfigurační proměnné, jejich typy a defaultní hodnoty:</p>
		<p style="TEXT-ALIGN: center">
				<img width="500" height="400" title="Okno My Project - Settings" alt="Screenshot" src="https://www.cdn.altairis.cz/Blog/2005/20050618-myproject-settings.png"> </p>
		<p>Milé je, že jako typ konfigurační proměnné je možno použít cokoliv, nejenom primitivní typy jako <code>String</code> nebo <code>Integer</code>. Příkladem budiž <em>Enum</em> typy použité pro uložení nastavení sériového portu (např. <code>System.IO.Ports.StopBits</code> a další). Načítání se pak v kódu děje způsobem, jež je až urážlivě jednoduchý:</p>
		<pre class="sh-code-vb">Dim Port As New System.IO.Ports.SerialPort()
Port.PortName = My.Settings.SensorPortName
Port.BaudRate = My.Settings.SensorBaudRate
Port.DataBits = My.Settings.SensorDataBits
Port.StopBits = My.Settings.SensorStopBits
Port.Parity = My.Settings.SensorParity
Port.ReadTimeout = My.Settings.SensorTimeout
Port.DtrEnable = True
Port.Open()</pre>
		<p>Pokud se jedná o nastavení s <em>user scope</em>, je možno stejným způsobem hodnoty nejenom číst, ale i nastavovat (po dokončení nastavování zavolejte <code>My.Settings.Save()</code>). Nastavení s <em>application scope</em> nelze za běhu aplikace měnit.</p>
		<h2>Ikonka v system tray a "Baloon tip" notifikace</h2>
		<img width="269" height="106" title="Baloon tip" style="FLOAT: right; MARGIN-LEFT: 1ex" alt="Screenshot" src="https://www.cdn.altairis.cz/Blog/2005/20050618-baloon-tip.png"> <p>Komponenta <code>NotifyIcon</code>, reprezentující ikonu v system tray (lokace známá též jako "vedle hodin") byla k dispozici již v předchozích verzích .NET Frameworku. Její Whidbey verze obsahuje též podporu pro "Baloon tip" - notifikaci nově používanou ve Windows XP.</p><p>V souvislosti s NotifyIcon umí aplikace tři věci:</p><ul><li>Po minimalizaci se "schová" do ikonky. </li><li>Po klepnutí na ikonku zobrazí baloon tip s aktuálními údaji o teplotě. </li><li>Po klepnutí na ikonku pravým tlačítkem zobrazí okno aplikace.</li></ul><p>Stará se o to následující kód:</p><pre class="sh-code-vb">Private Sub FormMain_Resize(ByVal sender As Object, _
            ByVal e As System.EventArgs) Handles Me.Resize<br>
    If Me.WindowState = FormWindowState.Minimized Then
        Me.Visible = False
        Me.TrayIcon.Visible = True
    End If
End Sub<br>
Private Sub TrayIcon_MouseClick(ByVal sender As Object, _
            ByVal e As System.Windows.Forms.MouseEventArgs) _
            Handles TrayIcon.MouseClick
    If e.Button = Windows.Forms.MouseButtons.Right Then
        Me.Visible = True
        Me.TrayIcon.Visible = False
        Me.WindowState = FormWindowState.Normal
    Else
        Dim Message As String = String.Format("{0}: {1}\n{2}: {3}", _
            Me.GroupBoxSensor.Text, Me.LabelSensor.Text, _
            Me.GroupBoxService.Text, Me.LabelService.Text)
            Me.TrayIcon.ShowBalloonTip(5, "Current temperature", _
            Message.Replace("\n", vbCrLf), ToolTipIcon.Info)
    End If
End Sub</pre><h2>Závěrem</h2><p>Toto je funkční aplikace, která využívá některé nové možnosti, dostupné v Microsoft .NET Beta 2. K jejímu spuštění potřebujete Whidbey beta 2, projekt je pro VS.NET, ale měl by být kompatibilní i s <em>Visual Basic Expressem</em>.</p><ul><li><a href="http://www.papouch.com/shop/scripts/_detail.asp?katcislo=0038">Čidlo TM</a> </li><li><a href="https://www.cdn.altairis.cz/Blog/2005/20050618-thermoclient.zip">Zdrojové kódy aplikace ke stažení (140 kB)</a></li></ul><p>Pracuji na obsáhlejším projektu, který bude umět centralizovaně monitorovat teplotu ve více bodech, včetně síťové komunikace a využití pokročilejších papouščích čidel. Dočkáte se ho během několika týdnů.</p>