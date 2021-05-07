<!-- dcterms:title = Jak používat starý Recorder v programu Camtasia 2021 -->
<!-- dcterms:abstract = Moje oblíbená Camtasia má novou verzi 2021. Je v ní i nový Recorder, který má krásné nové rozhraní kompatibilní s high DPI obrazovkami a podobně. Bohužel se v něm (zatím?) nedá nic nastavit. Naštěstí je stále k dispozici stará verze a ukážu vám, jak je mezi sebou přepínat. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:coverUrl = /cover-pictures/20210506-camtasia.png -->
<!-- x4w:pictureUrl = /perex-pictures/logo-camtasia.png -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = Software -->
<!-- x4w:category = Tipy, triky -->
<!-- dcterms:dateAccepted = 2021-05-06 -->

Moje oblíbená Camtasia má novou verzi 2021. Je v ní i nový Recorder, který má krásné nové rozhraní kompatibilní s high DPI obrazovkami a podobně. Bohužel se v něm (zatím?) nedá nic nastavit. Naštěstí je stále k dispozici stará verze a ukážu vám, jak je mezi sebou přepínat.

Pomocí skriptu `UseLegacyRecorder.cmd` můžete nahradit nový Camtasia Recorder tím původním:

```bat
@ECHO OFF

REM -- Rename CamtasiaRecorder to NewCamtasiaRecorder
cd "C:\Program Files\TechSmith\Camtasia 2021"
ren CamtasiaRecorder.* NewCamtasiaRecorder.*

REM -- Rename LegacyCamRecorder to CamtasiaRecorder
ren LegacyCamRecorder.exe CamtasiaRecorder.exe

REM -- Change shortcut in Start Menu
del "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\TechSmith\Camtasia Recorder 2021.lnk"
powershell "$s=(New-Object -COM WScript.Shell).CreateShortcut('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\TechSmith\Camtasia Recorder 2021.lnk');$s.TargetPath='C:\Program Files\TechSmith\Camtasia 2021\CamtasiaRecorder.exe';$s.Save()"
```

Bude nahrazen odkaz ve Start Menu a pokud v Camtasii zvolíte _Record_, zavolá se stará verze. Nová verze bude dostupná jako `NewCamtasiaRecorder.exe`.

Chcete-li se poté vrátit k použití nového Recorderu, použijte skript `UseNewRecorder.cmd`:

```bat
@ECHO OFF

REM -- Rename CamtasiaRecorder to LegacyCamRecorder
cd "C:\Program Files\TechSmith\Camtasia 2021"
ren CamtasiaRecorder.exe LegacyCamRecorder.exe

REM -- Rename NewCamtasiaRecorder to CamtasiaRecorder
ren NewCamtasiaRecorder.* CamtasiaRecorder.* 

REM -- Update shortcut in Start Menu
del "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\TechSmith\Camtasia Recorder 2021.lnk"
powershell "$s=(New-Object -COM WScript.Shell).CreateShortcut('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\TechSmith\Camtasia Recorder 2021.lnk');$s.TargetPath='C:\Program Files\TechSmith\Camtasia 2021\CamtasiaRecorder.exe';$s.Save()"
```

Je pravděpodobné, že se nový Recorder v následujících aktualizacích dočká požadované funkcionality. Ale prozatím se mi lépe používá starší verze.