<!-- dcterms:identifier = aspnetcz#26 -->
<!-- dcterms:title = Automatické přepínání jazyka stránky podle nastavení prohlížeče -->
<!-- dcterms:abstract = O možnosti využítí standardně zasílané hlavičky Accept-Language pro volbu preferovaného jazyka stránky jsem já osobně psal před čtyřmi lety (skoro). Dnešní živou diskusi na jistém fóru, týkající se magie způsobující že se moje osobní stránky někomu ukazují česky, někomu anglicky, jsem si zdůvodnil tím, že fórum je o psech a ne o počítačích. Když mi ovšem večer v mailboxu přistál dotaz jak z ASP.NET provést reverzní DNS lookup, kvůli volbě patřičné jazykové verze, došlo mi že je třeba jednat. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = IT -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2005-03-18T04:28:39.207+01:00 -->
<!-- dcterms:dateAccepted = 2005-03-18T04:28:39.207+01:00 -->

O možnosti využítí standardně zasílané hlavičky *Accept-Language* pro volbu preferovaného jazyka stránky jsem já osobně [psal před čtyřmi lety](http://archive.aspnetwork.cz/art/clanek.asp?id=117) (skoro). Dnešní živou diskusi na jistém fóru, týkající se magie způsobující že se moje [osobní stránky](http://www.rider.cz/) někomu ukazují česky, někomu anglicky, jsem si zdůvodnil tím, že fórum je o psech a ne o počítačích. Když mi ovšem večer v mailboxu přistál dotaz jak z ASP.NET provést reverzní DNS lookup, kvůli volbě patřičné jazykové verze, došlo mi že je třeba jednat.

Internetové prohlížeče umožňují nastavit jazyk, ve kterém si uživatel přeje dostávat stránky, je-li to možné. Tuto preferenci pak posílají s každým požadavkem jako hlavičku *Accept-Language*. Bližší podrobnosti jest nalézti ve shora linkovaném článku, případně přímo v [RFC 2616, sekce 14.4](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.4).

## Využití v ASP.NET

ASP.NET umožňuje přistupovat k jazykovým preferencím pomocí vlastnosti Request.UserLanguages. Želbohu, nepříliš inteligentně, prostě rozparsuje hlavičku Accept-Header podle čárek a dál se o nic nestará. Ačkoliv RFC umožňuje nastavit každému jazyku prioritu (váhu), ASP.NET ji ignoruje, a řídí se pouze pořadím jazyků v hlavičce. V praxi to naštěstí nepředstavuje problém, protože klienti kódy jazyků posílají v patřičném pořadí.

## Nastavení v MSIE

Internet Explorer přebírá nastavení požadovaného jazyka při instalaci, podle nastavených "regional settings". Je tedy pravděpodobné, že máte správně nastavenou češtinu. Pokud toto nastavení chcete změnit, jděte v menu na *Tools -> Internet Options* a na záložce *General* klepněte na tlačítko *Languages*:

![](https://www.cdn.altairis.cz/Blog/2005/20050318-langpref-msie.png)

Mozilla Firefox samozřejmě v duchu svých nejlepších tradic příslušná nastavení operačního systému zcela ignoruje, na natvrdo má (alespoň v anglické verzi) nastavenou angličtinu. Náprava je naštěstí snadná a kupodivu zcela stejná jako v MSIE:

![](https://www.cdn.altairis.cz/Blog/2005/20050318-langpref-firefox.png)