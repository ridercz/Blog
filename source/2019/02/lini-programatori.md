<!-- dcterms:title = Líný programátor - dobrý programátor: Akce pro ně -->
<!-- dcterms:abstract = V jedné staré písničce, populární v dobách mého mládí, se zpívá, že práce je matka pokroku. Můj názor je přesně opačný. Matkou všího pokroku je lidská lenost, snaha práci si pokud možno zjednodušit nebo se jí vyhnout úplně. Kdyby pračlověk Janeček nebyl líný každý večer lézt na strom, nikdy by se nebyl odvážil vlézt do temné jeskyně nebo experimentovat s něčím tak nebezpečným, jako je oheň. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20190211-lini-programatori.png -->
<!-- x4w:coverUrl = /cover-pictures/20190211-lini-programatori.jpg -->
<!-- x4w:coverCredits = OIST via Flickr, CC-BY -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = IT -->
<!-- x4w:category = Akce a události -->
<!-- dcterms:dateAccepted = 2019-02-11 -->

V jedné staré písničce, populární v dobách mého mládí, se zpívá, že práce je matka pokroku. Můj názor je přesně opačný. Matkou všího pokroku je lidská lenost, snaha práci si pokud možno zjednodušit nebo se jí vyhnout úplně. Kdyby pračlověk Janeček nebyl líný každý večer lézt na strom, nikdy by se nebyl odvážil vlézt do temné jeskyně nebo experimentovat s něčím tak nebezpečným, jako je oheň.

Absence lenosti a velká příchylnost k práci může být naopak jevem dosti problematickým. Ve výše zmíněných dobách se také říkalo, že aktivní blbec je horší než třídní nepřítel. Terminologie se sice poněkud změnila (i když při pohledu na naši politickou scénu se nelze ubránit podezření že toliko dočasně), leč obsah sdělení zůstává nezměněn. A u programování to platí stejně. Začasté vídám při konzultacích systémy, u nichž říkám "ale to muselo dát _strašné práce_" a nemyslím to jako pochvalu. Příliš pracovitý programátor může být dokonalá pohroma.

Základní myšlenka je zhruba následující: naprostá většina programátorů a naprostá většina aplikací neřeší žádné problémy _computer science_. Minimálně 80 % aplikací je významných především tím, že _nic nedělá_, že je to jenom hezké rozhraní k databázi. Scott Hanselmann tomu říká "textboxes over data - the most elusive problem of computer science". Málokdy je třeba vytvořit něco skutečně originálního, většinou stačí aplikovat některé z osvědčených, standardizovaných řešení. I v té menšině aplikací, které něco dělají, většina kódu řeší zase ty textboxes over data.

Pracovitý programátor při psaní takových aplikací napíše spoustu kódu. A to je problém, protože hodně kódu znamená hodně chyb. Překlepy, nekonzistence, na něco se zapomene… Líný programátor za sebe nechá pracovat stroj a použije nějaký udělátor - statický nebo dynamický generátor kódu a podobně. Tím si ušetří práci a nervy. Se psaním kódu, jeho laděním, pozdějšími změnami, hledáním chyb… Ušetří nervy i uživatelům, neboť vygenerované rozhraní bude konzistentní a bude se tedy jednoduše ovládat.

---

**ASP.NET Core nabízí celou řadu nástrojů k dynamické tvorbě uživatelského rozhraní. A spousta o nich mnoho neví. Proto jsem se rozhodl uspořádat akci s pracovním názvem [ASP.NET Core pro líné programátory](https://aspnetcore.updatedays.cz/). Bude se konat v Praze již tento čtvrtek a pátek a ještě jsou na ní nějaká volná místa.**

První den jsem si vzal celý pro sebe a kromě úvodní přednášky o obecně pokročilých možnostech ASP.NET Core Razor Pages bude celý věnován svaté trojici líného programátora:

* Dynamické generování uživatelského rozhraní na základě metadat; jak to dělat automaticky a jak ovlivnit, jak to bude vypadat.
* Dynamické a automatické generování oněch metadat.
* Lokalizace ASP.NET Core aplikací, protože psát a udržovat aplikace lokalizované do několika jazyků je pracné a únavné, takže je žádoucí to nějak zjednodušit.

Druhý den pak bude věnován technologii DotVVM, která je pro pohodlí líných programátorů LOB aplikací přímo navržená.
