<!-- dcterms:identifier = aspnetcz#5465 -->
<!-- dcterms:title = Byte packer – jak na binární datové struktury? -->
<!-- dcterms:abstract = Jako programátoři ve vysokoúrovňovém jazyce zpravidla nemusíme řešit nízkoúrovňové formáty dat. Takové struktury řešíme na vysoké úrovni a na konci je serializujeme třeba do XML nebo JSON. Nebo, když už to jinak nejde, alespoň do CSV. Ale co když potřebujeme komunikovat s něčím, co má podstatně nižší úroveň, a potřebujeme do prostého pole bajtů uložit složitější datovou strukturu? Vytvořil jsem pomocnou třídu BytePacker, která vám s tím pomůže. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = IT -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2018-02-07T22:57:07.167+01:00 -->
<!-- dcterms:dateSubmitted = 2018-05-25T11:24:00+02:00 -->
<!-- dcterms:dateAccepted = 2018-02-07T23:00:00+01:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20180207-byte-packer-jak-na-binarni-datove-struktury.png -->

Jako programátoři ve vysokoúrovňovém jazyce zpravidla nemusíme řešit nízkoúrovňové formáty dat. Takové struktury řešíme na vysoké úrovni a na konci je serializujeme třeba do XML nebo JSON. Nebo, když už to jinak nejde, alespoň do CSV. Ale co když potřebujeme komunikovat s něčím, co má podstatně nižší úroveň, a potřebujeme do prostého pole bajtů uložit složitější datovou strukturu? Vytvořil jsem pomocnou třídu `BytePacker`, která vám s tím pomůže.

Tento článek jsem napsal na základě diskuse s jedním začínajícím C# programátorem, který poněkud plaval v operacích s poli bajtů. Myslím si, že může být užitečný i mnoha dalším.

Základní zadání je následující:

*   Máme předem neurčené množství bloků binárních dat (polí `byte[]`).
*   Neznáme délku jednotlivých bloků, víme jen že bude 1-255 bajtů.
*   Neznáme počet jednotlivých bloků, víme jen že jich bude 2-256.
*   Potřebujeme vytvořit datovou strukturu, která toto umožní rozumným způsobem uchovat a zpracovat.

## Ukládání dat s předem známou délkou

Pokud ukládáme data s předem známou délkou, je to jednoduché. Prostě je naskládáme za sebe a hotovo. Protože dopředu známe délku, dokážeme rozpoznat komu které bajty patří.  

Typickým příkladem bude např. situace, kdy budeme jako součást datové struktury uchovávat ID měřícího zařízení (dva bajty), vnitřní teplotu a vnější teplotu. Teplotu budeme uchovávat s přesností na půl stupně celsia. Pokud bychom data ukládali v XML, lze si představit například následující formát:

    <measure id="1234" internalTemp="15.5" externalTemp="-3.5" />

V současné době je módní používat spíše JSON, v něm by to mohlo vypadat následovně:

    {
      "id" : 1234,
      "internalTemp" : 15.5,
      "externalTemp" : -3.5
    }

Jak to ovšem uložit do co nejmenšího objemu dat, například budeme-li data chtít přenášet po LPWAN síti s omezeným objemem přenášených dat? Stačí nám k tomu prosté čtyři bajty. První a druhý bajt bude identifikátor měřící stanice. Třetí bajt bude vnitřní teplota a čtvrtý bajt vnější teplota. 

Jeden bajt může uchovávat hodnotu 0-255. Jak do toho zakódovat desetinnou a zápornou teplotu? Možností je několik. Zápornou hodnotu vyřešíme tím, že k teplotě ve stupních pro účely ukládání přičteme 127. Budeme tak schopni uchovávat teplotu od –127 °C (uloženo jako 0) po +128 °C (uloženo jako 255), což nám pro naši aplikaci postačí. Chceme-li uchovávat s přesností na půl stupně, stačí hodnotu před uložením ještě vynásobit dvěma. Tím se nám sice sníží rozsah na polovinu (od –63,5 °C do +64 °C), ale to je pořád dostačující. Vzorec pro převod teploty `t` na uloženou hodnotu s tedy bude `s = t * 2 + 127`. Opačný převod pak provedeme pomocí vzorečku `t = (s – 127) / 2`.

*   ID zařízení (1234) budeme uchovávat jako dva bajty big endian, tj. `0x04`, `0xD2`. 
*   Interní teplota bude uložena jako `15.5 * 2 + 127 = 158 = 0x9E.` 
*   Externí teplota jako `–3.5 * 2 + 127 = 120 = 0x78`. 

Výsledná datová struktura tedy bude `[0x04, 0xD2, 0x9E, 0x78]`, nebo stručněji zapsáno `0x04D29E78`. Obsahuje pouze holá data, žádné režijní údaje. Víme, že první dva bajty jsou ID zařízení, další je interní teplota a druhá externí teplota.

## Ukládání dat s předem neznámou délkou

Neznáme-li dopředu délku uložených dat, pak jsou k dispozici pouze dvě metody. Buďto si jejich délku někam poznamenáme (typicky na začátek datové struktury) nebo použijeme oddělovače – takovou sekvenci, která se v datech samotných nikdy nemůže vyskytnout. Pohleďte příkladně na tuto sekvenci:

`0x11002222003333330044444444`

Ta obsahuje sekvence `0x11`, `0x2222,` `0x333333` a `0x44444444` oddělené nulami. Funguje to docela dobře, ovšem pouze do chvíle, kdy vlastní data nemohou obsahovat nulový bajt, na což se zpravidla nemůžeme spolehnout. Použijeme tedy jiný formát, který si bude délku jednotlivých bloků ukládat. Pro jednoduchost (abychom nemuseli řešit endian) budeme počítat s délkou bloku 0-255 bajtů. Tatáž data budou zakódována následovně:

`0x**01**11**02**2222**03**33333344444444`

Tučně zvýrazněné bajty určují délku následujícího bloku. Poslední blok (čtyři bajty `0x44`) délku uvedenou mít nemusí – jsou to "všechna zbývající data".

Nevýhodou tohoto přístupu je, že nedokážeme přímo přečíst konkrétní blok – vždy musíme přečíst data od začátku, protože jinak se nedozvíme, kde který blok začíná. 

Pokud ale známe počet bloků, můžeme datový formát vylepšit: všechny délky bloků napíšeme na začátek. Výsledek bude vypadat následovně:

`0x**010203**11222233333344444444`

Poslední vylepšení bude spočívat v tom, že i počet bloků můžeme uložit na začátek a zbavíme se tedy posledního omezení, že počet bloků musí být dopředu znám.

Pohleďte na následující datovou strukturu:

`0x02**010203**11222233333344444444`

První bajt určuje počet specifikovaných délek bloků mínus jedna. Určuje tedy, kolik následujících bajtů (v tomto případě tři, zdůrazněné tučně) jsou délky. Následují data jednotlívých bloků, včetně posledního "zbytkového".

## Třída BytePacker

Napsal jsem v C# komfortní třídu `BytePacker`, která dokáže datové struktury podle uvedeného vzoru vytvářet a zase rozebírat pomocí statických metod `Pack` a `Unpack`. Kód jsem ještě vylepšil o podporu práce s prefixem s pevně danou délkou – v praxi často používáme hybridní datové struktury, které mají část pevnou a část ne.

*   Zdrojový kód třídy a ukázkové aplikace najdete jako [gist na GitHubu](https://gist.github.com/ridercz/b77c210cbb3bbe0b832b3a6d06a8ad86).
*   Mírně zjednodušenou verzi (s pevně danou šířkou konzole) k živým experimentům pak najdete na [DotNetFiddle](https://dotnetfiddle.net/BiqaeN).