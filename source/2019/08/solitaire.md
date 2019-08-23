<!-- dcterms:title = Šifrovací algoritmus Solitaire -->
<!-- dcterms:abstract = Solitaire, známý též jako Pontifex, je zvláštní šifrovací algoritmus, který vyhoví moderním požadavkům na bezpečnost, ale přitom jej můžete používat i ručně. Jediné co potřebujete je papír, tužka a balíček karet. Je jednoduchý a elegantní a může tak sloužit jako dobrá ukázka fungování symetrických proudových šifer. Proto jsem se rozhodl se svolením autora přeložit jeho popis do češtiny. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20190823-solitaire.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20190823-solitaire.jpg -->
<!-- x4w:coverCredits = Nadia Hatoum via Flickr, CC BY -->
<!-- x4w:category = Bezpečnost -->
<!-- dcterms:dateAccepted = 2019-08-23 -->

> Verze 1.2, 26. 5. 1999
>
> Autorem algoritmu a tohoto textu je _Bruce Schneier_, anglický originál [najdete na jeho webu](https://www.schneier.com/academic/solitaire/), přeloženo se souhlasem autora

V novele [Kryptonomikon](https://amzn.to/2KMqROF) od Neala Stephensona popisuje Enoch Root jiné postavě, Randy Waterhousovi, kryptosystém s kódovým označením _Pontifex_ a odhalí mu, jak lze tuto šifru realizovat pomocí balíčku hracích karet. Obě postavy si potom pomocí tohoto systému vymění několik zašifrovaných zpráv. Tento kryptosystém se ve skutečnosti jmenuje _Solitaire_ (v knize je použito kódové označení _Pontifex_, které má dočasně skrýt že používá balíček hracích karet) a navrhl jsem ho tak, aby umožnil agentům v terénu bezpečně komunikovat, aniž by byli závislí na elektronice nebo s sebou museli mít nějaké potenciálně inkriminující pomůcky. Agent se může dostat do situace, kdy nemá k dispozici počítač, nebo může být stíhán za to, že u sebe má nástroje pro utajovanou komunikaci. Ale balíček karet? Na tom není nic špatného.

Bezpečnost Solitaire je založena na náhodnosti zamíchaného balíčku karet. Manipulací s balíčkem může účastník komunikace vytvořit řetězec "náhodných" písmen, která pak zkombinuje se svou zprávou. Solitaire lze samozřejmě simulovat i na počítači, ale je navržen tak, aby se dal dělat i ručně.

Solitaire je sice low-tech, ale nabízí high-tech bezpečnost. Navrhl jsem Solitaire tak, aby byl bezpečný i proti těm nejlépe vybaveným vojenským útočníkům s nejvýkonnějšími počítači a nejchytřejšími kryptoanalytiky. Samozřejmě nelze garantovat, že někdo neobjeví nějaký chytrý útok na Solitaire (pokud se tak stane, [budu o tom informovat](https://www.schneier.com/academic/solitaire/)), ale rozhodně jde o nejbezpečnější algoritmus, který jsem dosud viděl a který lze realizovat tužkou na papíře.

Pravda, není příliš rychlý. Zašifrovat nebo dešifrovat rozumně dlouhou zprávu může zabrat celý večer. David Kahn ve své knize [Kahn on Codes](https://amzn.to/2HkLrUf) popisuje skutečnou ruční šifru používanou sovětským špiónem. Zašifrovat zprávu sovětským algoritmem i Solitairem zabere zhruba stejně času: většinu večera.

## Šifrujeme pomocí Solitaire

Solitaire je proudová šifra s výstupní zpětnou vazbou (output feedback mode stream cipher). Tento druh šifry se také někdy nazývá key-generator (generátor klíčů, KG v americké vojenské hantýrce). Základní idea je, že Solitaire vygeneruje řetězec čísel mezi 1 a 26. Tomu se říká _keystream_. Pro zašifrování zprávy je nutné vygenerovat tolik znaků keystreamu, kolik znaků má otevřený text (plaintext) zprávy. Ty potom modulo 26 přičtěte ke znakům plaintextu, jeden po druhém, čímž vytvoříte zašifrovanou zprávu (ciphertext). Pro dešifrování vytvořte ten samý keystream a odečtěte jej modulo 26 od ciphertextu, čímž získáte původní plaintext. (Pokud nevíte co je _modulo 26_, nebojte se, za minutku to vysvětlím.)

Například zkusíme zašifrovat první zprávu zmíněnou v Kryptonomikonu, "DO NOT USE PC" (nepoužívej počítač).

> **Poznámka překladatele:** Solitaire nepočítá s českou diakritikou, pracuje pouze s A-Z, 26 písmeny anglické abecedy.

1. Rozdělte plaintext do skupin po pěti znacích. (Na pětiznakových skupinách není nic magického, je to jenom tradice.) Pokud je poslední skupina kratší než pět znaků, doplňte ji písmeny `X`. Takže pokud je zpráva `DO NOT USE PC`, plaintext bude následující:

```plain
DONOT  USEPC
```

2. Pomocí Solitaire vygenerujte písmena keystreamu (postup bude popsán později). Předpokládejme, že keystream je následující:

```plain
KDWUP  ONOWT
```

3. Převeďte plaintext z písmen na číslice: `A=1`, `B=2` atd.:

```plain
4 15 14 15 20  21 19 5 16 3
```

4. Stejným způsobem převeďte písmena keystreamu:

```plain
11 4 23 21 16   15 14 15 23 20
```

5. Sečtěte čísla plaintextu s čísly keystreamu, modulo 26. To znamená, že pokud je výsledek větší než 26, odečtěte od výsledku 26. Například `1+1=2`, `26+1=27` a `27-26=1`, takže `26+1=1`. Výsledek v našem příkladu je následující:

```plain
15 19 11 10 10   10 7 20 13 23
```

6. Převeďte čísla zpět na písmena:

```plain
OSKJJ  JGTMW
```

Pokud jste opravdu dobří, můžete se naučit sčítat písmena z hlavy a rovnou sčítat písmena z kroku 1 a 2. Stačí to dostatečně trénovat. Je jednoduché si zapamatovat, že `A+A=B`; zapamatovat si, že `T+Q=K` už je těžší.

## Dešifrujeme pomocí Solitaire

Základní idea je, že příjemce zprávy vygeneruje stejný keystream a odečte jeho písmena od písmen ciphertextu.

1. Vezměte zašifrovanou zprávu a rozdělte ji do skupin po pěti znacích (patrně už v té podobě bude):

```plain
OSKJJ  JGTMW
```

2. Pomocí Solitaire vygenerujte stejný počet písmen keystreamu. Pokud příjemce použije stejný klíč jako odesílatel, keystream budou ta samá písmena:

```plain
KDWUP  ONOWT
```

3. Převeďte zašifrovanou zprávu z písmen na číslice:

```plain
15 19 11 10 10   10 7 20 13 23
```

4. Stejným způsobem převeďte písmena keystreamu:

```plain
11 4 23 21 16   15 14 15 23 20
```

5. Odečtěte čísla keystreamu od čísel ciphertextu, modulo 26. Např. `22-1=21` a `1-22=5`. Je to jednoduché: Pokud je první číslo stejné nebo menší než druhé, přidejte k prvnímu číslu 26 předtím, než provedete odčítání. Takže z `1-22=?` bude `27-22=5`.

```plain
04 15 14 15 20  21 19 05 16 03
```

6. Převeďte číslice zpět na písmena:

```plain
DONOT USEPC
```

Jak vidíte, dešifrování je stejné jako šifrování, jenom keystream odečítáte místo přičítání.

## Generujeme písmena keystreamu

Tohle je srdce Solitaire. Výše popsaný způsob šifrování a dešifrování funguje pro jakoukoliv proudovou šifru v režimu výstupní zpětné vazby. Je to způsob, jakým funguje RC4. Je to způsob, jakým funguje OFB režim algoritmu DES. Ovšem tato sekce je specifická pro Solitaire, popisuje jak Solitaire generuje ten výše zmíněný keystream.

Solitaire pro generování keystreamu používá balíček pokerových (žolíkových, bridžových, francouzských...) karet. Balíček 54 karet (včetně žolíků) můžete brát jako permutaci 54 prvků. Existuje tedy `54!`, tj. přibližně `2,3 × 10^71`, možných různých uspořádání karet v balíčku. A ještě lépe, v balíčku je 52 karet (bez žolíků) a anglická abeceda má 26 písmen. Taková souhra náhod je prostě příliš dobrá na to, abych jí nevyužil.

Abychom mohli balíček použít pro Solitaire, potřebujeme kompletní balíček 52 karet se dvěma žolíky a karty žolíků se musejí nějakým způsobem odlišovat. (To je běžné. Balíček, na který se dívám při psaní tohoto textu, má na žolíkových kartách hvězdu: jeden malou a jeden velkou.) Jednoho žolíka nazvěte "A" a druhého "B". Obecně, na kartách bývá stejný grafický prvek, ale v různé velikosti. Řekněme, že žolík "B" je ten, kde je prvek větší (anglicky _bigger_). Pokud je to pro vás jednodušší, můžete na žolíky napsat "A" a "B", ale pamatujte, že to pak budete muset vysvětlovat tajné policii, pokud vás někdy chytí.

> **Poznámka překladatele:** Prohlédl jsem si čtyři balíčky karet, které mám doma a podle mého názoru to není tak jednoduché. S velkým/malým grafickým symbolem jsem se nesetkal. 
> 
> Běžné hrací karty _Bicycle_ od American Playing Card Company mají jednoho žolíka v barevném a jednoho v černobílém provedení, stejně jako velké karty koupené v prodejně Tiger. Historické karty _Series 1800_ od téže společnosti APCC mají oba žolíky stejné. U další sady karet čínské provenience se žolíky liší jenom tím, že na jednom je nápis _Made in China_. Potřebujete tedy správný balíček, nebo si žolíky nějak označit - s rizikem, že označení budete muset vysvětlovat tajné policii.

Začněte tím, že vezmete balíček do ruky, přední stranou nahoru. Poté seřaďte karty do výchozí konfigurace, která je klíčem. (O klíči bude řeč později, ale je to něco jiného než keystream.) Nyní jste připraveni k tomu, abyste vygenerovali první znak keystreamu.

Zde je postup, jak vygenerovat jeden znak keystreamu. To je vlastní algoritmus Solitaire.

1. Najděte žolíka "A". Posuňte jej o jednu kartu dolů (tj. vyměňte jeho pozici s kartou hned pod ním.) Pokud je žolík na spodku balíčku, přemístěte ho pod první kartu balíčku.

2. Najděte žolíka "B". Posuňte jej o dvě karty dolů. Pokud je žolík na spodku balíčku, dejte ho pod druhou kartu shora. Pokud je žolík předposlední karta, dejte ho pod první kartu shora. (V zásadě předpokládejte, že balíček je nekonečná smyčka.)

Je důležité tyto kroky udělat ve správném pořadí. Svádí to k lenosti a nabízí se prostě žolíky posunout, jakmile na ně narazíte. To je OK, ale jenom pokud nejsou blízko u sebe.

Takže, pokud balíček karet vypadá před krokem 1 takto:

```plain
A 7 2 B 9 4 1
```

na konci kroku 2 bude vypadat takto:

```plain
7 A 2 9 4 B 1
```

Ještě jeden příklad. Pokud balíček na začátku vypadá takto:

```plain
3 A B 8 9 6
```

bude po dokončení kroku 2 vypadat takto:

```plain
3 A 8 B 9 6
```

Pokud máte nějaké pochybnosti, pamatujte si, že vždycky musíte nejprve pohnout žolíkem "A" a teprve potom "B". A buďte opatrní, pokud jsou žolící na spodku balíčku. Pokud je žolík poslední karta, uvažujte o něm jako o první kartě balíčku, než začnete počítat.

3. Proveďte trojité sejmutí (triple cut). To znamená, prohoďte karty nad prvním žolíkem a karty pod druhým žolíkem. 

Pokud balíček vypadal takto:

```plain
2 4 6 B 5 8 7 1 A 3 9
```

bude po operaci trojitého sejmutí vypadat takto:

```plain
3 9 B 5 8 7 1 A 2 4 6
```

"První" a "druhý" žolík v tomto případě znamená kartu, která je blíže (dále) vrcholu balíčku. Pro účely tohoto kroku můžete ignorovat označení "A" a "B".

Pamatujte, že žolíci sami a karty mezi nimi se nepohybují, pohybují se jenom karty okolo nich. To je velice snadné zařídit, pokud karty držíte v ruce.

Pokud v některé ze tří sekcí nejsou žádné karty (žolíci jsou u sebe nebo na začátku nebo konci balíčku), chápejte sekci jako prázdnou a stejně s ní pohněte.

Například pokud balíček vypadal takto:

```plain
B 5 8 7 1 A 3 9
```

bude po trojitém sejmutí vypadat takto:

```plain
3 9 B 5 8 7 1 A
```

Balíček, který vypadá takto:

```plain
B 5 8 7 1 A
```

zůstane tímto krokem nezměněn.

4. Proveďte počítané sejmutí (count cut). Podívejte se na kartu vespod balíčku a převeďte ji na číslo od 1 do 53. Použijte při počítání bridžové pořadí barev: kříže/trefy (clubs), kára (diamonds), srdce (hearts) a piky/listy (spades). Pokud je karta křížová, má hodnotu která je na ní napsaná, 1-13. Pokud je kárová, přičtěte k hodnotě 13. Pokud srdcová, přičtěte 26 a pokud piková, přičtěte 39. Žolík (jedno který) má hodnotu 53. Odpočítejte odshora tolik karet, kolik říká karta vespod. Sejměte tak, aby poslední karta zůstala na spodku balíčku.

Pokud balíček vypadal takto:

```plain
7 ... karty ... 4 5 ... karty ... 8 9
```

a devátá karta je `4`, bude balíček po sejmutí vypadat takto:

```plain
5 ... karty ... 8 7	... karty ... 4 9
```

Poslední kartu necháváme na místě, aby byl proces reversibilní. To je důležité pro matematickou analýzu bezpečnosti algoritmu.

Balíček, který má na spodku žolíka, bude tímto krokem nezměněn.

Dejte si pozor, abyste při počítání nezměnili pořadí karet. Správný způsob je předávat si karty po jedné z ruky do ruky, nedělejte si hromádky na stole.

5. Najděte kartu s výsledkem. To uděláte tak, že se podíváte na první kartu a převedete ji na číslo postupem popsaným v předchozím kroku. Odpočítejte tolik karet, kolik říká karta na vrcholu balíčku. (Vrchní karta má číslo 1.) Zapište si číslo následující karty na papír, neodstraňujte ji z balíčku. (Pokud je touto kartou žolík, nezapisujte si nic, pokračujte znovu krokem 1.) Toto je vaše první výsledková karta. Povšimněte si, že tento krok nemění stav balíčku, jenom se díváte na hodnotu karty.

6. Převeďte hodnotu výstupní karty na číslo, resp. písmeno. Stejně jako v předchozím kroku, použijte bridžové počítání barev. Takže křížová/trefová A-K jsou 1-13 (tj. písmena A-M), kárová A-K jsou 14-26 (N-Z), srdcová A-K jsou zase 1-13 (A-M) a piková/listová A-K jsou 14-26 (N-Z). (Počítáme od jedné do 26, ne do 52, protože potřebujeme číslice převést na písmena.)

Tímto způsobem pomocí Solitaire zašifrujete jedno písmeno. Tento postup můžete použít k vygenerování tolika písmen keystreamu, kolik jich potřebujete; prostě opakujte kroky 1-6 pro každý znak zprávy.

Vím, že balíčky karet vypadají v různých zemích různě. Obecně nezáleží na tom, jaké pořadí barev použijete nebo jak budete převádět karty na čísla. Důležité ale je, aby se odesílatel i příjemce shodli na pravidlech a dělali to stejně, jinak nebudou schopni spolu komunikovat.

## Vytváříme klíč

Než začnete generovat písmena keystreamu, musíte balíček "naklíčovat", seřadit karty v určitém pořadí. To je nejspíš ta nejdůležitější část celé operace a závisí na ní bezpečnost celého algoritmu. Solitaire je jenom tak bezpečný, jak bezpečný je použitý klíč. Nejjednodušší způsob, jak prolomit šifru, je přijít na to, jaký klíč uživatelé používají. Pokud nemáte dobrý klíč, na zbytku nezáleží. Tady je pár nápadů, jak vytvořit dobrý klíč:

1. Použijte identicky namíchané karty. Náhodný klíč je nejlepší. Jeden z účastníků komunikace může náhodně zamíchat balíček karet a poté vytvořit jiný, se stejným pořadím karet. Jeden si vezme odesílatel, druhý dostane příjemce. Většina lidí neumí správně míchat karty, takže zamíchejte balíček alespoň šestkrát. A obě strany komunikace by měly mít záložní, identicky namíchaný balíček. Jinak, pokud uděláte chybu, nebudete nikdy schopni dešifrovat zprávu. Také pamatujte, že dokud klíč existuje, je v ohrožení: tajná policie může najít balíček a poznamenat si pořadí karet v něm.

2. Použijte bridžové pořadí. Popis sady bridžových rozdání, který můžete najít v novinách nebo knize o bridži, je přibližně 95-bitový klíč. Dohodněte si způsob, jakým převést bridžový diagram na pořadí karet v balíčku. Také se dohodněte, jak určit polohu žolíků. Nabízí se dát žolíka "A" za první kartu zmíněnou v textu a žolíka "B" za druhou.

Uvědomte si ale, že tajná policie může zjistit, jaký bridžový sloupek používáte a zaznamenat si hodnoty. Můžete zkusit vytvořit nějaký opakovatelný způsob, jaký sloupek použít. Například "použij bridžový sloupek z novin města, kde se právě nacházíš v den, kdy jsi šifroval zprávu". Nebo použijte seznam klíčových slov, zadejte je do vyhledávání na webu New York Times a použijte bridžový sloupek ze dne, ze kterého je první článek, který je nalezen. Pokud nepřítel odposlechne tato klíčová slova, budou vypadat jako passphrase. Vytvořte si svou vlastní konvenci pro převod bridžových sloupků na pořadí karet v balíčku; pamatujte, že i tajná policie čte knihy Neala Stephensona.

> **Poznámka překladatele:** V ČR bridžové články nevycházejí, ale hrají se téměř každý den nějaké turnaje, kde se generuje vždy sada rozdání. Tento bridžový diagram se pak dá použít jako klíč, protože v každé náhodně generované sadě jsou jiná rozdání. 
>
> Můžete se podívat třeba na [stránky Evy Fořtové](http://eva.fort.cz/) kde najdete výsledky turnajů nebo na [bridžové kanály](https://www.youtube.com/channel/UCOaZnFbFH1OlbhVm25z4rLQ/videos) na YouTube. Dobrým rozcestníkem je web [Českého bridžového svazu](http://www.czechbridge.cz/).

3. Pro vytvoření pořadí karet použijte passphrasi. Tato metoda používá algoritmus Solitaire k tomu, abyste vytvořili prvotní pořadí karet v balíčku. Odesílatel a příjemce se shodnou na jedné frázi, například "SECRET KEY". Začnete s balíčkem v pevném pořadí, například seřaďte karty podle bridžového počítání, následované žolíkem "A" a žolíkem "B". Poté proveďte výše popsanou operaci generování keystreamu. Ale místo kroku 5 udělejte další count cut, založený na prvním znaku passphrase (v našem příkladu S, tedy 19). Jinými slovy, zopakujte krok 4, ale použijte číslo odvozené z passphrase (19) místo hodnoty poslední karty. Pamatujte, že máte sejmuté karty umístit nad poslední kartu v balíčku, jak bylo popsáno dříve.

Opakujte těchto pět kroků pro každý znak passphrase. Tj. ve druhé sadě kroků použijte druhý znak, ve třetí sadě třetí znak atd.

Volitelný krok (který _není_ použit v příkladech níže): Použijte poslední dva znaky passphrase k určení pozice žolíků v balíčku. Pokud je předposlední znak G (tj. 7), umístěte žolíka "A" za sedmou kartu. Pokud je poslední znak T (číslo 20), umístěte žolíka "B" za dvacátou kartu.

Uvědomte si ale, že ve standardní angličtině je jenom přibližně 1,4 bitu entropie na znak. Chcete passphrasi, která má alespoň 64 znaků, aby byl tento postup bezpečný. Pro jistotu doporučuji 80 znaků. Sorry, s krátkým klíčem prostě nelze dosáhnout velké bezpečnosti.

## Ukázkový výstup

Zde jsou nějaká ukázková data, na kterých si můžete Solitaire natrénovat.

### Příklad 1

Začněte s nenaklíčovaným balíčkem v nominálním pořadí, tj. kříže A-K, kára A-K, srdce A-K a piky A-K, žolík A, žolík B. (Můžete si to představit jako `1...52, A, B`.)

Následující postup ukazuje, jak vytvořit první dvě výstupní hodnoty. Výchozí řazení balíčku je:

```plain
1 2 3 4 ... 52 A B
```

Po prvním kroku (posunutí žolíka "A"):

```plain
1 2 3 4 ... 52 B A
```

Po druhém kroku (posunutí žolíka "B"):

```plain
1 B 2 3 4 ... 52 A
```

Po třetím kroku (trojité sejmutí):

```plain
B 2 3 4 ... 52 A 1
```

Po čtvrtém kroku (počítané sejmutí):

```plain
2 3 4 ... 52 A B 1
```

Poslední karta je 1, což znamená sejmout jednu kartu. Pamatujte, že 1 zůstane kde je (na konci), takže se jedna karta - B - přesune na předposlední pozici.

Pátý krok nijak nemění karty v balíčku, jenom vygeneruje výstupní hodnotu. Karta na vrcholu balíčku je 2, takže odpočítejte dvě karty a následující je 4. To je vaše výsledková karta. (Nechte ji tam, kde je, jenom si poznamenejte její hodnotu.)

Pro vygenerování dalšího znaku keystreamu opakujte těchto pět kroků:

Krok 1:

```plain
2 3 4 ... 49 50 51 52 B A 1
```

Krok 2:

```plain
2 3 4 ... 49 50 51 52 A 1 B
```

Krok 3:

```plain
A 1 B 2 3 4 ... 49 50 51 52
```

Krok 4:

```plain
51 A 1 B 2 3 4 ... 49 50 52
```

Poslední karta je 52, takže odpočítejte 52 karet, až ke kartě s hodnotou 51. Sejměte tuto jedinou kartu 51, na vrchol balíčku. Pamatujte, že karta 52 se nehýbe.

Krok 5 určí výslednou kartu. První karta je 51, takže odpočítání 51 karet nás přivede ke kartě číslo 49, což je druhá výstupní karta. (Opět, neodstraňujte ji z balíčku, jenom si ji poznamenejte).

Prvních 10 výstupních hodnot tedy je:

```plain
4 49 10 (53) 24 8 51 44 6 4 33
```

Hodnotu 53 samozřejmě přeskočíme, nechal jsem ji tam jenom pro kontrolu a pro názornost.

Pokud je plaintext

```plain
AAAAA  AAAAA
```

bude výsledný ciphertext

```plain
EXKYI  ZSGEH
```

### Příklad 2

Při použití třetí metody generování klíče (passphrase) s frází "FOO" (pamatujte, že zde není použit volitelný krok pro umístění žolíků) je prvních patnáct výstupních hodnot:

```plain
8 19 7 25 20 (53) 9 8 22 
32 43 5 26 17 (53) 38 48
```

Pokud jsou plaintext samá `A`, bude ciphertext následující:

```plain
ITHZU  JIWGR  FARMW
```

### Příklad 3

Při použití třetí metody generování klíčů s passphrasí "CRYPTONOMICON" bude zpráva "SOLITAIRE" zašifrována jako:

```plain
KIRAK SFJAN
```

Pamatujte, že pro doplnění poslední skupiny znaků do pěti je použito písmeno `X`.

Samozřejmě že byste měli použít delší klíč. Tyto příklady jsou pouze pro testovací účely. Na webu najdete další příklady ([testovací vektory](https://www.schneier.com/code/sol-test.txt)) a další si můžete vygenerovat pomocí přiloženého programu.

## Skutečná bezpečnost, ne "security trough obscurity"

Algoritmus Solitaire byl navržen tak, že funguje, i když nepřítel ví, jak funguje. Předpokládal jsem, že [Kryptonomikon](https://amzn.to/2KMqROF) bude bestseller a že jeho kopie budou snadno dostupné. Předpokládám, že NSA a všichni ostatní budou tento algoritmus studovat a budou s ním počítat. Předpokládám, že jediné tajemství je v klíči.

To je důvod, proč je tak důležité uchovávat klíč v tajnosti. Pokud budete mít někde bezpečně schovaný balíček karet, měli byste předpokládat, že nepřítele napadne, že používáte Solitaire. Pokud budete mít v bankovní bezpečnostní schránce knihu o bridži, patrně to způsobí jistý podiv. Pokud bude o nějaké skupině známo, že používá Solitaire, dá se očekávat, že tajná policie bude udržovat databázi bridžových sloupků a bude ji používat při pokusech o prolomení šifry. Solitaire je bezpečný i v případě, že nepřítel ví, že ho používáte a prostý balíček hracích karet je pořád méně podezřelý než specializovaný šifrovací program běžící na vašem laptopu. Ale algoritmus není náhradou dostatečné obezřetnosti.

## Poznámky pro použití

1. První pravidlo pro jakoukoliv proudovou šifru s výstupní zpětnou vazbou je, že nikdy nesmíte použít stejný klíč pro zašifrování dvou různých zpráv. Opakujte po mně: **nikdy nesmíte použít stejný klíč pro zašifrování dvou různých zpráv**. Pokud to uděláte, kompletně tím kompromitujete celý systém. Proč? Pokud máte dvě zprávy zašifrované tímtéž klíčem, `A+K` a `B+K` a odečtete jednu od druhé, dostanete `(A+K)-(B+K) = A+K-B-K = A-B`. Tedy dva plaintexty zkombinované do sebe, bez použití klíče, a to je velice snadno prolomitelné. V tomhle ohledu mi věřte: vy možná nedokážete z `A-B` odhalit `A` a `B`, ale profesionální kryptoanalytik ano. To je životně důležité: nikdy nesmíte použít stejný klíč pro zašifrování dvou různých zpráv.

2. Snažte se, aby byly vaše zprávy krátké. Tento algoritmus je navržen pro krátké zprávy, maximálně pár tisíc znaků dlouhé. Použijte zkratky a slangové výrazy, nebuďte ukecaní. Pokud chcete zašifrovat novelu o 100 000 slovech, použijte počítačový algoritmus.

3. Jako všechny proudové šifry s výstupní zpětnou vazbou má i tento systém tu nešťastnou vlastnost, že nedokáže opravit chyby. Pokud šifrujete zprávu a uděláte v jednom kroku, zbytek zprávy bude zašifrován chybně a nebude možné ho dešifrovat, i s použitím správného klíče. A nikdy se to nedozvíte. Takže pokud šifrujete zprávu, musíte tentýž proces zopakovat dvakrát a porovnat výsledky. Pokud zprávu dešifrujete, průběžně kontrolujte, že dešifrovaný text dává smysl. A pokud jako klíč používáte náhodně zamíchaný balíček, mějte z tohoto důvodu jeden identický záložní.

4. Solitaire je symetrický reverzibilní algoritmus. To znamená, že pokud necháte zamíchaný balíček někde ležet poté, co jste dokončili práci, tajná policie ho může najít a s jeho pomocí dešifrovat zprávu. Je tedy nutné po dokončení práce balíček důkladně zamíchat, šestkrát.

5. Abyste dosáhli maximální bezpečnosti, snažte se všechno dělat z hlavy. Pokud tajná policie začne vyrážet dveře, klidně míchejte balíček. (Nevyhoďte ho jen tak do vzduchu; byli byste překvapeni, jak značná část pořadí zůstane zachována, pokud někdo udělá [52-Pickup](https://en.wikipedia.org/wiki/52_pickup).) Nezapomeňte zamíchat záložní balíček, pokud ho máte.

6. Pokud si musíte dělat poznámky, nakládejte s nimi opatrně. Budou obsahovat citlivé údaje.

Pravděpodobně nejbezpečnější způsob jak s nimi naložit, je spálit je, ale myslete na papír. Nejvhodnější pro tento účel je nepogumovaný rýžový cigaretový papír. Kolega dělal jisté pokusy s papírky značky _Club Cabaret Width_ a kompletně shoří.

Psát na cigaretové papírky není tak obtížné, jak by se mohlo zdát. Docela dobře lze použít obyčejnou tužku číslo 2 s jemným ale ne ostrým hrotem. Tužka číslo 3 funguje lépe, ale je poněkud neobvyklé ji nosit s sebou. Propisky nebo fixy s sebou nesou řadu problémů. Za prvé, tvrdá špička zanechává stopy na podložce pod papírem. A cokoliv s inkoustem může prosáknout papírem.

Každé dobré cigaretové papírky jsou navržené tak, aby shořely úplně a čistě. Papírky značky Club shořely nejlépe volně ve vzduchu, puštěné zhruba z výšky hrudníku. Mají také tu výhodu, že mají velmi malý objem a v případě nutnosti je můžete snadno sníst, pokud to bude potřeba.

Jsou také extrémně tenké. Papírky o ploše tří krychlových palců _(pozn. překladatele: asi jako platební karta)_ mohou být šestkrát přeloženy do čtverečku o straně 1 cm, který je asi milimetr silný. Na jeden papír se pohodlně vejde 80 znaků v osmi řádcích, každý řádek o dvou pětiznakových blocích. Je pravděpodobné, že rozumně pečlivý písař dokáže na takový papírek zapsat až 120 znaků.

> **Poznámka překladatele:** U nás běžně dostupné cigaretové papírky značky Vážka jsou menší, mají cca. 68x35 mm, ale bez problémů se mi na ně podařilo zapsat 14 řádků po deseti znacích (dvě skupiny po pěti). Hoří dobře a beze zbytku, pro případ pojídání doporučuji si připravit sklenici s vodou na zapití.

7. Solitaire může fungovat i na počítači. Často bude situace taková, že jedna strana může bezpečně používat počítač a jenom protistrana si bude muset vystačit s balíčkem karet. Pokud můžete, použijte počítač. Je to rychlejší a počítač nedělá chyby.

8. Většina karetních her nepoužívá žolíky, takže může být podezřelé u sebe mít balíček karet s nimi. Připravte si dopředu nějaké rozumné zdůvodnění.

> **Poznámka překladatele:** V českých zemích je - zejména mezi starší generací - populární hra [Kanasta](https://cs.wikipedia.org/wiki/Kanasta) nebo klasické [Žolíky](https://cs.wikipedia.org/wiki/%C5%BDol%C3%ADky). Obě hry se hrají se dvěma kompletními sadami francouzských karet včetně čtyř žolíků.

9. Bezpečnost Solitaire nezávisí na utajení metody. Předpokládám, že tajná policie ví, že ho používáte.

## Bezpečnostní analýza 

* [Properties of the Transformation Semigroup of the Solitaire Stream Cipher](http://eprint.iacr.org/2003/169) (B. Pogorelov and M. Pudovkina)
* [Problems with Bruce Schneier's "Solitaire"](http://www.ciphergoth.org/crypto/solitaire/) (Paul Crowley)
* [Probabilistic Cycle Detection for Schneier's Solitaire Keystream Algorithm](http://ieeexplore.ieee.org/xpls/abs_all.jsp?arnumber=6901648) (W. Tounsi, B. Justus, N.C. Boulahia, F. Cuppen, and J.G. Alfaro)

## Další zdroje informací

Pro začátek doporučuji svou vlastní knihu [Applied Cryptography](https://amzn.to/2Zh1e1z) (John Wiley & Sons, 1996). Poté si přečtěte [The Codebreakers](https://amzn.to/2ZaN9CK) od Davida Kahna (Scribner, 1996). Potom existuje spousta knih o počítačové kryptografii a pár o té ruční. Je to zábavný obor, hodně štěstí.

> **Poznámka překladatele:** Nejsem si vědom toho, že by byla některá z knih zmíněných v textu přeložena do češtiny. V češtině existuje kniha _Aplikovaná kryptografie_ od Karla Burdy, kterou ovšem upřímně nedoporučuji, přišla mi dost hrozná a nesrozmitelně napsaná.
>
> **Full disclosure:** Odkazy na Amazon, které jsou zde v textu, obsahují můj affiliate kód. Pokud si přes ně něco koupíte, dostanu provizi.

## Downloads

Na [původní stránce v angličtině](https://www.schneier.com/academic/solitaire/) je seznam implementací tohoto algoritmu v řadě programovacích jazyků. Odkazy sem nebudu kopírovat, protože v originále bude seznam pravděpodobně aktuálnější.

---

Děkuji _Adamovi Kubicovi_, _Fro Virglerovi_ a _Milanu Macurovi_ z ČBS za pomoc s českou bridžovou terminologií.