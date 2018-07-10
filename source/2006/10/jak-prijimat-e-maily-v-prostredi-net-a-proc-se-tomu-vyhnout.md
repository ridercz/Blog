<!-- dcterms:identifier = aspnetcz#118 -->
<!-- dcterms:title = Jak přijímat e-maily v prostředí .NET a proč se tomu vyhnout -->
<!-- dcterms:abstract = Nejpoužívanější službou internetu není kupodivu WWW, ale elektronická pošta: e-mail. Zatímco odesílání e-mailových zpráv z prostředí ASP.NET je jednoduché, se zpracováváním příchozích mailů to už není ani zdaleka tak snadné. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Tipy, triky -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2006-10-29T18:23:00.253+01:00 -->
<!-- dcterms:dateAccepted = 2006-10-29T18:23:00.253+01:00 -->

Nejpoužívanější službou internetu není kupodivu WWW, ale elektronická pošta: e-mail. Zatímco odesílání e-mailových zpráv z prostředí ASP.NET je jednoduché, se zpracováváním příchozích mailů to už není ani zdaleka tak snadné.

## Povaha elektronické pošty

Řada problémů, na které při plnění shora naznačeného úkolu narazíme, má svůj původ v tom, že - jak je ostatně v případě komunikačních technologií obvyklé - při tvorbě standardů elektronické pošty nikdo nepředpokládal, jaké obliby jeho vynález dosáhne. Internetová elektronická pošta je založena především na protokolech SMTP, POP3 a MIME. Ty byly vytvořeny v době, kdy počítače byly dřevěné a šlapací a jsou navrženy pro komunikaci lidí s lidmi, nikoliv počítačů s počítači.

Výtečně je rozdíl mezi protokoly určenými pro lidi a pro počítače vidět třeba na rozdílu mezi [RFC2822](http://www.ietf.org/rfc/rfc2822.txt) (norma popisující vnitřní formát e-mailových zpráv) a normami SOAP založenými na XML. RFC2822 je navržena pro komunikaci mezi lidmi, zprávy jsou pro člověka v zásadě čitelné i bez speciálního klienta a jejich formát je jenom velmi obecně omezující. Oproti tomu SOAP protokoly jsou navrženy tak, aby je dokázaly snadno a efektivně zpracovat počítače a běžným smrtelníkům jsou nesrozumitelné.

Rozparsovat e-mailovou zprávu na jednotlivé komponenty je tedy úkol nejednoduchý: protokoly samy o sobě jsou implementačně složité a navíc je řada klientů houfně nedodržuje. Psaní MIME parseru se tak podobá spíše psaní heuristického expertního systému, který se snaží ze zmatené hromádky bajtů vyvěštit, co chtěl odesílatel říci.

Pro předávání dat mezi aplikacemi je tedy běžný e-mail zcela nevhodný a je lepší použít kanály k tomuto účelu určené, např. SOAP over HTTP, neboli web services.

## Když musíš, tak musíš

Existují ovšem případy, kdy je nutné e-mailové zprávy zpracovávat. Například pokud chcete požadavky přijaté na adresu typu *support@firma* zadávat do nějakého systemizovaného helpdesku a podobně.

V takovém případě lze přijmout dva modely práce s došlými zprávami: synchronní a asynchronní.

V případě synchronního modelu se došlé zprávy zpracovávají v reálném čase: událost příchodu zprávy na poštovní server způsobí spuštění nějakého kódu, který zprávu zpracuje. V tomto případě potřebujete nutně mít kontrolu nad příslušným mail serverem a musíte mu svou aplikaci přizpůsobit. 

Některé poštovní servery umožňují při příjmu zprávy spustit program (EXE soubor), kterému se nějakou formou předají informace o zprávě. Příkladem takového programu je například [XMail Server](http://www.cz.xmailserver.org/) a jeho filtry. Jiné programy mají svůj vlastní model událostí, do nějž může být možné váš program zařadit, viz např.[event sink model u Microsoft Exchange](http://support.microsoft.com/kb/313404).

Při synchronním zpracování je nutné počítat s tím, že zpráv může najednou přijít velké množství. Ať už "legitimních", nebo "nelegitimních" - spam, chybová hlášení a podobně. Váš program tedy musí být připraven na to, že bude v jednom okamžiku běžet několik jeho kopií a měl by fungovat dostatečně efektivně, aby příliš nezdržoval hostitelský počítač.

V případě asynchronního modelu jsou zprávy normálně doručovány do poštovní schránky a jsou z ní jednou za čas načítány a zpracovávány. Načítání se může dít přes síť, pomocí běžného protokolu POP3 nebo IMAP. Většina poštovních serverů také funguje tak, že zprávy pro jednoho uživatele ukládá do nějakého adresáře jako samostatné soubory a můžete je odtamtud načítat.

Výhodou tohoto řešení je, že je do jisté míry nezávislé na konkrétním poštovním serveru, stačí jenom mít někde počítač, na kterém poběží stahovací služba.

## Formát zpráv

Vlastní načtení zprávy je ta jednodušší část. Pokud máme štěstí, tak ji poštovní server za nás už rozparsoval a můžeme k ní přistupovat pomocí nějakého objektového modelu - tak funguje třeba Microsoft Exchange. Pokud takové štěstí nemáte, dostanete zprávu ve formátu dle shora uvedené RFC2822 nebo formátu jemu velmi podobnému a je na vás, abyste zprávu zpracovali a vyčetli z ní, co potřebujete.

Což želbohu není úkol příliš jednoduchý, protože možných kódování a formátů je příliš mnoho. Pokud je to jenom trochu možné, omezte se na parsování hlaviček, protože tam je kreativita tvůrců poštovních programů dost omezena: načítání hlaviček jako adresa odesílatele, příjemce nebo předmět (subject) je vcelku bezproblémové.

Pokud jste nuceni zabývat se obsahem zprávy (nebo nedejbože přílohami) začíná celá řada zajímavých problémů, na které se vás snaží v úvodu [RFC2045](http://www.ietf.org/rfc/rfc045.txt) nevtíravě upozornit i sami její autoři:

> Several of the mechanisms described in this set of documents may seem somewhat strange or even baroque at first reading. It is important to note that compatibility with existing standards AND robustness across existing practice were two of the highest priorities of the working group that developed this set of documents. In particular, compatibility was always favored over elegance.

Od snahy psát vlastní MIME parser bych laskavé čtenáře rád odradil - vycházeje přitom z vlastních zkušeností, které nelze nazvat jinak, než jako bolestné. Je mnohem rozumnější (a v konečné důsledku též obvykle lacinější) zakoupit hotovou komponentu, například:

*   [Rebex Mail for .NET](http://www.rebex.net/mail.net/)

*   [/n software IP*Works](http://www.nsoftware.com/)