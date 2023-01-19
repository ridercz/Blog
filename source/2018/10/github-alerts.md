<!-- dcterms:title = GitHub Security Alerts nyní i pro .NET aplikace -->
<!-- dcterms:abstract = Koncem loňského roku spustil GitHub funkci, která vás varuje v případě, že používáte závislosti se známými bezpečnostními chybami. Nyní je dostupná i pro aplikace psané v .NETu a umí vás upozornit na to, že používáte potenciálně nebezpečné verze NuGet balíčků. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20181020-github-alerts.png -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = Bezpečnost -->
<!-- x4w:category = IT -->
<!-- dcterms:date = 2018-10-20 -->

Jedním z nejčastějších bezpečnostních problémů je používání zastaralých verzí závislostí (knihoven, komponent), které obsahují známé a opravené bezpečnostní chyby. V poslední verzi [OWASP Top 10](https://www.owasp.org/images/7/72/OWASP_Top_10-2017_%28en%29.pdf.pdf) se dostal na deváté místo. GitHub již od listopadu 2017 disponuje funkcí [Security Alerts](https://help.github.com/articles/about-security-alerts-for-vulnerable-dependencies/), která umí tyto zastaralé komponenty najít a upozornit vás, pokud je používáte.

Nyní je tato funkce k dispozici i pro .NET aplikace a umí vás upozornit na potenciálně nebezpečné NuGet balíčky. Funkce podporuje jak klasické .NET Framework aplikace (kde je seznam balíčků v `packages.config`) tak nové .NET Core aplikace, kde jsou referencované balíčky přímo v `.csproj` souboru.

## Jak se o problému dozvíte

Ve výchozím nastavení vás GitHub upozorní na potenciálně nebezpečné závislosti e-mailem:

![Screenshot e-mailové zprávy](https://www.cdn.altairis.cz/Blog/2018/20181020-github-alerts-0.png)

Rovněž vás upozorní žlutým výstražným bannerem přímo na hlavní stránce příslušného repozitáře:

![Screenshot notifikace na GitHubu](https://www.cdn.altairis.cz/Blog/2018/20181020-github-alerts-1.png)

Způsoby upozornění lze [změnit v nastavení](https://github.com/settings/notifications).

Přehled všech aktuálních alertů v repozitáři najdete na záložce _Insights_ v sekci _Alerts_. Tam najdete také odkaz na podrobnější informace o příslušné zranitelnosti:

![Screenshot detailu zranitelnosti](https://www.cdn.altairis.cz/Blog/2018/20181020-github-alerts-3.png)

## Co s tím

OK. Notifikaci jste dostali. A teď, co s tím? Samozřejmě nejjednodušší a nejsprávnější řešení je, že aktualizujete NuGet balíčky na nejnovější verzi (nebo alespoň na verzi, která řeší problém, na který jste byli upozorněni). V takovém případě alert automaticky zmizí.

V případě, že to učinit nemůžete nebo nehodláte, máte možnost alert zrušit pomocí tlačítka _Dismiss_, přičemž vyberete důvod, pro který jste se alert rozhodli ignorovat.

![Screenshot zrušení alertu](https://www.cdn.altairis.cz/Blog/2018/20181020-github-alerts-4.png)

U aktivně vyvíjených projektů obvykle nebývá s udržováním aktuálních verzí komponent zásadnější problém. Ale jakmile projekt přejde do fáze údržby, může to být náročnější, zejména pokud je projektů hodně a vývojářů málo. Alerty z GitHubu tudíž mohou přijít vhod a proto tuto funkci hodnotím velmi pozitivně.