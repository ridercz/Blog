<!-- dcterms:title = ASP.NET Core Health Checks: Jak sledovat zdraví vaší aplikace -->
<!-- dcterms:abstract = Pokud provozujete webovou aplikaci, je dobré vědět, že se těší dobrému zdraví. Že běží, odpovídá na HTTP requesty, ale také že běží správně. Tedy nejenom že běží web server, ale třeba také jestli se dokáže připojit k databázi, k cloudovému úložišti, jestli je dost místa na disku, jestli nezabírá moc paměti a podobně. To lze samozřejmě monitorovat zvnějšku aplikace, například pomocí performance counterů, ale to musíte mít pod kontrolou celou infrastrukturu, což často není možné nebo praktické. Proto je v ASP.NET Core přítomna technologie health checků, které fungují zevnitř. Aplikace pomocí nich dokáže otestovat sama sebe a reportovat, zda jednotlivé její části fungují tak jak mají. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:coverCredits = Midjourney AI -->
<!-- x4w:coverUrl = /cover-pictures/20221229-healthchecks.jpg -->
<!-- x4w:pictureUrl = /perex-pictures/20221229-healthchecks.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = Z-TECH -->
<!-- x4w:category = IT -->
<!-- dcterms:date = 2022-12-29 -->
<!-- x4w:dateUpdated = 2023-01-19 -->

Pokud provozujete webovou aplikaci, je dobré vědět, že se těší dobrému zdraví. Že běží, odpovídá na HTTP requesty, ale také že běží správně. Tedy nejenom že běží web server, ale třeba také jestli se dokáže připojit k databázi, k cloudovému úložišti, jestli je dost místa na disku, jestli nezabírá moc paměti a podobně. To lze samozřejmě monitorovat zvnějšku aplikace, například pomocí performance counterů, ale to musíte mít pod kontrolou celou infrastrukturu, což často není možné nebo praktické. Proto je v ASP.NET Core přítomna technologie health checků, které fungují zevnitř. Aplikace pomocí nich dokáže otestovat sama sebe a reportovat, zda jednotlivé její části fungují tak jak mají.

Pro [kanál Z-TECH](https://www.youtube.com/ztechcz) jsem připravil seriál videí, který se věnuje tomuto tématu. 

* [Playlist](https://www.youtube.com/playlist?list=PLFZurxJN0pMbFy_R9q7MQwPAwA_bwIZyG)
* [Příklady ke stažení](https://www.cdn.altairis.cz/Blog/2022/20221229-HealthChecks.zip)

## Úvod

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/6CdbAwoH4uY" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

V úvodním videu se podíváme na to, jak technologie health checků vlastně funguje, jak registrovat jednotlivé checky, jak je pomocí HTTP requestu spouštět a jak získat výsledek.

## Formátování výstupu a publishers

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/emteqjZdFNw" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

Ve vychozím nastavení je výsledkem volání health checku pouze informace _Healthy_ (všechno je OK), _Unhealthy_ (někde je problém) a _Degraded_ (ještě není problém, ale nejspíš brzo bude). Lze nicméně napsat vlastní formátování výstupu a pomocí něj dát vědět, co je vlastně špatně. Ukážu vám, jak vrátit JSON dokument s výpisem všech checků a jejich výsledků. Nadřízený monitorovací systém tak může - pokud danému formátu rozumí - lépe poznat, co se v aplikaci děje.

Také nemusí nutně platit, že health checky se spouštějí v návaznosti na HTTP požadavek zvenčí. Pomocí publisherů lze celou logiku obrátit. Tedy checky spouštět pravidelně v nastavených časových intervalech a jejich výsledky "tlačit" někam jinam, třeba je posílat do nějakého API.

## Knihovna AspNetCore.Diagnostics.HealthChecks

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/HrGUqyYU1Ps" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

Health checky nemusíte psát sami. Často to je potřeba, pokud potřebujete otestovat zdraví nějakých subsystémů, které jsou specifické pro vaši aplikaci. Ale mnohdy jde o vcelku standardizované věci, jako jsou systémové parametry (disk, paměť...) nebo externí služby (databáze, cloudová úložiště a API...). Existuje open source knihovna [AspNetCore.Diagnostics.HealthChecks](https://github.com/Xabaril/AspNetCore.Diagnostics.HealthChecks), která obsahuje desítky již hotových checků, které stačí jenom zkonfigurovat a použít.

## HealthChecks UI

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/AD_1dTNq4F4" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

V předchozím videu zmíněná knihovna AspNetCore.Diagnostics.HealthChecks umí ještě jednu zajímavou věc: vytvořit hezké webové grafické uživatelské rozhraní, které umožní podívat se na stav aplikace, a ukládat historii změn stavů checků do nějakého trvalého úložiště, typicky do databáze. S health check infrastrukturou přitom komunikuje pomocí HTTP a JSON formátovaného výstupu, takže to webové UI může běžet úplně jinde, než samotná aplikace.

## Externí služby pro monitoring stavu

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/7W_7GtgPsfM" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

Mít API pro health checks je jenom polovina řešení. Ještě potřebujete něco, co bude zdraví aplikace pravidelně kontrolovat a dá vám vědět, že je něco špatně. Ukážu vám dvě služby, UptimeRobot a Wedos Online, které to umí - a do určitého rozsahu zdarma.