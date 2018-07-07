<!-- dcterms:identifier = aspnetcz#378 -->
<!-- dcterms:title = Windows 8 po měsíci -->
<!-- dcterms:abstract = Už je tomu zhruba měsíc, co jsem si nainstaloval Windows 8 Consumer Preview. Své první dojmy jsem popsal v předchozím článku, v jeho pokračování se pokusím zamyslet podrobněji nad konkrétními věcmi, se kterými jsem se potkal. -->
<!-- np9:categoryId = 7 -->
<!-- x4w:category = Software -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2012-03-28T20:34:32.8+02:00 -->
<!-- dcterms:dateAccepted = 2012-03-28T20:30:00+02:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20120328-windows-8-po-mesici.png -->

Už je tomu zhruba měsíc, co jsem si nainstaloval Windows 8 Consumer Preview. Své první dojmy jsem popsal v [předchozím článku](http://www.aspnet.cz/articles/371-windows-8-visual-studio-11-prvni-dojmy), v jeho pokračování se pokusím zamyslet podrobněji nad konkrétními věcmi, se kterými jsem se potkal. Stále se nejedná o nějaký kompletní review, ten systém normálně používám pro každodenní práci, nehledám  plánovaně, co je v něm nového.

## Ďábelsky rychlý start

Windows 8 startují ďábelsky rychle. Od začátku bootu po začátek práce (včetně přihlášení) jim to v mém případě trvá 18 sekund. Uznávám, že mám jako systémový disk SSD, ovšem obecně je můj hardware dost obstarožní. A vzhledem k tomu, že už dnes jsou pro použití jako systémový disk [SSD levnější než plotnové disky](http://diit.cz/clanek/ssd-je-levnejsi-nez-hdd), v době uvedení Windows 8 na trh se bude myslím jednat o běžný standard nebo mírný nadstandard.

Restartů si užívám trochu více, než svůj obvyklý jeden za měsíc při aktualizacích, protože s Windows 8 se bohužel nedokáže můj notebook vyrovnat se změnou drátové síťové karty v docking station ve chvíli, kdy ho přendám z jedné do druhé (mám dvě, jednu doma a jednu v práci). Přisuzuju do ovladačům.

## Jednoduché mountování VHD a ISO

Virtuální harddisky (VHD) se používají pro virtuální počítače a pro zálohování. Připojit je jako další disk umí už Windows 7, ale musí se to dělat složitě přes disk manager. Windows 8 je umí připojit pohodlněji, stačí na soubor poklepat. Když chcete disk odpojit, stačí na něj klepnout pravým tlačítkem a zvolit "Eject", jako by se jednalo o výměnnou jednotku.

Naprosto stejným způsobem lze připojovat i ISO images, jako virtuální CD/DVD. Vypalovat image Windows umí už od předchozí verze, k dokonalému štěstí mi v tomto ohledu ve Windows chybí jenom nástroj pro vytváření ISO images. Nicméně to bych zase přišel o vtipné hlášky, které při startu hází [ImgBurn](http://www.imgburn.com/), který pro tento účel používám dosud.

## Hyper-V i na klientovi

64-bitové edice Windows 8 budou obsahovat plnokrevný virtualizační systém Hyper-V, stejný jaký obsahuje serverová verze. V současné době sice virtualizaci na klientských Windows páchat lze, ale všechna mně známá řešení jsou špatná:

*   **[Windows Virtual PC](http://www.microsoft.com/windows/virtual-pc/default.aspx)**, jediné oficiálně podporované řešení od Microsoftu, funguje sice docela dobře, ale umí emulovat jenom 32-bitové operační systémy. To znamená, že servery (které jsou už jenom 64-bitové) virtualizovat nemůžete, třeba pro účely testování. 
*   [**VirtualBox**](https://www.virtualbox.org/) tohle sice umí, ale jeho uživatelské rozhraní je velmi svérázné, stejně jako přístup k souborům virtuálních disků. Momentálně ho používám, jako nejmenší zlo, ale rozhodně nebudu želet, až se ho budu moci zbavit. 
*   [**VMWare Workstation**](http://www.vmware.com/products/workstation/overview.html) se mi nikdy nepodařilo dlouhodobě provozovat spolehlivě a bez problémů. Vždycky mi nějak záhadně vytrotlily síťové karty nebo něco podobného. Navíc je nutné za něj platit, jde o komerční SW, zatímco výše zmíněné alternativy jsou zdarma. V zájmu objektivity nutno dodat, že existuje i bezplatný VMWare Player, ten lze ale použít jenom k provozu existujících virtuálů, ne vytváření nových.  

Výhodou Hyper-V je, že se totéž používá pro serverovou virtualizaci jako pro klientskou. Testovací a vývojové servery tedy budou moci být kompatibilní.

Hyper-V ve Windows 8 ale bude vyžadovat procesor s funkcí Second Level Address Translation (SLAT), tedy nové procesory Intel i3, i5 a i7. Protože mne po letech opustil můj starý ThinkPad R61, koupil jsem si ThinkPad T420 a Hyper-V vyzkoušel. Funguje stejně jako ten serverový, což s sebou nese i vlastnosti nešťastné pro klientské použití, zejména v oblasti síťování (hodně mi chybí NAT, který je vestavěný ve VirtualBoxu). Připojení přes VM connection je dost nekomfortní, kvůli absenci sdílení schránky a podobně. 

Zatím tedy s mohutným frfláním zůstávám u VirtualBoxu, než vymyslím, jak si připravit nějaké dostatečně robustní "virtual lab" řešení, které by mi fungovalo na notebooku.

## [![Podpora pro mobile broadband](https://www.cdn.altairis.cz/Blog/2012/20120328-broadband_thumb.png "Podpora pro mobile broadband")](https://www.cdn.altairis.cz/Blog/2012/20120328-broadband_2.png)Podpora pro Mobile Broadband

*Poznámka: podle reakce v komentářích potvrzené rychlým googlováním je popisovaná funkcionalita dostupná už ve Windows 7, akorát se s ní zjevně nikdy nepotkal můj hardware.*

Windows 8 mají vestavěnou podporu pro připojení přes mobilní sítě. Pokud máte v počítači kompatibilní 3G modem, můžete s mobilní sítí pracovat stejným způsobem, jako s Wi-Fi. Lze ho také nastavit jako záložní spojení, které se automaticky zapne, když není k dispozici nic jiného.

Je to podobná funkcionalita, jakou nabízí třeba Lenovo v rámci svého software ThinkVantage Access Connections (který se mi mimhochodem na Windows 8 spolehlivě rozchodit nepodařilo), ale vestavěná přímo v systému.

Mimochodem: zarazil mne propastný rozdíl chováním vestavěného profesionálního 3G modulu (Ericsson F5521gw) a takových těch USB neřádů, co operátoři rozdávají prakticky zadarmo k internetovým tarifům. Mini PCI-E modul v kombinaci s vestavěnou anténou nabízí mnohem kvalitnější signál a vyrovnává se s jeho kolísáním nebo občasnou absencí mnohem lépe, než USB modem, potažmo obskurní software s nimi dodávaný. 

Jezdím často vlakem trasu Praha – Brno a používat za jízdy USB modem bylo utrpení, protože vlivem mizerného pokrytí železničních tratí spojení neustále padalo a časem modem zblbl natolik, že ho bylo nutné hardwarově odstranit a znovu přidat. Interní modul sice spojení občas ztratil také, ale méně často a bez jakýchkoliv problémů ho zase rychle navázal.

[![metered](https://www.cdn.altairis.cz/Blog/2012/20120328-metered_thumb.png "metered")](https://www.cdn.altairis.cz/Blog/2012/20120328-metered_2.png)

Windows 8 počítají i s tím, že připojení bude datově limitováno ("metered connection") a ve výchozím nastavení nebudou při takovém připojení stahovat aktualizace. Veškerá "rádia" (WiFi, Bluetoohh, 3G) se pak zapínají a vypínají na jedno místě, včetně existence "airplane mode", které vypne všechno najednou.

## To nešťastné Metro

Nové grafické rozhraní budí emoce a spousta lidí s ním má nějaký zásadní problém. Zkusím popsat své zkušenosti s ním po měsíci používání. Předesílám, že jsem spokojeným uživatelem Windows Phone, takže toto rozhraní pro mne není dramaticky nové a že se mi vizuálně velmi líbí, což také nutně není pravidlem.

Metro pokládám za geniální zařízení pro tablety a mobilní telefony, případně ještě pro nějaké speciální zařízení typu Surface nebo prostě velká dotyková obrazovka na zdi. U desktopu a notebooku ho nepokládám za příliš šťastné, protože myší a klávesnicí se neovládá právě nejlépe (resp. mám-li k dispozici myš a klávesnici, jsou efektivnější postupy).

[![Microsoft Device Center - kříženec Metro a desktopu](https://www.cdn.altairis.cz/Blog/2012/20120328-device_center_thumb.png "Microsoft Device Center - kříženec Metro a desktopu")](https://www.cdn.altairis.cz/Blog/2012/20120328-device_center_2.png)

Pro desktopové aplikace se mi víc líbí rozhraní na způsob Zune nebo nového Microsoft Device Center, jakýsi kříženec obou přístupů. Nemyslím si, že na běžných počítačích se Metro aplikace příliš uchytí, ale to ukáže čas. Pokud chcete Windows 8 používat na běžném počítači jako nástupce Windows 7, setkáte se s Metrem prakticky pouze ve dvou případech: ve Start screen a u některých nastavení.

[![Start Screen ve Windows 8](https://www.cdn.altairis.cz/Blog/2012/20120328-start_thumb.png "Start Screen ve Windows 8")](https://www.cdn.altairis.cz/Blog/2012/20120328-start_2.png)

Start screen nahrazuje Start menu a o svém přístupu k ní jsem psal již v [úvodním článku](http://www.aspnet.cz/articles/371-windows-8-visual-studio-11-prvni-dojmy). V podstatě se nijak nezměnil, beru Start screen jako další "plochu" pro aplikace spouštěné dostatečně často nato, abych je nechtěl vyhledávat a ne tak často, abych je připínal na taskbar. 

[![settings](https://www.cdn.altairis.cz/Blog/2012/20120328-settings_thumb_1.png "settings")](https://www.cdn.altairis.cz/Blog/2012/20120328-settings_4.png)

Druhé místo, kde se s Metrem setkáte i když nechcete, jsou nastavení "PC settings", což je jakási Metro obdoba ovládacích panelů. Některá nastavení (většinou ta "nová", ale třeba i připojení Bluetooth zařízení) najdete jenom zde, některá jenom v klasických ovládacích panelech, velmi málo jich je zdvojených. Předpokládám, že tohle se nějak časem ustálí a vyřeší. Naštěstí vyhledávání funguje napříč vším, takže netřeba řešit příliš urputně.

[![winp](https://www.cdn.altairis.cz/Blog/2012/20120328-winp_thumb.png "winp")](https://www.cdn.altairis.cz/Blog/2012/20120328-winp_2.png)

Jinak se s Metro rozhraním setkáte jenom u pár sidebar panelů, které vám v excitovaných okamžicích vylezou při pravé straně obrazovky. Třeba po klepnutí na ikonku sítí uvidíte panel se seznamem dostupných připojení, jak bylo ukázáno dříve, nebo po stisku Win+P se objeví možnost připojení projektoru či externího monitoru v nové podobě. Ve verzi Consumer Preview se tak nechová důsledně vše, třeba nastavení hlasitosti nebo režimu napájení je stále "postaru", ale to je předpokládám úkaz rázu dočasného.

## BitLocker

Používám šifrování disků BitLocker na systémovém, datovém i externích discích. BitLocker se objevil už ve Windows Vista, ve Windows 7 byl výrazně vylepšen a dalších vylepšení se dočkal ve Windows 8. To nejlepší je, že při zapnutí šifrování na disku není nutné šifrovat celý disk, ale jenom tu část, na které jsou stávající data, tj. nešifruje se "prázdná" část. To je užitečné ve chvíli, kdy máte nový disk, na který chcete ukládat šifrovaná data, protože vám to ušetří hodiny práce.

Snažil jsem se udělat nějaký výkonový test BitLockeru, porovnat rychlost přístupu při nezašifrovaném a při šifrovaném disku. Výsledky mi ovšem přijdou podivné, protože po zapnutí BitLockeru se podle nich přístup k disku zrychlil, jak na plotnovém disku tak na SSD. Můj nový procesor sice má hardwarovou akceleraci AES, ale že by měla fungovat až takhle, tomu moc nevěřím, takže předpokládám nějakou chybu v metodice.

*To je pro dnešek všechno, časem možná vydám další pokračování :).*