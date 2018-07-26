<!-- dcterms:identifier = aspnetcz#249 -->
<!-- dcterms:title = Automatizovaná záloha všech databází na SQL Express -->
<!-- dcterms:abstract = Express edice SQL Serveru 2008 je dostatečně robustní pro běh řady aplikací, přestože je dostupná zdarma. Většímu nasazení mnohdy brání absence SQL Agenta a Maintenance plánů, které u "velkého" SQL serveru zajišťují automatizovanou údržbu a zálohu databází. S trochou šikovnosti lze ale databáze automaticky zálohovat i u Express edice. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = IT -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2009-12-25T22:54:22.793+01:00 -->
<!-- dcterms:dateAccepted = 2009-12-25T22:54:22.793+01:00 -->

Express edice SQL Serveru 2008 je dostatečně robustní pro běh řady aplikací, přestože je dostupná zdarma. Většímu nasazení mnohdy brání absence SQL Agenta a Maintenance plánů, které u "velkého" SQL serveru zajišťují automatizovanou údržbu a zálohu databází. S trochou šikovnosti lze ale databáze automaticky zálohovat i u Express edice.

Maintenance plány fungují tak, že vám umožní například zazálohovat všechny databáze nebo na nich provést nějaké údržbové úkoly. SQL Server Agent, který se o ně stará, je jakýsi "task scheduler", který žije uvnitř SQL Serveru a stará se o automatické spouštění úloh.

Express edice nic takového nemá a pokud chceme například automaticky zálohovat všechny databáze, je třeba to naskriptovat vlastními silami. Princip fungování je velmi jednoduchý: V první řadě vytvoříme SQL dávku, která při spuštění projede seznam všech databází a pomocí příkazu BACKUP DATABASE je zazálohuje. Ve druhé řadě pak napíšeme dávkový soubor (CMD), ve kterém pomocí utility SQLCMD dříve vytvořený SQL skript spustíme. Aby se nám zálohy na disku nehromadily až do jeho úplného zaplnění, automaticky rovněž smažeme všechny záložní soubory, které jsou starší než definovaný počet dnů. Tento dávkový soubor pak pomocí systémového task scheduleru spustíme například jednou za den.

## ExpressBackup.sql

Takhle bude vypadat soubor `ExpressBackup.sql`, který provede vlastní zálohování:

    /******************************************************************************
    ** ALL DATABASE BACKUP SCRIPT FOR MICROSOFT SQL SERVER EXPRESS EDITION 2008  **
    ** Copyright (c) Michal A. Valasek, Altairis, 2009                           **
    ** http://www.aspnet.cz/ | http://www.altairis.cz/ | http://www.rider.cz/    **
    ** ------------------------------------------------------------------------- **
    ** When running from command line:                                           **
    **  - set BackupFilePath environment variable                                **
    **  - see ExpressBackup.cmd for example                                      **
    ** When running from SQL management studio:                                  **
    **  - enable Query -> SQLCMD mode                                            **
    **  - uncomment the ":setvar" line below and specify path                    **
    ******************************************************************************/

    -- :setvar BackupFilePath "D:\SqlBackup\" -- include trailing backslash!!

    -- Declare variables used in the script
    DECLARE
        @timestamp AS nvarchar(20),
        @current_id AS int,
        @current_name AS nvarchar(max),
        @current_file AS nvarchar(max)

    -- Create file name timestamp (YYYYMMDD_hhmmss format)
    SET @timestamp = CONVERT(nvarchar, GETDATE(), 20)
    SET @timestamp = REPLACE(@timestamp, '-', '')
    SET @timestamp = REPLACE(@timestamp, ':', '')
    SET @timestamp = REPLACE(@timestamp, ' ', '_')

    -- Get initial database ID
    SELECT @current_id = MIN(database_id) FROM sys.databases WHERE name <> 'tempdb'

    -- Go trough all databases
    WHILE @current_id IS NOT NULL BEGIN
        -- Get database name and backup file
        SELECT @current_name = name FROM sys.databases WHERE database_id = @current_id
        SET @current_file = '$(BackupFilePath)' + @current_name + '_' + @timestamp + '.bak'
        
        -- Backup database
        PRINT 'Backing up database ' + @current_name + ' to ' + @current_file
        BACKUP DATABASE @current_name TO  DISK = @current_file WITH NOINIT
        PRINT NULL
        
        -- Get next database
        SELECT @current_id = MIN(database_id) FROM sys.databases WHERE name <> 'tempdb' AND database_id > @current_id
    END

Tato dávka postupně zazálohuje všechny databáze do souboru `NázevDB_YYYYMMDD_hhmmss.bak` ve složce určené SQLCMD proměnnou `BackupFilePath`. 

Výše uvedený skript není primárně určen k tou, aby byl spouštěn interaktivně z Management Studia (i když i to je možné, pokud zapneme SQLCMD režim, viz komentář), ale právě ke spuštění pomocí řádkové utility SQLCMD. V takovém případě se konstrukce `$(NázevProměnné)` ve skriptu zamění za hodnotu systémové proměnné `NázevProměnné`.

## ExpressBackup.cmd

To je myslím hezky vidět v souboru `ExpressBackup.cmd`, který dělá v podstatě jenom tři věci: nastaví systémovou proměnnou, zavolá výše uvedenou SQL dávku a poté vymaže všechny záložní soubory starší než 7 dnů (posuzuje to podle data poslední změny souboru, ne podle jeho názvu).

    @ECHO OFF

    REM -- Set path to backup databases to - referenced from the SQL script
    REM -- This path must include trailing backslash!
    SET BackupFilePath=D:\SqlBackup\
    
    REM -- Call SQLCMD with parameters needed to connect to SQL Server
    SQLCMD -S .\SqlExpress -E -i ExpressBackup.sql
    
    REM -- Delete all backup files older than 7 days
    ECHO Deleting backups older than 7 days...
    FORFILES /P %BackupFilePath% /M *.bak /D -7 /C "CMD /C DEL /Q @FILE"

Tento soubor (zejména cestu k záložním souborům a volání SQLCMD) si můžete upravit dle potřeby.

Poslední krok pak spočívá v tom, že soubor `ExpressBackup.cmd` zavoláte jednou za den pomocí systémového plánovače úloh. Je nutné, aby běžel pod účtem, který má na SQL serveru právo zazálohovat příslušné databáze (je členem databázové role `db_backupoperator`).

Ačkoliv je tento návod ušit na míru Express edici, můžete ho v případě nutnosti použít i na vyšší edice. Nicméně obecně to nedoporučuji, SQL Server Agent umí mnohem víc a vyplatí se s ním naučit zacházet.