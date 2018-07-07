<!-- dcterms:identifier = aspnetcz#59 -->
<!-- dcterms:title = Vytváření vlastních parametrů podruhé - "bezpečný" query string parametr -->
<!-- dcterms:abstract = Pokud použijete strongly-typed parametry pro data binding a předanou hodnotu nebude možno na požadovaný typ převést, dojde k výjimce. Pokud si informace o výjimkách ve své aplikaci necháte posílat e-mailem, můžete být brzo zaplaveni zprávami právě o tomto typu chyb. Vyhnout se tomu lze právě pomocí vlastního parametru. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Tipy, triky -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2005-11-09T03:21:35.817+01:00 -->
<!-- dcterms:dateAccepted = 2005-11-09T03:21:35.817+01:00 -->

V článku [Tvorba vlastního parametru pro data binding v ASP.NET 2.0](/entry/article-20051005.aspx) jsem popisoval, kterak lze vytvořit vlastní parametr pro deklarativní data binding, novinku to v nové verzi ASP.NET. Obdobnou metodu je možno použít k odstranění problému, který mne štve od doby, co jsem ASP.NET 2.0 prakticky nasadil.

Pokud použijete strongly-typed parametry pro data binding a předanou hodnotu nebude možno na požadovaný typ převést, dojde k výjimce. Což je v zásadě v pořádku. Situace, kdy aplikace vyhodí výjimku, by však neměly zůstat nepovšimnuty jejím tvůrcem. Dobrou cestou je například nechat si informace o chybách posílat e-mailem. Pokud tak učiníte, budete ovšem zakrátko zaplaveni velkým množstvím zpráv, které vygenerují požadavky na chybná URL, typicky v případě adres zaslaných e-mailem (a tedy nějak poškozených), jistých tupějších robotů a podobně.

Řešením je napsat si vlastní typ parametru, který si s takovou situací dokáže graciézně poradit. V následujícím příkladu řeším případ načítání hodnoty z Query Stringu, tedy QueryStringParameter. Obdobnou logiku je možno využít pro všechny ostatní zdroje - cookies, forms atd.

## Vytvoření třídy SafeQueryStringParameter

Zdrojový kód vypadá následovně:

Namespace MyControls Public Class SafeQueryStringParameter Inherits System.Web.UI.WebControls.QueryStringParameter Protected Overrides Function Evaluate(ByVal context As System.Web.HttpContext, ByVal control As System.Web.UI.Control) As Object Try Return System.Convert.ChangeType(MyBase.Evaluate(context, control), Me.Type) Catch ex As Exception Return Me.DefaultValue End Try End Function End Class End Namespace

Stejně jako ve shora uvedeném článku upozorňuji na nutnost umístit naši třídu do namespace. Je vcelku jedno, jak se bude jmenovat, ale musí nějaký být.

Kód sám je velmi jednoduchý. Nová třída `SafeQueryStringParameter` jest poděděna od běžné `System.Web.UI.WebControls.QueryStringParameter`. Metodu `Evaluate()` jsem přepsal tak, že se pokusí zadanou hodnotu převést na požadovaný typ. Standardní `QueryStringParameter` v reaguje na neúspěch v tomto směru výjimkou, moje třída vrátí `DefaultValue`, tedy stejnou hodnotu, jako kdyby předmětný parametr nebyl v URL přítomen vůbec.

Není to samozřejmě jediné řešení. Můžete se pokusit v případě jednodušších typů heuristicky odhadnout, co chtěl básník říci (například odfiltrováním nečíselných znaků). Případně můžete vyhodit svou vlastní výjimku (exception) a přepsat aplikaci tak, aby na výskyt této konkrétní výjimky reagovala nikoliv zasláním e-mailu, ale zobrazením nějakého duchaplného návodného textu ohledně pravděpodobně poškozeného URL.

## Použití v ASP.NET stránkách

Nově deklarovaný parametr je možno použít v ASP.NET stránkách naprosto stejným způsobem, který jsem popsal v závěru [minulého článku](/entry/article-20051005.aspx). Vzhledem k tomu, že takto vytvořený prvek bude patrně třeba používat na mnoha stránkách (místo standardního parametru), bude ale vhodnější použít jiný postup. Registraci uživatelského ovládacího prvku je možno provést v souboru `web.config` s platností pro celou aplikaci:

<?xml version="1.0"?> <configuration> <system.web> <pages> <controls > <add tagPrefix="moje" namespace="MyControls" /> </controls> </pages> </system.web> </configuration>

Potom je možno ovládací prvek používat ve všech stránkách dané aplikace, aniž by bylo nutno ho v každé z nich výslovně zvlášť registrovat.

Vzhledem k tomu, že dialogy ve Visual Studiu nepodporují uživatelsky definované parametry při vytváření dotazů (prý v další verzi), doporučuji postupovat tak, že při vývoji použijete normální parametry a teprve po odladění dané části aplikace pomocí funkce Replace nahradíte veškeré řetězce `asp:QueryStringParameter` řetězcem `moje:SafeQueryStringParameter`.