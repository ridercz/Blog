<!-- dcterms:identifier = riderweblog#102 -->
<!-- dcterms:title = Vot éto těchnika! -->
<!-- np9:categoryId = 2 -->
<!-- x4w:category = Lidé a jiná zvěř -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2003-11-16T06:41:38+01:00 -->
<!-- dcterms:dateAccepted = 2003-11-16T06:41:38+01:00 -->

Nikdy jsem neměl s (vlastní) výpočetní technikou zásadnější problémy. Přičítal jsem to následujícím faktorům:

*   **Kupuji kvalitní hardware** (nejsem tak bohatý, abych si mohl dovolit kupovat levné věci).
*   **Netrvám na absolutní technické špičce** (protože je předražená a nevyzkoušená).
*   **Používám příčetný operační systém** (NT-based, militantní linuxáře prosím aby odešli do křoví a tiše chcípli)
*   **Neinstaluju na počítač kraviny** (jakožto například různé obskurní screensavery a jiné blbinky)
*   **Udržuji svůj systém v aktuálním stavu** (protože v každém systému jsou chyby, které je nutno opravovat)

Dokonce ani s oněmi vysmívanými Windows jsem nikdy neměl problémy. Možná je to tím, že s Windows 95 jsem koketoval jenom několik týdnů, než jsem objevil existenci Windows NT Workstation 4.0 a od té doby jedu tvrdě po NT linii. 

Léta provozování web serverů na platformě NT4 byla drsná. Ten systém byl nedospělý, poslepovaný a nevhodný pro vysokou zátěž. S odstupem času mohu říci, že nebýt mých masochistických sklonů a dvou let strávených na [Fakultě informatiky Masarykovy univerzity](http://www.fi.muni.cz/) (jejíž šílené osazenstvo ve mne vypěstovalo nevyléčitelnou idiosynkarzii k tučňákům), stal by se ze mne zatvrzelý linuxář.

S příchodem systému Windows 2000 se karta obrátila - stará NTčka porážel rozdílem třídy a zátěž bezmála dvou miliónů hitů denně snášel na průměrném hardware hrdinně. Windows 2003 dovádějí systém ještě dál a platforma .NET nemá světovou konkurenci.

Ale začal mne zrazovat hardware.

Začalo to nenápadně: v SQL serveru LUPUS odešel jeden harddisk. Žádný problém, od toho tam je hardwarový mirroring, že ano. Ovšem proč je onen RAID řadič tak stupidní, že po chybě při restartu člověk musí fyzicky odklepnout, že má systém opravdu naběhnout i bez disku, to nechápu.

A pak už to šlo ráz na ráz: značkový počítač Fujitsu Siemens, který prostě nezvládne více než tři IDE zařízení najednou. Podivná RAMka, která v jedné desce chodí a ve druhé nikoliv. Vadná (nová) základní deska osvědčeného výrobce. Síťovka poškozující přenesená data, aniž by zareagoval kterýkoliv z několika kontrolních mechanismů. Když dám do serveru RAID řadič a dva disky, neodejdou ony mirrorované disky, ale záhadně se ztratí data přímo v řadiči (nebo co... prostě mi najednou na mirrorovaném disku zmizela všechna data).

Za poslední tři měsíce mi selhalo víc hardwaru (převážně nového), než za posledních pět let. Plíživě se vytrácí moje důvěra v techniku, což mne děsí, protože lidem nedůvěřuju odjakživa a moc dalšího už toho nezbývá.

Do tohoto okamžiku jsem si mohl být v zásadě jistý, že mé servery budou běžet stabilně, protože se o ně dobře starám. Možnost selhání hardware a následného výpadku zde samozřejmě byla vždy, ale nijak pravděpodobná. Mohl jsem to v zásadě zaručit i svým zákazníkům, protože hlavní břímě leželo na mně. Teď mám takový divný pocit, že používám něco, o čem nikdo neví jak vlastně funguje a že nemám možnost příliš ovlivnit, co dělám. A bojím se na dálku restartovat server, protože se bojím, že nenajede.

Čím to asi je?

Možná je to tím, že se produkce počítačových komponent stala natolik masovou, že se prostě vyrábí věší procento zmetků, a to i u osvědčených značek.

Možná je to tím, že Zemi prý zasáhly nejsilnější elektromagnetické bouře, které kdy byly vůbec zaznamenány.

Možná je to tím, že dnešní počítače jsou tak složité, že je v zásadě navrhují *jiné počítače*, a tudíž *žádný člověk* stoprocentně neví, jak funguje. Taková člověkem asistovaná reprodukce - sice počítače vyrábíme, ale jejich vývoj už plně nekontrolujeme.