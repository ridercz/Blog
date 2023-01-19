<!-- dcterms:identifier = aspnetcz#9 -->
<!-- dcterms:title = Vytvoření vlastní konfigurační sekce ve Web.Config -->
<!-- dcterms:abstract = Webové .NET aplikace jsou předučeny k tomu, aby svá nastavení ukládala do souboru Web.Config. Pokud se nechcete omezit na ukládání pouhých dvojic název-hodnota, můžete si napsat vlastní handler konfigurační sekce a použít formát jaký se vám zlíbí. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = IT -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2005-01-09T06:54:43.36+01:00 -->
<!-- dcterms:date = 2005-01-09T06:54:43.36+01:00 -->

.NET aplikace jsou předurčeny k tomu, aby své konfigurační údaje ukládaly do souboru `jménoaplikace.config` (v případě webových `web.config`). K takto uloženým údajům lze přistupovat pomocí namespace `System.Configuration.ConfigurationSettings`.

Konfigurační soubory jsou psány ve formátu XML a jsou rozděleny na několik sekcí. `Web.Config` typické webové aplikace vypadá nějak takhle:

    <configuration>
      <appSettings>
        <add key="Nazev1" value="hodnota1" />
        <add key="Nazev2" value="hodnota2" />
      <appSettings>
      <system.web>
        <authentication mode="Forms">
          <forms name=".CHEETAH3AUTH" loginUrl="/Login.aspx" protection="All" timeout="60"/>
        </authentication>
      </system.web>
    </configuration>

Aplikační nastavení se obvykle ukládají do sekce `appSettings` jako dvojice *název-hodnota*. Přistupovat k nim pak lze jako k hodnotám kolekce `System.Configuration.ConfigurationSettings.AppSettings`.

## Za hranice AppSettings

Výše uvedený postup stačí pro jednoduché aplikace. Ale pokud píšete aplikaci složitější, pravděpodobně oceníte možnost zapsat její konfiguraci pomocí vlastních XML elementů a atributů. Protože jenom málo věcí je v prostředí .NET "zadrátováno" napevno, máte možnost snadno si naprogramovat vlastní konfigurační sekci.

Princip je zhruba následující: Je třeba vytvořit dvě třídy. Jedna bude reprezentovat vlastní nastavení (její vlastnosti a metody budou mít hodnoty podle uživatelem definovaného obsahu konfiguračního souboru). Druhá třída bude tzv. configuration section handler a zajistí naplnění konfigurační sekce dle potřeby.

Představme si, že chcete do konfiguračního souboru vložit novou sekci, která bude obsahovat informace pro odesílání e-mailových zpráv. Ona sekce bude vypadat nějak takhle:

    <mailConfig>
      <from name="Jméno odesílatele" address="odesilatel@example.com" />
      <to name="Jméno příjemce" address="prijemce@example.com" />
      <smtpServer>localhost</smtpServer>
    </mailConfig>

Obslužný kód ve VB.NET sestává ze dvou tříd:

    Public Class EmailSettingsConfigHandler
        Implements System.Configuration.IConfigurationSectionHandler

        Public Function Create(ByVal parent As Object, ByVal configContext As Object, ByVal section As System.Xml.XmlNode) As Object Implements System.Configuration.IConfigurationSectionHandler.Create
            Return New EmailSettings(section)
        End Function
    End Class

    Public Class EmailSettings
        Private _From, _To, _SmtpServer As String

        Friend Sub New(ByVal E As System.Xml.XmlNode)
            Me._From = """" & E.SelectSingleNode("from/@name").Value & """ " & _
                       "<" & E.SelectSingleNode("from/@address").Value & ">"
            Me._To = """" & E.SelectSingleNode("to/@name").Value & """ " & _
                       "<" & E.SelectSingleNode("to/@address").Value & ">"
            Me._SmtpServer = E.SelectSingleNode("smtpServer").InnerText
        End Sub

        Public ReadOnly Property From() As String
            Get
                Return Me._From
            End Get
        End Property

        Public ReadOnly Property [To]() As String
            Get
                Return Me._To
            End Get
        End Property

        Public ReadOnly Property SmtpServer() As String
            Get
                Return Me._SmtpServer
            End Get
        End Property
    End Class

Třída `EmailSettings` reprezentuje vlastní nastavení, která načítá ve svém konstruktoru z XML dokumentu.

Třída `EmailSettingsConfigHandler` slouží systému k práci s novou konfigurační sekcí. Implementuje rozhraní `IConfigurationSectionHandler`, které definuje jedinou metodu: `Create`. Jejím jediným parametrem, který nás momentálně zajímá, je `section`. To je `XmlNode`, odkazující na přiřazenou konfigurační sekci, v našem případě tedy na element `<mailConfig>`. Metoda vrací instanci námi vytvořené třídy s nastaveními a je velmi jednoduchá, veškerou "špinavou práci" za nás odvede konstruktor třídy samé.

## Konfigurace konfigurátoru

Abychom mohli nově založenou konfigurační sekci využívat, je potřeba ji zaregistrovat. To se dělá přidáním elementu `configSections`, jehož obsah je následující:

    <configSections>
      <section name="mailConfig" type="AltairCommunications.Test.EmailSettingsConfigHandler, Test" />
    </configSections>

Atribut `section/@name` určuje název elementu konfigurační sekce. Atribut `section/@type` je úplné označení typu výše uvedené třídy `EmailSettingsConfigHandler`. Konkrétní hodnota tohoto atributu záleží na vašem nastavení. Moje třída je uložena v namespace `AltairCommunications.Test`, vaše se bude patrně jmenovat jinak. Parametr za čárkou je název assembly (bez přípony, např. *.dll*), ve které se typ nachází. Moje knihovna se tedy jmenuje `Test.dll` - vaše se opět bude zřejmě jmenovat jinak.

## Použití konfigurace

Použití konfigurace je jednoduché. Zavoláte `System.Configuration.ConfigurationSettings.GetConfig("název sekce")` a přetypujete na váš konfigurační typ. Například:

    Public Sub SendMail()
        Dim Config As EmailSettings = DirectCast(System.Configuration.ConfigurationSettings.GetConfig("mailConfig"), EmailSettings)
        Dim Msg As New System.Web.Mail.MailMessage
        Msg.From = Config.From
        Msg.To = Config.To
        Msg.Subject = "Testovací zpráva"
        Msg.Body = "Obsah testovací zprávy"

        System.Web.Mail.SmtpMail.SmtpServer = Config.SmtpServer
        System.Web.Mail.SmtpMail.Send(Msg)
    End Sub