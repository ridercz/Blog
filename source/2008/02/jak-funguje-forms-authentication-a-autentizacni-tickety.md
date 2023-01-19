<!-- dcterms:identifier = aspnetcz#188 -->
<!-- dcterms:title = Jak funguje forms authentication a autentizační tickety -->
<!-- dcterms:abstract = Otázky na forms autentizaci patří na mých kurzech k velmi častým. I místní článek "Forms authentication a session state - proč nejsou synchronní?" vzbudil jistý zájem. Pojďme se tedy podrobněji podívat na to, jak forms authentication funguje, a rozeberme si onen magický autentizační ticket. -->
<!-- np9:categoryId = 2 -->
<!-- x4w:category = Bezpečnost -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2008-02-28T19:51:55.75+01:00 -->
<!-- dcterms:date = 2008-02-28T19:51:55.75+01:00 -->

Otázky na forms autentizaci, její použití a implementaci patří na [mých kurzech](http://www.gopas.cz/kurzy/GOC36/) k velmi častým. I místní článek [Forms authentication a session state - proč nejsou synchronní?](http://www.aspnet.cz/Articles/184-forms-authentication-a-session-state-proc-nejsou-synchronni.aspx) vzbudil jistý zájem. Pojďme se tedy podrobněji podívat na to, jak forms authentication funguje, a rozeberme si onen magický autentizační ticket.

## Co je forms authentication

Většina klasických internetových protokolů je na tom se zabezpečením dosti bídně. Vznikaly totiž v době, kdy Internet byl malý, počítače drahé a lidé si navzájem věřili. Tomu odpovídá i jejich úroveň zabezpečení - většinou statickým heslem, které se přenáší v otevřené podobě. Standard HTTP se v tomto ohledu nijak neliší. Obsahuje popis dvou autentizačních metod - Basic Authentication a Digest Authentication, které se ale v praxi z různých důvodů příliš nepoužívají. 

Drtivá většina dnešních webových aplikací nepoužívá nějaký specifický autentizační protokol, definovaný nějakou normou, ale ověřování uživatelů je součástí jejichy aplikační logiky. Uživatel zadá do formulářových polí své uživatelské jméno a heslo (stejně jako jakákoliv jiná data) a aplikace ho na jejich základě identifikuje, autentizuje a poznačí si ho tak, aby ho příště poznala, až ho zase někde potká.

Pro shora uvedený postup se ve světě ASP.NET vžilo pojmenování Forms Authentication, ačkoliv se nejedná o žádnou přesně popsanou standardní technologii.

Celou autentizaci lze rozdělit na dvě fáze. Ve fázi přihlašování dochází k výměně identifikačních (login, uživatelské jméno...) a autentizačních (heslo, PIN...) údajů ve formě HTTP transakce. Server si zaslané údaje nějak ověří, ve světě ASP.NET patrně využije služeb membership providera, a nazná, že uživatel jest vskutku tím, za koho se vydává.

Autentizační údaje se ale neposílají znovu s každým požadavkem. Následuje fáze druhá, kdy je uživatel nějakým způsobem označen, aby aplikace i při dalším požadavku poznala, s kým má tu čest. Ono označení se děje tak, že se uživateli pošle nějaký údaj, kterým se posléze prokazuje v další komunikaci. Tomuto údaji se obvykle říká token nebo ticket. ASP.NET používá termín "authentication ticket", kterého se budu v následujícím textu držet i já.

Autentizační ticket lze generovat v zásadě dvěma způsoby: buďto mají nebo nemají samy o sobě význam, vnitřní hodnotu.

### Autentizační ticket bez vlastní hodnoty

První varianta je, že autentizační ticket sám o sobě nic neznamená, jedná se jednom o hromádku náhodně vygenerovaných dat. Jedinou podmínkou je, aby byla opravdu náhodná, aby nebylo možné ze znalosti jendoho nebo více platných ticketů zkonstruovat jiný platný. K tomuto účelu byste tedy měli použít kryptograficky bezpečný generátor náhodných čísel (podrobnější informace najdete například v mém článku [Příliš spořádaný svět](http://www.aspnet.cz/Articles/142-prilis-sporadany-svet.aspx)).

Autentizační ticket sám tedy je jenom hromádka bezvýznamných dat, a to, co ho činí důležitým, je existence nějaké centrální databáze, kde je napsáno, že *tahle* hromádka náhodných dat momentálně identifikuje *tohoto* uživatele. Z možnosti mít takovou centrální databázi vyplývají výhody tohoto řešení, z nutnosti ji mít jeho nevýhody.

Velkou výhodou je, že provozovatel služby má absolutní kontrolu nad platností jednotlivých ticketů a bez jakékoliv interakce s klientem může jejich platnost prodlužovat či revokovat. Tak lze uživateli nabídnout bezpečné odhlášení, protože jakmile uživatel klepne na tlačítko "odhlásit", vazba mezi ticketem a uživatelem se prostě bez dalšího zruší.

Nevýhodou tohoto přístupu je, že tuto databázi musíte někde udržovat a že musí být přístupná pro všechny aplikace, které mají ticket akceptovat. To může být problematické v případě distribuovaných single sign-on aplikací a podobně.

### Autentizační ticket s vnitřní hodnotou

Druhý koncept počítá s tím, že ticket je "cenina" sama o sobě, že obsahuje informace potřebné k ověření uživatele. Například vezmete uživatelské jméno, zašifrujete ho, digitálně podepíšete a výsledek použijete jako ticket. Z bezpečnostních i praktických důvodů se zpravidla omezuje doba platnosti ticketu, takže se k uživatelskému jménu ještě přidá čas expirace.

Výhodou je, že k ověření identity pak nepotřebujete žádnou centrální databázi. Stačí ticket vzít, ověřit podpis, dešifrovat, a hned víte, s kým máte tu čest. Na všechny participující serery stačí jenom rozdistribuovat odpovídající klíče a máte vystaráno.

Na druhou stranu, jednou vystavený autentizační ticket nelze vzít zpět, bude prostě platit až do času expirace, děj se co děj (pokud samozřejmě nezměnite šifrovací klíče, čímž ale zneplatníte *všechny* tickety). I pokud se uživatel explicitně odhlásí, jeho ticket nadále platí. Pokud ho někdo zná, může ho použít až do skončení doby jeho platnosti.

## Implementace v ASP.NET

Forms authentication v ASP.NET využívá druhou zmiňovanou možnost, tedy tickety s vnitřní hodnotou. Autentizační ticket obsahuje následující data:

1.  Osm náhodně vygenerovaných bajtů.
2.  Verzi formátu ticketu.
3.  Informaci, zda se jedná o persistent cookie.
4.  Datum a čas vystavení.
5.  Datum a čas expirace.
6.  Uživatelské jméno.
7.  UserData - libovolná data určená programátorem.
8.  Cesta platnosti cookie. 

To celé zašifrované a digitálně podepsané. Autentizační ticket se předává buďto v cookie nebo v URL.

Pokud se uživatel odhlásí, tak se to platnosti ticketu jako takového nijak nedotkne. V případě cookie-less forms auth nebude součástí dalších odkazů. V případě použití cookies se klientovi pošle prázdná cookie téhož jména s časem expirace nastaveným do minulosti, což znamená, že prohlížeč cookie vymaže.

Pokud ale někdo autentizační ticket získal neoprávněně, třeba odposlechem, případně pokud uživatel použije tlačítko zpět, bude znovu považován za přihlášeného, aniž by znovu musel projít přihlašovacím procesem.