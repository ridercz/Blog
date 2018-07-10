<!-- dcterms:identifier = aspnetcz#6 -->
<!-- dcterms:title = ASP.NET caching pro mírně pokročilé: Ukládání částí stránky -->
<!-- dcterms:abstract = V minulém zápisu jsem načal téma cacheování výstupů ASP.NET stránek. Popsané metody zajišťují cacheování výstupů celých stránek. Což je v mnohých případech užitečné, v jiných ovšem nepoužitelné. ASP.NET proto umožňuje cacheovat nejenom celé stránky, ale i jejich části - web user controly. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Programování -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2005-01-06T06:40:36.86+01:00 -->
<!-- dcterms:dateAccepted = 2005-01-06T06:40:36.86+01:00 -->

V [minulém zápisu](/entry/article-20050105.aspx) jsem načal téma cacheování výstupů ASP.NET stránek. Popsané metody zajišťují cacheování výstupů *celých* stránek. Což je v mnohých případech užitečné, v jiných ovšem nepoužitelné. ASP.NET proto umožňuje cacheovat nejenom celé stránky, ale i jejich části - web user controly.

Většina stránek obsahuje kromě "originálního" obsahu také stále se opakující hlavičku a patičku, menu a podobně. Tyto opakující se části zhusta obsahují též obsah sice generovaný dynamicky (příkladně seznam rubrik), ale zase ne aktualizovaný příliš často. Je praktické generovat seznam rubrik dynamicky (protože jinak na to při přidání nové rubriky zapomenete), ale rozhodně *není* praktické ho znovu načítat z databáze při každém požadavku na kteroukoliv stránku.

ASP.NET umožňuje použít direktivu OutputCache nejenom v rámci ASPX stránek, ale i v rámci web user controlu - ASCX. Pro dynamicky generovaný seznam rubrik příkladně používám toto nastavení:

    <%@ OutputCache Duration="1800" Shared="true" VaryByParam="none" %>

Jest samozřejmé, že zatímco cacheování celých stránek je možno provádět na serveru, na klientovi či někde mezi nimi, pro cacheování částí stránky to neplatí - to lze provádět pouze na serveru. Použitím této technologie tedy neušetříte přenosové pásmo, ale "jenom" výkon serveru.

## Argumenty OutputCache pro ASCX

Ačkoliv direktiva zůstává stejná, její parametry se u ASPX a ASCX liší. Možné jsou:

`Duration` - doba po kterou jest ukládati, v sekundách.

`Shared` (`True` nebo `False`, default `False`) - určuje, zda bude cacheovaná hodnota sdílena mezi různými ASPX stránkami. Tedy: Pokud je jeden ASCX control umístěn ve více ASPX stránkách, bude při nastavení `True` cacheována jedna kopie, při nastavení `False` tolik kopií, v kolika různých stránkách bude includováno. Používejte dle kontextu - menu všude stejné bude sdíleno, hlavička stránky dynamicky generující titulek asi ne.

`VaryByParam`, `VaryByCustom` - chová se úplně stejně jako při [cacheování celých stránek](/entry/article-20050105.aspx).

`VaryByControl` - umožňuje stanovit závislost na serverovém ovládacím prvku, jež je součástí ASCX controlu. To je vlastnost natolik obskurní, že jí budeme věnovat pozornost v následujícím samostatném oddílu.

## VaryByControl

Jest nutno míti na paměti, že pokud je použito cacheování, kód v ASCX prvku se vůbec nevykoná a místo toho se použije již dříve vygenerovaný HTML kód. Což je dost nepříjemné v případě, že ASCX obsahuje sám o sobě nějakou funkčnost, závislou  příkladně na formulářových prvcích.

V případě ASPX stránky lze požadovaného efektu dosáhnout prostřednictvím `VaryByParam`, protože při postbacku se data předávají jako formulářové parametry. V případě ASCX je to složitější - data se sice také předávají jako formulářové parametry, leč název polí není vždy jednoznačný, je generován dynamicky podle ID controlu. `VaryByParam` nelze tedy použít.

Ukažme si to na příkladu. Mějmež web user control sestávající z textového pole, tlačítka a labelu:

    <p>
      <asp:textbox id="TextBox1" runat="server"></asp:textbox>
      <asp:button id="Button1" runat="server" text="Button"></asp:button>
    </p>
    <p>
      <asp:label id="Label1" runat="server">Label</asp:label>
    </p>

Jednořádkový obslužný kód v jeho Page_Load vypíše aktuální čas a hodnotu onoho textového pole:

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Me.Label1.Text = "Time = " & DateTime.Now.ToString() & "; Selected = " & Me.TextBox1.Text
    End Sub

Pokud bychom použili cacheovací direktivu bez `VaryByControl`, výsledek by nebyl příliš uspokojivý: zobrazil by se ten text, který byl zadán v okamžiku, kdy se naposledy přegenerovala cache, veškerá další zadání by byla ignorována. Pročež použijeme tuto direktivu:

    <%@ OutputCache Duration="60" VaryByParam="none" VaryByControl="TextBox1" %>

Ta, jak račte klidně vyzkoušeti, zajistí cacheování v závislosti na hodnotě zadané do textového pole.

V příštím díle si povíme o sofistikovanějším využití caching API, neb do cache nemusíte ukládat jenom generovaný výstup stránek, ale i jakákoliv jiná data (jsou-li serializovatelná).