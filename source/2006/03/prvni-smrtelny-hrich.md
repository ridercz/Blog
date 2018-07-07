<!-- dcterms:identifier = aspnetcz#83 -->
<!-- dcterms:title = První smrtelný hřích -->
<!-- dcterms:abstract = Ve svém článku o mailování z ASP.NET 2.0 jsem napsal, že posílání mailů v HTML považuji za druhý nejhorší programátorský hřích. Tato zmínka vyvolala předpokládané dotazy, jaký že je tedy ten první nejhorší hřích, jakého se dle mého názoru může .NET vývojář dopustit. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Tipy, triky -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2006-03-15T14:35:57.673+01:00 -->
<!-- dcterms:dateAccepted = 2006-03-15T14:35:57.673+01:00 -->

Ve svém [článku o mailování z ASP.NET 2.0](https://www.aspnet.cz/Articles/79-odesilani-e-mailu-z-prostredi-net-2-0.aspx) jsem napsal, že posílání mailů v HTML považuji za druhý nejhorší programátorský hřích. Tato zmínka vyvolala předpokládané dotazy, jaký že je tedy ten první nejhorší hřích, jakého se dle mého názoru může .NET vývojář dopustit. 

Když se podíváte do diskusních fór a konferencí, najdete poměrně dost dotazů typu: *Jak může moje ASP.NET aplikace pracovat se systémovým registrem na klientově počítači? Jak mohu zakázat použití tlačítka „Zpět“ v prohlížeči? Jak poznám, že uživatel opustil stránku zavřením prohlížeče, aniž by se odhlásil?*

Na takové otázky se nedá odpovědět, protože jejich tazatel zcela zjevně nepochopil samotný princip webových aplikací. Ubohý programátor, izolovaný od komunikačního protokolu vrstvami ASP.NET abstrakcí, netuší nic o principu a povaze toho, s čím pracuje. Panensky nepostižen informacemi o bezstavovosti HTTP a omezeními HTML nadává, že ASP.NET jsou hloupé a neumožňují mu udělat to, co slíbil šéfovi.

Je nám znám případ firmy, která pro svůj silně zatěžovaný databázový server sice zakoupila hromadu paměti a několik procesorů, ale pouze jeden disk, na němž je operační systém, data, logy zálohy…

**Prvním smrtelným programátorským hříchem je podle mne týrání počítačů.** Takové týrání může mít mnoho podob, ale příčina bývá obvykle tatáž: hloupost a naprostý nezájem vědět něco o použité technologii.

Důsledky těchto hříchů jsou závažné a dalekosáhlé. Programátoři či administrátoři ztratí hodiny řešením neřešitelného problému. Systém je pomalý a uživatelé nadávají. Aplikace funguje jenom v poslední verzi prohlížeče a to pouze každé liché úterý od tří do pěti. Hardware nakupovaný dle hesla „co nejde silou, jde ještě větší silou“ stojí hromadu peněz, aniž by se tato investice nějak pozitivně projevila…

Jak prvnímu smrtelnému hříchu předcházet? V první řadě tím, že se naučíte něco o principech technologie, kterou používáte. Nemyslím syntaxi programovacího jazyka a názvy tříd, ale filozofii a architekturu.

Pokud tak učiníte, dosáhnete vyššího stupně osvícení, kdy budete schopni rozhodnout, kdy kterou technologii použít. Nemůžete-li žít s tím, že uživatelé mohou otevírat nová okna a používat tlačítko „Zpět“, pak je nesmysl psát danou aplikaci jako webovou. Někdy – ne vždy – existují kličky a smyčky, které vám umožní dané omezení „obejít“, třeba pomocí klientských skriptů a podobně. Výsledek však pravidelně bývá takový, jako když vrut místo zašroubování do prkna namlátíte velkým kladivem. Bude to na první pohled vypadat jak má, ale pouze do okamžiku kdy své dílo podrobíte reálné zátěži. Pak se ukáže, že zatlučené šrouby nedrží.