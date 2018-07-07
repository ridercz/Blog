<!-- dcterms:identifier = aspnetcz#293 -->
<!-- dcterms:title = Lokalizace vývojových nástrojů v podání Microsoftu -->
<!-- dcterms:abstract = Vyhodnocení ankety z minulého týdne, jakož i další postřehy k tématu lokalizace vývojových nástrojů. -->
<!-- np9:categoryId = 7 -->
<!-- x4w:category = Software -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2010-08-04T00:31:00.847+02:00 -->
<!-- dcterms:dateAccepted = 2010-08-04T00:31:03.58+02:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20100804-lokalizace-vyvojovych-nastroju-v-podani-microsoftu.png -->

Microsoft ve spolupráci s VŠB-TU Ostrava připravil lokalizaci uživatelského rozhraní Visual Studia 2010 Professional (můžete si ji stáhnout zdarma na [http://www.msdn.cz/vscz/](http://www.msdn.cz/vscz/)). Pokračuje tak v tradici nastolené už balíkem [Captions Language Interface Pack](http://blogs.msdn.com/b/vyvojari/archive/2008/11/04/captions-language-interface-pack-v-1-0-for-visual-studio-2008.aspx) pro VS 2008. Na smysluplnost nastoleného trendu lokalizace mám svůj názor, ale než jej začnu hlásat, chtěl jsem znát postoj ostatních.

## Výsledky ankety

Proto jsem před týdnem [vyhlásil anketu](http://www.aspnet.cz/articles/292-jake-jazykove-verze-pouzivate-soutez-o-visual-studio-2010), v níž jsem se ptal na to, jak vnímáte při programování jazyky. Ankety se zúčastnilo celkem 327 z vás a zde jsou výsledky.

V první řadě mne zajímalo, jaké jazykové verze operačního systému, kancelářského balíku a dalších programů používáte, jaké byste používat chtěli a kdo rozhoduje o tom, jakou jazykovou verzi software budete na svém PC mít nainstalovanou.

[![anketa_idealni](https://www.cdn.altairis.cz/Blog/2010/20100804-anketa_idealni_thumb.png "anketa_idealni")](https://www.cdn.altairis.cz/Blog/2010/20100804-anketa_idealni_2.png)

[![anketa_skutecny](https://www.cdn.altairis.cz/Blog/2010/20100804-anketa_skutecny_thumb.png "anketa_skutecny")](https://www.cdn.altairis.cz/Blog/2010/20100804-anketa_skutecny_2.png)

[![anketa_rozhoduje](https://www.cdn.altairis.cz/Blog/2010/20100804-anketa_rozhoduje_thumb.png "anketa_rozhoduje")](https://www.cdn.altairis.cz/Blog/2010/20100804-anketa_rozhoduje_2.png)

Odpovědi na první tři otázky naznačují, že vývojáři si ve většině případů jazykovou verzi vybírají sami. V případě operačního systému je podpora národních jazyků proti angličtině zhruba půl na půl. Kancelářský balík je většinou požadován v češtině, ostatní programy v angličtině. Je zajímavé, že u OS i Office je podíl lokalizovaných verzí vyšší, než by si uživatelé přáli – projevuje se zde patrně ona čtvrtina vývojářů, u kterých o jazykové verzi rozhoduje někdo jiný.

Dále pak mne zajímalo, jaké používáte jazyky při programování, při psaní kódu a komentářů.

[![anketa_jazyk_kodu](https://www.cdn.altairis.cz/Blog/2010/20100804-anketa_jazyk_kodu_thumb.png "anketa_jazyk_kodu")](https://www.cdn.altairis.cz/Blog/2010/20100804-anketa_jazyk_kodu_2.png)

Pro pojmenovávání tříd, proměnných a podobně drtivá většina z vás používá angličtinu, ale (pro mne) překvapivě velké množství lidí píše komentáře v národním jazyce.

Poslední a z mého pohledu nejzajímavější je téma používání lokalizací VS 2008 a VS 2010:

[![anketa_lokalizace_2008](https://www.cdn.altairis.cz/Blog/2010/20100804-anketa_lokalizace_2008_thumb.png "anketa_lokalizace_2008")](https://www.cdn.altairis.cz/Blog/2010/20100804-anketa_lokalizace_2008_2.png)   

 [![anketa_lokalizace_2010](https://www.cdn.altairis.cz/Blog/2010/20100804-anketa_lokalizace_2010_thumb.png "anketa_lokalizace_2010")](https://www.cdn.altairis.cz/Blog/2010/20100804-anketa_lokalizace_2010_2.png)   
Nadpoloviční většina všech dotázaných obě verze lokalizace nepoužívá a ani tak nehodlá činit. Existující lokalizace používá okolo 4% dotázaných, dalších zhruba 15% jim je ochotno dát šanci a vyzkoušet je.   

### Výherce losování

Abych anketu učinil atraktivnější, jeden z vás vyhrál Visual Studio 2010 Ultimate s ročním předplatným MSDN. Oním šťastlivcem je **Tomáš Hájek** ze společnosti **Crespo**. Výherce jsem již kontaktoval e-mailem, doufám, že se mi ozve zpátky.

## Můj názor

Pokud se jazykových verzí týče, jsem fundamentalista. Veškerý software na počítači mám v angličtině, používám jenom české regionální nastavení (formáty data, času a podobně) a mám nainstalovaný do Office český spellchecker. Chápu nicméně, že pro většinu běžných uživatelů je překlad běžných programů nutnost a nebo alespoň velký přínos. Lokalizace vývojových nástrojů do tak minoritního jazyka, jako je čeština, ovšem napáchá dle méh soudu víc škody než užitku.

Většina programátorů lokalizaci používat nebude, což ostatně vyplývá i z výsledků ankety. To znamená, že programátor, který se bude ptát užívaje českých výrazů, které mu bude nabízet Visual Studio, bude za exota a ostatní programátoři (z logiky věci ti zkušenější, víc schopní poradit) mu nebudou rozumět, protože oni to mají jinak.

Dále pak, pokud náš nebohý začínající programátor bude hledat nějaké informace, bude to mít těžší, protože i když bude hledat v článcích českých autorů, relevantní informace budou stejně používat anglické pojmy. Od informací v jiných jazycích (většina jich je anglicky) bude odstřižen úplně. Najít informaci o přičině chybové hlášky v češtině je často skoro nemožné, když zadám totéž hlášku v angličtině, mám mnohem větší šanci na úspěch.

Vzhledem k tomu, že lokalizovaná je jenom malá část, s češtinou si programátor nevystačí tak jako tak a vyhledávání informací v té nelokalizované většině mu to jenom zkomplikuje. Reálná cílová skupina jsou tak začátečníci a hobby programátoři.  Když jsem o téhle anketě říkal lidem z českého DPE, dostalo se i přesně téhle odpovědi: že na ASPNET.CZ chodí zkušení programátoři a že pro ně ta lokalizace není určená. A že začátečníci a koníčkáři lokalizaci ocení.

Pokud je lokalizace určena začátečníkům, pak nechápu, proč je lokalizovaná jenom edice Professional. U začátečníků a koníčkářů se dá mnohem pravděpodobněji předpokládat, že budou používat Express edice, které si kdokoliv může stáhnout zdarma. Zbývají nám možná tak studenti středních a vysokých škol, kteří si mohu stáhnout Professional edici zdarma v rámci programu [DreamSpark](http://www.dreamspark.cz/). Nicméně u studentů středních a vysokých škol se zájmem o programování lze myslím dost oprávněně předpokládat znalost angličtiny na úrovni umožňující používání Visual Studia v angličtině.

Lokalizace Express nástrojů je ale hodně omezená, jsou kromě angličtiny dlouhodobě k dispozici jenom v hlavních šesti jazycích (FR, DE, IT, JP, RU, ES). Předpokládám, že česká lokalizace je technicky realizovaná způsobem, který nelze použít na Express edici, která nepodporuje pluginy. To je ale problém Microsoftu samotného. Uznávám, že ho nedokáže vyřešit česká pobočka, jejíž autonomie v rozhodování sahá asi tak k možnosti určit barvu toaletního papíru.

Microsoft vydal beta verzi nového nástroje jménem [WebMatrix](http://www.microsoft.com/web/webmatrix/download). Narozdíl od Visual Studia není WebMatrix přímo určen k vývoji aplikací (i když i to v něm lze činit), ale spíš pro případ, kdy chcete stáhnout, upravit a nasadit již hotovou aplikaci, z web applications gallery. To je přesně ten typ úkolů, které dělá "ten pán přes počítače" v menší firmě, a pro který by bylo docela rozumné mít lokalizovaný nástroj. Zda bude WebMatrix lokalizován se ovšem zatím neví. Doufám, že ano.

Poněkud absurdní příchuť celému lokalizačnímu divadlu dodává skutečnost, že Microsoft již řadu let neposkytuje žádný nástroj pro fulltextové vyhledávání v češtině. Poslední dostupný je český stemmer pro 32-bitovou edici SQL Serveru 2005, licencovaný od externí firmy. Na novějších verzích SQL Serveru nebo na 64-bitové platformě (a aktuální verze serverových OS se již 32-bitové nedělají) nefunguje. České tvarosloví neumí ani Bing, což vede k absurdní situaci, kdy pro vyhledávání na tomto webu používám Google, protože lepší varianta prostě není. Nebylo by lepší energii a peníze věnovat buďto vytvoření vlastního jazykového modulu a nebo třeba opět licencování nějakého již existujícího? Znám řadu lidí, kteří opečovávají staré SQL Servery 2005 jenom kvůli fulltextu.

Smysl této lokalizační operace mi tedy uniká. Lokalizovat vývojové nástroje má smysl možná do pár hlavních jazyků, kde je velká vývojářská komunita. U malých jazyků má smysl lokalizovat maximálně obsah, vzdělávací materiály. Čímž rozhodně nemyslím strojové překlady MSDN, které jsou nesrozumitelné a v nemalém procentu případů věcně špatné.