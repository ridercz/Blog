<!-- dcterms:identifier = aspnetcz#359 -->
<!-- dcterms:title = Ochrana před vymazáním formuláře pomocí Local Storage -->
<!-- dcterms:abstract = Kolikrát už se vám stalo, že jste začali psát nějaký dlouhý text a pak třeba omlem zmáčknuli Refresh, zavřeli okno nebo vám po odeslání aplikace zahlásila "vaše session vypršela, zkuste to znovu"? Existuje jednoduché a elegantní řešení, jak tento problém řešit, pomocí DOM Storage (Local Storage). -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = IT -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2011-12-28T21:42:56.493+01:00 -->
<!-- dcterms:date = 2011-12-28T21:45:00+01:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20111228-ochrana-pred-vymazanim-formulare-pomoci-local-storage.png -->

Kolikrát už se vám stalo, že jste začali psát nějaký dlouhý text a pak třeba omlem zmáčknuli Refresh, zavřeli okno nebo vám po odeslání aplikace zahlásila "vaše session vypršela, zkuste to znovu"? Existuje jednoduché a elegantní řešení, jak tento problém řešit, pomocí DOM Storage (Local Storage).

O této technologii jsem již před časem psal v článku [Local Storage: Sbohem cookies, sbohem session](http://www.aspnet.cz/articles/344-local-storage-sbohem-cookies-sbohem-session). Ve stručnosti se jedná o jednoduché úložiště "název-hodnota", které je dostupné z JavaScriptu na straně klienta, na server vůbec neputuje. Z tohoto důvodu také není třeba příliš brát ohled na objem dat atd.

## Zadání

Chci vyřešit problém s mizením hodnot z formulářů při automatickém odhlášení, chybě serveru a podobných záležitostech. Jako bonus pak lze použít tentýž postup pro zapamatování neměnných položek ve formulářích – typicky např. jméno a e-mailová adresa komentujícího. Jaké vlastnosti by tedy řešení mělo mít?

*   Umožnit autorovi aplikace jednoduše vybrat, hodnoty kterých polí chce zachovat. To vyplývá z logiky aplikace. Např. při psaní komentáře budu chtít zachovat jméno, e-mail a text komentáře, ale ne třeba opsaný CAPTCHA kód. 
*   V případě úspěšného odeslání formuláře některé (vybrané) zapamatované hodnoty smazat. Ale ne všechny – ne výše uvedeném případě odstranit jenom text komentáře, ne už jméno a e-mail. 
*   Minimální, nejlépe žádná, zátěž na straně serveru. 
*   Snadná implementace a široká kompatibilita.   

## Řešení

Zvolil jsem čistě klientské řešení využívající JavaScript, Local Storage a data-atributy z HTML 5. Toto řešení je podporováno většinou v současnosti používaných prohlížečů a v případě že podporováno není, nepůsobí problémy, prostě to tiše nebude fungovat. Klientský skript je psaný pomocí jQuery, protože bez něj psaní JavaScriptu hloboce přesahuje hranice mého masochismu.

Použití je jednoduché. Pro **zapamatování hodnoty pole** stačí danému elementu přidat atribut `data-rls-id`, jehož hodnota se použije pro vytvoření klíče, pod nímž bude zapamatovaná hodnota uložena v local storage:

    <input type="text" name="name" data-rls-id="name" />

Protože v případě ASP.NET server controls se neznámé atributy beze změny kopírují na výstup, je snadné totéž zapsat i v ASPX:

    <asp:TextBox ID="TextBoxName" runat="server" data-rls-id="name" />

Ve výše uvedeném příkladu se hodnota uloží do local storage pole s názvem `RLS[name]`. Syntaxe připomíná (záměrně) adresaci kolekcí, ale je to jenom stringový identifikátor. Ono "RLS" (Remember in Local Storage) tam přidávám proto, abych předešel možným konfliktům pro obvyklé hodnoty.

Některé hodnoty (jméno, e-mail) si budeme chtít pamatovat bez omezení, ale některé je žádoucí po úspěšném zpracování odstranit, protože příště budou jiné (text komentáře). Pro **vymazání zapamatované hodnoty** slouží atribut `data-rls-clear`, který přidáme k jekémukoliv elementu na stránce, která je reakcí na úspěšné odeslání formuláře. Hodnota tohoto atributu je seznam ID polí, která se mají zapomenout, oddělený čárkami:

    <p data-rls-clear="comment">Váš komentář byl zaznamenán.</p>

Zdrojový kód obslužného skriptu, který se zavolá při natažení stránky, je následující:

    $(function () {
        // Check if this browser supports local storage
        if ("localStorage" in window && window["localStorage"] !== null) {

            // Clear all remembered entries required by data-rls-clear
            $("*[data-rls-clear]").each(function () {
                var fields = $(this).data("rls-clear").split(",");
                for (var i = 0; i < fields.length; i++) {
                    window.localStorage.removeItem("RLS[" + fields[i].trim() + "]");
                }
            });

            $("*[data-rls-id]").each(function () {
                // Load currently remembered data
                var keyName = "RLS[" + $(this).data("rls-id") + "]";
                $(this).val(window.localStorage[keyName]);

                // Save data to local storage when value changes
                $(this).keyup(function () {
                    window.localStorage[keyName] = $(this).val();
                });
            });

        }
    });

Začneme tím, že si ověříme, jestli prohlížeč podporuje funkci Local Storage. Pokud ne, nic dalšího neděláme. Poté smažeme z úložiště všechny klíče, požadované atributem `data-rls-clear`. Dále naplníme všechna pole označená atributem `data-rls-id` případně z minula zapamatovanými hodnotami. Na závěr se pověsíme na událost `keyup` těchto polí handler, který uloží aktuální hodnotu do LocalStorage.

Použil jsem stisk klávesy, nikoliv událost `change`. Ta se vyvolá teprve ve chvíli, kdy pole ztatí focus. Pokud ale uživatel píše delší text do jednoho pole, pokládám za pravděpodobné, že k nějakému problému dojde v průběhu editace. Toto řešení možná není úplně efektivní (kód se volá při každém stisku klávesy, a to i pokud nedošlo ke změně textu), ale nepředpokládám, že by v tomto případě byl výkon extra kritický. Pro úplnost dodávám, že řešneí není ani stoprocentně funkční – pokud uživatel text modifikuje čistě použitím myši (např. vyjmutím nebo vložením obsahu schránky z kontextového menu), nebude fungovat.

Dále pak jsem se nezabýval minifikací skriptů nebo zabalením funkcionality do jQuery pluginu, ježto se v tom nevyznám. Vyřešení těchto problémů nechám případným zájemcům, kteří se v JavaScriptu vyznají lépe než já :)

**Kompletní zdrojové kódy a příklad použití si můžete stáhnout zde: **[**20111228-rls.zip**](https://www.cdn.altairis.cz/Blog/2011/20111228-rls.zip)** (4 kB).**