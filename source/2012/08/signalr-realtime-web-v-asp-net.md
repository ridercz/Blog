<!-- dcterms:identifier = aspnetcz#396 -->
<!-- dcterms:title = SignalR: Realtime web v ASP.NET -->
<!-- dcterms:abstract = V současnosti dostupné technologie, jako jsou web sockets, mají moc změnit způsob, jakým píšeme webové aplikace. Zda k lepšímu, nechávám na vás. -->
<!-- np9:categoryId = 6 -->
<!-- x4w:category = Akce a události -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2012-08-23T00:38:24.837+02:00 -->
<!-- dcterms:dateAccepted = 2012-08-23T00:30:00+02:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20120823-signalr-realtime-web-v-asp-net.png -->

***Aktualizováno:** Vyšla nová verze SignalR 0.5.3, která nabízí (podle mého názoru) jednodušší volání klientských metod. Níže uvedené příklady fungují nadále, ale existuje i *[*jednodušší cesta*](http://www.aspnet.cz/articles/399-signalr-0-5-3-a-aktualizace-prikladu)*.*

V současnosti dostupné technologie, jako jsou web sockets, mají moc změnit způsob, jakým píšeme webové aplikace. Zda k lepšímu, to už nechávám na vás. Rozhodnete-li se nicméně touto cestou vydat, [SignalR](http://www.signalr.net/) je .NET knihovna pro vás.

Před časem jsem na toto téma měl v Praze přednášku, jejíž záznam je nyní k [dispozici na YouTube](http://youtu.be/sgXFTkB_l0U):
 <iframe width="853" height="480" src="http://www.youtube-nocookie.com/embed/sgXFTkB_l0U" frameborder="0" allowfullscreen="allowfullscreen"></iframe> 

Kromě záznamu vám nabízím i odkazy na další materiály:

*   [Moje dema](http://www.cdn.altairis.cz/Prednasky/20120815-signalr.zip), s opravenými chybami ;-) Příklady jsem upravil pro Visual Studio 2012 RTM. Aby vám vše správně fungovalo, musíte mít v nastavení povolený nuget package restore, při prvním kompilaci si to pak samo stáhne všechny knihovny.
*   Session "Microsoft ASP.NET and the Realtime Web" z TechEdu (anglicky). Je k dispozici ve dvou verzích, z amerického a evropského TechEdu. Doporučuji vám shlédnout obě, protože ač se formálně jedná o tutéž session, jejich obsah je zcela rozdílný.
*   *   Damian Edwards se v [americké verzi](http://channel9.msdn.com/Events/TechEd/NorthAmerica/2012/DEV305) zaměřuje na vnitřnosti knihovny SignalR a její výkonové charakteristiky.
    *   Brady Gaster v [evropské verzi](http://channel9.msdn.com/Events/TechEd/Europe/2012/DEV305) zase lépe probírá clusterování a některé další aplikační scénáře  

*Poznámka: Na záznamu předchozího semináře o novinkách v ASP.NET se pracuje. Bohužel se nám to poněkud zvrhlo v debatní kroužek, což je na místě pěkné, ale na záznamu poněkud nesrozumitelné, takže musím vymyslet, jak to nějak sestříhat, aby to dávalo smysl.*