<!-- dcterms:identifier = aspnetcz#312 -->
<!-- dcterms:title = ASP.NET Chaos Generator: machine keys, klíče, hesla dle libosti -->
<!-- dcterms:abstract = Při vývoji a nasazení aplikací potřebujeme často trochu chaosu. Tím nemyslím příspěvky našich spolupracovníků, ale náhodně generované klíče či hesla. K jejich generování lze použít řadu různých programů a online služeb, ale já osobně s nimi z různých důvodů nejsem spokojen. Takže jsem napsal a zprovoznil vlastní nástroj, který lze považovat za swiss-army knife pro všechny případy, kdy toužíme po chaosu. A zároveň může sloužit jako inspirace pro tvorbu uživatelského rozhraní pomocí jQuery UI. -->
<!-- np9:categoryId = 7 -->
<!-- x4w:category = Software -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2010-12-31T06:11:35.61+01:00 -->
<!-- dcterms:dateSubmitted = 2010-12-31T06:23:06.157+01:00 -->
<!-- dcterms:dateAccepted = 2010-12-31T06:24:39.92+01:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20101231-asp-net-chaos-generator-machine-keys-klice-hesla-dle-libosti.png -->

Při vývoji a nasazení aplikací potřebujeme často trochu chaosu. Tím nemyslím příspěvky našich spolupracovníků, ale náhodně generované klíče či hesla. K jejich generování lze použít řadu různých programů a online služeb, ale já osobně s nimi z různých důvodů nejsem spokojen. Takže jsem napsal a zprovoznil vlastní nástroj, který lze považovat za swiss-army knife pro všechny případy, kdy toužíme po chaosu. A zároveň může sloužit jako inspirace pro tvorbu uživatelského rozhraní pomocí jQuery UI.

Online verzi aplikace najdete na adrese [chaos.aspnet.cz](http://chaos.aspnet.cz). Tamtéž si (na záložce *About*) můžete stáhnout zdrojový kód celé aplikace. A co umí?

## Generování machine keys i pro .NET 4.0

Prakticky pro každou ASP.NET aplikaci potřebujete vygenerovat klíče pro *machineKeys* sekci. Generátorů MachineKeys klíčů se po internetu toulá spousta, ale nenašel jsem žádný, který by podporoval i nové algoritmy, které jsou součástí ASP.NET 4.0.

## Generování hesel

Rovněž generátorů hesel je na Internetu spousta, ale když je potřebuju najít, žádný vhodný se mi nikdy pod ruku nedostane. Můj generátor umí automaticky vytvářet hesla libovolné délky a složitosti, přičemž zaručuje, že hesla nebudou obsahovat znaky, které lze vizuálně snadno zaměnit, jako 1/I/l nebo 0/O.

## Univerzální generátor klíčů a náhodných dat

Tohle je funkce, která mi chyběla nejvíc. Můžete zadat požadovaný počet klíčů a jejich délku (v bitech nebo bajtech) a program je umí vygenerovat v řadě různých formátů:

*   **DEC array** je pole bajtů v desítkové soustavě, oddělených řárkami, třeba pro zkopírování do zdrojového kódu. 
*   **HEX array** je totéž, ale bajty jsou v šestnáctkové soustavě, v 0x00 notaci. 
*   **Base16** generuje klíč jako sekvenci šestnáctkových číslic 0-F (velká nebo malá písmena). Tenhle formát je používán machineKeys (i když na ty mám zvláštní generátor), ale třeba se typicky zadává i při konfiguraci WiFi sítě. 
*   **Base64** je kódování široce používané na mnoha místech. 
*   **UrlBase64** je jeho varianta, která je bezpečná i pro použití v rámci URL, protože znaky + a / byly nahrazeny - a _.  

## Rozhraní jQuery UI

Pro tvorubu uživatelského rozhraní jsem použil knihovnu jQuery UI a aplikace ukazuje, jak je možné ji zkombinovat s ASP.NET Web Forms. Aplikace přirom není na JavaScriptu závislá a "degrades gracefully" – pokud JavaScript nefunguje, zobrazí sice jednoduché, ale plně funkční rozhraní

## Třída ChaosHelper pro vaše aplikace

Jádrem aplikace je jednoduchá třída *ChaosHelper*, která poskytuje uživatelsky přítulné metody pro generování náhodných dat v různých formátech. Používá přitom třídu *RNGCryptoServiceProvider*, tedy kryptograficky bezpečný generátor náhodných čísel (více o něm najdete v článku [Příliš spořádaný svět](http://www.aspnet.cz/articles/142-prilis-sporadany-svet)).

Tuto třídu můžete použít i samostatně ve vlastních aplikacích, pokud budou vyžadovat generování klíčů či hesel.