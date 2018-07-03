<!-- dcterms:identifier = aspnetcz#215 -->
<!-- dcterms:title = TechEd Developers 2008: Den druhý až čtvrtý -->
<!-- dcterms:abstract = Konečně jsem získal dostatek času, abych sepsal zážitky z druhého až čtvrtého dne TechEdu. -->
<!-- np9:categoryId = 6 -->
<!-- x4w:category = Akce a události -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2008-11-14T00:39:55.69+01:00 -->
<!-- dcterms:dateAccepted = 2008-11-14T00:39:55.69+01:00 -->

Konečně jsem získal dostatek času, abych sepsal zážitky z druhého až čtvrtého dne TechEdu.

## Internet Explorer 8

Smíšené pocity mám z Internet Exploreru 8. Líbí se mi vylepšení renderovacího engine a podobně. Smíšené pocity mám z různých vychytávek UI, jako například web slices, activities a podobně. Na první pohled to vypadá úžasně, ale tak nějak se nemohu naučit to používat (IE8 mám už delší dobu nainstalovaný). Nevím, zda jsem příliš konzervativní nebo jak, ale jediné funkce svého prohlížeče, které používám, jsou adresní řádek, back, forward, stop a reload.

Výtečnou novinkou v IE8 je InPrivate browsing. Na jedno kliknutí se vám otevře nové okno, které nic nezaznamenává, neukládá historii, cache, všechno se smaže při zavření okna prohlížeče. Ideální pro páchání trestné činnosti a zejména pro různé návštěvy a práci na ne_zcela_důvěryhodných_počítačích. Jako jsou příkladně ty na CommNetu, veřejně přístupné stroje, kterých jsou po CCIB rozmístěny stovky. Hojně je používám, protože můj notebook je se svými rozměry a váhou spíše převozný než přenosný, takže si ho nechávám v hotelu, a já se připojuji k webovému rozhraní Exchange. Na počítačích je IE8 a já důsledně používám InPrivate.

Provoz InPrivate režimu je indikován poměrně výraznou ikonou v adresním řádku. Když procházím kolem nekonečných řad počítačů, obsazených vývojáři z celé Evropy, nemohu se ubránit pohledu na jejich monitory. Je fascinující, že většina z nich dělá poměrně citlivé činnosti (jako například přihlašování do webmailu a podobně), ale InPrivate nepoužívá téměř nikdo. Obecně, adopce propagovaných technologií je překvapivě nízká. Každý tady má PDA a většina (mini)notebooky. Vypadá to místy jako mezinárodní sraz uživatelů Asus EEE PC. Nicméně přesto s sebou většina lidí nosí objemnou bichli s programem a poznámky si dělá na papír. V čem je asi chyba? A je to vůbec chyba?

## "Geneva" server, framework a CardSpace

Hlavním lákadlem celého TechEdu je pro mne samozřejmě projekt Geneva. Lapidárně řečeno, nová verze ADFS, CardSpace a ještě něco navíc. Generace "Geneva" má být ve finální verzi k dispozici ve druhé polovině příštího roku a vypadá velmi, velmi slibně. Rozdíl mezi současnou verzí těchto technologií a Genevou je asi jako mezi .NET Frameworkem 1.0 a 2.0.

O těchto věcech tady obšírně psát nebudu, toho si užijete do sytosti na přednáškách a článcích, až se vrátím do Prahy.

## .NET Framework 4.0

O nové verzi .NET Frameworku se hovoří hodně a obšírně. Některé věci mě naplňují nadšením, některé děsem. Mezi ty děsivé patří zejména plíživé prorůstání dynamických jazyků do C#, čímž se eminentně zvyšuje nebezpečí, že se z něj stane write-only jazyk. Z novinek subjektivně vybírám:

Mechanismus pro explicitní určení klientského ID prvku (užitečné pro klientský JavaScript).

Lepší renderování prvků, s ohledem na HTML (už aby to bylo).

Vylepšení Entity Frameworku – entity mohou být jakékoliv třídy, nevyžadují podědění či speciální intrerface. Nový EF bude umět lazy loading a bude mít lepší podporu pro práci s uloženými procedurami a funkcemi. Takže bude konečně použitelný stejně snadno, jako LINQ-to-SQL.

Předělaná logika viewstate. V současné verzi není možné ho by default vypnout na úrovni stránky/aplikace a zapnout jenom pro konkrétní prvky. Pokud chcete ViewState někde používat a někde ne, musíte ho na všech ostatních prvcích kromě vybraných explicitně zakázat, místo abyste ho explicitně povolili tam, kde ho chcete. Nový .NET Framework bude obsahovat podporu pro opačný scénář, že ViewState bude jenom tam, kde si ho výslovně vyžádáte.

AJAX kam se podíváš. Podpora konzumace REST datových služeb (ATOM feedy) z JavaScriptu a obousměrný databinding na straně klienta. Na jednu stranu je to velmi působivé a rozhodně čistší, než současný ASP.NET AJAX. Na stranu druhou od JavaScriptu uživatele tolik neodstiňuje a při špatné implementaci (kterých bude přehršel) je zaděláno na bezprecedentní bezpečnostní díry.

Příští verze bude také projednou "opravdová" verze, tj. nikoliv nadstavba nad runtime verze 2.0. Zda je to dobře nebo špatně, těžko říct, ale určitě to bude přehlednější, než teď, kdy většina lidí neví, do které verze či service packu která technologie patří.

Těmto změnám sekundují i odpovídající změny Visual Studia 2010. Pokud vás to zajímá, můžete si novinky osahat na CTP verzi, která je volně k dispozici v podobě [Virtual PC image](http://go.microsoft.com/fwlink/?LinkId=129231 "Visual Studio 2010 and .NET Framework 4.0 CTP").

## Sladký život na obláčku

Nejoblíbenější buzz-words letošního TechEdu jsou pojmy jako "mesh", "cloud computing" a Windows Azure. U posledních dvou jmenovaných chápu alespoň princip. Jsem sice velmi, velmi skeptický k tomu, že firmy budou nadšeně přesouvat kritické služby do imaginárního obláčku kdesi v Microsoftím datacentru v Chicagu, ale kdo ví. Koně jsou obecně přízemní, konzervativní a paranoidní stvoření. Nechodíme s hlavou v oblacích a zraky upřenými na azurovou oblohu.

Co je to mesh jsem nepochopil ani po několika přednáškách a půlhodinové diskuzi s managerem projektu. Toho mé neustálé dotazy "a k čemu je to vlastně dobré", dohnaly téměř k slzám. Lépe řečeno, co je mesh vím, ale nenašel jsem praktické využití a všechny uváděné příklady by bylo možné dle mého názoru mnohem efektivněji využít méně exotickými technologiemi.

Poslední den TechEdu začal přes 38 minutami a dojmy z něj vám sdělím zase někdy večer.