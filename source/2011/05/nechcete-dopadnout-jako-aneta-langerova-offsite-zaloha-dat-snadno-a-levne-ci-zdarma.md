<!-- dcterms:identifier = riderweblog#257 -->
<!-- dcterms:title = Nechcete dopadnout jako Aneta Langerová? Offsite záloha dat snadno a levně či zdarma -->
<!-- dcterms:abstract = Zálohovat data, třeba vypalováním na DVD nebo kopírování na druhý disk, nemusí vždycky stačit. Pokud vás vykradou a nebo dojde třeba k požáru, přijdete i o ně. Přesvědčila se o tom teď třeba Aneta Langerová. Řešením je používat takzvané offsite zálohy. A účelem tohoto článku je přesvědčit vás, že to není věc jenom pro velské firmy, ale i pro běžné smrtelníky, nepočítačové mágy. -->
<!-- np9:categoryId = 2 -->
<!-- x4w:category = Lidé a jiná zvěř -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2011-05-14T22:49:35.907+02:00 -->
<!-- dcterms:date = 2011-05-14T22:49:37.42+02:00 -->

Zálohovat data, třeba vypalováním na DVD nebo kopírování na druhý disk, nemusí vždycky stačit. Pokud vás vykradou a nebo dojde třeba k požáru, přijdete i o ně. Přesvědčila se o tom teď třeba Aneta Langerová:

> Nějaký dobrák mi vykradl byt. Vzal s sebou vše, co pro mě mělo velkou hodnotu - veškerá má data - práci na nových věcech, podklady na koncertní hraní a celý archiv všeho, co jsem kdy udělala. Může se stát, že budu mít štěstí a alespoň malou část toho všeho získám díky někomu z vás zpět, je to sedm let života zaznamenaných na několika hard discích a v počítačích a moc mi na tom záleží. ([www](http://www.langerovaaneta.cz/blog/pomooooc/))

Řešením je používat takzvané offsite zálohy, tedy zálohy, které se ukládají na geograficky oddělené místo, než na kterém se nacházejí původní počítače. Toto řešení se běžně používá ve velkých firmách jako součást disaster recovery plánů, ale je dostupné i pro běžné uživatele. Oproti populárním představám je též velice levné, a za určitých okolností zcela zdarma.

Tento článek popisuje dvě možná řešení, která můžete používat samostatně a nebo ve vzájemné kombinaci. Nejedná se o jediná řešení, ale tahle dvě dlouhodobě používám ke své plné spokojenosti. Jejich výhodou je, že se o ně nemusíte starat. Jednou je nastavíte a pak běží automaticky. 

## Windows Live Mesh

Prvním užitečným nástrojem (a službou) je Windows Live Mesh. Jedná se o službu od Microsoftu, která je součástí balíčku [Windows Live Essentials](http://download.live.com/). Mesh slouží především k sychronizaci dat mezi několika počítači, třeba mezi stolním a notebookem. To samo může sloužit jako forma zálohy. 

Kromě toho ale nabízí zdarma i 5 GB místa na serverech Microsoftu (jmenuje se to "Synchronizované úložiště SkyDrive"). Takže i když máte jenom jeden počítač, může vám Mesh se zálohou pomoci. Myslím si, že na opravdu důležitá data pět giga velké části uživatelů postačí. Těch 5 GB je bohužel konečná, nemůžete si připlatit za víc prostoru.

Mezi počítači můžete synchronizovat neomezené množství dat. Mesh je natolik inteligentní, že pokud může, používá rychlou lokální síť a teprve pokud ne, kopíruje data přes Internet. Používá přitom servery Microsoftu jako prostředníky, takže nemusíte mít žádné zvláštní nastavení sítě a podobně. Při vytváření offsite backupu lze postupovat tak, že nejprve oba počítače dáte na jedno místo a prvotní synchronizaci provedete po lokální síti. Pak jeden počítač odvezete a následná sychronizace poběží přes Internet.

Mesh (resp. Windows Live Essentials, kterých je Mesh součástí) si můžete zdarma stáhnout na [http://download.live.com](http://download.live.com), a to i v češtině. Po instalaci si jenom zvolíte složky, které chcete synchronizovat a s čím. Mesh toho umí mnohem více, můžete data sdílet a synchronizovat mezi více uživateli a podobně, ale to je nad rámec tohoto článku.

Nevýhodou je, že Mesh nefunguje na Windows XP, musíte mít Windows Vista nebo novější. Na Windows XP funguje jenom starší verze Essentials, ve které ale Mesh ještě nebyl.

Výhodou je jednoduchost, pochopitelnost i pro běžné uživatele a pro někoho též česká lokalizace. Jako bonus můžete brát, že těch 5 GB dat synchronizovaných se SkyDrive budete mít dostupných také odkudkoliv přes Internet, pomocí webového prohlížeče, na [http://skydrive.live.com](http://skydrive.live.com). 

## CrashPlan

[CrashPlan](http://www.crashplan.com/) je online služba, která slouží vyloženě k zálohování, a to hned několika způsoby. Data můžete samozřejmě zálohovat na jiný disk (což vám ale ne vždy pomůže, jak jsme si již řekli). Další možnost je, že data můžete zálohovat na počítač jiného uživatele služby CrashPlan, pokud se s ním domluvíte – můžete se třeba dohodnout se známým a zálohovat si data navzájem.

Pro tento článek je ale nejpodstatnější služba online storage, tedy záloha na prostor na serverech společnosti CrashPlan. Jedná se o službu placenou, ale velmi levnou. Pokud vám stačí 10 GB úložiště, zaplatíte 2 USD měsíčně (tj. asi 34 Kč, podle aktuálního kurzu). Za neomezené úložiště pro zálohu jednoho počítače zaplatíte dvojnásobek, přičemž pokud si službu předplatíte na delší období, ceny mohou ještě výrazně klesnout (na $ 1.50, resp. $ 3 měsíčně). K dispozici jsou ještě [další nabídky](http://www.crashplan.com/consumer/compare.html).

Instalace je podobná Meshi, tj. stáhnete si klienta a nastavíte, co a kam chcete zálohovat. CrashPlan má klienta nejenom pro Windows (včetně starších Windows XP), ale i pro Mac, Linux a Solaris. Je na konfiguraci drobet složitější než Mesh (a není přeložen do češtiny, pokud je mi známo), ale zase je vhodný pro paranoidnější povahy, protože vám umožní data zašifrovat vaším vlastním klíčem, než jsou zaslána na servery provozovatele, tj. ani provozovatel služby nemá přístup k vašim datům.

Další výhodou je, že můžete být (volitelně) informováni i průběhu záloh. Pokud z nějakého důvodu záloha neproběhne, CrashPlan vám začne posílat upozorňovací e-maily. CrashPlan také umí archivovat několik verzí smazaných nebo změněných souborů, takže vám může pomoci třeba v případě, že si soubor omylem smažete.

## Offsite backup obecně a moje řešení

Prvotní vytvoření offline zálohy může trvat velmi dlouho, řádově i několik týdnů. Záleží na rychlosti vašeho připojení a objemu zálohovaných dat. Další zálohy se pak dělají inkrementálně, tedy kopírují se jenom změny, což je obvykle rychlé.

Já osobně obě zmiňované možnosti kombinuji. Žiju napůl v Praze a napůl v Brně, můj hlavní počítač je notebook. Pomocí Windows Live Meshe synchronizuji data na jeden počítač, který stojí v Praze. Tenhle počítač slouží i jako archiv, má několik velkých disků, na které nahrávám věci, které sice běžně nepoužívám, ale chci je mít někde uložené (třeba archiv originálů všech svých fotografií). Celý tento počítač se pak zálohuje na CrashPlan. Ta nejdůležitější data se ještě pomocí Live Meshe synchronizují na SkyDrive.

Všechna moje data se tedy vyskytují nejméně ve třech exemplářích: na notebooku, na pražském serveru a na serveru CrashPlan. Ta nejdůležitější jsou ještě navíc na SkyDrive. Do budoucna plánuju dát další zálohovací server do Brna, jako kopii toho pražského, ale ještě jsem to po stěhování nestihl.

Popisované metody jsou jednoduché a podle mého názoru dostupné i pro běžné uživatele, nevyžadují žádné náročné znalosti a vybavení. Za určitých okolností jsou dostupné i zdarma, ale myslím si, že i cena placených služeb je natolik nízká, že si ji může dovolit každý.