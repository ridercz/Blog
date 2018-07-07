<!-- dcterms:identifier = riderweblog#38 -->
<!-- dcterms:title = Různé kódování češtiny -->
<!-- np9:categoryId = 2 -->
<!-- x4w:category = Lidé a jiná zvěř -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2003-04-04T15:32:31+02:00 -->
<!-- dcterms:dateAccepted = 2003-04-04T15:32:31+02:00 -->

Naivně jsem předpokládal, že bude stačit, když své stránky dám k dispozici ve standardizovaném kódování UTF-8 a poradí si s tím všechna mobilní i nemobilní zařízení.

Díky [eLKa](http://www.elka.cz/edenik/), který byl tak laskav a na svém Palmu otestoval výše zmiňované mobilní rozhraní, jsem zjistil, že tomu tak není. Jeho Palm si s UTF-8 neporadil.

V levé části stránky nyní najdete menu, ve kterém si můžete přepnout kódování pro web. Pro PDA je nutno upravit URL, a to tak, že na konec přidáte parametr "*c=XXX*", kde "*XXX*" je patřičné kódování:

*   **UTF-8:** [http://weblog.rider.cz/mobile/?c=utf](http://weblog.rider.cz/mobile/?c=utf)
*   **ISO 8859-1:** [http://weblog.rider.cz/mobile/?c=asc](http://weblog.rider.cz/mobile/?c=asc)
*   **ISO 8859-2:** [http://weblog.rider.cz/mobile/?c=iso](http://weblog.rider.cz/mobile/?c=iso)
*   **Windows-1250:** [http://weblog.rider.cz/mobile/?c=win](http://weblog.rider.cz/mobile/?c=win) 

Kdyby nic, tak kódování ISO-8859-1 by mělo fungovat snad všude, protože neobsahuje speciální české znaky s nabodeníčky. Neřeknete-li jinak, bude se vše prezentovat v UTF-8.

Pro správný provoz je nutné, aby vaše zařízení podporovalo cookies. Jsem v dané chvíli příliš líný, než abych přepisoval všechny linky a přidával k nim informaci o kódování, nebo to řešil nějak jinak.