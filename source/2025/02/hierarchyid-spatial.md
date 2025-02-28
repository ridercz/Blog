<!-- dcterms:title = Hierarchická a geografická data v SQL Serveru a Entity Frameworku -->
<!-- dcterms:abstract = Na akci WUG Dev Day jsem měl přednášku o hierarchických a geografických datových typech v Microsoft SQL Serveru. Nabízím ke stažení materiály z této přednášky a zároveň odkazy na související videa. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20250228-hierarchyid-spatial.jpg -->
<!-- x4w:coverUrl = /cover-pictures/20250228-hierarchyid-spatial.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = IT -->
<!-- dcterms:date = 2025-02-28 -->

Na akci WUG Dev Day jsem měl přednášku o hierarchických a geografických datových typech v Microsoft SQL Serveru. Nabízím ke stažení materiály z této přednášky a zároveň odkazy na související videa.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://1drv.ms/p/s!Apo4M7bgM3zB1ulu7VVyS-X5EKAWJw?embed=1&amp;em=2&amp;wdAr=1.7777777777777777" frameborder="0" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

## Hierarchická data

Microsoft SQL Server má speciální datový typ `hierarchyid` pro uchovávání stromově organizovaných dat. Například kategorie a podkategorie, organizační struktura nebo rodokmen. Pomocí tohoto typu můžete jednoduše dělat dotazy na libovolné části tohoto stromu.

* [Video](https://www.youtube.com/watch?v=qAvR4J3qINQ)
* [Zdrojový kód](https://gist.github.com/ridercz/175048cac3c0d4a1291d30948c6bce5c)

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/qAvR4J3qINQ" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

Od verze 8.0 je pro tento datový typ podpora i v Entity Frameworku Core.

* [Video](https://www.youtube.com/watch?v=cS65o-Vn2y0)
* [Zdrojový kód](https://www.cdn.altairis.cz/Blog/2025/20250213-HierarchyId.zip)

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/cS65o-Vn2y0" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

## Geografická a prostorová data

Microsoft SQL Server má i speciální datové typy pro práci se souřadnicemi - spatial types. Datový typ `geometry` pracuje v rovině s kartézským souřadnicemi a datový typ `geography` pracuje se zeměpisnou šířkou a délkou.

* [Video](https://www.youtube.com/watch?v=4o8G7HbebFA)
* [Zdrojový kód](https://www.cdn.altairis.cz/Blog/2025/20250218-SpatialTSQL.zip)

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/4o8G7HbebFA" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

I tyto datové typy jsou podporovány v EF Core.

* [Video](https://www.youtube.com/watch?v=375ag0DAN9c)
* [Zdrojový kód](https://www.cdn.altairis.cz/Blog/2025/20250227-SpatialEF.zip)

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/375ag0DAN9c" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>
