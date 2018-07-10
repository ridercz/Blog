<!-- dcterms:identifier = aspnetcz#29 -->
<!-- dcterms:title = Personalizace v ASP.NET 2.0 -->
<!-- dcterms:abstract = Zařekl jsem se, že se Whidbey vůbec nebudu zabývat, dokud nebude na světě alespoň beta 2 (kdo přepisoval aplikace pro .NET 1.0 z bety 1 do bety 2 ví proč). Nicméně toto mé úsilí jest systematicky podkopáváno Microsoftem i rozličnými nadšenci. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Tipy, triky -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2005-04-10T02:33:57.373+02:00 -->
<!-- dcterms:dateAccepted = 2005-04-10T02:33:57.373+02:00 -->

Zařekl jsem se, že se Whidbey vůbec nebudu zabývat, dokud nebude na světě alespoň beta 2 (kdo přepisoval aplikace pro .NET 1.0 z bety 1 do bety 2 ví proč). Nicméně toto mé úsilí jest systematicky podkopáváno Microsoftem i rozličnými nadšenci. Jedním z nich je jistý Egypťan jménem Khaled Hussein, který napsal sérii třech článků o možnostech pesonalizace v ASP.NET 2.0:

*   [Část první](http://www.kdkeys.net/forums/4107/ShowPost.aspx)
*   [Část druhá](http://www.kdkeys.net/forums/4135/ShowPost.aspx)
*   [Část třetí](http://www.kdkeys.net/forums/4137/ShowPost.aspx)

Ve zkratce: základním principem .NET je abstrakce. Framework se snaží programátora odstínit od detailů, aby se mohl věnovat skutečné kreativní práci. Ono "odstínění od detailů" může spočívat jednak v abstrakci od konkrétního hardware/operačního systému, ale také v "zapouzdření" často používaných technik do jednoduchého rozhraní. Typickým příkladem je *Forms Authentication* v ASP.NET 1.1. Nevím jak vy, ale já osobně jsem variantu téhož napsal v ASP 3.0 asi stokrát.

Abstrakce ale není dokonalá: pokud se nechcete spokojit s několika uživateli napevno zadanými ve web.configu (ne že by to v mnoha případech nestačilo), musíte si databázi uživatelů sami napsat. Pokud máte trochu složitější strukturu, používáte role a podobně, Forms Authentication vám sice práci ulehčí, ale nezbavíte se ji.

Personalizační mechanismy v nové verzi .NET jsou mnohem dál: bez jediného řádku kódu lze naprogramovat správu uživatelů, podporu skupin a dokonce i profilů, kam lze ukládat libovolné údaje, samozřejmě jako strongly-typed vlastnosti. Více se dozvíte ve shora linkovaných článcích.

Čím lépe poznávám Whidbey, tím více nabývám přesvědčení, že současná verze 1.1 je spíše taková *ochutnávka* toho, co lze od .NET čekat. Už se na něj těším, protože k .NET programování mne vrátilo to, že to znovu začala být *zábava*. Whidbey slibuje, že to bude zábava ještě větší!