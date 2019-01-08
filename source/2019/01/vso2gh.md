<!-- dcterms:title = Jak zmigrovat z Azure DevOps (ex- Visual Studio Online) na GitHub -->
<!-- dcterms:abstract = GitHub umožnil bezplatným uživatelům zakládat neomezené množství privátních repozitářů. Psal jsem o tom již včera, s nadšením že budu moci konečně na GitHub převést všechny svoje projekty. Na migraci z Azure DevOps (dříve Visual Studio Online, ještě dříve TFS Online) jsem si dokonce napsal skript. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/logo-github.png -->
<!-- x4w:coverUrl = /cover-pictures/20190109-vso2gh.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = IT -->
<!-- dcterms:dateAccepted = 2019-01-09 -->

GitHub umožnil bezplatným uživatelům zakládat neomezené množství privátních repozitářů. [Psal jsem o tom již včera](https://www.altair.blog/2019/01/github), s nadšením že budu moci konečně na GitHub převést všechny svoje projekty. Na migraci z Azure DevOps (dříve Visual Studio Online, ještě dříve TFS Online) jsem si dokonce napsal skript.

GitHub nabízí přímo možnost importu repozitáře ze známých služeb (v menu _+_ místo _New repository_ zvolte _Import repository_). Import je vhodný pro případy komplikovaných repozitářů. Jenomže většina mých repozitářů v TFS je primitivních, nějaké ukázkové aplikace pro zákazníky a podobně. Prostý kód v jedné `master` větvi. 

Pro ně je procedura importu příliš komplikovaná a zdlouhavá. Proto jsem napsal jednoduchý skript `vso2gh.cmd` soubor, který celý proces automatizuje. Zde je:

```bat
@ECHO OFF
SETLOCAL

ECHO -------------------------------------------------------------------------------
ECHO VSO2GH version 1.0.0 - (c) Michal A. Valasek - Altairis, 2019
ECHO                            www.altair.blog * www.rider.cz * www.altairis.cz
ECHO -------------------------------------------------------------------------------
ECHO.

IF "%1" EQU "" GOTO HELP
IF "%2" EQU "" GOTO HELP
IF "%3" EQU "" GOTO HELP

SET SOURCE=https://%1.visualstudio.com/DefaultCollection/%3/_git/%3
IF "%4" EQU "" (
    SET TARGET=https://github.com/%2/%3.git
) ELSE (
    SET TARGET=https://github.com/%2/%4.git
)


ECHO Migrate git repository from Azure DevOps (ex- Visual Studio Online) to GitHub:
ECHO Source: %SOURCE%
ECHO Target: %TARGET%
CHOICE /M "Do you want to continue?"
IF %ERRORLEVEL% NEQ 1 EXIT /B
ECHO.

REM -- First, clone the original repository
git clone %SOURCE%

REM -- Remove original remote origin
CD %3
git remote rm origin

REM -- Add GitHub as new remote origin
git remote add origin %TARGET%

REM -- Push the repository there
git push -u origin master

REM -- Configure
git config master.remote origin
git config master.merge refs/heads/master

CD ..
EXIT /B

:HELP
ECHO Migrate git repository from Azure DevOps (ex- Visual Studio Online) to GitHub.
ECHO.
ECHO USAGE vso2gh hostname username vsoproject [ghproject]
ECHO hostname      the custom part of *.visualstudio.com
ECHO username      GitHub user name
ECHO vsoproject    repository name in Azure DevOps/VSO
ECHO ghproject     empty GitHub project name, defaults to vsoproject

```

Skript se volá takto:

    vso2gh hostname username vsoproject [ghproject]

Význam parametrů je následující:

* `hostname` je personalizovaná část VSO adresy. Tj. např. máte-li adresu `altairis.visualstudio.com`, zadejte `altairis`.
* `username` je vaše uživatelské jméno na GitHubu.
* `vsoproject` je název migrovaného projektu v Azure DevOps (VSO).
* `ghproject` je nepovinný argument, název cílového repozitáře na GitHubu. Pokud není uveden, předpokládá se, že je stejný jako `vsoproject`.

Skript nevytvoří repozitář na GitHubu, to musíte udělat sami ručně. Vytvořte úplně prázdný repozitář a potom spusťte výše uvedený skript.