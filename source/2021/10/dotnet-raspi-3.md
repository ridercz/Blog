<!-- dcterms:title = ASP.NET na Raspberry Pi: Kompilace a nasazení .NET aplikace -->
<!-- dcterms:abstract = Ve třetím pokračování našeho seriálu se konečně dostáváme k .NET aplikaci jako takové. Ukážu vám, jak aplikaci zkompilovat a nasadit v režimu SCD (self-contained deployment) a jak nastavit, aby běžela aspoň trochu bezpečně a spouštěla se automaticky. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20211028-dotnet-raspi-3.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20211028-dotnet-raspi-3.jpg -->
<!-- x4w:coverCredits = Louis Reed via Unsplash.com -->
<!-- x4w:category = Z-TECH -->
<!-- x4w:category = IT -->
<!-- x4w:serial = ASP.NET na Raspberry Pi -->
<!-- dcterms:dateAccepted = 2021-10-28 -->

V [prvním](https://www.altair.blog/2021/10/dotnet-raspi-1) a [druhém](https://www.altair.blog/2021/10/dotnet-raspi-2) dílu seriálu o běhu ASP.NET na Raspberry Pi jsme se k .NETu vůbec nedostali. Ukázal jsem vám jenom obecné zprovoznění Linuxu na Raspberry Pi, aktualizaci systému a zabezpečení vzdáleného přístupu pomocí kryptografického klíče místo hesla. Nyní však nadešel čas .NETu. Ukážu vám, jak aplikaci zkompilovat tak, aby na RPi běžela a jak ji nastavit, aby se automaticky spouštěla při restartu a běžela na pozadí.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/sv6hc8-YCBc" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

## Kompilace aplikace

Existují tři režimy, v nichž může být aplikace napsaná v .NETu spouštěna:

* **SDK (Software Development Kit)** je způsob, který používáme na vývojovém počítači, kde je nainstalován kompletní SDK. Aplikace se před spuštěním zkompiluje ze zdrojových kódů. Pro produkční nasazení je tento režim zcela nevhodný.
* **SCD (Self-Contained Deployment)** je opačný extrém. Výsledkem kompilace je nativní binárka pro danou kombinaci operačního systému (Windows, Linux, Mac OS) a architekturu procesoru (x64, ARM...). Tu stačí (spolu s doprovodnými soubory) nahrát na server a tam ji lze bez dalšího spustit, aniž by bylo nutné na server cokoliv dotnetového instalovat. Kompletní runtime (resp. jeho potřebné části) si aplikace nese s sebou.
* **FDD (Framework-Dependent Deployment)** je něco mezi. Aplikace vyžaduje, aby byl na serveru nainstalován příslušný runtime (zde .NET 5.0), ale nemusí tam být kompletní SDK.

Zásadní rozdíl mezi SCD a FDD v praxi spočívá v tom, kdo se stará o aktualizaci runtime. V případě nasazení SCD je runtime součástí aplikace a pokud vyjde jeho nová verze (třeba s opravou chyb) je nutné aplikaci překompilovat a znovu nasadit. V případě FDD je runtime aktualizován nezávisle na aplikaci, zpravidla nějakým automatizovaným mechanismem: Microsoft Update na Windows a Aptitude (`apt-get upgrade`) na Linuxu. U SCD je tedy aktualizace v režii vývojáře, u FDD se o ni stará správce serveru.

FDD má ještě další výhody ve chvíli, kdy na serveru běží několik různých aplikací využívajících tentýž runtime. To ale u našeho Raspberry Pi nehrozí, takže využijeme Self-Contained Deployment (SCD).

Vytvoříme nový publishing profil, nastavíme v něm SCD režim a cílovou platformu a aplikaci vypublikujeme.

## Nahrání aplikace

Soubory z publikačního adresáře je nutné nahrát na server. Použijeme k tomu příkaz SCP (Secure CoPy), který soubory přenáší stejným způsobem, jako funguje vzdálený shell SSH.

Nyní aplikaci můžeme spustit z příkazového řádku a bude fungovat (ve výchozím nastavení běží na `127.0.0.1:5000`). Fungovat bude ovšem pouze po dobu, co budeme přihlášeni a poběží interaktivní session. Navíc poběží pod identitou uživatele `pi`, který má zbytečně vysoká oprávnění, což představuje bezpečnostní riziko.

## Zabezpečení

Vytvoříme proto uživatele jménem `www-askme`, který nemá žádná speciální práva. Přiřadíme mu tedy práva ke čtení do složky s aplikací a práva pro zápis do složky `App_Data`, kde je umístěna naše Sqlite databáze, aby do ní aplikace mohla zapisovat.

> Na složce `App_Data` není v .NET 5 nic speciálního a datová složka se může jmenovat jakkoliv. Nicméně v .NET Frameworku (4.x a nižší) měla jisté speciální vlastnosti a typicky se jednalo o jedinou složku, kam aplikace mohla sama zapisovat. Přijde mi užitečné se této konvence držet.

Po provedení těchto změn lze aplikaci spustit i pod identitou omezeného uživatele `www-askme`.

## Vyvolávání démonů

Stále ale přetrvává problém s tím, že aplikace běží jenom pokud je ručně spuštěna a dokud je uživatel přihlášen, což u web serveru není úplně praktické. Chceme, aby se spouštěla automaticky při startu operačního systému a běžela na pozadí. Windows takovým programům říká _služby_ a konkrétně v případě web serveru je před námi typicky skrývá tím, že se o běh stará IIS. Na Linuxu se tomuto druhu programů říká _daemon_ (démon) a musíme si je oinstrumentovat sami.

Vytvoříme tedy démona jménem `kestrel-askme`. Začneme tím, že vytvoříme soubor jménem `/etc/systemd/system/kestrel-askme.service` (název souboru určuje název služby). Zadáme do něj následující obsah:

```
[Unit]
Description=ASKme .NET 5 Web Application

[Service]
WorkingDirectory=/home/pi/AskMe/
ExecStart=/home/pi/AskMe/Altairis.AskMe.Web.RazorPages
Restart=always
RestartSec=10
SyslogIdentifier=dotnet-askme
User=www-askme
Environment=ASPNETCORE_ENVIRONMENT=Production

[Install]
WantedBy=multi-user.target
```

Význam obsahu souboru je myslím dostatečně srozumitelný, [podrobnější informace o Systemd Units najdete na webu DigitalOcean](https://www.digitalocean.com/community/tutorials/understanding-systemd-units-and-unit-files). V zásadě určuje jaký program (`/home/pi/AskMe/Altairis.AskMe.Web.RazorPages`) se má spustit, v jakém adresáři (`/home/pi/AskMe/`), pod jakou identitou (`www-askme`) a s jakými proměnnými prostředí (`ASPNETCORE_ENVIRONMENT=Production`).

Následujícími dvěma příkazy službu povolíme (nainstalujeme) a spustíme:

```sh
sudo systemctl enable kestrel-askme.service
sudo systemctl start kestrel-askme.service
```

Tímto jsme dosáhli toho, že naše aplikace běží na pozadí, automaticky se spustí po rebootu systému a pokud spadne, Systemd ji znovu spustí. Aplikace ovšem běží na nestandardním portu 5000 (což je výchozí nastavení pro Kestrel). Pokud bychom ji chtěli rozjet na standardním portu 80, museli bychom změnit konfiguraci.

Mnohem typičtější ale je, že se Kestrel do sítě nevystavuje přímo, ale prostřednictvím nějaké reverzní proxy, jako je například Nginx. O tom si ale povíme v příštím pokračování za týden ve čtvrtek na kanálu [Z-Tech](https://www.ztech.cz/).