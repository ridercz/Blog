<!-- dcterms:identifier = aspnetcz#12 -->
<!-- dcterms:title = IIS 7: Per aspera ad astra -->
<!-- dcterms:abstract = Další důvod proč se učit psát HTTP moduly se jmenuje IIS 7 - nová generace web serveru od Microsoftu -->
<!-- np9:categoryId = 4 -->
<!-- x4w:category = IT -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2005-01-12T23:15:30.547+01:00 -->
<!-- dcterms:dateAccepted = 2005-01-12T23:15:30.547+01:00 -->

*Per aspera ad astra* - tedy "utrpením ke hvězdám" - je dle mého názoru docela přesný popis způsobu, jakým se vyvíjel webový server od Microsoftu - Internet Information Services. Moje první setkání s IIS se uskutečnilo ve verzi 2.0 (byla součástí Windows NT 4.0). Používat ji bylo opravdové utrpení, které příliš nezměkčil ani SP3 (tuším) na NT Server, který IIS upgradoval na verzi 3.0.

IIS verze 4.0 byl součástí Windows NT Option Packu a znamenal z pohledu webu na Windows platformě revoluci - konečně bylo možné na NT provozovat trochu slušný web server. Žel bohu, v případě že se jednalo o server zatíženější, musel vedle něj stát administrátor a podpírat ho, aby nespadl.

![Fotografie pavučiny](https://www.cdn.altairis.cz/Blog/spiderweb.jpg "Photo by slonecker / sxc.hu, used by permission")Součástí Windows 2000 se stal IIS 5. Že se poslední slovo názvu změnilo ze "server" na "services" byla nejméně podstatná změna. Pomineme-li onu [trapnou záležitost](http://archives.neohapsis.com/archives/ntbugtraq/2000-q3/0080.html) s chybou Translate:F, jednalo se o velmi dobře použitelný web server.

Současná aktuální verze IIS 6.0 (součást Windows 2003) se - dle mého názoru - nevyznačuje zásadními problémy. Drobnosti by se však našly.

Soubor `MetaBase.xml`, tedy úložiště konfiguračních informací o serveru, je jednou z těch, které mi obzvláště pijí krev. Ačkoliv je to lepší, než onen podivný binární formát v IIS 4 či 5, je metabáze příkladným důkazem skutečnosti, že formát XML není samospasitelný, a že ani well-formed XML formát nemusí znamenat, že se ve výsledku někdo vyzná.

## IIS 7 se odhaluje

Dnes večer jsem se zúčastnil neveřejného chatu s vývojáři nového IISka. Bylo nám dovoleno poodhalit něco z tajemství budoucnosti. Vzhledem k tomu, co jsem se dozvěděl, tak činím s nevšední radostí. Tři hlavní přednosti nové verze jsou:

*   Přehlednějši konfigurace, založená na distribuovaném modelu známém z .NET. 
Modularita (instalujete jenom to co skutečně potřebujete) a snadná rozšiřitelnost. 
    *Mnohem* lepší konfigurační nástroje.

### Přehlednější konfigurace

Konfigurace IIS bude uložena v XML formátu s využitím jeho předností (už žádné sáhodlouhé seznamy hodnot oddělené čárkami!) Parametry web serveru bude možno nastavit přímo v souboru `web.config`, stejně jako je tomu u .NET aplikací. V tomto XML souboru bude možno nastavit všechny parametry webu, jako například mapování přípon na různé HTTP handlery, povolení či zakázání directory browsingu v různých adresářích a podobně.

### Modularita a rozšiřitelnost

Psaní rozšíření do IIS (ISAPI filtrů) je v současné době činnost opředená mnohými pověstmi a tajemstvími a hodně nevděčná. O jejich instalaci a konfiguraci nemluvě. ASP.NET [HTTP handlery a moduly](/entry/article-20050110.aspx) bude nyní možno zakomponovat přímo do IIS. Bude tedy například možno snadno používat forms autentizaci pro statické nebo obecně ne-.NET soubory.

Modularita znamená také to že můžete mít jenom to, co opravdu potřebujete. V rámci aplikační konfigurace bude možno nezávisle vyhodit moduly, které nechcete či nepotřebujete. Pokud má vaše aplikace sloužit jenom jako publikační místo pro web services, odstraníte všechny ostatní moduly, včetně např. statických souborů.

### Lepší konfigurační nástroje

Ne každý je fanouškem ručního psaní XML konfigurace, proto bude v IIS 7 nové a lepší GUI pro administraci. Má do jisté míry spojovat konfiguraci IIS a .NET aplikací (budete moci např. přímo vytvářet uživatele a skupiny pro webovou autentizaci). Rozhraní obsahuje větší množství roztomilých průvodců pro běžné úlohy a - naštěstí - i jedno velké okno, kde jsou formou property gridu zobrazeny všechny konfigurační parametry. Komunikace bude možná i vzdáleně, prostřednicvím web service.

Ochutnávku tohoto rozhraní můžete mít již dnes, konfigurace je koncepčně velmi podobná tomu co se nachází ve veřejné betě VS.NET 2005 Express.