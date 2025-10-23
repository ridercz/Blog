<!-- dcterms:title = Jak nainstalovat Windows 11 i bez Microsoft accountu -->
<!-- dcterms:abstract = Microsoft se snaží, aby uživatelé Windows používali online účty. Obecně je to dobrý nápad, ale v některých případech se to nehodí. Ukážu vám způsob, jak Windows 11 nainstalovat i bez Microsoft účtu. A to takový, který by měl fungovat trvale, protože nejde o hack. -->
<!-- x4w:category = IT -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:date = 2025-10-23 -->
<!-- x4w:coverUrl = /cover-pictures/20251023-windows.jpg -->
<!-- x4w:pictureUrl = /perex-pictures/20251023-windows.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->

Microsoft se snaží, aby uživatelé Windows používali online účty. Obecně je to dobrý nápad, ale v některých případech se to nehodí. Ukážu vám způsob, jak Windows 11 nainstalovat i bez Microsoft účtu. A to takový, který by měl fungovat trvale, protože nejde o hack.

> **Z celého srdce vám doporučuji používat Microsoft Account! Důvody, které většina lidí uvádí pro jeho nepoužívání, jsou nesmyslné.**
>
> Hlavním důvodem, proč jsem vytvořil tohoto průvodce je, že uživatelské jméno vytvořené během standardního nastavení nelze určit prostřednictvím uživatelského rozhraní a je pevně nastaveno na prvních pět znaků e-mailové adresy. Použití MS Accountu také není praktické pro testovací a demonstrační účely. Pro většinu domácích uživatelů to není problém, ale pro pokročilé uživatele mého typu ano.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/Led2EeouEdA" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

## Jak na to

Chcete-li nainstalovat Windows 11 bez účtu Microsoft, postupujte takto:

1. Spusťte počítač z instalačního média a dokončete první fázi instalace (vypadá jako Windows 7).
2. Po restartu počkejte, až se zobrazí rozhraní OOBE (Out of Box Experience). Jedná se o moderně vypadající rozhraní, které vás požádá o výběr země.
3. Stiskněte klávesovou zkratku _Shift + F10_.
4. Otevře se okno s příkazovou řádkou.
5. Spusťte v něm následující dva příkazy:
```
curl -L -o bypass.cmd https://altair.is/win11-oobe
bypass.cmd
```
6. Počítač se restartuje a instalace bude pokračovat jako obvykle. Nebudete požádáni o použití účtu Microsoft, ale místo toho budete požádáni o zadání názvu místního účtu a volitelného hesla. Žádný další aspekt instalace se nezmění.

## Bude to fungovat?

Mělo by. Zatímco starší metody, ke kterým Microsoft omezuje přístup, jsou nedokumentované hacky, soubor `unattend.xml` je oficiálně dokumentován a je klíčový pro mnoho scénářů v reálném světě. Jelikož by jeho zrušení nebo změny měly dopad i na mnoho důležitých firemních zákazníků, je velmi nepravděpodobné, že by byl tento postup odstraněn nebo změněn.

## Můžu ti věřit?

Ne, neměli byste věřit cizím lidem, zejména ne podivným sociopatickým warlockům křemíkového boha, jako jsem já. Spouštění náhodných skriptů z Internetu během kritické fáze nastavení operačního systému je velmi špatný nápad, který může vést k ohrožení celého systému.

Měli byste:

1. Ověřit, že zkrácený odkaz https://altair.is/win11-oobe vede k souboru `bypass.cmd` v [mém repozitáři](https://github.com/ridercz/Scripts/tree/master/Setup-Windows11/OOBE).
2. Ověřit obsah tohoto souboru.
3. Ověřit obsah souboru `unattend.xml`, který se stáhne.

Ale nemůžu vás k tomu nutit, že? Pokud to neuděláte, měli byste dostat výprask! Ano, mimo jiné jsem na BDSM. Stále mi věříte?

## Další zdroje informací

* [Unattended Windows Setup Reference](https://learn.microsoft.com/en-us/windows-hardware/customize/desktop/unattend/) od Microsoftu (oficiální referenční dokumentace)
* [Generate autounattend.xml files for Windows 10/11](https://schneegans.de/windows/unattend-generator/) od Christopha Schneeganse (online nástroj pro generování XML souborů s odpověďmi)
* [Bypass NRO](https://github.com/ChrisTitusTech/bypassnro/) od Chrise Tita (mnohem rozsáhlejší změny, které mě inspirovaly)