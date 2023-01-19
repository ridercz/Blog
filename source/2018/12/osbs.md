<!-- dcterms:title = Nový build systém pro OpenSCAD -->
<!-- dcterms:abstract = Pro vytváření 3D modelů používám program OpenSCAD. Nyní jsem k němu napsal build systém, který umí snadno a jednoduše vygenerovat více variant z jednoho souboru a má podporu pro vícebarevný, resp. vícemateriálový tisk. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20181227-osbs.png -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = 3D tisk -->
<!-- dcterms:date = 2018-12-27 -->

Pro vytváření 3D modelů používám program OpenSCAD. Ten je specifický tím, že se v něm model programuje, nikoliv kreslí. V minulosti jsem o něm už také napsal [několik](https://josefprusa.cz/priklad-z-praxe-naprogramujte-si-model-pro-3d-tisk-v-openscad/) [článků](https://josefprusa.cz/parametricke-modelovani-v-openscadu/).

Teď pracuji na projektu, kde potřebuji na základě různých parametrů vygenerovat větší množství podobných modelů. Na to se OpenSCAD výtečně hodí. Nicméně chybí možnost generování modelů automatizovat. Naštěstí se dá OpenSCAD ovládat z příkazové řádky, takže jsem si na to vytvořil systém.

Jmenuje se **OSBS - OpenScad Build System** a najdete ho na [mém GitHubu](https://github.com/ridercz/OSBS). Ve své podstatě je to obyčejný dávkový soubor (`.cmd`), ale ne úplně jednoduchý.

## Co OSBS umí?

Soubor `build.cmd` je nutné umístit do stejné složky, kde se nacházejí `.scad` soubory. Pokud má být soubor zahrnut do buildu, je třeba do něj vložit speciální komentář `/* OSBS:build */`.

Poté je možno vytvořit soubor s příponou `.vars`, který bude obsahovat různé varianty modelu, s různým nastavením proměnných. OSBS vygeneruje všechny varianty.

Další funkcí je podpora modelů, které se budou tisknout více extrudery. Přidáním komentáře `/* OSBS:build:2E */` lze např. určit, že se model bude tisknout dvěma extrudery. V takovém případě se odpovídající model bude renderovat třikrát, OSBS mu podstrčí proměnnou `osbs_selected_extruder` s hodnotami `0`, `1` a `2` a jednoduchými podmínkami uvnitř souboru lze určit, co se kdy bude generovat.

---

Kompletní informace a příklad použití najdete na [https://github.com/ridercz/OSBS](https://github.com/ridercz/OSBS).