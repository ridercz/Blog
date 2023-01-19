<!-- dcterms:identifier = aspnetcz#4409 -->
<!-- dcterms:title = Posílání mailů z Azure: Sendy, Amazon SES a ASP.NET -->
<!-- dcterms:abstract = Snažím se své nové projekty spouštět ve Windows Azure. Jednou z velkých bolestí nicméně zůstává velmi problematické posílání mailů z Azure Web Sites. Pro jednotlivé transakční maily jsem si řešení už napsal, ale ani to nestačí na odesílání tisíců nebo desetitisíců zpráv. Nicméně, našel jsem řešení. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = IT -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2013-08-19T03:59:13.74+02:00 -->
<!-- dcterms:date = 2013-08-19T03:59:14+02:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20130819-posilani-mailu-z-azure-sendy-amazon-ses-a-asp-net.png -->

Snažím se své nové projekty spouštět ve Windows Azure. Jednou z velkých bolestí nicméně zůstává velmi problematické posílání mailů z Azure Web Sites. Pro jednotlivé transakční maily jsem si řešení už napsal, ale ani to nestačí na odesílání tisíců nebo desetitisíců zpráv. Nicméně, našel jsem řešení.

To spočívá v kombinaci Sendy, Amazon Simple Email Service a jednoduchého ASP.NET klienta. Tento článek je návodem, jak to celé rozchodit taky.

## Sendy.co

Sendy je webová aplikace pro správu mailing listů. Řeší správu distribučních seznamů, rozesílání mailů, zpracování nefunkčních e-mailů a odhlášení atd. Stojí 59 dolarů (jednorázově) a jsou to velmi dobře investované peníze, protože napsat podobně schopnou aplikaci by bylo dosti náročné a určitě dražší. 

Na jedné instalaci Sendy můžete provozovat neomezené množství mailing listů. Můžete tam dokonce vytvářet i podúčty zákazníkům a posílání mailů zpoplatňovat přes PayPal.

Jedinou nevýhodou Sendy je v mých očích to, že je napsána v PHP a vyžaduje MySQL. Naštěstí, Azure Web Sites podporují PHP a k předplatnému dostanete jednu 20 MB MySQL databázi zdarma. Použití Azure není podmínkou, můžete si někde zaplatit laciný hosting, nebo si Sendy hostovat sami, pokud máte někde nějaké PHP a MySQL.

Sendy oficiálně není na Windows platformě podporováno, nicméně fakticky funguje. Velmi podrobný návod napsal [Scott Hanselman na svém blogu](http://www.hanselman.com/blog/InstallingSendyAPHPAppOnWindowsAzureToSendInexpensiveNewsletterEmailViaAmazonSES.aspx). Já se PHP vyhýbám, jak jen to jde, ale přesto jsem podle něj byl schopen Sendy úspěšně rozchodit.

Pro správnou funkčnost na Windows musíte (nad rámec odkazovaného návodu) provést záměnu všech řetězců

    $_SERVER['SCRIPT_FILENAME']

za

    strtr($_SERVER['SCRIPT_FILENAME'], '\\', '/')

(tuto radu najdete v komentářích)

## Amazon Simple Email Service

O vlastní rozesílání mailů se stará Amazon SES. Jedná se o placenou službu, která stojí 0,10 USD za 1000 odeslaných mailů. Což je myslím velice dobrá cena. Zejména uvážíme-li, že se nejedná jenom o tupé odeslání mailu, ale i o jejich DKIM odesílání a zejména sledování chyb (zpráv o nedoručitelnosti) a stížností na odhlášení. To si všechno můžete udělat sami (a dělal jsem to), ale je to natolik komplikované, že je podle mého soudu lepší za to zaplatit Amazonu.

SES má jednoduché API a můžete ho začlenit do svých ASP.NET aplikací, já jsem ho nicméně pouze [podle návodu](http://sendy.co/get-started) propojil se Sendy a dál to neřešil.

## ASP.NET klient pro Sendy API

Pokud chcete uživatele do maling listů přidávat a odstraňovat z webu, můžete použít Sendy API. Je extrémně jednoduché. Existuje pro něj i .NET klient, ale ten mi přišel divný, tak jsem si napsal vlastního. Umí jenom uživatele přidat a odebrat z mailing listu, neumí odeslat zprávu (to Sendy nativně nepodporuje, byť existuje jakýsi add-in, který by to měl dělat). Já nicméně nic takového nebudu v dohledné době potřebovat, zprávy budu posílat ručně přes webové GUI Sendy.

Moje třída je jednoduchá. V konstruktoru jí předáte výchozí adresu instalace Sendy a pak zavoláte jenom metodu Subscribe nebo Unsubscribe. ID distribučního seznamu najdete ve výpisu, je to dlouhý Base64-kódovaný řetězec.

Zdrojový kód třídy je následující:

    using System;
    using System.Net;
    using System.Web;

    public class Sendy {
        private const string PAYLOAD_FORMAT = "email={0}&list={1}&boolean=true";
        private const string CONTENT_TYPE = "application/x-www-form-urlencoded";
        private const string SUCCESS_STRING = "1";

        public Uri BaseUri { get; private set; }

        public Sendy(Uri baseUri) {
            if (baseUri == null) throw new ArgumentNullException("baseUri");
            if (!baseUri.IsAbsoluteUri) throw new ArgumentException("The URI must be absolute.", "baseUri");

            this.BaseUri = baseUri;
        }

        public void Subscribe(string email, string listId) {
            this.DoCommand(email, listId, "subscribe");
        }

        public void Unsubscribe(string email, string listId) {
            this.DoCommand(email, listId, "unsubscribe");
        }

        private void DoCommand(string email, string listId, string apiCommand) {
            if (email == null) throw new ArgumentNullException("email");
            if (string.IsNullOrWhiteSpace(email)) throw new ArgumentException("Value cannot be empty or whitespace only string.", "email");
            if (listId == null) throw new ArgumentNullException("listId");
            if (string.IsNullOrWhiteSpace(listId)) throw new ArgumentException("Value cannot be empty or whitespace only string.", "listId");

            // Prepare payload
            var payload = string.Format(PAYLOAD_FORMAT,
                HttpUtility.UrlEncode(email),   // 0
                HttpUtility.UrlEncode(listId)); // 1

            // Prepare URI
            var uri = new Uri(this.BaseUri, new Uri("/" + apiCommand, UriKind.Relative));

            using (var wc = new WebClient()) {
                wc.Headers.Add("Content-Type", CONTENT_TYPE);
                var s = wc.UploadString(uri, payload);
                if (!s.Trim().Equals(SUCCESS_STRING)) throw new Exception(s);
            }
        }

    }

Kombinací Sendy, Amazon SES a uvedeného API dokážete jednoduše a levně spravovat mailing listy v prostředí Windows Azure i lokálním.