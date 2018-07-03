<!-- dcterms:identifier = aspnetcz#20 -->
<!-- dcterms:title = Píšeme vlastní validátor - jak ověřit platnost ISBN plus malá soutěž o tričko -->
<!-- dcterms:abstract = ISBN (International Standard Book Number) je unikátní identifikátor přidělovaný knihám. Na jeho příkladu si ukážeme, jak se dá v .NET vytvořit vlastní validátor. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Tipy, triky -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2005-01-29T03:17:44.853+01:00 -->
<!-- dcterms:dateAccepted = 2005-01-29T03:17:44.853+01:00 -->

ISBN (International Standard Book Number) je unikátní identifikátor přidělovaný knihám. Celosvětová koordinace zajišťuje, že žádné dvě knihy nemají stejné ISBN. Pro jeho formát platí jisté zákonitosti, které není možné snadno ověřit prostřednictvím prvku `RegularExpressionValidator`. Pokud potřebujete validovat vstup ISBN, musíte si validaci napsat sami. Pokud to děláte jednou v celé aplikaci, vystačíte si s prvkem `CustomValidator`, ale pokud se toto zadání opakuje vícekrát, je výhodnější si napsat vlastní specializovaný validátor.
 <h2>Formát ISBN-10</h2> 

Tento formát je původní a dnes nejběžnější. ISBN v tomto formátu může vypadat například takto: <em>80-7234-184-7</em>. Jedná se o devět významových číslic (co znamenají si můžete přečíst na [www.isbn.org](http://www.isbn.org/)) a desátý kontrolní znak, což může být buď číslice nebo písmeno X. Mezi číslice mohou být přidány pro větší srozumitelnost pomlčky, jejich umístění může být v zásadě libovolné.

Validace ISBN-10 tedy probíhá takto:
 <ol> <li>Odstraň všechny mezery, pomlčky a převeď text na velká písmena. <li>Ověř, zda výsledný řetězec odpovídá regulárnímu výrazu `^[0-9]{9}[0-9X]$`. <li>Spočítej kontrolní číslici z prvních devíti číslic a ověř, zda odpovídá poslednímu znaku.</li></ol> 

Výpočet kontrolní číslice probíhá tak, že se pro každá z devíti významových číslic vynásobí svým pořadím a výsledky se sečtou. To celé se vydělí jedenácti a zbytek je kontrolní číslice (pokud je zbytek 10, zapíše se jako X). Pro shora uvedené ISBN tedy bude výpočet kontrolní číslice probíhat takto:

<em>8*1 + 0*2 + 7*3 + 2*4 + 3*5 + 4*6 + 1*7 + 8*8 + 4*9 = 183  
183 mod 11 = 7</em>
 <h2>Formát ISBN-13</h2> 

Ve své podstatě je formát ISBN-13 pouhým přepisem ISBN-10 do formátu kompatibilního se standardem EAN-13. EAN (European Article Number) je systém umožňující unikátní číslování obecně libovolného zboží, založený na čárových kódech (více na [www.ean.cz](http://www.ean.cz/)). Pokud tedy na knize najdete čárový kód, bude se s největší pravděpodobostí jednat právě o ISBN-13.

Přepis probíhá tak, že se devíti významovým číslicím ISBN předřadí prefix '978', který identifikuje že se jedná o knihu (ještě je vyhrazen prefix '979', který ale zatím nebyl přidělen). Kontrolní číslice se počítá podle pravidel EAN, která jsou o něco složitější:

Z dvanácti významových číslic se spočítá kontrolní součet tak, že se jednotlivé číslice sečtou, přičemž čísla na sudých pozicích se vynásobí třemi. Kontrolní číslice je 10 - zbytek po dělení 10. Pro náš příklad bude tedy výpočet vypadat takto:

<em>9 + 7*3 + 8 + 8*3 + 0 + 7*3 + 2 + 3*3 + 4 + 1*3 + 8 + 4*3 = 121  
10 - 121 mod 10 = 9</em>

Příklad tedy bude ve formátu ISBN-13 vypadat takto: <em>9788072341849</em>.
 <h2>Píšeme vlastní validátor</h2> 

Validátor je ve své podstatě třída odvozená (Inherits) od `System.Web.UI.BaseValidator`. Je nutné přepsat metodu `EvaluateIsValid`, která vrací `True`, pokud vstup vyhovuje a `False` pokud nikoliv.

Dále pak potřebuji, aby programátor mohl zvolit, zda pro tuto specifickou aplikaci považuje za validní ISBN ve formátu ISBN-10, ISBN-13 nebo obě varianty. To zajistí vlastnost `EnabledIsbnTypes`, nabývající hodnot `Isbn10`, `Isbn13` a `Both`.

Kompletní zdrojový kód třídy pak vypadá takto:

Imports System.ComponentModel Imports System.Web.UI <DefaultProperty("Text"), ToolboxData("<{0}:IsbnValidator1 runat=server></{0}:IsbnValidator>")> Public Class IsbnValidator Inherits System.Web.UI.WebControls.BaseValidator Public Enum IsbnTypes Isbn10 Isbn13 Both End Enum Private _EnabledIsbnTypes As IsbnTypes = IsbnTypes.Both Public Property EnabledIsbnTypes() As IsbnTypes Get Return Me._EnabledIsbnTypes End Get Set(ByVal Value As IsbnTypes) Me._EnabledIsbnTypes = Value End Set End Property Protected Overrides Function EvaluateIsValid() As Boolean Dim Value As String = Me.GetControlValidationValue(Me.ControlToValidate) ' If empty string, return true If Value = "" Then Return True ' Remove formatting and turn to uppercase Value = Value.Replace(" ", String.Empty).Replace("-", String.Empty).ToUpper() ' Check if the result is ISBN-10 or ISBN-13 If Value.Length = 10 Then ' ISBN-10: Check if is enabled and valid If Me._EnabledIsbnTypes = IsbnTypes.Isbn13 Then Return False If Not System.Text.RegularExpressions.Regex.IsMatch(Value, "^[0-9]{9}[0-9X]$") Then Return False ' Compute checksum Dim CheckSum As Int32 For I As Int32 = 0 To 8 CheckSum += Int32.Parse(Value.Chars(I)) * (I + 1) Next CheckSum = CheckSum Mod 11 Dim CheckString As String = CheckSum.ToString() If CheckSum = 10 Then CheckString = "X" ' Compare checksum Return CheckString = Right(Value, 1) ElseIf Value.Length = 13 Then ' ISBN-13: Check if is enabled and valid If Me._EnabledIsbnTypes = IsbnTypes.Isbn10 Then Return False If Not System.Text.RegularExpressions.Regex.IsMatch(Value, "^97[89][0-9]{10}$") Then Return False ' Compute checksum Dim CheckSum As Int32 For I As Int32 = 0 To 11 If I Mod 2 = 0 Then CheckSum += Int32.Parse(Value.Chars(I)) Else CheckSum += Int32.Parse(Value.Chars(I)) * 3 End If Next CheckSum = 10 - (CheckSum Mod 10) If CheckSum = 10 Then CheckSum = 0 ' Compare checksum Return Right(Value, 1) = CheckSum.ToString() Else ' Bad number of digits Return False End If End Function End Class
 <h2>Použití</h2> 

Po zkompilování a nakopírování výsledko do adresáře `/bin` vaší aplikace můžete validátor používat. V hlavičce stránky ho zaregistrujete takto (hodnoty Namespace a Assembly samozřejmě upravte dle potřeby):

<%@ Register TagPrefix="iv" Namespace="AltairCommunications.Web.UI" Assembly="IsbnValidator" %>

Použít ho může prostým vložením následujícího kódu do stránky:

<my:isbnvalidator runat="server" id="IsbnValidator1" controltovalidate="TextBox1">(!)</my:isbnvalidator>

Kompletní příklad včetně zdrojových kódů si můžete stáhnout na [http://software.altaircom.net/software/isbnvalidator.aspx](http://software.altaircom.net/software/isbnvalidator.aspx).
 <h2>Soutěž</h2> 

ISBN knihy, kterou jsem před pár hodinami dočetl, je <em>80-7197-2?5-2</em>. Bohužel, jedna číslice z něj vypadla. Kdo na základě výše popsaného algoritmu vypočítá správné ISBN a napíše jako první do komentářů název knihy, dostane firemní tričko!