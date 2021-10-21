<!-- dcterms:title = ASP.NET na Raspberry Pi: Autentizace SSH klíčem -->
<!-- dcterms:abstract = První díl našeho seriálu o ASP.NET na Raspberry Pi jsme skončili v okmžiku vzdáleného přihlášení jménem a heslem. Místo hesla ale lze pro přihlášení přes SSH (Secure SHell) použít asymetrický klíč. To je mnohem bezpečnější a zároveň pohodlnější. Ukážeme si, jak povolit autentizaci klíčem a zakázat použití hesla. Tento návod se navíc netýká pouze Raspberry Pi, ale jakéhokoliv počítače s Linuxem. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20211021-dotnet-raspi-2.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20211021-dotnet-raspi-2.jpg -->
<!-- x4w:coverCredits = Chunli Ju via Unsplash.com -->
<!-- x4w:category = Z-TECH -->
<!-- x4w:category = IT -->
<!-- x4w:serial = ASP.NET na Raspberry Pi -->
<!-- dcterms:dateAccepted = 2021-10-21 -->

[První díl](https://www.altair.blog/2021/10/dotnet-raspi-1) našeho seriálu o ASP.NET na Raspberry Pi jsme skončili v okmžiku vzdáleného přihlášení jménem a heslem. Místo hesla ale lze pro přihlášení přes SSH (Secure SHell) použít asymetrický klíč. To je mnohem bezpečnější a zároveň pohodlnější. Ukážeme si, jak povolit autentizaci klíčem a zakázat použití hesla. Tento návod se navíc netýká pouze Raspberry Pi, ale jakéhokoliv počítače s Linuxem.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/TtU4HAmmjbs" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

## Vygenerování klíče

V první řadě potřebujete SSH klienta. Ve Windows je součástí od poměrně dávného buildu Windows 10 a můj návod se týká jeho. Můžete samozřejmě použít i jiného klienta, jako [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) nebo [Bitvise SSH Client](https://www.bitvise.com/ssh-client-download), ale pak bude postup jiný.

Pokud již máte SSH klíč, který chcete použít, můžete tento krok přeskočit. Pokud ne, použijte pro vytvoření nového klíče příkaz `ssh-keygen` v příkazové řádce. V průběhu generování budete dotázáni na heslo. Pokud ho zadáte, bude klíč uložen v zašifrovaném tvaru a pro jeho použití budete muset zadat heslo. To se ale zadává pouze lokálně, nepřenáší se nikam po síti.

> Pokud chcete modifikovat existující klíč (přidat mu heslo, odebrat ho nebo změnit), použijte příkaz `ssh-keygen -p`.

Výchozí jméno souboru je `id_rsa` (bez přípony, privátní klíč) a `id_rsa.pub` (veřejný klíč) a nachází se ve vašem uživatelském profilu ve složce `.ssh`, tj. např. `C:\User\johndoe\.ssh\id_rsa`. **Tyto soubory ihned zazálohujte.** Pokud o ně v budoucnu přijdete a zakážete přihlašování pomocí hesla, na server se v budoucnu po síti nedostanete.

Je bezpečné používat tentýž klíč k přihlašování k více serverům.

## Nahrání klíče na server

Druhým krokem je, že musíte vzdálenému serveru říct, že se k němu hodláte do budoucna přihlašovat konkrétním klíčem. Na Linuxu a nejspíš i Macu se k tomuto účelu používá příkaz [`ssh-copy-id`](https://www.ssh.com/academy/ssh/copy-id), ale na Windows není z nějakého důvodu k dispozici.

Na Windows tedy musíte použít následující poněkud krkolomný příkaz:

	type %USERPROFILE%\.ssh\id_rsa.pub | ssh pi@10.7.0.126 "mkdir -p ~/.ssh && cat >> .ssh/authorized_keys"

Místo `10.7.0.126` samozřejmě zadejte IP adresu nebo jméno vašeho Raspberry Pi. Tento příkaz přidá váš veřejný klíč do souboru `~/.ssh/authorized_keys` na serveru. Budete vyzváni k zadání současného hesla (pokud jste ho na konci předchozího dílu nezměnili, je `raspberry`).

Nyní stačí napsat `ssh pi@10.7.0.126` a budete automaticky přihlášeni pomocí klíče, bez hesla.

## Zákaz přihlašování pomocí hesla

V této chvíli si můžete vybrat. Můžete se přohlásit buďto pomocí hesla nebo klíče. Přihlašování pomocí hesla jse však dobrý nápad zakázat.

Připojte se přes SSH na vzdálený server a následujícím příkazem otevřete textový editor _Nano_ a v něm soubor `/etc/ssj/sshd_config`:

	sudo nano /etc/ssj/sshd_config

Najděte v souboru řádek `# PasswordAuthentication yes` a změňte ho na `PasswordAuthentication no` (tj. odkomentujte smazáním úvodního `#` a změňte hodnotu na `no`).

Stiskněte _Ctrl+X_ pro ukončení editoru. Na otázku _Save modified buffer?_ odpovězte _Y_ a poté klávesou _ENTER_ potvrďte uložení souboru.

Aby se změna projevila, musíte restartovat počítač (příkazem `sudo reboot now`) nebo alespoň SSH službu (daemona) příkazem `sudo /etc/init.d/ssh restart`. Použití druhého příkazu vás možná odpojí od serveru a budete se muset znovu připojit.

V tomto okamžiku máte na serveru povoleno vzdálené přihlašování pouze pomocí klíče. Za týden se v dalším pokračování tohoto seriálu podíváme, jak na ARM Linux nasadit aplikaci napsanou v ASP.NET 5.0