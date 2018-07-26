<!-- dcterms:identifier = aspnetcz#5432 -->
<!-- dcterms:title = Projekt Atropa (4): Automatické spuštění webu a publikace pomocí nginx -->
<!-- dcterms:abstract = V předchozích dílech jsme si ukázali postup, jak na Raspberry Pi rozchodit ASP.NET a napsat jednoduchou aplikaci. Web server jsme ale museli spustit ručně a jde o interní server Kestrel. V tomto pokračování se podíváme na to, jak spustit aplikaci jako daemona (službu) a vypublikovat ji pomocí nginx. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = IT -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- np9:serialId = 7 -->
<!-- x4w:serial = Projekt Atropa -->
<!-- dcterms:created = 2015-07-13T15:31:20.883+02:00 -->
<!-- dcterms:dateAccepted = 2015-08-03T00:00:00+02:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20150713-projekt-atropa-1-jak-vyrobit-z-raspberry-pi-zle-zarizeni-s-netem.jpg -->

V předchozích dílech jsme si ukázali postup, jak na Raspberry Pi rozchodit ASP.NET a napsat jednoduchou aplikaci. Web server jsme ale museli spustit ručně a jde o interní server Kestrel. V tomto pokračování se podíváme na to, jak spustit aplikaci jako daemona (službu) a vypublikovat ji pomocí nginx.

## Automatické spuštění Kestrelu pomocí init.d

Na Windows se jim říká služby, na UNIX-like systémech démoni. Programy, které startují automaticky a při spuštění běží v pozadí, i když není nikdo interaktivně přihlášen. Jako první potřebujeme zařídit, aby se Kestrel, web server na kterém běží ASP.NET, choval právě takhle.

Můj návod vychází z postupu, který [popsal Ivan Derevianko na svém blogu](http://druss.co/2015/06/run-kestrel-in-the-background/). Jeho návod nicméně s nejnovější verzí ASP.NET nefunguje, protože se změnila syntaxe, s jakou se DNX volá. [Mou upravenou verzi](https://gist.github.com/ridercz/97e01a4c67c045eb9d46) najdete na GitHubu.

Začněte tím, že si mnou upravenou verzi stáhnete z GitHubu následujícím příkazem (d**ůležité:** aby se mi to vešlo na stránku, přidal jsem do URL mezeru (před slovo *raw*); před spuštěním ji odstraňte):

`wget "https://gist.githubusercontent.com/ridercz/97e01a4c67c045eb9d46/ raw/adb69b6fc219bf1a6b6a3dd8869512250afaf6c5/kestrel_service.sh"`

Poté si soubor `kestrel_service.sh` otevřete v editoru Nano příkazem `nano kestrel_service.sh`. Upravte hodnoty, které jsou ve `<ŠPIČATÝCH ZÁVORKÁCH>`, přičemž závorky samotné odstraňte. Pro naši demo aplikaci z předchozího pokračování nastavte následující hodnoty:

*   `<SCRIPT_NAME>` je logický název "služby". V našem případě `kestrel_wifigate`. Pokud byste na jednom počítači chtěli provozovat víc webů, musíte každý z nich zaregistrovat tímto postupem zvlášť pod jiným jménem. 
*   `<WWW_USER>` je název uživatele, pod kterým služba poběží. V našem případě je to `pi`. Z bezpečnostního hlediska není dobrý nápad rozjet web server pod tímto uživatelem, ale pro naše účely to zatím postačí. 
*   `<PATH_TO_RUNTIME>` je cesta k aktuální verzi DNX. V cestě používám dříve definovanou proměnnou `WWW_USER`, cesta pro betu 5 je `/home/$WWW_USER/.dnx/runtimes/dnx-mono.1.0.0-beta5/bin/dnx`. 
*   `<APPROOT>` je cesta k rootu aplikace, v našem případě tedy `/home/$WWW_USER/www/wifigate`. 

Celý soubor bude po úpravách vypadat takto:

    #!/bin/sh
    ### BEGIN INIT INFO
    # Provides:          kestrel_wifigate
    # Required-Start:    $local_fs $network $named $time $syslog
    # Required-Stop:     $local_fs $network $named $time $syslog
    # Default-Start:     2 3 4 5
    # Default-Stop:      0 1 6
    # Description:       Script to run asp.net 5 application in background
    ### END INIT INFO

    # Author: Ivan Derevianko aka druss <drussilla7>
    # Fixed for ASP.NET 5 beta 5 with DNVM/DNX by Michal A. Valasek - github.com/ridercz

    WWW_USER=pi
    DNXRUNTIME=/home/$WWW_USER/.dnx/runtimes/dnx-mono.1.0.0-beta5/bin/dnx
    APPROOT=/home/$WWW_USER/www/wifigate

    PIDFILE=$APPROOT/kestrel.pid
    LOGFILE=$APPROOT/kestrel.log

    # fix issue with DNX exception in case of two env vars with the same name but different case
    TMP_SAVE_runlevel_VAR=$runlevel
    unset runlevel

    start() {
      if [ -f $PIDFILE ] && kill -0 $(cat $PIDFILE); then
        echo 'Service already running' >&2
        return 1
      fi
      echo 'Starting service...' >&2
      su -c "start-stop-daemon -SbmCv -x /usr/bin/nohup -p \"$PIDFILE\" -d \"$APPROOT\" -- \"$DNXRUNTIME\" . kestrel > \"$LOGFILE\"" $WWW_USER
      echo 'Service started' >&2
    }

    stop() {
      if [ ! -f "$PIDFILE" ] || ! kill -0 $(cat "$PIDFILE"); then
        echo 'Service not running' >&2
        return 1
      fi
      echo 'Stopping service...' >&2
      start-stop-daemon -K -p "$PIDFILE"
      rm -f "$PIDFILE"
      echo 'Service stopped' >&2
    }

    case "$1" in
      start)
        start
        ;;
      stop)
        stop
        ;;
      restart)
        stop
        start
        ;;
      *)
        echo "Usage: $0 {start|stop|restart}"
    esac

    export runlevel=$TMP_SAVE_runlevel_VAR</drussilla7>

Ukončete Nano s uložením změn (Ctrl+X, Y, Enter). Nyní je třeba přidat náš skript do init.d, což je infrastruktura, která se stará právě o spouštění služeb. Učiňte to následujícími příkazy:

    sudo cp kestrel_service.sh /etc/init.d/kestrel_wifigate
    sudo chmod +x /etc/init.d/kestrel_wifigate

Prvním příkazem (`cp`) zkopírujete soubor do adresáře `/etc/init.d` a přejmenujete ho na `kestrel_wifigate` (bez přípony). Druhým příkazem (`chmod`) soubor označíte jako vykonatelný. Na Linuxu se k označení spustitelných souborů nepoužívají přípony (`.exe` atd.), ale speciální příznak, který tímto příkazem nastavíte.

Příkazem `sudo service kestrel_wifigate start` službu nastartujete (můžete také místo `start` využít příkazy `stop` a `restart`). Pokud vše dopadlo dobře, chvíli po spuštění služby najdete na adrese serveru a portu 5004 ukázkový ASP.NET 5 web. Pokud vše nedopadlo dobře, službu zastavte a podívejte se do souboru `~/www/wifigate/kestrel.log`, kde najdete, na co si Kestrel stěžuje.

[![Ukázková stránka ASP.NET 5](https://www.cdn.altairis.cz/Blog/2015/20150713-atropa_demopage_thumb.png "Ukázková stránka ASP.NET 5")](https://www.cdn.altairis.cz/Blog/2015/20150713-atropa_demopage_2.png)

Pokud chcete, aby služba startovala automaticky po rebootu (nejspíš ano), nastavte to příkazem `sudo update-rc.d kestrel_wifigate defaults`. Pokud budete chtít autostart zrušit, vypněte ho příkazem `sudo update-rc.d kestrel_wifigate remove`.

Restartujte počítač příkazem `sudo reboot` a vyzkoušejte, že po nastartování služba automaticky naběhne.

## Použití nginx

V zásadě bychom mohli zkonfigurovat Kestrel tak, aby naslouchal ne na portu 5004, ale na portu 80 a prohlásit, že máme hotovo. Nicméně Kestrel není k takovému nasazení zcela vhodný, chybí mu řada obvyklých funkcí (jako třeba schopnost navázat na jeden port několik virtuálních webů) a navíc by musel běžet po doprávněním roota, aby mohl být navázán na port nižší, než 1024. Proto, pokud chceme web vypublikovat do Internetu, použijeme pro to *nginx*. To je program, který slouží (mimo jiné) jako reverzní proxy, dá se srovnat třeba s Application Request Routingem (ARR) v IIS. 

Jak na to, nám opět poradí [Druss](http://druss.co/2015/06/asp-net-5-kestrel-nginx-web-server-on-linux/), jeho návod jsem jenom mírně upravil pro naše potřeby a přidal pár vysvětlivek. Nginx nainstalujete následujícími příkazy:

    sudo apt-get install nginx -y
    sudo update-rc.d nginx defaults
    sudo service nginx start

První příkaz nginx nainstaluje, druhý nastaví automatické spouštění po startu pomocí init.d a třetí službu nastartuje. Když se nyní podíváte z webového prohlížeče na adresu Raspberry Pi s výchozím portem (80), uvidíte hlášku *Welcome to nginx!*:

[![atropa_nginx](https://www.cdn.altairis.cz/Blog/2015/20150713-atropa_nginx_thumb.png "atropa_nginx")](https://www.cdn.altairis.cz/Blog/2015/20150713-atropa_nginx_2.png)

My ovšem nechceme publikovat statický obsah (uložený mimochodem v adresáři `/usr/share/nginx/www/`), ale chceme nginx použít jako proxy pro Kestrel. Proto musíme upravit jeho konfiguraci.

Konfigurace virtuálních serverů nginxu je uložena ve dvou složkách:

*   `/etc/nginx/sites-available` obsahuje konfiguraci jednotlivých virtuálních web serverů. Ne všechny jsou aktivní, je to seznam konfigurací, které jsou k dispozici. 
*   `/etc/nginx/sites-enabled` pak obsahuje symlinky (odkazy, zástupce) na ty soubory ze `sites-available`, které se mají skutečně použít. 

Po instalaci je v `sites-available` vytvořen soubor `default`, který způsobil, že se zobrazila hláška "Welcome to nginx!". Mohli bychom jej editovat, ale jednodušší bude vytvořit nový soubor, který bude obsahovat jenom konfiguraci, kterou potřebujeme.  Soubor se bude jmenovat `/etc/nginx/sites-available/wifigate` a vytvoříte jej pomocí editoru Nano příkazem `sudo nano /etc/nginx/sites-available/wifigate`. Poté do něj zadejte následující text:

    server {
            listen 80;
            location / {
                    proxy_set_header    Host $host;
                    proxy_set_header    X-Real-IP   $remote_addr;
                    proxy_set_header    X-Forwarded-For $proxy_add_x_forwarded_for;
                    proxy_pass  http://127.0.0.1:5004;
            }
    }

Aktualizujeme konfiguraci nginxu následujícími příkazy:

    sudo rm /etc/nginx/sites-available/default
    sudo ln -s /etc/nginx/sites-available/wifigate /etc/nginx/sites-enabled/wifigate
    sudo service nginx restart

Prvním příkazem odstraníme symlink na výchozí konfiguraci, čímž ji vypneme. Druhým příkazem uděláme symlink na naši vlastní konfiguraci, čímž ji zapneme. Posledním příkazem restartujeme nginx, čímž se změny provedou.

Když se nyní podíváte na adresu Raspberry Pi z webového prohlířeče na výchozím portu (80), uvidíte ukázkový ASP.NET 5 projekt.

## Kam jsme se dostali

V průběhu dosavadních dílů seriálu jsme si na minipočítač Raspberry Pi nainstalovali Raspbian Linux, rozjeli na něm ASP.NET 5 a vypublikovali aplikaci pomocí nginxu. Máme univerzální platformu, na které může běžet jakákoliv ASP.NET 5 aplikace, na zařízení velikosti balíčku karet a s cenou okolo tisícovky.

V dalším pokračování si ukážeme, jak z Raspberry Pi udělat WiFi honeypot s captive portálem, jak napsat patřičný portál a jak se podobným útokům bránit.