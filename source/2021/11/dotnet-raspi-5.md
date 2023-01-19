<!-- dcterms:title = ASP.NET na Raspberry Pi: Raspberry Pi Zero 2 a Framework-Dependent Deployment -->
<!-- dcterms:abstract = Seriál o ASP.NET Core na Raspberry Pi měl původně mít jenom čtyři pokračování. Ale výrobce v jeho průběhu uvedl nový model, Raspberry Pi Zero 2. Ten je z mnoha důvodů zajímavý, takže jsem mu věnoval bonusový, pátý díl seriálu. A zároveň jsem popsal, jak používat framework-dependent deployment, tedy jak nainstalovat na Raspberry .NET runtime a provozovat univerzální multiplatformní binárky. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20211112-dotnet-raspi-5.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20211112-dotnet-raspi-5.jpg -->
<!-- x4w:category = Z-TECH -->
<!-- x4w:category = IT -->
<!-- x4w:serial = ASP.NET na Raspberry Pi -->
<!-- dcterms:date = 2021-11-12 -->

Seriál o ASP.NET Core na Raspberry Pi měl původně mít jenom čtyři pokračování. Ale výrobce v jeho průběhu uvedl nový model, Raspberry Pi Zero 2. Ten je z mnoha důvodů zajímavý, takže jsem mu věnoval bonusový, pátý díl seriálu. A zároveň jsem popsal, jak používat framework-dependent deployment, tedy jak nainstalovat na Raspberry .NET runtime a provozovat univerzální multiplatformní binárky.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/Lne_PqxrZ8w" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

## Raspberry Pi Zero 2

Běžné počítače Raspberry Pi mají velikost asi jako běžná krabička cigaret a cenu okolo 35 dolarů. Existuje ale ještě menší řada, Raspberry Pi Zero. Počítače této řady jsou ještě omezenější svým výkonem a konektivitou, ale jsou výrazně levnější a menší.

Úplně první bylo [Raspberry Pi Zero](https://www.raspberrypi.com/products/raspberry-pi-zero/). Počítač s cenou pět dolarů (v českých podmínkách [127 Kč u oficiálního distributora RPishop.cz](https://rpishop.cz/zero/632-raspberry-pi-zero.html)). Jeho největší slabinou je, že se nativně neumí připojit k síti. Nemá Wi-Fi ani ethernetové rozhraní a je nutné ho k němu dodatečně přidat přes USB. Nástupcem je [Raspberry Pi Zero W](https://www.raspberrypi.com/products/raspberry-pi-zero-w/). To za dvojnásobnou cenu ($ 10 nebo [279 Kč](https://rpishop.cz/zero/647-raspberry-pi-zero-w-4053199547425.html)) nabízí navíc 2,4 GHz Wi-Fi. Existují i verze s "H" na konci, ale to jenom znamená, že mají napájené hlavičky na univerzálním konektoru a nemusíte to dělat sami, pokud je budete chtít využít.

Tyto modely byly pro .NET programátory nezajímavé, protože na jejich procesorech .NET běžet neumí. Nepodporují totiž instrukční sadu ARMv6, kterou .NET vyžaduje. To se změnilo s modelem [Raspberry Pi Zero 2 W](https://www.raspberrypi.com/products/raspberry-pi-zero-2-w/). Ten stojí patnáct dolarů ([410 Kč](https://rpishop.cz/zero/4311-raspberry-pi-zero-2-w-5056561800004.html)) a má stejný procesor jako Raspberry Pi 3. Má výrazně vyšší výkon než jeho předchůdci, srovnatelný s Raspberry Pi 3. A .NET na něm běží.

Řada Zero je předurčena k malým věcem. A to doslova, protože destička má pouhých 65 x 30 mm a je tedy menší než platební karta. Nabízí Wi-Fi konektivitu, jeden MicroUSB port s funkcí OTG (druhý MicroUSB konektor slouží k napájení) a MicroHDMI pro grafický výstup.

Od počítače s těmito parametry nelze čekat žádné výkonové zázraky. Spouštění webové aplikace v .NETu je dostatečné, ale taková kompilace je jenom pro trpělivé a i instalace trvá výrazně déle. Ostatě s pouhými 512 MB RAM není čemu se divit. Na druhou stranu jsou aplikace, kde nízký výkon nevadí a oceníme nízkou cenu, rozměry a spotřebu.

## Framework-Dependent Deployment

Vlastní postup instalace tak, jak byl popsán v předchozích dílech našeho seriálu, je zcela univerzální, bez ohledu na použitý model RPi. Zero 2 lze nainstalovat přesně stejně, jako jeho větší bratříčky.

Proto jsem se v tomto modelu vydal poněkud jinou cestou a rozhodl se aplikaci spustit ve FDD režimu, který vyžaduje instalaci .NET runtime na Raspberry Pi. Upřímně řečeno, nedává to moc smysl - právě u Zero verze se mnohem víc hodí SCD (Self-Contained Deployment), kdy na server nahráváme nativní binárku. Ale tu už jsem popisoval dříve, takže jsem se vydal komplikovanější cestou.

Sám postup je docela dobře popsán v článku [Deploy .NET apps to Raspberry Pi](https://docs.microsoft.com/en-us/dotnet/iot/deployment). Od nasazení na "velký" Linux se liší především v tom, že není k dispozici instalace pomocí package manageru a vše se musí dělat "ručně". Přičemž ovšem "ručně" obnáší spuštění jednoho shell skriptu. 

Sekvence příkazů pro instalaci .NETu je následující:

```bash
curl -sSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --channel Current
echo 'export DOTNET_ROOT=$HOME/.dotnet' >> ~/.bashrc
echo 'export PATH=$PATH:$HOME/.dotnet' >> ~/.bashrc
source ~/.bashrc
dotnet --version
```

* První řádek stáhne skript `dotnet-install.sh` a vykoná ho. Tento shell skript udělá všechno podstatné, nainstaluje nejnovější verzi .NETu (nyní tedy 6.0, ve videu je to ještě 5.0).
* Další dva řádky nastaví systémové proměnné, které říkají, kde je .NET nainstalován. Instalace totiž nevyžaduje práva roota (administrátora), vše se instaluje jenom pro aktuálního uživatele.
* Čtvrtý řádek provede opakované načtení konfigurace shellu, aby se změny projevily. 
* Poslední řádek pak spustí `dotnet` a vypíše jeho verzi, čímž jest ověřiti, že vše proběhlo správně.

Uvedeným postupem se nainstaluje kompletní SDK, takže nyní lze použít všechny metody deploymentu. Kompilaci ze zdrojáků však důrazně nedoporučuji, přišla mi i u primitivní aplikace extrémně pomalá, nejspíš s ohledem na malé množství operační paměti.

Použití FDD vyžaduje změnu v souboru `/etc/systemd/system/kestrel-askme.service`. Nespouštíme přímo binárku aplikace, ale binárku `/home/pi/.dotnet/dotnet` jíž jako argument předáváme název spouštěného DLL. Dále pak jsem tady neřešil běh pod low-privileged účtem a vše běží pod uživatelem `pi`. Definiční soubor služby pak vypadá takto:

```
[Unit]
Description=ASKme .NET 5 Web Application

[Service]
WorkingDirectory=/home/pi/AskMe/
ExecStart=/home/pi/.dotnet/dotnet Altairis.AskMe.Web.RazorPages.dll
Restart=always
RestartSec=10
SyslogIdentifier=dotnet-askme
User=pi
Environment=ASPNETCORE_ENVIRONMENT=Production

[Install]
WantedBy=multi-user.target
```

## Provoz holého Kestrelu

Vzhledem k omezenému výkonu jsem se rozhodl nezatěžovat počítač ještě navíc Nginxem a Kestrel si musí poradit sám o sobě. Změnil jsem konfiguraci tak, aby naslouchal na standardním portu 80.

S tím je ovšem spojen drobný problém. Na Linuxu standardně na portech pod 1000 smějí naslouchat pouze procesy běžící pod oprávněním roota. Následujícím příkazem přidáme proces `dotnet` do výjimek:

```bash
sudo setcap CAP_NET_BIND_SERVICE=+eip /home/pi/.dotnet/dotnet
```

To řešení není úplně ideální (povolí naslouchat všem .NET aplikacím na všech nízkých portech), ale pro účely našeho dema je zcela postačující.

Tímto dílem končí náš oficiální seriál o hostování ASP.NET aplikací na Raspberry Pi, ale rozhodně to není poslední článek o této platformě. Ostatně, minulou neděli jsem vydal jako článek odpověď na dotaz čtenáře, [jak řešit deployment na Linux](https://www.altair.blog/2021/11/scp-publish) "na jedno tlačítko" z Visual Studia pomocí SCP.

Pokud máte nějaké další dotazy a náměty, můžete mi napsat na [Twitteru](https://twitter.com/ridercz), [Facebooku](https://www.facebook.com/rider.cz) nebo [mailem](https://www.rider.cz/#contact).