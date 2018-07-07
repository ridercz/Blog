<!-- dcterms:identifier = aspnetcz#15 -->
<!-- dcterms:title = Základy použití uložených procedur v .NET -->
<!-- dcterms:abstract = Používat či nepoužívat? Mezi příznivci a odpůrci uložených procedur se vede letitá zákopová válka. Velká část programátorů (zejména začínajících) ale vůbec neví co uložené procedury (stored procedures) jsou a jak se používají. Právě jim je určen tento článek. Zda je budete využívat nebo ne, už nechávám na vás. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Tipy, triky -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2005-01-22T00:17:23.627+01:00 -->
<!-- dcterms:dateAccepted = 2005-01-22T00:17:23.627+01:00 -->

Používat či nepoužívat? Mezi příznivci a odpůrci uložených procedur se vede letitá zákopová válka. Jeden z nejaktuálnějších výstřelů najdete například na blogu [Franse Boumy](http://weblogs.asp.net/fbouma/archive/2003/11/18/38178.aspx). Velká část programátorů (zejména začínajících) ale vůbec neví co uložené procedury (stored procedures) jsou a jak se používají. Právě jim je určen tento článek. Zda je budete využívat nebo ne, už nechávám na vás.

## Co je uložená procedura

Uloženou proceduru je možno si představit jako metodu na straně SQL Serveru, nebo jako dávkový příkaz. Sekvenci SQL příkazů je možno si na straně serveru uložit a pojmenovat. Pak ji lze znovu vyvolat pomocí jejího jména.

Používání uložených procedur má své výhody:

*   Kód je do jisté míry nezávislý na struktuře databázových tabulek (při změně tabulek jest změniti jenom patřičné procedury). Jazyk SQL je vhodný na zpracování některých typů úloh. Platí-li předchozí bod, je takové zpracování rychlejší, než kdyby se provádělo na straně SQL klienta (tedy aplikace). 

Má ovšem i své nevýhody:

*   Musíte se učit další jazyk, protože tady už si se `SELECT`, `INSERT`, `UPDATE` a `DELETE` mnohdy nevystačíte. Přesouváním aplikační logiky na databázovou vrstvu se aplikace znepřehledňuje, zejména je-li příliš složitá na to, aby se tam dala přenést *veškerá* aplikační logika. Používáte-li uložené procedury důsledně na všechno, budete jich mít spoustu. Nepoužíváte-li (někdo se řídí zásadou *čtu vždy přímo, měním vždy přes proceduru*), přijdete o výhodu nezávislosti na struktuře. S tou rychlostí to neplatí absolutně, protože SQL 2000 si umí cacheovat i ad-hoc execution plan; a i když platí, poznáte to až při velké zátěži nebo opravdu velké databázi. 

## Moje první uložená procedura

Tradice velí, abych vám ukázal, jak pomocí SP vypsat 'Hello World!'. Půjdu trochu dál, a naučím vás na tomto příkladu, kterak procedury vytvářet, měnit a mazat. Otevřete si SQL Query Analyzer (nebo jakékoliv jiné prostředí, které vám umožní přímo posílat na SQL server příkazy) a založte si nějakou dočasnou databázi. Připojte se k ní a vykonejte následující příkaz:

CREATE PROCEDURE my_hello_world AS SELECT 'Hello, World!' GO

Po spuštění tohot příkazu se nestane nic viditelného. V hloubi SQL serveru se však stane jedna důležitá věc: vznikne uložená procedura `my_hello_world`.

Nyní si dovolím malou odbočku k názvům: všechny vestavěné uložené procedury mají název začínající prefixem "sp_". Jejich názvy se píší malými písmeny a jednotlivé slova se oddělují podtržítkem - typickým příkladem může být `sp_server_info` (vypíše informace o serveru). V zájmu zachování zdravého rozumu doporučuji, abyste pro své uložené procedury používali stejnou logiku vytváření jmen, ale jiný prefix. Obvyklé je "my_" (jako *moje* v angličtině), ale může to být třeba i zkratka vašeho projektu.

Pokud chcete tuto proceduru vykonat, jednoduše zapište její jméno a spusťte:

my_hello_world

Výsledkem bude resultset o jediném řádku a sloupci, obsahující text *Hello, World!*

Pokud chcete uloženou proceduru změnit, použijte místo *CREATE PROCEDURE* příkaz *ALTER PROCEDURE*:

ALTER PROCEDURE my_hello_world AS SELECT 'Ahoj, světe!' GO 

Pokud chcete proceduru smazat, použijte *DROP PROCEDURE*:

DROP PROCEDURE my_hello_world

## Moje první užitečná procedura

Představme si web, který nabízí možnost zapsat svoji adresu do mailing listu a přihlásit se tak k odběru zpráv. Seznam adres je uložen v SQL tabulce MailingList, která je deklarována takto:

CREATE TABLE MailingList ( Adresa varchar(50) NOT NULL, Datum datetime NOT NULL, )

Pokud chceme přidávat do mailing listu adresu, je dobré ověřit, zda v něm již není, aby tam jeden uživatel nebyl zapsán dvakrát. Musíme tedy za sebou vykonat dva příkazy: zjistit, zda se zadaná adresa nachází v mailing listu a pokud ne, přidat ji:

CREATE PROCEDURE my_pridat_adresu @Adresa varchar(50) AS SET @Adresa = LOWER(@Adresa) IF NOT EXISTS(SELECT * FROM MailingList WHERE Adresa=@Adresa) INSERT INTO MailingList (Adresa, Datum) VALUES (@Adresa, GETDATE()) GO

V tomto okamžiku se na scéně objevuje novinka: SQL parametry - to jsou ty názvy se zavináčem na začátku. Parametr je v podstatě proměnná. V našem případě jejím prostřednictvím předáváme e-mailovou adresu. Pokud budeme chtít naši uloženou proceduru zavolat z VB.NET, učiníme tak takto:

Dim DB As New System.Data.SqlClient.SqlConnection("SERVER=(local);UID=demo;PWD=demo") Dim CMD As New System.Data.SqlClient.SqlCommand("my_pridat_adresu", DB) CMD.CommandType = System.Data.CommandType.StoredProcedure CMD.Parameters.Add("@Adresa", "uzivatel@server.tld") CMD.ExecuteNonQuery() DB.Close()

## Používáme výstupní parametry

V tomto okamžiku máme zajištěno, že v mailing listu nebude žádná adresa dvakrát - a pokud se někdo pokusí přidat adresu, která tam už je, nic se nestane. Lepší by ovšem bylo, kdybychom se o tomto stavu nějak dozvěděli.

SQL umí používat i výstupní parametry, tedy takové, jimiž nám bude hodnota vrácena zpět. Přidáme tedy ještě parametr `@Vysledek`, který bude v případě úspěchu obsahovat text '`+OK něco`' a v případě neúspěchu '`-ERR něco`' (tuto syntaxi jsem si vypůjčil z POP3 protokolu):

ALTER PROCEDURE my_pridat_adresu @Adresa varchar(50), @Vysledek varchar(100) output AS SET @Adresa = LOWER(@Adresa) IF EXISTS(SELECT * FROM MailingList WHERE Adresa=@Adresa) BEGIN SET @Vysledek = '-ERR Adresa se již nachází v mailing listu' END ELSE BEGIN INSERT INTO MailingList (Adresa, Datum) VALUES (@Adresa, GETDATE()) SET @Vysledek = '+OK Adresa byla úspěšně přidána do mailing listu' END GO

Z prostředí VB.NET zavoláme proceduru a výsledek získáme nějak takhle:

Dim DB As New System.Data.SqlClient.SqlConnection("SERVER=(local);UID=demo;PWD=demo") Dim CMD As New System.Data.SqlClient.SqlCommand("my_pridat_adresu", DB) CMD.CommandType = System.Data.CommandType.StoredProcedure CMD.Parameters.Add("@Adresa", "uzivatel@server.tld") CMD.Parameters.Add("@Vysledek", System.Data.SqlDbType.VarChar, 100).Direction = System.Data.ParameterDirection.Output CMD.ExecuteNonQuery() DB.Close() Response.Write("Výsledek: " & CType(CMD.Parameters("@Vysledek").Value, String))

## Závěr

Na jednoduchých příkladech jste se naučili, jak vytvářet uložené procedury a volat je z prostředí .NET.

K tomu, aby vám tato dovednost byla v praxi k něčemu dobrá, se ovšem musíte naučit jazyk *Transact-SQL*. Dobrým zdrojem informací vám budou SQL ServerBooks Online, které jsou součástí instalace SQL Serveru a nebo si je samostatně můžete stáhnout z webu [Microsoftu](http://www.microsoft.com/sql/techinfo/productdoc/2000/books.asp).