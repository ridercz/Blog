<!-- dcterms:identifier = aspnetcz#77 -->
<!-- dcterms:title = Tajemství souboru app_offline.htm - snadný upgrade aplikací v ASP.NET 2.0 -->
<!-- dcterms:abstract = Jak snadno aktualizovat ASP.NET aplikaci, včetně výměny SQL Express databází? Použijte jednoduchý trik se souborem app_offline.htm -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = IT -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2006-02-23T00:46:27.777+01:00 -->
<!-- dcterms:dateAccepted = 2006-02-23T00:46:27.777+01:00 -->

Často je potřeba aktualizovat běžící aplikaci. Pokud vám na ni chodí pět lidí za den, není to velký problém, prostě se stará data přepíší novými. Pokud je ale aplikace navštěvovanější, začínají problémy. Soubory jsou zamčené a není možné je přepsat, u větších updatů může dojít ke zmatení aplikace, o uživateli nemluvě a podobně.

Dobrodružné povahy použivající v ostrém provozu *user instance* SQL Serveru 2005 Express navíc musejí řešit problém s výměnou datových souborů MDF/LDF, k nimž je nemožno se za běhu dostat atd.

Řešení spočívá v souboru `app_offline.htm`. Pokud v rootu své webové aplikace vytvoříte soubor s tímto názvem, celá .NET aplikace se zastaví. Zruší se její aplikační doména (AppDomain) a v důsledku toho se též odpojí všechny připojené databázové soubory a zruší user instance.

Všechny požadavky na danou aplikaci směřované pak budou zodpovězeny zasláním obsahu tohoto souboru - měli byste do něj tudíž umístit nějakou vysvětlující zprávu v duchu, že právě probíhá aktualizace.

Pokud tento soubor smažete (nebo přejmenujete), při prvním dalším požadavku se aplikace normálně nastartuje.

Tuto funkcionalitu využívá interně i VS 2005 / VWD ve své funkci "copy project" potažmo "publish web site".

Až někdy přijdete na ASPNET.CZ a uvidíte [tento text](/_app_offline.htm), tak vězte, že je způsoben právě tím, že jsem při aktualizaci takto aplikaci dočasně zakázal.