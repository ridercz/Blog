<!-- dcterms:identifier = aspnetcz#5467 -->
<!-- dcterms:title = Jak vyměnit v serveru disk za větší -->
<!-- dcterms:abstract = Byl jsem tázán na některé okolnosti výměny disku v serveru za větší. Vyzkoušel jsem si simulaci ve virtuálním počítači a říkám si, že by se popis postupu mohl hodit i někomu dalšímu. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = IT -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2018-04-25T16:36:45.987+02:00 -->
<!-- dcterms:date = 2018-04-25T16:36:46+02:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20180425-jak-vymenit-v-serveru-disk-za-vetsi.jpg -->

Byl jsem tázán na některé okolnosti výměny disku v serveru za větší. Vyzkoušel jsem si simulaci ve virtuálním počítači a říkám si, že by se popis postupu mohl hodit i někomu dalšímu.

Následující screenshot popisuje výchozí stav v Disk Managementu. Na serveru je operační systém Windows Server 2012 R2 (ale uvedený postup funguje bez ohledu na verzi Windows). Server má celkem tři fyzické disky: jeden je systémový a toho se naše změny týkat nebudou, další dva jsou v mirroru jako datové. Chceme oba dva disky vyměnit za větší – 10 GB na 20 GB (reálně na velikosti nezáleží, poměrně malou velikost jsem zvolil, aby demo bylo rychlejší). Výměnu chceme provést pokud možno za provozu bez výpadku, nebo jenom s minimálním výpadkem. Pokud server podporuje hot swap disků, lze vše provést za provozu, jinak je nutno server pro výměnu vypnout.

[![image](https://www.cdn.altairis.cz/Blog/2018/20180425-image_thumb.png "image")](https://www.cdn.altairis.cz/Blog/2018/20180425-image_2.png)

Klepněte na mirror pravým tlačítkem a z kontextového menu zvolte *Break Mirrored Volume*.

[![image](https://www.cdn.altairis.cz/Blog/2018/20180425-image_thumb_1.png "image")](https://www.cdn.altairis.cz/Blog/2018/20180425-image_4.png)

Tím z jednoho logického disku **E:** vzniknou dva s tímtéž obsahem, **E:** a **F:**, jak je vidět na následujícím obrázku:

[![image](https://www.cdn.altairis.cz/Blog/2018/20180425-image_thumb_2.png "image")](https://www.cdn.altairis.cz/Blog/2018/20180425-image_6.png)

Disk **F:** z počítače odstraňte a místo něj zapojte nový, větší. Původní disk se ukáže jako *Missing*. Z kontextového menu ho smažte:

[![image](https://www.cdn.altairis.cz/Blog/2018/20180425-image_thumb_3.png "image")](https://www.cdn.altairis.cz/Blog/2018/20180425-image_8.png)

Nově vložený disk není inicializovaný. Klepněte na levou část pravým tlačítkem a z kontextového menu jej inicializujte:

[![image](https://www.cdn.altairis.cz/Blog/2018/20180425-image_thumb_4.png "image")](https://www.cdn.altairis.cz/Blog/2018/20180425-image_10.png)

Nyní vytvoříme mirror dat z původního disku na část nově přidaného disku. Klepněte na **E:** pravým tlačítkem a z kontextového menu zvolte *Add Mirror*:

[![image](https://www.cdn.altairis.cz/Blog/2018/20180425-image_thumb_5.png "image")](https://www.cdn.altairis.cz/Blog/2018/20180425-image_12.png)

V následném dialogu zvolte nově přidaný disk a klepněte na *Add Mirror*:

[![image](https://www.cdn.altairis.cz/Blog/2018/20180425-image_thumb_6.png "image")](https://www.cdn.altairis.cz/Blog/2018/20180425-image_14.png)

Resynchronizace bude nějakou dobu trvat. Mohou to být i hodiny, v závislosti na rychlosti disků, jejich velikosti a objemu dat. Vyčkejte, dokud se stav nezmění na *Healthy*. Poté z kontextového menu opět zvolte *Break Mirrored Volume:*

[![image](https://www.cdn.altairis.cz/Blog/2018/20180425-image_thumb_7.png "image")](https://www.cdn.altairis.cz/Blog/2018/20180425-image_16.png)

Vyjměte starý disk, místo něj zapojte nový větší a odstraňte *Missing* svazek. Měli byste se dostat do následujícího stavu:

[![image](https://www.cdn.altairis.cz/Blog/2018/20180425-image_thumb_8.png "image")](https://www.cdn.altairis.cz/Blog/2018/20180425-image_18.png)

Z kontextového menu nad **E:** zvolte *Extend Volume*:

[![image](https://www.cdn.altairis.cz/Blog/2018/20180425-image_thumb_9.png "image")](https://www.cdn.altairis.cz/Blog/2018/20180425-image_20.png)

Pokud chcete využít celý disk, což je pravděpodobné, ponechte hodnoty v následném dialogu beze změny. Partition **E:** se rozšíří na celý disk. Výsledné zobrazení by mělo vypadat takto:

[![image](https://www.cdn.altairis.cz/Blog/2018/20180425-image_thumb_10.png "image")](https://www.cdn.altairis.cz/Blog/2018/20180425-image_22.png)

Z kontextového menu nad **E:** zvolte *Add Mirror* a vytvořte znovu mirror. Resynchronizace bude opět nějakou dobu trvat, v závislosti na objemu dat:

[![image](https://www.cdn.altairis.cz/Blog/2018/20180425-image_thumb_11.png "image")](https://www.cdn.altairis.cz/Blog/2018/20180425-image_24.png)

Ve výsledku budete mít opět mirror, tentokrát ovšem s novou velikostí disků:

[![image](https://www.cdn.altairis.cz/Blog/2018/20180425-image_thumb_12.png "image")](https://www.cdn.altairis.cz/Blog/2018/20180425-image_26.png)