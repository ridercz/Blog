<!-- dcterms:title = FTPS: bezpečná varianta prastarého protokolu -->
<!-- dcterms:abstract = Přes existenci lepších metod přenosu souborů a deploymentu tady s námi stařičký FTP je a ještě drahnou dobu zůstane. Doufejme, že povětšinou v šifrované variantě, implicitní nebo explicitní. Ukážeme si, jak se tyto varianty liší a jak je na IIS použít. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:dateAccepted = 2018-08-15 -->
<!-- x4w:category = IT -->
<!-- x4w:pictureUrl = /perex-pictures/20180815-ftps.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureCredits = Photo by Harry Pears via Flickr, CC-BY-SA -->

FTP, alias "File Transfer Protocol" je jeden z nejstarších síťových protokolů, které dnes používáme. Jeho první verze byla standardizována jako [RFC 114](https://tools.ietf.org/html/rfc114) již v roce 1971, tedy několik let předtím, než se zrodilo to, co dnes nazýváme Internetem. Má relativně komplikovanou sturkturu a nerozumí si moc dobře s firewally (což bylo později poněkud vylepšeno podporou pasivního režimu).

## Zabezpečení FTP

Ve své původní podobě nedisponuje žádným zabezpečením, které by stálo za řeč. Autentizace serveru neexistuje žádná, uživatelé se autentizují pouze jménem a statickým heslem, které se po síti přenáší v otevřené podobě, takže jej lze zjistit primitivním odposlechem. Obecně lze provoz klasického FTP serveru na Internetu dnes chápat jako hazardérství. Existují proto různé postupy, jak FTP zabezpečit.

Prvním z nich je **SFTP**, což je bohužel zkratka mající několik významů. Prvním a dnes zapomenutým je _Simple File Transfer Protocol_, dnes již zapomenutý standard definovaný v [RFC 913](https://tools.ietf.org/html/rfc913), který se nikdy příliš nerozšířil. Druhý význam je _FTP over Secure Shell_, kdy se klasický FTP tuneluje skrze SSH, protokol pro bezpečnou komunikaci používaný zejména na Linuxu a podobných systémech. Ani tento protokol se příliš nerozšířil, což je dobře, protože klasické implementace chránily pouze kanál pro přenos příkazů, nikoliv data. Protokol tedy ochránil vaše heslo, ale ne přenášená data, před odposlechem nebo modifikací.

Když se dnes bavíme o SFTP nebo **SecureFTP**, obvykle to znamená _SSH File Transfer Protocol_, což je protokol, který má s klasickým FTP společný jenom název a lze jej chápat spíše jako rozšíření linuxového **SCP** (Secure Copy Protocol). Jeho vývoj probíhal dosti živelně a do dnešního dne není definitivně standardizován. Windows ani IIS jej standardně nepodporují ani jako server, ani jako klient a nebudeme se jím proto nadále zabývat.

## FTPS

Bude nás zajímat **FTPS**. Pokud má nějaký protokol na konci písmeno _S_, zpravidla to znamená, že je dodatečně zabezpečen pomocí SSL nebo TLS (dnes tedy TLS, protože všechny existující verze SSL jsou dnes pokládány za nebezpečné). FTPS umí fungovat ve dvou režimech.

Prvním a služebně starším je **Implicit FTPS**. Ten funguje velmi jednoduše: jako první je nutné ustavit zabezpečený komunikační kanál prostřednictvím TLS. Teprve poté, co je vytvořeno toto bezpečné spojení, které lze s trochou nadsázky možné přirovnat k VPN, je tímto kanálem bez jakékoliv úpravy prohnáno klasické FTP spojení. Je to stejná logika, s jakou se setkáme třeba u běžného HTTPS.

Implicitní FTPS běží typicky na portech 990/TCP (FTPS control) a 989/TCP (FTPS data). Jistou výhodou tohoto protokolu je, že od firewallu nevyžaduje žádné aktivní porozumění, stačí když tento nebude blokovat uvedené dva porty.

Novější variantu představuje **Explicit FTPS**, označovaný někdy také zkratkou **FTPES**. Tento protokol běží na stejných portech 21/TCP (FTP control) a 20/TCP (FTP data), které používá běžné FTP. Klient má nicméně možnost požádat o "upgrade" spojení a přejít na šifrovanou verzi. 

## FTPS v IIS

IIS podporuje oba dva režimy a přepíná mezi nimi automaticky, na základě čísla portu. Pokud jako číslo portu uvedete 990, použije se implicitní TLS, pokud jakékoliv jiné, použije se explicitní TLS.

Pokud tedy chcete provozovat maximálně kompatibilní FTPS server, musíte vytvořit dva prakticky totožné virtuální servery. Budou mít stejné nastavení, ale budou se lišit pouze číslem portu. Jeden bude mít jako port 21 a druhý 990.

IIS podporuje FTPS od verze 7.0, tedy již deset let. Přesto se lze stále setkat s případy, kdy příkladmo poskytovatelé hostingu nabízejí pouze dnes již nebezpečné FTP. 

Podrobnější informace o konfiguraci FTPS v IIS najdete na [docs.microsoft.com](https://docs.microsoft.com/en-us/iis/configuration/system.applicationhost/sites/site/ftpserver/security/ssl)