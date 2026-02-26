<!-- dcterms:title = Projekt Kiwix: Wikipedia a další weby i bez Internetu -->
<!-- dcterms:abstract = Chcete mít kompletní Wikipedii dostupnou offline? Nebo celou řadu dalších webů? Pomůže vám projekt Kiwix. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:date = 2026-02-26 -->
<!-- x4w:category = IT -->
<!-- x4w:pictureUrl = /perex-pictures/20260226-kiwix.jpg -->
<!-- x4w:coverUrl = /cover-pictures/20260226-kiwix.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->

Na Internetu najdete spoustu informačních zdrojů, s Wikipedií v čele. Ale jak si poradit, když je chcete používat a nemáte připojení k Internetu?

[Projekt Kiwix](https://kiwix.org/) je pro mne takovou reminiscencí devadesátých let, kdy se za připojení k Internetu platilo podle času a ve špičce to bylo dražší než mimo ni. Existovala tedy dnes zapomenutá technologie PointCast, která se v noci za levnějšího tarifu připojila a do zásoby stáhla vaše oblíbené weby, abyste si je pak přes den mohli číst, aniž byste se museli připojovat.

Kiwix umí obsah celého webu stáhnout do jednoho souboru (s příponou `.zim`) a pak si můžete tento web pomocí speciálního prohlížeče číst i bez připojení k Internetu. Zároveň vytvoří i fulltextový archiv, takže můžete web offline prohledávat.

Něco takového má samozřejmě smysl jenom u webů víceméně statických, jako je třeba blog nebo již zmíněný Wikipedie, zpracovat takto třeba eshop nebude k ničemu.

Kdy se to celé hodí? Samozřejmě se nabízí melodramatický obraz konce civilizace a záchrany vědomostí celého lidstva touto cestou. Ale existují i méně dramatické scénáře, kdy se něco takového může hodit. Obecně všude, kde připojení k Internetu není vůbec, nebo je nějakým způsobem omezené: pomalé, nespolehlivé nebo třeba drahé. To může být při cestování (letadlem, lodí nebo třeba i vlakem mimo dobré pokrytí), dovolené na místě kde není dobrý signál nebo třeba jenom v zahraničí na místě s drahým roamingem.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/IGi69RVkrz0" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

Na webu projektu si můžete [stáhnout několik prohlížečů](https://kiwix.org/en/applications/):

* Samostatnou prohlížecí aplikaci pro všechny možné platformy (Windows, Linux, Mac OS, iOS a Android).
* Plugin pro webový prohlížeč (Edge, Firefox, Chrome).
* Server, který zpřístupní obsah jakémukoliv prohlížeči v lokální síti.
* [Kiwix Hotspot](https://kiwix.org/en/kiwix-hotspot/), což je placené řešení typu _all in one_, kde máte Raspberry Pi (nebo image SD karty pro něj) a ten ze sebe udělá Wi-Fi hotspot a zpřístupní svou knihovu.

Zároveň je k dispozici [knihovna zdrojů](https://library.kiwix.org/) už připravených ve formátu ZIM. Jde o volně dostupné zdroje typu Wikipedia, Projekt Gutenberg, TED přednášky a další. Můžete si je filtrovat podle tématu nebo jazyka.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/oAEowMXcHZM" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

Pokud vám hotové ZIM archivy nestačí, můžete si vytvořit vlastní. Uživatelsky nepřívětivější je web [ZimIt](https://zimit.kiwix.org/), kam stačí zadat adresu webu (a případně nějaká metadata) a on vytvoří jeho ZIM verzi. Potíž je, že trvá dost dlouho, než na vás dojde řada.

Na [GitHubu openZIM](https://github.com/openzim/) najdete nástroje, jak ZIM archivy vytvářet z různých zdrojů sami, ale to už je pro poněkud pokročilejší uživatele.

Zajímavý je skript wget-2-zim, který umí stáhnout web pomocí utility Wget a pak z něj udělat ZIM archiv. Drobnou nevýhodou je, že jde o bash skript, který funguje jenom na Linuxu. Na Windows k jeho běhu můžete použít [Windows Subsystem for Linux](https://www.altair.blog/2026/02/wsl). K dispozici je [oficiální repository](https://github.com/ballerburg9005/wget-2-zim), já jsem skript poněkud vylepšil a poslal pull request, který nicméně zatím nebyl zařazen do hlavní větve, pull request čeká na přijetí. Mezitím si mou verzi můžete stáhnout na [mém GitHubu](https://github.com/ridercz/wget-2-zim/).

---

Vzhledem k tomu, že na jednu MicroSD kartu o velikosti 256 GB (která dnes stojí okolo 750 Kč) se vejde kompletní anglická i česká Wikipedie včetně obrázků, knihy českého i anglického Gutenberga a řada dalších zdrojů, se myslím vyplatí něco takového vytvořit a čas od času aktualizovat. Kdyby už jenom pro případ toho konce světa.