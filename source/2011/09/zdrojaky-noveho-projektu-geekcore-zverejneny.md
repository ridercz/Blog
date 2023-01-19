<!-- dcterms:identifier = aspnetcz#338 -->
<!-- dcterms:title = Zdrojáky nového projektu GeekCore zveřejněny -->
<!-- dcterms:abstract = Když jsem před lety rozjížděl kalendář na akce.altairis.cz, nenapadlo by mne, že během pár let získá skoro 3000 uživatelů a že se stane faktickým centrem komunitních akcí pro geeky na Microsoft platformě. Postupem času systém zastaral a bylo třeba vydat novou verzi. Tu jsem před několika týdny slavnostně zprovoznil na nové adrese www.geekcore.cz. Můj záměr od počátku byl, aby aplikace NemesisEvents, na které GeekCore běží, byla open source a sloužila ostatním k poučení a právě jsem zveřejnil zdrojový kód. -->
<!-- np9:categoryId = 7 -->
<!-- x4w:category = Software -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2011-09-18T21:50:43.243+02:00 -->
<!-- dcterms:date = 2011-09-19T08:00:00+02:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20110919-zdrojaky-noveho-projektu-geekcore-zverejneny.png -->

Když jsem před lety rozjížděl kalendář na webu *akce.altairis.cz*, bylo mým záměrem udělat jednoduchý systém pro sérii pěti seminářů o novinkách v ASP.NET 2.0 (to ten čas letí, co?), který jsme pořádali s dnes již neexistující <span style="text-decoration: line-through;">Windows User Group</span> .NET Group. Nenapadlo mne, že během pár let získá skoro 3000 uživatelů a že se stane faktickým centrem komunitních akcí pro geeky na Microsoft platformě. Jako každý systém, i tento (postavený na ASP.NET 2.0 a SQL 2005) postupem času zastaral a bylo třeba vydat novou verzi. 

Rozhodl jsem se k radikálnímu zásahu a celý systém od základu přepsal pomocí nejaktuálnějších dostupných technologií – ADO.NET Entity Framework, ASP.NET 4.5, HTML 5, jQuery, jQuery UI… Tuto verzi jsem před několika týdny slavnostně zprovoznil na nové adrese [www.geekcore.cz](http://www.geekcore.cz). Podrobnější informace o migraci najdete [na webu samém](http://www.geekcore.cz/wiki/migrace_z_akce_altairis_cz).

## Open source

Mým záměrem od počátku bylo vytvořit open source aplikaci, která bude sloužit i jako ukázka a inspirace pro ostatní vývojáře. Těch několik týdnů běhu posloužilo k vychytání drobných much a tudíž jsem v noci na dnešek zveřejnil první verzi zdrojového kódu. Můžete si ji stáhnout na [http://geekcore.codeplex.com](http://geekcore.codeplex.com).

Další verze budou následovat, mám v plánu při každé větší aktualizaci webu na CodePlexu publikovat aktualizovanou verzi.

## Tak trochu jiné školení

Zveřejněním zdrojového kódu přiběh ale teprve začíná. Okolo GeekCore a procesu jeho vývoje jsem se rozhodl postavit jeden ze svých kurzů v Gopasu. Tak trochu jiný kurz, než je obvykle zvykem.

Většina školení a kurzů se zabývá nějakými konkrétními technologiemi a učí vás, jak je používat. Mou snahou bylo vytvořit jiný kurz: předpokládám, že používané technologie, jako ASP.NET, Entity Framework atd. již znáte a zaměřil jsem se na to, jak je využít v praxi. Zaznamenal jsem celý postup vývoje aplikace a přetransformoval jej do podoby hands-on labu. Vytvořil jsem podrobnou příručku, která vám umožní projít v průběhu kurzu procesem vývoje od začátku do konce.

To je totiž mým hlavním cílem: neukazovat technologie, ale na reálném příkladu předvést, jak se používají v praxi a jak vedou ke konkrétnímu výsledku.

Tento kurz je podle mého názoru vhodný pro dvě skupiny uživatelů: Pokročilí začátečníci, kteří sice vědí, jak psát kód, ale chtějí se naučit triky pro koncepční návrh aplikací s reálnými problémy. A také "staří rutinéři", kteří chtějí pro občerstvení mysli konfrontovat své zažité postupy s jinými názory a také se podívat, jak mohou rutinu usnadnit nové technologie v .NET 3.5/4.0 a Visual Studiu 2010.

Kurz školím v počítačové škole Gopas a má kód [GOC335](http://www.gopas.cz/kurzy/GOC335). Nejbližší běh se bude konat od 10. října v Praze (další je naplánován až na leden příštího roku, ale pokud bude dost zájemců, vyhlásíme nový termín dřív).