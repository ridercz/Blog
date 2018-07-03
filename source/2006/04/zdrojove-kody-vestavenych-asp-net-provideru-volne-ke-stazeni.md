<!-- dcterms:identifier = aspnetcz#88 -->
<!-- dcterms:title = Zdrojové kódy vestavěných ASP.NET providerů volně ke stažení! -->
<!-- dcterms:abstract = Microsoft uvolnil zdrojové kódy vestavěných providerů v ASP.NET 2.0 - Membership, Role, Profile a SiteMap. -->
<!-- np9:categoryId = 2 -->
<!-- x4w:category = Bezpečnost -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2006-04-14T11:00:00+02:00 -->
<!-- dcterms:dateAccepted = 2006-04-14T11:00:00+02:00 -->

Předpokládám, že jste obeznámeni s provider modelem v ASP.NET 2.0 (nejste-li, [přijďte na náš seminář](/Articles/85-petidilny-seminar-novinky-v-asp-net-2-0.aspx), obeznámíme vás). Microsoft dnes uvolnil zdrojové kódy většiny vestavěných providerů pro membership, role, profily a sitemap. To vám může pomoci k pochopení, co a jak ti provideři vlastně dělají.

Odkaz a doplňující informace najdete na [weblogu Scotta Guthrieho](http://weblogs.asp.net/scottgu/archive/2006/04/13/442772.aspx).

S tím souvisí drobná poznámka: Vestavěný membership a role provider má spoustu užitečných vlastností, ale nevýslovně ohavnou databázovou strukturu, jako daň za univerzalitu. Napsal jsem si proto vlastní SimpleMembershipProvider a SimpleRoleProvider. Sice toho neumí tolik, ale vystačí si dohromady se třemi jednoduchými tabulkami. Momentálně ty třídy testuji (jsou nasazeny mimo jiné na tomto webu). Pokusím se je dát volně k dispozici běem příštího týdne.