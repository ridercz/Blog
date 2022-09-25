<!-- dcterms:title = Skoro statický obsah: Od konkrétní aplikace k univerzální komponentě -->
<!-- dcterms:abstract = Skoro každá webová aplikace má nějaký skoro statický obsah. Obsah, který sice není měněn zcela pravidelně a nejde o její hlavní úkol, ale přesto je dobré mít možnost ho editovat jinak než zásahem do zdrojáku. Různé pomocné texty jako podmínky použití, kontakty a podobně. V osmidílném seriálu jsem vám ukázal, jak lze specifické řešení pro jednu aplikaci přeměnit v univerzální komponentu. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:coverUrl = /cover-pictures/20220926-static-content.jpg -->
<!-- x4w:pictureUrl = /perex-pictures/20220926-static-content.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = IT -->
<!-- x4w:category = Z-TECH -->
<!-- dcterms:dateAccepted = 2022-09-26 -->

Skoro každá webová aplikace má nějaký skoro statický obsah. Obsah, který sice není měněn zcela pravidelně a nejde o její hlavní úkol, ale přesto je dobré mít možnost ho editovat jinak než zásahem do zdrojáku. Různé pomocné texty jako podmínky použití, kontakty a podobně. V [osmidílném seriálu](https://www.youtube.com/playlist?list=PLFZurxJN0pMY1Iy0i4N6dYJ6eY2vOSsEO) jsem vám ukázal, jak lze specifické řešení pro jednu aplikaci přeměnit v univerzální komponentu.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/BOyD6d6prUI" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

To vše formou "skoro live codingu". Z různých logistických důvodů jsem to nechtěl dělat jako přímo živé kódování, ale zároveň jsem nechtěl, aby to bylo jako připravené demo. Takže ve videu najdete různé moje záseky a chyby, které pobaví, protože škodolibost je nejčistší lidská radost, ale také vám umožní se z cizích, tedy mých, chyb poučit.

## Díl první: Prvotní aplikace

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/dTVRO1PW2CY" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

V prvním dílu vytvořím řešení pro konkrétní ukázkovou aplikaci. Používá jako úložiště Entity Framework, formátuje pomocí Markdownu a asi jste něco takového psali mnohokrát.

* [Zdrojové kódy ke stažení](https://www.cdn.altairis.cz/Blog/2022/20220809-DemoStaticContent-G1.zip)

## Díl druhý: Základní abstrakce a View Component

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/pcA8_xwlSoY" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

Ve druhém dílu do architektury zavedu základní abstrakci pomocí jednoduchého rozhraní (což mi umožní konkrétní implementaci později změnit). Také zařídím syntakticky snazší použití celé věci pomocí vlastní view komponenty.

* [Zdrojové kódy ke stažení](https://www.cdn.altairis.cz/Blog/2022/20220816-DemoStaticContent-G2.zip)

## Díl třetí: Lepší abstrakce

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/kzNZelAs98A" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

Minule jsme skončili vytvořením jakési abstrakce pomocí rozhraní. Nebylo to ale příliš elegantní, proto v tomto dílu rozdělíme funkcionalitu získávání dat a formátování - v zásadě jde o snahu o dodržování SOLID principů a zejména ISP - Interface Separation Principle.

* [Zdrojové kódy ke stažení](https://www.cdn.altairis.cz/Blog/2022/20220823-DemoStaticContent-G3.zip)

## Díl čtvrtý: Abstrakce DbContextu a logování

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/FLE-CA5mHH8" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

V našem putování od specifického řešení k univerzální komponentě zbývá poslední překážka: Přílišná vazba na konkrétní DbContext. Ve čtvrtém dílu vám ukážu, jak pomocí interface umět napojit našeho providera na jakýkoliv DbContext. Také do našeho řešení přidáme standardní logování, abychom mohli sledovat co dělá.

* [Zdrojové kódy ke stažení](https://www.cdn.altairis.cz/Blog/2022/20220830-DemoStaticContent-G4.zip)

## Díl pátý: GitHub repozitář a vytvoření komponenty

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/wbqflHaLBsA" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

Dosud jsem pracoval stále s jednou konkrétní aplikací. V tomto pokračování vytvořím repozitář na GitHubu a proof of concept aplikaci přetvořím ve dva projekty: Samostatnou komponentu pro správu obsahu a ukázkovou aplikaci, která ji využívá.

* [Zdrojové kódy na GitHubu](https://github.com/ridercz/Altairis.Services.StaticContent/tree/01b0a31a908f5ae0b5447ee91987e85c5cfae460)

## Díl šestý: Konfigurace

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/noqtX7i4D_4" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

Podmínkou pro univerzální použitelnost kódu je možnost jeho konfigurace. Proto v tomto pokračování vytvořím konfigurační infrastrukturu: pevně zakódované parametry nahradím vlastními konfiguračními objekty, injectovanými pomocí Options patternu.

* [Zdrojové kódy na GitHubu](https://github.com/ridercz/Altairis.Services.StaticContent/tree/d1f3d981dd9cb84e72cb1e007ed007c6ad074ff4)

## Díl sedmý: Registrace služeb

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/YjWPxUbZyfo" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

S tvorbou komponenty pro statické texty se blížíme do finále. V tomto díle bude mým cílem odstranit nepohodlnou registraci služeb do IoC/DI. Vytvořím registrační extension metody, které budou sloužit uživatelům naší komponenty k její inicializaci a konfiguraci.

* [Zdrojové kódy na GitHubu](https://github.com/ridercz/Altairis.Services.StaticContent/tree/bc433633440297138d9e151c5876395fc350058e)

## Díl osmý: Tvorba a publikace NuGet balíčku

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/X5whPQTtKDs" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

Komponenta pro statické texty je hotová. V posledním dílu seriálu z ní udělám NuGet balíček a publikuji ji na serveru [NuGet.org](https://www.nuget.org/).

* [Zdrojové kódy na GitHubu](https://github.com/ridercz/Altairis.Services.StaticContent/tree/9a97a7376b251a7505efa09dcfa8d6353a7be2b3)

## A co dál?

Komponenta je hotová a můžete ji začít používat. Její zdrojáky [najdete na GitHubu](https://github.com/ridercz/Altairis.Services.StaticContent), takže se můžete zapojit do vývoje. Už mi tam přistály [nějaké pull requesty](https://github.com/ridercz/Altairis.Services.StaticContent/pulls), které jsem zatím neměl čas zkoumat. Rozhodně je také dobré napsat nějakou dokumentaci, protože `README.md` zeje prázdnotou. Snad se k tomu brzo dostanu.