<!-- dcterms:identifier = aspnetcz#39 -->
<!-- dcterms:title = Jak úspěšně provozovat ASP.NET 1.1 a 2.0 B2 na jednom stroji -->
<!-- dcterms:abstract = Návod na testování Whidbey aplikací souběžně s verzí 1.1 -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Tipy, triky -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2005-06-12T07:23:59.137+02:00 -->
<!-- dcterms:dateAccepted = 2005-06-12T07:23:59.137+02:00 -->

Pokud chcete provozovat na jednom serveru ASP.NET verze 1.1 a 2.0 Beta 2 (Whidbey), je to možné. Mapování jednotlivých verzí ve struktuře IIS (na jednotlivé virtuální servery a adresáře) je na sobě naprosto nezávislé. Jedinou podmínkou je, že různé verze nemohou běžet v jednom <em>Application Poolu</em>.

Postup je tedy následující:
 <ol> <li>V IIS Manageru vytvořte nový application pool. Ve stromu vlevo klepněte pravým tlačítkem na <em>Application Pools</em> a v menu zvolte <em>New > Application Pool</em>. Ponechte defaultní nastavení a pojmenujte ho třeba <em>WhidbeyAppPool</em>.</li> <li>Vytvořte nový virtuální web server (adresář). Poté si otevřete jeho vlastnosti. Na záložce <em>Home Directory</em> zvolte v listboxu dříve vytvořený pool. Dále pak na záložce ASP.NET (objeví se při instalaci Whidbey runtime) zvolte jako <em>ASP.NET version</em> 2.0.50215.0 (nebo takovou jakou máte nainstalovanou).</li></ol> 

V tomto okamžiku je už všechno nastaveno a patřičný web bude fungovat pod runtime 2.0, všechno ostatní pojede na stávající 1.1 verzi.