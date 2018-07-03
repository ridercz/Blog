<!-- dcterms:identifier = aspnetcz#166 -->
<!-- dcterms:title = Konfigurace v ASP.NET a IIS verze 6.0 a 7.0 -->
<!-- dcterms:abstract = Aplikace psané v ASP.NET jsou ve své podstatě konfederace nezávislých tříd, kterou drží pohromadě konfigurace. Je to právě konfigurační systém .NET, který říká kdy se který modul má použít. S příchodem nové verze IIS (7.0 ve Windows Vista a Windows Server 2008) je konfigurační model .NETu ještě důležitější, protože se jeho prostřednictvím budou nastavovat i vlastnosti IIS jako takového. -->
<!-- np9:categoryId = 4 -->
<!-- x4w:category = IIS -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2007-09-17T11:00:37+02:00 -->
<!-- dcterms:dateAccepted = 2007-09-17T11:00:37+02:00 -->

*Poznámka: Tento článek je první součástí seriálu o konfiguraci ASP.NET a vychází z [přednášky](http://akce.altairis.cz/Events/122.aspx), kterou jsem měl v Praze 30. srpna 2007. Nebyl z ní pořízen záznam a těm, kdož se jí nezúčastnili, by patrně nebyly pouhé slajdy k ničemu.*

O aplikacích psaných v "nižších" technologiích, jako je třeba klasické ASP nebo PHP s oblibou (a jistou mírou despektu, přiznávám) tvrdím, že se nejedná ani tak o aplikaci, jako spíše o volnou konfederaci nezávislých skriptů. Typicky totiž jednotlivé stránky aplikace nespojuje nic, až na pár include souborů.

O ASP.NET aplikacích se nicméně dá dle stejného vzoru s trochou nadsázky říct, že jde o volnou konfederaci nezávislých tříd, kterou pohromadě drží konfigurační systém. .NET Framework je striktně objektová technologie, což umožňuje extrémní modularizaci jednotlivých aplikací. A je to právě konfigurace, která určuje, které moduly se mají použít a v jaký okamžik. Je proto důležité konfiguračnímu systému .NET porozumět a naučit se ho využívat. Jinak nebude vývoj větších aplikací povznášejícím zážitkem, ale krvavým bojem, ve kterém budete mít jako programátor dost nevýhodnou pozici.

Stejný model, jaký používá .NET, používá i příští verze Microsoft Internet Information Services - IIS 7.0, která je součástí Windows Vista a bude součástí Windows Serveru 2008 (alias "Longhorn").

## Konfigurace ASP.NET

Tři klíčové vlastnosti konfiguračních mechanismů v .NETu jsou hierarchie, univerzalita a rozšiřitelnost.

*   Konfigurace je **hierarchická**, protože jednotlivé konfigurační soubory popisují pouze změnu od výchozí konfigurace, lépe řečeno od konfigurace "dříve známé". To umožňuje udržovat konfigurační soubory na snesitelné velikosti, ačkoliv konfiguračních nastavení jsou tisíce. Dále pak tento model umožňuje nastavení konfigurace decentralizovat (s možným stanovením omezení), takže není nutno veškeré konfigurace provádět z moci administrátora serveru, ale lze je učinit součástí aplikace samé. Konfigurace je **univerzální**. Jednotný konfigurační model se používá pro nastavení všech částí .NET Frameworku. Základy a principy jsou v podstatě stejné pro webové aplikace, desktopové aplikace, služby, mobilní aplikace atd. Konfigurace je **rozšiřitelná**, protože je její model navržený tak, abyste do konfiguračních souborů mohli ukládat nejenom nastavení .NET Frameworku, ale i nastavení vaší aplikace nebo jednotlivých komponent. Konfigurační soubory jsou zapsány ve formátu XML a formát jednotlivých konfiguračních sekcí není pevně dán, syntaxe je v rukou jejich tvůrce. 

Základní konfigurace, platná pro všechny webové aplikace běžící na daném serveru, je uložena v souboru *machine.config*, který se nachází ve složce .NET Frameworku, typicky tedy v *%SYSTEMROOT%\Microsoft.NET\Framework\v2.0.50727\CONFIG\* (a to i v případě .NET Frameworku 3.0 nebo 3.5, protože i tyto verze používají jádro verze 2.0, pro více viz [samostatný článek](http://www.aspnet.cz/Articles/161-jeste-jednou-a-dukladneji-k-verzim-microsoft-net-frameworku.aspx)).

V téže složce se nachází ještě soubor *web.config*, kterému se obvykle říká *root web.config*. Jedná se v podstatě o vydělení konfigurační sekce system.web do samostatného souboru, z hlediska architektury je jeho role stejná, jako v případě *machine.configu*.

Shora uvedené soubory byste měli modifikovat pouze výjimečně a pouze tehdy, víte-li dobře co a proč děláte. Veškeré další konfigurační soubory totiž popisují pouze změny od tohoto základu. A obecně předpokládají, že ta základní konfigurace bude výchozí, že bude odpovídat standardnímu nastavení .NET Frameworku. Pokud tedy v těchto základních souborech provedete nějaká opravdu divoká nastavení, podřízené aplikace to může poněkud zaskočit, protože očekávají poněkud... konformnější přístup.

Další v pořadí je konfigurační soubor, který se nachází v rootu dané aplikace, tedy v rootu daného virtuálního webu nebo adresáře. Obvykle se označuje jako *~/web.config*, protože tilda (vlnovka) se v ASP.NET používá k označení kořene aplikace. Tento soubor určuje konfiguraci konkrétní aplikace a je to právě on, s nímž budete pracovat nejčastěji.

Je-li aplikace členěna do podadresářů, mohou jednotlivé podadresáře obsahovat další soubory *web.config*, které obsahují nastavení platná pro konkrétní adresář a jeho případné podadresáře. Použití těchto "podřízených" *web.configů* jest spíše věcí osobního vkusu, protože stejného efektu lze dosáhnout přímo v aplikačním konfiguračním souboru pomocí elementu *<location>*, jímž lze omezit působnost určité části konfigurace. 

 Osobně nicméně doporučuji dát vnořeným souborům přednost před psaním všeho do jednoho soubory. V první řadě se tím hlavní *web.config* zpřehledňuje a to je vždy pozitivní (ono je tam u složitějších aplikací i bez toho zmatku dost). Ve druhé řadě tím předejdete možným omylům z nepozornosti. Pokud adresář přejmenujete a konfigurace bude v něm, nic se nestane - bude prostě beze změny platná i pro nový název. Pokud ale použijete element *<location>* v aplikačním konfiguračním souboru, musíte změnu zaznamenat i zde. Pokud tak zapomenete učinit, můžete si v aplikaci vyrobit třeba i ošklivou bezpečnostní díru - například pokud se předmětná konfigurace týká nastavení URL autorizace.

## Konfigurace IIS 6.0

[![Konfigurace ASP.NET v IIS 6.0](http://www.aspnet.cz/Files/20070916-20070915-aspconfig-iis6_thumb.png)](http://www.aspnet.cz/Files/20070916-20070915-aspconfig-iis6.png)V případě Internet Information Services verze 6.0 a nižší se konfigurace web serveru ukládá odděleně od konfigurace ASP.NET a je na ní obecně zcela nezávislá.

Konfigurace IIS se ukládá v takzvané metabázi, což je samostatný konfigurační systém, který používá pouze IIS. Do verze 5.x včetně byla metabáze uchovávána jako binární soubor na disku a pokud došlo k jejímu poškození a neměli jste zálohu, byla sebevražda v některých případech celkem adekvátní reakcí. 

V případě IIS 6.0 se sice jedná o XML soubor, ale dobrovolný odchod ze života jako řešení kategoricky stále neodsuzujte. Rozhodně ne dříve, než se podíváte do souboru *%SYSTEMROOT%\system32\inetsrv\metabase.xml*. Formálně se sice o XML jedná, ale co do architektury se žádná velká hierarchie, přehlednost, rozšiřitelnost a další podobné zážitky s XML obvykle spojované nedostavují.

Ruční nebo programová editace tohoto souboru se ze shora uvedených důvodů přiliš nedoporučuje. Ke správě se využívá GUI IIS Manageru, programově lze s konfigurací pracovat pomocí WMI a ADSI, což není upřímně řečeno příliš jednoduché, intuitivní ani povznášející.

Z této architektury mimo jiné vyplývá, že některé věci (týkající se specificky .NETu) nastavujete pomocí konfiguračního modelu ASP.NET a **.config* souborů popsaných výše a některé věci (nastavení web serveru jako takového) nastavujete pomocí IIS Manageru a ukládají se v metabázi. Občas se tato nastavení i duplikují - typicky např. reakce na chyby (chybové stránky) a podobně.

## Konfigurace IIS 7.0

[![Konfigurace ASP.NET v IIS 7.0](http://www.aspnet.cz/Files/20070916-20070915-aspconfig-iis7_thumb.png)](http://www.aspnet.cz/Files/20070916-20070915-aspconfig-iis7.png)Nová verze Internet Information Services, IIS 7.0, která je součástí Windows Vista a bude součástí Windows Serveru 2008 přistupuje ke konfiguraci podstatně elegantnějším způsobem. Nepřehledná metabáze je nahrazena stejným systémem hierarchických konfiguračních souborů, jaké známe z .NETu. 

Na vrcholu hierarchie z hlediska IIS stojí soubor *ApplicationHost.config*, který najdeme v adresáři *%SYSTEMROOT%\system32\inetsrv\config*. Má podobnou roli jako machine.config, tedy popisuje výchozí konfiguraci. Zároveň také obsahuje seznam všech webů a virtuálních adresářů, které jsou na daném serveru provozovány.

Další nastavení se poté zapisují do souborů *web.config* na úrovni aplikace nebo adresářů. Nově tak tyto soubory obsahují jak nastavení ASP.NET (typicky v sekci *system.web*) tak nastavení webového serveru, IIS, v sekci *system.webServer*. Koncepčně tato architektura připomíná systém ".htaccess" souborů, známý třeba z Apache.

Poněkud mimo tento model stojí ještě soubor *Administration.config* (nachází se v témže adresáři jako *ApplicationHost.config*). Tento soubor popisuje konfiguraci **administračních nástrojů** IIS, tedy nikoliv serveru jako takového, ale GUI pro jeho správu. Nově lze totiž rozšiřovat i ty a psát konfigurační pluginy i do nich.

Kromě GUI (vylepšeného IIS Manageru) lze konfiguraci provádět i pomocí řádkových příkazů a nově pomocí managed kódu a namespace *System.Web.Administration*. Možnost administrace pomocí WMI/ADSI zůstala zachována, pro zpětnou kompatibilitu a masochisty.

## Shrnutí

Konfigurace .NETových aplikací obecně a ASP.NET zejména je zapisována do XML souborů, které jsou hierarchicky organizovány a jsou rozšiřitelné.

V případě IIS 6.0 a nižších je konfigurace webového serveru ukládána na jiném místě a nastavuje se zcela jiným způsobem, přičemž v případě komplikovanějších aplikací je třeba tyto dva procesy koordinovat, což není triviální a někdy ani možné.

Nová verze IIS 7.0 tyto konfigurační modely slučuje, resp. v ní IIS přebírá tentýž model jako ASP.NET, takže konfigurace bude uváděna v obou případech jednotně.

V následných článcích se podíváme na strukturu konfiguračních souborů a možnosti jejího rozšíření.