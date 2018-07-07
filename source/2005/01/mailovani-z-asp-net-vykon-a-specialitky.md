<!-- dcterms:identifier = aspnetcz#3 -->
<!-- dcterms:title = Mailování z ASP.NET - výkon a specialitky -->
<!-- dcterms:abstract = Detailní pohled na zasílání mailů prostřednictvím ASP.NET stránek -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Tipy, triky -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2005-01-03T05:01:35.627+01:00 -->
<!-- dcterms:dateAccepted = 2005-01-03T05:01:35.627+01:00 -->

K rozesílání e-mailových zpráv z prostředí ASP.NET aplikací se obvykle používá tříd z namespace `System.Web.Mail`, potažmo `System.Web.Mail.SmtpMail`. Pro většínu případů plně postačuje základní nastavení opsané z příruček. Problémy nastanou v případě, kdy je e-mailů třeba rozeslat hodně, nebo pokud je architektura sítě komplikovaná. Nezaškodí tedy podívat se na to, jakým způsobem mailování probíhá a co vše můžeme nastavit.

Existují dvě základní metody odesílání e-mailových zpráv. V prvním případě se ASP.NET chovají jako běžný poštovní klient (MUA - Mail User Agent), připojí se přes síť (TCP spojení na port 25) k mail serveru a zprávu odešlou. To je spolehlivé, máme-li k dispozici funkční mail server, leč poměrně pomalé - sestavení spojení a zaslání zprávy nějakou dobu trvá. Na druhou stranu, jako SMTP server můžeme použít cokoliv - vestavěný mail server ve Windows, produkt třetí strany...

Ve druhém případě jsme těsně svázáni s použitým mail serverem, v našem případě tedy se *SMTP Service* ve Windows. Ta totiž umí prostřednictvím funkce "mail pickup service" monitorovat určitou složku (Standardně `C:\InetPub\MailRoot\pickup` ) a objeví-li se v ní specifickým způsobem formátovaný soubor, odešle ho jako e-mail. Maily v této složce zpracovává postupně, takže nemůže dojít k přetížení - maximálně se doručení zprávy o něco zpozdí, než na ni dojde řada. Podmínkou ovšem je, že na daném stroji musí běžet právě *Microsoft SMTP Service*.

## Základní varianta

Dim Message As New System.Web.Mail.MailMessage Message.From = "odesilatel@server.cz" Message.To = "prijemce@server.cz" Message.Subject = "Subject zpravy" Message.Body = "Text zpravy" System.Web.Mail.SmtpMail.Send(Message)

Použitím shora uvedeného kódu se zpráva odešle prostřednictím mail pickup service, tedy prostřednictvím lokálního serveru a jeho MS SMTP služby. V případě, že by na jednom serveru běželo více instancí MS SMTP serveru, je možno explicitně určit do které složky se má zpráva uložit:

Dim Message As New System.Web.Mail.MailMessage Message.From = "odesilatel@server.cz" Message.To = "prijemce@server.cz" Message.Subject = "Subject zpravy" Message.Body = "Text zpravy" Message.Fields("http://schemas.microsoft.com/cdo/configuration/sendusing") = 1 Message.Fields("http://schemas.microsoft.com/cdo/configuration/smtpserverpickupdirectory") = "C:\InetPub\MailRoot\pickup" System.Web.Mail.SmtpMail.Send(Message)

## Odeslání přes konkrétní SMTP server

V některých případech je nutné odeslat zprávu přes nějaký konkrétní SMTP server. Například tehdy, je-li server umístěn v rámci lokální sítě za firewallem, který z důvodu ochrany proti spamu a virům neumožňuje přímé připojení na vnější SMTP servery. V takovém případě bývá určen jeden místní server, přes který musí být přeposílána (relayována) veškerá pošta. Dalším případem, dnes již díky bohu vídaným jenom zřídka, je síť která není do Internetu připojena trvale, ale pouze v nějakých intervalech vytáčeným spojením - místní server nasbírá zprávy k odeslání a řekněme jednou za hodinu se na pár minut připojí a zprávy dávkově rozešle.

V takovém případě je třeba nastavit statickou vlastnost `System.Web.Mail.SmtpMail.SmtpServer`:

Dim Message As New System.Web.Mail.MailMessage Message.From = "odesilatel@server.cz" Message.To = "prijemce@server.cz" Message.Subject = "Subject zpravy" Message.Body = "Text zpravy" System.Web.Mail.SmtpMail.SmtpServer = "mail.intranet.local" System.Web.Mail.SmtpMail.Send(Message)

## Odeslání přes konkrétní SMTP server s autentizací či přes nestandardní port

V rámci uzavřených sítí mail servery zpravidla nevyžadují žádnou autentizaci a běží na standardním portu (25). Může však nastat situace, kdy je třeba zprávu odeslat přes server běžící na nestandardním portu (v našem příkladu 2525), nebo kdy je třeba zadat uživatelské jméno a heslo, či použít šifrované spojení (SSL). To vše je možno nastavit pomocí konfiguračních polí zprávy:

Dim Message As New System.Web.Mail.MailMessage Message.From = "odesilatel@server.cz" Message.To = "prijemce@server.cz" Message.Subject = "Subject zpravy" Message.Body = "Text zpravy" Message.Fields("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2 Message.Fields("http://schemas.microsoft.com/cdo/configuration/sendusername") = "uzivatelske_jmeno" Message.Fields("http://schemas.microsoft.com/cdo/configuration/sendpassword") = "heslo" Message.Fields("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "mail.intranet.local" Message.Fields("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 2525 Message.Fields("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = True System.Web.Mail.SmtpMail.Send(Message)

## Závěr: Kdy co použít

Ve většině případů je nejsnazší cestou žádné zvláštní metody nespecifikovat a použít první zmiňovaný případ, zaslání prostřednictvím *pickup service*. Pokud to není možné, lze prostřednictvím konfiguračních polí určit rozličné parametry připojení na SMTP server ([jejich kompletní popis najdete v MSDN](http://msdn.microsoft.com/library/default.asp?url=/library/en-us/e2k3/e2k3/_cdo_schema_configuration.asp)).

Odesílání pomocí SMTP ovšem zabírá poměrně dost času a prostředků. Pokud kvůli nastavení sítě musíte použít nějaký komplikovaný postup, a odesíláte hodně mailů, je lepší cestou nainstalovat na lokální server Microsoft SMTP Service a *tu* potom zkonfigurovat tak, aby pro posílání používala odpovídajícího prostředníka - *smarthost*.