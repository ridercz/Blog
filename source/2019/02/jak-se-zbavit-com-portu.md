<!-- dcterms:title = Jak se zbavit neaktivních COM portů? -->
<!-- dcterms:abstract = Pokud si taky rádi hrajete s elektronikou, Arduinem a podobnými radostmi, patrně máte na svém počítači přehršel neaktivních sériových portů (COM portů) s čísly narůstajícími do pozoruhodné velikosti. Dám vám návod, jak od nich váš systém vyčistit. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20190826-jak-se-zbavit-com-portu.png -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20181115-honeyesp.jpg -->
<!-- x4w:category = Bastlení -->
<!-- x4w:category = Tipy, triky -->
<!-- dcterms:dateAccepted = 2019-02-26 -->

Pokud si taky rádi hrajete s elektronikou, Arduinem a podobnými radostmi, patrně máte na svém počítači přehršel neaktivních sériových portů (COM portů). Dám vám návod, jak od nich váš systém vyčistit.

## Kde se vzaly COM porty?

Sériové porty byly běžným rozhraním pro připojování příslušenství u počítačů standardu PC v 80. a 90. letech. Připojovala se přes ně většina příslušenství s malým datovým tokem, jako například myši, modemy, některé tiskárny a další zařízení. Vymizely až s příchodem rozhraní USB koncem 90. let.

Dnes již klasické sériové porty (s 9 nebo 25-pinovým konektorem) v počítačích prakticky nenajdete. Na některých základních deskách ještě možná najdete tento port vyvedený na hlavičkách, ale ani to už není standardem. Pokud byste z nějakého důvodu opravdový port potřebovali, musíte si ho koupit v podobě rozšiřující karty, jakou vidíte na následující fotografii. 

<figure>
    <img src="https://www.cdn.altairis.cz/Blog/2019/20190226-karta.jpg" alt="Karta se sériovými a paralelním portem" />
    <figcaption>Tato konkrétní karta má dva sériové porty (malé konektory na samostatném bracketu) a jeden paralelní, široký konektor na vlastní kartě. Paralelní port se používal zpravidla k připojení tiskáren, ale i skenerů nebo páskových jednotek.</figcaption>
</figure>

Sériové porty se označovaly zkratkou COM (z **COM**munications Port) a paralelní zkratkou LPT (**L**ine **P**rin**T**er). V systému DOS a pozdějí Windows jsou označována jako číslovaná zařízení, příkladně `COM1`, `COM2`, `COM3` atd.

## Proč jich je tolik?

Ačkoliv se fyzické sériové porty dnes už v běžných počítačích nevyskytují, jejich dědictví žije dál, protože jejich sériový protokol je implementován a emulován řadoiu jiných prostředků. Například přes Bluetooh, interně v rámci komunikace základní desky nebo třeba pomocí USB převodníků. Ať už samostatných, nebo někde schovaných, třeba ve vývojové desce typu Arduino.

<figure>
    <img src="https://www.cdn.altairis.cz/Blog/2019/20190226-prevodnik.jpg" alt="Kompletní převodník s DB9 konektorem" />
    <figcaption>Kompletní převodník s DB9 konektorem</figcaption>
</figure>

<figure>
    <img src="https://www.cdn.altairis.cz/Blog/2019/20190226-prevodnik-maly.jpg" alt="Jednoduchý převodník pro připojení na UART pomocí pinů" />
    <figcaption>Jednoduchý převodník pro připojení na UART pomocí pinů</figcaption>
</figure>

Pokud připojíte převodník nebo zařízení s ním, pokusí se Windows najít vhodný již existující COM port (podle typu zařízení, použitého USB portu atd.) a pokud se mu to nepodaří, vytvoří COM port s dalším číslem v řadě. Pokud s podobnými zařízeními pracujete často, asi se jich budete chtít časem zbavit.

## Jak je smazat?

1. Spusťte příkazový řádek jako administrátor.
1. Zadejte následující příkaz `SET DEVMGR_SHOW_NONPRESENT_DEVICES=1`. Tím v Device Manageru povolíte zobrazování momentálně nepřipojených zařízení.
1. Spusťte Device Manager příkazem `devmgmt.msc`.
1. V menu vyberte _View -> Show hidden devices_.
1. Sériové porty se vám zobrazí ve větvi _Ports (COM & LPT)_. Ty momentálně nepřipojené budou mít polopůhlednou ikonku Smazat je můžete klepnutím na DEL nebo z kontextového menu.

<figure>
    <img src="https://www.cdn.altairis.cz/Blog/2019/20190226-device-manager.png" alt="Nepřipojené COM porty v Device Manageru" />
    <figcaption>Nepřipojené COM porty v Device Manageru</figcaption>
</figure>

Pokud chcete nad nainstalovanými zařízeními větší kontrolu a třeba i možnost smazat všechna nepoužívaná zařízení (a nejenom COM porty) najednou, mohu doporučit program jménem [Device Remover](https://www.softpedia.com/get/System/System-Miscellaneous/Device-Remover.shtml). Jeho uživatelské rozhraní je pravda poněkud divoké, ale umí toho hodně. Pro zobrazení všech nepřítomných zařízení stiskněte _Ctrl+Shift+D_. Poté v _Edit -> Check All Devices_ zaškrtněte všechna zařízení a pomocí _Ctrl+Del_ je smažte.x