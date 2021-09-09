<!-- dcterms:title = C# pro mírně pokročilé: Vlastnosti vlastností -->
<!-- dcterms:abstract = Některé programovací jazyky se bez vlastností (properties) docela dobře obejdou. Ale v C# jsou od samého počátku a jejich zápis se s každou verzí zjednodušuje. Hodí se to, protože se mění kód který píšeme. Nově často místo funkčního kódu píšeme modely a tam se rychlé vytváření vlastností hodí. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20210909-csharp-properties.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20210909-csharp-properties.jpg-->
<!-- x4w:category = Z-TECH -->
<!-- x4w:category = IT -->
<!-- dcterms:dateAccepted = 2021-09-09 -->

Vlastnosti (properties) v C# umožňují publikovat privátní fieldy navenek. Bez konceptu vlastností se v zásadě obejdete: některé programovací jazyky ho vůbec nemají a nahrazují je getter a setter metodami:

```cs
private string firstName;

public string GetFirstName() {
    return this.firstName;
}

public void SetFirstName(string value) {
    this.firstName = value;
}
```

V C# ale properties jsou odjakživa a jejich klasická konstrukce syntaxí C# 1.0 vypadá takto:

```cs
private string firstName;

public string FirstName {
    get {
        return this.firstName;
    }

    set {
        this.firstName = value;
    }
}
```

S přibývajícími verzemi se však zápis čím dál tím víc zjednodušoval, takže dneska si v řadě případů vystačíme s tím nejjednodušším:

```cs
public string FirstName { get; set; }
```

Vlastnosti toho ale umí mnohem víc. Lze jim nastavit výchozí hodnoty, jejich tělo může být v podobě expression a aktuální verze C# 9.0 přinesla nové klíčové slovo `init`, které umožňuje vytvářet immutable typy. O tom všem je řeč v nejnovějším dílu našeho seriálu o C#.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/ev_keTCImlk" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>
