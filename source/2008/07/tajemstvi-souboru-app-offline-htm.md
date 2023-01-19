<!-- dcterms:identifier = aspnetcz#203 -->
<!-- dcterms:title = Tajemství souboru app_offline.htm -->
<!-- dcterms:abstract = Magické schopnosti souboru app_offline.htm, přítomné v ASP.NET od verze 2.0, vám mohou usnadnit nasazení a upgrade aplikací. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = IT -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2008-07-02T23:08:00.123+02:00 -->
<!-- dcterms:date = 2008-07-02T23:08:00.123+02:00 -->

Tenhle článek jsem se chystal napsat už pěkně dlouho, ale vždycky mi do toho něco vlezlo. Týká se tajemného souboru *app_offline.htm*.

Princip jeho fungování je ve skutečnosti velice prostý. Pokud do rootu webové aplikace umístíte soubor, který se jmenuje *app_offline.htm* (název je nutné přesně dodržet, s jiným to fungovat nebude), stanou se dvě věci:

1.  Ukončí se běh celé aplikace a zruší se její AppDomain. 
2.  Veškeré požadavky, které by aplikace jinak vyřizovala (typicky tedy požadavky na soubory .aspx, .ashx atd.) budou vyřízeny tak, že žadatel obdrží obsah souboru *app_offline.htm*.   

Ukončení aplikace budete typicky využívat v případě, že chcete aplikaci, nebo její části, upgradovat. Uvolní se totiž všechny soubory, které by aplikace mohla používat, uzavřou se všechna databázová spojení atd. Do souboru byste měli též zapsat nějaký smysluplný text, který vašim uživatelům sdělí, že se jedná o plánovaný výpadek a že nemají propadat panice. 

I když informace sama je většinou svou podstatou stručná, velikost souboru by měla být větší než 512 bajtů. Ne z hlediska ASP.NET (aplikaci vám shodí i prázdný soubor, na jeho obsahu nezáleží), ale protože Internet Explorer v případě chybových stavů s odpovědí kratší než 512 bajtů zobrazí svou vlastní generickou chybovou hlášku (obávané “Stránku nelze zobrazit”) a ne vámi definovaný text. Inspiraci můžete načerpat například v [jeho znění na tomto serveru](http://www.aspnet.cz/_app_offline.htm) (mám ve zvyku tento soubor ve všech aplikacích trvale uchovávat a jenom ho přejmenovat, když není třeba, proto to podtržítko na začátku).

Takovéto odstavení aplikace vám také umožní aktualizovat ad-hoc připojený databázový soubor v případě user instance SQL Serveru Express. Ovšem pouze za předpokladu, že jste jejím jediným uživatelem.

Poté, co upgrade dokončíte, stačí soubor *app_offline.htm* smazat a nebo přejmenovat. První další požadavek na danou aplikaci ji znovu nastartuje.