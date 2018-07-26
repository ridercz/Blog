<!-- dcterms:identifier = aspnetcz#38 -->
<!-- dcterms:title = Neznámé leč užitečné stavové kódy HTTP -->
<!-- dcterms:abstract = Stavové kódy 301 (Moved Permanently) a 410 (Gone) -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = IT -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2005-06-07T23:44:56.427+02:00 -->
<!-- dcterms:dateAccepted = 2005-06-07T23:44:56.427+02:00 -->

[RFC 2616](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html) (HTTP) definuje mimo jiné stavové kódy, kterými HTTP servery odpovídají na požadavky. Notoricky známý (a nenáviděný) je například *404 Object not found*. Kompletní přehled najdete ve zmíněném RFCčku, já si dovolím upozornit na dva specifické. Jedná se o *301 Moved Permanently* a *410 Gone*. Oba dva jsou užitečné zejména při komunikaci s vyhledávači.

## 301 Moved Permanently

Tento stavový kód se používá v případě, že požadovaná stránka byla trvale přesunuta na jinou adresu (např. v rámci zpracování nové verze webu). Tato adresa se posílá jako hlavička *Location*. 

Obvykle používaný stav *302 Found* (který ASP.NET generuje při *Response.Redirect*) znamená přesměrování dočasné. Klienti by sice měli přesměrovat požadavek na novou adresu, leč nic víc.

Zato v případě 301 doporučuje norma klientům, aby odpovídajícím způsobem upravili například bookmarky a podobně. Není mi sice známo, že by tak některý z reálně používaných prohlížečů dneška činil, ale vyhledávače se tím docela řídí.

## 410 Gone

Ještě zajímavější je stavový kód *410 Gone*. Ten indikuje, že požadovaná stránka byla definitivně a nenávratně odstraněna, zničena a vaporizována. Její URL má být navždy zapomenuto a všechny odkazy vypáleny a jejich pole posypána solí a salnytrem, aby na nich nic nerostlo. S tím salnytrem jsem to možná trochu přehnal, ale v zásadě toto jest záměr tvůrců normy. Vyhledávače na to reagují zpravidla vymazáním stránky z indexu.

## Jak na to v ASP.NET

ASP.NET neobsahují pro shora uvedené žádnou systémovou podporu. Pročež používám dvojici funkcí, které totéž učiní za mne:

    Public Shared Sub PermanentRedirect(ByVal URL As String)
        With System.Web.HttpContext.Current.Response
            .Clear()
            .StatusCode = 301
            .StatusDescription = "Moved Permanently"
            .AddHeader("Location", URL)
            .Write("<html><head><title>301 Moved Permanently</title></head>")
            .Write("<body><h1>301 Moved Permanently</h1><p>Requested page was permanently moved <a href='" & URL & "'>here</a>.</p></body></html>")
            .End()
        End With
    End Sub

    Public Shared Sub PermanentGone()
        With System.Web.HttpContext.Current.Response
            .Clear()
            .StatusCode = 410
            .StatusDescription = "Gone"
            .Write("<html><head><title>410 Gone</title></head>")
            .Write("<body><h1>410 Gone</h1><p>Requested page was permanently discontinued. Please remove all links here.</p></body></html>")
            .End()
        End With
    End Sub