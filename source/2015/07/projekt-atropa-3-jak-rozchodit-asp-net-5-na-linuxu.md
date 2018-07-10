<!-- dcterms:identifier = aspnetcz#5431 -->
<!-- dcterms:title = Projekt Atropa (3): Jak rozchodit ASP.NET 5 na Linuxu -->
<!-- dcterms:abstract = V předchozích dílech seriálu jsme si řekli, proč a jak budeme tvořit "zlý" počítač založený na Raspberry Pi a Raspbian Linuxu a ukázali si, jak jej nainstalovat. V dnešním pokračování si ukážeme, jak na něj nainstalovat Mono, ASP.NET 5 a jak napsat a spustit jednoduchou aplikaci. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Programování -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- np9:serialId = 7 -->
<!-- x4w:serial = Projekt Atropa -->
<!-- dcterms:created = 2015-07-13T04:48:35.75+02:00 -->
<!-- dcterms:dateAccepted = 2015-07-27T00:00:00+02:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20150713-projekt-atropa-1-jak-vyrobit-z-raspberry-pi-zle-zarizeni-s-netem.jpg -->

V předchozích dílech seriálu jsme si řekli, proč a jak budeme tvořit "zlý" počítač založený na Raspberry Pi a Raspbian Linuxu a ukázali si, jak jej nainstalovat. V dnešním pokračování si ukážeme, jak na něj nainstalovat Mono, ASP.NET 5 a jak napsat a spustit jednoduchou aplikaci. Uvedený postup je sice psán na míru Raspberry Pi a Raspbianu, ale mělo by být možné jej použít obecně, i pro jiné distribuce Linuxu.

## Architektura ASP.NET 5

Dnes je de facto podporován jenom jediný runtime (.NET Framework) a ASP.NET je závislé na řadě starých API pevně svázaných s Windows a IIS. Není prakticky možné provozovat ASP.NET na ničem jiném, než na Windows. Takhle vypadá ASP.NET dnes, ve verzi 4.5:

[![atropa_aspnet_45](https://www.cdn.altairis.cz/Blog/2015/20150713-atropa_aspnet_45_thumb.png "atropa_aspnet_45")](https://www.cdn.altairis.cz/Blog/2015/20150713-atropa_aspnet_45_2.png)

S ASP.NET 5 se architektura výrazně změní. Nová verze bude nezávislá na použitém operačním systému a Windows, Mac OS X a Linux budou chápány jako rovnocenné platformy. K dispozici budeme mít také na výběr ze třech různých platforem, kterým se říká DNX (.NET Execution Environment) a budou mít různé vlastnosti. A čistě na nich, bez závislosti na konkrétních legacy API, budou postaveny všechny webové technologie. Lze si to představit zhruba takto:

[![atropa_aspnet_50](https://www.cdn.altairis.cz/Blog/2015/20150713-atropa_aspnet_50_thumb.png "atropa_aspnet_50")](https://www.cdn.altairis.cz/Blog/2015/20150713-atropa_aspnet_50_2.png)

K dispozici máme v současné době celkem tři různá běhová prostředí - DNX:

*   **.NET Framework 4.6** - to je plnohodnotný .NET, jak ho známe a milujeme. Funguje jenom na Windows a nabízí úplnou sadu API a nejširší možnosti. 
*   **CoreCLR** - nový runtime, napsaný od základu. Momentálně toho umí nejméně a zatím není v praxi použitelný, ale postupně by měl .NET Framework nahradit a být k dispozici pro všechny tři podporované platformy (zatím je k dispozici jenom pro Windows). 
*   **Mono** - projekt Mono dostává s příchodem ASP.NET 5 nový smysl. Funguje multiplatformně, na Windows, Linuxu i Macu a je dostatečně dospělý pro řadu aplikací. 

## Instalace Mono runtime

V ideálním světě by stačilo napsat `sudo apt-get install mono-complete`. Nicméně, v ideálním světě nežijeme a v repozitářích Raspbianu není v době psaní tohoto článku dostupná aktuální verze Mona. A verze, která je k dispozici, příliš nefunguje a není kompatibilní s ASP.NET 5. Takže k instalaci je třeba poněkud více příkazů:

    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF 
    echo "deb http://download.mono-project.com/repo/debian wheezy main" | sudo tee /etc/apt/sources.list.d/mono-xamarin.list 
    sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get install mono-complete -y

Prvními dvěma příkazy přidáme do seznamu repozitářů balíčkovacího systému server pro distribuci Mona. Dalšími příkazy aktualizujeme seznam dostupných balíčků, nainstalujeme dostupné aplikace a konečně kompletní distribuci Mona. Jejich vykonání bude chvíli trvat, protože je nutné stáhnout a nainstalovat spoustu věcí.

## Instalace Libuv

ASP.NET 5 využívá knihovnu Libuv, která slouží k asynchronnímu programování. Bohužel, není k dispozici jako balíček. Začněte tím, že se podíváte na [stránky projektu na GitHubu](https://github.com/libuv/libuv/releases) a zjistíte aktuální verzi. V době psaní článku byla aktuální verze 1.6.1. Pokud mezi tím vyjde novější, upravte v příkazech číslo verze.

K instalaci použijte následující příkazy:

    sudo apt-get install automake libtool -y
    curl -sSL https://github.com/libuv/libuv/archive/v1.6.1.tar.gz | sudo tar zxfv - -C /usr/local/src
    cd /usr/local/src/libuv-1.6.1
    sudo sh autogen.sh
    sudo ./configure
    sudo make
    sudo make install
    sudo rm -rf /usr/local/src/libuv-1.6.1 && cd ~/
    sudo ldconfig

První příkaz nainstaluje balíčky `automake` a `libtool`, které budeme potřebovat dále. Druhým příkazem stáhnete zdrojové kódy knihovny a rozbalíte je do dočasné složky v `/usr/local/src`. Dalšími příkazy potom kód zkompilujete a dočasné soubory smažete.

## Přidání certifikátů mezi důvěryhodné

ASP.NET 5 si průběžně dotahuje balíčky z různých serverů. Komunikuje s nimi přes HTTPS. Následující sekvencí příkazů všechny použité certifikáty označíme jako důvěryhodné:

    sudo yes | sudo certmgr -ssl -m -v https://go.microsoft.com
    sudo yes | sudo certmgr -ssl -m -v https://nugetgallery.blob.core.windows.net
    sudo yes | sudo certmgr -ssl -m -v https://myget.org
    sudo yes | sudo certmgr -ssl -m -v https://nuget.org
    sudo yes | sudo certmgr -ssl -m -v https://www.myget.org/F/aspnetvnext/
    sudo mozroots --import --sync --quiet

## Instalace ASP.NET 5

Nyní můžeme konečně nainstalovat ASP.NET 5 jako takové. Základem všeho je DNVM - .NET Version Manager. Můžete totiž mít nainstalovány různé verze .NETu side by side

Instalační skript pro DNVM je k dispozici na GitHubu a získáte jej následujícím příkazem:

    curl -sSL https://raw.githubusercontent.com/aspnet/Home/dev/dnvminstall.sh | DNX_BRANCH=dev sh && source ~/.dnx/dnvm/dnvm.sh

Nejsou ale nainstalovány žádné verze DNX, jak se můžete přesvědčit příkazem `dnvm list`. Pro instalaci nejnovější betaverze použijte příkaz `dnvm upgrade`. V době psaní článku jde o verzi 1.0.0-beta5, jak vidíte v následujícím výstupu uvedeného příkazu:

    *pi@raspberrypi ~ $* **dnvm upgrade**
    Determining latest version
    Latest version is 1.0.0-beta5
    Downloading dnx-mono.1.0.0-beta5 from https://www.nuget.org/api/v2
    Download: https://www.nuget.org/api/v2/package/dnx-mono/1.0.0-beta5
    ######################################################################## 100.0%
    Installing to /home/pi/.dnx/runtimes/dnx-mono.1.0.0-beta5
    Adding /home/pi/.dnx/runtimes/dnx-mono.1.0.0-beta5/bin to process PATH
    Setting alias 'default' to 'dnx-mono.1.0.0-beta5'

Pokud v době, kdy budete ASP.NET instalovat, bude k dispozici novější verze, musíte patřičným způsobem upravit i následující soubory a projekty.

Poznámka: v předchozích verzích se DNVM jmenoval KVM a byly k dispozici i jiné příkazy. Pokud najdete příklady, kde je příliš mnoho "káček", patrně jsou zastaralé.

Nyní byla dokončena instalace ASP.NET 5 a můžeme vytvořit první projekt.

## Vytvoření ukázkového projektu

Náš "zlý captive portál" se bude jmenovat WiFiGate a tomu odpovídají i názvy adresářů a podobně.  Pokud chcete rozjet vlastní aplikaci, pojmenujte si je jinak.

Začneme tím, že vytvoříme v domácím adresáři aktuálního uživatele `pi` adresář `www` a v něm adresář `wifigate`. K tomu použijeme následující příkaz: `mkdir -p ~/www/wifigate`.

Poté vytvoříme v uvedeném adresáři definiční soubor `project.json`. K editaci souborů budeme obecně používat editor nano, protože je dosti komfortní a uživatelé Windows s ním budou nejspíše dost kompatibilní. Spusťte jej příkazem `nano ~/www/wifigate/project.json`.

[![Editor Nano](https://www.cdn.altairis.cz/Blog/2015/20150713-atropa_nano_thumb.png "Editor Nano")](https://www.cdn.altairis.cz/Blog/2015/20150713-atropa_nano_2.png)

Zadejte do souboru následující kód (nezapomeňte jej upravit, budete-li používat novější verzi, než `1.0.0-beta5`; k náhradě textu můžete v editoru Nano použít klávesovou zkratku *Ctrl+W Ctrl+R*):

    {
      "dependencies": {
          "Kestrel": "1.0.0-beta5",
          "Microsoft.AspNet.Diagnostics": "1.0.0-beta5",
          "Microsoft.AspNet.Hosting": "1.0.0-beta5",
          "Microsoft.AspNet.Server.WebListener": "1.0.0-beta5",
          "Microsoft.AspNet.StaticFiles": "1.0.0-beta5"
      },
      "frameworks": {
          "dnx451": { },
          "dnxcore50": { },
      },
      "commands": {
          "kestrel": "Microsoft.AspNet.Hosting --server Kestrel --server.urls http://localhost:5004"
      }
    }

Editor ukončete stikem *Ctrl+X*. Na otázku, zda se má modifikovaný obsah uložit, odpovězte *Y* (ano). Nabídnutý název souboru neměňte a potvrďte jej stiskem klávesy *Enter*.

Stejným způsobem vytvořte v téže složce soubor `Startup.cs`, jehož obsah bude následující:

    using Microsoft.AspNet.Builder;

    namespace Altairis.WiFiGate {
        public class Startup {
            public void Configure(IApplicationBuilder app) {
                app.UseStaticFiles();
                app.UseWelcomePage();
            }
        }
    }

Tento kód vesměs nic nedělá, jenom zobrazí ukázkovou stránku, abychom věděli, že vše řádně funguje.

## Obnovení NuGet balíčků a spuštění projektu

Před spuštěním aplikace je nutné nainstalovat (obnovit) balíčky, specifikované v souboru `project.json`. To jest činiti příkazem `dnu restore ~/www/wifigate/`.

Nyní konečně můžeme spustit projekt ve vestavěném serveru Kestrel, následujícím příkazem: `dnx ~/www/wifigate/ kestrel`.

Spouštění bude chvíli trvat, ale poté, co se vypíše na konzoli "Started", můžeme se podívat na IP adresu RPi a port 5004 (zkonfigurovaný v `project.json`). Pokud jste vše udělali správně, měla by se vám zobrazit ukázková stránka ASP.NET 5:

[![Ukázková stránka ASP.NET 5](https://www.cdn.altairis.cz/Blog/2015/20150713-atropa_demopage_thumb.png "Ukázková stránka ASP.NET 5")](https://www.cdn.altairis.cz/Blog/2015/20150713-atropa_demopage_2.png)

Gratulujeme, právě jste zprovoznili ASP.NET 5 aplikaci na Raspberry Pi na Linuxu.

Za normálních okolností byste měli mít možnost ukončit Kestrel tím, že stisknete Enter.  Aktuální beta ovšem obsahuje chybu, takže je nutné použít poněkud dramatičtější prostředky.

Nejprve proces pozastavte stiskem klávesové zkratky *Ctrl+Z*. Poté si příkazem `ps` najděte proces jménem `mono` a zjistěte jeho pid (v prvním sloupci, například zde 18080). Pomocí příkazu `kill -9 <pid>` proces zabijte. Že vše proběhlo v pořádku si můžete ověřit opětovným spuštěním příkazu `ps`. Celou sekvenci vidíte zde:

    *pi@raspberrypi ~ $*** dnx ~/www/wifigate/ kestrel**
    Started

    [1]+  Stopped                 dnx ~/www/wifigate/ kestrel
    *pi@raspberrypi ~ $ ***ps**
      PID TTY          TIME CMD
    18001 pts/0    00:00:01 bash
    18080 pts/0    00:00:54 mono
    18090 pts/0    00:00:00 ps
    *pi@raspberrypi ~ $ ***kill -9 18080**
    *pi@raspberrypi ~ $ ***ps**
      PID TTY          TIME CMD
    18001 pts/0    00:00:01 bash
    18091 pts/0    00:00:00 ps
    [1]+  Killed                  dnx ~/www/wifigate/ kestrel
    *pi@raspberrypi ~ $*

Aplikace nám sice běží, ale jenom na vývojovém serveru a musíme jí ručně spustit, neběží v pozadí jako služba. Jak to zařídit, to si ukážeme v dalším pokračování za týden.