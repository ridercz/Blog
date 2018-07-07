<!-- dcterms:identifier = aspnetcz#115 -->
<!-- dcterms:title = Altairis Simple ASP.NET SQL Providers ke stažení -->
<!-- dcterms:abstract = Provider object model v ASP.NET 2.0 představuje velký krok kupředu proti verzi 1.x. Vestavěné SQL providery jsou ovšem pro většinu aplikací prakticky nepoužitelné, protože vyžadují velice specifickou databázovou strukturu. Napsal jsem si vlastní providery, které nejsou sice tak univerzální, ale zato používají jednoduchou databázovou strukturu, propojitelnou snadno se zbytkem vaší databáze. -->
<!-- np9:categoryId = 7 -->
<!-- x4w:category = Software -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2006-10-12T17:38:56.717+02:00 -->
<!-- dcterms:dateAccepted = 2006-10-12T17:38:56.717+02:00 -->

Provider object model v ASP.NET 2.0 představuje velký krok kupředu proti verzi 1.x. Vestavěné SQL providery jsou ovšem pro většinu aplikací prakticky nepoužitelné, protože vyžadují velice specifickou databázovou strukturu.

Hlavním motivem při tvorbě vestavěných providerů (jejichž [zdrojové kódy jsou mimochodem volně dostupné](http://weblogs.asp.net/scottgu/archive/2006/04/13/442772.aspx)) byla naprostá univerzálnost. Databáze je tedy "rozkročena" velice široce, umožňuje uchovávat jakýkoliv serializovatelný typ v profilech, údaje více nezávislých aplikací v jedné struktuře tabulek a podobně.

## Altairis Simple ASP.NET SQL Providers

Knihovna **Altairis Simple ASP.NET SQL Providers** obsahuje tři providery:

*   *Altairis.Web.Providers.SimpleSqlMemebrshipProvider* - membership provider pro správu uživatelů
*   *Altairis.Web.Providers.SimpleSqlProfileProvider* - profile provider pro uchovávání dalších údajů o uživatelích
*   *Altairis.Web.Providers.SimpleSqlRoleProvider* - role provider pro správu rolí a členství uživatelů v nich

Moji provideři nejsou tak univerzální jako ty vestavěné. Nepodporují např. anonymní profily, mají pouze některé typy vlastností v profilech, neumí blokování účtů nebo více nezávislých aplikací v jedné databázi). Hlavním motivem při *jejich* tvorbě byla nicméně snadná integrace se zbytkem databázové struktury libovolné aplikace.

Membership a Profile provider si vystačí každý s jednou tabulkou, Role provider potřebuje dvě. Ze shora uvedených důvodů nepoužívám ani uložené procedury a podobně. Rovněž je snadné tuto strukturu upravit, případně do ní přidat vlastní pole, které vaše aplikace využívá.

## Release Candidate 1 a CodePlex

[![CodePlex](https://www.cdn.altairis.cz/Blog/CodePlex.jpg) ](http://www.codeplex.com/Wiki/View.aspx?ProjectName=AltairisWebProviders)

Od samého počátku bylo mým záměrem tuto knihovnu zveřejnit, ale neustále jsem nebyl schopen k nim napsat nějakou dokumentaci a zejména udržovat publikovanou verzi projektu v aktuálním stavu. Microsoft nicméně spustil nový komunitní projekt **[**CodePlex**](http://www.codeplex.com/)**, kde existuje infrastruktura, která by mi tento úkol měla značně ulehčit.

Tyto providery již delší dobu úspěšně používám na řadě svých projektů (včetně toho na který se právě díváte nebo známého webu [akce.altairis.cz](http://akce.altairis.cz/)). Většina chyb by tedy měla být již vychytána.

*   [**Stažení poslední verze** ](http://www.codeplex.com/Release/ProjectReleases.aspx?ProjectName=AltairisWebProviders)(včetně dokumentace a příkladů)
*   [**Issue tracker** ](http://www.codeplex.com/WorkItem/List.aspx?ProjectName=AltairisWebProviders)(hlášení chyb a feature requestů)

Můj plán je neomezovat se pouze na české vývojáře, pište proto prosím v angličtině. Pokud máte zájem podílet se na vývoji, i to je možné. Knihovna je zveřejněna pod [Microsoft Shared Source Permissive License (MS-PL)](http://www.codeplex.com/Project/License.aspx?ProjectName=AltairisWebProviders), což znamená, že její zdrojový kód můžete upravovat a šířit.