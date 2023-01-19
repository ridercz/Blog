<!-- dcterms:identifier = aspnetcz#50 -->
<!-- dcterms:title = Filtrování HTML: jak na "nebezpečné" elementy? -->
<!-- dcterms:abstract = Jednou z nejčastěji se vyskytujících chyb ve webových aplikacích je script injection. Příčinou je nedostatečné ověření vstupů. Jak snadno a pro uživatele vstřícně zacházet s generickým HTML vstupem? -->
<!-- np9:categoryId = 2 -->
<!-- x4w:category = Bezpečnost -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2005-10-01T09:12:24.22+02:00 -->
<!-- dcterms:date = 2005-10-01T09:12:24.22+02:00 -->

Jednou z nejčastěji se vyskytujících chyb je *script injection*. Mechanismus, který dovolí uživateli zadat HTML kód, který, jsa zobrazen jinému uživateli, bude mít negativní efekt. Oním negativním efektem může být ledacos, obvykle se ale jedná o:

*   Prosté obtěžování uživatele (otevíráním pop-up oken a podobně). 
Získání autentizačních údajů (jsou-li uloženy v cookies, URL a podobně). 
Čirý vandalismus.

## ![Filter, sieve](https://www.cdn.altairis.cz/Blog/filter.jpg "Image via sxc.hu, used by permission.")Každý vstup je považován za nebezpečný, dokud neprokáže opak

Často je třeba principiálně nedůvěryhodným (či dokonce anonymním) uživatelům umožnit nějak zadávat vlastní obsah na stránky, typicky například jako komentáře, příspěvky do diskusního fóra, inzeráty... V takovém případě je třeba ošetřit vstup tak, aby uživatel - ať už z čiré blbosti nebo zlé vůle - nemohl způsobit nepříjemnosti systému nebo dalším uživatelům.

V první řadě je třeba zabránit spouštění skriptů - což znamená nejenom zakázat tag *script*, ale i *style* (behaviours) a všechny události (*onload*, *onmouseover...*). Ve druhé řadě je třeba poradit si se syntaktickými chybami, počínaje neuzavřenými párovými tagy, přes překlepy, nedokončené komentáře až po úplné syntaktické nesmysly.

A to vše navíc dostatečně bezpečně, aby bylo možno ubránit se i úmyslnému útoku s využitím rozličných druhů kódování a podobně.

### Řešení první: Velká čínská zeď

Implementačně nejjednodušším - a nutno přiznat, že v řadě případů postačujícím - řešením je "velká čínská zeď". Tedy přístup, kdy lze zadat pouze čistý text. Pokus o zadání jakéhokoliv HTML formátování skončí buďto chybovým hlášením, nebo se text prožene metodou *Server.HtmlEncode* a značky se viditelně zobrazí.

První přístup je vlastní též ASP.NET od verze 1.1. Standardně se chovají tak, že pokud jakýkoliv vstup (pole formuláíře, QueryString...) obsahuje cokoliv co vypadá jako HTML tag, vyhodí runtime exception ještě předtím, než se nad požadavkem jakkoliv hlouběji zamyslí. Chcete-li toto chování vypnout a ošetření vstupu provádět sami, musíte tak učinit přidáním atributu *ValidateRequest="false"* do direktivy *@Page*.

### Řešení druhé: Objevujeme Ameriku

Druhé řešení spočívá v tom, že HTML zavrhneme a vymyslíme vlastní značkovací jazyk s omezenými - a bezpečnými - možnostmi. Ten se pak na straně serveru přeloží do HTML a použije. Tento přístup má dvě základní nevýhody. Tou první je, že je implementačně dosti náročný, pokud chceme, aby byl trochu schopný. Druhou nevýhodou je, že vytvářet sto padesátý osmý značkovací jazyk nekompatibilní se zbytkem světa je principiální pitomost, protože se ho kromě autora nikdo další nebude učit, může-li se tomu vyhnout.

### Řešení třetí: Filtrujeme HTML

Řešení, dle mého soudu nejlepší, spočívá v použití jisté podmnožiny jazyka HTML. Znalost jeho základů (odstavce, tučné, kurzíva, odkazy) je poměrně běžná a lze ji snadno získat. Problém je, že psát HTML parser (reálného HTML, který si poradí s překlepy, překříženými tagy a kdečím dalším) je jeden z nejohavnějších úkolů, jaké mohou programátora potkat. Důkazem toho jsou i (ne)kvality webových prohlížečů.

## .NET HTML Agility Pack

Vyslyšením mnohých modliteb je knihovna nazvaná [.NET HTML Agility Pack](http://smourier.blogspot.com/), jejímž autorem je Simon Mourier. Tato knihovna, zdarma dostupná pro HTML 1.1 i 2.0, je odolný HTML parser, který dokáže načíst jakýkoliv HTML dokument a pracovat s ním pomocí metod známých z XML. A to i tehdy, když dokument není *well-formed.* V takovém případě si - stejně jako webové prohlížeče - heuristicky domyslí, co asi autor chtěl sdělit. Ne vždy správně, ale takový už je úděl věštců.

Možných aplikací HTML Agility Packu je mnoho, přičemž jednou z nich je právě filtrování uživatelského vstupu, s ohledem na bezpečnost a nápravu uživatelských chyb.

## Třída SafeHtml - kompletní a komfortní řešení

Na bázi Agility Packu jsem napsal třídu SafeHtml, která nabízí dvě základní metody zacházení se vstupem, s ohledem na použití ve webových aplikacích. Je vyzkoušena pod Whidbey (ASP.NET 2.0 Beta 2), ale principiálně by měla chodit i pod verzí 1.1.

### SimpleFilter - plain text do XHTML

První metoda je zmiňovaná *čínská zeď*. Vstup by měl být zadán v plain textu, bez jakéhokoliv formátování. Statická metoda *SimpleFilter* s ním provede několik věcí:

1.  Převede jej na odstavce, podle zalomení řádků (ENTER). Inteligentně přitom vynechá prázdné odstavce. Je tedy jedno, zda uživatel používá k oddělení odstavců 1x nebo 2x ENTER. 
Celý text zakóduje pomocí *HtmlEncode*. Případně zadané HTML značky se zobrazí, nikoliv aplikují. 
Prohledá text na výskyt webových a e-mailových adres. Najde-li nějaké, převede je automaticky na odkazy. 
Pokud je odkazovaná adresa příliš dlouhá (delší než 60 znaků), automaticky se zobrazí v textu pouze prvních 60 znaků (cíl odkazu samozřejmě zůstane nezměněn).

Tato metoda je vhodná tehdy, neočekává-li se od uživatelů, že budou cosi explicitně formátovat a nemá-li jim to být ani umožněno.

Celé filtrování je založeno na jedné veřejné a jedné pomocné metodě:

    Public Shared Function SimpleFilter(ByVal Text As String) As String
        Dim SB As New System.Text.StringBuilder
        For Each Line As String In Split(Text, vbCrLf)
            Line = Line.Trim()
            If Line <> "" Then
                Line = System.Web.HttpUtility.HtmlEncode(Line)
                Line = System.Text.RegularExpressions.Regex.Replace(Line, "\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*", "[$0]()")
                Line = System.Text.RegularExpressions.Regex.Replace(Line, "(http|https|ftp)\://[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,3}(:[a-zA-Z0-9]*)?/?([a-zA-Z0-9\-\._\?\,\'/\\\+&%\$#\=~])*[^\.\,\)\(\s]", New System.Text.RegularExpressions.MatchEvaluator(AddressOf EvaluateHyperlink))
                SB.Append("

" & Line & "
" & vbCrLf)
            End If
        Next
        Return SB.ToString()
    End Function

    Private Shared Function EvaluateHyperlink(ByVal M As System.Text.RegularExpressions.Match) As String
        Dim Title As String = M.Value
        If Title.Length > 60 Then Title = Title.Remove(60) & "..."
        Return String.Format("[{1}]()", M.Value, Title)
    End Function

Jedinou zajímavost zde představuje metoda *EvaluateHyperlink*. Že je pomocí regulárních výrazů možno vyhledávat a nahrazovat, je obecně známo. Je nicméně též možno napsat si vlastní metodu, která procedurálně zajistí jakkoliv složité nahrazení, které není možné napsat přímo v regexp, případně to programátor neumí. Já jsem této funkcionality využil při implementaci zmiňované funkce zobrazování URL.

### AdvancedFilter - tag soup do XHTML

Druhá statická metoda, *AdvancedFilter* aplikuje posledně zmiňovaný přístup. Předpokládá, že vstup je zapsán v HTML, nebo že se o to alespoň uživatel pokoušel. S takovým vstupem pak provede následující psí kusy:

1.  Převede jej na well-formed XML. Domyslí si tedy chybějící párové tagy, odstraní překřížené a podobně. 
Všechny názvy elementů/atributů převede na malá písmena (pro kompatibilitu s XHTML). 
V duchu nejlepších tradic presumpce viny odstraní všechny konstrukce, kromě těch, jež byly výslovně prohlášeny za důvěryhodné a povolené. 
Odstraní HTML komentáře.

Tuto metodu lze - po případné úpravě - použít kromě zabezpečení též k omezení nežádoucí kreativity autorizovaných uživatelů.

Standardně jsou za povolené pokládány následující elementy a jejich atributy: *a (href), img (src, alt, title, width, height), b, i, cite, strong, em, p, br, code, blockquote*. V případě odkazů je rovněž zajištěno, že smí začínat pouze některým ze standardních internetových protokolů (*http://, https://, ftp://, mailto: *a* news:*) a nesmějí se tedy odkazovat na klientské skripty.

V případě, že je zadaný text nějak obšírněji modifikován (například odstraněním nepovolených elementů), je vhodné na to uživatele upozornit. Pročež lze, kromě základního volání funkce, možno metodu *AdvacedFilter* volat i s odkazem předávaným parametrem *WasChanged*. V případě, že filtr provedl nějaké obsahové změny (tj. odstranil elementy či atributy, nikoliv jenom formálně překódoval do XHTML), nabývá hodnoty True, jinak False.

Celou třídu můžete velmi snadno upravit k obrazu svému, příkladně co do seznamu povolených HTML konstrukcí.

## Download a odkazy

*   [.NET HTML Agility Pack](http://smourier.blogspot.com/) - informace a download 
[SafeHtml](https://www.cdn.altairis.cz/Blog/2005/20051001-SafeHtml.zip) - zdrojový kód ve VB.NET