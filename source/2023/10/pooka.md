<!-- dcterms:title = Pooka: Automatické vypnutí počítače při odchodu -->
<!-- dcterms:abstract = Stihnete vypnout počítač, když vám zásahovka vyrazí dveře? Nebo ho jenom zapomínáte zamknout, když jdete na oběd? V obou případech vám pomůže trocha hardware a pomocník jménem Pooka. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20231031-pooka.png -->
<!-- x4w:coverUrl = /cover-pictures/20231031-pooka.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = IT -->
<!-- x4w:category = Bezpečnost -->
<!-- dcterms:date = 2023-10-31 -->

POOKA je bezpečnostní pomocník, který dokáže - podobně jako stejnojmenní bájní koně - konat dobro i zlo.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/mUN_GBYhjyU" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

## Proč ho potřebujete?

Upřímně řečeno, pravděpodobně ho nepotřebujete vůbec. Jedná se o poměrně specifický software pro poměrně specifické scénáře použití související s kybernetickou a fyzickou bezpečností.

Představte si, že pracujete na svém počítači, na něčem, co se mocnému protivníkovi, například vládě vaší země, nelíbí. Pokud se informace prozradí, strávíte zbytek života ve vězení. Pokud zkušený protivník získá přístup k běžícímu počítači, může se dostat k informacím v něm uloženým, i když používáte šifrování celého disku apod. Klíče jsou v paměti a lze je odtud získat. 

Jediným bezpečným stavem počítače proti tomuto protivníkovi je jeho vypnutí. Nejlépe správným způsobem, aby byly šifrovací klíče z paměti odstraněny, pouhé odpojení napájení nemusí být dostatečně dobré.

Když vám do dveří vtrhne zásahová jednotka, nebudete to moci udělat. Věřte mi, vím, o čem mluvím. Ale správný hardware a software vám může pomoci.

## Software

Pooka je vlastně docela jednoduchý software, který běží na pozadí počítače s Windows a pravidelně kontroluje, zda určitý soubor na vyměnitelném úložném zařízení stále existuje. Pokud bylo zařízení odstraněno, Pooka provede nakonfigurovanou akci. Může uzamknout počítač, vypnout jej nebo spustit vlastní příkaz.

**Stáhněte si nejnovější verzi z [GitHubu](https://github.com/ridercz/Pooka/releases/latest).** K dispozici jsou dvě binární verze:

* `pooka.exe` vyžaduje instalaci běhového prostředí .NET 7 a je menší.
* `pooka-standalone.exe` je samostatný a nevyžaduje běhové prostředí .NET, ale je větší.

## Hardware

Budete potřebovat:

* **Flash disk USB-C.** Nejlépe malý a v takovém provedení, abyste k němu mohli připevnit kroužek, karabinu nebo nějaké podobné zařízení.
* **[Redukci USB-C F-F](https://s.click.aliexpress.com/e/_DFB4JP1)**
* **[Magnetický kabel USB-C.](https://s.click.aliexpress.com/e/_DchKLH9)** Vyberte si takový, který má i datové linky, většina z nich je pouze nabíjecí.

Připojte všechny tyto věci dohromady:

![](https://github.com/ridercz/Pooka/blob/master/Assets/hw-1.jpg?raw=true)
![](https://github.com/ridercz/Pooka/blob/master/Assets/hw-2.jpg?raw=true)

Poté k somě mechanicky přidělejte onu flashku. Například k poutku na opasku nebo ještě lépe k náramkovým hodinkám. Nakonfigurujte aplikaci Pooka tak, aby po odpojení flash disku vypnula počítač.

![](https://github.com/ridercz/Pooka/blob/master/Assets/hw-3.jpg?raw=true)

Jakmile oddálíte ruku, například když ji zvednete v gestu vzdání se, počítač se automaticky vypne a vymaže z paměti šifrovací klíče disku.

V méně dramatickém případě stačí flash disk připevnit na poutko u opasku a počítač automaticky uzamknout pokaždé, když opustíte svůj stůl, abyste se vyhnuli žertům spolupracovníků.