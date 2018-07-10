<!-- dcterms:identifier = aspnetcz#286 -->
<!-- dcterms:title = Altairis Mail Toolkit: mailování z webových aplikací snadno a korektně -->
<!-- dcterms:abstract = Poslat e-mail z .NET aplikace není žádná velká věda. Stačí zavolat System.Net.Mail.SmtpMail.Send. Ale posílat maily způsobem korektním a dlouhodobě udržitelným, to je větší oříšek. Zveřejnil jsem proto open source knihovnu, která řeší obvyklé problémy s tím spojené. -->
<!-- np9:categoryId = 7 -->
<!-- x4w:category = Software -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2010-06-08T02:49:17.17+02:00 -->
<!-- dcterms:dateAccepted = 2010-06-08T02:49:17.84+02:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 130 -->
<!-- x4w:pictureUrl = /perex-pictures/20100608-altairis-mail-toolkit-mailovani-z-webovych-aplikaci-snadno-a-korektne.png -->

Poslat e-mail z .NET aplikace není žádná velká věda. Stačí zavolat *System.Net.Mail.SmtpMail.Send*. Ale posílat maily způsobem korektním a dlouhodobě udržitelným, to je větší oříšek. Zveřejnil jsem proto open source knihovnu, která řeší obvyklé problémy s tím spojené.

Dobrý systém pro rozesílání zpráv by měl mít následující vlastnosti:

*   **Umístění textů e-mailových zpráv mimo kód.** Aby při změně formulace mailu nebylo nutné přepisovat backendový kód. Zároveň je nutné řešit doplňování údajů do relevantních šablon e-mailů.
*   **Jednotný formát všech zpráv.** Společné hlavičky/nožičky napomáhají snadné identifikaci zprávy a třeba i automatickému třídění.
*   **Lokalizace do více jazyků.** Problém komplikuje i to, že mnohdy chceme zprávu odeslat v jiném jazyce, než jaký je aktuálně používán. Např. akce způsobená uživatelem anglické verze se má oznámit uživateli jehož preferovaným jazykem je čeština.
*   **Korektní nastavení hlaviček původce.** Tedy *From*, *Sender* a *Reply-To*.
*   **Rozesílání e-mailů na více adres současně.** Ve většině případů je vhodné maily více příjemcům rozesílat tak, aby o sobě jednotliví příjemci nevědli, tj. aby každý měl vlastní kopii se svou adresou v hlavičce *To*.
*   **Jednoduchost odeslání mailu** z kódu, ideálně na jeden příkaz/řádek.
*   **Centralizace konfigurace**, aby změnu parametrů nebylo nutné provádět na mnoha místech najednou.  

Kromě toho platí vše, co pro .NET aplikace všeobecně. Tedy maximální využití existujících standardů a infrastruktury, což zjednoduší zapojení do existujících struktur.

## Altairis Mail Toolkit

Na základě zkušeností z předchozích projektů jsem vytvořil jednoduchou, ale celkem mocnou, komponentu jménem **Altairis Mail Toolkit**. Je k dispozici včetně zdrojového kódu a dokumentace na [CodePlexu](http://altairismailtoolkit.codeplex.com/). Řeší všechny výše uvedené problémy, s použitím standardních .NETových technik.

Veškeré informace o formátu a textu mailů jsou **uloženy ve standardních resource souborech**. To elegantně řeší veškeré problémy spojené s lokalizací a umístěním textů zpráv mimo kód. Automaticky zajišťuje například možnost, aby text překládal neprogramátor jiným nástrojem, než Visual Studiem.

Samotné rozesílání mailů za nás řeší .NET Framework, stačí ho jenom správně nastavit. Obšírnější pojednání o významu hlaviček *From*, *Reply-To* a *Sender* jest nalézti v [RFC 2822](http://www.ietf.org/rfc/rfc2822.txt) a v poněkud zjednodušené formě jsem jej sepsal na [CodePlexu](http://altairismailtoolkit.codeplex.com/wikipage?title=E-mail%20basics&referringTitle=Documentation) (anglicky).

Konfigurace je řešena pomocí standardního .NET konfiguračního modelu, pomocí vlastní konfigurační sekce *altairis.mailToolkit*.

## Vytváření šablon v resource souborech

Pro každou šablonu, tj. typ odesílaného mailu, je třeba vytvořit dva resource klíče. Jejich názvy začínají názvem šablony a následuje konfigurovatelný suffix – standardně *Subject* pro předmět zprávy a *Body* pro její text.

Šablona může obsahovat placeholdery v klasickém tvaru dle metody *String.Format*, tj *{0}* atd.

Kromě toho mohou existovat ještě další dva resource klíče, opět s konfigurovatelnými názvy, standardně *_SubjectFormat* a *_BodyFormat* (včetně úvodních podtržítek). Ty určují formát celé zprávy (předmětu a těla). Obsahují právě jeden placeholder *{0}*, kam se vloží celý zbytek textu.

Načítání resources z cizí assembly je pravděpodobně technicky nejkomplikovanější úkon, zbytek je technologicky triviální. 

## Odesílání mailů

Vlastní odeslání mailů z kódu realizují dvě metody statické třídy *Altairis.MailToolkit.Mailer*. Jmenují se SendTemplatedMessage a SendTemplatedMessages. Každá z nich má sbírku overloadů pro různé příležitosti, jejichž kompletní dokumentace je k dispozici [online](http://altairismailtoolkit.codeplex.com/wikipage?title=Usage%20from%20code&referringTitle=Documentation).

Pokud použijete overload se specifikací jazyka (*CultureInfo*), použije se příslušně lokalizovaná verze. Pokud je jazyk nastaven na null nebo se použije overload bez jeho určení, použije se aktuální *UiCulture*.

Komponentu **Altairis Mail Toolkit** si včetně zdrojového kódu a dokumentace můžete stáhnout na [altairismailtoolkit.codeplex.com](http://altairismailtoolkit.codeplex.com/).