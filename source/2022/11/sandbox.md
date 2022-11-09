<!-- dcterms:title = Windows Sandbox: Vestavěný virtuální stroj pro běžné uživatele -->
<!-- dcterms:abstract = Windows 10 a Windows 11 obsahují možnost jak spustit "virtuální počítač" s čistou instalací Windows, který je izolovaný od toho fyzického, skutečného. To můžete využít v případě, že chcete vyzkoušet něco, co na svém běžném PC dělat nechcete. Například nainstalovat nějakou aplikaci kterou nechcete používat dlouhodobě. Po vypnutí Sandboxu se totiž všechny provedené změny ztratí a vše se vrátí do původního stavu. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:coverUrl = /cover-pictures/20221109-sandbox.jpg -->
<!-- x4w:pictureUrl = /perex-pictures/20221109-sandbox.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = Z-TECH -->
<!-- x4w:category = IT -->
<!-- dcterms:dateAccepted = 2022-11-09 -->

Windows 10 a Windows 11 obsahují možnost jak spustit "virtuální počítač" s čistou instalací Windows, který je izolovaný od toho fyzického, skutečného. To můžete využít v případě, že chcete vyzkoušet něco, co na svém běžném PC dělat nechcete. Například nainstalovat nějakou aplikaci kterou nechcete používat dlouhodobě. Po vypnutí Sandboxu se totiž všechny provedené změny ztratí a vše se vrátí do původního stavu.

## Virtuální počítač nebo kontejner?

V úvodu jsem pojem "virtuální počítač" psal do uvozovek. Protože Sandbox sice využívá virtualizační technologii, ale spíše se jedná o kontejner. Podrobně to popisuje článek [Windows Sandbox architecture](https://learn.microsoft.com/en-us/windows/security/threat-protection/windows-sandbox/windows-sandbox-architecture), takže jenom stručně.

Virtuální počítač je plná simulace skutečného počítače. Můžete do něj nainstalovat jakýkoliv operační systém a ten "neví" že neběží na opravdovém počítači, ale na simulovaném. To například znamená, že počítač má virtuální harddisk (reprezentovaný na tom fyzickém jako jeden soubor) a v něm uložený celý operační systém - typicky tedy v řádu gigabajtů nebo jejich desítek. Virtualizačních technologií je celá řada. Microsoft má Hyper-V, ale populární je třeba VMWare, Oracle VirtualBox a řada dalších.

Sandbox využívá kontajnerizaci. Vytvoří dynamický image, který využívá toho, že většina souborů tvořících operační systém je neměnných a jsou na všech instalacích stejné. Tyto soubory se bez dalšího použijí z hostitelského systému a pouze ta menší část, kterou je nutné upravit, se liší. Image pro Sandbox s Windows 11 tedy nemá desítky gigabajtů ale jenom přibližně 500 MB. Podobně se přistupuje i ke správě paměti a dalším věcem. Sandbox se snaží neduplikovat funkčnost hostitelského systému a maximum jeho zdrojů sdílet.

## Základní použití Sandboxu

Základnímu použití Sandboxu se věnuje první video. Pozor, omylem v něm uvádím, že Sandbox funguje jenom na Windows 11 Pro. Ve skutečnosti funguje i na Windows 10 Pro.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/8USq8ImYMZs" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

## Konfigurace

Sandbox lze samozřejmě konfigurovat. Stačí vytvořit XML soubor s příponou `.wsb` a v něm nastavit různé parametry. Jejich kompletní popis najdete v článku [Windows Sandbox configuration](https://learn.microsoft.com/en-us/windows/security/threat-protection/windows-sandbox/windows-sandbox-configure-using-wsb-file), ale zejména se jedná o následující možnosti:

* Sdílení složek na disku mezi hostitelským počítačem a sandboxem. Tímto způsobem lze předávat soubory mezi oběma počítači. Složku lze sdílet i pouze pro čtení, takže ji Sandbox nebude moci modifikovat.
* Sdílení schránky, tiskáren, grafické karty... To nabízí větší možnosti, ale zároveň může znamenat vyšší riziko při použití nedůvěryhodného software.
* Vypnutí nebo zapnutí sítě. Ve výchozím nastavení má Sandbox přístup k síti prostřednictvím NATu. Tuto funkci lze nicméně vypnout, takže Sandbox se do sítě nedostane vůbec.

Konfiguračních WSB souborů můžete mít několik a stačí na jeden poklepat, aby se vám spustil sandbox s příslušným nastavením. Vzhledem k omezením použité technologie ale nelze spustit několik instancí současně. Pokud byste něco takového potřebovali, musíte použít "velkou" virtualizaci, například Hyper-V.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/U2GzwvXXMIM" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

## Odkazy

* [Oficiální dokumentace](https://learn.microsoft.com/en-us/windows/security/threat-protection/windows-sandbox/windows-sandbox-overview) na learn.microsoft.com.
* [Windows Sandbox Editor](https://github.com/damienvanrobaeys/Windows_Sandbox_Editor) je vizuální editor WSB souborů.
* [Run in Sandbox Context Menu](https://github.com/damienvanrobaeys/Run-in-Sandbox) přidá do kontextového menu Windows možnost spustit konkrétní program (nebo rozbalit archiv či image) přímo v Sandboxu.