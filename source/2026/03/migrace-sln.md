<!-- dcterms:title = Dávková konverze solution souborů na formát SLNX -->
<!-- dcterms:abstract = Visual Studio 2026 přináší kromě jiného i nový formát solution souborů. Jsou ve formátu XML a jsou výrazně jednodušší, než ten původní textový formát. Proto je chci hromadně začít používat kde to jenom jde, včetně příkladů a podobně. Jedná se ale o velké množství projektů. Proto jsem napsal skript, který umí celý proces migrace automatizovat. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:date = 2026-03-26 -->
<!-- x4w:category = IT -->
<!-- x4w:pictureUrl = /perex-pictures/20260326-migrace-svn.jpg -->
<!-- x4w:coverUrl = /cover-pictures/20260326-migrace-svn.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->

Visual Studio 2026 přináší kromě jiného i nový formát solution souborů. Jsou ve formátu XML a jsou výrazně jednodušší, než ten původní textový formát. Proto je chci hromadně začít používat kde to jenom jde, včetně příkladů a podobně. Jedná se ale o velké množství projektů. Proto jsem napsal skript, který umí celý proces migrace automatizovat.

## Jak na migraci `.sln` na `.slnx`

Pokud chcete zmigrovat jeden projekt, je to jednoduché. Stačí na to jeden příkaz:

    dotnet sln "Cesta\k\souboru.sln" migrate

případně, pokud se nacházíte v adresáři dané solution a je tam právě jeden `.sln` soubor:

    dotnet sln migrate

Tento příkaz převede `.sln` na `.slnx`.

## Hromadná migrace

Napsal jsem dávkový soubor `migrateall.cmd`, který umí zmigrovat všechny solutions v daném adresáři a rekurzivně jeho podadresářích. Použití je následující:

* `migrateall` - zmigruje všechny `.sln` v daném adresáři a jeho podadresářích na `.slnx` a původní soubory smaže.
* `migrateall C:\Cesta` - totéž, ale pro konkrétní adresář
* `migrateall --dry-run` nebo `migrateall --dry-run C:\Cesta` - jenom vypíše všechny `.sln` soubory, které by jinak migroval.

Zde je jeho zdrojový kód:

```bat
@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

SET "ROOT=%CD%"
SET "DRYRUN=0"

:PARSE_ARGS
IF "%~1"=="" GOTO ARGS_DONE

IF /I "%~1"=="--DRY-RUN" SET "DRYRUN=1"
IF /I "%~1"=="/DRY-RUN"  SET "DRYRUN=1"

IF NOT "%~1"=="--DRY-RUN" IF NOT "%~1"=="/DRY-RUN" (
    SET "ROOT=%~1"
)

SHIFT
GOTO PARSE_ARGS

:ARGS_DONE

ECHO Scanning "%ROOT%" for .SLN files to migrate...
FOR /R "%ROOT%" %%F IN (*.SLN) DO (
    IF "!DRYRUN!"=="1" (
        ECHO Would migrate %%F
    ) ELSE (
        dotnet sln "%%F" migrate

        IF EXIST "%%~DPNF.SLNX" (
            DEL "%%F"
        ) ELSE (
            ECHO   -> Migration failed for %%F, .SLNX file not found.
        )
    )
)

ECHO Done.
ENDLOCAL
```

