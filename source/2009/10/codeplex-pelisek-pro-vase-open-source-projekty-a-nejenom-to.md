<!-- dcterms:identifier = aspnetcz#240 -->
<!-- dcterms:title = CodePlex: Pelíšek pro vaše open source projekty (a nejenom to) -->
<!-- dcterms:abstract = Můj psíček (fena československého vlčáka, kterou možná znáte z některých mých akcí) s oblibou lehává buďto v mé posteli a nebo na dlaždičkách v předsíni – podle toho, jaká panuje venku teplota. Oficiální pelíšek sice má, ale využívá ho jenom, když si myslí, že se na ni nikdo nedívá. Pokud by ale Esta byla open source projektem, jistě by si bez váhání za svůj pelíšek zvolila server CodePlex. -->
<!-- np9:categoryId = 7 -->
<!-- x4w:category = Software -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2009-10-05T18:40:00+02:00 -->
<!-- dcterms:dateAccepted = 2009-10-05T18:40:00+02:00 -->

[![20090403-170540-0000_jpg](https://www.cdn.altairis.cz/Blog/2009/20091005-20090403-170540-0000_jpg_thumb.jpg "20090403-170540-0000_jpg")](https://www.cdn.altairis.cz/Blog/2009/20091005-20090403-170540-0000_jpg_2.jpg) Můj psíček (fena československého vlčáka, kterou možná znáte z některých mých akcí) s oblibou lehává buďto v mé posteli a nebo na dlaždičkách v předsíni – podle toho, jaká panuje venku teplota. Oficiální pelíšek sice má, ale využívá ho jenom, když si myslí, že se na ni nikdo nedívá. Pokud by ale Esta byla open source projektem, jistě by si bez váhání za svůj pelíšek zvolila server [CodePlex](http://www.codeplex.com).

CodePlex je open source repository, něco podobného jako SourceForge a nebo Google Code. Provozuje ho Microsoft a interně běží na Team Foundation Serveru. K čemu je takový server dobrý? Poskytuje vývojářům a uživatelům aplikací infrastrukturu k vývoji a publikování aplikací, hlášení chyb a problémů a tvorbu dokumentace. Ať už OSS projekty vytváříte, užíváte, nebo se k tomu chystáte, stojí CodePlex za pozornost.

## CodePlex pro uživatele

Většina aplikací na CodePlexu není určena pro běžné koncové uživatele. Zpravidla se jedná o komponenty, utility a nástroje pro programátory a IT profesionály. Těch tam ale najdete nepřeberné množství – jedná se pravděpodobně o nejobsáhlejší zdroj na Internetu pro MS platformu. Většina projektů zde hostovaných je postavena na .NET Frameworku, ale jsou zde i jiné.

Pokud tedy jako programátor nebo administrátor hledáte nějakou komponentu či nástroj, doporučuji začít právě zde. V procházení projektů podle kategorií a nebo fulltextovým vyhledáváním. Jako na každém podobném serveru samozřejmě platí, že velká část projektů jsou rozdělané a dávno opuštěné plány. Nicméně sama skutečnost, že v projektu nedošlo za delší dobu k žádné změně není na závadu. Je možné, že projekt dosáhl jistého stupně vyspělosti, umí všechno, co si jeho autoři přejí a není nutné jej dále rozvíjet.

Vzhledem k tomu, že zde publikované projekty jsou open source, je ke všem z nich dostupný zdrojový kód, který můžete použít pro inspiraci při vývoji vlastních programů. Pokud se setkáte s problémy, můžete pomocí záložky Issues nebo diskusního fóra zjistit, zda tentýž problém neřeší i někdo jiný, případně nahlásit chybu vývojářům.

Pro všechny položky jsou k dispozici RSS feedy a (pokud se zaregistrujete) i e-mailová notifikace. Můžete se pomocí nich například dozvěděl o nové verzi (v žargonu CodePlexu "release") aplikace, kterou používáte.

## CodePlex pro vývojáře

Vývojářům open source aplikací nabízí CodePlex výtečnou infrastrukturu pro vývoj vlastních aplikací. Pro mne bylo právě spuštění CodePlexu impulsem pro převedení řady mých aplikací a komponent pod Open source licenci. Snahy software prodávat jsem už víceméně vzdal. A publikovat open source vlastními silami je poněkud vyčerpávající – a tady právě CodePlex může pomoci.

V první řadě slouží jako code repository, k němuž lze přistupovat pomocí Subversion a nebo TFS. Nabízí vám tedy bezpečné úložiště kódu, včetně verzování a týmové spolupráce více členů, klidně i v různých koutech světa. Použité protokoly TFS i SVN běží nad HTTPS, takže přístup je bezpečný a univerzální odkudkoliv. Klienti pro obě platformy jsou volně dostupní a lze je i vzájemně kombinovat. Při týmovém vývoji tak každý může používat, na co je zvyklý, já svou oblíbenou kombinaci TortoiseSVN a AnkhSVN, někdo jiný zase Team Client.

Checkout (zkopírování zdrojáků ze serveru na lokální stroj) může provést kdokoliv anonymně, checkin (nebo update, prostě nahrání dat na server) pak jenom oprávněný uživatel, který byl zařazen mezi vývojáře správcem projektu. Kterýkoliv registrovaný uživatel pak může pomocí webového rozhraní nahrávat tzv. patche – svoje návrhy na opravy či úpravy, které pak kmenoví vývojáři mohou zahrnout do kódu. Repository je dostupná i z běžného webového prohlížeče (záložka *Source Code*) a lze se tedy snadno podívat do kódu i cizího projektu, na konkrétní soubor.

Jednou za čas je dobré vydat novou verzi aplikace. V terminologii CodePlexu se jí říká "release" a ukazuje se na odpovíddající záložce. Hotovou aplikaci (případně další balíčky, jako dokumentaci a příklady) můžete publikovat dle potřeby. Release lze nastavit i jako "planned", tedy připravovanou verzi, do které pak mají přístup jenom členové vývojového týmu. Ostatní uživatelé mohou releases hodnotit a komentovat.

Pomocí záložky *Issue Tracker* lze sledovat "work items" – hlášení chyb, problémů a náměty. CodePlex umožňuje Issues různě zpracovávat a třídit. Stejně jako releases, i work items mohou uživatelé hodnotit a komentovat. Vývojáři se k nim pak vyjadřovat, zavírat je a přiřazovat konkrétním členům týmu. Lze také work items přiřazovat ke konkrétnímu release, který je opravuje či bude opravovat. Na nově přišedší work items můžete být upozorňováni i e-mailem.

Větším projektům se může hodit i diskuzní fórum, které se skrývá za záložkou *Discussions*. Pro jednotlivé projekty ho lze i zakázat, já tak zpravidla činím, protože pro projekty mého rozsahu stačí dle mého soudu work items.

Poslední důležitou funkcí je Wiki. Pomocí ní publikujete obecné informace o projektu a můžete jej využít i k tvorbě dokumentace. To je obvykle dosti bolestivé místo open source projektů, protože dokumentaci se nechce nikomu psát. Wiki na CodePlexu se vám snaží teno nelehký úkol pokud možno usnadnit.

## Jak se přidat

Pokud chcete na CodePlex přidat svůj projekt, je to jednoduché. Stačí se [zaregistrovat](http://www.codeplex.com/site/project/create) a [založit nový projekt](http://www.codeplex.com/site/project/create). Získáte vlastní adresu odpovídající názvu projektu (např. [http://codeplex.com/AltairisWebSecurity/](http://codeplex.com/AltairisWebSecurity/) nebo [http://altairiswebsecurity.codeplex.com/](http://altairiswebsecurity.codeplex.com/) – funguje obojí). Po založení máte měsíc na to, abyste projekt naplnili nějakým počátečním obsahem a publikovali jej. Dokud je projekt nepublikovaný, nemá k němu přístup nikdo kromě vývojářů.

Abyste mohli CodePlex pro svůj projekt používat, musíte zvolit některou z [podporovaných open source licencí](http://codeplex.codeplex.com/Wiki/View.aspx?title=CodePlex%20FAQ#License). Já obvykle používám Microsoft Public License, ale můžete použít i GPL nebo jiné.

### Moje projekty na CodePlexu

*   [Altairis Identity Toolkit](http://altairisidtoolkit.codeplex.com/) 
*   [Altairis Web Security Toolkit](http://altairiswebsecurity.codeplex.com/) 
*   [Altairis Web UI Controls](http://altairiswebui.codeplex.com/) 
*   [Nemesis Gallery](http://nemesisgallery.codeplex.com/) 
*   [Nemesis Switchboard](http://nemesisswitchboard.codeplex.com/) 
*   [RSS To Frame](http://rssframe.codeplex.com) 
*   [Sigma ASC 105 Control Library](http://sigmaasc105lib.codeplex.com/)  

U výše uvedených projektech se chystám v dohledné době trochu víc psát a představit vám je. Přidáte se?