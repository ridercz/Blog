<!-- dcterms:identifier = aspnetcz#40 -->
<!-- dcterms:title = Události z EventLogu Windows do vaší RSS čtečky -->
<!-- dcterms:abstract = Nápad přehledně zobrazovat události z EventLogu vzdálených serverů jsem zcizil na CodeProjectu. Implementace se mi nelíbila, proto jsem napsal vlastní - lepší. Nabízím vám ji k testování. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Tipy, triky -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2005-06-13T04:50:10.063+02:00 -->
<!-- dcterms:dateAccepted = 2005-06-13T04:50:10.063+02:00 -->

Již dlouho pasu po řešení, které by mi umožnilo nějak jednoduše sledovat důležité události v event logu našich asi dvaceti počítačů. Vyzkoušel jsem (a částečně napsal) kdejakou variantu různého přeposílání vybraných eventů mailem a podobně, ale s ničím jsem nebyl zcela spokojen.

Na CodeProjectu se objevila [zajímavá idea](http://www.codeproject.com/aspnet/EventLogRss.asp): generovat z eventlogu RSS feed, který lze pohodlně zpracovávat jakoukoliv RSS čtečkou. Ten nápad mne opravdu zaujal. Tamo předvedená implementace již méně:

*   On-line generování ASPX stránkou mi přijde úplně nejšťastnější, může server zbytečně zatěžovat. Tímto způsobem lze monitorovat jenom počítač, na kterém běží IIS a žádný jiný. IIS uživatel nemá standardně právo přistupovat k síťovým zdrojům - a dávat mu ho jenom pro tento účel se mi nelíbí. Nabídnuté možnosti filtrování jsou nedostatečné. Některé aplikace používají event log nesprávným způsobem, typ události (*Information*, *Warning*, *Error*, *SuccessAudit*, *FailureAudit*) často neodpovídá její závažnosti. Jest proto nutné umožnit filtrování podle různé kombinace parametrů, která může být dosti složitá. Kromě toho se mi nelíbilo celkové pojetí feedu, měl bych být jediným pohledem do čtečky schopen odhalit chybu, což znamená vhodně popisné titulky a další "hlavičkové" parametry. 

## Moje řešení

Vymyslel jsem tedy řešení, které je dle mého názoru lepší. Jedná se o konzolovou EXE aplikaci, která se v pravidelných intervalech spouští, natáhne si data z různých logů z lokálního i vzdáleného počítače a vygeneruje statické XML (RSS) soubory, které zapíše do WWW prostoru.

Standard RSS jsem mírně modifikoval, lépe řečeno rozšířil pomocí vlastního namespace. Výsledek je tedy kompatibilní se standardem RSS, ale zároveň obsahuje určité údaje specifické pro eventlogy: typicky typ události, EventID, jméno uživatele a podobně.

Běžná čtečka nedokáže samozřejmě tyto speciální údaje využít, ale otevírá se tím cesta k napsání speciálního nástroje, který to umět bude. Kromě toho se dají použít k filtrování.

## Filtrování výstupu

Dlouho jsem bádal nad tím, kterak bych měl zajistit vhodné filtrování dle určitých pravidel. Tak, aby bylo dostatečně schopné, ale přitom aby byl zápis pravidel jednoduchý. Nakonec jsem zvolil XSLT transformaci.

Program vygeneruje RSS feed (s těmito speciálními údaji), ale ještě před jeho uložením na něj může volitelně aplikovat jakoukoliv XSLT transformaci. Do programu jsou vestavěné dvě základní, které propustí pouze chyby (typ *Error*) nebo varování a chyby (*Warning* a *Error*), aby administrátor nebyl zavalen informačními hlášeními.

Tato XSLT transformace může být v podstatě libovolně složitá: lze například vyfiltrovat pouze chyby a varování od SQL serveru a podobně.

Výstupem nemusí být jenom RSS - XSLT transformace umožňuje víceméně jakýkoliv výstup. Pokud nepoužíváte RSS čtečku, je možné nechat si generovat třeba HTML stránky.

## Event Gatherer

Výsledkem mé činnosti jest prográmek nazvaný *Event Gatherer*. Ono slovo "prográmek" je na místě, protože přes své schopnosti je tvořen jenom 180 řádky ve VB.NET. Psal jsem ho už pro .NET 2.0 (Whidbey) Beta 2, ale je triviální ho upravit pro verzi 1.1.

Jeho syntaxe je následující:

`gatherer -L logname -O filename [-C computername] [-M number] [-T transform | -CT filename]`

*   Parametr **-L** je název logu, standardní jsou `System`, `Application` a `Security`. Parametr **-O** je název výstupního souboru. Pokud soubor již existuje, bude přepsán. Parametr **-C** je název nebo IP adresa počítače, ze kterého se mají události načítat. Pokud není uveden, použije se lokální. Uvádějte bez lomítek a podobně. Parametr **-M** je maximální počet záznamů, který bude z logu načten. To neznamená, že tento počet bude i zapsán do RSS feedu, co se v něm objeví záleží na nastavení filtrů. Toto omezení slouží k tomu, aby se opakovaně nenačítaly tisíce starých znáznamů. Parametr **-T** je název vestavěné transformace. Možné jsou tři hodnoty: `errors` (propustí pouze chyby), `warnings` (propustí chyby a varování) a `all` (propustí všechny, standardní nastavení). Parametr **-TC** je cesta ke XSLT souboru, který se použije pro transformaci. Na ukázku je přiložen soubor `FilterSql.xslt`, který vyfiltruje pouze události zapsané Microsoft SQL Serverem a SQL Server Agentem. Pokud je použit tento parametr, případný parametr `-T` se ignoruje. 

## Plány do budoucna

Současné řešení je dostačující pro případ, že v daném místě (lokaci) máte k dispozici alespoň jeden web server. To nemusí být vždy pravidlem. Plánuji tedy do EG doplnit možnost POSTnout výsledek činnosti na zadané URL. Jednoduchý ASPX skript na straně web serveru umožní zaslaná data přijmout a uložit na lokální disk jako XML. Takto bude možné dohledovat lokaci, která nemá žádný web server a neumožňuje přímé připojení, ale má přístup k Internetu.

## Download

Aktuální "Beta 1" verzi EG si můžete stáhnout [zde](https://www.cdn.altairis.cz/Blog/2005/20050613-gatherer-b1.zip). Budu velmi vděčen za vaše připomínky a náměty, případně užitečné XSLT šablony. Pro jistotu znovu připomínám, že pro správnou funkci programu musíte mít nainstalován .NET Framework 2.0 beta 2.