<!-- dcterms:identifier = aspnetcz#234 -->
<!-- dcterms:title = Stavové HTTP: Shrnutí a dokončení -->
<!-- dcterms:abstract = Při přípravě článku, který se podrobně zabývá technologií ViewState sjem zjistil, že vám již více než rok dlužím jeden díl seriálu o (bez)stavovém HTTP. Ba dokonce možná díl nejdůležitější, totiž poslední, shrnující a hodnotící. Nuže, tady je. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Programování -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- np9:serialId = 4 -->
<!-- x4w:serial = Stavové HTTP -->
<!-- dcterms:created = 2009-06-23T00:01:08.363+02:00 -->
<!-- dcterms:dateAccepted = 2009-06-23T00:01:08.363+02:00 -->

Při přípravě článku, který se podrobně zabývá technologií ViewState sjem zjistil, že vám již více než rok dlužím jeden díl seriálu o (bez)stavovém HTTP. Ba dokonce možná díl nejdůležitější, totiž poslední, shrnující a hodnotící. Nuže, tady je. Odkazy na předchozí díly seriálu najdete v boxu v pravé části stránky.

V [úvodu](http://www.aspnet.cz/Articles/190-stavove-http-jak-funguji-cookies-session-a-viewstate-a-proc-je-nepouzivat.aspx) jsem vysvětlil, že HTTP je protokol bezstavový, tedy že neumí udržovat žádný kontext a spojit si několik po sobě jdoucích požadavků do nějaké logické sekvence. Popsal jsem také tři techniky, které umožňují tuto bezstavovost s větším či menším množstvím problémů obejít: [cookies](http://www.aspnet.cz/Articles/191-stavove-http-cookies.aspx), [sessions](http://www.aspnet.cz/Articles/193-stavove-http-sessions.aspx) a [ViewState](http://www.aspnet.cz/Articles/192-stavove-http-viewstate.aspx).

Jaký je tedy můj závěrečný verdikt a doporučení, kterou z technologií používat? Odpověď je jednoduchá: pokud možno žádnou.

Bezstavovost HTTP je jeho základní a do jisté míry definující vlastností. Právě proto, že HTTP je bezstavové, je jednoduché na implementaci a právě proto se dočkalo tak jednoduchého rozšíření. První a základní rada tedy zní: navrhujte své aplikace jako bezstavové, pokud to jenom trochu jde. Onu stavovost si totiž na HTTP vynutíte jenom obtížně a krví za ní zaplatíte, dříve či později.

**Sessions** radím nepoužívat vůbec. Pokud je použijete špatně, vedou k problémům se škálovatelností aplikace a místy k nepředvídatelnému chování, když se session z nějakého důvodu "ztratí". Pokud je chcete použít správně, bude vás to stát tolik úsilí, že to rovnou můžete vyřešit jinak.

**ViewState** je v drtivé většině případů zbytečné, mírnou úpravou kódu se obejdete bez něj, možná za cenu jstého zvýšení zátěže databáze. Zpravidla je ale toto zvýšení výhodnou výměnou za výrazné snížení objemu přenášených dat. Základní funkcionalitu dokážete realizovat pomocí ControlState, kterého se stejně nezbavíte. Novou krev do žil může této technologii vnést nová verze ASP.NET 4.0, která vám umožní ViewState globálně vypnout a zapnout ho jenom pro konkrétní prvky. Zatím to nejde, pokud chcete dosáhnout tohoto efektu, musíte ViewState naopak vypnout všude, kde ho nepotřebujete a jenom někde nechat zapnuté. Což je sice možné, ale nepříliš elegantní.

**Cookies** jsou dle mého názoru nejmenším zlem. Na jejich podporu se dnes můžeme již vcelku spolehnout, staly se tak nepostradatelnými, že mít je vypnuté je v podstatě nemožné. Zároveň se výrazně zvýšila jejich ochrana v prohlížečích, takže k vypínání z důvodu obavy o soukromí není zásadní důvod. Jejich nevýhodou je, že do nich můžete uložit jenom dosti omezené množství dat.

## Typický příklad

Představme si třeba internetový obchod, který jistou míru stavovosti vyžaduje. V první řadě chceme funkčnost nákupního košíku, do kterého je možné přidávat zboží a i jinak s ním pracovat. Dále pak máme "pokladnu", neboli odesání objednávky, které může probíhat v několika logicky propojených krocích, např. výběr způsobu dopravy, zadání adresy a dalších údajů atd.

Nákupní košík lze realizovat pomocí cookies. V jednodušších případech (kdy předpokládáme menší objem "košíkových" dat) lze prostě seznam vybraných položek uložit přímo do cookie. V komplikovanějších případech si můžete napsat "něco jako session" vlastními silami. Tedy obsah košíku budete ukládat do databáze a do cookie si uložíte jenom nějaký unikátní identifikátor košíku. Jsem znám jako horlivý odpůrce znovuobjevování kola, tak proč tak najednou navrhuji znovuobjevování session? Protože tohle specializované "kolo" je mnohem rozumnější, než "generická" varianta v podobě session. Obsah košíku nebudete patrně tupě načítat vždy, na každé stránce (typicky zobrazujete jenom počet položek nebo celkovou cenu a to si můžete cacheovat v cookie také) a kromě toho, rozumný způsob uložení dat vám umožní držet "session" dlouhou dobu. Ne v řádu desítek minut, ale třeba v řádu dnů nebo týdnů, což se zrovna v případě nákupního košíku může hodit. Údržbový mechanismus, který opuštěné košíky smaže, můžete pak spouštět dávkově, jednou za čas.

V procesu odesílání objednávky si vystačíte s ControlState. Celý proces můžete realizovat pomocí jednoho formuláře a ControlState se postará o zbytek. Jakmile budete mít všechna data pohromadě, vytvoříte objednávku v databázi a dále pracujete jenom s nějakým jejím (stručným) identifikátorem. Třeba při přesměrování na platební bránu – takže pokud vám v průběhu transakce někdo restartuje server, objednávka se ještě někdy najde.

Tolik tedy k (bez)stavovosti. A pamatujte – je to váš přítel, kterého byste měli využít. Ne nepřítel, se kterým je nutno bojovat ohněm a mečem!