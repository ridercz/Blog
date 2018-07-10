<!-- dcterms:identifier = aspnetcz#189 -->
<!-- dcterms:title = Virtualizace: První zkušenosti s Microsoft Hyper-V -->
<!-- dcterms:abstract = Jak již stálí čtenáři vědí, virtualizační technologie patří k mým oblíbeným, ostatně i tento web běží na virtuálním serveru. Nemohl jsem tedy odolat a vyzkoušel jsem novou technologii Microsoft Hyper-V, která je součástí Windows Serveru 2008. -->
<!-- np9:categoryId = 7 -->
<!-- x4w:category = Software -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- np9:serialId = 1 -->
<!-- x4w:serial = Virtualizace -->
<!-- dcterms:created = 2008-03-18T18:31:41.287+01:00 -->
<!-- dcterms:dateAccepted = 2008-03-18T18:31:41.287+01:00 -->

Technologie Hyper-V je součástí Windows Serveru 2008. Svým určením je to v podstatě nástupce Virtual Serveru 2005 (o kterém jsem zde již [psal](https://www.aspnet.cz/Articles/110-virtualizace-virtual-server-2005-r2.aspx), stejně jako o obecných principech [virtualizace](https://www.aspnet.cz/Articles/103-virtualizace-uvod.aspx)).

## Co co je Microsoft Hyper-V

[![Hyper-V manager](https://www.cdn.altairis.cz/Blog/2008/20080318-20080318-hyperv-manager_thumb.png)](https://www.cdn.altairis.cz/Blog/2008/20080318-20080318-hyperv-manager_2.png)  

Hyper-V je nová generace virtualizační technologie, přímo svázaná s operačním systémem a vyždaující speciální hardware (procesor s HW podporou virtualizace). Jedná se tedy o opravdovou virtualizaci, nikoliv o emulaci. 

Ve finální verzi Windows Serveru 2008 je pre-release verze Hyper-V, ostrá verze bude po dokončení nahrána pomocí Windows Update. Hyper-V je k dispozici pouze na 64-bitové edici Windows Server 2008 Standard a vyšší.

Já to testuji na Windows Server 2008 Enterprise RTM, jako hardware používám server HP ProLiant DL320 G5 s dual-core procesorem a 8 GB operační paměti.

## Instalace a první dojmy

[![Nastaven&iacute; virtu&aacute;ln&iacute;ho serveru](https://www.cdn.altairis.cz/Blog/2008/20080318-20080318-hyperv-settings_thumb.png)](https://www.cdn.altairis.cz/Blog/2008/20080318-20080318-hyperv-settings_2.png)  

Přestože se můj server nenachází na oficiálním [seznamu podporovaného hardware](https://www.microsoft.com/windowsserver2008/en/us/hyperv-install.aspx#RecommendedHardwareDevices) pro pre-release verzi, byla instalace vcelku bezproblémová. Jediný problém spočívá v tom, že pro instalaci a provoz Hyper-V musíte mít na serveru nastavené anglické prostředí. 

Lépe řečeno: System a Default user locale musí být "English (United States)". Lze doinstalovat českou klávesnici a změnit regional settings pro jiného uživatele. Pokud to neuděláte, odmítne virtualizační služba nastartovat. Tento problém by měl být vyřešen ve finální verzi.

Správa virtuálních serverů se provádí z Microsoft Management Console, nikoliv přes web, jako v případě Virtual Serveru 2005. Obecně mi přijde rozhraní pro správu velmi dobře navržené, například všechny parametry virtuálnícho stroje lze nastavit z jednoho přehledného dialogu, který je vyřešen ještě lépe, než obdobný dialog u Virtual PC (a o řád lépe, než webové rozhraní Virtual Serveru). To je ale průvodní znak téměř všech nástrojů pro správu, které jsou součástí Windows Serveru 2008. Zdá se mi, že při jejich navrhování skutečně někdo myslel hlavou.

Bohužel není (a obávám se, že z technologických důvodů ani nikdy nebude) oficiálně podporován scénář, kdy na fyzický server přistupujete přes remote desktop (terminál) a z něj spravujete konzoli virtuálního stroje (VMRC). Praktické zkušenosti jsou takové, že pokud máte nainstalované Integration services (dříve Virtual Machine Additions), funguje to celkem dobře, včetně myší atd. Nechodí akorát systémové klávesové zkratky, protože kolidují s terminálovými službami. Pokud nemáte nainstalované Integration Services, myš nefunguje vůbec, narozdíl od Virtual Serveru, kde fungovala sice chaoticky, ale přece jenom. Při instalaci a úvodní konfiguraci OS si tedy musíte vystačit jenom s klávesnicí.

Instalace integration services je také vyřešena podstatně lépe, není tam klasický setup, stačí vrazit virtuální CD do mechaniky a pokud je spuštěn autorun, nainstaluje se to samo, stačí akorát mačkat Enter, což ze shora uvedených důvodů potěší.

Byla kompletně překopána logika podpory sítí. Hyper-V vytvoří nad fyzickou kartou virtuální síťvku, přes kterou pak vede veškerou komunikaci fyzického i virtuálního stroje. Microsoft doporučuje u serveru vyhradit jednu fyzickou kartu pro management a přijde mi to jako velmi dobrá rada, protože pokud budete mít jenom jednu síťovku a Hyper-V vám nějak vyhnije, na server se po síti nedostanete.

Neprováděl jsem žádné formální testování, ale subjektivně mi přijde Hyper-V svižnější, než Virtual Server 2005 R2 SP1 na podobním hardware

## Převod serverů z Virtual Serveru 2005

Vyzkoušel jsem i převod virtuálního serveru z Virtual Server 2005 do Hyper-V. Formát virtuálních disků (VHD) zůstává stejný jako u VS nebo VPC. Soubory s nastaveními (VMC) jsou různé, lépe řečeno, Hyper-V používá nějaký zcela odlišný formát. Virtuální stroj a jeho nastavení tedy budete muset vytvořit znovu a jenom k němu připojit existující disky.

Hardware virtuálního stroje je v Hyper-V odlišný, než ve Virtual PC nebo Virtual Serveru, nejsou kompatibilní ani Virtual Machine Additions. Musíte je tedy odinstalovat a nainstalovat Integration Services. Kromě odpovídajících ovladačů také změni HAL ve Windows 2003.

Shora uvedené se týká i síťových karet. Před migrací byste tedy měli ještě na starém železe vymazat IP konfiguraci síťových karet, jiank bude Windows při nastavení stejné IP protestovat. Pokud jste na to zapomněli, postup pro odstranění starých síťových karet najdete v [Q241257](http://support.microsoft.com/default.aspx/kb/241257).

Po několika restartech (odinatalace VM Additions, instalace nového HAL, instalace Integration Services) a nastavení IP na nových síťových kartách systém normálně funguje.