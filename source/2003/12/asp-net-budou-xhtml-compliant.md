<!-- dcterms:identifier = riderweblog#113 -->
<!-- dcterms:title = ASP.NET budou XHTML Compliant! -->
<!-- np9:categoryId = 2 -->
<!-- x4w:category = Lidé a jiná zvěř -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2003-12-19T14:36:55+01:00 -->
<!-- dcterms:dateAccepted = 2003-12-19T14:36:55+01:00 -->

Před nějakou dobou jsem objevil, že psát stránky jako valid HTML se vyplatí - člověk pak zhusta nemusí řešit problémy s kompatibilitou v různých prohlížečích, pomineme-li prohlížeče z doby kamenné, jako např. Netscape 4.x.

Poté, co jsem většinu svých webů přepsal a vybavil ikonkou "Valid HTML 4.01", přišly ASP.NET. A ty se vydaly jinou cestou: místo generování validního HTML kódu a spoléhání na to, že si to klient nějak přebere, si zjistí typ prohlížeče a vygenerují nějaké svinstvo, které sice nemá se standardem nic společného, ale onen konkrétní browser ho zobrazí.

U nových projektů, založených na ASP.NET jsem tedy s těžkým srdcem myšlenku validního HTML opustil, protože výhody vývoje ASP.NET převážily.

Nyní se na [weblogu ScottGu](http://weblogs.asp.net/scottgu/posts/39620.aspx) dozvídám, že Whidbey (nová verze) bude umět generovat výstup kompatibilní s HTML 1.1 a dokonce i s [WCAG](http://www.w3.org/TR/WCAG/). Tyto vlastnosti budou zapnuté by default, z čehož vyplývá, že pravděpodobně přibude mnoho lépe napsaných webů.

Jsem jenom zvědav na reakci jistého typu zavile antimicrosoftích linuxáků, resp. na způsob, jakým i tuto flagrantní podporu otevřených standardů překroutí a prohlásí za další důkaz všeobecné zkaženosti a zlovolnosti M$ a útok na hodnoty které my, slušní lidé, vyznáváme.