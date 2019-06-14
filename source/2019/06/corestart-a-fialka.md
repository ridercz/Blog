<!-- dcterms:title = Fialka.net a CoreStart - materiály z konference -->
<!-- dcterms:abstract = Minulý týden se v Praze konala konference CoreStart 3.0, na které jsem přednášel o ASP.NET Identity a kryptografii v .NET Core. Nyní dávám k dispozici prezentace a ukázkovou aplikaci Fialka.net. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20190706-corestart-a-fialka.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20190706-corestart-a-fialka.jpg -->
<!-- x4w:coverCredits = Fichtenspargel via Wikimedia Commons, CC BY-SA -->
<!-- x4w:category = Akce a události -->
<!-- dcterms:dateAccepted = 2019-06-14 -->

Minulý týden se v Praze konala konference CoreStart 3.0, na které jsem přednášel o ASP.NET Identity a kryptografii v .NET Core. Nyní dávám k dispozici prezentace a ukázkovou aplikaci Fialka.net.

## CoreStart 3.0

Konference CoreStart, kterou jsme původně vymysleli pro "restart" uživatelů na .NET Core, měla už třetí verzi. Hlavními hvězdami byli přednášející z Microsoftu, ale i já jsem přispěl dvěma přednáškami. Nyní si můžete stáhnout [prezentace z nich](https://www.cdn.altairis.cz/Blog/2019/20190607-corestart3.zip).

## Fialka.net

Moje druhá přednáška ukazovala kryptografické možnosti v .NET Core 3.0. Zaměřil jsem se na symetrické šifrování, protože .NET Core 3.0 bude konečně podporovat autentizované režimy AES, totiž GCM a CCM. Abych je předvedl, napsal jsem ukázkovou aplikaci. Kromě toho ukazuje i jak v .NET Core generovat náhodná data (klíče) a jak z hesla vygenerovat klíč pomocí algoritmu PBKDF2.

Aplikace se jmenuje Fialka.net a [najdete ji na mém GitHubu](https://github.com/ridercz/Fialka.net).

Jméno je odvozeno od ruského elektromechanického šifrovacího stroje [Fialka (ФИАЛКА)](https://www.cryptomuseum.com/crypto/fialka/), který byl ve druhé polovině 20. století používán ve všech zemích Varšavské smlouvy.