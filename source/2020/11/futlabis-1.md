<!-- dcterms:title = Záznam live codingu aplikace v .NET 5.0 a pozvánka na pokračování -->
<!-- dcterms:abstract = Před pár dny Microsoft vydal následovníka .NET Core jménem .NET 5. První aplikace, kterou v něm píšu, bude rezervační systém pro makerspace FutLab. Nabízím vám záznam prvního streamu a pozvánku na další. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20201115-futlabis-1.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20201115-futlabis-1.jpg -->
<!-- x4w:category = IT -->
<!-- dcterms:dateAccepted = 2020-11-15 -->

Před pár dny Microsoft vydal následovníka .NET Core jménem .NET 5. První aplikace, kterou v něm píšu, bude rezervační systém pro makerspace FutLab a rozhodl jsem se, že její tvorbu budu živě streamovat.

## Jakou aplikaci píšu

Aplikaci popisuje tento [design document](https://1drv.ms/w/s!Apo4M7bgM3zBz69X-y8zIZAgBQDN5w). Nicméně jde o jednoduchou aplikaci, která bude držet databázi uživatelů a zdrojů (např. prostor či strojů) a bude umožňovat rezervaci času na nich.

Něco podobného jsem [už kdysi napsal](https://github.com/ridercz/Rap) v ASP.NET MVC 5, ale přijde mi jednodušší napsat novou verzi od základu znovu než upgradovat ten starý projekt.

## Obsah prvního dílu

* Seznámení se zadáním.
* Tvorba [repozitáře na GitHubu](https://github.com/ridercz/FutLabIS).
* Vytvoření struktury solution.
* Vytvoření data access layer prostřednictvím Entity Frameworku a migrací.
* Vytvoření základní grafiky a stylování webu pomocí SCSS.
* Konfigurace a bootstrapping ASP.NET Identity.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/uGJr0YJGXpk" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

## Pokračování příště

> * **Kdy:** středa 17. listopadu 2020 od 17:00.
> * **Kde:** [YouTube stream](https://youtu.be/uSCWcdQYaoU) - tamtéž bude dostupný ihned po skončení záznam.
> * [Stránka události na Facebooku](https://fb.me/e/280cWpJPA) kde můžete v předstihu pokládat dotazy.

Hlavním tématem druhého dílu bude vytvoření infrastruktury pro přihlášení, odhlášení, reset hesla apod. To si ovšem vyžádá nějaké prerekvizity:

* Instalace a konfigurace knihovny [Conventional Metadata Providers](https://github.com/ridercz/Altairis.ConventionalMetadataProviders) pro lokalizaci validačních chyb a dynamicky generovaného uživatelského rozhraní.
* Instalace a konfigurace knihovny [Altairis.Services.Mailing](https://github.com/ridercz/Altairis.Services.Mailing) pro rozesílání mailů.
* Vytvoření uživatelského rozhraní pro přihlášení a odhlášení uživatele.
* Implementace resetu hesla.
* Stylování formulářů.

Na zítřek už mám připravený [jiný stream](https://www.altair.blog/2020/11/obcanka-1), ale pokračování plánuji na středu podvečer. 

