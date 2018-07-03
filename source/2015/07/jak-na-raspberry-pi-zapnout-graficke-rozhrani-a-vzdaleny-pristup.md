<!-- dcterms:identifier = aspnetcz#5433 -->
<!-- dcterms:title = Jak na Raspberry Pi zapnout grafické rozhraní a vzdálený přístup? -->
<!-- dcterms:abstract = Chcete si s Raspberry Pi pohrát víc, než jak vám nabízím v seriálu o projektu Atropa? Můžete povolit grafické rozhraní a zapnout vzdálený přístup přes RDP. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Tipy, triky -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2015-07-13T21:21:28.983+02:00 -->
<!-- dcterms:dateAccepted = 2015-07-23T19:53:00+02:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20150723-jak-na-raspberry-pi-zapnout-graficke-rozhrani-a-vzdaleny-pristup.png -->

Chcete si s Raspberry Pi pohrát víc, než jak vám nabízím v seriálu o projektu Atropa? Můžete povolit grafické rozhraní a zapnout vzdálený přístup přes RDP.

## Jak zapnout grafické prostředí?

Z konzole můžete nastartovat grafické rozhraní příkazem `startx`. Ale co když chcete, aby vám Raspberry do grafického prostředí rovnou bootovalo? 

V takovém případě zadejte příkaz `sudo raspi-config`. Spustí se vám textové rozhraní, pomocí kterého můžete nastavit řadu paramerů. Mimo jiné tam najdete i volbu *Enable boot to Desktop/Scratch*:

[![Utilita raspi-config: hlavní menu](http://www.aspnet.cz/Files/20150713-raspi_config_1_thumb.png "Utilita raspi-config: hlavní menu")](http://www.aspnet.cz/Files/20150713-raspi_config_1_2.png)

Po klepnutí na něj si můžete vybrat, zda se má bootovat do textové konzole, grafického prostředí nebo do programovacího jazyka Scratch (což je takový trochu lepší Karel nebo Logo, programovací jazyk pro děti):

[![Utilita raspi-config: nastavení režimu bootu](http://www.aspnet.cz/Files/20150713-raspi_config_2_thumb.png "Utilita raspi-config: nastavení režimu bootu")](http://www.aspnet.cz/Files/20150713-raspi_config_2_2.png)

Po výběru požadovaného typu bootu zvolte *<Ok>* a *<Select>* a restartuje Rapberry.

## Jak zapnout vzdálený přístup?

Pokud nechcete na Raspberry pracovat lokálně, ale vzdáleně, hodí se na něm zapnout RDP, na které se pak budete moci připojit z Windows.

Za tímto účelem musíte nainstalovat balíček *xrdp*, což učiníte z terminálu následujícím příkazem: `sudo apt-get install xrdp`.

Při snaze rozchodit správně xrdp jsem měl problém s českou klávesnicí. Ačkoliv mi správně fungovala na lokále v textovém i grafickém režimu, přes RDP jsem měl pořád anglické rozložení a nedokázal jsem psát háčky a čárky. Po jistých problémech jsem přišel na řešení.

Připojte se lokálně na konzoli do grafického rozhraní a spusťte terminál (ve kterém vám funguje klávesnice, jakou chcete). Poté spusťte následující příkazy:

sudo xrdp-genkeymap /etc/xrdp/km-0405.ini sudo cp /etc/xrdp/km-0409.ini /etc/xrdp/km-0409.ini.bak sudo xrdp-genkeymap /etc/xrdp/km-0409.ini

První příkaz vezme stávající mapování klávesnice a uloží ho do souboru `km-0405.ini`. Číslo 0405 je kód pro češtinu (seznam kódů najdete [na webu xrdp](http://xrdp.sourceforge.net/documents/keymap/rfc1766.html)). To by samo o sobě mělo stačit, nicméně mně to nepomohlo. Možná proto, že mám anglická Windows a RDP klient reportuje jako jazyk angličtinu. Proto jsem se rozhodl, že českým přepíšu anglické mapování klávesnice, které je v souboru `km-0409.ini`. Původní nastavení jsem si pro jistotu uložil do `km-0409.ini.bak` (to dělá druhý příkaz) a pak přegeneroval původní soubor (třetí příkaz). Poté mi xrdp začalo fungovat česky.

## Jak se připojit z Windows?

Pokud se pokusíte připojit s výchozími nastaveními, nebude vám to fungovat, protože xrdp podporuje pouze osmi nebo šestnáctibitovou barevnou hloubku, zatímco výchozí nastavení terminálového klienta je 32 bitů. 

Příkazem `mstsc` spusťte na Windows terminálového klienta a klepněte ve spodní části okna na šipku vedle *Show Options*. Přepněte se na záložku *Display* a nastavte jako barevnou hloubku *High Color (16 bit)*. Můžete také nastavit rozlišení, jaké chcete používat, pokud chcete, aby spojení běželo v okně a ne na plné obrazovce:

[![Nastavení vlastností terminálového klienta](http://www.aspnet.cz/Files/20150713-mstsc_thumb.png "Nastavení vlastností terminálového klienta")](http://www.aspnet.cz/Files/20150713-mstsc_2.png)

Na záložce *General* zadejte název nebo IP adresu vašeho RPi za a klepněte na *Connect*. Budete vyzvání k potvrzení, že se chcete připojit pomocí nešifrovaného spojení  a poté se vám zobrazí přihlašovací dialog, kde zadejte své uživatelské jméno a heslo (výchozí je `pi` a `raspberry`):

[![Přihlašovací dialog xrdp](http://www.aspnet.cz/Files/20150713-xrdp_dialog_thumb.png "Přihlašovací dialog xrdp")](http://www.aspnet.cz/Files/20150713-xrdp_dialog_2.png)

Poté budete úspěšně připojeni. Na posledním screenshotu vidíte, jak jsem přes terminál připojen na Raspberry, kde běží Midnight Commander, webový prohlížeč a LibreOffice Writer, který jsem nainstaloval z grafického prostředí pomocí Pi Store:

[![RPi přes RDP](http://www.aspnet.cz/Files/20150713-xrdp_desktop_thumb.png "RPi přes RDP")](http://www.aspnet.cz/Files/20150713-xrdp_desktop_2.png)