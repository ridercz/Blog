<!-- dcterms:identifier = aspnetcz#345 -->
<!-- dcterms:title = Certifikační autorita snadno a rychle -->
<!-- dcterms:abstract = V řadě případů potřebujeme rychle vytvořit nějaké testovací certifikáty či přímo jejich logickou sestavu. Dlouhá léta jsem pro tento účel používal OpenSSL, ale nyní jsem zjistil, že vhodný nástroj je přímo součástí Windows SDK. -->
<!-- np9:categoryId = 2 -->
<!-- x4w:category = Bezpečnost -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2011-10-17T22:34:19.43+02:00 -->
<!-- dcterms:date = 2011-10-17T22:39:52.57+02:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20111017-certifikacni-autorita-snadno-a-rychle.png -->

V řadě případů potřebujeme rychle vytvořit nějaké testovací certifikáty či přímo jejich logickou sestavu. Dlouhá léta jsem pro tento účel používal OpenSSL, ale nyní jsem zjistil, že vhodný nástroj je přímo součástí Windows SDK. Dlouho jsem `makecert.exe` považoval jenom za nástroj pro vytváření self-signed certifikátů (jejichž použitelnost je obecně omezená), ale teď jsem s překvapením zjistil, že toho umí mnohem víc.

S pomocí `makecert.exe` můžete vytvořit certifikační autoritu a jí podepsané serverové i klientské certifikáty. Tato utilita je součástí Windows SDK. To se vám nainstaluje s Visual Studiem a nebo si jej ve verzi pro Windows 7 a .NET 4.0 můžete stáhnout [z webu Microsoftu](http://www.microsoft.com/downloads/en/details.aspx?FamilyID=6b6c21d2-2006-4afa-9702-529fa782d63b). Nejlepší přehled všech dostupných verzí jsem našel na [Wikipedii](http://en.wikipedia.org/wiki/Microsoft_Windows_SDK). Po instalaci pak najdete utility v `C:\Program Files (x86)\Microsoft SDKs\Windows\v7.0A\Bin` případně `C:\Program Files\Microsoft SDKs\Windows\v7.1\Bin` (cesta obecně závisí na platformě a verzi instalovaného SDK, může být i jiná).

## Vytvoření klíčů a self-signed certifikátu certifikační autority

Prvním krokem je vytvoření certifikátu certifikační autority. K tomu použijeme následující příkaz:

`makecert -r -n "CN=My Test Root CA" -pe -sv root.pvk -a sha256 -m 120 -len 2048 -cy authority root.cer`

Význam parametrů je následující:
  <table><tbody>     <tr style="vertical-align: top">       <td style="white-space: nowrap">`-r`</td>        <td>Vytvořit self-signed certifikát, tedy vystavovatel je stejný jako subjekt</td>     </tr>      <tr style="vertical-align: top">       <td style="white-space: nowrap">`-n "CN=My Test Root CA"`</td>        <td>Distinguished name v certifikátu. "CN" je common name, nejdůležitější parametr, ale zde můžete napsat jakkoliv složité DN.</td>     </tr>      <tr style="vertical-align: top">       <td style="white-space: nowrap">`-pe`</td>        <td>Vygenerovaný soukromý klíč bude označen jako exportovatelný.</td>     </tr>      <tr style="vertical-align: top">       <td style="white-space: nowrap">`-sv root.pvk`</td>        <td>Název souboru, do nějž bude uložen soukromý klíč.</td>     </tr>      <tr style="vertical-align: top">       <td style="white-space: nowrap">`-a sha256`</td>        <td>Algoritmus použitý pro podpis. Výchozí hodnota je `sha1` (což je v nouzi ještě použitelné), pro nové certifikáty se doporučuje používat nejméně `sha256`. Rozhodně nepoužívejte `md5`.</td>     </tr>      <tr style="vertical-align: top">       <td style="white-space: nowrap">`-m 120`</td>        <td>Doba platnosti certifikátu v měsících. Pro CA se obvykle nastavují delší hodnoty. Lze místo toho použít přepínače `-b` a `-e`, které umožňují určit přesně začátek a konec platnosti (datumy se udávají ve formátu mm/dd/yyyy). Tak lze vyrobit například expirovaný certifikát.</td>     </tr>      <tr style="vertical-align: top">       <td style="white-space: nowrap">`-len 2048`</td>        <td>Délka klíče v bitech. Výchozí (a dnes již stěží přijatelná) je hodnota 1024 bitů, doporučuji používat 2048 nebi 4096.</td>     </tr>      <tr style="vertical-align: top">       <td style="white-space: nowrap">`-cy authority`</td>        <td>Typ certifikátu může být `end` (koncový uživatel) nebo `authority` (certifikační autorita).</td>     </tr>      <tr style="vertical-align: top">       <td style="white-space: nowrap">`root.cer`</td>        <td>Název souboru, kam bude uložen nový certifikát.</td>     </tr>   </tbody></table>  

Výsledkem tohoto příkazu budou soubory `root.pvk` a `root.cer`. První z nich představuje soukromý (tajný) klíč a měli byste ho střežit jako oko v hlavě, budete ho potřebovat pro další práci. Druhý je kořenový certifikát. Ten musíte naopak obvyklým způsobem nainstalovat do všech počítačů, které mají tuto CA pokládat za důvěryhodnou.

## Vytvoření klíčů a certifikátu pro server

Druhým krokem je, že použijeme tuto CA pro vytvoření serverového certifikátu, typicky pro web server. Syntaxe je následující:

`makecert -iv root.pvk -ic root.cer -n "CN=localhost" -pe -sv server.pvk -a sha256 -len 2048 -m 12 -sky exchange -eku 1.3.6.1.5.5.7.3.1 server.cer`

Význam parametrů je:
  <table><tbody>     <tr style="vertical-align: top">       <td style="white-space: nowrap">`-iv root.pvk`</td>        <td>Cesta k soukromému klíči CA.</td>     </tr>      <tr style="vertical-align: top">       <td style="white-space: nowrap">`-ic root.cer`</td>        <td>Cesta k veřejnému klíči (certifikátu) CA.</td>     </tr>      <tr style="vertical-align: top">       <td style="white-space: nowrap">`-n "CN=localhost"`</td>        <td>Opět distinguished name uvedený v certifikátu. Pro použití v rámci web serveru se musí obvykle CN rovnat DNS názvu serveru.</td>     </tr>      <tr style="vertical-align: top">       <td style="white-space: nowrap">`-pe`</td>        <td>Vygenerovaný soukromý klíč bude označen jako exportovatelný.</td>     </tr>      <tr style="vertical-align: top">       <td style="white-space: nowrap">`-sv root.pvk`</td>        <td>Název souboru, do nějž bude uložen soukromý klíč.</td>     </tr>      <tr style="vertical-align: top">       <td style="white-space: nowrap">`-a sha256`</td>        <td>Algoritmus použitý pro podpis. Výchozí hodnota je `sha1` (což je v nouzi ještě použitelné), pro nové certifikáty se doporučuje používat nejméně `sha256`. Rozhodně nepoužívejte `md5`.</td>     </tr>      <tr style="vertical-align: top">       <td style="white-space: nowrap">`-m 12`</td>        <td>Obecné certifikáty (serverové, klientské) se obvykle vystavují nak kratší dobu, v tomto případě na 12 měsíců.</td>     </tr>      <tr style="vertical-align: top">       <td style="white-space: nowrap">`-sky exchange`</td>        <td>Typ klíče je typicky `signature` (pro elektronický podpis) nebo `exchange` (výměna klíčů, šifrování).</td>     </tr>      <tr style="vertical-align: top">       <td style="white-space: nowrap">`-eku 1.3.6.1.5.5.7.3.1`</td>        <td>Numerické identifikátory (OID) účelů, pro které lze certifikát využít. V tomto případě OID `1.3.6.1.5.5.7.3.1` znamená Server Authentication.</td>     </tr>      <tr style="vertical-align: top">       <td style="white-space: nowrap">`server.cer`</td>        <td>Název souboru, kam bude uložen nový certifikát.</td>     </tr>   </tbody></table>  

## Vytvoření klíčů a certifikátů pro klienta

Chcete-li používat autentizaci klientskými certifikáty, je nutné vygenerovat certifikát i pro klienta. Příkaz pro vygenerování je prakticky stejný, jako u serverového certifikátu:

`makecert -iv root.pvk -ic root.cer -n "CN=John Q. Public, E=jqp@example.com" -pe -sv client.pvk -a sha256 -len 2048 -m 12 -sky exchange -eku 1.3.6.1.5.5.7.3.2 client.cer`

Liší se jenom v jiném distinguished name (typicky udáváme nejméně jméno osoby a její e-mailovou adresu) a především v použitém OID, které má na konci dvojku - `1.3.6.1.5.5.7.3.2` znamená Client Authentication.

## Konverze PVK + CER na PFX

Pro serverovou a klientskou autentizaci potřebujeme certifikát naimportovat do úložiště včetně soukromého klíče. Samostatný PVK soubor nelze (alespoň pokud je mi známo) naimportovat přímo, takže oba klíče nejprve zkonvertujeme do formátu dle PKCS#12, tedy do souboru s příponou obvykle PFX nebo P12. K tomu použijeme další utilitu, která je součástí Windows SDK, a to `pvk2pfx.exe`:

`pvk2pfx -pvk client.pvk -spc client.cer -pfx client.pfx`

Význam parametrů je myslím poměrně jasný

## Varování na závěr

Provozovat certifikační autoritu, opravdovou, pro reálné nasazení, je mnohem náročnější, než jenom spustit pár prográmků. Výše uvedené postupy představují jednoduché řešení pro pokusy, testy, vývoj a podobně, rozhodně se nejedná o postup doporučený pro běžnou práci.