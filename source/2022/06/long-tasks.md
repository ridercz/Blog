<!-- dcterms:title = Dlouze běžící úlohy jako zabiják výkonu webových aplikací -->
<!-- dcterms:abstract = Jedním z největších problémů webového vývoje jsou dlouho běžící úlohy zpracovávané na web serveru. Web servery na ně nejsou připraveny a neumí si s nimi dobře poradit. Připravil jsem seriál videí a příkladů, které radí, jak si s tímto fenoménem poradit. V tomto článku najdete souhrn všech dílů ve věcně logickém pořadí (které z různých důvodů neodpovídá pořadí, v jakém byly zveřejněny). -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20220622-long-tasks.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20220622-long-tasks.jpg -->
<!-- x4w:category = Z-TECH -->
<!-- x4w:category = IT -->
<!-- dcterms:dateAccepted = 2022-06-22 -->

Jedním z největších problémů webového vývoje jsou dlouho běžící úlohy zpracovávané na web serveru. Web servery na ně nejsou připraveny a neumí si s nimi dobře poradit. Připravil jsem seriál videí a příkladů, které radí, jak si s tímto fenoménem poradit. V tomto článku najdete souhrn všech dílů ve věcně logickém pořadí (které z různých důvodů neodpovídá pořadí, v jakém byly zveřejněny).

## Zdrojové kódy příkladů

Všechny zdrojové kódy najdete v [repozitáři NetUtilsDemo na mém GitHubu](https://github.com/ridercz/NetUtilsDemo).

## Předehra: Traceroute a ping

Pro dema jsem potřeboval nějaký příklad dlouho (sekundy, desítky sekund a déle) běžící úlohy. Většina reálných úloh tohoto typu jsou logicky věci dosti náročné a pro dema nevhodné, jako náročné databázové věci, generování reportů, práce s velkými objemy dat... Nicméně pro síťovou diagnostiku se používají příkazy `ping` a `traceroute`/`tracert`. 

Jejich běh trvá dost dlouho, ale přitom jsou vlastně velice jednoduché. Jsou tedy ideálním příkladem pro dema. V následujícím videu vysvětluji jak fungují a jak je napsat v C#:

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/yglCUKiZcnw" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

## Úvod: Proč to chceme řešit a jak

Časově poslední vydaný díl seriálu je z hlediska věcného vlastně tím prvním. Vysvětluje totiž, proč vlastně vše děláme tak komplikovaně a prostě to neuděláme na web threadu web serveru.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/rv-QWxcciGQ" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

## Background workery a jejich hostování

Abychom si všechno nemuseli dělat sami, má .NET interface `IHostedService` a třídu `BackgroundWorker`, která slouží k hostování kódu, který ony dlouhé operace dělá. Ty lze pak hostovat různým způsobem.

První video popisuje, jak napsat vlastní Windows Service (službu) a použít ji pro hostování našeho background workeru:

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/-8phkcv4QB8" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

Druhé video pak, jak background worker hostovat přímo ve webové aplikaci ASP.NET Core:

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/SHF5WSHr7RU" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

## Windows Services a jejich identita

První video této části je tady pro pořádek. Netýká se přímo background workerů, ale popisuje jak můžete webovou aplikaci psanou v ASP.NET Core rozjet jako Windows Service, bez nutnosti instalovat a používat IIS:

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/P0oJQR2SJMg" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

Druhé se pak zabývá nastavením identity Windows Service:

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/f2acAHLhsYE" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

Michael Grafnetter mi ukázal lepší způsob práce s identitou Windows Services, který jsem neznal, Virtual Service Identity. Jím se zabývá třetí video tohoto bloku:

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/qYb2W0kYGBg" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

## Co se jinam nehodilo

Poslední video, které s tématem souvisí, byť úplně nezapadá do série, je představení knihovny Hangfire. Tu lze chápat jako jistou alternativu k background workerům. Má velice široké možnosti, i když vyžaduje ne zcela triviální nastavení databázového úložiště.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/36p2-gr_iYk" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

## Co plánuji do budoucna

Často v této sérii mluvím o použití front, ale vlastně jsem žádnou nepředvedl, resp. realizoval jsem ji pomocí tabulky v databázi, což je řešení sice časté, ale svým způsobem limitující. Plánuji udělat videa o používání různých druhů front jak lokálně, tak v prostředí Microsoft Azure.

Když už jsme u cloudu, tak pro úlohy na pozadí lze s výhodou použít koncept Web Jobs, takže chci udělat video i o něm. V tomto kontextu je zajímavý i serverless koncept, Azure Functions. O tom vůbec nic nevím, ale už dlouho ho mám na seznamu věcí které se chci naučit. Pokud je běžně používáte a chcete mi s tvorbou videa o nich nějakým způsobem pomoci, tak neváhejte a kontaktujte mne!