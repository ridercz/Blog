<!-- dcterms:identifier = aspnetcz#61 -->
<!-- dcterms:title = Kompilace a nasazení (deployment) aplikací v ASP.NET 2.0 - přehled -->
<!-- dcterms:abstract = Mezi ASP.NET 1.x a 2.x se změnil model kompilace webových aplikací a s tím souvisí i rozdílný způsob instalace aplikací na produkční server (nebo chcete-li deploymentu). Aby toho nebylo málo, v této oblasti je také zásadní rozdíl mezi plnokrevným Visual Studiem 2005 a Visual Web Developerem Express. Prostě nastal čas udělat v tom trochu pořádek. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Programování -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2005-11-21T22:12:11.047+01:00 -->
<!-- dcterms:dateAccepted = 2005-11-21T22:12:11.047+01:00 -->

Mezi ASP.NET 1.x a 2.x se změnil model kompilace webových aplikací a s tím souvisí i rozdílný způsob instalace aplikací na produkční server (nebo chcete-li deploymentu). Aby toho nebylo málo, v této oblasti je také zásadní rozdíl mezi plnokrevným Visual Studiem 2005 a Visual Web Developerem Express. Prostě nastal čas udělat v tom trochu pořádek.

## Kompilační modely ASP/ASP.NET

Kompilace je proces, jímž se program překládá z jazyka srozumitelného (některým) lidským bytostem do jazyka srozumitelného počítačům. V případě .NET jazyků do jakési "mezifáze", kterou poté vykonává .NET runtime, ale to pro naše účely není podstatné. V případě webových aplikací se tento proces s postupem času vyvíjel.

### ASP 3.0: Kde nic není, ani čert nebere

V "klasických" ASP 3.0 se o kompilaci nedá moc mluvit. Byl použit skriptovací jazyk, který není kompilovaný, ale interpretovaný. To znamená, že se nepřekládá do strojového kódu, ale přímo vykonává interpreterem.

Jednotlivé ASP stránky také tvořily spíše konfederaci nezávislých skriptů, než aplikaci. Dvě stránky spolu neměly v zásadě nic společného, nemohly nijak systemizovaně komunikovat a v podstatě o sobě vůbec nevěděly.

Pokud jste chtěli ASP aplikaci nahrát na server, museli jste nahrát přímo zdrojové kódy, jiná forma neexistovala.

### ASP.NET 1.0 a 1.1: Code behind

První verze ASP.NET přišla s konceptem "code behind", kdy stránka byla rozdělena na dvě části. Soubor **.aspx* obsahoval HTML a serverové ovládací prvky a programový kód byl uložen v samostatném souboru (obvykle nazvaném **.aspx.vb* nebo **.aspx.cs*). Každá stránka k sobě měla přiřazenou třídu (class), která se starala o její funkčnost. Veškeré serverové ovládací prvky přidané do ASPX stránky bylo nutno znovu deklarovat v code behind souboru. V případě VS.NET se o to postaralo vývojové prostředí a každý soubor obsahoval velký kus automaticky generovaného kódu, kde se tyto věci odehrávaly.

Před nahráním aplikace na server jste tuto museli nejprve zkompilovat. Výsledkem byla jedna assembly (DLL knihovna), která obsahovala veškerou funkčnost aplikace. Na server se pak nahrávala tato DLL (do adresáře *bin*) a samotné ASPX soubory s pseudo-HTML kódem.

Z tohoto důvodu také nebylo možné kombinovat při psaní jedné webové aplikace více jazyků, např. napsat část aplikace ve VB.NET a část v C#, protože ve výsledku z toho bude jediná assembly.

Oproti předchozí verzi má tento přístup dvě hlavní výhody: Za prvé je běh aplikace mnohem rychlejší, protože u ASP se při každém požadavku stránka jakoby "kompilovala" znovu. Za druhé na produkční server nenahráváte zdrojové kódy, což je výhodné třeba na hostingu - předmětné DLL sice lze poměrně snadno dekompilovat, ale pořád lepší, než nahrávat přímo zdrojové kódy. Nevýhodou tohoto přístupu je, že při každé, sebemenší, změně programového kódu musíte celou aplikaci znovu kompilovat a nahrávat novou verzi DLLka na server.

### ASP.NET 2.0: Code beside

Současná verze ASP.NET 2.0 podporuje z důvodu zpětné kompatibility i shora uvedenou metodu *code behind*, ale zároveň přichází s novinkou jménem *code beside*.

Nový .NET 2.0 přináší koncept *partial class*, což si lze představit jako zápis jedné třídy do více souborů. V případě ASP.NET to znamená, že objektová reprezentace serverových ovládacích prvků zapsaných v pseudo-HTML souboru není generována vývojovým nástrojem do nějaké "schované" části zdrojového kódu, ale je generována samostatně do zvláštního souboru runtimem (při běhu). 

Každá stránka má svou vlastní třídu a také svou vlastní assembly. Tento přístup má několik důsledků:

*   Jednu a tutéž aplikaci je možno složit ze stránek psaných v různých jazycích, protože každá stránka má svou vlastní assembly (DLL). 
V případě, že se změni kód jedné stránky, je nutné překompilovat pouze jednu assembly, odpovídající dané stránce, a ne celou aplikaci.

Zvláštní úlohu mají třídy uložené ve složce *App_Code*. To jsou takzvané sdílené třídy (*shared class*) a zkompilují se do jednoho samostatného souboru.

Důležitou změnou je, že shora uvedené probíhá standardně nikoliv ve vývojovém prostředí, ale až na serveru, při běhu. Znamená to mimo jiné to, že pokud na server nahrajete kompletní aplikaci a změníte něco ve zdrojovém kódu, automaticky se při dalším požadavku předmětná část aplikace překompiluje a uloží se do *C:\WINDOWS\Microsoft.NET\Framework\v2.0.50727\Temporary ASP.NET Files*.

Druhá možnost je, že .NET frameworku tuto činnost ušetříte a aplikaci zkompilujete "ručně", a na server nahrajte jenom předmětné knihovny. Narozdíl od verzí 1.x není z hlediska ASP.NET nutné nahrávat ani ASPX soubory, neboť i jejich obsah je v DLL. Přítomnost těchto souborů může být nicméně nutná z jiných důvodů, jak si povíme za chvíli.

## Deployment ASP.NET 2.0 aplikací

Při nasazení ASP.NET 2.0 aplikací existují dvě cesty, jimiž se můžete vydat. První cesta spočívá v tom, že na web nahrajete kompletní projekt, včetně zdrojových kódů, a necháte na serveru, aby si je dle libosti kompiloval. Tato cesta je vhodná u menších aplikací a u aplikací kde čekáte, že může být užitečné mít možnost je pozměnit na straně serveru. **Je to také jediná možnost, pokud používáte Visual Web Developer Express**, protože pokročilejší možnosti má pouze Visual Studio 2005.

![Okno Publish web site](https://www.cdn.altairis.cz/Blog/2005/20051121-publish-web-site.png)Pokud jste šťastnými vlastníky VS 2005, můžete použít i druhou cestu, kompilaci celého webu. Chcete-li tak učinit, vyberete v menu *Build -> Publish web site*.

Pokud v objevivším se okně zaškrtnete *Allow this precompiled site to be updateable*, dostanete se do stavu zhruba podobného ASP.NET 1.1. Do vámi zvolené složky se nakopírují potřebné ASPX (atd) soubory a jejich funkčnost se zkompiluje do DLL knihoven v adresáři *bin*. Budete mít možnost měnit vzhled aplikace (HTML kód).

Pokud shora uvedené okénko nezaškrtnete, na první pohled se nic nezmění (jenom přibude položek v adresáři *bin*). Po bližším nahlédnutí ovšem zjistíte, že všechny soubory s příponou ASPX obsahují pouze následující text:

> This is a marker file generated by the precompilation tool, and should not be deleted!

Z hlediska ASP.NET jsou tyto soubory zbytečné (k ničemu se nepoužívají), ale mohou být užitečné v určitých konfiguracích IIS, kdy si server ověřuje, zda dotazovaný soubor skutečně existuje, takže na jeho místě musí něco být. Nezastupitelné jsou však "default documenty" (soubory *default.aspx*), pokud se chcete odkazovat pouze na root webu či adresáře, ne na název souboru.

### Web Deployment Projects

Pro usnadnění nasazení webových projektů Microsoft uvolnil add-in pro VS 2005 zvaný "web deployment projects". Tento plugin má čtyři hlavní funkce:

1.  Lze určit, do kolika DLL (assemblies) bude projekt rozdělen a jak se mají jmenovat - můžete to určit podle logiky vaší aplikace. 
Lze přímo editovat řídící soubory pro MSBuild. 
Můžete definovat několik různých přednastavených kombinací s různými parametry. 
V závislosti na shora uvedených kombinacích můžete v průběhu buildu nahradit specifické sekce souboru web.config jinými. Pravděpodobně máte jiné nastavení pro produkční a jiné pro testovací server, což lze snadno automatizovat.

Projekt WDP je momentálně ve fázi beta verze, nicméně to se týká jenom interface, vlastní build proces umí shora uvedené od samého počátku, jenom pro to ve VS není uživatelské rozhraní. Nemusíte se tedy bát tuto betu použít i v produkčním prostředí.

*   [Download (beta)](http://msdn.microsoft.com/asp.net/reference/infrastructure/wdp/default.aspx) 
[Příklady použití](http://weblogs.asp.net/scottgu/archive/2005/11/06/429723.aspx)