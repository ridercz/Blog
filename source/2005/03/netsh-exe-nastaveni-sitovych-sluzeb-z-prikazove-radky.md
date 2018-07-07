<!-- dcterms:identifier = aspnetcz#24 -->
<!-- dcterms:title = NETSH.EXE - nastavení síťových služeb z příkazové řádky -->
<!-- dcterms:abstract = Nastavovat komplikované filtrování portů na jednom počítači přes GUI je opruz. Dělat totéž na osmi je na sebevraždu. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Tipy, triky -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2005-03-13T04:07:26.567+01:00 -->
<!-- dcterms:dateAccepted = 2005-03-13T04:07:26.567+01:00 -->

Poslední dobou se věnuji jistému šílenému projektu, jehož součástí bylo mimo jiné nainstalovat osm broadcastových serverů. Každý z nich má tři síťové karty připojené do třech různých sítí, a na každém rozhraní jsou nastavena jiná pravidla filtrování portů (firewallu). Společné mají jenom to, že jsou velmi komplikovaná.

Nastavovat komplikované filtrování portů na jednom počítači přes GUI je opruz. Dělat totéž na osmi je na sebevraždu.

Naštěstí je přímo součástí operačního systému řádková utilitka NETSH.EXE. Pomocí jejích příkazů můžete nastavit všechny parametry týkající se síťových rozhraní. Základní informace o něm najdete v [Q242468](http://support.microsoft.com/Default.aspx?kbid=242468).

Nejjednodušším způsobem použití je pomocí příkazu `NETSH dump > soubor.txt` vypsat vaši aktuální konfiguraci do souboru, vymazat vše co nepotřebujete, upravit zbytek a pak to zase příkazem `NETSH < soubor.txt aplikovat`.

Následující konfigurační soubor nastaví na rozhraní vnější sítě (pokud se bude jmenovat *LAC External*) poměrně restriktivní sadu pravidel:

# IP Configuration pushd routing ip reset set loglevel error add preferenceforprotocol proto=LOCAL preflevel=1 add preferenceforprotocol proto=STATIC preflevel=3 add preferenceforprotocol proto=NONDOD preflevel=5 add preferenceforprotocol proto=AUTOSTATIC preflevel=7 add preferenceforprotocol proto=NetMgmt preflevel=10 add preferenceforprotocol proto=OSPF preflevel=110 add preferenceforprotocol proto=RIP preflevel=120 add interface name="LAC External" state=enable add interface name="LAC Internal" state=enable set filter name="LAC External" fragcheck=disable set filter name="LAC Internal" fragcheck=disable add interface name="Internal" state=enable set filter name="Internal" fragcheck=disable add interface name="Loopback" state=enable set filter name="Loopback" fragcheck=disable # Zakázat vše, co není explicitně povoleno set filter name="LAC External" filtertype=INPUT action=DROP # Povolit TCP-Established add filter name="LAC External" filtertype=INPUT srcaddr=0.0.0.0 srcmask=0.0.0.0 dstaddr=0.0.0.0 dstmask=0.0.0.0 proto=TCP-EST srcport=0 dstport=0 # Povolit HTTP (80/tcp), HTTPS (443/tcp), SMTP (25/tcp), POP3 (110/tcp) pro všechny add filter name="LAC External" filtertype=INPUT srcaddr=0.0.0.0 srcmask=0.0.0.0 dstaddr=0.0.0.0 dstmask=0.0.0.0 proto=TCP srcport=0 dstport=80 add filter name="LAC External" filtertype=INPUT srcaddr=0.0.0.0 srcmask=0.0.0.0 dstaddr=0.0.0.0 dstmask=0.0.0.0 proto=TCP srcport=0 dstport=443 add filter name="LAC External" filtertype=INPUT srcaddr=0.0.0.0 srcmask=0.0.0.0 dstaddr=0.0.0.0 dstmask=0.0.0.0 proto=TCP srcport=0 dstport=25 add filter name="LAC External" filtertype=INPUT srcaddr=0.0.0.0 srcmask=0.0.0.0 dstaddr=0.0.0.0 dstmask=0.0.0.0 proto=TCP srcport=0 dstport=110 # Povolit přístup na terminál jenom ze sítě Eurotel (příklad) add filter name="LAC External" filtertype=INPUT srcaddr=160.218.0.0 srcmask=255.255.0.0 dstaddr=0.0.0.0 dstmask=0.0.0.0 proto=TCP srcport=0 dstport=3389 popd # End of IP configuration