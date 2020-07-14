<!-- dcterms:title = Rychlý export databáze do formátu BACPAC -->
<!-- dcterms:abstract = Microsoft SQL Server umožňuje export a import dat do formátu BACPAC. Jedná se v podstatě o BCP (bulk copy) formát a u menších databází se jedná o asi nejrychlejší způsob, jak ji přenést z jednoho serveru na druhý (třeba z produkce na vývojový server, kde si můžete s reálnými daty hrát beztrestně). Napsal jsem skript, který umí celý proces automatizovat. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:coverUrl = /cover-pictures/20200713-bacpac.jpg -->
<!-- x4w:coverCredits = @jankolario via Unsplash.com -->
<!-- x4w:pictureUrl = /perex-pictures/20200713-bacpac.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = IT -->
<!-- dcterms:dateAccepted = 2020-07-13 -->

Microsoft SQL Server umožňuje export a import dat do formátu BACPAC. Jedná se v podstatě o BCP (bulk copy) formát a u menších databází se jedná o asi nejrychlejší způsob, jak ji přenést z jednoho serveru na druhý (třeba z produkce na vývojový server, kde si můžete s reálnými daty hrát beztrestně).

Export a import lze snadno dělat ze SSMQ (SQL Server Management Studio), ale vyžaduje do dost klikání. Jde to i z příkazové řádky, ale to zase vyžaduje dost psaní. Napsal jsem proto skript, který proces výrazně zjednodušuje. Zde je:

```bat
@ECHO OFF

REM -- Configuration
SET SQLPACKAGE="C:\Program Files (x86)\Microsoft SQL Server\140\DAC\bin\sqlpackage.exe"
SET SQLSERVER=.
SET FOLDER="C:\Users\Administrator\Desktop\Export"

REM -- Generate date stamp (expects Czech date format)
FOR /f "tokens=1-3 delims=. " %%a in ('DATE /T') do (SET CURRENT_DATE=%%c%%b%%a)

REM -- Ask for database name
IF "%1"=="" (
    SET /P DBNAME="Enter database name: "
) ELSE (
    SET DBNAME=%1
)

REM -- Generate file name
SET FILENAME="%FOLDER%\%DBNAME%-%CURRENT_DATE%.bacpac"

REM -- Export database to bacpac file
%SQLPACKAGE% /a:Export /ssn:%SQLSERVER% /sdn:%DBNAME% /tf:%FILENAME%
```

Na začátu jsou tři konfigurační proměnné:

* `SQLPACKAGE` je cesta k souboru `sqlpackage.exe`, který je součástí SSMS nebo si ho můžete stáhnout samostatně.
* `SQLSERVER` je název SQL serveru. Tečka znamená lokální server. Lze určit i název instance, např `.\SqlExpress`.
* `FOLDER` je složka, do níž bude ukládán výsledný soubor. Musí existovat, skript ji nevytvoří.

Skript neřeší autentizaci. Předpokládá, že poběží pod účtem, který může použít integrovanou autentizaci a má odpovídající práva.

Další část vygeneruje timestamp ve formátu `YYYYMMDD`, který bude částí názvu souboru. Předpokládá že na serveru bude české nastavení datumu, pro anglické je třeba parsování mírně upravit.

Další část se podívá, zda byl skript volán s parametrem určujícím název databáze. Pokud ne, zeptá se na něj interaktivně.

Následující část pak na základě zjištěných údajů vytvoří název výsledného souboru, který je ve formátu `NázevDB-TimeStamp.bacpac`.

Poslední řádek pak provede vlastní export.

Exportní dávku je možné použít dvěma způsoby. První je, že se zavolá z příkazové řádky s parametrem určujícím název databáze. Druhý je, že se spustí bez jakýchkoliv parametrů, třeba i poklepáním. Pak se na název zeptá.