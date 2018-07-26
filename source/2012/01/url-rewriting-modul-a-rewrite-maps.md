<!-- dcterms:identifier = aspnetcz#364 -->
<!-- dcterms:title = URL rewriting modul a rewrite maps -->
<!-- dcterms:abstract = Pro Martina Pavlise jsem řešil migraci jeho blogu ze SubTextu na Nemesis a narazil jsem na problém zachování stávajících odkazů pro velké množství článků. Typický úkol pro URL rewriting modul v IIS a RewriteMaps. -->
<!-- np9:categoryId = 4 -->
<!-- x4w:category = IT -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2012-01-15T21:22:38.917+01:00 -->
<!-- dcterms:dateAccepted = 2012-01-15T21:22:40+01:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20120115-url-rewriting-modul-a-rewrite-maps.png -->

Podobnou situaci jsme zažili asi všichni: je třeba přejít na jiný systém a migrovat data. Jenomže s novým systémem se často mění i adresy – URL, na kterých se obsah nachází. Pokud je nový systém hodně konfigurovatelný a nebo psaný na zakázku, dá se to vyřešit vcelku snadno, ale co když není, nebo co když má prostě nový systém úplně odlišnou logiku? 

Dostal jsem se přesně do téhle situace, když jsem migroval [blog Martina Pavlise](http://www.pavlis.net) ze SubTextu na Nemesis. SubText a Nemesis mají úplně jinou logiku generování adres článků, která je vzájemně nekompatibilní (SubText používá kombinaci datumu a titulku článku, Nemesis ID a titulek). Přitom zachování funkčnosti původních adres je žádoucí až nezbytné (typicky např. u adres, které konzumují roboti, ne lidé, jako RSS feedy atd.).

## URL Rewrite modul pro IIS

Víceméně standardní součástí instalace IIS je – a nebo by pro své mnohostranné použití měl být – [URL Rewrite modul pro IIS](http://www.iis.net/download/URLRewrite). Ačkoliv URL rewriting jako takový je ohavný hack a v nových aplikacích doporučuji používat URL routing, tento modul zvládá celou řadu dalších, často požadovaných věcí. Kromě rewritingu umí i redirectovat, blokovat a v součinnosti s [Application Request Routingem](http://www.iis.net/download/ApplicationRequestRouting) i fungovat jako reverzní proxy.

Chování modulu může být řízeno komplxními pravidly založenými na regulárních výrazech. To použijeme v případě, že máme větší množství adres, které můžeme zpracovat podle nějakých pravidel, převést starou adresu na novou. Ale co když to není možné, co když taková pravidla neexistují? Často se to stává u webů, které vznikaly chaoticky-demokratickým způsobem a nemají jednotnou strukturu. Další možnost je ten můj – oba způsoby generování URL mají svou logiku, leč bohužel vzájemně nepřevoditelnou.

Pokud je adres konečné množství a můžete vytvořit "převodní tabulku" mezi starými a novými adresami, máte vyhráno. Můžete použít rewritingový modul a *Rewrite Maps*.

## Rewrite maps

Prvním krokem k úspěchu je získání "převodní tabulky". Konkrétní postup závisí na vašem systému, já jsem použil vhodně naformulovaný dotaz do staré a nové databáze:

[![rewritemap-1](https://www.cdn.altairis.cz/Blog/2012/20120115-rewritemap-1_thumb.png "rewritemap-1")](https://www.cdn.altairis.cz/Blog/2012/20120115-rewritemap-1_2.png)

Výsledek (ve spodním okně) se dá dobře zkopírovat do Excelu a tam s ním dále pracovat. Hardcore databázisti si vytvoří dotaz, který jim vygeneruje přímo XML, já většinou používám Excel a jeho vzorečky:

[![rewritemap-2](https://www.cdn.altairis.cz/Blog/2012/20120115-rewritemap-2_thumb.png "rewritemap-2")](https://www.cdn.altairis.cz/Blog/2012/20120115-rewritemap-2_2.png)

Vygenerované XML potom obalím elementy *rewriteMaps* a *rewriteMap* (můžete jich mít vytvořeno více) a uložím jako soubor *RewriteMaps.config*, jehož obsah je přibližně následující:

    <rewriteMaps>
        <rewriteMap name="OldArticles">
            <add key="/archive/2004/12/13/147.aspx" value="/articles/1" />
            <add key="/archive/2004/12/13/150.aspx" value="/articles/2" />
            <add key="/archive/2004/12/14/151.aspx" value="/articles/3" />
            <!-- Vypuštěno zhruba 850 řádků -->
            <add key="/archive/2012/01/01/Congratulations-2012-Microsoft-MVP.aspx" value="/articles/859-congratulations-2012-microsoft-mvp" />
        </rewriteMap>
    </rewriteMaps>

Celý proces vytváření a referencování samostatného souboru bychom si v zásadě mohli odpustit, protože rewrite mapy lze psát přímo do *web.configu*. Nicméně rewrite mapy používáme typicky v případech, kdy psaní samostatných pravidel by bylo komplikované a nepřehledné, takže jsou obvykle dost rozsáhlé a *web.config* je pak  nepřehledný.

Ve *web.configu* potom vytvoříme pravidlo, které se bude odkazovat na dříve vytvořebou rewrite map:

    <configuration>
        <system.webServer>
            <rewrite>
                <rules>
                    <rule name="Old article URLs" stopProcessing="true">
                        <match url=".*" />
                        <conditions>
                            <add input="{OldArticles:{REQUEST_URI}}" pattern="(.+)" />
                        </conditions>
                        <action type="Redirect" url="{C:1}" appendQueryString="False" redirectType="Permanent" />
                    </rule>
                </rules>
                <rewriteMaps configSource="RewriteMaps.config" />
            </rewrite>
        </system.webServer>
    </configuration>

Používám *redirectType="Permanent"*, takže server použije pro přesměrování stavový kód [301 Moved Permanently](§). Vyhledávače by si tedy měly opravit příslušné odkazy a převést případné zvýhodnění ze zpětných odkazů na novou adresu.

Tímto poměrně jednoduchým a elegantním způsobem lze vyřešit velmi častý problém směrování starých URL na nové. Je to jednoduché, přehledné a výkonné, protože mapa se cacheuje.