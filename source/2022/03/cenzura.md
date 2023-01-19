<!-- dcterms:title = Obcházení cenzury Internetu -->
<!-- dcterms:abstract = Ruská vláda blokuje weby, které označuje jako dezinformační; česká také, ale nemohou se shodnout na tom, které to jsou. Jak takovou cenzuru obejít? Ukážeme si hned tři způsoby, jaké vám mohou v podobných případech pomoci. -->
<!-- x4w:category = Politika -->
<!-- x4w:category = Bezpečnost -->
<!-- x4w:category = Z-TECH -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:date = 2022-03-13 -->
<!-- x4w:pictureUrl = /perex-pictures/20200103-screenly-shutdown.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20200103-screenly-shutdown.jpg -->
<!-- x4w:coverCredits = Aleksandar Cvetanovic (@lemonzandtea) via Unsplash.com -->

Ruská vláda blokuje weby, které označuje jako dezinformační; česká také, ale nemohou se shodnout na tom, které to jsou. Jak takovou cenzuru obejít? Ukážeme si hned tři způsoby, jaké vám mohou v podobných případech pomoci.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/aQpFJCrdLFk" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

## Opera "VPN"

Na nejnižší úrovni stačí si nainstalovat prohlížeč Opera a použít funkci, kterou nazývá VPN. Ve skutečnosti nejde o klasickou virtuální privátní síť ale spíše o proxy server, ale to je technologický detail. Prakticky funguje tak, že se z vašeho počítače ustanoví šifrovaný tunel na servery Opery (a dokonce si můžete vybrat ve které zemi se mají nacházet) a odtamtud se pak požadavek pošle dál. Tím je skryta vaše IP adresa a geografická lokace, což může pomoci obejít nejobvyklejší formy blokování.

Je to jednoduché, ale má to i své nevýhody. V první řadě Operu momentálně vlastní čínská firma, které můžete a nemusíte věřit. V řadě druhé jsou adresy proxy serverů Opery veřejně známy a tato funkcionalita bude zřejmě jedna z prvních, kterou cenzura zablokuje.

## Vlastní VPN

O stupeň výše je tvorba vlastní VPN. Z pohledu běžného uživatele je nejsnazší použít projekt Outline, který udělá všechno za vás a má klienty pro desktopová i mobilní zařízení. O tom už jsem psal, takže jenom pár odkazů:

* [Nespoléhejte na komerční VPN, mají slabiny. S projektem Outline si snadno vytvoříte vlastní](https://tech.hn.cz/c7-66666540-psms7-740eeccb76b34cc)
* [Bezplatné online školení a návod jak Outline nainstalovat a používat](https://elearning.altairis.cz/courses/outline)
* [Affiliate link pro DigitalOcean](https://altair.is/digitalocean), se kterým získáte kredit $100 na 60 dnů (jinak potřebný server vyjde na $5 měsíčně)

Výhodou vlastní VPN je zejména to, že se dost těžko blokuje, protože VPN server je jedinečný pro vás. Také to, že ochrání veškerý síťový provoz, nejenom webový.

## Tor Browser

Nejvyšší stupeň představuje použití sítě Tor, která vám na rozdíl od těch předchozích při správném použití zajistí plnou anonymitu. Nejsnazší způsob jak Tor používat je stáhnout si [Tor Browser](https://www.torproject.org/download/). To je speciální prohlížeč, který je zkonfigurován tak, aby využíval síť Tor.

Doporučuji vám, abyste si ho stáhli a měli ho třeba na flashce. Nikdy nevíte kdy se vám bude hodit.