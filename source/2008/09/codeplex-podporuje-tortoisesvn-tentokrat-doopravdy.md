<!-- dcterms:identifier = aspnetcz#209 -->
<!-- dcterms:title = CodePlex podporuje TortoiseSVN – tentokrát doopravdy -->
<!-- dcterms:abstract = Microsoft už dva roky provozuje server CodePlex. Slouží k podpoře open source projektů, jejichž vývojářům poskytuje potřebnou infrastrukturu. Podpora pro Subversion byla jedním z nejčastejších požadavků. Po nesmělých klientských řešení nyní CodePlex podporuje Subversion nativně. -->
<!-- np9:categoryId = 7 -->
<!-- x4w:category = Software -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2008-09-17T01:16:14.183+02:00 -->
<!-- dcterms:dateAccepted = 2008-09-17T01:16:14.183+02:00 -->

Microsoft už dva roky provozuje server [CodePlex](http://www.codeplex.com/). Slouží k podpoře open source projektů, jejichž vývojářům poskytuje potřebnou infrastrukturu. CodePlex podporuje sledování problémů, zveřejňování nových verzí a především code repository, nutnost v případě, že se má na projektu podílet větší množství lidí. Podobné služby nabízí například [SourceForge](http://www.sourceforge.net/) nebo [Google Code](http://code.google.com/hosting/).

CodePlex je postaven nad Team Foundation Serverem. To je nástroj velmi mocný, ale pro řadu uživatelů (včetně mne) až příliš komplexní a náročný na obsluhu. Stejně jako řada dalších programátorů dávám přednost systému [Subversion](http://subversion.tigris.org/) a samostatnému klientskému nástroji [Tortoise SVN](http://tortoisesvn.tigris.org/). Podpora Subversion byla jednou z nejčastěji požadovaných nových funkcí.

První vlaštovkou v tomto směru byl projekt [SvnBridge](http://www.codeplex.com/SvnBridge/). Jedná se o program, který běží na klientském počítači a v podstatě slouží jako překladač mezi SVN a TFS. SVN klient se připojí k lokálnímu počítači a komunikuje s programem, který požadavky překládá do formátu, kterému rozumí Team Foundation Server. Použití tohoto programu je také možné i proti jiným TFS než CodePlex. Počin to jest jistě chvályhodný, želbohu je však toto řešení mnohdy příliš komplikované.

Před několika dny nicméně [CodePlex spustil přímou podporu](http://blogs.msdn.com/codeplex/archive/2008/09/14/codeplex-launches-support-for-tortoisesvn.aspx), bez nutnosti instalovat speciální klientský software. Ačkoliv důsledně operuje pouze s názvem TortoiseSVN, nikoliv Subversion, mělo by rozhraní z principu být použitelné i pro jiné klienty. Výhodou pak je, že tentýž repository je dostupný různými způsoby, takže jeden uživatel může používat TFS a jiný SVN. Read-only přístup je anonymní, pro změny musíte být členy projektu.

Nadšeně jsem se jal tuto funkci využívat, načež jsem během prvního půl dne (resp. půli noci, při mém životním rytmu :-) objevil tři závažné chyby. K mému velkému a velmi příjemnému překvapení je vývojáři během jediného dne odstranili, ačkoliv jsem nepoužíval žádných speciálních kanálů a reportoval jsem to toliko prostředky dostupnými běžným smrtelníkům. Bystře jsem tedy na CodePlex nahrál jeden nový projekt, o kterém napíšu blíže zítra.

Podrobný obrázkový návod najdete [na blogu CodePlex teamu](http://blogs.msdn.com/codeplex/archive/2008/09/14/codeplex-launches-support-for-tortoisesvn.aspx). Ostříleným uživatelům pak nepochybně postačí informace, že pro připojení ke svému projektu mají použít url **https://*název-projektu*.svn.codeplex.com/svn**. Uživatelské jméno a heslo pro zápis je stejné jako na web, tj. nemusíte zadávat jméno ve speciálním formátu, jako pro TFS.