<!-- dcterms:title = ASP.NET Core na Linuxu: Jak získat výkonný cloudový server zdarma -->
<!-- dcterms:abstract = Společnost Oracle nabízí zdarma ve svém cloudu server se čtyřmi jádry, 24 GB RAM a 200 GB disku. Jaký je v tom háček? Má ARM architekturu a běží na něm Linux. V novém seriálu vám ukážu, jak na takovém serveru bezpečně a odděleně od sebe hostovat více ASP.NET Core aplikací. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:coverUrl = /cover-pictures/20230118-oci-linux.jpg -->
<!-- x4w:pictureUrl = /perex-pictures/20230118-oci-linux.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = Z-TECH -->
<!-- x4w:category = IT -->
<!-- dcterms:dateAccepted = 2023-01-18 -->

Společnost Oracle nabízí zdarma ve svém cloudu server se čtyřmi jádry, 24 GB RAM a 200 GB disku. Je to součást [always free cloud services](https://www.oracle.com/cloud/free/), nejedná se tedy o trial nebo o nabídku omezenou na rok, jak to má třeba [Azure](https://azure.microsoft.com/en-us/pricing/free-services/) nebo [AWS](https://aws.amazon.com/free/). Můj názor je, že Oracle je se svým cloudem relativně nový a méně významný hráč, proto se snaží touto cestou přitáhnout zákazníky.

Pro .NET programátory zvyklé na Windows může být poněkud nezvyklé, že ona jádra mají ARM architekturu a nelze tak v rámci této virtuálky nainstalovat Windows Server. Nicméně lze tam nainstaloval Linux a na něm .NET běží zcela bez problémů, i na ARM architektuře.

Rozhodl jsem se, že využiji tuto nabídku od Oracle k tomu, abych si postavil server, na kterém budu hostovat různé malé "zbytkové" aplikace, pro které z různých (zejména finančních) důvodů nechci dělat samostatné cloudové služby. Nevyžadují žádný velký výkon, takže čtyřjádrový server se 24 GB RAM jim postačí více než dostatečně. Chci ale, aby to celé bylo bezpečné, aby aplikace od sebe byly navzájem izolované a byly provozovány pod účtem s minimálními oprávněními.

A navíc jsem na toto téma vytvořil [bezplatné elektronické školení](https://elearning.altairis.cz/cs/courses/netlinux) na platformě Altairis eLearning a seriál videí na [YouTube kanálu Z-TECH](https://youtube.com/ztechcz). Pro pořádek: popisované postupy nejsou závislé na Oracle cloudu. Prakticky stejný postup můžete použít kdekoliv, kde běží Ubuntu Linux (a po mírné úpravě i na jiné distribuce). Místo Oracle můžete použít třeba můj oblíbený [Digital Ocean](https://altair.is/digitalocean).

Zbývá vyřešit jenom jeden problém: kam bude aplikace ukládat data, protože sice existuje Microsoft SQL Server pro Linux, ale neběží na ARM architektuře. Nicméně pro tak malé aplikace, jaké já tam potřebuju hostovat, plně postačuje použití Sqlite a tomu jsem se už [v minulosti dost podrobně věnoval](https://www.youtube.com/playlist?list=PLFZurxJN0pMZl_W9qflSsUzcCSPYb_93P).

##  Jak získat výkonný cloudový server zdarma

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/JAb0Wfd5AX4" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

V prvním dílu seriálu vám ukážu, jak vytvořit virtuální server v OCI (Oracle Cloud Infrastructure), aktualizovat ho a nastavit pravidla pro firewall. To není úplně triviální, protože firewall musíte nastavit na dvou místech. Na serveru samotném a pak v cloudové infrastruktuře.

## Self-Contained deployment, nastavení služby a Nginxu

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/FhxuchYRzRA" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

Druhý díl je klíčový, protože v něm provedeme vlastní nasazení aplikace a konfiguraci. Není to úplně triviální, protože pro ARM neexistuje balíčková instalace .NETu, takže nejjednodušším řešením je použít SCD (self-contained deployment), kdy aplikaci zkompilujeme přímo do nativního kódu pro danou architekturu a operační systém. Aplikace si také nese vlastní runtime, na server není třeba instalovat žádnou podporu pro .NET. 

Také vám předvedu, jak správně nastavit identitu uživatele, pod kterým aplikace poběží a jak nastavit práva. Vše je připraveno na to, že na serveru poběží ne jedna aplikace, ale hned několik různých a budou od sebe oddělené. Zároveň nastavíme aplikaci jako službu (daemona), aby se spustila při startu systému, běžela na pozadí a pomocí proměnných prostředí nastavíme její konfiguraci.

Jako poslední vám v tomto díle ukážu, jak nainstalovat Nginx jako reverzní proxy a jak pomocí něj aplikaci vypublikovat do Internetu, protože nechcete aby vám uživatelé z Internetu přistupovali přímo ke Kestrelu.

## Automatizace nasazení z Visual Studia

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/jtpvWHJZdYc" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

Dříve popsaný proces nasazení aplikace na Linux pomocí SCP vyžadoval značné množství manuálních úkonů. V tomto videu vám předvedu, jak lze tyto úkony automatizovat. Také vám ukážu jak nastavit vlastní chybovou stránku, která se zobrazí, pokud web právě neběží, třeba protože nasazujeme novou verzi.

Automatizaci deploymentu přes SCP jsem se už [v minulosti na tomto blogu věnoval](https://www.altair.blog/2021/11/scp-publish) a toto video v zásadě vychází z tohoto článku. Nicméně nabízí toho mnohem víc (umí po dobu deploymentu službu zastavit a pak zase spustit) a je aktuálnější. V článku jsem popisoval ošklivý hack jak na 64-bitovém systému volat SCP z 32-bitového MSBuildu, ale současné Visual Studio už podporuje 64-bitový MSBuild, takže v článku popisovaný postup nejenom že není potřeba, ale ve výchozím nastavení už ani nefunguje. Nový je mnohem jednodušší.

##  Certifikáty, HTTPS a HSTS

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/K90hQjLFif8" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

Ve čtvrtém dílu seriálu o ASP.NET Core na Linuxu vám ukážu, jak pomocí utility Certbot a Let's Encrypt CA získat certifikát pro HTTPS a vše správně nastavit, včetně Strict-Transport-Security hlavičky pro HSTS. Provozovat jakýkoliv web přes HTTPS je dneska prakticky nutnost, ale s Certbotem na NGinxu je to extrémně snadné. Certbot mě inspiroval při psaní mého vlastního nástroje [AutoACME](https://www.autoacme.net/), ale tak jednoduché jsem to udělat nedokázal.