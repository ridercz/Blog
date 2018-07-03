<!-- dcterms:identifier = aspnetcz#5442 -->
<!-- dcterms:title = Centralized SSL Certificates v IIS: Proč a jak je používat -->
<!-- dcterms:abstract = Často se mluví o “HTTPS Everywhere” a jedním z pozitivních trendů dnešní doby je snaha maximálně využívat HTTPS pokud možno všude a pokud možno by default. IIS od verze 8.0 (Windows 2012) disponuje funkcí Centralized SSL Certificates, která dovoluje práci s certifikáty velice výrazně usnadnit. V tomto článku vám ukážu postup krok za krokem, jak tuto funkci nastavit a používat. -->
<!-- np9:categoryId = 4 -->
<!-- x4w:category = IIS -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2016-01-31T00:12:08.447+01:00 -->
<!-- dcterms:dateAccepted = 2016-01-31T00:00:00+01:00 -->
<!-- x4w:pictureWidth = 149 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20160131-centralized-ssl-certificates-v-iis-proc-a-jak-je-pouzivat.jpg -->

Často se mluví o “HTTPS Everywhere” a jedním z pozitivních trendů dnešní doby je snaha maximálně využívat HTTPS pokud možno všude a pokud možno by default. IIS od verze 8.0 (Windows 2012) disponuje funkcí Centralized SSL Certificates, která dovoluje práci s certifikáty velice výrazně usnadnit. V tomto článku vám ukážu postup krok za krokem, jak tuto funkci nastavit a používat.

## Co to je a proč to chcete použít?

Dosavadní typický způsob práce se serverovými certifikáty je, že se ukládají do systémového úložiště (certificate store). S ním se manipuluje pomocí speciálního API a GUI nástrojů. Což je fajn pokud HTTPS weby máte na svém serveru dva. Ale co když jich tam máte desítky nebo stovky? Případně máte serverů hodně a potřebujete certifikáty mezi nimi synchronizovat?

V takovém případě by bylo lepší, kdyby certifikáty (a jejich privátní klíče) byly uloženy čistě souborově, na nějakém vhodném místě (nejlépe sdíleném). Pracovalo by se s nimi čistě pomocí standardní manipulace se soubory. No a přesně tuto funkcionalitu nabízí Centralized Certificate Store (CCS). Je určen zejména pro webové farmy (kde se všechny serveru odkazují na jedno síťové úložiště), ale s výhodou jej využijete i u většího hostingového serveru.

Bohužel je v názvosloví poněkud zmatek. Někde se tato funkce jmenuje *Centralized SSL Certificates*, jinde *Central* (nebo *Centralized*) *Certificate Store* a různé další varianty. Jedná se ale vždy o tutéž věc.

## Praktický návod krok za krokem

Nabízím vám kompletní lab, návod krok za krokem, kterak rozjet hromadu HTTPS webů na IIS. Můžete si to vyzkoušet na nějakém virtuálu na hraní nebo třeba v Azure VM. Vše je připraveno pro Windows Server 2012 R2, ale mělo by to fungovat i na “R1”. V praxi samozřejmě nebudete používat tento postup celý, ale použijete jenom části, které budete potřebovat.

**» Veškeré potřebné soubory najdete v archivu [20160131-CSS.zip](http://www.aspnet.cz/files/20160131-CCS.zip).**

### Vytvoření a nastavení webů

Tento příklad počítá s tím, že máte kontrolu nad DNS resolvingem a dokážete si potřebné ukázkové DNS záznamy nasměrovat na IP adresu vašeho web serveru. Pokud takovou kontrolu nemáte nebo se s tím nechcete moc mazat a stačí vám lokálně fungující demo, stačí editovat obsah souboru `C:\Windows\System32\drivers\etc\hosts` (soubor nemá příponu). Přidejte na jeho konec následující text:

127.0.0.1 www.northwind.com 127.0.0.1 northwind.com 127.0.0.1 www.contoso.com 127.0.0.1 contoso.com 127.0.0.1 www.example.com 127.0.0.1 example.com 127.0.0.1 www1.example.com 127.0.0.1 www2.example.com 127.0.0.1 www3.example.com 127.0.0.1 www4.example.com 127.0.0.1 www5.example.com

Tím zajistíte, že se DNS jména jako `northwind.com` apod. budou překládat na vámi určenou adresu. V tomto případě na `127.0.0.1`, tedy `localhost`.

Dále pak si vytvořte osm ukázkových webů, se kterými budete dále pracovat. Budou to weby jménem `www1.contoso.com` až `www5.contoso.com` (název webu odpovídá host name, který na něj ukazuje). Dále pak webu `www.northwind.com`, `www.contoso.com` a `www.example.com`, přičemž na ně bude ukazovat příslušný hostname a zároveň totéž ve verzi bez `www` na začátku, tj. např. jen `northwind.com`.

Na obsahu těchto webů nezáleží. Pokud je necháte prázdné, bude vám server vracet chybu 403, což z hlediska HTTPS nevadí. V souboru s příklady najdete stránku `default.aspx`, která vypíše základní informace o svém webu, takže ji můžete použít. Také tam najdete skript `1_create_websites.cmd`, který po spuštění weby vytvoří.

Výsledek by měl v IIS manageru vypadat nějak takto:

[![Screenshot](http://www.aspnet.cz/Files/20160131-SNAGHTML51fe537_thumb.png "IIS Manager po vytvoření webů")](http://www.aspnet.cz/Files/20160131-SNAGHTML51fe537.png)

Pokud se nyní podíváte na některou z výše uvedených adres, web by měl fungovat a zobrazit váš obsah.

### Instalace Centralized Certificate Store

CCS není součástí výchozí instalace, takže ho možná nemáte nainstalovaný. Ověřte si to tak, že se na úrovni web serveru podíváte na nainstalované snap-iny. Měli byste v sekci Management vidět ikonu Centralized Certificates: 

[![Screenshot](http://www.aspnet.cz/Files/20160131-image_thumb.png "Centralized Certificates v IIS Manageru")](http://www.aspnet.cz/Files/20160131-image_2.png)

Pokud tomu tak není, musíte si to nainstalovat. Buďto pomocí rozhraní pro správu rolí ve Windows a nebo pomocí [Web Platform Installeru](https://www.microsoft.com/web/platform/):

[![Screenshot](http://www.aspnet.cz/Files/20160131-image_thumb_1.png "Instalace CCS pomocí Web Platform Installeru")](http://www.aspnet.cz/Files/20160131-image_4.png)

Dále vytvořte složku, do níž budete ukládat certifikáty. Například `C:\CentralCertStore`. Může být i na síťovém disku, zejména v případě webových farem. Nastavte této složce práva tak, aby se do ní dostal jenom vámi pro tento účel vytvořený uživatel. Pro účely demonstrace budu používat uživatele `Administrator`, ale to není dobrý nápad pro produkci.

Poklepejte v IIS Manageru na ikonu *Centralized Certificates* a pak v pravém panelu na *Edit Feature Settings*. V následném dialogu nastavte cestu k úložišti a uživatelské jméno a heslo, které se má použít pro přístup k němu:

[![Screenshot](http://www.aspnet.cz/Files/20160131-image_thumb_2.png "Konfigurace CCS")](http://www.aspnet.cz/Files/20160131-image_6.png)

Pole v sekci *Certificate Private Key Password* nechte prázdná. Naše PFX soubory nebudeme chránit heslem. Na první pohled to vypadá jako bezpečnostní riziko, ale celý princip CCS tkví v souborovém systému a jeho ochraně. Dodatečné heslo sice lze zadat, ale musí být pro všechny PFX soubory stejné a pokud útočník získá přístup k nastavení serveru na takové úrovni, je to stejně game over.

### Získání potřebných certifikátů

V praxi budete postupovat podle instrukcí vámi zvolené certifikační autority. Podstatné je jenom to, abyste na konci měli k dispozici soubory ve formátu PFX, které budou obsahovat (pouze) serverový certifikát a jeho privátní klíč a nebudou chráněny heslem (nebo budou chráněny tím heslem, které jste zadali v předchozím kroku).

Já pro náš příklad používám postup popsaný v článku [Certifikační autorita snadno a rychle](http://www.aspnet.cz/articles/345-certifikacni-autorita-snadno-a-rychle). Ve staženém souboru se o vygenerování ukázkových klíčů a nakopírování PFX souborů do adresáře `C:\CentralCertStore` postará dávka `2_make_all_certs.cmd`. Ta zároveň vytvoří testovací kořenovou certifikační autoritu a označí ji na daném počítači jako důvěryhodnou. Což rozhodně *nechcete* dělat na produkčním serveru!

### Správné pojmenování souborů

U CCS extrémně záleží na správném pojmenování souborů. Všechny musejí mít příponu `.pfx` a jejich název musí dodržovat následující pravidla:

*   Název zásadně odpovídá použitému host name, s příponou `.pfx`. 
*   Pokud jeden certifikát obsluhuje několik různých host names (např. verzi s i bez “`www`” na začátku), musí se jeho soubor v adresáři nacházet dvakrát s odpovídajícími názvy. 
*   Pokud se jedná o wildcard certifikát, je hvězdička nahrazena podtržítkem. Tj. je-li certifikát vydán pro `*.example.com`, bude se odpovídající soubor jmenovat `_.example.com.pfx`.  

Poté co skončíte, měl by váš adresář vypadat nějak takto:

[![Screenshot](http://www.aspnet.cz/Files/20160131-SNAGHTML539bd9b_thumb.png "Soubory v CCS adresáři")](http://www.aspnet.cz/Files/20160131-SNAGHTML539bd9b.png)

### Nastavení HTTPS bindingu webu

Nyní můžete běžným způsobem nastavit HTTPS binding webu. Všimněte si, že vám přibylo nové zaškrtávací pole *Use Centralized Certificate Store* a pokud ho zaškrtnete, zmizí možnost (nutnost) vybrat konkrétní certifikát. Bude vybrán automaticky podle host name a názvu souboru:

[![Screenshot](http://www.aspnet.cz/Files/20160131-image_thumb_3.png "Ruční konfigurace HTTPS bindingu")](http://www.aspnet.cz/Files/20160131-image_8.png)

V tomto příkladu používám SNI (Server Name Indication) a všechny HTTPS weby mi běží na jedné IP adrese a portu. SNI nicméně používat nemusíte, máte-li dostatek IP adres (což nejspíš nemáte). Všechny současné prohlížeče SNI podporují.

Pokud máte webů hodně, asi se vám nebude chtít je nastavovat takto po jednom. V takovém případě můžete použít PowerShell a HTTPS binding nastavovat z příkazové řádky následujícím příkazem:

`powershell New-WebBinding -Name www.northwind.com -Protocol https -Port 443 -HostHeader www.northwind.com -SslFlags 3`

Význam parametrů je následující:

*   `-Name` je logický název webu tak, jak je definován v IIS 
*   `-Protocol` je vždy (pro v článku popisované účely) `https` 
*   `-Port` je ve výchozím nastavení `443` 
*   `-HostHeader` je hostname při využití SNI 
*   `-SslFlags` je numerická hodnota, která nabývá následujících hodnot 

    *   `0` = vazba na IP:port, systémové úložiště certifikátů 
    *   `1` = použití SNI, systémové úložiště certifikátů 
    *   `2` = vazba na IP:port, CCS 
    *   `3` = použití SNI, CCS (což je náš případ)   

Seznam webů včetně bindingů by měl nyní vypadat nějak takto (povšimněte si, že všem webům přibyly HTTPS bindingy):

[![Screenshot](http://www.aspnet.cz/Files/20160131-SNAGHTML5ca5e25_thumb.png "Seznam webů s HTTPS bindingy")](http://www.aspnet.cz/Files/20160131-SNAGHTML5ca5e25.png)

### Povolení CCS v HTTP.SYS

Pokud nastavujete parametry pomocí GUI IIS Manageru, mělo by nyní vše začít fungovat, protože IIS Manager automaticky přidává potřebné nastavení do `HTTP.SYS`. Nicméně pokud jste přidali vazby z příkazové řádky, je nutné ručně napojit `HTTP.SYS` (komponenta operačního systému, která se stará o zpracování HTTP transakcí) na CCS.

Zda byla vazba provedena zjistíte příkazem `netsh http show sslcert`:

[![Screenshot](http://www.aspnet.cz/Files/20160131-image_thumb_4.png "Kontrola vazby na HTTP.SYS")](http://www.aspnet.cz/Files/20160131-image_10.png)

Pokud je CCS navázán na `HTTP.SYS`, najdete v seznamu SSL certificate bindings položku, která má prázdný `Certificate Hash` a je uvozena `Central Certificate Store` s hodnotou, která odpovídá číslu portu. V případě že takovou položku nenajdete, musíte ji přidat následujícím příkazem:

`netsh http add sslcert ccs=443 appid={7276352B-8070-4B14-822A-4B72E20F0DBE}`

Hodnota za `appid=` je jakýkoliv GUID – jde o identifikátor bindingu a jediným požadavkem je, že musí být unikátní.

Vytvoření bindingů v IIS i CCS dělá ve staženém souboru dávka `3_add_iis_bindings.cmd`.

### Kontrola nastavení

Když se nyní podíváte na snap-in Centralized Certificates, uvidíte seznam všech dostupných certifikátů:

[![Screenshot](http://www.aspnet.cz/Files/20160131-SNAGHTML5d3d760_thumb.png "Výpis certifikátů v CCS")](http://www.aspnet.cz/Files/20160131-SNAGHTML5d3d760.png)

Pokud se podíváte z browseru na kteroukoliv z adres pomocí protokolu HTTPS, zobrazí se vám stránka správně s použitím správného certifikátu:

[![Screenshot](http://www.aspnet.cz/Files/20160131-SNAGHTML5d5b5a6_thumb.png "HTTPS web pomocí CCS")](http://www.aspnet.cz/Files/20160131-SNAGHTML5d5b5a6.png)

Pokud budete nyní chtít provést jakoukoliv změnu (např. obnovu expirujícího certifikátu), stačí změnit příslušný soubor ve složce, do níž ukazuje konfigurace CCS. Změna se provede na všech napojených serverech zároveň.