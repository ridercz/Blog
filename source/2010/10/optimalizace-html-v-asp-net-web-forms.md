<!-- dcterms:identifier = aspnetcz#304 -->
<!-- dcterms:title = Optimalizace HTML v ASP.NET Web Forms -->
<!-- dcterms:abstract = Častou výčitkou, která se na ASP.NET Web Forms snáší, je ošklivé HTML, které generují. Výčitka je to zhusta neoprávněná, protože i Web Forms umí generovat pěkné sémantické HTML, které lze snadno stylovat přes CSS. Je ale třeba správně chápat možnosti, které nám ASP.NET nabízí. V rámci tohoto článku se podíváme, jak na generování moderního HTML v ASP.NET Web Forms. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = IT -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2010-10-27T00:14:36.09+02:00 -->
<!-- dcterms:dateAccepted = 2010-10-27T00:14:37.247+02:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20101027-optimalizace-html-v-asp-net-web-forms.jpg -->

Častou výčitkou, která se na ASP.NET Web Forms snáší, je ošklivé HTML, které generují. Výčitka je to zhusta neoprávněná, protože i Web Forms umí generovat pěkné sémantické HTML, které lze snadno stylovat přes CSS. Je ale třeba správně chápat možnosti, které nám ASP.NET nabízí. V rámci tohoto článku se podíváme, jak na generování moderního HTML v ASP.NET Web Forms.

Serverové ovládací prvky v ASP.NET lze rozdělit v zásadě do čtyř skupin, podle toho, jaké je jejich určení a jaký generují výsledný HTML kód.

*   **Nevizuální prvky:** Negenerují samy o sobě HTML kód žádný a slouží jenom k propojení ostatních pvků v rámci Web Forms infrastruktury. Typickým zástupcem jsou prvky jako `SqlDataSource`, `QueryStringParameter` a podobně. Tyto prvky nás z hlediska výsledného kódu nijak nezajímají a jako takové je tedy můžeme pominout. Do této skupiny patří také prvky `MultiView` a `View` (ty jenom řídí zobrazování vnořených prvků a samy nic nekreslí) nebo `Literal` a `Localize` (ty jenom zobrazí, co jim dáme, beze změny). 
*   **Jednoduché prvky:** Zpravidla představují serverovou reprezentaci jednoho HTML elementu. Typickými zástupci jsou např. `Label`, `TextBox`, `Button` a podobné prvky. HTML markup jednoduchých prvků je zpravidla také jednoduchý a nepředstavuje problém. S komplexními prvky hraničí třeba `RadioButtonList` nebo `CheckBoxList`. Ty už dodávají kreativity více, ale i s nimi si lze poradit. 
*   **Komplexní prvky:** Generují komplexní HTML kód, který je v nich "zadrátovaný" a sice je možné jej ovlivnit, ale rozhodně ne snadno. Právě jimi generovaný markup je to, co HTML puristy pobuřuje nejčastěji. Typickými zástupci této skupiny jsou prvky jako `Calendar`, `GridView`, `DetailsView`, `TreeView` a `Menu`. 
*   **Šablonovací prvky:** Ve své podstatě nemají žádný vlastní HTML markup (`ListView` a `Repeater`) a jenom skládají dohromady kousky HTML zadané uživatelem. Záleží tedy na tom, jaké HTML uživatel zadá do šablon. Některé prvky (jako `FormView` nebo `Login`) jednak obsahují výchozí šablony (které bývají dost hrozné) a jednak generují trochu vlastního HTML "okolo" –  to ale můžeme snadno vypnout.   

Základním principem .NET Frameworku je "něco za něco". Zpravidla máte na výběr z několika možností, jak nějaký úkol splnit. Některé jsou jednoduché a bezpracné (`GridView`), ale za jejich použití zaplatíte méně elegantním kódem a menší kontrolou nad ním. Jiné (`ListView`) vám sice dávají lepší kontrolu nad kódem, ale jsou na pochopení a použití náročnější a navíc se v ASP.NET objevily až později, např. ve verze 3.5 nebo 4.0.

## Jak na jednoduché prvky

Jednoduché prvky mají zpravidla jednoduchý a neurážející markup. Obvykle odpovídají jednomu nebo několika málo HTML elementům. Jednoduchá převodní tabulka mezi Web Forms  a HTML by mohla vypadat takto:
  <table><thead>     <tr>       <th>Web Forms</th>        <th>HTML</th>     </tr>   </thead><tbody>     <tr>       <td>`<asp:Label>`</td>        <td>`<span>`; pokud je definována vlastnost AssociatedControlId, pak `<label>`.</td>     </tr>      <tr>       <td>`<asp:TextBox>`</td>        <td>Podle vlastnosti `TextMode` buď `<input type="text">`, `<input type="password">` nebo `<textarea>`.</td>     </tr>      <tr>       <td>`<asp:RadioButton>`</td>        <td>`<input type="radio">`; pokud je definována vlastnost `Text`, tak také `<label>`.</td>     </tr>      <tr>       <td>`<asp:CheckBox>`</td>        <td>`<input type="checkbox">`; pokud je definována vlastnost `Text`, tak také `<label>`.</td>     </tr>      <tr>       <td>`<asp:Button>`</td>        <td>`<input type="submit">`</td>     </tr>      <tr>       <td>`<asp:LinkButton>`</td>        <td>`<a href="…">…</a>`</td>     </tr>      <tr>       <td>`<asp:ImageButton>`</td>        <td>`<input type="image">`</td>     </tr>      <tr>       <td>`<asp:Image>`</td>        <td>`<img src="…">`</td>     </tr>      <tr>       <td>`<asp:HyperLink>`</td>        <td>`<a href="…">…</a>`</td>     </tr>      <tr>       <td>`<asp:DropDownList>`</td>        <td>`<select size="1">`</td>     </tr>      <tr>       <td>`<asp:ListView>`</td>        <td>`<select size="n">`</td>     </tr>      <tr>       <td>`<asp:*Validator>`</td>        <td>`<span>` + validační JavaScript</td>     </tr>      <tr>       <td>`<asp:ValidationSummary>`</td>        <td>Záleží na nastavení, ale obvykle `<ul>` a `<li>`.</td>     </tr>   </tbody></table>  

Výše uvedené prvky nepředstavují obvykle z hlediska HTML markupu žádný problém. Generovaný HTML kód je jednoduchý, validní a přehledný. Jediná "ošklivost" jsou dlouhá a automaticky generovaná ID, která budou pojednána dále samostatně.

Do rodiny jednoduchých prvků v zásadě patří ještě `CheckBoxList` a `RadioButtonList`. Zatímco výše zmíněné prvky `CheckBox` a `RadioButton` reprezentují jeden konkrétní ovládací prvek, tak tyto představují celou jejich kolekci. Pomocí vlastnosti `RepeatLayout` pak lze určit, jak mají být jednotlivé prvky poskládány. Výchozí hodnota – `Table` – je sice "blbuvzdorná", ale z hlediska HTML markupu nejproblematičtější. V závislosti na požadovaném vyznění je zpravidla lepší zvolit `Flow`, `OrderedList` nebo `UnorderedList`.

## Co s komplexními prvky

Komplexní prvky jsou ty, které generují rozličné divoké HTML. Platíme tím za pohodlí, které nám přinášejí. V obecné rovině je podle mého názoru dobré je nepoužívat vůbec a nahradit je jinými technikami.

Místo `GridView` lze použít `ListView` s patřičnými šablonami. Prvek `DetailsView` lze nahradit podle okolností buď opět prvkem `ListView` a nebo `FormView`. Nenahraditelné (resp. obtížně nahraditelné) jsou tyto prvky jenom ve scénářích typu ASP.NET Dynamic Data. Tam musíme při dynamickém generování UI krásné HTML oželet a nebo použít adaptéry, o nichž bude řeč později.

Prvek `Calendar` je dle mého soudu lepší nepoužívat vůbec a nahradit jej nějakými vyskakovacími řešeními na bází JavaScriptu – např. z jQuery UI nebo Ajax Control Toolkitu.

Pro prvky `TreeView` a `Menu` platí v zásadě totéž. Existují pro ně civilizující adaptéry, ale obecně bych se bez nich raději obešel.

## Šablonovací prvky

Do této kategorie patří především prvky `Repeater` (ten je v ASP.NET odjakživa) a `ListView` (od verze 3.5). Tyhle prvky nedělají nic jiného, než že skládají zadaná markup za sebe (`Repeater`) a nebo do sebe (`ListView`). `Repeater` umí data jenom jednoduše zobrazovat, `ListView` je plnohodnotná komponenta, která zvládá editaci, řazení, stránkování atd. Tyto prvky samy žádný markup negenerují a výsledný kód je tedy plně v rukách programátora.

Dále pak sem patří komponenty odvozené od prvku `Wizard`. Nejčastěji tedy prvky týkající se membershippingu: `Login`, `ChangePassword`… A konečně prvek `FormView`. Tyhle komponenty mohou fungovat v zásadě ve dvou režimech: buďto se použije nějaký jejich výchozí vzhled, nebo můžete definovat vlastní šablony. Ty vestavěné bývají dost hrozné. Další problém s touto rodinkou prvků spočívá v tom, že i když si definujete vlastní šablonu, tak vám okolo ní prvky vytvoří obálku v podobě ošklivé tabulky. Tomu se dá zabránit opět pomocí adaptérů a nebo, od verze 4.0, přidáním atributu `RenderOuterTable="false"`.

## Control Adapters

Control adaptéry jsou technologie původně vymyšlená pro adaptivní rendering, tedy možnost měnit HTML kód podle toho, z jakého prohlížeče a zařízení uživatel přistupuje. Lze vytvořit vlastní třídu, která se pak postará o renderování, místo toho prvku samotného. Jedná se o jediný způsob, jak změnit HTML kód, který generují. Jejich smysl nicméně postupně mizí, se změnami, které přináší ASP.NET 4.0.

Pokud se jim chcete věnovat, doporučuji nastudovat si fungování [CSS Friendly Control Adapters](http://cssfriendly.codeplex.com/). To je hotová sada adaptérů, původně od Microsoftu, nyní open source. Slouží k "učesání" výstupu běžných ASP.NET prvků.

## Závěrem

Ačkoliv je získání kontroly nad výsledným HTML kódem v případě ASP.NET Web Forms poněkud méně přímočaré, než např. v případě ASP.NET MVC, je možné. I pomocí ASP.NET Web Forms lze vytvářet stránky, které mají čistý a semanticky strukturovaný markup. Hodně tomu pomohla verze 4.0, kde se obejdeme i bez "hardcore" variant, jako jsou control adaptéry. V předchozích verzích byl přístup pravda poněkud komplikovanější.