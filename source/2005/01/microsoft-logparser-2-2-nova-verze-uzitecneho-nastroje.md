<!-- dcterms:identifier = aspnetcz#16 -->
<!-- dcterms:title = Microsoft LogParser 2.2: Nová verze užitečného nástroje -->
<!-- dcterms:abstract = Jedna z nenápadných Microsoftích utilitek se dočkala nové verze - a ta zvyšuje jeho použitelnost o řád. -->
<!-- np9:categoryId = 4 -->
<!-- x4w:category = Programování -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2005-01-23T00:05:06.293+01:00 -->
<!-- dcterms:dateAccepted = 2005-01-23T00:05:06.293+01:00 -->

Microsoft [uvolnil novou verzi](http://www.microsoft.com/downloads/details.aspx?FamilyID=890cd06b-abf8-4c25-91b2-f8d975cf8c07&displaylang=en) svého málo známého, ale o to užitečnějšího nástroje **Microsoft LogParser**. Tento program umí zpracovat v podstatě jakákoliv zdrojová data (zejména nejrůznější logy, jak již jeho název napovídá) a dotazovat se do nich pomocí SQL-like dotazů. Výsledek umí vygenerovat v mnoha různých formátech. Přibližnou představu vám může dát následující schéma činnosti:

![Schéma činnosti Microsoft LogParseru](https://www.cdn.altairis.cz/Blog/2005/20050122-logparser-schema.png "Schéma činnosti Microsoft LogParseru")

LogParser není primárně určen ke generování obvyklých webserverových statistik (ne že by to neuměl, ale obvykle je jednodušší použít jiné nástroje). S výhodou ho můžete použít pokud potřebujete analyzovat logy s ohledem na nějaké speciální zadání či při řešení určitého problému.

Výhodou je, že LogParser umí jako vstupní data zpracovat prakticky cokoliv. Obvyklé formáty užívané ve Windows umí zpracovávat nativně (logy IIS, eventlogy atd.), ostatní obvyklé textové formáty (data s oddělovačem, XML...) lze nakonfigurovat, pro formáty zcela obskurní je možno napsat COM plugin.

LogParser sám obsahuje knihovnu logparser.dll, která může být použita jako COM komponenta, takže jeho funkčnost lze zahrnout do dalších programů.

## Použití log parseru k analýze logu web serveru

Následujícím příkazem zpracujeme všechny logy nacházející se v `D:\TMP\wwwlogs` a vypíšeme seznam nejčastějších požadavků, které skončily chybou *404 Object not found*. Pokud se nějaký dotaz opakuje příliš často, pravděpodobně to má nějaký důvod, např. chybně zapsaný odkaz.

`LogParser "SELECT TOP 50 cs-uri-stem AS URL, COUNT(*) AS Pocet FROM D:\TMP\wwwlogs\ex*.log WHERE sc-status=404 GROUP BY cs-uri-stem ORDER BY Pocet DESC" -rtp:-1`

Následujícím příkazem vygenerujeme do souboru `D:\TMP\hits.gif` graf vývoje počtu požadavků (hits) v čase - po dnech. 

`LogParser.exe "SELECT date, COUNT(*) AS Hits INTO D:\TMP\hits.gif FROM D:\TMP\LogParserTestData\ex*.log GROUP BY date ORDER BY date" -o:chart`

Prostřednictvím parametrů ve WHERE klauzuli lze spočítat počet pageviews (odfiltrováním obrázků, stylů a podobných "systémových" záležitostí) a lze měnit parametry grafu, takže výsledek může vypadat nějak takto (graf zachycuje časový vývoj pageviews/den na mém [osobním weblogu](http://weblog.rider.cz/)):

![Ukázka grafu generovaného LogParserem](https://www.cdn.altairis.cz/Blog/2005/20050122-logparser-ukazkagrafu.png "Ukázka grafu generovaného LogParserem")

Generování grafů probíhá prostřednictvím Office Web Components, takže musíte mít na daném počítači licenci MS Office.

## Použití log parseru k analýze jiných logů

Chci používat LogParser k analýze logu mého mail serveru. Jako MTA používám XMail a jeho logy mají tvar dat oddělených tabulátorem, hodnoty jsou uzavřeny v uvozovkách. Typický řádek ze souboru tohoto typu vypadá nějak takhle:

`"" "canis.bbg.altaircom.net" "222.232.226.66" "2005-01-21 23:57:54" "195.39.105.9" "altaircom.net" "ouqwtz@bxemail.com" "michal.valasek@altaircom.net" "S1D002A" "RECV=OK" "" "2897" ""`

LogParser umí nativně s TSV (tab separated values) pracovat, ale nezná formát tohoto konkrétního souboru (který navíc neobsahuje hlavičku). Vytvořím si tedy pomocný soubor `header.tsv`, který bude obsahovat názvy sloupců oddělené tabulátorem:

`res1 server-name client-ip date server-ip domain from to smtp-id status authuser size client-name`

SQL (nebo spíše SQL-like) příkazy se nám stávají čím dál tím složitějšími. Naštěstí není nutno je psát přímo do příkazové řádky - je možno načíst je ze souboru. Pokud budu chtít vypsat počet mailů, které mým serverem prošly za den, použiji následujcí příkaz:

`LogParser -i:TSV file:D:\TMP\smtplogs\stats1.sql -headerRow:OFF -iHeaderFile:D:\TMP\smtplogs\header.tsv -rtp:-1`

Onen soubor `stats1.sql` bude obsahovat toto:

    SELECT 
     TO_DATE(TO_TIMESTAMP(date, '"yyyy-MM-dd hh:mm:ss"')) AS Datum, 
     COUNT(*) AS Pocet 
    FROM D:\TMP\smtplogs\smtp-* 
    WHERE status='"RCPT=OK"'
    GROUP BY Datum 
    ORDER BY Datum

Data mohu samozřejmě vyexportovat i do grafu nebo různě agregovat. Obsáhlejší příklady na analýzu logů XMailu najdete [zde](ftp://ftp.altaircom.net/outgoing/altaircom/logparser-xmail-samples.zip).

## Nejenom na logy

Kromě logů v rozličných formátech lze jako vstupní data použít i takové zdroje jako filesystém, Active Directory nebo registry. Například následujícím příkazem lze na základě shodných MD5 hashů najít na disku shodné soubory:

`LogParser "SELECT HASHMD5_FILE(Path) AS Hash, COUNT(*) AS NumberOfCopies FROM D:\TMP\*.* GROUP BY Hash HAVING NumberOfCopies > 1" -i:FS`

Stejně tak výstup lze ukládat nejenom do rozličných typů souborů, ale též posílat například na [SYSLOG](http://www.faqs.org/rfcs/rfc3164.html) server, nebo je vkládat do libovolné SQL databáze přes ODBC.

### Související odkazy

*   [Microsoft LogParser 2.2](http://www.microsoft.com/downloads/details.aspx?FamilyID=890cd06b-abf8-4c25-91b2-f8d975cf8c07&displaylang=en) - download 
[Forensic Log Parsing with Microsoft's LogParser](http://www.securityfocus.com/infocus/1712) 
[LogParser.com](http://www.logparser.com/) - knihovna odkazů a dalších zdrojů