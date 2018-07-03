<!-- dcterms:identifier = aspnetcz#46 -->
<!-- dcterms:title = Pozvánka na TechEd Praha 2005 a soutěž o volnou vstupenku! -->
<!-- dcterms:abstract = Gopas & Microsoft TechEd 2005 v Praze je výběr nejzajímavějších přednášek z "velkého" TechEdu. Chcete se podívat? Nabízíme vám volnou vstupenku v ceně 6000 Kč! -->
<!-- np9:categoryId = 6 -->
<!-- x4w:category = Akce a události -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2005-09-12T07:10:45.51+02:00 -->
<!-- dcterms:dateAccepted = 2005-09-12T07:10:45.51+02:00 -->

Pro ty, kdož se z rozličných důvodů nedostali na konferenci Microsoft TechEd 2005 tradičně Microsoft a Počítačová škola Gopas pořádají akci nazvanou [Gopas & Microsoft TechEd 2005](http://www.teched.cz/) v Praze. Jedná se o výběr nejzajímavějších přednášek z "velkého" TechEdu.

Letos se koná 19-23. září, tedy příští týden. Kompletní program najdete na [oficiálním webu](http://www.teched.cz/program.htm), ale patrně nikoho nepřekvapí, že vývojářská sekce je věnována převážně nadcházející verzi .NET 2.0 "Whidbey". Kromě přednášek je užitečnou částí i zóna "ask the expert", kde máte po přednášce možnost klást všetečné otázky všeho druhu (tematické!) předtím se exhibujícímu expertovi.

Nezanedbatelná část TechEdu bude věnována i webovým technologiím a prezentace nezanedbatelné části této části leží na mých bedrech. Pro úvod do světa ASP.NET 2.0 jsem zvolil tři přednášky:
 <ul> <li><strong>WEB323 - Overview of ASP.NET 2.0</strong>   
<em>(úterý, 10:30-11:45) </em>Základní seznámení s technologií ASP.NET 2.0, představení možností. Spousta demo ukázek a příkladů ke stažení! <li><strong>WEB327 - Best Practices for Building Web Application UI with Master Pages, Themes and Site Navigation</strong>   
<em>(středa, 10:30-11:45) </em>Co oko nevidí, sice srdce nebolí, ale co oko vidí, musí někdo naprogramovat. Whidbey umožňuje dosud nejpropracovanější oddělení grafiky od dat, a některé novinky, dosud u vývoje webových aplikací nevídané. <li><strong>WEB340 - IIS7: Discover and Move to the Next Generation Web Application Server Platform</strong>  
<em>(čtvrtek 10:30-11:45) </em>A na závěr, pohled do budoucnosti poněkud vzdálenější, na následující verzi Internet Information Services. Jako malou ochutnávku doporučuji přečíst si dříve zde vydaný článek [IIS 7: Per aspera ad astra](/entry/article-20050112.aspx).</li></ul> <h2>Soutěž o volnou vstupenku</h2> 

Běžný [registrační poplatek](https://www.microsoft.cz/akce/teched2005/) na pražský TechEd je "baťovských" 5 990 Kč, DPH v to nepočítaje. Díky velkorysosti hlavního pořadatele, [počítačové školy Gopas](http://www.gopas.cz/), mohu na ASPNET.CZ vyhlásit soutěž. Hlavní výherce obdrží zdarma volnou vstupenku na akci, a druhý vylosovaný získá firemní tričko [Altair Communications](http://www.altaircom.net/).

Abyste měli šanci na výhru, stačí jenom zadat svou e-mailovou adresu a požadovanou velikost trička. Ale protože ASPNET.CZ čtou programátoři (a jim je také určena vývojářská část TechEdu), rozhodl jsem se vás neponižovat triviálním webovým formulářem, takže své údaje musíte zadat pomocí web services rozhraní.
 <h2>Jak na to?</h2> 

Na adrese [http://web.aspnet.cz/TechEdSoutez/Service.asmx](http://web.aspnet.cz/TechEdSoutez/Service.asmx) najdete webovou službu, která poskytuje dvě metody (obě lze volat pouze metodou SOAP, prosté HTTP GET či POST požadavky ani nezkoušejte).

V první fázi zavolejte metodu <em>StepOne</em>, a jako parametr jí předejte svou e-mailovou adresu a požadovanou velikost trička. Metodat vrací řetězec, buďto "OK" v případě úspěchu a nebo informaci o chybě. Jakmile se tak stane, webová služba vám obratem pošle na zadanou e-mailovou adresu zprávu, obsahující vygenerovaný kontrolní řetězec.

Ve druhé fázi zavolejte metodu <em>StepTwo</em>, které jako parametry předáte shora uvedeným způsobem získaný potvrzující řetězec, své ctěné jméno a telefonní číslo. I tato metoda vrací řetězec, odpověď "OK" znamená, že jste byli úspěšně zařazeni do zpracování, v opačném případě dostanete chybové hlášení.

Každou e-mailovou adresu můžete zadat jenom jednou. Pokusy o automatizované hlasování (generované adresy atd.) budou detekovány a ze soutěže vyřazeny.

Oba dva kroky musíte stihnout do zítřejší půlnoci (14. 09. 2005, 00:00), poté web service přestane přijímat data. Ve středu 14. vylosujeme výherce a budu je kontaktovat telefonicky. Pokud se mi s výhercem nepodaří spojit, bude vylosován náhradník, takže ve vlastním zájmu berte telefony :-)

Jsem zvědav, kolik účastníků soutěž přiláká :-)