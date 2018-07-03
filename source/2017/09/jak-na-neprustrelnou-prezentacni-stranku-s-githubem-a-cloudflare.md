<!-- dcterms:identifier = aspnetcz#5458 -->
<!-- dcterms:title = Jak na neprůstřelnou prezentační stránku s GitHubem a CloudFlare -->
<!-- dcterms:abstract = Chcete si udělat jednoduchou statickou stránku na nezničitelné infrastruktuře a zadarmo? Kombinace GitHubu a CloudFlare vám to zajistí. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Tipy, triky -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2017-09-03T02:20:15.86+02:00 -->
<!-- dcterms:dateAccepted = 2017-09-03T00:00:00+02:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20170903-jak-na-neprustrelnou-prezentacni-stranku-s-githubem-a-cloudflare.jpg -->

Znáte to: chcete vytvořit jednoduchou prezentační stránku, pár statických souborů nebo možná jeden jediný. Osobní stránku, landing page nějakého projektu a podobně. Jenomže kam s tím? Aby to bylo bezpečné, spolehlivé a pokud možno neprůstřelné – bezpečné a kapacitně zvládající případnou vysokou zátěž nebo i DoS útoky. A to celé pokud možno zdarma… Odpovědí je kombinace dvou bezplatných služeb: GitHub Pages a CloudFlare.

Naznal jsem, že po několika letech by <span style="text-decoration: line-through;">kovářova kobyla</span> ajťácký valach měl přestat chodit bos a že bych si měl udělat aktuální domovskou stránku na [www.rider.cz](http://www.rider.cz). A ačkoliv mám k dispozici kdejakou infrastrukturu od vlastních serverů po Microsoft Azure, vydal jsem se právě naznačenou cestou. Moje požadavky byly následující:

*   Infrastruktura kompletně nezávislá na mé stávající, aby se dala použít třeba i v případě výpadku nebo útoku na mne.
*   Stačí hostování statických stránek, není třeba žádné serverové programování.
*   Bezúdržbové, bez nutnosti cokoliv (kromě obsahu) aktualizovat.
*   Bezplatné bez omezení (objemu uložených či přenesených dat atd.) v pro mne relevantních hodnotách.
*   Možnost provozu na vlastní doméně (`rider.cz`).
*   Podpora HTTPS 

## GitHub Pages

Většina programátorů zná GitHub jako platformu pro verzování zdrojového kódu a týmovou spolupráci. Nicméně GitHub nabízí i možnost hostingu statických stránek, třeba osobních stránek programátorů nebo softwarových projektů. Pokud stačí statická stránka, je to velice dobrá varianta, protože infrastruktura GitHubu je daleko lepší, než má většina z nás k dispozici. V tomto článku budu popisovat tři možnosti, jak si vytvořit vlastní domovskou stránku na GitHubu (nejsou jediné, [přehled najdete v nápovědě](https://help.github.com/categories/github-pages-basics/)):

1.  "Hlavní" stránka uživatele, nativně na adrese `*username*.github.io`.
2.  Stránka "projektu" (repozitáře) vytvořená ze složky `/docs`,  nativně na adrese `*username*.github.io/*repository-name*`.
3.  Publikování celého repozitáře, nativně opět na adrese `*username*.github.io/*repository-name*`. 

### Hlavní stránka uživatele na adrese `*username*.github.io`

Tuto stránku doporučuji vytvořit vždy, protože i když tak neučiníte (a budete využívat ostatní možnosti), stejně tuto adresu budete potřebovat a budete ji – minimálně při testování funkčnosti – využívat. Jinak je vhodná v případě, že potřebujete nějaký jednoduchý web, ale nemáte nebo nechcete použít vlastní doménu.

Stránky na výchozí adrese `*username*.github.io` si vytvoříte velice jednoduše: stačí vytvořit repozitář téhož jména. Moje uživatelské jméno na GitHubu je `ridercz`, takže jsem si založil repozitář jménem `[ridercz.github.io](https://github.com/ridercz/ridercz.github.io)`. Nic dalšího není třeba nastavovat. Obsah tohoto repozitáře bude dostupný na adrese `[https://ridercz.github.io/](https://ridercz.github.io/)` (včetně podpory HTTPS), root na root. Vytvoření nemusí být okamžité, pokud to nefunguje, minutku počkejte.

S repozitářem pracujete standardním způsobem, takže prostě nahrajte soubor `index.html` a hotovo. Přesně to vidíte v citovaném repozitáři. V mém případě obsahuje jediný soubor, kterým je `index.html` a který obsahuje META REFRESH přesměrování na mou skutečnou homepage, na adresu [`https://www.rider.cz/`](https://www.rider.cz/). 

### Stránka projektu na adrese `*username*.github.io/*repository-name*`

Tato možnost se vám hodí v případě, že chcete vytvořit prezentační stránku projektu, který je hostovaný na GitHubu (repozitář tedy obsahuje kód a další informace) a chcete to udržovat všechno při jednom. Tento postup používám třeba ve svém projektu AutoACME: web [https://www.autoacme.net/](https://www.autoacme.net/) je hostován na GitHubu a [v repozitáři projektu samého](https://github.com/ridercz/AutoACME/tree/master/docs). Chcete-li se vydat touto cestou, postupujte následovně:

1.  Vytvořte v repozitáři svého projektu složku `docs`.
2.  Do ní nahrajte soubory, které mají být vidět na webu. Tato složka bude rootem webu, takže do ní nejspíš chcete umístit soubor `index.html`.
3.  V repozitáři klepněte na ikonku *Settings* a poté najděte sekci *GitHub Pages*.
4.  V rozbalovacím seznamu Source zvolte možnost *master branch /docs folder.*
5.  Hotovo. Obsah adresáře bude dostupný na adrese `*username*.github.io/*repository-name*`. Opět platí, že vytvoření nemusí být okamžité, pokud to nefunguje, minutku počkejte. 

Vše uvedené (včetně adresy) bude fungovat, i když nemáte svou osobní stránku na `*username*.github.io`. Pokud zadáte tuto adresu, server vrátí chybu, že stránka neexistuje. Pokud zadáte adresu včetně repozitáře, vše bude fungovat.

### Publikování celého repozitáře na adrese `*username*.github.io/*repository-name*`

Tento postup se hodí, pokud chete mít pro web samostatný repozitář, kde nebude nic jiného. Použil jsem ho pro svou osobní stránku na [www.rider.cz](http://www.rider.cz), protože jsem si nechtě "zabrat" hlavní stránku s výchozí adresou na doméně `github.io`, kdybych ji někdy potřeboval. Takže jsem vytvořil nový repozitář jménem [HomePage](https://github.com/ridercz/HomePage/)`` (může se jmenovat jakkoliv). 

Dále je postup velmi podobný tomu, co bylo popsáno výše. Tj. nahrajte do repozitáře obsah svého webu – root na root. V *Settings* ale jako *Source* zvolte *master branch*. Stránka bude dostupná na adrese `*username*.github.io/*repository-name*`.

### Jak na vlastní doménu

Ve všech výše zmíněných případech můžete web publikovat i na jiné adrese, třeba na vlastní doméně. Pokud tak chcete učinit, musíte provést nastavení na straně GitHubu i na straně DNS.

**Nastavení na straně GitHubu** je jednoduché – stačí vytvořit v rootu projektu textový soubor jménem `CNAME` (bez přípony), jehož jediným obsahem bude adresa, na které má být stránka publikována. V mém případě tedy jediným obsahem souboru bude text `www.rider.cz`. Ve vlastním zájmu nepoužívejte "holou doménu" (např. `rider.cz`), neboť by vám to výrazně zkomplikovalo další nastavení.

Postup **nastavení na straně DNS serveru** závisí na tom, jaký server nebo poskytovatele používáte. Ať už je to jakkoliv, potřebujete vytvořit záznam typu `CNAME`, který bude zdrojovou adresu (v mém případě `www`) překládat na `*username*.github.io`, tj. v mém případě `ridercz.github.io`. Neřešíte, jestli je za lomítkem rozlišovací název repozitáře nebo ne, alias je vždy na adresu bez lomítka (ono to v DNS ani jinak nejde, logicky). GitHub si požadavky routuje sám právě pomocí záznamu v `CNAME` souboru.

A je hotovo. Jakmile se změny v DNS propíší (což může trvat několik sekund i několik dnů, v závislosti na nastavení TTL na serveru), budou stránky fungovat na nové adrese.

Stránka musí mít vždy právě jednu adresu, soubor `CNAME` nesmí obsahovat víc než jednu hodnotu. Pokud chcete, aby byl web dostupný na více adresách (třeba ve verzi s `www` na začátku i bez něj), musíte si přesměrování zajistit mimo GitHub Pages, třeba na vlastním serveru nebo u poskytovatele hostingových služeb, nebo třeba pomocí CloudFlare.

Nevýhodou ovšem je, že tímto krokem jste ztratili podporu HTTPS. GitHub má pouze wildcard certifikát pro `*.github.io`, nemá a nemůže mít certifikát pro vaši vlastní doménu a nedá se tam ani nijak nahrát. Pokud chcete aby váš web byl dostupný přes HTTPS i na vlastní doméně, musíte použít další službu, a tou je CloudFlare.

## CloudFlare

[CloudFlare](https://www.cloudflare.com/) nabízí celou řadu užitečných služeb, například:

*   Provozování DNS serverů (nemusíte mít vlastní servery nebo se spoléhat na servery svého poskytovatele web hostingu).
*   Funguje jako firewall/proxy/web akcelerátor. Tj. postaví se mezi váš server a klienty z Internetu.
*   To umožňuje reagovat na různá ohrožení typu DoS útoky a podobně.
*   Také to vašemu webu automaticky přidá podporu nejnovějších standardů typu HTTP/2 nebo IPv6, a to i když je váš vlastní server nepodporuje.
*   Umí též zajistit terminaci HTTPS a automaticky vám vystaví důvěryhodný HTTPS certifikát. 

To vše nabízí zdarma. Má i placené programy, které toho umí víc, ale pro naše nároky bude stačit ten bezplatný.

Jako první krok musíte převést svou doménu na DNS servery CloudFlare, což bude vyžadovat i změnu u vašeho registrátora. Na straně CloudFlare je na to hezký a dle mého názoru naprosto blbuvzdorný průvodce. Na straně svého registrátora domény si s tím musíte poradit sami. CF podporuje i DNSSEC a ačkoliv je tato technologie dle mého názoru mrtvě narozené dítě, můžete to nastavit.

V CloudFlare potom nastavte patříčné DNS záznamy. Zde vidíte moje nastavení:

[![Screenshot CloudFlare](http://www.aspnet.cz/Files/20170903-SNAGHTML464454b_thumb.png "Screenshot CloudFlare")](http://www.aspnet.cz/Files/20170903-SNAGHTML464454b.png)

Ikonka oblaku v pravé části pak určuje, jak se bude s DNS záznamem zacházet. Pokud je oranžová (jako na obrázku), budou požadavky směrovány na serveru CLoudFlare. Pokud na ni kliknete, obláček zešediví, šipka ho obejde a CloudFlare bude působit jenom jako obyčejný DNS server. My chceme využívat služeb CloudFlare (přidání HTTPS), takže obláček zůstane oranžový.

Jakmile se změna projeví, bude váš web dostupný pomocí obou variant prokotolu: HTTP i HTTPS. Pokud chcete, aby byl web dostupný jenom přes HTTPS (a požadavky na HTTP se přesměrovaly), klepněte v horní části stránky na *Page Rules* a pak na tlačítko *Create Page Rule*. Poté zadejte hodnoty podle následujícího vzoru a klepněte na *Save and Deploy*:

[![Screenshot CloudFlare](http://www.aspnet.cz/Files/20170903-image_thumb_2.png "Screenshot CloudFlare")](http://www.aspnet.cz/Files/20170903-image_6.png)

Všechny požadavky zaslané protokolem HTTP budou nyní přesměrovány na HTTPS. V sekci *Crypto* můžete nastavit další podrobnosti. Zejména pak režim fungování HTTPS a HSTS.

CloudFlare podporuje čtyři režimy fungování HTTPS:

*   *Off* znamená, že se HTTPS nebude vůbec používat.
*   *Flexible* je výchozí nastavení a znamená, že se požadavky od klienta na servery CF mohou dít pomocí HTTPS, ale požadavky mezi CF a vaším serverem (resp. zde serverem GitHub Pages) jdou přes nešifrované HTTP. To není zdaleka ideální, protože umožňuje i pasivní odposlech mezi servery CF a GitHubu. Nicméně největší nebezpečí hrozí mezi klientem a CF, takže i takto nedokonalá podpora má svůj smysl.
*   *Full* znamená, že komunikace mezi CF a vaším serverem (GitHubem) sice probíhá přes HTTPS, ale nekontroluje se platnost certifikátu. Ten může tedy být vydaný nedůvěryhodnou CA nebo pro jiný host name. To je nastavení, které chcete použít v případě GitHub Pages (certifikát mají, ale špatný, pro jiný host name). Oproti předchozí variantě je tato lepší, protože útočník musí mít pro úspěšný útok možnost provoz modifikovat (podvrhnout certifikát), nestačí prostý pasivní odposlech.
*   *Full (strict)* vyžaduje, aby origin server měl platný certifikát od důvěryhodné CA a pro správný host name. Což je ideální stav, kterého ale lze dosáhnout pouze máte-li pod kontrolou cílový server. V případě GitHub pages ho použít nemůžete. 

Ve stejné sekci *Crypto* můžete nastavit i parametry HTTP Strict Transport Security. Pokud nevíte co to je, podívejte se na záznam mé přednášky [HTTPS už máte, tak ještě aby vám k něčemu bylo](https://www.youtube.com/watch?v=EpdIx5dNfOk).

Update: Pokud chcete aby se HTTP požadavky v rámci celé domény automaticky přesměrovaly na HTTPS, nemusíte tak činit pomocí pravidel, ale [můžete to nastavit v rámci vlastností HTTPS](https://blog.cloudflare.com/how-to-make-your-site-https-only/). Díky za upozornění Michalu Špačkovi.

## Nevýhody tohoto řešení

Mnou popisované řešení má samozřejmě i nevýhody a není vhodné ve všech případech.

*   **GitHub Pages nepodporují žádné serverové aplikace.** Nemůžete tedy používat něco jako ASP.NET, PHP a podobně. Umí jenom publikovat mrtvá data. Což není tak úplně pravda, je tam podpora pro šablonový statický generátor Jekyll, ale ten se mi bohužel nikdy nepodařilo rozchodit k mé plné spokojenosti.
*   **Kdokoliv vidí kompletní zdrojáky vašeho webu a celou jejich historii.** Což ve většině případů nevadí, protože u statického webu stejně není moc co schovávat. Pokud vám to vadí, můžete si za $7/měs. pořídit placený účet, který vám umožní vytvářet privátní repozitáře (ale jejich stránky jsou veřejné).
*   **Není k dispozici end-to-end HTTPS. **Pokud někdo provede úspěšný útok mezi CloudFlare a GitHubem, může váš web kompromitovat. V případě běžných prezentačních stránek toto riziko pokládám za malé (jakkoliv ne nulové) a jsem ochoten to risknout. Pokud bych k tomu ochoten nebyl, musel bych celou tuto metodu opustit.