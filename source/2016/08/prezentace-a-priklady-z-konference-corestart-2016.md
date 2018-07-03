<!-- dcterms:identifier = aspnetcz#5448 -->
<!-- dcterms:title = Prezentace a příklady z konference CoReStart 2016 -->
<!-- dcterms:abstract = U příležitosti restartu nového .NET Frameworku jsme uspořádali konferenci CoReStart 2016. Nyní vám nabízím prezentace a příklady z ní. -->
<!-- np9:categoryId = 6 -->
<!-- x4w:category = Akce a události -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2016-08-25T18:09:43.187+02:00 -->
<!-- dcterms:dateAccepted = 2016-08-25T18:00:00+02:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20160825-prezentace-a-priklady-z-konference-corestart-2016.png -->

U příležitosti restartu nového .NET Frameworku jsme uspořádali konferenci [CoReStart 2016](https://www.corestart.cz/). Nyní vám nabízím svoje prezentace a příklady z ní. Na zpracování záznamů se pracuje, ale bude to nějakou dobu trvat. Až budou hotové, najdete je na [YouTube kanále společnosti Altairis](https://youtube.com/altairiscz).

*   <div style="text-align: left;">**[Prezentace a příklady ke stažení](http://www.cdn.altairis.cz/Prednasky/20160818-CoreStart.zip)** jako ZIP, 4 MB.</div>  

V první přednášce jsem se vám snažil sdělit, **co vlastně ASP.NET Core 1.0 je**. Že to je defacto restart platformy .NET, neboť Microsoft po čtrnácti letech naznal, že je třeba. Ačkoliv idea .NETu je dobrá, mnoho rozhodnutí učiněných v době, kdy ještě žila britská královna matka a premiérem ČR se s heslem "zdroje tu jsou" stal Vladimír Špidla, je z dnešního pohledu nešťastných. Nový .NET Core sice neumí zdaleka všechno, co stávající .NET Framework, ale je postavený způsobem, který nám zase nějakou dobu vydrží.

Dále jsem se zabýval **hostováním a nasazením .NET Core aplikací**. Zde se toho změnilo opravdu hodně, protože Core aplikace jsou hostovány ve vlastním serveru Kestrel a IIS jim slouží jenom jako publikační proxy. Nasadit Core aplikaci na klasické IISko tedy vyžaduje jisté změny oproti tomu, na co jsme zvyklí.

Třetím tématem byla **konfigurace Core aplikací**. Zatímco dosavadní .NET měl všechno v XML web.config souborech, nový Core na to jde jinak. Konfigurace IIS zůstává nadále ve web.configu, zatímco konfigurace komponent frameworku probíhá v kódu a žádný vlastní konfigurační soubor nevyžaduje. Pro vaše vlastní konfigurační nastavení je zde zajímavý a rozšiřitelný systém, který jsem vám na příkladech představil.

Poslední přednáška se věnovala **ochraně tajemství v Core aplikacích**. Předchozí generace má systém [Machine Keys](http://www.aspnet.cz/articles/5427-pohodlna-kryptografie-v-asp-net-pomoci-machine-keys), nová má ASP.NET Data Protection (nezaměňovat s DPAPI, Windows Data Protection API). To staví na základech Machine Keys, ale přidává řadu nových možností a především řeší velikou bolest Machine Keys, totiž obtížnou změnu klíčů.