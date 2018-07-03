<!-- dcterms:identifier = aspnetcz#42 -->
<!-- dcterms:title = Jak testovat Whidbey a jak to přežít -->
<!-- dcterms:abstract = Nepíšu, protože konám. Chcete konat též? -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Tipy, triky -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2005-07-23T04:12:13.107+02:00 -->
<!-- dcterms:dateAccepted = 2005-07-23T04:12:13.107+02:00 -->

Bystřejší povahy si nepochybně již povšimly toho, že se zde již delší dobu nic neobjevilo. Abych si vypůjčil [slova své drahé polovičky](http://weblog.bestijka.cz/ShowRecord.aspx?day=20030522): <em>Nepíšu, protože konám! </em>Jmenovitě tedy bádám v hlubinách Whidbey a píšu rozličné testovací a ukázkové aplikace - dočkáte se.
 <h2>Bety nejen pro vyvolené</h2> 

Kdo se kolem počítačů a MS technologií motá déle, nepochybně pamatuje doby, kdy vydolovat z Microsoftu betaverzi bylo téměř nemožné. A pokud jste ji už nějakým způsobem získali a třeba v ní objevili nějaký bug, neměli jste moc možností, jak ho sdělit někomu, kdo s ním něco udělá.

Zhruba od příchodu první verze .NETu se situace radikálně změnila a Microsoft se otevřel. Jak informačně, tak pokud se týče beta verzí. Novou verzi .NET Frameworku a souvisejících nástrojů může dneska testovat opravdu kdokoliv. A náznaky z hlubi Microsoftu naznačují, že v této politice hodlá společnost pokračovat.
 <h2>Jak Whidbey získat</h2> 

Nejjednodušším řešením je stáhnout si z webu Microsoftu [Express edici](http://lab.msdn.microsoft.com/express/) vašeho oblíbeného vývojového nástroje. Pro většinu to asi bude [Visual Web Developer Express](http://lab.msdn.microsoft.com/express/vwd/default.aspx). Obnáší to cca. 60 MB downloadu při minimální instalaci. Pokud si nainstalujete i MSDN library a SQL Server Express, bude to asi o 200-300 MB více).

Obrovskou výhodou Express nástrojů je, že budou i v ostré verzi k dispozici zdarma. Express edici radím nepodceňovat. Ubohý J. B. z českého Microsoftu, jsa hodnocen podle prodeje VS.NET, už teď má z Express edice těžkou hlavu ;-) Právem - jedná se totiž o extrémně schopný vývojový nástroj, který se od plnokrevného VS.NET liší jenom v opravdu pokročilých funkcích pro návrh komplexních systémů. Mám nainstalované obojí a obvykle používám jenom VWD, protože je menší a rychlejší.

Pokud by pro vás stahování VWD představovalo příliš velké sousto, CD s ním bylo poslední dobou v několika tištěných časopisech. Předpokládám rovněž, že nebude zásadní problém si jej obstarat na akcích pořádaných Microsoftem.

[![](/files/20050429-betaexperience.jpg)](http://www.microsoft.com/emea/msdn/betaexperience/cscz/)

Pokud vám Express edice nestačí a prahnete po plnokrevníkovi, je postup o něco komplikovanější. Ondyno jsem dostal balíček s kompletní sadou betaverzí všech komponent Whidbey. Pokud dobře počítám, je to sedm DVDček. To se z Internetu stahuje blbě i těm, kdož mohou využívat dobrodiní <em>skutečně</em> širokopásmového připojení.

Download z Internetu je umožněn pouze uživatelům MSDN Subscription. Můžete si nicméně bezplatně přihlásit do programu [Beta Experience](http://www.microsoft.com/emea/msdn/betaexperience/cscz/) (už jsem o něm [psal](/entry/article-20050429.aspx)) a Microsoft vám bude bety posílat na DVD. V mém případě trvalo doručení asi týden - a po tu dobu vás spolehlivě zabaví Express edice :-)
 <h2>Jak se z toho nezbláznit</h2> 

Já mám s beta verzemi zásadní problém: vzhledem k tomu, že se živím prací, nemám moc času na hraní. Beta verzi jsem ochoten používat pouze tehdy, je-li alespoň částečně použitelná pro reálnou práci a neshodí mi můj hlavní počítač, když si ji nainstaluju. Nemám sice problém s tím postavit si nějaký testovací stroj (o virtuálních počítačích nemluvě), ale stejně se nedonutím k tomu ho používat. To je ostatně důvod, proč jsem se ještě nikam neodhodlal nainstalovat žádnou z preview verzí Windows Longhorn, pardon, Vista, jimiž mne Microsoft hojně zásobuje.

Druhá beta VS.NET se v tomto ohledu chová velmi mravně. Neškodí a je prakticky použitelná. Dokonce jsem pod ní napsal i několik prakticky používaných věcí - vbrzku vás s nimi seznámím.Rovněž se stabilitou to není nijak hrozné. Runtime běží spolehlivě. Vývojové prostředí se mi už podařilo poslat k zemi několikrát, ale zatím se vždy zhroutilo distinguovaným způsobem a dovolilo uložit rozdělanou práci.

Moje doporučení ohledně testů Whidbey zní: nehoňte se bezmyšlenkovitě za vyšším číslem buildu. Existují v zásadě tři typy předprodukčních verzí, na které můžete narazit:

*   <strong>Beta (beta 1, beta 2...)</strong> - "beta" verze by měla být poměrně stabilní a neměla by obsahovat žádné zvlášť závažné chyby, které by vám měly znemožnit ji využívat. Nemusí obsahovat všechny plánované funkce. V okamžiku psaní tohoto článku je aktuální <em>Beta 2</em>, a to pro Express i VS.NET. <strong>Technical Preview</strong> - testovací verze vyvržená Microsoftem zpravidla s ohledem na nějakou konanou akci. Označuje se buď názvem akce (jako například slavný <em>PDC Build</em>) nebo názvem měsíce (aktuální je <em>June Community Technical Preview</em> VS.NET, Express ji zatím nemá). Preview verze obsahuje ty cool nové feturky, o nichž povídají v prezentacích, ale bývá podstatně více zablešená, než beta. Z tohoto důvodu jsem se ještě neodhodlal k tomu, abych si tu preview verzi nainstaloval. <strong>Neveřejné bety</strong> - běžný smrtelník se k nim nedostane, alespoň ne standardní cestou. Pomineme-li cestu nelegálmího stažení nějaké pokoutně vynesené verze, dostanete se k nim pouze jako účastník nějakého speciálního programu Microsoftu. Já se například těším této pozornosti co MVP. Jsem nicméně přesvědčen, že to nestojí za tu námahu, pokud onen build neobsahuje opravu nějakého konkrétního bugu, který vás trápí. Vyrvou to ubohým vývojářům zpod pazour a podle toho to vypadá. 

Doporučuji tedy instalovat aktuální betu nebo nanejvýše - máte-li rádi dobrodružství - technical preview.

Aktuální verze se zcela bezproblémově snáší se všemi programy, které používám, včetně VS.NET 2003 a frameworku 1.1. Jednotlivé beta verze se obvykle nemají moc rády mezi sebou. Instalace novější verze se může proměnit v reinstalaci celého počítače. To jsem zažil nedávno, když se mi těch pět různých verzí Frameworku pohádalo tak nehorázným způsobem, že jsem z toho vyvázl jedině formátováním disku. (O pár týdnů později jsem si to zopakoval, když mi v notebooku chcípl disk; opakování - matka moudrosti).
 <h2>Feedback</h2> 

Účelem beta verzí je nejenom ukojit zvědavost zákazníků, ale též získat informace o tom, kterak to chodí či nechodí. Mohu s uspokojením konstatovat, že doby, kdy se zasílání jakéhokoliv feedbacku do Microsoftu podobalo komunikaci s černou dírou, jsou minulostí.

Na adrese [http://lab.msdn.microsoft.com/ProductFeedback/](http://lab.msdn.microsoft.com/ProductFeedback/) jest nalézti jednoduchý leč silný nástroj, pomocí kterého je možno reportovat nalezené chyby či požadovaná vylepšení a sledovat, co se s nimi děje. Podle mých zkušeností je odezva vcelku rychlá. Na příkladu mnou nalezeného bugu v [IntelliSense](http://lab.msdn.microsoft.com/ProductFeedback/viewfeedback.aspx?feedbackid=cd0e87f5-5fa7-487d-8d91-850a363dc15a) je vidět, že moje chyba byla reprodukována a potvrzena během 24 hodin a pracuje se na řešení.

I tento nástroj se Microsoftu osvědčil a je tedy pravděpodobné, že bude k dispozici i pro další produkty.