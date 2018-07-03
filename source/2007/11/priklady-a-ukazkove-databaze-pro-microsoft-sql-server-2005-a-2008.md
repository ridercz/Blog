<!-- dcterms:identifier = aspnetcz#170 -->
<!-- dcterms:title = Příklady a ukázkové databáze pro Microsoft SQL Server 2005 a 2008 -->
<!-- dcterms:abstract = Doba, kdy součástí každé instalace databázového serveru byly ukázkové databáze pubs a Northwind naštěstí již dávno skončila. Ukázkovou databázi AdventureWorks si nyní musíte stáhnout a nainstalovat zvlášť, nachází se na CodePlexu. -->
<!-- np9:categoryId = 7 -->
<!-- x4w:category = Software -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2007-11-27T02:56:26.633+01:00 -->
<!-- dcterms:dateAccepted = 2007-11-27T02:56:26.633+01:00 -->

Doba, kdy součástí každé instalace databázového serveru byly ukázkové databáze `pubs` a `Northwind` naštěstí již dávno skončila. Ukázkovou databáze `AdventureWorks` si nyní musíte stáhnout a nainstalovat zvlášť. O škodlivosti předinstalovaných příkladů by se dalo napsat mnohé. Ostatně, kdo spravoval IIS 4.0 mi jistě dá za pravdu, že pokud jeden ručně neodstranil z produkčního serveru příklady, děly se podivuhodné věci - protože příklady obsahovaly roztomilou sbírku bezpečnostních chyb.

U SQL Serveru o žádných konkrétních nevím, leč jistě nejsem sám, kdo si svého času myslel, že databáze jménem `pubs` je - stejně jako `master`, `model`, `msdb` a `tempdb` - cosi systémového, na co by běžný smrtelník raději neměl sahat.

V případě SQL Serveru 2005 a 2008 si musíte příklady explicitně stáhnout a nainstalovat, prahnete-li po nich. Ta správná adresa je [http://codeplex.com/SqlServerSamples/](http://codeplex.com/SqlServerSamples/ "http://codeplex.com/SqlServerSamples"). Najdete na ní kompletní sbírku příkladů pro rozličné funkce SQL Serveru a rovněž několik verzí databáze `AdventureWorks`.

Novinkou, alespoň tedy pro mne, je zjednodušená databáze `AdventureWorksLT`. Má mnohem jednodušší strukturu a také objem - stahujete dvě mega místo třiceti.

Upozorňuji, že instalace vám jenom datové soubory nakopíruje na správné místo (typicky do složky `C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Data`), ale neattachne je, takže nebudou v SQL Serveru vidět. Musíte si je tedy připojit ručně, případně je zkopírovat do aplikačního adresáře a attachnout přes user instance.