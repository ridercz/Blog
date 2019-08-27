<!-- dcterms:title = Live coding: Vlastní password validátor v ASP.NET Core Identity -->
<!-- dcterms:abstract = Rozhodl jsem se napsat vlastní validátor síly hesel pro ASP.NET Core Identity. A říkám si, že to bude zajímavější, když to budu živě přenášet na YouTube. Založím nový projekt na GitHubu, napíšu validátor a vypublikuji ho jako NuGet balíček. Alespoň tedy takový je plán, ale v živém přenosu se to může rychle změnit... -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/logo-youtube.svg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20190827-live-coding.jpg -->
<!-- x4w:category = Bezpečnost -->
<!-- x4w:category = IT -->
<!-- dcterms:dateAccepted = 2019-08-27 -->

Rozhodl jsem se napsat vlastní validátor síly hesel pro ASP.NET Core Identity. A říkám si, že to bude zajímavější, když to budu živě přenášet na YouTube. Založím nový projekt na GitHubu, napíšu validátor a vypublikuji ho jako NuGet balíček. Alespoň tedy takový je plán, ale v živém přenosu se to může rychle změnit...

## Co budu programovat

K napsání vlastního validátoru mne přimělo několik věcí. V první řadě to, že většina validátorů (včetně toho výchozího v ASP.NET Identity) je napsaná špatně. Při volbě hesla uživatele šikanuje příliš a zbytečně. No a pak mne inspirovalo několik článků:

* **[Creating a validator to check for common passwords in ASP.NET Core Identity](https://andrewlock.net/creating-a-validator-to-check-for-common-passwords-in-asp-net-core-identity/)** tohle je dobrý validátor, který ověřuje heslo proti seznamům nejběžněji používaných ([GitHub](https://github.com/andrewlock/CommonPasswordsValidator/tree/master/src/CommonPasswordsValidator/PasswordLists)).
* **[I've Just Launched "Pwned Passwords" V2 With Half a Billion Passwords for Download]** (https://www.troyhunt.com/ive-just-launched-pwned-passwords-version-2/#cloudflareprivacyandkanonymity) tohle je služba Troye Hunta, provozovatele [Have I Been Pwned](https://haveibeenpwned.com/), která umožňuje prohledávat uniklá hesla.

Rád bych napsal validátor, který bude tyto dvě funkcionality kombinovat.

## Kdy a kde to bude k vidění?

Celou akci budu živě streamovat na našem YouTube kanálu. Adresa streamu je [https://youtu.be/t_ZleMiX_z8](https://youtu.be/t_ZleMiX_z8).

Stream se bude konat zítra, tedy ve středu **28. srpna 2019 od 20:00** dokud neskončím. Vstup zdarma, jste srdečně zváni :-)
