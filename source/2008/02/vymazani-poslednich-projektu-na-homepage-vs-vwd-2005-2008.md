<!-- dcterms:identifier = aspnetcz#186 -->
<!-- dcterms:title = Vymazání posledních projektů na homepage VS/VWD 2005/2008 -->
<!-- dcterms:abstract = Když si hraju s větším množstvím pokusných projektů a příkladů, esteticky mne uráží, že se jejich názvy drží v seznamu naposledy otevřených projektů na úvodní stránce Visual Studia. Vymazání tohoto seznamu je ale vemi snadné. -->
<!-- np9:categoryId = 7 -->
<!-- x4w:category = Software -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2008-02-25T08:00:33+01:00 -->
<!-- dcterms:dateAccepted = 2008-02-25T08:00:33+01:00 -->

Když si hraju s větším množstvím pokusných projektů a příkladů, esteticky mne uráží, že se jejich názvy drží v seznamu naposledy otevřených projektů na úvodní stránce Visual Studia. Vymazání tohoto seznamu je ale vemi snadné.

Údaje o posledních otevřených projektech se udržují v registrech a pomocí jednoduchého dávkového programu a konzolové utilitky REG.EXE (je součástí Windows) lze tyto údaje snadno vymazat:
 <div style="font-size: 11pt; background: white; color: black; font-family: consolas, courier new, monospace"> 

@ECHO OFF

ECHO Cleaning MRU Projects for Visual Studio 2005...

REG DELETE HKCU\Software\Microsoft\VisualStudio\8.0\ProjectMRUList /va /f

ECHO Cleaning MRU Projects for Visual Studio 2008...

REG DELETE HKCU\Software\Microsoft\VisualStudio\9.0\ProjectMRUList /va /f

ECHO Cleaning MRU Projects for Visual Web Developer Express 2005...

REG DELETE HKCU\Software\Microsoft\VWDExpress\8.0\ProjectMRUList

ECHO Cleaning MRU Projects for Visual Web Developer Express 2008...

REG DELETE HKCU\Software\Microsoft\VWDExpress\9.0\ProjectMRUList
</div> 

Výše uvedený soubor je univerzální, funguje pro Visual Studio 2005, 2008 a pro Visual Web Developer Express 2005 a 2008 (za informace stran express edic děkuji autorům komentářů).