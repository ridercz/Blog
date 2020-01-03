<!-- dcterms:title = Automatické zapnutí a vypnutí digital signage na RPi -->
<!-- dcterms:abstract = K minulému článku o digital signage jsem dostal řadu dotazů, jestli to jako má běžet nonstop a jestli se monitor nezničí a případně jak to automaticky vypnout a zapnout. Současné LCD monitory by měly vydržet nepřetržitý provoz (alespoň ty co mám doma proti němu nijak neprotestují) a zapnout a vypnout to samozřejmě jde. -->
<!-- x4w:category = Bastlení -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:dateAccepted = 2020-01-03 -->
<!-- x4w:coverUrl = /cover-pictures/20200103-screenly-shutdown.jpg -->
<!-- x4w:coverCredits = Aleksandar Cvetanovic (@lemonzandtea) via Unsplash.com -->
<!-- x4w:pictureUrl = /perex-pictures/20200103-screenly-shutdown.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->

K [minulému článku o digital signage](/2019/12/digital-signage) jsem dostal řadu dotazů, jestli to jako má běžet nonstop a jestli se monitor nezničí a případně jak to automaticky vypnout a zapnout. Současné LCD monitory by měly vydržet nepřetržitý provoz (alespoň ty co mám doma proti němu nijak neprotestují) a zapnout a vypnout to samozřejmě jde.

Většina standardních počítačů má funkci automatického zapnutí a vypnutí přímo v nastavení BIOSu/UEFI. Mají totiž nezávislé hodiny reálného času [zálohované baterií](https://www.makeuseof.com/tag/why-does-my-motherboard-have-a-battery/). Raspberry Pi nic takového nemá. Čas si synchronizuje pomocí NTP z Internetu a jinak neví kolik je hodin. Neumí se tedy "probudit".

## Jak signage vypnout

K vypnutí digital Raspberry Pi lze použít `cron`, což je plánovač úloh na Linuxu. Jenomže jak se k němu dostat?

Pokud jste Screenly OSE nainstalovali postupem podle [předchozího článku](/2019/12/digital-signage) z image, nemáte jak se dostat na shell po síti. Jde to udělat jenom z konzole. 

Doporučuji začít tím, že z webového rozhraní deaktivujete všechny assety typu video. Pokud tak neuděláte, bude se vám přes příkazový řádek neustále spouštět video, což je otravné.

Připojte k RasPi klávesnici a stiskněte klávesovou zkratku _Ctrl+Alt+F1_, čímž se připojíte na konzoli `tty1`. (zpět se přepnete pomocí _Ctrl+Alt+F2_.) Přihlašte se jako uživatel `pi` s heslem `raspberry`.

Po přihlášení zadejte následující příkaz

    sudo crontab -e

Pokud se vás systém zeptá, jaký editor chcete použít, zvolte výchozí volbu 2 (editor `nano`).

Na konec souboru zadejte následující řádek:

    00 20 * * * /sbin/shutdown now

Sestává z několika komponent oddělených mezerou. Jejich význam je následující:

* `m` - minuta
* `h` - hodina
* `dom` - den v měsíci
* `mon` - měsíc
* `dow` - den v týdnu
* `command` - příkaz, který se má spustit

V našem případě tedy spouštíme každý den (`*` znamená "vždy") ve 20:00 příkaz `/sbin/shutdown now`, který vypne počítač.

Pokud budete chtít nastavit různá pravidla pro různé dny v týdnu pak vězte, že se označují čísly od `0` do `6`, přičemž `0` je neděle. Následující dva řádky vypnou systém v po-pá ve 20:00 a o víkendu už ve 12:00:

    00 20 * * 1-5 /sbin/shutdown now
    00 12 * * 0,6 /sbin/shutdown now

Poté ukončete editor stiskem klávesové zkratky _Ctrl+X_. Na otázku, zda chcete soubor uložit, odpovězte _y_ a název souboru ponechte beze změny (stiskněte _Enter_).

## Nastavení časové zóny

Ve výchozím nastavení je Raspberry v londýnské časové zóně. Pokud chcete časovou zónu změnit, můžete tak učinit pomocí utility **Raspi Config**. Spustíte ji příkazem `sudo raspi-config`. Poté zvolte volby _Localisation Options_ &raquo; _Change Timezone_ &raquo; _Europe_ &raquo; _Prague_. Pak klávesou _Tab_ doskákejte na Finish a program ukončete.

## Jak signage zapnout

Jak již bylo řečeno, Raspberry Pi nemá žádnou možnost se samo zapnout. Nejjednodušší tedy je použít klasické elektronické nebo mechanické spínací hodiny, které stojí pár korun (například [Lidl Shop](https://www.lidl-shop.cz/SILVERCREST-Digitalni-mechanicke-spinaci-hodiny/p100264657) je prodává za 169 Kč). Nastavte je tak, aby se vypnuly chvíli poté, co se RasPi vypne a zapnuly v požadovaný čas.

Proč se obtěžovat se softwarovým vypínáním a nepoužít jenom hodiny? Vypnutí "natvrdo" nedělá počítačům dobře, je lepší je nechat, ať se vypnou korektně.