<!-- dcterms:identifier = aspnetcz#102 -->
<!-- dcterms:title = Webový vývoj trochu jinak - WAP a WDP -->
<!-- dcterms:abstract = Pokud vám zcela nevyhovuje mírně chaotický způsob, jakým Visual Studio 2005 zachází s webovými projekty, mohou se vám hodit dva pluginy od Microsoftu: Web Application Projects (WAP) a Web Deployment Projects (WDP). -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Tipy, triky -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2006-07-03T01:14:33.133+02:00 -->
<!-- dcterms:dateAccepted = 2006-07-03T01:14:33.133+02:00 -->

V jedničkové verzi ASP.NET byl vývoj webových aplikací sice zcela jiný než v ASP 3.0, ale zároveň celkem snadno pochopitelný: veškerý back-endový kód se zkompiloval do jedné dynamické knihovny a předmětné DLLko se nakopírovalo na web server, spolu s ASPX soubory, které obsahovaly HTML kód a definice server controls.

V případě ASP.NET 2.0 je situace poněkud složitější. Standardně máte na výběr ze třech možností:

 **XCopy Deployment** - na server nahráváte kompletní zdrojový kód (ASPX i VB/CS soubory, tak jak je píšete). ASP.NET runtime si je při prvním požadavku zkompiluje a drží si je zkompilované v cache, dokud se aplikace nerestartuje, nebo dokud se zdrojové soubory nezmění. Tento postup se nejčastěji využívá při vývoji (v tomto režimu běží aplikace ve vývojovém serveru který je součástí VS/VWD 2005). Toto je také jediný model, který můžete nativně použít, pokud nemáte VS 2005, ale jenom Visual Web Developer Express.

 **Publishing - site updateable.** Pokud z menu ve Visual Studiu zvolíte *Publish Web Site* a zaškrtnete *allow this site to be updateable*, provede se v podstatě to, co je popsáno o odstavec výše, ale najednou. Na server pak naráváte hromádku DLLek (zjednodušeně řečeno: pro každou stránku jedno) a ASPX souborů. Tento model se v zásadě podobá chování z verze 1.x, pouze výsledkem není jedna knihovna, ale celé jejich stádečko.

Při běhu aplikace pak dojde ke zvláštnímu stavu, kdy je část kódu (to, co jste napsali vy) k dispozici ve zkompilované podobě. Druhá část (reprezentace serverových ovládacích prvků) se pak generuje dynamicky podle ASPX souboru. To je důvod, proč je v definici backendových tgříd pro stránky uvedeno klíčové slovo *partial class* - třída je rozdělená, půlka se generuje dynamicky za běhu, druhá je už zkompilovaná.

 **Publishing - not updateable.** Pokud ve stejném dialogu zrušíte zaškrtnutí pole *allow this site to be updateable*, situace se razantně změní. Celá aplikace, včetně HTML kódu se zkompiluje do dynamických knihoven. Výsledkem publikace jsou sice i ASPX soubory, ale jsou prázdné. Z hlediska .NET Frameworku nemají význam a můžete je smazat (mohou ale, při určitém nastavení, mít význam pro Internet Information Services).

## Web Application Projects

Pokud vám výše popsané chování nevyhovuje, případně se vám nelíbí, že VS 2005 přisupuje k webovým projektům stylem "co projekt, to adresář" a zahrne do projektu vše, co v dané složce vidí, připravil pro vás Microsoft **[**Web Application Projects (WAP)**](http://msdn.microsoft.com/asp.net/reference/infrastructure/wap/)**. To je doplněk do VS 2005, který vám umožní vyvíjet i v nové verzi projekty "postaru". Součástí projektu bude jen to, co do něj explicitně zahrnete a výsledkem bude jedna DLL knihovna.

WAP můžete ocenit též v případě, že chcete snadno zmigrovat webovou aplikaci napsanou v .NET 1.x pod aktuální verzi 2.0. Pokud se tímto typem projektů chcete obšírněji zabývat, doporučuji vám prostudovat si [stránku s příklady a tutoriály](http://webproject.scottgu.com/), kterou provozuje můj oblíbenec Scott Guthrie.

## Web Deployment Projects

Pokud vám nový přístup k webovým projektům vyhovuje, ale chtěli byste mít větší kontrolu nad procesem nasazení aplikací, neměl by vaší pozornosti uniknout jiný doplněk: **[**Web Deployment Projects (WDP)**](http://msdn.microsoft.com/asp.net/reference/infrastructure/wdp/)**. Tento nástroj vám umožní podrobně nastavovat, v jaké podobě se bude vyskytovat zkompilovaný kód. Můžete vygenerovat jednu DLL pro celou aplikaci, pro každou stránku, podle adresářů... Jedná se v zásadě o schopnější náhradu výše zmiňované funkce *publish web site*.

Pro pořádek jenom připomínám, že všechny zde popsané nástroje se instalují pouze na vývojovou stanici, kde je Visual Studio. Na serveru pro WAP nebo WDP žádnou speciální podporu nepotřebujete,