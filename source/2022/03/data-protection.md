<!-- dcterms:title = ASP.NET Data Protection: Vše co o něm potřebujete vědět -->
<!-- dcterms:abstract = Pro ochranu (šifrování a digitální podepisování) dat je v ASP.NET Core funkce Data Protection. Ve čtyřech dílech video seriálu vám o ní řeknu všechno, co potřebujete vědět. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/faux-code-1.svg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20211021-dotnet-raspi-2.jpg -->
<!-- x4w:coverCredits = Chunli Ju via Unsplash.com -->
<!-- x4w:category = Z-TECH -->
<!-- x4w:category = IT -->
<!-- dcterms:date = 2022-03-03T12:00:00 -->

Pro ochranu (šifrování a digitální podepisování) dat je v ASP.NET Core funkce Data Protection. Ve čtyřech dílech video seriálu vám o ní řeknu všechno, co potřebujete vědět.

## Zdrojové kódy ke stažení

* [První část](https://www.cdn.altairis.cz/Blog/2022/20220303-dataprotection-1.zip) - základní použití a konfigurace
* [Druhá část](https://www.cdn.altairis.cz/Blog/2022/20220303-dataprotection-2.zip) - ukládání klíčů do databáze a programová správa

## Použití

První díl popisuje ASP.NET Data Protection obecně. Ukazuje k čemu slouží a hlavně jak ho používat pro vaše vlastní účely.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/_T-hz9vMtPA" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

## Omezení časové platnosti

Ve druhém dílu jsem se zaměřil na relativní ale užitečnou drobnost - možnost časově omezit platnost payloadu.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/_vckwfU8duo" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

## Správa klíčů

Data protection umí fungovat v režimu zero configuration, kdy si klíče spravuje kompletně sám. Pro jednodušší aplikace to stačí, u těch složitějších je dobré to mít pod kontrolou a řešit ukládání klíčů (případně jejich dodatečnou ochranu) pro účely zálohy, synchronizace mezi více počítači a podobně.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/u7WxEnHwTEw" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

## Ukládání klíčů do databáze

Ukládání konfigurace do databáze obvykle není úplně dobrý nápad a klíče pro data protection jsou konfigurace sui generis. Nicméně v tomto případě má ukládání do databáze řadu výhod, proto jsem ve čtvrtém dílu popsal, jak používat ukládání klíčů do databáze pomocí rozhraní `IDataProtectionKeysContext` a Entity Frameworku. Také jsem popsal rozhraní `IKeyManager` a jeho použití pro programovou správu klíčů. 

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/e2mwUMrrxZ0" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>