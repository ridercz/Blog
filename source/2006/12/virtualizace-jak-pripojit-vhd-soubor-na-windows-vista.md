<!-- dcterms:identifier = aspnetcz#128 -->
<!-- dcterms:title = Virtualizace: Jak připojit VHD soubor na Windows Vista -->
<!-- dcterms:abstract = VHD soubory se nám utěšeně rozmáhají. Kromě Virtual PC a Virtual Serveru je najdete například i ve Windows Vista, protože do tohoto formátu se ukládají zálohy kompletního systému. Tím zajímavější může být možnost připojit si VHD soubor jako další harddisk k fyzickému počítači. -->
<!-- np9:categoryId = 7 -->
<!-- x4w:category = Software -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- np9:serialId = 1 -->
<!-- x4w:serial = Virtualizace -->
<!-- dcterms:created = 2006-12-17T16:24:53.98+01:00 -->
<!-- dcterms:dateAccepted = 2006-12-17T16:24:53.98+01:00 -->

VHD soubory se nám utěšeně rozmáhají. Kromě Virtual PC a Virtual Serveru je najdete například i ve Windows Vista, protože do tohoto formátu se ukládají zálohy kompletního systému. Tím zajímavější může být možnost připojit si VHD soubor jako další harddisk k fyzickému počítači.

Takovou možnost vám nabízí utilitka **VHDMount**, která je součástí *Virtual Server 2005 R2 SP1 Beta 2*. Pokud chcete svoje VHD soubory připojovat k fyzickému počítači, postupujte následovně:

1.  Stáhněte si z Microsoft Connect [aktuální betaverzi Virtual Serveru se SP1](https://connect.microsoft.com/programdetails.aspx?ProgramDetailsID=525).
2.  Spusťte setup a nainstalujte si program. Nemusíte instalovat celý Virtual Server, pokud zvolíte Custom Install, máte možnost zvolit si pouze instalaci VHDMount.
3.  Vše potřebné nyní najdete ve složce C:\Program Files\Microsoft Virtual Server\Vhdmount. Příkazem *vhdmount /m C:\cesta\k\souboru.vhd* disk připojíte, pomocí *vhdmount /u C:\cesta\k\souboru.vhd* disk odpojíte. 

Pokud se vám nechce používat příkazovou řádku, můžete si příkazy pro mount a unmount [přidat do kontextového menu](http://blogs.msdn.com/virtual_pc_guy/archive/2006/09/01/734435.aspx) pro VHD soubory.

 ![VHD mount error](/Files/20061217-vhdmount_vista.png) 

Na Windows Vista z neznámých důvodů současná verze nefunguje a je potřeba si pomoci malým trikem.

1.  Připojte disk shora popsaným postupem. Vista zahlásí, že se jí nepodařilo nainstalovat hardware.
2.  Otevřete si computer management a v něm device manager. Klepněte pravým tlačítkem na "Microsoft Virtual Server Storage Device" a zvolte "Update Driver Software".
3.  V dalším okně klepněte na "Browse my computer for driver software".
4.  V dalším okně klepněte na "Let me pick from a list...". Ze seznamu ovladačů vyberte "Microsoft Virtual Server Storage Devices".
5.  Po nainstalování ovladačů je disk plně funkční, vidíte ho v Disk manageru a můžete mu přiřadit písmeno.