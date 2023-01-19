<!-- dcterms:identifier = aspnetcz#109 -->
<!-- dcterms:title = Dokumentační novinky z Redmondu -->
<!-- dcterms:abstract = Nástroj pro tvorbu MSDN-like dokumentace pro .NET 2.0 a kompletní MSDN Library ke stažení zdarma. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = IT -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2006-08-11T04:00:00+02:00 -->
<!-- dcterms:date = 2006-08-11T04:00:00+02:00 -->

## Pískové zámky dokumentace

Jestli programátoři něco nesnášejí, je to psaní dokumentace. Na hranici snesitelnosti je ještě psaní XML komentářů přímo do kódu - zejména proto, že je nativně podporování Visual Studiem. Výsledkem takového snažení může být XML soubor, který VS 2005 využívá k nápovědě v IntelliSense. Při troše snahy se z týchž podkladů dá vygenerovat HTML dokumentace třeba ve stylu MSDN Library.

Ona "trocha snahy" dosud ve většině případů znamenala použití geniálního nástroje jménem [NDoc](http://ndoc.sourceforge.net/). Ten ovšem nepodporuje .NET 2.0 a jeho další vývoj [byl zastaven](http://www.charliedigital.com/PermaLink,guid,95b2ab68-ba92-413a-b758-2783cde5df9c.aspx), protože jeho autor byl znechucen nedostatkem jakékoliv podpory vývojářské komunity.

Microsoft anoncoval vlastní nástroj v podobném duchu - je znám pod kódovým označením *Sandcastle*. K dispozici je jeho [červencová Community Technology Preview](http://www.microsoft.com/downloads/details.aspx?FamilyID=e82ea71d-da89-42ee-a715-696e3a4873b2&DisplayLang=en). K přívětivosti a jednoduchosti ovládání NDocu mu pravda ještě hodně chybí, jeho ovládání je poněkud... liunxové :-) Pokud jste líní psát komplikované příkazy v command line, doporučuji podívat se na [tento jednoduchý program](http://www.codeproject.com/useritems/SandcastleCreateBat.asp) který umí automagicky vygenerovat příslušné dávkové soubory.

*   [Microsoft codename "sandcastle", July 2006 CTP](http://www.microsoft.com/downloads/details.aspx?FamilyID=e82ea71d-da89-42ee-a715-696e3a4873b2&DisplayLang=en)

*   [Sandcastle CHM-compile BAT script & configuration utility](http://www.codeproject.com/useritems/SandcastleCreateBat.asp)

## MSDN Library ke stažení

Lidé se mne často ptají na doporučenou literaturu. Dostávají mne tím trochu do úzkých, protože je obvykle neuspokojí moje dva oblíbené odkazy: [www.google.com](http://www.google.com/) a [msdn.microsoft.com](http://msdn.microsoft.com/).

MSDN je oficiální dokumentace k většině produktů, které vývojáře mohou zajímat. K dispozici je její [online verze na webu](http://msdn.microsoft.com/library/) a nebo si ji můžete lokálně nainstalovat. Zatímco online verze je od počátku věků zdarma dostupná komukoliv, verze k instalaci byla až dosud za peníze v rámci MSDN Subscription. Nyní si ji celou můžete stáhnout. Pokud se vám ta tři cédéčka stahovat nechce, přijďte na [Developer Days 2006](http://www.microsoft.com/cze/events/developerdays/default.mspx), kdežtě byste je měli jako účastníci dostat ve fyzické podobě.

*   [MSDN Library - May 2006](http://www.microsoft.com/downloads/details.aspx?FamilyId=373930CB-A3D7-4EA5-B421-DD6818DC7C41&displaylang=en) 
*   [SQL Server 2005 Books Online - July 2006](http://www.microsoft.com/downloads/details.aspx?familyid=BE6A2C5D-00DF-4220-B133-29C1E0B6585F&displaylang=en) 

Celkově je milé, že Microsoft pokračuje v nastoupeném trendu a postupně uvolňuje zdarma velké množství pro vývojáře užitečných věcí. Nyní je možné pro Windows a .NET platformu velmi pohodlně vyvíjet i relativně složité aplikace, aniž byste museli za nástroje, dokumentaci, DB stroj a podobně platit.