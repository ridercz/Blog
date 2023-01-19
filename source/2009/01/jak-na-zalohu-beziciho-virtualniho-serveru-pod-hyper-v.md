<!-- dcterms:identifier = aspnetcz#221 -->
<!-- dcterms:title = Jak na zálohu běžícího virtuálního serveru pod Hyper-V -->
<!-- dcterms:abstract = Jednou z velkých výhod virtualizačních technologií je snadnost zálohování. Stačí spustit zálohu fyzického serveru a máme zazálohovány i virtuální stroje na něm běžící. Tolik tedy praví teorie. V praxi to bývá poněkud složitější. -->
<!-- np9:categoryId = 7 -->
<!-- x4w:category = Software -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2009-01-29T00:38:00+01:00 -->
<!-- dcterms:date = 2009-01-29T00:38:00+01:00 -->

Jednou z velkých výhod virtualizačních technologií je snadnost zálohování. Stačí spustit zálohu fyzického serveru a máme zazálohovány i virtuální stroje na něm běžící. Tolik tedy praví teorie. V praxi to bývá poněkud složitější.

## O zálohování virtuálů obecně

Obecně lze zálohování virtuálního stroje provádět dvěma způsoby. Při prvním z nich zapomeneme na to, že počítač je virtuální a zazálohujeme ho stejně jako fyzický stroj. Tedy nainstalujeme do něj příslušný zálohovací program, agenta či co a zálohujeme jako obvykle. Elegantnější řešení spočívá v tom, že si uvědomíme, že virtuání server není v podstatě nic jiného, než několik souborů na disku a že si můžeme spoustu práce ušetřit tím, že tyto soubory prostě zkopírujeme jinam.

Nejjednodušší řešení tedy spočívá v tom, že virtuální stroj zastavíme, zkopírujeme příslušné VHD soubory a virtuální stroj zase spustíme. To je jednoduché a elegantní (skriptů na programové zastavení a spuštění virtuálního počítače je na webu spousta), ale nevýhodou je downtime. Po dobu zálohování, a to může trvat dlouhé minuty, je server offline. Nejlepší by tedy bylo umět zazálohovat běžící virtuální server, aniž by bylo třeba tento zastavovat nebo jinak zvlášť opečovávat. Dobrá zpráva: jde to. Špatná zpráva: nikdo vám neřekne přesně jak. Tedy až na mne :)

### Sugestivní zatáčka ke snapshotům

Hyper-V disponuje slibně vypadající technologií "snapshotů". Jedním stručným povelem lze vytvořit snapshot běžícího počítače a kdykoliv se k němu pak vrátit. Což o to, funkcionalita je to pěkná, ale **nechrání před selháním disku na hostitelském (fyzickém) stroji**. Snapshot je užitečný, pokud se chystáte páchat zhůvěřilosti ve virtuálu a chcete mít možnost se vrátit zpět (a i zde jsou jisté drobné zádrhele, o nichž si můžete podrobně přečíst [v článku mého MVP kolegy](http://itbloggen.se/cs/blogs/micke/archive/2008/09/20/like-snapshots-in-hyper-v-please-read-this.aspx)). Ale nezachrání vás, když se disk fyzického serveru odebéře do věčných lovišť.

## Jak na zálohu pomocí Shadow Copy

Skutečná cesta k on-line zálohování vede přes Shadow Copy. Shadow copy je funkce, která vám umožní zálohovat i otevřené a průběžně se měnící soubory tím, že vytvoří jejich dočasnou "zmraženou" kopii, kterou pak můžete zkopírovat, kam je jen libo.

Pro práci se shadow copy slouží ve Windows 2008 program `DISKSHADOW.EXE`. Tento jest lze spustit buďto v interaktivním režimu, kdy mu ručně zadáváte příkazy, a nebo v režimu dávkovém, kdy tytéž příkazy zapíšete do textového souboru a ten tomuto programu vecpete do chřtánu pomocí parametrů příkazového řádku.

Obecná idea zálohování Hyper-V stroje je následující:

1.  Na všech discích, kde máte data virtuálních strojů (tedy typicky systémový disk, kde je konfigurace a datové disky, kde je VHD) povolíte shadow copy. 
2.  Vytvoříte shadow copy, tj. v podstatě vytvoříte dočasnou kopii stavu tak, jak je právě *teď*. 
3.  Tuto shadow copy si přimountujete jako další disk (buďto další písmenko a nebo si můžete vytvořit NTFS junction point a namapovat to do prázdného adresáře). 
4.  Z této shadow copy potom běžnými prostředky okopírujete data někam do pryč, na jiný disk. 
5.  Shadow copy opět odmountujete. 
6.  Shadow copy můžete explicitně zrušit. Pokud tak neučiníte, postará se o to příležitostně operační systém sám, drží si jich jenom omezený počet.   

Praktická bezobslužná implementace jest ovšem poněkud komplikovaná, s ohledem na dočasnou a nestálou povahu stínových kopií. Potřebujete udělat hned několik věcí:

1.  Spustit hlavní dávkový soubor, který udělá přípravné práce a spustí `DISKSHADOW.EXE` se sadou příkazů, které vytvoří kopii, přimountují ji a zase odmountují. 
2.  V této sadě příkazů želbohu nemůžete zkopírovat soubory, protože to `DISKSHADOW.EXE` neumí. Umí ale zavolat v rámci dávky externí dávkový soubor, který to udělá. 
3.  Po dokončení běhu dávky se pak vrátíme zpět do hlavního souboru a uklidíme po sobě.   

## Konkrétní implementace

Představme si následující situaci: máme jeden fyzický Hyper-V server a na něm větší množství virtuálů. Fyzický server má tři disky:

*   **C:** – na něm je operační systém a také uložená konfigurační data Hyper-V serverů, a to v adresáři `C:\ProgramData\Microsoft\Windows\Hyper-V\Virtual Machines`. 
*   **D:** – zde se nacházejí systémové disky virtuálních strojů, v adresáři `D:\SystemVHD`. 
*   **E:** – zde se nacházejí datové disky virtuálních strojů, v adresáři `E:\DataVHD`.   

Zálohování chceme provádět "křížem", tedy že data z **D:** zkopírujeme na **E:** a naopak. Konfiguraci (je malá) zkopírujeme na **D:** i na **E:**. Tím dosáhneme toho, že při selhání kteréhokoliv z disků budeme mít k dispozici kompletní data.

Aby byla situace zábavnější, chceme udržovat vždy dvě poslední zálohy, nazvěme je třeba "SetA" a "SetB". Toto opatření zajistí, že i pokud by došlo k selhání v průběhu zálohy, budeme mít k dispozici "poslední dobrá" data odminula.

To celé lze zařídit celkem jednoduše, pomocí jednoho dávkového souboru, jedné sady příkazů pro `DISKSHADOW.EXE` a pár pomocných souborů, které si dle potřeby vytvoříme a zase smažeme.

Hlavní magie se děje v souboru `C:\Backup\HVBS\backup.cmd`, který vypadá následovně:
  <div style="font-family: consolas, courier new; background: white; color: black; font-size: 12pt">   

@ECHO OFF

SET HVBS_SEQMARKERFILE=C:\Backup\HVBS\sequence.marker

SET HVBS_PHAMARKERFILE=C:\Backup\HVBS\phase.marker

SET HVBS_LOGFILE=C:\Backup\HVBS\last.log

IF EXIST %HVBS_PHAMARKERFILE% GOTO PHASE2

:PHASE1

CLS

ECHO Hyper-V Backup Script version 1.0 (2009-01-03)

ECHO Copyright (c) Michal A. Valasek - Altairis, 2008-2009

ECHO.

ECHO == Running backup phase #1 ==

ECHO This is a marker file for determining backup phase. Do not delete. > %HVBS_PHAMARKERFILE%

ECHO Determining backup sequence...

IF EXIST %HVBS_SEQMARKERFILE% (

  DEL %HVBS_SEQMARKERFILE%

  SET HVBS_SEQ=SetB

) ELSE (

  ECHO This is a marker file for determining backup sequence. > %HVBS_SEQMARKERFILE%

  SET HVBS_SEQ=SetA

)

ECHO This is backup sequence "%HVBS_SEQ%"

ECHO [%DATE%%TIME%] Backup sequence "%HVBS_SEQ%" started > %HVBS_LOGFILE%

ECHO Deleting metadata...

DEL C:\Backup\HVBS\*.cab

ECHO Preparing mount points...

MKDIR C:\Backup\HVBS\mnt.c

MKDIR C:\Backup\HVBS\mnt.d

MKDIR C:\Backup\HVBS\mnt.e

ECHO Creating backup directories...

MKDIR D:\Backup-%HVBS_SEQ%\CFG

MKDIR D:\Backup-%HVBS_SEQ%\VHD

MKDIR E:\Backup-%HVBS_SEQ%\CFG

MKDIR E:\Backup-%HVBS_SEQ%\VHD

ECHO Running diskshadow...

ECHO [%DATE%%TIME%] Running diskshadow script >> %HVBS_LOGFILE%

DISKSHADOW /S C:\Backup\HVBS\backup.dsh

ECHO [%DATE%%TIME%] DISKSHADOW completed with errorlevel %ERRORLEVEL% >> %HVBS_LOGFILE%

GOTO PHASE3

:PHASE2

ECHO == Running backup phase #2 ==

DEL %HVBS_PHAMARKERFILE%

ECHO [%DATE%%TIME%] Entering phase 2 >> %HVBS_LOGFILE%

ECHO Copying configuration #1...

ROBOCOPY "C:\Backup\HVBS\mnt.c\ProgramData\Microsoft\Windows\Hyper-V\Virtual Machines" "D:\Backup-%HVBS_SEQ%\CFG" *.xml /MIR /NJH /NJS /ETA

ECHO [%DATE%%TIME%] ROBOCOPY #1 completed with errorlevel %ERRORLEVEL% >> %HVBS_LOGFILE%

ECHO Copying configuration #2...

ROBOCOPY "C:\Backup\HVBS\mnt.c\ProgramData\Microsoft\Windows\Hyper-V\Virtual Machines" "E:\Backup-%HVBS_SEQ%\CFG" *.xml /MIR /NJH /NJS /ETA

ECHO [%DATE%%TIME%] ROBOCOPY #2 completed with errorlevel %ERRORLEVEL% >> %HVBS_LOGFILE%

ECHO Copying system VHDs...

ROBOCOPY "C:\Backup\HVBS\mnt.d\SystemVHD" "E:\Backup-%HVBS_SEQ%\VHD" /MIR /NJH /NJS /ETA

ECHO [%DATE%%TIME%] ROBOCOPY #3 completed with errorlevel %ERRORLEVEL% >> %HVBS_LOGFILE%

ECHO Copying data VHDs...

ROBOCOPY "C:\Backup\HVBS\mnt.e\DataVHD" "D:\Backup-%HVBS_SEQ%\VHD" /MIR /NJH /NJS /ETA

ECHO [%DATE%%TIME%] ROBOCOPY #4 completed with errorlevel %ERRORLEVEL% >> %HVBS_LOGFILE%

GOTO END

:PHASE3

ECHO == Running backup phase #3 ==

ECHO [%DATE%%TIME%] Entering phase 3 >> %HVBS_LOGFILE%

ECHO Deleting mount points...

RMDIR C:\Backup\HVBS\mnt.c

RMDIR C:\Backup\HVBS\mnt.d

RMDIR C:\Backup\HVBS\mnt.e

ECHO [%DATE%%TIME%] Backup sequence "%HVBS_SEQ%" completed >> %HVBS_LOGFILE%

ECHO Backup script completed!

:END
 </div>  

Pomocným fámulem jest soubor `C:\Backup\HVBS\backup.dsh`, jehož obsah je dost stručný:
  <div style="font-family: consolas, courier new; background: white; color: black; font-size: 12pt">   

set context persistent

add volume C: alias drive_c

add volume D: alias drive_d

add volume E: alias drive_E

set verbose on

create

expose %drive_c% C:\Backup\HVBS\mnt.c

expose %drive_d% C:\Backup\HVBS\mnt.d

expose %drive_e% C:\Backup\HVBS\mnt.e

exec C:\Backup\HVBS\backup.cmd

unexpose C:\Backup\HVBS\mnt.c

unexpose C:\Backup\HVBS\mnt.d

unexpose C:\Backup\HVBS\mnt.e
 </div>  

Dále pak si skript v průběhu své činnosti vytvoří a zase smaže soubory `C:\Backup\HVBS\sequence.marker` a `C:\Backup\HVBS\phase.marker`. Postup činnosti zálohovacího skriptu je poměrně prostý:

1.  Spustíme (patrně pomocí Task Scheduleru) dávku `backup.cmd`. 
2.  Ta zjistí, že neexistuje soubor `phase.marker` a pokračuje tedy fází 1. 
3.  Shora uvedený soubor `phase.marker` vytvoříme (na jeho obsahu nezáleží, pouze na tom, zda existuje nebo ne). 
4.  V závislosti na (ne)existenci souboru `sequence.marker` určíme název cílového adresáře jako "`SetA`" nebo "`SetB`" a soubor se vytvoří nebo smaže, takže tyto názvy se cyklicky střídají. 
5.  Vytvoříme prázdné adresáře `C:\Backup\HVBS\mnt.c` až `C:\Backup\HVBS\mnt.e`. Na ně později namapujeme vytvořené kopie. 
6.  Spustíme `DISKSHADOW.EXE` a předáme mu dávku příkazů `C:\Backup\HVBS\backup.dsh`. 
7.  V rámci této dávky je znovu spuštěna ve druhé kopii dávka `backup.cmd`. Protože ale nyní existuje soubor `phase.marker`, přeskočí se již provedená fáze 1 a spustí se fáze 2. 
8.  V ní pomocí ROBOCOPY.EXE zkopírujeme co jen kam potřebujeme. Jen v cestě místo písmen disků použejem dříve vytvořené adresáře "`mnt.c`", "`mnt.d`" a "`mnt.e`". 
9.  Nezapomeneme smazat soubor `phase.marker`, aby se příště dávka spustila zase od začátku a dávku ukončíme. 
10.  V běhu pokračuje první instance `backup.cmd`, která pokračuje fází 3, ve které se už neděje nic zásadního, jenom po sobě uklidíme a smažeme nyní již nepotřebné prázdné adresáře.   

Výsledkem této činnosti je, že při každém spuštění skriptu se nám vytvoří jedna záloha, cyklicky pojmenovaná "`D/E:\Backup-SetA`" a "`D/E:\Backup-SetB`". Virtuální počítače o této činnosti nevědí a nevyžaduje se od nich žádná aktivní spolupráce. Pouze musejí mít nainstalované Integration components (tj. "Virtual Machine Additions pro Hyper-V"). Nemají-li, bezvýpadkově je zálohovat nelze a v průběhu zálohy budou zapauzovány a potí znovu rozběhnuty. Nebo by alespoň měly být, nezkoušel jsem to, protože žádný server bez IC nemám.