<!-- dcterms:identifier = aspnetcz#298 -->
<!-- dcterms:title = Kritická bezpečnostní chyba v ASP.NET -->
<!-- dcterms:abstract = V pátek byla zveřejněna kritická bezpečnostní chyba ve všech verzích ASP.NET, od 1.0 po 4.0 včetně. Dosud na ni neexistuje patch, jenom workaround, a ten je bohužel dosti pracný. -->
<!-- np9:categoryId = 2 -->
<!-- x4w:category = Bezpečnost -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2010-09-21T03:27:03.133+02:00 -->
<!-- dcterms:date = 2010-09-21T03:27:03.977+02:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20100921-kriticka-bezpecnostni-chyba-v-asp-net.png -->

V pátek byla zveřejněna kritická bezpečnostní chyba ve **všech verzích ASP.NET**, od 1.0 po 4.0 včetně. Dosud na ni neexistuje patch, jenom workaround, a ten je bohužel dosti pracný.

Abychom byli zcela korektní, tak původní příčina, známá jako "Padding Oracle Exploit" nemá v zásadě s ASP.NET nic společného, je to kryptografický útok, který zahrnuje rodinu symetrických algoritmů, zahrnující bohužel i AES – nejpoužívanější symetrický algoritmus dneška. Tímto problémem jsou zasaženy všechny webové frameworky a nejenom ony.

Problém ASP.NET spočívá v tom, že využívá AES způsobem, který umožňuje tento problém využít mimo jiné k získání obsahu jinak chráněných souborů – zejména *web.config*. Tento soubor typicky obsahuje informace jako connection string a další, které mohou být dále zneužitelné různým způsobem.

Podrobnější informace najdete na webu [netifera.com](http://netifera.com/research/).

## Workaround

V okamžiku publikace tohoto článku **neexistuje na tuto chybu pro ASP.NET oprava**, ačkoliv na ní Microsoft usilovně pracuje. Existuje pouze workaround, který zavírá jeden známý směr útoku. Jeho podstatou je, aby server pro všechny HTTP chyby vracel stejné chybové hlášení (tedy nerozlišoval např. chyby 404 a 500).

Nestačí pouze dodržovat best practices a mít povolené custom errors. Problém nespočívá v obsahu chybového hlášení, ale v prostém odlišení odpovědi "nenalezeno" a "vnitřní chyba serveru".

**Návod k aplikaci workaroundu najdete zde:**

*   [Microsoft Security Advisory 2416728](http://www.microsoft.com/technet/security/advisory/2416728.mspx)
*   [Článek na blogu ScottGu](http://weblogs.asp.net/scottgu/archive/2010/09/18/important-asp-net-security-vulnerability.aspx)  

Pozor! Čtěte a aplikujte pozorně!

Problém zmíněného workaroundu je, že jej není možné aplikovat na celý server, ale je nutné opatchovat každou aplikaci zvlášť, což je dosti pracné. Pracuji na řešení pomocí globálně aplikovatelného HTTP modulu, ale mám s ním jisté problémy, takže není dosud k dispozici.

## Nic se nejí tak horké…

Jistou uklidňující zprávou je, že v době vydání tohoto článku nebyl zatím k dispozici žádný hotový nástroj pro provedení útoku na ASP.NET aplikaci. Na [výše linkované stránce](http://netifera.com/research/) je k nalezení POET (Padding Oracle Exploit Tool) ve verzi 1.0, která ASP.NET přímo nepodporuje. 

Také dosud **nebyl zaznamenán žádný úspěšný útok na produkční aplikaci**. Jediné co je k dispozici, je následující video na YouTube:
  <div style="padding-bottom: 0px; margin: 0px auto; padding-left: 0px; width: 425px; padding-right: 0px; display: block; float: none; padding-top: 0px" id="scid:5737277B-5D6D-4f48-ABFC-DD9C333F4C5D:198ad0d7-2351-4f21-b387-8aa274accca9" class="wlWriterEditableSmartContent"><div>[![](https://www.cdn.altairis.cz/Blog/2010/20100921-video9bec751ad1ef.jpg)](http://www.youtube.com/watch?v=yghiC_U2RaM)</div></div>  

Bohužel, tento uklidňující stav je pouze dočasný. Dá se předpokládat, že mechanismus pro úspěšný útok bude k dispozici v řádu hodin, nejvýše dnů. Doporučuji tedy okamžitě přijmout odpovídající opatření.

## Preventivní opatření

Dopady útoku může zmínit šifrování kritických konfiguračních sekcí. Útočník sice získá konfigurační soubor, ale důležité údaje v něm budou zašifrované. Podrobnější informace najdete na MSDN:

*   [Encrypting and Decrypting Configuration Sections](http://msdn.microsoft.com/en-us/library/zhhddkxy.aspx)
*   [Walkthrough: Encrypting Configuration Information Using Protected Configuration](http://msdn.microsoft.com/en-us/library/dtkwfdky.aspx)  

Bohužel, v řadě scénářů je použití šifrování konfigurace nepoužitelné a ve zbytku dosti komplikované.

Vzhledem k tomu, že realizace úspěšného útoku vyžaduje zaslání řádově desítek tisíc požadavků, lze ke zkomplikování útoku použít i [Dynamic IP Restrictions](http://www.iis.net/download/DynamicIPRestrictions) modul pro IIS 7.0. Ten umožňuje dočasně dynamicky blokovat IP adresy, z nichž přichází velké množství požadavků. Jedná se ovšem pouze o zpomalení útoku, nikoliv jeho odvrácení.