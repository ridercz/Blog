<!-- dcterms:identifier = aspnetcz#328 -->
<!-- dcterms:title = ASP.NET Universal Providers: Blýskání na lepší časy? -->
<!-- dcterms:abstract = Microsoft uvedl první veřejnou betaverzi nové generace providerů pro membership, role, profily a session. Na rozdíl od těch současných kromě SQL Serveru podporují i SQL Server Compact a Windows Azure. Neřeší sice všechny problémy, ale jsou docela zajímavé. -->
<!-- np9:categoryId = 7 -->
<!-- x4w:category = Software -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2011-06-30T23:45:22.6+02:00 -->
<!-- dcterms:dateAccepted = 2011-06-30T23:45:23+02:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20110630-asp-net-universal-providers-blyskani-na-lepsi-casy.png -->

Microsoft uvedl první veřejnou betaverzi nové generace providerů pro membership, role, profily a session. Na rozdíl od těch současných kromě SQL Serveru podporují i SQL Server Compact a Windows Azure. Neřeší sice všechny problémy, ale jsou docela zajímavé.

Stávající implementace (ve třídách *SqlMembershipProvider*, *SqlRoleProvider* atd.) je dost hrozná. Podporuje jenom Microsoft SQL Server a vyžaduje vytvoření dost divoké struktury tabulek, pohledů a uložených procedur, a to ve jménu maximální univerzálnosti celého řešení. Provider model sám je ovšem velice funkční, jenom to chce mít schopné providery (nejlépe samozřejmě [ty moje](http://altairiswebsecurity.codeplex.com/) ;-).

Nová generace providerů je založena na Entity Frameworku a je, jak již bylo řečeno, dosti univerzální. Na základě connection stringu umí fungovat proti "velkému" Microsoft SQL Serveru 2005 a vyššímu, "malému" SQL Compact a Windows Azure (předpokládám že proti Table Storage, ale zatím jsem do toho moc nešťoural).

Má nižší nároky na databázovou strukturu, vyžaduje jenom šest tabulek (žádné uložené procedury a pohledy), a struktura tabulek je skoro příčetná:

[![UniversalProviders](https://www.cdn.altairis.cz/Blog/2011/20110630-UniversalProviders_thumb.png "UniversalProviders")](https://www.cdn.altairis.cz/Blog/2011/20110630-UniversalProviders_2.png)

Bohužel i nadále zůstává plně zachována logika ukládání údajů více aplikací do jedné databáze, což činí propojení dat providera se zbytkem datové struktury poněkud komplikované. Rovněž je zachováno ukládání profilových vlastností serializovaně.

Podrobné informace najdete na [blogu Scotta Hanselmana](http://www.hanselman.com/blog/IntroducingSystemWebProvidersASPNETUniversalProvidersForSessionMembershipRolesAndUserProfileOnSQLCompactAndSQLAzure.aspx), knihovnu si můžete stáhnout pomocí NuGetu jako package jménem *System.Web.Providers*.