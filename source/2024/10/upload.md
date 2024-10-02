<!-- dcterms:title = Upload souborů v ASP.NET Core -->
<!-- dcterms:abstract = V ASP.NET Core existují dvě hlavní cesty, jak dostat soubory z klienta na server: bufferovaný a streamovaný upload. Oba dva si ukážeme a představíme si jejich výhody a nevýhody. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20241002-upload.svg -->
<!-- x4w:coverUrl = /cover-pictures/20241002-upload.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = IT -->
<!-- dcterms:date = 2024-10-02 -->

Ve webových aplikacích je často potřeba uploadovat soubory z klienta na server. Buďto se tam mají nějakým způsobem zpracovat, nebo třeba jenom uložit a zpřístupnit někomu dalšímu. ASP.NET Core nabízí dvě základní metody bufferovaný a streamovaný upload.

* **Bufferovaný upload** je nejjednodušší na zpracování. Celý uploadovaný soubor se natáhne do paměti a je k dispozici jako `IFormFile` a mohu zjistit jeho velikost, původní název a samozřejmě přistupovat k jeho obsahu. Tato metoda je vhodná zejména pro menší soubory, ve velikosti jednotek nebo malých desítek MB.
* **Streamovaný upload** je vhodnější pro větší soubory, protože nevyžaduje, aby se všechno načetlo do paměti najednou, ale data lze zpracovávat nebo ukládat postupně. Díky tomu lze ukládat i data o objemu stovek megabajtů až gigabajtů.

Připravil jsem pro vás dvoudílný seriál, který toto téma pojednává. K dispozici jsou i [zdrojové kódy příkladu](https://www.cdn.altairis.cz/Blog/2024/20241001-LargeFileUpload.zip).

## Bufferovaný upload a validace názvů souborů

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/uJhVb9-p6MU" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

V prvním videu vám ukážu, jak používat klasický bufferovaný upload, což je velmi jednoduché. Také zde mluvím o důležitém tématu, kterým je sanitizace názvů souborů.

### File name sanitizer

Klient sice pošle s daty i název souboru (jaký název měl původně), ale těmto datům není dobré věřit. Protože zlovolný klient může podstrčit v podstatě cokoliv. Nelze tedy bez dalšího vzít název souboru zaslaný klientem a použít ho jako název souboru na serveru. Ideální z hlediska bezpečnosti by bylo, kdybychom mohli klientem zaslaný název souboru zcela ignorovat a vytvořit si vlastní název, o kterém víme, že je bezpečný. To ale často není možné.

Vyvořil jsem proto interface `IFileNameSanitizer`, který má jedinou metodu `SanitizeFileName` a ta dostane na vstupu data zadaná z klienta a na výstupu vrátí bezpečný název souboru:

```csharp
public interface IFileNameSanitizer {

    public string? SanitizeFileName(string fileName);

}
```

Zároveň jsem vytvořil jeho implementaci `WindowsFileNameSanitizer`, což je třída, která provádí velice konzervativní ošetření názvů souborů, mimo jiné na základě pravidel zmíněných v článku [Naming Files, Paths, and Namespaces](https://learn.microsoft.com/windows/win32/fileio/naming-a-file#naming-conventions). Pravidla pro Linux by byla poněkud volnější (název souboru může na Linuxu obsahovat i znaky, které by na Windows možné nebyly), ale chceme-li aby byla aplikace multiplatformní, je lepší používat konzervativnější přístup Windows.

Třída vypadá takto:

```csharp
public class WindowsFileNameSanitizer : IFileNameSanitizer {

    private const string ValidFileNameChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_.";
    private static readonly string[] ReservedNames = ["^CON$", "^PRN$", "^AUX$", "^NUL$", @"^COM\d*$", @"^LPT\d*$"];

    public string? SanitizeFileName(string fileName) {
        // Get file name without path
        fileName = Path.GetFileName(fileName);

        // Replace spaces with underscores
        fileName = fileName.Replace(' ', '_');

        // Remove diacritic from file name
        fileName = string.Join("", fileName.Normalize(NormalizationForm.FormD).Where(c => CharUnicodeInfo.GetUnicodeCategory(c) != UnicodeCategory.NonSpacingMark)).Normalize(NormalizationForm.FormC);

        // Remove all unsupported characters
        fileName = string.Join("", fileName.Where(ValidFileNameChars.Contains));

        // Shorten the file name to 64 characters and extension to 32 characters
        var fileNameWithoutExtension = Path.GetFileNameWithoutExtension(fileName);
        var extension = Path.GetExtension(fileName);
        if (fileNameWithoutExtension.Length > 64) fileNameWithoutExtension = fileNameWithoutExtension[..64];
        if (extension.Length > 32) extension = extension[..32];

        // Replace all dots in filename part with underscores
        fileNameWithoutExtension = fileNameWithoutExtension.Replace('.', '_');

        // Do not accept files whose names or extensions are empty after removing unsupported characters
        if (string.IsNullOrEmpty(fileNameWithoutExtension)) return null;
        if (string.IsNullOrEmpty(extension)) return null;

        // Do not accept files with reserved names
        foreach (var reservedName in ReservedNames) {
            if (Regex.IsMatch(fileNameWithoutExtension, reservedName, RegexOptions.IgnoreCase)) return null;
        }

        // Join the file name and extension
        return fileNameWithoutExtension + extension;
    }

}
```

Postup sanitizace je následující:

* Z názvu souboru odstraníme cestu, pokud je přítomna.
* Případné mezery nahradíme podtržítky.
* Odstraníme diakritiku běžně používaným trikem, kdy string převedeme na Unicode Form D, kdy jsou diakritická znaménka jako samostatné znaky a ty odstraníme. Poté převedeme string na běžnější Form C. Nejsem si zcela jist, zda toto odstranění diakritiky funguje zcela spolehlivě za všech okolností, ale pro české znaky je uspokojivé.
* Odstraníme z názvu souboru všechny znaky, které nejsou v seznamu povolených. Povolená jsou pouze velká a malá písmena anglické abecedy, číslice, mínus, podtržítko a tečka.
* Název souboru zkrátíme na 64 znaků a příponu na 32 znaků. Tento limit jsem zvolil zcela odhadem, limit délky cesty závisí na použitém souborovém systému atd., ale 64 + 32 znaků mi přijde jako rozumný limit pro běžné soubory.
* Tečky v názvu souboru nahradíme podtržítky. Název souboru bude obsahovat právě jednu tečku, před příponou.
* Ověříme si, že soubor má jak název, tak příponu. Neakceptujeme tedy soubory bez přípony.
* Odmítneme soubory s názvy, které jsou na Windows rezervované, jako `CON`, `PRN`, `AUX`, `NUL`, `COMx` nebo `LPTx`.

Výsledek vrátíme zpět. Pokud se nepodařilo vytvořit validní název (třeba protože název souboru obsahuje pouze nepovolené znaky nebo je rezervovaný), vrátí metoda `null`. Volající kód se s tím musí nějak vyrovnat, třeba vrátit chybu.

## Streamovaný upload na několik souborů

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/MHpXk8GO5XM" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

Druhé video se zabývá streamovaným uploadem souborů. Tam přistupujeme k datům na mnohem nižší úrovni, nemáme k dispozici pohodlné zpracování formulářových dat a podobně. Navíc je třeba trocha klientského JavaScriptu. Výměnou za to ale dokážeme uploadovat i větší soubory a hlavně v průběhu uploadu komunikovat s klientem -- ukázat mu průběh uploadu, rychlost a podobné věci.

Ve videu ukážu postupně tři varianty uploadu, z nichž v praxi použitelná je vlastně jenom ta poslední. První dvě totiž neumějí zjistit, že se soubor v pořádku nahrál celý, pokud bude upload přerušen, zůstane soubor nekompletní. Poslední příklad ale používá dočasný soubor, pomocí jehož názvu sváže uploadovaný soubor s ostatními odeslanými formulářovými daty.

## To není všechno

Obě popisované metody mají jednu velkou výhodu i nevýhodu zároveň: přenos běží v rámci jednoho HTTP requestu. Je velmi jednoduchý, ale pořád jsme omezeni maximální velikostí jednoho requestu a nedokážeme třeba navázat spojení v případě jeho výpadku a podobně.

Pokud bychom potřebovali takovou funkcionalitu, použitelnou i pro souboru o velikosti mnoha gigabajtů, bylo by zapotřebí k tomu přistupovat výrazně jinak. Pomocí JavaScriptového [File API](https://developer.mozilla.org/en-US/docs/Web/API/File) lze z browseru přistupovat k (některým, uživatelem vybraným) souborům ve file systému. Můžeme je postupně po částech načítat a postupně posílat v několika HTTP requestech na server. Nicméně to je podstatně složitější postup a jím se budu možná zabývat někdy příště, stejně jako způsoby zpracování a ukládání souborů na straně serveru.