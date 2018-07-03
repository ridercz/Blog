<!-- dcterms:identifier = aspnetcz#3413 -->
<!-- dcterms:title = Moje oblíbená rozšíření pro Visual Studio v roce 2013 -->
<!-- dcterms:abstract = Na svém Ask.fm jsem byl tázán, jaké používám add-iny do Visual Studia. Původně jsem chtěl tazatele odkázat na svůj starší článek na toto téma, ale pak jsem zjistil, že se od té doby seznam mých pluginů dost změnil. Něco přibylo a něco zmizelo, protože se to už stalo součásti Visual Studia. Zde je tedy můj současný seznam pro Visual Studio 2012. -->
<!-- np9:categoryId = 7 -->
<!-- x4w:category = Software -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2013-05-25T02:06:19.127+02:00 -->
<!-- dcterms:dateAccepted = 2013-05-25T02:06:20+02:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20130525-moje-oblibena-rozsireni-pro-visual-studio-v-roce-2013.png -->

Na [svém Ask.fm](http://ask.fm/ridercz) jsem byl tázán, jaké používám add-iny do Visual Studia. Původně jsem chtěl tazatele odkázat na svůj [starší článek na toto téma](http://www.aspnet.cz/articles/329-moje-oblibena-rozsireni-pro-visual-studio), ale pak jsem zjistil, že se od té doby seznam mých pluginů dost změnil. Něco přibylo a něco zmizelo, protože se to už stalo součásti Visual Studia. Zde je tedy můj současný seznam pro Visual Studio 2012.

## Source control

Postupně jsem byl donucen pro různé projekty používat různé verzovací systémy. Používám Subversion, Mercurial i Git. Takže mám odpovídající pluginy i Windows klienty. Bohužel se mi stává, že Visual Studio zapomíná, jaký verzovací systém solution používá a musím to ručně přepínat. Řešení tohoto problému bohužel neznám.

*   Subversion: [AnkhSVN](http://visualstudiogallery.msdn.microsoft.com/E721D830-7664-4E02-8D03-933C3F1477F2?SRC=Home) (VS plugin) + [TortoiseSVN](http://tortoisesvn.net/) (Windows klient) + [VisualSVN Server](http://www.visualsvn.com) 
*   Mercurial: [HgSCC](http://visualstudiogallery.msdn.microsoft.com/9bc074fa-9e1f-4ce2-a75d-b90e65f7475a) + [TortoiseHg](http://tortoisehg.bitbucket.org/) 
*   Git: [Visual Studio Tools for Git](http://visualstudiogallery.msdn.microsoft.com/abafc7d6-dcaa-40f4-8a5e-d6724bdb980c) + [TortoiseGit](http://code.google.com/p/tortoisegit/)  

## Univerzální sady rozšíření

Používám několik víceméně univerzálních sad rozšíření, které do Visual Studia přidávají drobné, ale užitečné funkce. Uvádím ty, které mne zajímají nejvíce, ta rozšíření toho umí mnohem víc:

*   [Productivity Power Tools](http://visualstudiogallery.msdn.microsoft.com/3a96a4dc-ba9c-4589-92c5-640e07332afd) – column guides, copy as HTML, vylepšený scrollbar, organize usings… 
*   [VSCommands for Visual Studio 2012](http://visualstudiogallery.msdn.microsoft.com/a83505c6-77b3-44a6-b53b-73d77cba84c8) – Barevné odlišení zpráv v output okně, solution badges, možnost libovolně seskupovat soubory v Solution exploreru. 
*   [Web Essentials 2012](http://vswebessentials.com/) – základní rozšíření Visual Studia pro každého webového programátora  

## Všeliké jiné různé

*   [AttachTo](http://visualstudiogallery.msdn.microsoft.com/d0265ab0-df51-4100-8e10-1f84403c4cd0) – umožňuje na jedno kliknutí připojit debugger k IIS nebo IIS Express. 
*   [CodeMaid](http://visualstudiogallery.msdn.microsoft.com/site/search?query=codemaid&f%5B0%5D.Value=codemaid&f%5B0%5D.Type=SearchText&ac=3) – umí "uklidit" prasácky napsaný kód (zformátovat ho podle vámi definovaných pravidel, seřadit metody…) a také má kouzenou funkci "Collapse all Recursively", která umí zavřít rozcapený strom v Solution Exploreru. 
*   [GhostDoc](http://visualstudiogallery.msdn.microsoft.com/46A20578-F0D5-4B1E-B55D-F001A6345748) - Nástroj pro automatické generování XML dokumentace ke třídám, vlastnostem, metodám… Má spoustu inteligentních šablon, které vygenerují I hodně návodného textu, který pak staší jenom upravit. Free verze je zdarma, schopnější Pro za peníze. 
*   [Image Optimizer](http://visualstudiogallery.msdn.microsoft.com/a56eddd3-d79b-48ac-8c8f-2db06ade77c3) – plugin od autora Web Essentials řeší optimalizaci velikosti PNG a JPG souborů. Optimalizace je bezztrátová, funguje na principu vnitřní optimalizace datových struktur. 
*   [Indent Guides](http://visualstudiogallery.msdn.microsoft.com/e792686d-542b-474a-8c55-630980e72c30) – doplní čáry, vizuálně zdůrazňující odsazení částí kódu. Nepostradatelné v hluboce hierarchicky strukturovaných záležitostech HTML, XML, C#… 
*   [Layouts O Rama](http://visualstudiogallery.msdn.microsoft.com/35966ad9-430f-4ad7-9186-4394b784e36c) – nepostradatelný plugin pro někoho, kdo pracuje v různých konfiguracích monitorů. Když mám notebook v docku, mám tři monitory (a na nich rozložená různá okna), pokud mimo dock, mám jenom jednu obrazovku a jiné rozlišení. Layouts O Rama umožňuje uložit několik různých rozložení oken a přepínat se mezi nimi. 
*   [SQL Server Compact Toolbox](http://sqlcetoolbox.codeplex.com/) v současné době nemám nainstalovaný, protože SQL CE v současných projektech používám via EF Code First, ale pokud bych měl se SDF databázemi dělat cokoliv pokročilejšího, nainstaloval bych si ho.  

## Věci od Microsoftu

*   [Azure SDK 2.0 for .NET](http://weblogs.asp.net/scottgu/archive/2013/04/30/announcing-the-release-of-windows-azure-sdk-2-0-for-net.aspx) přináší integraci správy Windows Azure do Visual Studia a výrazně zjednodušuje deployment do Azure Web Sites. 
*   [Identity and Access Tool](http://visualstudiogallery.msdn.microsoft.com/e21bf653-dfe1-4d81-b3d3-795cb104066e) je nástroj na na konfiguraci federated identity. 
*   Pod dojmem TechEdí přednášky Tomáše Hercega jsem si nainstaloval [TypeScript](http://www.typescriptlang.org/), ale zatím jsem ho ještě nepoužil. 