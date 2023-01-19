<!-- dcterms:title = Jak zkonfigurovat Cloudflare proxy v ASP.NET -->
<!-- dcterms:abstract = Cloudflare je populární služba zajišťující (mimo jiné) CDN a reverzní proxy. To znamená, že se postaví mezi váš server a klienta a zařizuje různé zajímavé služby, od geografické dostupnosti přes zabezpečení po cacheování. Skrývá ale IP adresu klienta. Napsal jsem knihovnu, která umožňuje ASP.NET Core aplikaci transparentně zjistit IP adresu klienta, i když je publikována přes Cloudflare. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:coverUrl = /cover-pictures/20220904-cloudflare.png -->
<!-- x4w:coverCredits = Midjourney AI -->
<!-- x4w:pictureUrl = /perex-pictures/logo-cloudflare.svg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = IT -->
<!-- dcterms:date = 2022-09-04 -->

Cloudflare je populární služba zajišťující (mimo jiné) CDN a reverzní proxy. To znamená, že se postaví mezi váš server a klienta a zařizuje různé zajímavé služby, od geografické dostupnosti přes zabezpečení po cacheování. Skrývá ale IP adresu klienta. Napsal jsem knihovnu, která umožňuje ASP.NET Core aplikaci transparentně zjistit IP adresu klienta, i když je publikována přes Cloudflare.

> TL;DR: Knihovnu najdete na [https://github.com/ridercz/Altairis.Services.Cloudflare](https://github.com/ridercz/Altairis.Services.Cloudflare) a NuGet balíček se jmenuje `Altairis.Services.Cloudflare`.

## Cloudflare a proxy

Reverzní proxy je server (nebo tedy zpravidla více serverů), které se postaví mezi webovou aplikaci (web server) a klienta (browser). Reverzní proxy může poskytovat různé zajímavé služby, například:

* Cacheování obsahu, čímž snižuje objem dat přenesených ze serveru (za který obvykle platíte, pokud tedy nehostujete v ČR a většina vašeho trafficu nejde do NIXu).
* Geografickou distribuci koncových serverů, čímž zrychlujete svůj web pro uživatele (cacheovaný obsah se načítá ze serveru který jim je blíže, ne z vašeho serveru).
* Detekce kybernetických útoků (zejména DoS/DDoS) a obrana proti nim - útočník útočí na infrastrukturu Cloudflare, ne na vaši.
* HTTPS/TLS endpoint, kdy Cloudflare řeší vystavování a obnovování serverových certifikátů.
* Různé formy úpravy obsahu, přesměrování, rewritingu.
* Podporu IPv6, HTTP/2 a dalších standardů.

## Skrytí IP adresy klienta

Protože se Cloudflare postaví mezi váš server a klienta, nemá server možnost přímo vidět klientovu IP adresu - pro něj je klientem proxy server Cloudflare. Naštěstí pro nás přidává do požadavku Cloudflare svoje HTTP hlavičky, které obsahují údaje o klientovi:

* `CF-Connecting-IP` obsahuje původní IP adresu klienta
* `X-Forwarded-For` a `X-Forwarded-Proto` jsou standardní hlavičky používané různými proxy servery, kam ze zapisují proxy cestou

V ASP.NET Core lze IP adresu klienta zjistit tak, že se zeptáte na vlastnost `HttpContext.Connection.RemoteIpAddress`. Nicméně, pokud je ve hře proxy, dostanete adresu proxy, ne skutečného klienta.

## Forwarded headers middleware

Proto Microsoft jako součást ASP.NET nabízí [middleware](https://docs.microsoft.com/en-us/aspnet/core/host-and-deploy/proxy-load-balancer?view=aspnetcore-6.0), který umí přečíst shora uvedené hlavičky a vlastnost `RemoteIpAddress` podle ní nastavit.

Pokud máte obvyklý setup, kdy je vše na jednom serveru a web je publikován pomocí IIS, Nginxu nebo něčeho podobného, funguje to výborně bez nutnosti obsáhlejší konfigurace. Nicméně pokud používáte CDN službu, je to složitější. Forwarded Headers Middleware sice umí přečíst hlavičky typu `X-Forwarded-For`, ale je nutné pomocí vlastnosti `KnownNetworks` whitelistovat seznam podporovaných proxy. Děje se tak z dobrých, bezpečnostních důvodů. Pokud by totiž web byl náhodou najednou přístupný napřímo, kdokoliv by mohl hlavičku `CF-Connecting-IP` podvrhnout a podvrhout tak klientskou IP adresu.

Vypadá to pak v `Program.cs` nějak takhle:

```cs
builder.Services.Configure<ForwardedHeadersOptions>(options => {
    options.ForwardedHeaders = ForwardedHeaders.XForwardedFor;
    options.ForwardedForHeaderName = "CF-Connecting-IP";
    options.KnownNetworks.Add(new IPNetwork(IPAddress.Parse("10.0.0.0"), 24));
    options.KnownNetworks.Add(new IPNetwork(IPAddress.Parse("10.0.1.0"), 24));
});
var app = builder.Build();
app.UseForwardedHeaders();
```

Přičemž to `KnownNetworks.Add` musíme udělat pro všechny sítě, které Cloudflare používá. Jejich seznam je veřejně dostupný pro [IPv4](https://www.cloudflare.com/ips-v4) i [IPv6](https://www.cloudflare.com/ips-v6).

## Altairis.Services.Cloudflare

Proto jsem napsal jednoduchou knihovnu, která si při startu aplikace stáhne z výše uvedených adres seznamy sítí a zkonfiguruje Forwarded Headers Middleware tak, aby správně fungoval s Cloudflare. Přidání podpory je pak směčně jednoduché.

Nejdříve musíte nainstalovat NuGet balíček:

```ps
Install-Package Altairis.Services.Cloudflare
```

Potom stačí v `Program.cs` zavolat:

```cs
app.UseCloudflare();
```

Knihovna se postará o všechno ostatní.

Zdrojové kódy najdete jako vždy na [GitHubu](https://github.com/ridercz/Altairis.Services.Cloudflare) a jsou dostupné zdarma pod MIT licencí.