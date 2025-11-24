<!-- dcterms:title = ASP.NET na Arduinu Uno Q -->
<!-- dcterms:abstract = Značku Arduino máme tradičně spojenou s mikrokontrolery a na nich ASP.NET neběží. Ale novinka Uno Q kombinuje mikrokontroler s linuxovým mikropočítačem a já vás naučím, jak na tomto mikropočítači .NET a ASP.NET rozjet. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:date = 2025-11-24 -->
<!-- x4w:coverUrl = /cover-pictures/20251114-unoq.jpg -->
<!-- x4w:pictureUrl = /perex-pictures/logo-arduino.svg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = IT -->
<!-- x4w:type = TMD -->

<!-- $ -->
Značku Arduino máme tradičně spojenou s mikrokontrolery a na nich ASP.NET neběží (na některých běží [.NET NanoFramework](https://nanoframework.net/), ale to je jiná pohádka). Ale jiná pohádka je i nejnovější [Arduino Uno Q](https://www.arduino.cc/product-uno-q). To totiž na jedné desce kombinuje mikrokontroler (MCU, STM32U585) a ARM mikroprocesor (MPU, Qualcomm Dragonwing QRB2210). A na MPU běží Linux (v tomto případě Debian) a na Linuxu běží .NET. Nedalo mi a desku jsem si za zhruba tisícovku musel koupit a vyzkoušet na tom ASP.NET rozjet. A to rovnou v nejnovější, před pár dny vydané verzi 10.0.
- - -
## Instalace nejnovějšího image Linuxu

Deska se nedodává s nejnovější verzí Linuxu, takže jako první je žádoucí aktualizovat Linux na nejnovější verzi.
- - -
Odpojte desku Arduino Uno Q od počítače.
- - -
<!-- #shortpins -->
Vyzkratujte dva piny podle následujícího obrázku. Použijte k tomu třeba F-F propojovací kabel nebo klasický jumper, používaný třeba na PC základních deskách.

![](https://www.cdn.altairis.cz/Blog/2025/20251114-unoq-jumper.svg)
- - -
(i)
Pokud jsou tyto dva piny propojené při zapnutí, přepne se deska do režimu EDL (Emergency Download) a je možné updatovat image.
- - -
Připojte desku k počítači přes USB.
- - -
Stáhněte si [Arduino Flasher CLI](https://www.arduino.cc/en/software/#flasher-tool) a ZIP soubor někam rozbalte.
- - -
Spusťte následující příkaz:

```
arduino-flasher-cli flash latest -y
```
- - -
Budete-li vyzvání k instalaci ovladače pro USB zařízení, udělejte to:

![](https://www.cdn.altairis.cz/Blog/2025/20251114-unoq-driver.png)
- - -
Začne se stahovat nejnovější dostupný image. To bude chvíli trvat, soubor má cca. 2 GB.
- - -
Poté se image nahraje do desky (což také nějakou dobu trvá) a program bude ukončen.

![](https://www.cdn.altairis.cz/Blog/2025/20251114-unoq-flashdone.png)
- - -
(i)
Image (2,3 GB) a jeho rozbalená verze (9 GB) se uloží do vašeho uživatelského profilu, do složky `%LOCALAPPDATA%\arduino-flasher-cli`. Pokud chcete ušetřit 11 GB místa na disku, můžete její obsah smazat, neplánujete-li flashovat znovu.

Pokud plánujete flashovat tentýž image znovu, je poněkud nemilé, že aplikace bude nejnovější verzi stahovat znovu, neb si neumí ověřit, že ji už má. Chcete-li tomu zabránit, podívejte se do výše uvedené složky a najděte její podsložku, v níž je soubor `disk-sdcard.img.root`. Přesný název adresáře záleží na okamžiku stažení (`download-XXXXXXXXX`) a verze image (v době psaní tohoto návodu `arduino-unoq-debian-image-20251024-412`).

Pokud použijete následující příkaz (s patřičným názvem adresáře), nebude se stahovat image znovu:

```
arduino-flasher-cli flash C:\Users\UserName\AppData\Local\arduino-flasher-cli\download-904505832\arduino-unoq-debian-image-20251024-412 -y
```
- - -
Odpojte desku od počítače, odstraňte propojku přidanou v kroku [#shortpins] a desku znovu připojte.
- - -
## Připojení k Wi-Fi síti
- - -
Stáhněte si nástroj [Arduino App Lab](https://www.arduino.cc/en/software/#app-lab-section) a nainstalujte jej.
- - -
(!)
Současná verze aplikace (0.2.0) není příliš stabilní a občas padá. Pokud se tak stane, spusťte ji znovu a pokračujte tam, kde jste přestali.
- - -
Spusťte Arduino App Lab a vyčkejte, dokud není detekována deska připojená přes USB. Poté klepněte na její ikonu:

![](https://www.cdn.altairis.cz/Blog/2025/20251114-unoq-lab01.png)
- - -
Vyberte rozložení klávesnice, desku nějak pojmenujte a klepněte na Confirm:

![](https://www.cdn.altairis.cz/Blog/2025/20251114-unoq-lab02.png)
- - -
(i)
Rozložení klávesnice by mělo význam pouze tehdy, pokud byste klávesnici k zařízení fyzicky připojili pomocí USB-C hubu a pracovali na konzoli, což asi dělat nebudete.
- - -
Klepněte na název Wi-Fi sítě, zadejte její heslo a klepněte na Confirm:

![](https://www.cdn.altairis.cz/Blog/2025/20251114-unoq-lab03.png)
- - -
Aplikace vás nejspíše vyzve k aktualizaci balíčků, což proveďte. Opět to bude nějakou dobu trvat.

![](https://www.cdn.altairis.cz/Blog/2025/20251114-unoq-lab04.png)
- - -
Poté klepněte na _Restart App Lab_ a znovu se připojte přes USB.
- - -
<!-- #pwd -->
Zadejte nové heslo pro uživatele `arduino` a klepněte na _Confirm_.

![](https://www.cdn.altairis.cz/Blog/2025/20251114-unoq-lab05.png)
- - -
Tím je nastavení desky ukončeno. Aplikaci Arduino App Lab můžete ukončit.
- - -
<!-- #getip -->
Zjistěte, např. na routeru, jaká IP adresa byla zařízení přidělena, např. `192.168.0.123`.
- - -
## Vytvoření a publikace aplikace
- - -
Vytvořte jakoukoliv ASP.NET Core aplikaci, např. ukázkovou aplikaci podle výchozí šablony.
- - -
V souboru `Program.cs` nastavte, aby Kestrel naslouchal na všech adresách na portu 5000 (standardně naslouchá pouze na localhostu):

<pre>
var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddRazorPages();

<ins>// Listen on port 5000 for HTTP on all network interfaces (0.0.0.0).
builder.WebHost.ConfigureKestrel(options =&gt; {
    options.ListenAnyIP(5000);
});</ins>

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment()) {
    app.UseExceptionHandler("/Error");
}

app.UseRouting();

app.UseAuthorization();

app.MapStaticAssets();
app.MapRazorPages()
   .WithStaticAssets();

app.Run();
</pre>
- - -
V menu klepněte na _Build > Publish_.
- - -
Zvolte jako _Target_ možnost _Folder_ a klepněte na _Next_:

![](https://www.cdn.altairis.cz/Blog/2025/20251114-unoq-publish01.png)
- - -
V dalším dialogu nastavte cestu pro vypublikování dle svých preferencí, případně nechte výchozí, a klepněte na _Finish_:

![](https://www.cdn.altairis.cz/Blog/2025/20251114-unoq-publish02.png)
- - -
V dalším dialogu klepněte na _Close_.
- - -
Klepněte na _Show all settings_:

![](https://www.cdn.altairis.cz/Blog/2025/20251114-unoq-publish03.png)
- - -
Nastavte následující parametry:

* Deplyment Mode: Self-contained
* Targer Runtime: linux-x64
* Produce single file: ano (není nezbytné, ale zjednoduší deployment)
* Delete all existing files prior to publish: ano (není nezbytné, ale zjednoduší deployment)

Poté klepněte na _Save_:

![](https://www.cdn.altairis.cz/Blog/2025/20251114-unoq-publish04.png)
- - -
(i)
Používám self-contained deployment, protože je to pro účely dema nejjednodušší a protože v této chvíli ještě nejsou v repozitářích pohodlně dostupné balíčky .NET 10.0, takže by instalace jeho runtime byla zbytečně komplikovaná. Obecně samozřejmě můžete použít jakýkoliv způsob deploymentu.
- - -
<!-- #getdir -->
Klepněte na tlačítko _Publish_ a vyčkejte, dokud se projekt nevypublikuje. Poté si poznamenejte cestu, kam se tak stalo.
- - -
## Nakopírování aplikace na server
- - -
Spusťte příkazovou řádku a připojte se přes SSH jako uživatel `arduino` k serveru s IP adresou zjištěnou v kroku [#getip]:

```
ssh arduino@192.168.0.123
```
- - -
Při prvním přihlášení budete požádáni o potvrzení SSH klíče. Zadejte `yes` a potvrďte _Enter_.
- - -
Zadejte heslo, které jste vytvořili v kroku [#pwd] a potvrďte _Enter_.
- - -
Zadáním následujících příkazů aktualizujte systém:

```
sudo apt-get update && sudo apt-get upgrade -y
```
- - -
Následujícím příkazem vytvoříte ve své domácí složce `/home/arduino` složku `www`:

```
mkdir ~/www
```
- - -
Nyní je třeba zkopírovat vypublikovanou aplikaci z lokální složky z kroku [#getdir] do nově vytvořené složky `~/www` na serveru. To uděláme pomocí SCP (Secure Copy). 

Otevřete si druhou záložku v okně terminálu a zadejte následující příkaz (nezapomeňte nahradit cestu tou z kroku [#getdir] a IP adresu tou z [#getip]):

```
scp -r X:\Projects\WebApplication1\bin\Release\net10.0\publish\* arduino@192.168.0.123:~/www
```
- - -
Vyčkejte, dokud nebudou všechny soubory nahrány na server.
- - -
Přepněte se na záložku terminálu, kde jste připojeni na server přes SSH.
- - -
Nastavte binárku vaší aplikace jako spustitelnou následujícím příkazem (název souboru může být jiný, podle názvu vaší assembly; soubor nemá příponu):

```
chmod +x ~/www/WebApplication1
```
- - -
Aplikace je nyní spuštěna. Poznáte to podle toho, že vypisuje debugovací zprávy na konzoli:

![](https://www.cdn.altairis.cz/Blog/2025/20251114-unoq-publish06.png)
- - -
Podívejte se z webového prohlížeče na IP vašeho zařízení, port 5000, např.:

```
http://192.168.0.123:5000/
```
- - -
Zobrazí se vám vaše aplikace.
- - -
<!-- $ -->

Tímto jsme si ověřili, že je aplikace funkční a běží, jako na kterémkoliv jiném Linuxu. V této chvíli běží jenom dočasně, dokud je spuštěna z vaší uživatelské relace. Chcete-li, aby aplikace běžela plnohodnotně, podívejte se na bezplatný kurz [Hosting ASP.NET Core aplikací na Linuxu](https://elearning.altairis.cz/cs/courses/netlinux) a použijte tam popsaný postup pro nasazení aplikace jako služby a publikaci pomocí Nginxu.

V této chvíli jsem bohužel zatím nenašel pohodlný způsob, jak zajistit komunikaci mezi .NET kódem běžícím na ARM MPU a C++ kódem běžícím na STM MCU. Veškeré příklady jsou bohužel pouze pro Python, knihovna pro .NET neexistuje. Komunikace je však principiálně možná. Podle dostupných údajů se používá pro komunikaci mezi MPU a MCU technologie Unix Domain Sockets (kterou by .NET měl nativně podporovat) se zprávami formátovanými podle standardu [MessagePack](https://msgpack.org/) pro kterou existuje [NuGet balíček](https://www.nuget.org/packages/MessagePack). Dle svých časových možností se budu touto problematikou dále zabývat nebo to udělá někdo jiný.

Proč se tedy touto deskou zabývat, když je z hlediska .NET programátora pro většinu scénářů nejspíše výhodnější a jednodušší použít Raspberry Pi, které se dá ve srovnatelné hardwarové konfiguraci pořídit za stejné peníze? Jde především o možnosti do budoucna, kdy bude možné propojení s MCU na téže desce a využití podpory pro AI. V době psaní tohoto článku je Uno Q na trhu velice krátkou dobu a podpora není velká, ale to se v budoucnu změní. Další výhodou je napájení. Podle datasheetu si Uno Q verzme maximálně 3 A při 5 V (a většinou spíše méně), zatímco Raspberry Pi je z hlediska napájení komplikovanější, protože si umí sáhnout i na 5 A, což nemusí být vždy jednoduché zajistit, zejména při napájení třeba z powerbanky.