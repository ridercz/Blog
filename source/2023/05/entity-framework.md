<!-- dcterms:title = Entity Framework Core 7.0: Novinky, tipy, triky -->
<!-- dcterms:abstract = Entity Framework je nejpoužívanější object/relational mapper pro .NET. Připravil jsem pro vás seriál videí o novinkách v aktuální verzi 7.0, ale i s různými tipy a triky, které sice nejsou vždy úplně nové, ale hodí se je znát. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:coverUrl = /cover-pictures/20230502-entity-framework.jpg -->
<!-- x4w:pictureUrl = /perex-pictures/20230502-entity-framework.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = IT -->
<!-- dcterms:date = 2023-05-02 -->

Entity Framework je nejpoužívanější object/relational mapper pro .NET. Připravil jsem pro vás seriál videí o novinkách v aktuální verzi 7.0, ale i s různými tipy a triky, které sice nejsou vždy úplně nové, ale hodí se je znát.

## EF Core Database First a Code Second

Mnoho lidí si myslí, že EF Core podporuje jenom přístup _code first_, kdy je databáze vytvořena podle modelu v C# kódu. To je zdaleka nejpopulárnější přístup u vývoje nových aplikací, ale není to povinné. EF Core umí _database first_: vzít existující databázi a vygenerovat z ní objektový model na straně .NETu. To se hodí v případech, kdy do databáze nemůžete zasahovat, je spravována někým jiným a vy ji můžete pouze využívat jak je. Anebo prostě tehdy, kdy chcete databázi vytvářet a udržovat mimo svůj .NET kód.

Často se hodí i přístup _code second_. Při něm automaticky vygenerujete model odpovídající existující databázi a poté převezmete její správu, jako kdyby se jednalo o code first. Pro další údržbu a změny tak můžete použít migrace v EF Core.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/spv-dt5u9Ig" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

## Novinky v EF Core 7.0

První užitečnou novinkou jsou JSON columns. V relačních databázích typicky data ukládáme normalizovaně, každý kousek v samostatném chlívečku. Nicméně někdy dává smysl kusy struktury ukládat v jednom databázovém poli, třeba jako data serializovaná do JSON. Zjednodušuje to databázovou strukturu i SQL dotazy a může to i zrychlit práci s daty. EF Core to v Microsoft SQL Serveru nyní nativně podporuje. Nejlepší na tom je, že SQL Server umožňuje i dotazování do JSON datové struktury, takže lze vytvářet i dotazy, které to dělají. Není to ale ani moc vhodné ani moc rychlé.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/UumW4ZBBhJM" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

Jednou ze slabin Entity Frameworku dlouho byla nemožnost hromadných operací. Pokud jste potřebovali aktualizovat nebo smazat více položek, muselo se to dělat po jednom. EF Core 7 přidává metody `ExecuteUpdate` a `ExecuteDelete`, které tento problém elegantně řeší: můžete určit podmínku a vykonávanou operaci a vše se provede pomocí `WHERE` klauzule na straně serveru.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/60PJAuUCiQY" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

Entity Framework je založen na konvencích. "Pokud se vlastnost jmenuje `Id` nebo `NázevEntityId`, tak to bude asi primární klíč" a podobně. V EF7 máte možnost tyto konvence ovlivnit a sami vytvářet. Ukážu vám, jak si vytvořit vlastní konvenci na omezení délky řetězce.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/vNr3lNuUzuk" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

V předchozích verzích EF jste museli při vytváření instance třídy `DbContext` vždy určit connection string. EF 7 vám ale umožní vytvořit instanci bez connection stringu - ten se načte až při jejím použití. K čemu je to dobré? Pro psaní multi-tenant aplikací. Tedy takovoých, kde každý "nájemce" má svoje data a nastavení, ale aplikace běží v jediné instanci. Toto video je docela dlouhé, ale ukáže vám kompletní postup s využitím nové feature lazy connection strings:

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/OM5Ztps0Hkc" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

## Uložené procedury

Úvodní video této subsérie je poněkud dlouhé a poněkud teoretické. Pokládám ale za nutné zmínit, proč uložené procedury (ne)používat. S dotazy na téma zda a jak EF Core podporuje uložené procedury se setkávám dosti často. Zeptám-li se ale na to, jaké uložené procedury lidé používají a proč, dostávám dost nepřesvědčiné odpovědi. Mnoho důvodů je zastaralých a dnes již neplatných. Další pak ukazují, že vývojový postup daného projektu trpí fundamentálními nedostatky a použití uložených procedur je možná dokáže maskovat, ale ne vyřešit. No a někde jsou "storky" a jejich používání prostě projevem cargo kultu a fetišismu. Těmito špatnými důvody pro použití uložených procedur se zabývám v následujícím videu - no a taky přidávám pár těch dobrých, kdy použití uložených procedur i dnes dává smysl.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/-InpOnVwtMs" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

Častým přístupem (ne vždy smysluplným) je, že se uložené procedury používají pro změny dat (místo příkazů `INSERT`, `UPDATE` a `DELETE`) a pro načítání dat se používá příkaz `SELECT`. EF Core 7 nativně podporuje mapování operací pro vytváření změny a mazání dat na uložené procedury a v tomto videu vám ukážu, jak to využít.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/P9YOU2YPlyM" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

Poslední z trojice videí věnovaných uloženým procedurám popisuje, jak můžete volat libovolné vlastní uložené procedury pohodlně z C#. Slouží k tomu metoda `FromSql`, která umí vykonat jakýkoliv SQL dotaz a volitelně jeho výsledek namapovat na datové entity.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/3pOg16uNs4c" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

## Máte nějaké otázky?

Tímto pokládám téma Entity Frameworku Core až na další za uzavřené, nenapadají mne další témata. Můžete to ale změnit: pokud máte nějaké dotazy nebo náměty, napište mi je do komentářů pod video a je možné, že mne inspirujete k natočení dalšího videa!
