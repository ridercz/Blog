<!-- dcterms:title = ASP.NET na Raspberry Pi: Publikace pomocí Nginxu a nastavení firewallu -->
<!-- dcterms:abstract = Čtvrtý díl seriálu o ASP.NET na Raspberry Pi se zabývá instalací a konfigurací Nginxu jako reverzní proxy pro publikaci a základním nastavením firewallu. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20211104-dotnet-raspi-4.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20211104-dotnet-raspi-4.jpg -->
<!-- x4w:coverCredits =  Karminski-牙医 via Unsplash.com -->
<!-- x4w:category = Z-TECH -->
<!-- x4w:category = IT -->
<!-- x4w:serial = ASP.NET na Raspberry Pi -->
<!-- dcterms:dateAccepted = 2021-11-04 -->

Naše Raspberry Pi jsme na konci třetího pokračování opustili ve stavu, kdy naše ASP.NET aplikace běží v Kestrelu jako služba (daemon) na nestandardním portu 5002. Dnes se podíváme na to, jak ji vypublikovat na portu 80 (případně 443) pomocí Nginxu a jak server zabezpečit pomocí firewallu.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/VI_EcSLnATs" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

## Nginx

Kestrel je jednoduchý web server a v triviálních případech bychom si s ním vystačili (bude o tom řeč v příštím dílu za týden), ale ve většině případů je lepší jej schovat za web akcelerátor, který jej publikuje do sítě. Nejčastěji se k tomuto účelu používá [Nginx](https://www.nginx.org), případně jeho konkurence [HAProxy](https://www.haproxy.org/). Použití Nginxu umožní v případě potřeby řešit cacheování, HTTPS terminaci a případně věci jako load balancing a další.

Následujícím příkazem Nginx nainstalujete:

```bash
sudo apt-get install nginx -y
```

Po instalaci jej spusťte:

```bash
sudo service nginx start
```
Když se nyní podíváte webovým prohlížečem na adresu svého RPi, měli byste vidět úvodní stránku Nginxu.

Vytvořte soubor `/etc/nginx/sites-available/askme` a zadejte do něj následující obsah:

```nginx
server {
    listen 80;
    location / {
        proxy_pass http://localhost:5002;
        proxy_http_version 1.1;
        proxy_set_header   Upgrade $http_upgrade;
        proxy_set_header   Connection keep-alive;
        proxy_set_header   Host $host;
        proxy_cache_bypass $http_upgrade;
        proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header   X-Forwarded-Proto $scheme;
    }
}
```

Tento soubor říká, že má naslouchat na portu 80 a fungovat jako proxy pro `http://localhost:5002`. 

Následujícími příkazy pak zakážete výchozí web, místo něj povolíte ten právě vytvořený a obnovíte konfiguraci Nginxu:

```bash
sudo ln /etc/nginx/sites-available/askme /etc/nginx/sites-enabled/askme
sudo rm /etc/nginx/sites-enabled/default
sudo nginx -s reload
```

## Nastavení firewallu

Alespoň základní zabezpečení serveru zařídíme pomocí firewallu UFW, kterým zakážeme připojení zvenčí na všechny porty s výjimkou 22 (SSH), 80 (HTTP) a 443 (HTTPS, i když to zatím nepoužíváme).

UFW nainstalujete pomocí Aptitude. Bohužel v současné verzi je nezbytné po instalaci Raspberry Pi restartovat:

```bash
sudo apt-get install ufw -y
sudo reboot now
```

Následující sekvencí příkazů pak UFW nastavíte a povolíte:

```bash
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw enable
```

## ASP.NET na Raspberry Pi Zero 2

V tomto okamžiku měl dle původních plánů náš seriál končit. Dosáhli jsme svého cíle, naše webová aplikace běží na Raspbery Pi a to relativně spolehlivě a bezpečně. Nicméně v průběhu vytváření seriálu byl uveden nový model Raspberry Pi Zero 2, miniaturní počítač v ceně 15 dolarů.

Předchozí verze Zero/Zero W běh .NET nepodporovala, protože měla příliš starý procesor. Nicméně nová generace již obsahuje podporovaný procesor, což nám umožní použít jej i pro běh ASP.NET. Mimořádně tedy příští čtvrtek vyjde pátý díl tohoto čtyřdílného seriálu, v němž ukážu jak tutéž aplikaci rozjet na RPi Zero 2 v FDD (Framework-Dependent Deployment) režimu, tedy s instalací .NET runtime a bez Nginxu, protože RPi Zero nemá výkonu na rozdávání a nechci jej zbytečně zatěžovat dalším softwarem.