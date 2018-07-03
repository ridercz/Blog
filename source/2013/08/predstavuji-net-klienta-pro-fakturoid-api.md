<!-- dcterms:identifier = aspnetcz#4408 -->
<!-- dcterms:title = Představuji .NET klienta pro Fakturoid API -->
<!-- dcterms:abstract = Léta jsem používal pro vystavování faktur a související činnosti vlastní webovou aplikaci. Teď jsem našel službu Fakturoid, která dělá totéž lépe a umí skoro všechno, co ta moje. A co neumí, to se dá napsat pomocí jejího API, pro které jsem napsal .NET klienta, kterého tímto dávám jako open source k dispozici. -->
<!-- np9:categoryId = 7 -->
<!-- x4w:category = Software -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2013-08-05T20:07:12.287+02:00 -->
<!-- dcterms:dateAccepted = 2013-08-05T20:07:12+02:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20130805-predstavuji-net-klienta-pro-fakturoid-api.png -->

Léta jsem používal pro vystavování faktur a související činnosti vlastní webovou aplikaci. Teď jsem našel službu [Fakturoid](http://www.fakturoid.cz/), která dělá totéž lépe a umí skoro všechno, co ta moje. A co neumí, to se dá napsat pomocí jejího API, pro které jsem napsal .NET klienta, kterého tímto dávám jako open source k dispozici.

Fakturoid nabízí [docela příjemné API](https://github.com/fakturoid/api). Je to vcelku příčetné REST rozhraní s JSON serializací a docela dobře funguje s klientskou knihovnou pro ASP.NET Web API. Některé aspekty serializace jsou trochu podivné a nejsem si jist 100% správností typů (které nejsou publikované a je na fantazii implementátora, jak si s nimi poradí), ale v zásadě by to mělo fungovat.

Rád bych poděkoval technické podpoře fakturoidího robota, protože je nejlepší, s jakou jsem se poslední dobou setkal. Odpovědi k věci a většinou prakticky obratem.

Moje API najdete na [GitHubu](https://github.com/ridercz/Fakturoid-API) (nojo, nakazil jsem se tou nemocí taky) a je k dispozici i jako NuGet balíček <strong abp="336">Altairis.Fakturoid.Client**.

## Ukázka použití

[Ukázkovou aplikaci](https://github.com/ridercz/Fakturoid-API/blob/master/Altairis.Fakturoid.Client.DemoApp/Program.cs) (stejně jako [dokumentaci](https://github.com/ridercz/Fakturoid-API/blob/master/Documentation.chm?raw=true)) najdete na GitHubu, já níže nabídnu jenom ukázku, jak se s knihovnou pracuje:

// Vytvořit instanci API klienta var fc = new FakturoidContext("username", "apitoken", "Název aplikace (me@example.com)"); // Vytvořit instanci třídy, která reprezentuje nový kontakt var newSubject = new JsonSubject { name = "ACME, s. r. o.", street = "Testovací 123", city = "Praha", zip = "11000", country = "CZ", registration_no = "12345678", vat_no = "CZ12345678", email = "acmecorp@mailinator.com" }; // Pomocí API vytvořit kontakt a získat jeho ID var newSubjectId = fc.Subjects.Create(newSubject); // Vytvořit instanci třídy, která reprezentuje fakturu var newInvoice = new JsonInvoice { subject_id = newSubjectId, lines = new List<jsoninvoiceline abp="342">(), }; // Přidat do ní nějaké položky newInvoice.lines.Add(new JsonInvoiceLine { name = "Položka 1", quantity = 1, unit_name = "ks", unit_price = 100, vat_rate = 21 }); newInvoice.lines.Add(new JsonInvoiceLine { name = "Položka 2", quantity = 3, unit_name = "hod.", unit_price = 1234, vat_rate = 21 }); // Pomocí API fakturu vytvořit var newInvoiceId = context.Invoices.Create(newInvoice); // ...a odeslat e-mailem context.Invoices.SendMessage(newInvoiceId, InvoiceMessageType.InvoiceMessage);</jsoninvoiceline>

Základní tarif (omezený na 5 zákazníků, ale bez omezení na počet faktur) je zdarma, další jsou za ceny velmi nízké a uživatelsky přítulné, takže mohu doporučit minimálně na vyzkoušení.
</strong>