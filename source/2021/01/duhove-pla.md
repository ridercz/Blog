<!-- dcterms:title = 3D tisk ve všech barvách: duhový filament od značky C-Tech -->
<!-- dcterms:abstract = Ten efekt zná každý majitel FDM 3D tiskárny. Když se mění barva filamentu, je nutné extruder vyčistit a teče z něj plast, který postupně mění barvu. Totéž se děje i při výrobě filamentů, když výrobní linka přechází z jedné barvy na druhou. Výsledkem jsou dvoubarevné cívky filamentu, kde jedna barva pomalu přechází v druhou. Značka C-Tech nabízí podobný "duhový" filament jako oficiální výrobek. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:coverUrl = /cover-pictures/20210108-duhove-pla.jpg -->
<!-- x4w:pictureUrl = /perex-pictures/20210108-duhove-pla.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = 3D tisk -->
<!-- x4w:category = Recenze -->
<!-- dcterms:date = 2021-01-08 -->

Ten efekt zná každý majitel FDM 3D tiskárny. Když se mění barva filamentu, je nutné extruder vyčistit a teče z něj plast, který postupně mění barvu. Totéž se děje i při výrobě filamentů, když výrobní linka přechází z jedné barvy na druhou. Výsledkem jsou dvoubarevné cívky filamentu, kde jedna barva pomalu přechází v druhou - říká se jim "přeběhové cívky" a jsou občas k mání v eshopech pro fajnšmekry. Značka C-Tech ale nabízí podobný "duhový" filament jako oficiální výrobek. Společnost [TonerPartner](https://www.tonerpartner.cz/), která filamenty C-Tech u nás prodává, mi nabídla jednu cívku k otestování.

Pokud se týče obecných tiskových vlastností filamentu, tak není o čem psát. Je to standardní PLA od C-techu, což je běžná konzumní značka. Tisknu na standardní Průša i3 MK3S, používám PrusaSlicer s výchozí profil "Generic PLA" (210/60 °C), žádná magie. Po mechanické stránce byl tisk zcela bezproblémový. Jediná změna je v barvě.

Barva standardní kilové cívky se plynule mění, od červené přes oranžovou, žlutou, zelenou až po modrou v různých odstínech. Stejně tak se bude plynule měnit barva vašeho výtisku. Celý efekt působí docela zajímavě, ale musíte ho umět využít.

V první řadě je změna barvy dosti pozvolná. Což znamená, že aby byla na výtisku patrná, musí být výrobek dosti velký a spotřebovat dost filamentu. Rozhodně nepočítejte s tím, že budete mít jeden výtisk ve všech barvách duhy, to byste na něm museli protisknout celou kilovou cívku. I u poměrně velkých výtisků je změna pozvolná.

![](https://www.cdn.altairis.cz/Blog/2021/20210108-duhove-pla.jpg)

Typickým příkladem je tento [zásobník na tavné lepidlo](https://www.thingiverse.com/thing:2950646). Spotřebuje podle výpočtů PrusaSliceru 45 metrů filamentu o váze 134 gramů a jeho tisk trvá téměř jedenáct hodin. Přesto je změna barvy - ze zelené do brčálově modrozelené - velmi plynulá a decentní.

![](/cover-pictures/20210108-duhove-pla.jpg)

Mnohem více je změna vidět, pokud tisknete více stejných předmětů. Pro kamarádku jsem tiskl tento [dashboard](https://www.thingiverse.com/thing:3024359) pro deskovou hru Gloomhaven, což je zhruba podobně velký výtisk (51 m a 152 g filamentu, doba tisku 9:40 h). Na třech postupně tištěných kopiích je změna barvy vidět docela hezky. Na výtisku je vidět také to, že barva filamentu se (logicky) nemění zcela plynule, ale po změně následuje vždy delší sekce jedné stálé barvy.

Na specifické vlastnosti filamentu je nutné myslet i při organizaci tisku a správné orientaci výtisků. Pokud byste chtěli vytisknout třeba krabičku s víčkem (např. [tento můj model na hrací kostky](https://www.thingiverse.com/thing:3836868)), je téměř nemožné dosáhnout plynulého barevného přechodu napříč celým výrobkem. Pokud budete základnu a víko tisknout současně, bude po sestavení barevný přechod (zde mezi červenou a modrou, černá linie představuje místo setkání víka a základny při stejné šířce obou) vypadat takto:

<p style="margin:1ex auto;width:500px;color:#fff; text-align:center;line-height:250%;background: linear-gradient(90deg, #c00 0, #00c 250px, #000 251px, #00c 252px, #c00)">červená - modrá - červená</p>

To sice nevypadá špatně, ale možná to není to, co jste zamýšleli. Pokud budete díly tisknout běžným způsobem za sebou (tj. plochou stranou k tiskové podložce), bude po sestavení výsledek mnohem divnější:

<p style="margin:1ex auto;width:500px;color:#fff; text-align:center;line-height:250%;background: linear-gradient(90deg, #c00 0, #606 250px, #000 251px, #00c 252px, #606)">červená - fialová | modrá - fialová</p>

Pokud byste chtěli dosáhnout efektu jako na posledním schématu, museli byste nejdřív vytisknout základnu a pak víko, ovšem víko ve "správné" orientaci, tedy plochou stranou nahoru:

<p style="margin:1ex auto;width:500px;color:#fff; text-align:center;line-height:250%;background: linear-gradient(90deg, #c00 0, #606 250px, #000 251px, #606 252px, #00c)">červená - modrá</p>

Takový tisk by si vyžádal použití podpor a u složitějších modelů poskládaných z více dílů by plynulé přechody vůbec nebyly možné.

Nad výsledkem máte celkově jenom minimální kontrolu. Pokud byste chtěli nějaký _konkrétní_ barevný přechod, touto technologií ho vyrobit nelze. Výtisky z duhového filamentu jsou vizuálně rozhodně zajímavé. I když změna barvy není příliš markantní výsledek je netradiční, protože dosáhnete odstínů, které filamenty běžně nemívají.

Je ovšem otázkou, zda to stojí za téměř dvojnásobnou cenu. Zatímco běžný PLA C-Tech vychází na [eshopu TonerPartner](https://www.tonerpartner.cz/) na 458 Kč včetně DPH, duhové provedení vyjde na 808 Kč za kilové balení.