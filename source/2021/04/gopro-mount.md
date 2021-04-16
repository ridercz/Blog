<!-- dcterms:title = Knihovna pro GoPro držáky v OpenSCADu -->
<!-- dcterms:abstract = Poslední dobou zjišťuju, že dost často modeluju držáky na GoPro kamery. Staly se jakýmsi standardem i mimo svět akčních kamer a hodí se jako rozebíratelné úhlově nastavitelné spojení dvou komponent. Udělal jsem proto OpenSCADovou knihovnu pro generování jejich samčí i samičí podoby. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:coverUrl = /cover-pictures/20210416-gopro-mount.jpg -->
<!-- x4w:coverCredits = Jakob Owens (@jakobowens1) via Unsplash.com-->
<!-- x4w:pictureUrl = /perex-pictures/20210416-gopro-mount.png -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = Bastlení -->
<!-- x4w:category = 3D tisk -->
<!-- dcterms:dateAccepted = 2021-04-16T00:00:00 -->

Poslední dobou zjišťuju, že dost často modeluju [držáky na GoPro kamery](https://www.altair.blog/2021/03/kamera). Staly se jakýmsi standardem i mimo svět akčních kamer a hodí se jako rozebíratelné úhlově nastavitelné spojení dvou komponent. Udělal jsem proto OpenSCADovou knihovnu pro generování jejich samčí i samičí podoby.

Zde je zdrojový kód:

<script src="https://gist.github.com/ridercz/fb9a9a4730ac393cea68e363ddf806ed.js"></script>

Knihovna definuje dva moduly, `gopro_mount_m` a `gopro_mount_f`.

* Modul `gopro_mount_m` je "samčí" část, tedy ta, která má vyčnívající "ploutvičky" a obvykle je součástí toho, _co přiděláváme_ - třeba kamery nebo pouzdra na ni. Hloubka (velikost v ose `y`) samčí části je vždy 9.5 mm.
* Modul `gopro_mount_f` je jeho "samičí" protikus a obvykle je součástí toho, _na co přiděláváme_ - třeba stativu nebo něčeho podobného. Hloubka (velikost v ose `y`) samičí části je vždy 19 mm.

Oba dva moduly berou jako hlavní parametry `base_width` a `base_height`, což jsou rozměry kvádru, na kterém se držák nachází. Musí mít z technologických důvodů nenulovou výšku. Pokud se vám nehodí, musíte ho "zapustit" do podkladu nebo později uříznout. Jsou tam ještě nějaké další parametry, ale ty nejspíš nebudete potřebovat měnit. Pokud ano, podívejte se do zdrojáku, jsou tam komentáře.

Ke spojení obou částí potřebujete ještě šroub M5 a čtvercovou matici M5. Změnou parametrů modulu `gopro_mount_f` lze vytvořit i díru pro běžnou (nebo zaslepenou, jako to má originál) šestihrannou matici, ale hrozí nebezpečí, že se při silnějším dotažení začne protáčet. Pro tento účel jsou prostě čtverhranné matice vhodnější.