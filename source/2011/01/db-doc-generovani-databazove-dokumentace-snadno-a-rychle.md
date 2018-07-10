<!-- dcterms:identifier = aspnetcz#315 -->
<!-- dcterms:title = DB>doc: generování databázové dokumentace snadno a rychle -->
<!-- dcterms:abstract = Pro jeden projekt, na kterém momentálně pracuji, jsem hledal nástroj, který by mi umožnil snadno vygenerovat dokumentaci k používaným databázovým objektům. Zejména tedy k čemu jsou dobré jednotlivé tabulky a jaký význam mají jejich sloupečky. Použitelné řešení jsem nenašel, tak jsem si jedno napsal. A nyní jej dávám k dispozici i vám. -->
<!-- np9:categoryId = 7 -->
<!-- x4w:category = Software -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2011-01-27T01:34:29.46+01:00 -->
<!-- dcterms:dateSubmitted = 2011-01-27T01:35:00.973+01:00 -->
<!-- dcterms:dateAccepted = 2011-01-27T01:37:38.787+01:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20110127-db-doc-generovani-databazove-dokumentace-snadno-a-rychle.png -->

Pro jeden projekt, na kterém momentálně pracuji, jsem hledal nástroj, který by mi umožnil snadno vygenerovat dokumentaci k používaným databázovým objektům. Zejména tedy k čemu jsou dobré jednotlivé tabulky a jaký význam mají jejich sloupečky. Bohužel jsem takový nástroj nenašel. Vytváření komentářů je v SQL serveru poměrně snadné, jde to dělat snadno třeba z databázového diagramu. Ale potom s těmi komentáři nějak rozumně pracovat, na to jsem dobré řešení nenašel. Zkoušel jsem databázové diagramy ve Visiu a podobných nástrojích, nicméně ty se zaměřují spíše na popisování vztahů mezi jednotlivými entitami, než na popisy jejich obsahu, tedy co je tam konkrétně za sloupečky a především, co se očekává, že budou obsahovat za hodnoty.

Našel jsem spoustu obludně složitých nástrojů, ale nic, co by mne uspokojilo. Naštěstí je ale poměrně snadné napsat nástroj, který zmapuje strukturu předhozené mu databáze a načte související komentáře. Výsledek pak může vypadat nějak takto:

[![20110127-dbdoc](https://www.cdn.altairis.cz/Blog/2011/20110127-20110127-dbdoc_thumb.png "20110127-dbdoc")](https://www.cdn.altairis.cz/Blog/2011/20110127-20110127-dbdoc_2.png)

## DB>doc for Microsoft SQL Server

Napsal jsem jednoduchou utilitku, která se ovládá z příkazové řádky a přesně tohle dokáže. Zmapuje tabulky, pohledy a vztahy mezi nimi a vygeneruje XML dokument, který obsahuje všechny potřebné informace. Výstup je pak k dispozici v několika různých formátech:

*   **XML** – původní XML dokument, který můžete použít pro další zpracování, například pomocí XSLT transformací. Program sám obsahuje dvě transformace, které umožňují výstup v dalších dvou formátech.
*   **HTML** – výsledkem této transformace je HTML dokument, který obsahuje informace o všech tabulkách. Funguje interaktivně, foreign klíče vedou na odkazované tabulky a obsahuje dostatek prostoru pro komentáře. Zároveň je tento dokument optimalizován pro tisk, takže jej lze použít pro tvorbu dokumentace buďto tištěné a nebo třeba v PDF nebo XPS.
*   **WikiPlex** – třetí formát, do nějž lze dokumentaci exportovat, je textový dokument s wiki syntaxí projektu [WikiPlex](http://wikiplex.codeplex.com/). Tento formát používá třeba populární server [CodePlex](http://www.codeplex.com/), ale je snadné jej zahrnout i do vlastních projektů.  

K dispozici je též [ukázka dokumentace](http://sqldbdoc.codeplex.com/wikipage?title=Sample%20Output&referringTitle=Home) vygenerované pro populární databáze Northwind a AdventureWorks. Vzhledem k použité technologii XSL transformací je možné tyto šablony snadno modifikovat nebo vytvářet nové, podle požadavků daného projektu.

Podstatné je, že žádnou dokumentaci není nutné vyvíjet zvlášť, všechno je drženo v rámci SQL serveru samotného a jeho metadat. 

Mým současným požadavkům aplikace vyhovuje, přestože neumí dokumentovat třeba uložené procedury, já je beztak moc nepoužívám, obecně dávám přednost řešení na straně .NETu. Nicméně, pokud bude mít někdo zájem, je možné jej o tyto a další možnosti snadno rozšířit, infrastruktura je ta. Podporovaná platforma je Microsoft SQL Server 2008 a 2008 R2. Nástroj by měl nicméně fungovat i proti SQL Azure nebo proti SQL Serveru 2005, ačkoliv jsem to zatím ještě netestoval.

**DB>doc for Microsoft SQL Server** si můžete stáhnout na adrese [sqldbdoc.codeplex.com](http://sqldbdoc.codeplex.com). Program je licencován pod Ms-PL (Microsoft Public License) a k dispozici jsou tedy i jeho zdrojové kódy pro další vývoj či inspiraci.