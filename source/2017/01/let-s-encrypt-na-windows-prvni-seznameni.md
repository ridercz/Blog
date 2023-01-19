<!-- dcterms:identifier = aspnetcz#5453 -->
<!-- dcterms:title = Let's Encrypt na Windows: První seznámení -->
<!-- dcterms:abstract = Asi jste již zaznamenali, že poslední dobou sílí snaha dostat maximum webů pod HTTPS. A k tomu jsou potřeba certifikáty, vydané důvěryhodnou certifikační autoritou. Řadu let jsem používat a doporučoval certifikační autoritu StartSSL, která vydávala běžné serverové i klientské certifikáty zdarma. Ta bohužel nyní přišla o svou důvěryhodnost v prohlížečích, neboť ji koupila čínská firma a začala vydávat certifikáty v rozporu s uznávanými pravidly. Řešením může být projekt Let's Encrypt, který vám chci představit v malém seriálu článků. -->
<!-- np9:categoryId = 4 -->
<!-- x4w:category = Bezpečnost -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2017-01-15T00:26:55.28+01:00 -->
<!-- dcterms:date = 2017-01-15T00:00:00+01:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/logo-letsencrypt.png -->

Asi jste již zaznamenali, že poslední dobou sílí snaha dostat maximum webů pod HTTPS. A k tomu jsou potřeba certifikáty, vydané důvěryhodnou certifikační autoritou. Řadu let jsem používat a doporučoval certifikační autoritu StartSSL, která vydávala běžné serverové i klientské certifikáty zdarma. Ta bohužel nyní přišla o svou důvěryhodnost v prohlížečích, neboť ji koupila čínská firma a začala vydávat certifikáty v rozporu s uznávanými pravidly. Řešením může být projekt Let's Encrypt, který vám chci představit v malém seriálu článků.

## Co je Let's Encrypt?

Historicky bylo HTTPS vzácnost, používané jenom na nejdůležitějších webech, technicky komplikované a drahé, certifikáty stály stovky dolarů za rok. Poté konkurence slačila ceny řádově na desítky dolarů a zjednodušila ověřování, takže se proces vydání certifikátu zkrátil ze dnů na hodiny. A nyní je čas na další revoluci: certifikáty zdarma, automaticky a během sekund.

To je vize neziskového projektu Let's Encrypt, který provozuje důvěryhodnou certifikační autoritu, která vydává bezplatné certifikáty každému kompletně automaticky. Automatizovaným způsobem pomocí HTTP nebo DNS ověří, že má žadatel kontrolu nad doménou a vydá mu certifikát. Celý proces si můžete ručně vyzkoušet třeba na webu [SSL for Free](https://www.sslforfree.com/).

Problém je, že zatímco certifikáty běžných autorit mají platnost obvykle 1-3 roky, Let's Encrypt vydává certifikáty na 90 dnů a do budoucna tento interval plánuje ještě zkrátit. Cílem totiž je vydávání certifikátů maximálně automatizovat. Idea je, že na serveru poběží aplikace, která bude vše automatizovat. Od toho je zde protokol ACME (Automated Certificate Management Environment), pomocí kterého klient (web server) a server (certifikační autorita, což nemusí být nutně jen Let's Encrypt) komunikují.

## Podpora na Windows

Nejpoužívanějším klientem pro Let's Encrypt je [Certbot](https://certbot.eff.org/) od EFF, který zajišťuje vše potřebné. Problém je, že nepodporuje Windows a IIS. Pro Windows existuje několik řešení (nejpoužívanější je asi [Letsencrypt-win-simple](https://github.com/Lone-Coder/letsencrypt-win-simple) a [ACMESharp](https://github.com/ebekker/ACMESharp), což je modul pro PowerShell), ale ani jedno z nich se mi nepodařilo spolehlivě a automatizovaně rozchodit pro větší počet webů.

Hlavní nevýhoda řešení pro Windows spočívá v tom, že jsou příliš křehké. Počítají se standardizovaným modelem aplikací, snaží se dělat moc věcí najednou (včetně instalace certifikátů a nastavení IIS) a selžou ve chvíli, kdy je třeba nějaké nestandardní řešení. Proto jsem se rozhodl postupně napsat vlastní aplikaci, která bude vycházet z jiných principů.

## AutoAcme

Moje aplikace se bude jmenovat AutoAcme a od výše uvedených se bude lišit určením i principem fungování. Hlavním smyslem této aplikace bude zcela bezobslužně nasadit HTTPS na velké množství webů, řádově stovky až tisíce, běžící na větším množství serverů. Budu přitom využívat některé specifické schopnosti Internet Information Services, nicméně můj proces bude univerzální a umožní automatickou změnu certifikátů i mimo webové prostředí.

ACME nabízí dvě možnosti ověření identity žadatele, resp. serveru. První je pomocí HTTP, kdy je třeba nahrát na daný server soubor se specifickým jménem (obecně */.well-known/acme-challenge/<ticket_id>*) a obsahem. Druhé je pomocí DNS, kdy je třeba vytvořit specifický TXT záznam. Metoda přes HTTP je obecně jednodušší, protože použití DNS vyžaduje kontrolu nad DNS servery a nějaké API pro práci s ním, což není úplně jednoduché.

AutoAcme použije pro ověření HTTP. Nicméně na rozdíl od výše uvedených řešení nebude nahrávat fyzické soubory do jednotlivých virtuálních webů. To je komplikované na webové farmě nebo při komplikovanějším zacházení s URL a podobně. Použije místo toho URL rewriting modul pro IIS a jednoduché nastavení na úrovni celého serveru, které bude všechny požadavky na ACME challenge interně směřovat na jeden specializovaný web server a tam je vyřizovat.

Další problém pak spočívá v nutnosti získaný certifikát a vygenerovaný privátní klíč zpřístupnit v IIS, tedy v práci se systémovým certificate storem, buďto Personal nebo Web Hosting. Dále pak je nutné překonfigurovat IIS tak, aby daný klíč použilo. Což není úplně jednoduché, opět na webových farmách nebo ve složitějších případech.

AutoAcme bude používat CCS – Central Certificate Store. To je funkce v IIS, která umožňuje certifikáty a klíče ukládat do adresáře na file serveru, bez nutnosti cokoliv instalovat. Pro změnu certifikátu stačí změnit soubor a není třeba nic měnit v konfiguraci IIS. CCS je určen především pro webové farmy, ale bez problémů ho lze nasadit na jeden server. Aplikace tedy bude ve skutečnosti docela jednoduchá, protože bude pracovat jenom se soubory.

Použití CCS také vyřeší ještě jeden častý problém: totiž dostupnost téhož webu pod několika různými DNS jmény. To se u certifikátů obvykle řeší více jmény v jednom certifikátu (ať už pomocí několika common names nebo pomocí Subject Alternative Name) nebo wildcard certifikáty. Wildcard certifikáty (**.example.com*)

AutoAcme si pro každý host name vyžádá samostatný certifikát, protože podle konceptu CCS stejně musí mít každý host name samostatný soubor, čímž tento problém obejde.

Certifikáty je nutné pravidelně obnovovat. Ať už ručně nebo automaticky. U Let's Encrypt vydrží jenom 90 dnů, takže spíše automaticky než ručně. Dále pak je nutné mít nějaké rozhraní, které si certifikát vyžádá poprvé a zařadí ho do seznamu pro automatickou obnovu.

AutoAcme bude neinteraktivní konzolová aplikace. Vše se bude řešit pomocí parametrů z příkazové řádky, což umožní snadnou automatizaci v podobě napojení na další systémy a skripty i automatické obnovování certifikátů prostým použitím systémového Task Scheduleru. Bude si držet interní databázi certifikátů v jednoduchém formátu (nejspíš XML nebo JSON) a jenom těmito certifikáty se bude zabývat. Nebude tedy žádným způsobem kolidovat s použitím jiných certifikátů (v CCS nebo mimo něj), pokud tyto budou na serveru nastaveny ručně nebo nějakým jiným mechanismem.

Certifikáty se používají nejenom pro HTTPS, ale i v řadě dalších případů: pro mail servery, FTP a podobně. Tam je nutné je nějakým specifickým způsobem nainstalovat a zkonfigurovat.

AutoAcme tento problém neřeší, ale ani jeho řešení nijak nebrání. Protože používá CCS, jsou certifikáty a jejich klíče ukládány ve standardním formátu PFX s předvídatelným názvem souboru (který odpovídá host name). Jakákoliv jiná aplikace tento soubor může využít přímo nebo lze napsat aplikaci, která klíče z něj použije libovolným způsobem.