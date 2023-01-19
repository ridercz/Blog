<!-- dcterms:identifier = aspnetcz#10 -->
<!-- dcterms:title = Pohled do hlubin webserverovy duše (aneb jak fungují HTTP moduly a handlery) -->
<!-- dcterms:abstract = Kromě psaní klasických ASP.NET stránek (ASPX) je možné webové aplikace psát ještě "o úroveň níž", tedy pomocí HTTP handlerů a modulů. Je to jediná možnost jak implementovat některé funkce a nejpraktičtější možnost jak implementovat mnohé jiné. V tomto spíše teoretickém článku si povíme, jak vlastně funguje komunikace .NET s Internet Information Services a kde do toho můžeme jako programátoři zasahovat. -->
<!-- x4w:category = IT -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2005-01-10T03:55:09.127+01:00 -->
<!-- dcterms:date = 2005-01-10T03:55:09.127+01:00 -->

Kromě psaní klasických ASP.NET stránek (ASPX) je možné webové aplikace psát ještě "o úroveň níž", tedy pomocí HTTP handlerů a modulů. Je to jediná možnost jak implementovat některé funkce a nejpraktičtější možnost jak implementovat mnohé jiné. V tomto spíše teoretickém článku si povíme, jak vlastně funguje komunikace .NET s Internet Information Services a kde do toho můžeme jako programátoři zasahovat.

## Jak funguje web server

Web server komunikuje s okolím prostřednictvím protokolu <acronym title="Hypertext Transfer Protocol">HTTP</acronym>. Velmi zjednodušeně transakce probíhá nějak takhle:

1.  Klient se připojí na server a řekne "*chci z webu *[*www.aspnet.cz*](/)* soubor `/_gfx/mvp.png`*". 
Server se podívá do své konfigurace a zjistí, že WWW root pro server jménem [www.aspnet.cz](/) ukazuje do fyzického adresáře `C:\InetPub\wwwroot\`, a že se tedy požadovaný soubor nachází na fyzické cestě `C:\InetPub\wwwroot\_gfx\mvp.png`. 
Na základě shora uvedeného zjištění uchopí předmětný soubor, pošle ho klientovi a ukončí spojení.

Pokud bychom napsali web server podle výše uvedených zásad (což je triviální), sice by fungoval, ale uměl by posílat jenom statické stránky, předávat soubory bez jakékoliv další funkcionality.

A proto se už v dobách, kdy byly počítače dřevěné a šlapací, objevily takzvané <acronym title="Common Gateway Interface">CGI</acronym> skripty. Jejich princip je geniálně jednoduchý: pokud byl požadovaný soubor program, tak místo aby se odeslal klientovi, spustil se a klientovi se poslal jeho výstup. Programování webových aplikací tímto způsobem má pravda i své výhody (je jednoduché pro někoho, kdo umí programovat klasické konzolové aplikace), ale nevýhody často převažují: nízký výkon, komplikovaná údržba, možné ohrožení bezpečnosti... 

Proto spatřila světlo světa technologie <acronym title="Internet Server Application Programming Interface">ISAPI</acronym>. S jistým zjednodušením jest možno říci, že se jedná o univerzální technologii, která umožňuje předávat HTTP požadavky rozličným komponentám (říká se jim ISAPI filtry), aby si s nimi poradily jak umí. 

Klasickým případem z internetového dávnověku může být technologie <acronym title="Server-side Includes">SSI</acronym>: Vložením speciální direktivy (pokud mne paměť neklame, je to `<!--#include file="jmenosouboru"-->`) do HTML souboru bylo možno na straně serveru vložit do HTML kódu jiný soubor (příkladně vždy se opakující navigaci) a výsledek odeslat. 

## ISAPI v IIS 6

Od té doby se technologie *poněkud* vyvinula a na vrcholu je nyní technologie .NET. Podíváme-li se na Microsoft Internet Information Services 6.0 (web server ve Windows 2003), zpracovávají se HTTP požadavky na .NET aplikace nějak takhle (klepnutím na obrázek otevřete jeho větší verzi):

[![Schéma zpracování HTTP požadavku v IIS 6 - popis v textu](https://www.cdn.altairis.cz/Blog/2005/20050110-process-schema-lq.png "Schéma zpracování HTTP požadavku")](https://www.cdn.altairis.cz/Blog/2005/20050110-process-schema-hq.png)

Na samém počátku je IIS. Jeho konfigurace je uložena v Metabázi (fyzicky se jedná o soubor `%SYSTEMROOT%\System32\inetsrv\MetaBase.xml`). Kromě mnoha jiných je tam také uložena informace který virtuální server (určený kombinací IP adresy, portu a hostname) ukazuje na kterou oblast (složku) disku a jaké ISAPI moduly se mají na jaké soubory aplikovat.

Posledně zmíněné nastavení je závislé na příponě serveru. IIS tak mapuje soubory s příponou *.asp* na `ASP.DLL` (ISAPI filtr pro klasické ASP 3.0), soubory s příponami *.aspx, .ascx, .asmx*  a podobně na `ASPNET_ISAPI.DLL` (totéž pro ASP.NET), výše zmíněné server-side includes soubory *.shtml*, *.shtm* a *.stm* na `SSINC.DLL` a podobně.

Z výše zmíněného vyplývá, že ASP.NET engine (a tedy ani vaše aplikace) se nedozví o požadavcích, které byly učiněny na soubory, jejichž přípony nejsou namapovány na `ASPNET_ISAPI.DLL`. Veškeré techniky popsané v tomto článku, jakož i v jeho pokračováních, tedy můžete použít jenom na soubory s mapovanými příponami. Pokud tedy chcete např. napsat HTTP handler který bude automaticky zmenšovat JPG obrázky, musíte příponu *.jpg* namapovat v konfiguraci IIS stejně jako např. *.aspx*. 

### Wildcard application maps

IIS 6.0 přináší novinku, která umožňuje výše zmíněné omezení obejít - *wildcard application maps*. Pomocí ní můžete nastavit, aby se *veškeré* požadavky zpracovávaly prostřednictvím nějakého ISAPI filtru. Pokud tedy nastavíte toto mapování na ASPNET ISAPI filtr (`C:\WINDOWS\Microsoft.NET\Framework\v1.1.4322\aspnet_isapi.dll`), budou se veškeré požadavky zpracovávat pomocí ASP.NET engine a budete do nich moci zasahovat.

Shora uvedenou technologii používá např. můj systém [SilverWolf](http://software.altaircom.net/software/silverwolf.aspx) (živé nasazení příkladně v [mé fotogalerii](http://gallery.rider.cz/default.xhtml)), když automaticky generuje HTML a náhledy při požadavcích na adresáře, obrázky nebo soubory s příponou *.xhtml*.

Pokud chcete pro daný web wildcard mapping nastavit, otevřete si v IIS Manageru jeho vlastnosti a na záložce *Home directory* klepněte na *Application Settings* -> *Configuration*. Kromě obvyklého mapování máte možnost přidat i wildcardové. Pokud zrušíte zaškrtnutí pole *Verify that file exists*, nebude IIS ověřovat ani zda požadovaný soubor existuje, než zavolá ISAPI engine.

## ASP.NET Pipeline

Rozhodne-li se IIS že o blaho zadaného požadavku by se měl dále přičiniti ISAPI engine pro ASP.NET, může do toho začít mluvit vaše aplikace. Zde totiž ztrácí svou konfigurační moc metabáze a získává ji konfigurace .NET, jmenovitě soubory `Machine.Config` a `Web.Config`. Zjednodušeně řečeno: `Machine.Config` nastavuje parametry pro celý server, `Web.Config` může pro určitou aplikaci tato nastavení doplnit či přepsat. Pokud tak neučiní, použijí se nastavení z `Machine.Config`. Pomocí těchto souborů můžete, jak si povíme v následných článcích, do hry zapojit vlastní HTTP moduly a handlery.

### GLOBAL.ASAX a HTTP moduly poprvé

Jako první se odpálí patřičné události (znáte lepší překlad pro *firing event? *;-) definované v `GLOBAL.ASAX` - typicky se jedná například o oblíbenou událost `BeginRequest` a podobně.

Dále přijdou na řadu zkonfigurované HTTP moduly. Pro tento okamžik si je můžete představit jako nezávislé knihovny (aplikace o nich fakticky nemusí vůbec vědět a nemůže jim do činnosti moc mluvit), které se napojí na události aplikace a dělají prakticky totéž co `GLOBAL.ASAX`.

HTTP moduly se používají například pro autentizaci a autorizaci. Používáte-li například *Forms Authentication*, vězte že její funkčnost je zajištěna právě HTTP modulem. Nic vám tedy nebrání v tom, abyste si napsali vlastní autentizační modul a používali ho místo ní (příklad - v angličtině - najdete na [webu SAMS publishing](http://www.samspublishing.com/articles/article.asp?p=25466&seqNum=1)).

V tomto okamžiku máme možnost víceméně libovolně měnit obdržený požadavek. Hezkým příkladem je například takzvaný *url rewriting*. Z přirozenosti ASP.NET skriptů vyplývá, že je nejsnazší jsou-li volány nějak jako */Clanek.aspx?id=123*. Tento postup ovšem není příliš v oblibě u uživatelů a vyhledávačů, neb ti mají rádi "hezká" URL. Mnohem lepší by bylo, kdyby adresa vypadala nějak jako */Clanky/123.aspx*. Ovšem spravovat smečku autogenerovaných ASPX souborů není nic moc. Proto v rámci HTTP modulu můžeme nastavit, že se všechny adresy */Clanky/neco.aspx* přepíší na */Clanek.aspx?id=neco*. Shora uvedené nastane v rámci serveru, klient se o tom vůbec nedozví. Chcete praktický příklad? Podívejte se na adresu článku, který právě čtete.

### HTTP handler

Poté, co moduly dokončí svou práci, zavolá se odpovídající handler (odpovídající podle nastavení v *.Config* souborech). To je "konečná instance", třída jejímž smyslem je vygenerovat vlastní obsah stránky a poslat ho na klienta.

Typickým příkladem může být například zpracování souborů s příponou ASPX: konečnou instancí pro ně je HTTP handler, který přečte zdrojový soubor z disku a vykoná k němu přiložený kód (ať už inline nebo backend). Jiným příkladem je třeba handler, který se vyvolá při dotazu na jakýkoliv soubor s příponou *.Config* - ten je o hodně jednodušší, protože bez ohledu na cokoliv dalšího prostě vygeneruje chybové hlášení na téma že do konfiguračních souborů nikdo nemá co lézt.

### GLOBAL.ASAX a HTTP moduly podruhé

Poté co handler dokončí svou práci, dění se vrací zpět do rukou HTTP modulů a GLOBAL.ASAX. Odpálí se další eventy, ve kterých je možno pracovat s výstupem, který handler vygeneroval, a nějak ho dále měnit.

Hezkým příkladem takového modulu může být například [rozkošné dílko](http://www.mvps.org/emorcillo/dotnet/web/qse.shtml) mého MVP kolegy [Eduarda A. Morcilla](http://www.mvps.org/emorcillo/index.shtml). Pomocí HTTP modulu transparentně šifruje a dešifruje parametry předávané prostřednictím QueryStringu.

## Shrnutí

HTTP požadavky mohou být v rámci IIS zpracovávány různými ISAPI filtry. IIS rozhoduje o tom, které to budou, na základě vlastní konfigurace a přípony souboru, případně wildcard mappingu.

Pokud je použit ISAPI modul pro ASP.NET, lze do průběhu vyřizování požadavků zasahovat prostřednictvím HTTP modulů a HTTP handlerů. Moduly lze vrstvit "*na sebe*" a obvykle se používají k modifikování HTTP požadavku nebo odpovědi, například k autentizaci nebo autorizaci. HTTP handler je vždy právě jeden a je odpovědný za "obvyklou práci", tedy vlastní vygenerování odpovědi na uživatelův požadavek.

V dalších článcích si povíme o tom, jak je možno psát a používat vlastní HTTP handlery a moduly.