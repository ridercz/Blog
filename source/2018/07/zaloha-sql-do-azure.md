<!-- dcterms:title = Automatizovaná záloha SQL Serveru do Azure Storage -->
<!-- dcterms:abstract = Před lety jsem napsal populární skript na automatizaci záloh databází na SQL Serveru Express. Microsoft SQL Server se mezitím naučil zálohování do Azure Storage, což je velmi jednoduchý, levný a spolehlivý způsob, jak nepřijít o data. Svůj skript jsem tedy rozšířil o možnost záloh do cloudového úložiště. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:dateAccepted = 2018-07-26 -->
<!-- x4w:category = IT -->
<!-- x4w:pictureUrl = /perex-pictures/logo-azure.png -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->

Jeden z mých nejužitečnějších článků je myslím [Automatizovaná záloha všech databází na SQL Express](https://www.altair.blog/2009/12/automatizovana-zaloha-vsech-databazi-na-sql-express). SQL Server Express je přes svá omezení mocný nástroj a mnoha firmám více než postačuje, zejména protože je zdarma. Pomocí jednoduchého skriptu lze též vyřešit jeho pravidelné zálohování, i když nemá službu SQL Server Agent.

Od verze (nepletu-li se) 2012 podporuje SQL Server též zálohování do Azure Storage. Nastal tedy čas můj devět let starý skript poněkud rozšířit a nabídnout i zálohu do cloudu.

## Proč zálohovat do cloudu

Protože je to snadné, levné a spolehlivé. Vzhledem k vestavěné podpoře na to stačí jediný SQL příkaz a dá se to snadno skriptovat. Azure Storage úložiště je - pro objemy dat, které lze u většiny českých firem předpokládat - velmi levné. A je řádově spolehlivější, než většina úložišť, která mají standardní české firmy k dispozici.

Proto doporučuji - umožňuje-li to objem dat vaší databáze - tuto formu zálohy využívat, třeba jako doplňkovou "poslední záchranu" pro případ, že by vše ostatní selhalo.

Konkrétně zde popisovaný postup je určen pro SQL Server Express, ale můžete jej použít i na vyšších edicích.

## Příprava Storage Accountu

Nejdříve si musíte v Azure vytvořit úložiště - storage account. Lze tak učinit mnoha způsoby, my použijete webové rozhraní na [portal.azure.com](https://portal.azure.com).

![](https://www.cdn.altairis.cz/Blog/2018/20180726-portal-1.png)

Nejprve kleněte na _Create a resource_, poté ze seznamu vyberte _Storage_ a následně _Storage account - blob, file, table, queue_.

![](https://www.cdn.altairis.cz/Blog/2018/20180726-portal-2.png)

Poté zadejte název (_Name_). Ten musí být unikátní a smí obsahovat pouze malá písmena anglické abecedy a číslice a musí být 3-24 znaků dlouhý. Zde je `sqlbackuptutorial`.

Zadejte název Resource Group, v níž bude storage account umístěn. Pokud nemáte specifické požadavky, vytvořte novou RG, která se bude jmenovat stejně jako storage account.

Klepněte na tlačítko _Create_ a vyčkejte. Vytvoření účtu bude trvat několik desítek sekund.

![](https://www.cdn.altairis.cz/Blog/2018/20180726-portal-3.png)

Až se tak stane, zobrazte si vlastnosti nově vytvořeného účtu a klepněte na _Access keys_. Poznamenejte si název účtu (`sqlbackuptutorial`) a jeden z klíčů `key1` nebo `key2`.

> Oba dva klíče si jsou rovny a mají stejnou funkci. Dva klíče jsou vygenerovány proto, abyste je mohli bez výpadku změnit.

![](https://www.cdn.altairis.cz/Blog/2018/20180726-portal-4.png)

Jako poslední je třeba vytvořit kontejner, do kterého budete data ukládat. Klepněte na _Container_ a poté na _+ Container_. Zadejte název `sqlbackup` a klepněte na OK.

## Nastavení SQL Serveru

V SQL Serveru musíte vytvořit _credential_, tedy uložit autentizační údaj, který budeme později používat. Můžete jej vytvořit v GUI SQL Management Studia (v hlavním stromu _Server\Security\Credentials_) nebo pomocí následujícího příkazu, kde stačí nahradit hodnoty `IDENTITY` a `SECRET` názvem účtu a klíčem vygenerovaným výše. Můžete změnit i jméno (zde `AzureStorage`), ale pak budete muset změnit i další skripty.

```sql
CREATE CREDENTIAL AzureStorage WITH 
    IDENTITY = 'sqlbackuptutorial',
    SECRET = '5D/R5sUXPzJ/uTjdndTOZYgT71Imb028ZaUMjlVBbS34lShfueBhr7fxVBWqKSNO+5eVsrLXuHtMbai+PT028g=='
```

## Záloha databáze

Nyní můžete zálohovat databáze do Azure Storage. Zálohu jedné konkrétní databáze provedete následujícím příkazem:

```sql
BACKUP DATABASE Northwind
TO URL = 'https://sqlbackuptutorial.blob.core.windows.net/sqlbackup/Northwind.bak'   
WITH CREDENTIAL = 'AzureStorage'
```

Hodnota `URL` je adresa v rámci Azure Storage, kde bude záloha vytvořena. Pokud chcete přepsat zálohu na této adrese již existující, přidejte `WITH FORMAT`:

```sql
BACKUP DATABASE Northwind
TO URL = 'https://sqlbackuptutorial.blob.core.windows.net/sqlbackup/Northwind.bak'   
WITH CREDENTIAL = 'AzureStorage', FORMAT
```

## Záloha všech databází

Pro sálohu všech uživatelských databází můžeme použít mírně upravený skript z [minulého článku](https://www.altair.blog/2009/12/automatizovana-zaloha-vsech-databazi-na-sql-express). Základní logika procházení databází v cyklu a postupné zálohy zůstává stejná, pouze zálohujeme do URL a ne na místní disk.

```sql
/*******************************************************************************
** ALL USER DATABASE BACKUP TO AZURE - SCRIPT FOR MICROSOFT SQL SERVER        **
** Copyright (c) Michal A. Valasek, Altairis, 2018                            **
** https://www.altairis.cz/ | https://www.rider.cz/ | https://www.altair.blog **
*******************************************************************************/

-- Configuration
DECLARE	
    @base_url AS nvarchar(max) = 'https://sqlbackuptutorial.blob.core.windows.net/sqlbackup/',
    @credential_name AS nvarchar(max) = 'AzureStorage'

-- Declare variables used in the script
DECLARE
    @timestamp AS nvarchar(20),
    @current_id AS int,
    @current_name AS nvarchar(max),
    @current_url AS nvarchar(max)

-- Create file name timestamp (YYYYMMDD_hhmmss format)
SET @timestamp = CONVERT(nvarchar, GETDATE(), 20)
SET @timestamp = REPLACE(@timestamp, '-', '')
SET @timestamp = REPLACE(@timestamp, ':', '')
SET @timestamp = REPLACE(@timestamp, ' ', '_')

-- Get initial database ID
SELECT @current_id = MIN(database_id) FROM sys.databases WHERE owner_sid != 0x01

-- Go trough all user databases
WHILE @current_id IS NOT NULL BEGIN
    -- Get database name and backup file
    SELECT @current_name = name FROM sys.databases WHERE database_id = @current_id
    SET @current_url = @base_url + @current_name + '_' + @timestamp + '.bak'

    -- Backup database
    PRINT 'Backing up database ' + @current_name + ' to ' + @current_url
    BACKUP DATABASE @current_name TO URL = @current_url WITH CREDENTIAL = @credential_name
    PRINT NULL

    -- Get next database ID
    SELECT @current_id = MIN(database_id) FROM sys.databases WHERE owner_sid != 0x01 AND database_id > @current_id
END
```

I mechanismus spouštení lze převzít z [původního článku](https://www.altair.blog/2009/12/automatizovana-zaloha-vsech-databazi-na-sql-express), jenom si tentokrát můžeme odpustit laborování s předávanými parametry `SQLCMD`, protože není co nastavovat.

![](https://www.cdn.altairis.cz/Blog/2018/20180726-portal-5.png)

Že záloha úspěšně proběhla si můžeme ověřit pomocí Azure Portálu. Stačí klepnout na název kontejneru a zobrazí se seznam uložených blobů (souborů).

Tento mechanismus nezahrnuje mazání starých záloh, protože v případě mých databází je cena za uskladnění tak nízká, že se mi nevyplatí mazání řešit. Pokud je to ve vašem případě jinak, bude to nutné řešit externími prostředky, například nějakým PowerShellovým skriptem nebo naplánovanou úlohou v Azure.