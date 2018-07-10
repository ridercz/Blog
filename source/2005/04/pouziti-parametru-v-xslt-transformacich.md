<!-- dcterms:identifier = aspnetcz#30 -->
<!-- dcterms:title = Použití parametrů v XSLT transformacích -->
<!-- dcterms:abstract = XSLT transformace je proces, v němž je XML dokument podle zapsaných pravidel překonvertován do jiného tvaru - nejčastěji XML v jiném formátu nebo HTML k prezentaci. Ve většíně případů, kdy se XSLT transformace využívá k prezentaci dat uživateli, se na různá data aplikuje vždy ta samá šablona. Někdy je ale potřebné, nebo minimálně užitečné, kromě těchto dvou vstupů dodat ještě něco dalšího. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Programování -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2005-04-11T00:40:47.303+02:00 -->
<!-- dcterms:dateAccepted = 2005-04-11T00:40:47.303+02:00 -->

XSLT transformace je proces, v němž je XML dokument podle zapsaných pravidel překonvertován do jiného tvaru - nejčastěji XML v jiném formátu nebo HTML k prezentaci. Ve většíně případů, kdy se XSLT transformace využívá k prezentaci dat uživateli, se na různá data aplikuje vždy ta samá šablona. Někdy je ale potřebné, nebo minimálně užitečné, kromě těchto dvou vstupů dodat ještě něco dalšího. 

V XSLT můžete pomocí elementu `xsl:param` definovat parametry, které lze "zvenčí" (při přípravě transformace) naplnit vhodnou hodnotou. Zpravidla se jedná o číslo či řetězec, ale můžete - což možnosti užití výrazně rozšiřuje - tímto způsobem předat i jiný XML dokument, potažmo jeho část. Parametr se chová jako XSLT proměnná (a stejně se používá), jenom je dostupný i zvenčí.

## Jednoduchý příklad použití XSLT parametru

Mějmež následující šablonu:

    <?xml version="1.0" encoding="UTF-8" ?>
    <x:stylesheet version="1.0" xmlns:x="http://www.w3.org/1999/XSL/Transform">
      <x:param name="SimpleParameter" />
      <x:template match="/">
        <h1>
          <x:value-of select="$SimpleParameter" />
        </h1>
      </x:template>
    </x:stylesheet>

Naplnění parametru `SimpleParameter` hodnotou jest provésti pomocí vlastnosti `TransformArgumentList` použité transformace. V příkladu níže transformaci provádím pomocí server control `asp:xml` jménem `Xml1`, ale postup je analogický pro všechny transformace:

    Me.Xml1.TransformArgumentList = New System.Xml.Xsl.XsltArgumentList
    Me.Xml1.TransformArgumentList.AddParam("SimpleParameter", "", "Hodnota parametru")

Příklad XML souboru neuvádím, v tomto případě na něm nezáleží (použijte třeba `<root />`).

## Předání XML struktury

Jak již bylo řečeno, hodnotou parametu může být i `NodeSet`, tedy vybrané nody z dokumentu. V tomto příkladu budeme chtít předat celý jednoduchý dokument:

    Dim Doc As New System.Xml.XmlDocument
    Doc.LoadXml("<root><demo>jedna</demo><demo>dva</demo></root>")

    Me.Xml1.TransformArgumentList = New System.Xml.Xsl.XsltArgumentList
    Me.Xml1.TransformArgumentList.AddParam("AdvancedParameter", "", _
                                           Doc.CreateNavigator().Select("/"))

S takto předaným parametrem je pak v šabloně možno nakládat stejně, jako s fragmentem vlastního dokumentu, příkladně:

    <?xml version="1.0" encoding="UTF-8" ?>
    <x:stylesheet version="1.0" xmlns:x="http://www.w3.org/1999/XSL/Transform">
      <x:param name="AdvancedParameter" />
      <x:template match="/">
        <x:for-each select="$AdvancedParameter/root/demo">
          <div>
            <x:value-of select="." />
          </div>
        </x:for-each>
      </x:template>
    </x:stylesheet>