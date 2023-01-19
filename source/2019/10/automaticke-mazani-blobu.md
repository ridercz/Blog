<!-- dcterms:title = Automatické mazání blobů v Azure Storage -->
<!-- dcterms:abstract = Pokud používáte Azure Storage pro zálohy a podobné účely, možná se vám bude hodit Lifecycle Management - možnost bloby podle určitých pravidel přesouvat, mazat nebo jinak šikanovat. Ukážu vám, jak tuto funkci využít. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20191017-automaticke-mazani-blobu.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20191017-automaticke-mazani-blobu.jpg -->
<!-- x4w:coverCredits = Andrew Stawarz via Flickr, CC BY-SA 2.0 -->
<!-- x4w:category = IT -->
<!-- dcterms:date = 2019-10-17 -->

Mám rád Azure Storage, protože je to levné, jednoduché a spolehlivé úložiště dat. Používám ho mimo jiné pro "zálohu poslední záchrany" pro databáze. Podrobnosti najdete v článku [Automatizovaná záloha SQL Serveru do Azure Storage](https://www.altair.blog/2018/07/zaloha-sql-do-azure). Můj skript nicméně neřeší mazání starých záloh. Při cenách Azure Storage a velikosti našich databází mi nestálo za to psát na to nějaký skript.

Od letošního března ale Azure Storage podporuje funkci [Lifecycle Management](https://azure.microsoft.com/en-ca/blog/azure-blob-storage-lifecycle-management-now-generally-available/). Ta umožňuje nastavení pravidel, která budou jednotlivé bloby různě šikanovat, například je po určitém čase přesune do levnějšího pomalejšího úložiště, smaže jejich snapshoty (staré verze) a nebo je třeba úplně smaže. Zcela automaticky, aniž bychom se o to museli nějak starat. Další informace najdete v článku [Manage the Azure Blob storage lifecycle](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-lifecycle-management-concepts.)

## Jak na to

Pomocí následujícího návodu nastavíme úložiště tak, aby automaticky smazalo soubory, které byly naposledy modifikovány před rokem (a déle).

V první řadě si ověřte, že je váš storage account General Purpose Version 2 (GPv2). Pokud ho máte už dlouho, možná je ve starší GPv1 a musíte ho nejprve [upgradovat](https://docs.microsoft.com/en-us/azure/storage/common/storage-account-upgrade).

![](https://www.cdn.altairis.cz/Blog/2019/20191017-deleteblobs-0.png)

Klepněte na odkaz _Lifecycle Management_ a poté _Add Rule_:

![](https://www.cdn.altairis.cz/Blog/2019/20191017-deleteblobs-1.png)

Zadejte název pravidla (může obsahovat pouze malá písmena anglické abecedy a číslice) a zaškrtněte _Delete blob_ a do pole _days after last modification_ zadejte _365_ - tedy jeden rok. Poté klepněte na _Review + Add_.

![](https://www.cdn.altairis.cz/Blog/2019/20191017-deleteblobs-2.png)

Takto zadané pravidlo smaže všechny staré bloby na storage accountu. Pomocí záložky _Filter set_ můžete omezit, na které bloby se pravidlo bude vztahovat.

Zkontrolujte zadané parametry a klepněte na _Add_:

![](https://www.cdn.altairis.cz/Blog/2019/20191017-deleteblobs-3.png)

Vytvoří se nové pravidlo:

![](https://www.cdn.altairis.cz/Blog/2019/20191017-deleteblobs-4.png)

Pravidla se vyhodnotí a aplikují jednou denně. Nadbytečné bloby se tedy nesmažou okamžitě, ale může trvat až 24 hodin, než se změna projeví.