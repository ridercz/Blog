<!-- dcterms:identifier = aspnetcz#340 -->
<!-- dcterms:title = Novinky ve Windows 8 a IIS 8 pro webové vývojáře -->
<!-- dcterms:abstract = Minulý týden byla na konferenci Build uvedena první testovací verze Windows 8. Většina dosavadních zpráv se zaměřila na nové Metro UI a rozličné kontroverze, které budou Windows 8 provázet. Já se s vámi chci podělit o dojmy z hlediska vyvojáře webových aplikací. -->
<!-- np9:categoryId = 4 -->
<!-- x4w:category = IIS -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2011-09-24T14:41:39.83+02:00 -->
<!-- dcterms:dateAccepted = 2011-09-24T14:41:41+02:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20110924-novinky-ve-windows-8-a-iis-8-pro-webove-vyvojare.png -->

Minulý týden byla na konferenci Build uvedena první testovací verze Windows 8. Většina dosavadních zpráv se zaměřila na nové Metro UI a rozličné kontroverze, které budou Windows 8 provázet. Já se s vámi chci podělit o první dojmy z hlediska vyvojáře webových aplikací.

Na úvod tradiční varování: píšu o velmi rané pre-release verzi, takže se všechno může změnit. Navíc píšu jenom o tom, co jsem sám objevil a zatím vyzkoušel a co jsem z toho vyvěštil. K serverové verzi jsem neobjevil žádné "what's new" dokumenty a třeba [IIS.NET](http://www.iis.net/) (oficiální web IIS) se tváří, jako by žádné IIS 8 neexistovalo. Když jsem se poptával, dozvěděl jsem se těžko pochopitelnou informaci, že i když software sám byl dán volně k dispozici, nemají lidé z MS povoleno zveřejňovat žádné další informace a články na blozích, nejspíš až do uveřejnění beta verze.

## Windows 8 Client

Začnu jednou novinkou klientské verze, protože by pro webové vývojáře mohla být velmi platná. Protože nově i klientská verze podporuje virtualizační platformu Hyper-V. Nevím, jak ostatní vývojáři, ale já při práci používám virtualizaci velmi často, protože mi umožňuje pohodlně simulovat různé složitá prostředí a konfigurace. 

V současné době používám jako virtualizační platformu [VirtualBox](http://www.virtualbox.org) od Sun/Oracle. Windows 7 sice disponují slušným *Windows Virtual PC*, ale to bohužel podporuje jenom 32-bitové guest operační systémy. Což je nepříjemné s přihlédnutím k tomu, že od Windows 2008 R2 jsou všechny serverové os jenom 64-bitové.

Hyper-V je v současné době serverová virtualizační platforma. Nutno říct, že velmi dobrá (tento web ostatně běží na Hyper-V virtualizovaném serveru). Nicméně pro mne na klientu nepoužitelná, protože instalace odstaví power management, takže si to nemohu nainstalovat na notebook. Windows 8 Client Hyper-V podporuje a zdá se, že nemá problémy ani s power managementem (podařilo se mi počítač, na kterém bylo Hyper-V s běžícími guesty uspat a zase probudit).

Bohužel, možnosti uživatelského rozhraní jsou stále velmi spartánské a odpovídající spíše serveru. Stále nefunguje třeba synchronizace schránky mezi klientem a serverem nebo automatické přizpůsobení rozlišení. To se dá nicméně vyřešit připojením přes RDP. 

Poslední problém, který jsem zatím nevyzkoušel, je funkčnost připojení guest OS přes WiFi. Hyper-V na rozdíl třeba od VirtualBoxu nemá vestavěný NAT pro připojení do Internetu a z technologických důvodů (rozdíly mezi drátovým a bezdrátovým stackem) neumí sdílet bezdrátové adaptéry. Hyper-V 8 jsem v tomto směru zatím nezkoušel, ježto jsem ho měl nainstalovaný na desktopu bez WiFi.

## Windows 8 Server

I serverová verze Windows 8 disponuje Metro rozhraním a je mu přizpůsobená i grafika některých administratčních nástrojů:

[![Server Manager ve Windows 8](https://www.cdn.altairis.cz/Blog/2011/20110924-win8_server_manager_thumb.png "Server Manager ve Windows 8")](https://www.cdn.altairis.cz/Blog/2011/20110924-win8_server_manager_2.png)

I jejich schopnosti se opět sympaticky rozrostly, dashboard je přehlednější a vypadá to, že má víc funkcí, pro hromadnou správu více serverů a ukládání předdefinovaných konfiguračních šablon.

### Server Name Indication (SNI) pro HTTPS

Z mého hlediska velmi podstatnou a užitečnou novinku představuje podpora pro SNI rozšíření protokolu TLS. Nezní to jako moc vzrušující novinka, ale pokusím se ji osvětlit.

Běžně komunikace mezi browserem a web serverem probíhá nešifrovaně a kdokoliv ji může odposlouchávat a případně modifikovat. Což se týká třeba i hesel zasílaných v rámci forms authentication a dalších potenciálně citilivých údajů. Tento problém lze řešit tím, že se použije zabezpečená varianta HTTP – HTTPS, nazývaná též SSL nebo TLS (každá tahle zkratka znamená něco trochu jiného, ale pro účely tohoto článku je můžeme považovat za ekvivalentní). SSL vytvoří šifrovaný tunel, kterým pak procpe běžné HTTP. Větší weby někdy zabezpečenou komunikaci nabízejí (i když méně často, než by se mi líbilo), ale pro menší je tato cesta nedostupná.

K sestavení SSL tunelu totiž dojde ještě před zahájením vlastní HTTP komunikace, tedy před zasláním hlavičky "host", potřebné pro možnost hostovat na jedné IP adrese a defaultním portu několik různých virtuálních web serverů. Takže kromě nutnosti obstarat si SSL certifikát (což lze zařídit i vcelku [jednoduše a zdarma](http://www.startssl.com/)) musí mít provozovatel webu k dispozici samostatnou IP adresu (což nebývá jednoduché ani levné) nebo rozjet web na nestandardním portu (což s sebou nese rozličné další problémy jako například nedostupnost ze sítí, jejichž firewally podporují pouze standardní protokoly).

Tento problém se podujalo vyřešit rozšíření protkolu TLS, známé jako SNI – Server Name Indication ([RFC4366](http://tools.ietf.org/html/rfc4366), [RFC5746](http://tools.ietf.org/html/rfc5746)). To umožňuje zaslat předpokládaný host name při sestavování bezpečného tunelu a tedy na jedné IP adrese a portu mít neomezené množství SSL-protected virtuálních web serverů.

Jedná se o (relativně) nový standard, který současná verze IIS nepodporuje. IIS 8 již ano. Při vytváření SSL bindingu nyní můžete povolit SNI a zadat common name vhodného certifikátu:

[![Nastavení SNI ve Windows 8](https://www.cdn.altairis.cz/Blog/2011/20110924-win8_sni_thumb.png "Nastavení SNI ve Windows 8")](https://www.cdn.altairis.cz/Blog/2011/20110924-win8_sni_2.png)

Jistou nevýhodou SNI je neúplná podpora na straně klientů. Na Windows XP nefunguje SNI v IE (libovolné verze) a v Safari (na Windows Vista a novějších to chodí). Rozpačitá je podpora v Androidu: zájemce o podrobnosti odkazuji na [issue tracker](http://code.google.com/p/android/issues/detail?id=12908), ve verzích Androidu nemám přehled. Nicméně i tak je SNI pro malé weby velký krok kupředu, pro zastaralé klienty se prostě použije nestandardní port nebo fallback na HTTP.

### Web hosting key store

Další novinka se také týká šifrovaného spojení v rozsáhlejších systémech. 

[![Web Hosting Certificate Store](https://www.cdn.altairis.cz/Blog/2011/20110924-win8_certmgmt_thumb_1.png "Web Hosting Certificate Store")](https://www.cdn.altairis.cz/Blog/2011/20110924-win8_certmgmt_4.png)

Přibyl nový certificate store jménem *Web Hosting*, se kterým umí nativně pracovat i IIS Manager a tahat si serverové certifikáty z něj, místo z klasického *Personal* store. 

Pokud jsem vše pochopil správně, bude možné klíče centrálně ukládat na file share a tento store umístit na něj. Což zjednoduší současnou praxi ve webových farmách a větších hostingových scénářích, kde je nutné certifikáty a jim přináležející klíče rozličnými způsoby synchronizovat mezi sebou.