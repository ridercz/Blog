<!-- dcterms:identifier = aspnetcz#73 -->
<!-- dcterms:title = WS-Security v praxi - jednoduchý příklad použití WSE 3.0 -->
<!-- dcterms:abstract = Základní specifikace web services (WS-I) jest praktickým důkazem pravdivosti tvrzení, že v jednoduchosti je síla. Tato specifikace je ve své podstatě neuvěřitelně primitivní. To má ovšem za následek skutečnost, že webové služby podle ní sepsané neumějí spoustu užitečných věcí, které by bylo lze od nich očekávati, příkladně autentizaci. S tím se ovšem počítalo a existuje řešení. -->
<!-- np9:categoryId = 2 -->
<!-- x4w:category = Bezpečnost -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2006-01-12T06:47:46.92+01:00 -->
<!-- dcterms:dateAccepted = 2006-01-12T06:47:46.92+01:00 -->

Základní specifikace web services (WS-I) jest praktickým důkazem pravdivosti tvrzení, že v jednoduchosti je síla. Tato specifikace je ve své podstatě neuvěřitelně primitivní. To má ovšem za následek skutečnost, že webové služby podle ní sepsané neumějí spoustu užitečných věcí, které by bylo lze od nich očekávati, příkladně autentizaci. S tím se ovšem počítalo a existuje řešení.

Webové služby jsou založeny na posílání XML dokumentů (obvykle přes HTTP). Což v praxi znamená, že je lze víceméně libovolně rozšiřovat. Všechny standardy založené na XML lze beztrestně rozšiřovat přidáním vlastních namespace. Vznikla proto řada doplňkových standardů. Z nich nás bude zajímat především standard **WS-Security**.

Tento standard umožňuje (mimo jiné) s každým požadavkem posílat autentizační údaje, a toho právě budeme využívat.

## Web Services Enhancements 3.0

Chcete-li využívat dobrodiní rozšíření WS-Security (jakož i řady dalších) na platformě ASP.NET 2.0, musíte si nainstalovat softwarový balík Web Services Enhancements (WSE). Jeho aktuální verze má číslo 3.0 a můžete si ji [zdarma stáhnout](http://www.microsoft.com/downloads/details.aspx?FamilyID=018a09fd-3a74-43c5-8ec1-8d789091255d&DisplayLang=en) na webu Microsoftu.

Verze WSE se vyznačují tím, že nejsou kumulativní, nejedná se o "upgrade". Každá verze má svůj vlastní namespace (trojka `Microsoft.Web.Services3`) a implementuje různé standardy.

Pro účely tohoto článku bych vám doporučil, abyste zvolili vývojářskou instalaci. Ta vám kromě runtime a dokumentace nainstaluje také plugin do Visual Studia 2005. Tento plugin bohužel není kompatibilní s Express edicemi vývojových nástrojů, nicméně součástí WSE jest i samostatný nástroj, který můžete použít.

### Tradiční povzdech nad kvalitou dokumentace

Instalace WSE je snadná. Zato pokračování... Za kvalitu dokumentace všeobecně a příkladů zejména by někdo v Microsoftu zasloužil nakopat. Nebo přinejmenším vysvětlit, že příklady mají být jednoduché, snadno pochopitelné, a pokud možno nikoliv zběsile provázané mezi sebou.

Naštěstí situaci zachraňuje [tento poměrně dobrý článek](http://msdn.microsoft.com/library/en-us/dnpag2/html/wss_ch3_impdirectauth_wse30.asp) na MSDN. Z něho jsem vycházel při psaní tohoto článku, jakož i příkladů.

Pokud už totiž někde narazíte na popis WSE, pak v roztodivných komplikovaných scénářích s napojením na Active Directory, s využitím klientských certifikátů a podobně. Já jsem se ovšem dostal do situace, kdy jsem potřeboval používat nikoliv certifikáty nebo AD, ale standardní membership databázi ASP.NET aplikací. Proto vznikl tento článek a s ním související příklady

### Předpokládané znalosti čtenáře

Tento článek předpokládá, že laskavý čtenář disponuje jistými znalostmi a nevysvětuje tudíž základy. Předpokládá se, že kromě obecných základů práce ve Visual Studiu 2005 a ASP.NET obecně umíte pracovat s běžnými webovými službami a víte, jak fungují membership providery v ASP.NET 2.0.

## Serverová část

Naše ukázková webová služba sama o sobě nepředstavuje nižádnou ukázku programátorského umu. Založte si nový webový projekt a umístěte do něj novou webovou službu. Ponecháme onu ukázkovou metodu `HelloWorld()`, pro naše účely zcela postačuje. Zdrojový kód tedy vypadá nějak takto:

    Imports System.Web
    Imports System.Web.Services
    Imports System.Web.Services.Protocols
    <WebService(Namespace:="http://tempuri.org/")> _
    <WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
    <Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
    Public Class WebService
        Inherits System.Web.Services.WebService
        <WebMethod()> _
        Public Function HelloWorld() As String
            Return "Hello World"
        End Function
    End Class

Chceme-li tuto metodu využívat, není třeba se v dané chvíli obtěžovat žádnými uživatelskými jmény a podobně. Ukázkovou aplikaci jistě dokážete vytvořit sami, jednu najdete v přiložených příkladech jako projekt **UnsecureClient**.

Programový kód této webové služby již nebudeme dále modifikovat, pouze později přidáme jeden atribut. To je důležité - WSE 3.0 nativně používá tzv. politiky (policy), jimiž lze deklarativně určovat podmínky, za nichž lze volat tu kterou webovou službu. Připomíná to nastavení URL autorizace, kde pomocí direktiv v souboru `web.config` určujete, kteří uživatelé či skupiny mají právo přistupovat k té které části aplikace.

### Nastavení povolených protokolů

Webové služby jest možno volati mnoha různými způsoby. Ač je pro ně nativní SOAP over HTTP, je možno je - kvůli kompatibilitě s tupějšími klienty - možno volat i pomocí prostých a nekomplikovaných HTTP požadavků metodami GET a POST. Pro naše účely ovšem potřebujeme pouze SOAP. Primitivnější metody nepodporují WSE rozšíření a jest tedy nutno zakázat jejich použití.

Toto je **velmi důležitý krok**, protože jinak si vytvoříte roztomilou bezpečnostní díru. Z .NET klienta bude všechno chodit jak má (nativně používá SOAP), ale pokud si někdo vaši webovou službu zavolá metodou HTTP GET nebo POST z prohlížeče, může se do ní dostat.

Seznam povolených protokolů můžeme měnit ve `web.config`u. Odstraníme z něj všechny protokoly s výjimkou `AnyHttpSoap` a `Documentation`. Posledně jmenovaný se stará o zobrazení informační stránky s popisem webové služby.

    <?xml version="1.0" encoding="utf-8"?>
    <configuration>
      <system.web>
        <webServices>
          <protocols>
            <clear />
            <add name="Documentation" />
            <add name="AnyHttpSoap" />
          </protocols> 
        </webServices>
      </system.web>
    </configuration>

### Vytvoření databáze uživatelů

Naším cílem je učinit web services kompatibilní se standardními Membership Providery v ASP.NET 2.0. Můj příklad používá `SqlMembershipProvider` s databází na SQL Serveru Express, ale aplikace bude chodit s jakýmkoliv providerem, který se rozhodnete použít.

Součástí naší politiky bude povolit přístup k webové službě pouze členům určité role. V mém příkladu se jmenuje "`WebServiceUsers`" a obsahuje jediného uživatele, jehož jméno je "`DemoUser`" a heslo "`demo.password`". Vytvořte si tedy patřičné uživatele a role, nebo použijte mou databázi.

### Povolení WSE 3.0 v projektu

Tvorba XML konfiguračních souborů a souborů s politikami není jednoduchá. Naštěstí WSE disponuje již zmiňovaným pluginem pro jejich vytváření. Klepněte pravým tlačítkem na projekt a z kontextového menu zvolte položku "**WSE Settings 3.0**". Objeví se okno, v němž na záložce **General** zaškrtněte oba checkboxy:

 ![Screenshot](https://www.cdn.altairis.cz/Blog/2006/20060112-wse-01.png) 

Tímto krokem přidáte do konfiguračního souboru aplikace řadu nastavení, které povolí použití WSE 3.0, stejně jako referenci na odpovídající knihovnu.

### Tvorba bezpečnostní politiky

Dále je nutno vytvořit soubor pravidel, která budou stanovovat, kdo má právo přistupovat k naší službě. Přepněte se na záložku **Policy**, zaškrtněte **Enable policy** a klepněte na **Add** pro vytvoření nové politiky. Nějak vhodně si ji pojmenujte (například `MyServerPolicy`) a pokračujte spuštěním průvodce.

 ![Screenshot](https://www.cdn.altairis.cz/Blog/2006/20060112-wse-02.png) 

V prvním kroku je třeba zvolit, že chcete zabezpečit serverovou část - webovou službu (**service application**). Dále pak musíte zvolit formu autentizace. Zvolte **Username** - certifikáty a podobně si necháme na jindy.

 ![Screenshot](https://www.cdn.altairis.cz/Blog/2006/20060112-wse-03.png) 

Politika může (ale nemusí, pokud to chcete nastavit vlastními silami) zajistit též autorizaci, tedy povolit volání pouze určitým uživatelům nebo skupinám. Zaškrtněte **Perform Authorization** a povolte přístup skupině `WebServiceUsers`.

 ![Screenshot](https://www.cdn.altairis.cz/Blog/2006/20060112-wse-04.png) 

V posledním kroku průvodce můžete nastavit, zda se má SOAP zpráva podepsat, šifrovat či obojí. Použití podpisů a šifrování vyžaduje pokročilejší konfiguraci klíčů a podobně, proto v tomto okamžiku pro jednoduchost zvolíme "**None (rely on transport protection)**". To znamená, že WSE nebude žádnou ze shora uvedených činností provádět, a že tedy uživatelské jméno a heslo poputuje sítí v otevřené podobě. Tomu je radno se vyhnout a pokud použijete tento postup, neměli byste k webové službě přistupovat přes obyčejné HTTP, ale přes jeho šifrovanou variantu HTTPS - tím přenesete zodpovědnost za šifrování na transportní vrstvu.

Poklikáním na různé next a finish průvodce ukončíte.

Řady souborů ve vaší aplikaci se rozmnožily o `~/wse3policyCache.config`. Tento soubor, vytvořený uvedeným průvodcem, obsahuje definci vaší bezpečnostní politiky. Můžete jej modifikovat stejně jako jste ho vytvořili, nebo přímo editovat jeho zdrojový kód. Rovněž `web.config` se rozrostl, a to právě o odkaz na tento soubor.

### Vytvoření a použití vlastního username token manageru

WSE standardně disponuje pouze ověřováním proti systémové databázi uživatelů. Pokud se chcete ověřovat proti čemukoliv jinému (například proti databázi membership providera), musíte si sami napsat vlastní `UsernameTokenManager`, v němž si napíšete vlastní kód pro rozhodnutí, zda je ten který uživatel správný.

Vytvoříme tedy třídu `MembershipUsernameTokenManager` a umístíme ji do namespace `WseDemo` (je nutno použít nějaký namespace, je vcelku jedno jaký). Tato třída bude dědit od `Microsoft.Web.Services3.Security.Tokens.UsernameTokenManager` a bude přepisovat toliko metodu `AuthenticateToken`:

    Namespace WseDemo
        Public Class MembershipUsernameTokenManager
            Inherits Microsoft.Web.Services3.Security.Tokens.UsernameTokenManager
            Protected Overrides Function AuthenticateToken(ByVal Token As Microsoft.Web.Services3.Security.Tokens.UsernameToken) As String
                ' Validate username and password using configured membership provider
                If Not Membership.ValidateUser(Token.Username, Token.Password) Then Return Nothing
                ' Create new principal based on user name
                Dim I As New System.Security.Principal.GenericIdentity(Token.Username)
                Dim P As New System.Security.Principal.GenericPrincipal(I, Roles.GetRolesForUser(Token.Username))
                Token.Principal = P
                Return Token.Password
            End Function
        End Class
    End Namespace

Tato metoda obdrží jako vstupní parametr `UsernameToken` a vrací řetězec`. `Pokud je autentizace úspěšná, vrací údaj předaný jako heslo (`Token.Password`); není-li, vrací `Nothing`, případně může vyhodit výjimku.

Jest nutno si uvědomit, že dle implementace nemusí "password" být nutně heslo jako takové, může se jednat například o jeho hash a podobně.

Protože používáme kromě autentizace i autorizaci pomocí rolí, následují tři řádky, kde načteme role uživateli přiřazené.

Nyní je třeba způsobit, aby se námi pracně vytvořený manager vůbec spustil - respektive použil namísto standardního. Otevřete si proto opět konfigurační nástroj a na záložce **Security** v sekci **Security Token Managers** klepněte na tlačítko **Add**.

 ![Screenshot](https://www.cdn.altairis.cz/Blog/2006/20060112-wse-05.png) 

V objevivším se okně zadejte do položky **Type** plný název vámi vytvořené třídy (proto bylo nutno ji zažadit do namespace), v našem případě je to `WseDemo.MembershipUsernameTokenManager`. Další dvě položky určují, k jakému elementu ve zprávě se naše třída vztahuje. Namespace je `http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd` a LocalName je `UsernameToken`.

### Aplikace bezpečnostní politiky

Posledním krokem na straně serveru je nutné zajistit, aby se námi vytvořená politika jménem `MyServerPolicy` aplikovala na naši webovou službu (politik můžete mít samozřejmě více pro různé služby). Jest tak učiniti pomocí atributu `Microsoft.Web.Services3.Policy`, jímž obohatíme definici třídy naší webové služby, takže kód bude vypadat takto:

    Imports System.Web
    Imports System.Web.Services
    Imports System.Web.Services.Protocols
    <WebService(Namespace:="http://tempuri.org/")> _
    <WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
    <Microsoft.Web.Services3.Policy("MyServerPolicy")> _
    <Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
    Public Class WebService
        Inherits System.Web.Services.WebService
        <WebMethod()> _
        Public Function HelloWorld() As String
            Return "Hello World"
        End Function
    End Class

## Klientská část

Pokud se pokusíte naši webovou službu zavolat z "normálního" klienta, dojde k chybě. Klienta je nutno upravit, aby se naučil, jak že má posílat autentizační údaje. Vytvořte proto nový projekt typu **Windows Application**. Bude sestávat z formuláře na kterém budou dva text boxy (pro zadání jména a hesla) a jedno tlačítko pro zavolání webové služby.

I v této aplikaci spusťte konfigurační nástroj WSE a na záložce **General** zaškrtněte Enable this project for **Web Services Enhancements**. Poté přejděte na záložku **Policy** a popsaným způsobem vytvořte klientskou politiku (bude se jmenovat `MyClientPolicy`). Hodnoty budou stejné jako u serveru, pouze budete zabezpečovat klientskou část. Ačkoli v průběhu průvodce budete moci zadat uživatelské jméno a heslo, nedělejte to, budeme ho nastavovat v kódu.

Přidejte si běžným způsobem odkaz na webovou službu - pojmenujte ji třeba `HelloWorldService`. Visual Studio vytvoří tentokrát nikoliv jednu, ale dvě proxy třídy pro její volání. Ta která nás zajímá má na konci ještě přídomek `Wse`.

Vlastní kód pro obsluhu stisknutého tlačítka je jednoduchý:

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        Dim MyToken As New Microsoft.Web.Services3.Security.Tokens.UsernameToken(Me.TextBoxUserName.Text, Me.TextBoxPassword.Text, Microsoft.Web.Services3.Security.Tokens.PasswordOption.SendPlainText)
        Dim HW As New HelloWorldService.WebServiceWse()
        HW.SetPolicy("MyClientPolicy")
        HW.SetClientCredential(MyToken)
        Dim Response As String = HW.HelloWorld()
        MsgBox("Web service returned: " & Response, MsgBoxStyle.Information)
    End Sub

Při zadání chybného uživatelského jména či hesla dojde k výjimce, u živých aplikací je tedy vhodné ošetřit chybové stavy.

## Ponaučení z článku plynoucí

1.  Základní specifikace webových služeb (WS-I) neobsahuje žádnou podporu pro předávání autentizačních údajů s požadavkem.
2.  Tento problém řeší rozšiřující standard WS-Security, který je v prostředí .NET přítomen v podobě balíku Web Services Enhancements, který je možno si zdarma stáhnout.
3.  Jaká pravidla se na tu kterou službu vztahují, jest určovati nejlépe deklarativně, pomocí tzv. politik (policy).
4.  Standardně s WSE dodávané třídy umožňují pouze autentizaci proti Windows databázi uživatelů a/nebo pomocí klientských certifikátů.
5.  Je nicméně snadné napsat si vlastní `UsernameTokenManager`, který může používat libovolnou databázi uživatelů.

### Odkazy

*   [Zdrojové kódy ke stažení](https://www.cdn.altairis.cz/Blog/2006/20060112-wse-samples.zip) 
*   [Článek o WSE na MSDN (anglicky)](http://msdn.microsoft.com/library/en-us/dnpag2/html/wss_ch3_impdirectauth_wse30.asp)

*   [Stažení WSE 3.0](http://www.microsoft.com/downloads/details.aspx?FamilyID=018a09fd-3a74-43c5-8ec1-8d789091255d&DisplayLang=en)