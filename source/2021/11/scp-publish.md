<!-- dcterms:title = Jak publikovat ASP.NET aplikaci na Linux pomocí SCP a Visual Studia -->
<!-- dcterms:abstract = Vypublikovat hotovou ASP.NET aplikaci na server přes FTP nebo Web Management Service je snadné: stačí ve Visual Studiu vytvořit publishing profil a klepnout na Publish. Ale co když chcete aplikaci nasadit na server s Linuxem, kde chcete použít SCP, třeba na Raspberry Pi z našeho seriálu? Je to možné, ale vyžaduje to trochu ručních zásahů do projektového souboru. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20211107-scp-publish.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20211107-scp-publish.jpg -->
<!-- x4w:category = IT -->
<!-- dcterms:dateAccepted = 2021-11-07 -->

Vypublikovat hotovou ASP.NET aplikaci na server přes FTP nebo Web Management Service je snadné: stačí ve Visual Studiu vytvořit publishing profil a klepnout na _Publish_. Ale co když chcete aplikaci nasadit na server s Linuxem, kde chcete použít SCP, třeba na [Raspberry Pi z našeho seriálu](https://www.altair.blog/serials/asp-net-na-raspberry-pi)? Je to možné, ale vyžaduje to trochu ručních zásahů do projektového souboru.

> Tento článek vznikl na základě dotazu, který mi poslal čtenář tohoto blogu Michal Krchnavy. Budiž vám to inspirací: pokud máte nějaké dotazy nebo náměy, [napište mi](https://www.rider.cz/#contact). Nezaručuji vám odpověď, ale možná z toho bude článek. Pokud chcete mít radu s jistotou, nabízím [placené konzultace](https://www.altair.blog/2018/10/co-stoji-dobra-rada).

## Předpoklady

Níže popsaný postup je možné použít pro jakoukoliv aplikaci a jakýkoliv server, na který se lze připojit přes SSH, potažmo kopírovat soubory přes SCP. Aby fungoval jak je popsán, musíte mít [nastavenu autentizaci výchozím SSH klíčem](https://www.altair.blog/2021/10/dotnet-raspi-2) a tento klíč nesmí být chráněn lokální passphrasí (heslem).

Tento postup také smaže všechny soubory ve vzdáleném adresáři a nahraje tam nové, což nemusí být zcela žádoucí, jak bude popsáno dále.

## Postup

Publishing profily (soubory `~/Properties/PublishProfiles/*.pubxml`) jsou ve své podstatě standardní MSBuild projektové soubory. Můžeme tedy celkem snadno přidat akci, která se spustí ve správný okamžik při zpracování tohoto souboru, v tomto případě po dokončení publikování.

Začněte tím, že vytvoříte standardní publishing profil, který bude publikovat do složky. Jak, to jsem popisoval ve [třetím dílu seriálu o běhu ASP.NET na Raspberry Pi](https://www.altair.blog/2021/10/dotnet-raspi-3). Otevřete výsledný soubor a téměř na jeho konec (před uzavírací tag `</Project>`) přidejte následující kód:

```xml
<Target Name="ScpUploadAfterPublish" AfterTargets="AfterPublish">
    <PropertyGroup>
        <SshUserName>pi</SshUserName>
        <SshServerName>10.7.0.126</SshServerName>
        <SshServerPath>~/AskMe/</SshServerPath>
    </PropertyGroup>
    <Exec Command="%WINDIR%\sysnative\cmd /C ssh $(SshUserName)@$(SshServerName) &quot;rm -rf $(SshServerPath)*&quot;" />
    <Exec Command="%WINDIR%\sysnative\cmd /C scp -r &quot;$(PublishDir)*&quot; &quot;$(SshUserName)@$(SshServerName):$(SshServerPath)&quot;" />
</Target>
```

Jeho název (`Name`) může být jakýkoliv, ale důležité je, aby atribut `AfterTargets` měl hodnotu `AfterPublish`. V elementu `PropertyGroup` pak definujeme tři proměnné (nenechte se zmást tím, že vám je IntelliSense podtrhá jako neznámé):

* `SshUserName` je uživatelské jméno na vzdáleném serveru.
* `SshServerName` je název nebo IP adresa vzdáleného serveru.
* `SshServerPath` je cesta do adresáře, do kterého se má nasazovat, a to **včetně posledního lomítka**.

Následující dva elementy `Exec` pak smažou všechno, co na serveru je a nahrají tam aktuální verzi. Nejprve se pomocí SSH vzdáleně zavolá příkaz `rm -rf ~/AskMe/*`, který smaže veškerý obsah adresáře, ale ne adresář samotný. Potom se pomocí SCP do téhož adresáře nahraje výsledek publishingu.

## Možné zákeřnosti a úpravy

Nepodařilo se mi přijít na způsob, jak přesměrovat výstup ze SCP do konzole Visual Studia. V průběhu publikace tedy není vypisován žádný průběh, což může působit dojmem, že se proces někde zasekl. Buďte trpěliví.

Tento kód předpokládá, že bude spouštěn na 64-bitovém počítači z Visual Studia, v němž běží 32-bitový MSBuild, což je výchozí nastavení. Z tohoto důvodu používám ono podivné volání `%WINDIR%\sysnative\cmd /C`, protože příkazy `scp` a `ssh` jsou 64-bitové a normálně pro 32-bitový MSBuild nejsou vidět.

Při nasazení postupuji tak, že na serveru úplně všechno smažu a nahraju tam novou vypublikovanou verzi. Což nemusí být úplně dobrý nápad, například ve chvíli, kdy se v adresáři aplikace nacházejí nějaká aplikační data, jako třeba SQLite databáze v `App_Data/ask.db` v případě [ukázkové aplikace AskMe](https://github.com/ridercz/AskMe). Nejjednodušší řešení v tomto případě je ukládat data někam jinam, mimo adresář do kterého se nasazuje.

Uvedený postup také není úplně nejefektivnější. Mnohem lepší by bylo třeba použít `rsync`, ale ten (zatím?) na Windows není standardně dostupný.

Pomocí syntaxe `ssh user@server "..."` můžete vzdáleně na serveru vykonat jakýkoliv příkaz. Lze tedy například po dobu nasazování ručně zastavit službu Kestrelu nebo nějak jinak zkonfigurovat, aby se po dobu nasazování ukázala nějaká hláška typu "aplikace se právě aktualizuje".

