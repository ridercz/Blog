<!-- dcterms:title = Šifrování pro každého -->
<!-- dcterms:abstract = "A vy jste už někdy šifroval? Nikdo nešifruje, samozřejmě." Tento výrok někdejšího náměstka ministra financí Ondřeje Závodského se s realitou míjí přímo ukázkově. Chcete umět šifrovat svoje data? Nový seriál vás to naučí. Chcete zašifrovat jeden soubor s citlivými daty? Udělat si šifrovaný kontejner? Zašifrovat přenosný flashdisk? Nebo dokonce celý systém, Windows nebo Linux? Ukážu vám, jak používat BitLocker, VeraCrypt nebo LUKS. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20231212-sifrovani-pro-kazdeho.jpg -->
<!-- x4w:coverUrl = /cover-pictures/20231212-sifrovani-pro-kazdeho.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = IT -->
<!-- x4w:category = Bezpečnost -->
<!-- dcterms:date = 2023-12-12 -->

"A vy jste už někdy šifroval? Nikdo nešifruje, samozřejmě." Tento výrok někdejšího náměstka ministra financí Ondřeje Závodského se s realitou míjí přímo ukázkově. Chcete umět šifrovat svoje data? Nový seriál vás to naučí. Chcete zašifrovat jeden soubor s citlivými daty? Udělat si šifrovaný kontejner? Zašifrovat přenosný flashdisk? Nebo dokonce celý systém, Windows nebo Linux? Ukážu vám, jak používat BitLocker, VeraCrypt nebo LUKS.

K čemu se jednotlivé varianty hodí?

* **Šifrování konkrétního souboru nebo archivu** je nejjednodušší a umožňuje ochránit konkrétní soubory, které nechcete jen tak nechat někde ležet. Také se hodí pro případy, kdy chcete někomu jinému poslat citlivá data a nevíte, komu se cestou mohou dostat do rukou. Můžete mu tak data poslat třeba e-mailem nebo poštou a heslo mu sdělit SMSkou a podobně.
* **Šifrování celého přenosného disku** se hodí ve chvíli, kdy máte svou "osobní flashku" s důležitými daty, kterou nosíte s sebou. Strčíte ji tu do počítače doma, tu v práci... Co kdybyste ji ztratili a někdo ji našel? Je to pro vás problém? Pak vám pomůže BitLocker To Go, který z jakékoliv flashky udělá šifrovanou.
* **Multiplatformní VeraCrypt** vás bude zajímat, pokud se neomezujete jenom na Windows. Jeho použití není tak snadné, ale funguje i na Linuxu a Macu. A umí docela zajímavé věci.
* **Šifrování systémového disku** zařídí, že se bude šifrovat prostě všechno, co na počítači máte. Včetně třeba dočasných souborů a podobně. Na Windows k tomu slouží BitLocker nebo Device Encryption, na Linuxu LUKS. Použití těchto nástrojů je podle mého názoru věcí základní informační hygieny, a to i pro případ ztráty nebo třeba reklamace daného zařízení.
* **Pre-boot autentizace** nabízí ještě větší úroveň bezpečí. Ve výchozím nastavení je u BitLockeru obsah disku chráněn pomocí TPM, Trusted Platform Modulu. Tj. když útočník najde vypnutý počítač, operační systém normálně nabootuje a čeká na přihlášení. To ho otevírá celé řadě útoků. Netriviálních, ale možná jsou součástí vašeho threat modelu. Pokud ano, chcete zapnout autentizaci ještě před bootem operačního systému, kterou podporuje jak BitLocker na Windows tak LUKS na Linuxu. V takovém případě musíte zadat heslo ještě předtím, než operační systém vůbec začne startovat. Což vám sice poněkud zkomplikuje život (např. tím, že není možné systém na dálku restartovat), ale mnohem víc to zkomplikuje život útočníkovi.

## Použití programu 7-Zip

Začneme zlehka. [7-Zip](https://www.7zip.org) většina lidí zná jako výborný komprimační program a tím také bezpochyby je. Ale kromě toho disponuje i možností vytvořené 7Z archivy zašifrovat pomocí standardního algoritmu AES. Nějakou formu "ochrany heslem" nabízí kdejaký program a formát, ale skutečná úroveň bezpečnosti se mezi jednotlivými programy a jejich verzemi dramaticky liší. Takže pokud potřebujete zašifrovan nějaká specifická data, třeba pro přenos nespolehlivým způsobem nebo pro archiv, 7-Zip je docela dobrá volba.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/EdjLHSNW2qc" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

## BitLocker To Go

Další level představuje šifrování celého přenosného úložiště, třeba USB flashky. Asi nejjednodušší způsob jak něco takového udělat představuje BitLocker To Go. Je součástí Windows už řadu verzí a funguje na nich jednoduše a spolehlivě. Má ovšem dvě nevýhody. První je, že pořádně funguje jenom na Windows a pokud tedy potřebujete šifrovanou flashku přečíst i na jiném operačním systému, není to řešení pro vás. Druhá nevýhoda je, že pro vytvoření šifrovaného disku potřebujete Pro edici Windows, nestačí Home edice. Pro práci s diskem pak můžete použít Windows Home, ale vytvořit ho musíte na Pro.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/tHg01Nasq2w" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

## VeraCrypt

Pokud je pro vás důležitá nezávislost na platformě, je tady pro vás [VeraCrypt](https://veracrypt.fr/), nejvíce životaschopný nástupce legendárního programu TrueCrypt. Funguje na Windows, Linuxu i Mac OS. Jeho použití není tak jednoduché jako v případě BitLockeru, ale zato nabízí víc možností. Věnoval jsem mu hned tři díly tohoto seriálu.

První díl ukazuje základní použití se souborovým kontejnerem:

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/ji5T0suq6co" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

Další díl ukazuje, jak vytvořit hidden volume. Tedy takový, který lze "otevřít" dvěma hesly - a pro každé vydá jiný obsah. Představuje jistou formu proti "kryptoanalýze gumovou hadicí". Tedy proti situaci, kdy se útočník pokusí z vás heslo dostat nátlakem. Pokud jste na to připraveni, můžete vyzradit krycí heslo a nebude možné zjistit - natož prokázat - že kontejner obsahuje i něco jiného.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/wpuS8n4aGEM" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

Poslední díl věnovaný VeraCryptu ukazuje, jak pomocí něj zašifrovat celý disk. VeraCrypt umí zašifrovat celý disk nebo konkrétní partition. Pokud zašifrujete celý disk, bude vypadat jako zcela nový, nikdy nepoužitý a nebude možné zjistit, že na něm jsou uložena nějaká šifrovaná data (natož je dešifrovat), což nabízí další možnost plausible deniability. Pokud by vám to bylo málo, můžete to zkombinovat s předchozím tipem a udělat na něm hidden volume.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/i5IpQgQE1VQ" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

## Intermezzo - proč vlastně šifrovat?

Kdo nic neprovedl, nemá se čeho bát. Spořádaný občan šifrování nepotřebuje. Mantry odpůrců práva na soukromí. Proč byste o šifrování měli stát, i když na svém počítači nemáte nic super tajného? 

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/ZS6BcXatdX8" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

## "Plnokrevný" BitLocker a šifrování systémového disku

O verzi "To Go" už řeč byla hned ve druhém dílu našeho seriálu. Ale "plnokrevný" BitLocker toho umí víc. Třeba zašifrovat i systémový disk a ochránit tak celý počítač.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/gvHDAQj8TEk" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

BitLocker umí zašifrovat disk i tak, že bude nutné ještě před startem operačního systému zadat heslo (kterému říká PIN). To umožní ochránit vypnutý počítač před ještě větším množstvím útoků.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/jC02daVBWHc" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

## LUKS - Linux Unified Key Setup

Obdobou BitLockeru pro Linux je program jménem LUKS - Linux Unified Key Setup. Umí toho opravdu hodně, včetně podpory TPM a dalších věcí, ale to už jsou záležitosti poněkud za hranicemi tohoto seriálu. Nicméně ukážu vám, jak LUKS jednoduše zkonfigurovat při instalaci Ubuntu a ochránit disk heslem, který je nutné zadat před spuštěním.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/QqkNzMPKfYI" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>