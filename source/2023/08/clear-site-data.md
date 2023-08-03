<!-- dcterms:title = HTTP hlavička Clear-Site-Data -->
<!-- dcterms:abstract = Méně známá HTTP hlavička "Clear-Site-Data" dokáže být velmi užitečná. Umí totiž prohlížeči přikázat, aby smazal všechny stopy po návštěvě daného webu. To se hodí zejména při odhlášení uživatele. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:coverUrl = /cover-pictures/20230803-clear-site-data.jpg -->
<!-- x4w:pictureUrl = /perex-pictures/20230803-clear-site-data.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = IT -->
<!-- dcterms:date = 2023-08-03 -->

Méně známá HTTP hlavička "Clear-Site-Data" dokáže být velmi užitečná. Umí totiž prohlížeči přikázat, aby smazal všechny stopy po návštěvě daného webu. To se hodí zejména při odhlášení uživatele.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/8XMhzEi8bek" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

 Princip jejího fungování je jednoduchý. Server může s HTTPS odpovědí (celé to, stejně jako všechna nová API, funguje jenom přes HTTPS) poslat klientovi hlavičku `Clear-Site-Data`. Hodnotou této hlavičky mohou být následující tokeny, oddělené čárkami (pozor, uvozovky jsou součástí tokenu):

 Název                 | Význam
 --------------------- | ------
 `"cache"`             | _Experimentální._ Položky v HTTP cache. Browser může vymazat i související věci, jako třeba návrhy v adresním řádku apod.
 `"cookies"`           | Cookies pro doménu, ve které se nachází origin, a všechny její subdomény. Také HTTP autentizace (např. Basic Authentication).
 `"storage"`           | Různé formy storage, např. Local/Session Storage, IndexedDB a další.
 `"executionContexts"` | _Experimentální, nefunguje v Chrome et al._ Refreshnout otevřené záložky na tomtéž originu.
 `"*"`                 | _Nefunguje v Chrome et al._ Všechna data, která lze smazat.

 Co dobře funguje v současných prohlížečích, jsou hodnoty `"cache", "cookies", "storage"`. Problém je s hodnotami `"executionContexts"` a `"*"`. Jediný browser, který [podle MDN podporuje](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Clear-Site-Data) hodnotu `"executionContexts"` je Samsung Internet Browser. Firefox sice tuto hodnotu neimplementuje, ale ignoruje ji. Problém je s browsery, které jsou založeny na jádře Chromium (tj. Chrome, Edge, Opera a spousta dalších). Ty totiž v případě, že je přítomna hodnota `"executionContexts"` nebo `"*"` ignorují celou hlavičku a nevymažou nic. Jedná se o [známý bug](https://bugs.chromium.org/p/chromium/issues/detail?id=898503), který je reportován již od roku 2018 a zatím (v srpnu 2023, kdy píšu tento článek) nebyl vyřešen.

 ## Kdy a jak tuto hlavičku použít?

 Typickým kandidátem pro použití této hlavičky je proces odhlášení uživatele. Kód (implementovaný pomocí Minimal API) pro odhlášení a smazání stop může vypadat například takto:

 ```csharp
 app.MapGet("/logout", async (HttpContext c, SignInManager<ApplicationUser> signInManager) => {
    // Sign out the user
    if (signInManager.IsSignedIn(c.User)) await signInManager.SignOutAsync();

    // Add the Clear-Site-Data header to the response
    // Do not use "*", due to a bug #898503 in Chromium-based browsers
    c.Response.Headers.Add("Clear-Site-Data", "\"cache\", \"cookies\", \"storage\"");

    // Redirect to the home page
    return Results.Redirect("/");
});
 ```

 Pokud si chcete vyzkoušet jak to funguje, připravil jsem pro vás [jednoduchou ukázkovou aplikaci](https://www.cdn.altairis.cz/Blog/2023/20230803-ClearSiteData.zip), kde si můžete vyzkoušet mazání cookies a local storage.