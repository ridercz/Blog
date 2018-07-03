<!-- dcterms:identifier = aspnetcz#159 -->
<!-- dcterms:title = Představení Internet Information Services (IIS) 7.0 -->
<!-- dcterms:abstract = Na akci v Bratislavě se podíváme na novou generaci webového a aplikačního serveru od Microsoftu, zejména z pohledu vývojáře .NET aplikací. -->
<!-- np9:categoryId = 6 -->
<!-- x4w:category = Akce a události -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2007-07-23T10:30:07+02:00 -->
<!-- dcterms:dateAccepted = 2007-07-23T10:30:07+02:00 -->

Internet Information Services 7.0, nová generace webového a aplikačního serveru od Microsoftu, přinášejí řadu novinek, které jistě potěší vývojáře i administrátory. IIS 7.0 je součástí Windows Vista a bude součástí Windows Server 2008 (alias "Longhorn"). 

Nová generace přináší řadu koncepčních změn, které by měly přispět k vyšší bezpečnosti, výkonnosti a snazšímu programování aplikací. 

**Modulární architektura** - veškerá funkčnost je k dispozici ve formě samostatných knihoven (modulů), které můžete zapínat a vypínat dle libosti. Server tedy může podporovat pouze přesně tu funkcionalitu, kterou potřebujete. Nestane se, že by na serveru bylo běželo něco co nepoužíváte, ale jenom to nejde vypnout. 

**Nový konfigurační model založený na XML** - zatímco předchozí verze IIS používaly pro ukládání konfiguračních dat metabázi, IIS 7 využívá konfigurační model známý z ASP.NET: hierarchicky organizované XML soubory. Znamená to mimo jiné, že nastavení aplikace a nastavení web serveru bude na jednom místě. 

**Lepší nástroje pro správu** - nový konfigurační model si žádá též nové nástroje pro správu serveru. Nová generace IIS Manageru je přehlednější a schopnější. Mimo jiné též umožňuje z jednoho místa provádět konfiguraci vlastností serveru i nastavení aplikace. 

**.NET integrated pipeline** - ASP.NET se dostává poněkud privilegovaného postavení: zatímco v předchozích verzích IIS byl .NET implementován jako jeden z mnoha ISAPI filtrů, v IIS 7 je jeho podpora zabudována přímo. To znamená větší možnosti pro ASP.NET programátory a možnost lepší spolupráce ASP.NET aplikací s jinými technologiemi jako PHP apod. 

## Pozvánka na akci v Bratislavě

Podrobněji se budu věnovat shora uvedeným tématům na akci, která se bude konat ve slovenské pobočce Microsoftu v Bratislavě **23. srpna 2007 od 9:00**. Vstup na akci je zdarma, podmínkou je ale předchozí registrace [na webu slovenského Microsoftu](http://msevents.microsoft.com/CUI/EventDetail.aspx?EventID=1032347096&Culture=sk-sk). 

Abych předešel očekávaným dotazům: v blízké budoucnosti se podobná akce uskuteční i v ČR. 

Další informace o IIS7 najdete na [www.iis.net](http://www.iis.net).