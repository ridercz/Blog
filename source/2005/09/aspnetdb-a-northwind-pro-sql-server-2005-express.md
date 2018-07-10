<!-- dcterms:identifier = aspnetcz#49 -->
<!-- dcterms:title = AspNetDb a Northwind pro SQL Server 2005 Express -->
<!-- dcterms:abstract = Dva užitečné datové soubory pro SQL Express -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Tipy, triky -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2005-09-19T22:17:40.733+02:00 -->
<!-- dcterms:dateAccepted = 2005-09-19T22:17:40.733+02:00 -->

Vývojové prostředí Whidbey umožňuje jeden zajímavý trik, kterým je přímé připojení databázového MDF souboru. Pokud máte na klientovi nainstalovaný SQL Server 2005 Express, můžete do adresáře *App_Data* uložit přímo MDF soubor a napojit se na něj tímto connection stringem:

    Data Source=.\SQLEXPRESS;Integrated Security=True;User Instance=True
    AttachDbFilename=|DataDirectory|Northwind.mdf;

Výhoda je především pro vývoj, protože na různé pokusy a testování nemusíte složitě konfigurovat SQLko, ale stačí vytvořit datové soubory (lze přímo z VS.NET nebo VWD). Problém spočívá v tom, že současné verze nástrojů neumožňují - nebo jsem to alespoň neobjevil - pohodlný import dat ze SQL 2000, ani vytvoření "systémové" databáze *AspNetDb*.

Za pomoci "velkého" SQL Serveru 2005 a dalších triků jsem vytvořil dva MDF soubory, které se vám mohou hodit:

*   **[Northwind](https://www.cdn.altairis.cz/Blog/2005/20050919-Northwind.zip)** je klasická Microsoftí ukázková databáze. Hodí se, pokud si chcete něco vyzkoušet a nemáte jiná testovací data. Soubor obsahuje strukturu (tabulky, uložené procedury, pohledy...) i ukázková data (obsah tabulek).
*   **[AspNetDb](https://www.cdn.altairis.cz/Blog/2005/20050919-AspNetDb.zip)** je databáze, obsahující strukturu kterou využívá Membership, Role a Profile provider z Whidbey. Je možno ji vytvořit pomocí utilitky *aspnet_regsql.exe*, ale ta nepodporuje připojení přímo na MDF soubor. Databáze neobsahuje žádná data.