<!-- dcterms:identifier = aspnetcz#2 -->
<!-- dcterms:title = HTTP komprese v IIS a ASP.NET -->
<!-- dcterms:abstract = Zapnutím HTTP komprese je možno snížit objem přenášených dat a zrychlit načítání stránek. Za vše se ale platí. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Tipy, triky -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2005-01-02T02:16:39.593+01:00 -->
<!-- dcterms:dateAccepted = 2005-01-02T02:16:39.593+01:00 -->

Pravděpodobně všichni znáte a používáte klasickou komprimaci souborů - jejich "sbalení" do ZIP nebo RAR archivu, čímž se zmenší jejich datový objem. Takovou kompresi je možno provádět i automaticky při přenosu mezi webovým serverem a klientem. Můžete si to představit tak, že server posílaná data sbalí do ZIPu a klient (prohlížeč) je zase rozbalí a zobrazí. V případě HTML kódu je možno dosáhnout značné úspory přenášených dat a tím zrychlit stahování stránek, zejména na pomalejších linkách.

## Jak to v IIS nastavit

V defaultním nastavení na IIS 6.0 je HTTP komprese vypnutá. Chcete-li ji zapnout, otevřete si *IIS Manager*, v levém sloupci klepněte pravým tlačítkem na "složku" *Web sites* a z kontextového menu zvolte *Properties*. Na záložce *Service* zaškrtněte *Compress application files* i *Compress static files*:

![Dialogové okno nastavení HTTP komprese](https://www.cdn.altairis.cz/Blog/2005/20050102-http-compression.png)

Komprese se zapne po restartu IIS. Zatím ho ovšem ještě nerestartujte, je totiž třeba nastavit co se má komprimovat.

## Co komprimovat a co ne?

Které soubory se budou či nebudou komprimovat rozhoduje IIS podle jejich přípony. Standardně jsou nastaveny takto:

*   Statické soubory: *htm, html, txt* 
Dynamické aplikace: *asp, exe, dll*

Toto nastavení není nejšťastnější, protože zcela ignoruje .NET aplikace a ani v případě statických souborů má jisté rezervy.

Bezztrátová komprese funguje tak, že nahrazuje opakující se sekvence bajtů. Principiálně je tedy vhodná pro textová data a značkovací jazyky a některé další typy dat. Naopak naprosto nevhodná jsou data se strukturou víceméně náhodnou - například data šifrovaná nebo již jednou komprimovaná (což se týká i formátů, které mají kompresi "vestavěnou", jako například JPEG, GIF, PNG, MP3, WM* a podobně).

Osobně používám toto nastavení:

*   Statické soubory: *htm, html, txt, css, js, vbs, xml, xslt* 
Dynamické aplikace: *asp, exe, dll, aspx, asmx*

Seznam přípon je uložen v metabázi, ve větvích *W3Svc/Filters/Compression/GZIP* a *W3Svc/Filters/Compression/DEFLATE* (IIS podporuje dva komprimační algoritmy, GZIP a DEFLATE). Spíše než přímou editaci metabase.xml doporučuji použít skript *ADSUTIL.VBS* (nachází se zpravidla v *C:\InetPub\AdminScripts\*). Otevřete tedy příkazový řádek, přejděte do tohoto adresáře a postupně spusťte následující čtyři příkazy:

    CSCRIPT.EXE ADSUTIL.VBS SET W3Svc/Filters/Compression/GZIP/HcFileExtensions "htm" "html" "txt" "css" "js" "vbs" "xml" "xslt"
    CSCRIPT.EXE ADSUTIL.VBS SET W3Svc/Filters/Compression/DEFLATE/HcFileExtensions "htm" "html" "txt" "css" "js" "vbs" "xml" "xslt"
    CSCRIPT.EXE ADSUTIL.VBS SET W3Svc/Filters/Compression/GZIP/HcScriptFileExtensions "asp" "dll" "exe" "aspx" "asmx"
    CSCRIPT.EXE ADSUTIL.VBS SET W3Svc/Filters/Compression/DEFLATE/HcScriptFileExtensions "asp" "dll" "exe" "aspx" "asmx"

Tak. A teď už můžete to IISko konečně restartovat (z příkazové řádky spusťte *iisreset.exe*).

## Něco za něco

V životě není nic zadarmo. A samozřejmě že ani HTTP komprese nebude výjimkou. Komprimace přenášených dat sice šetří linky, ale zase zatěžuje procesor na straně serveru i klienta. S klientem si starosti dělat netřeba - zvládne to v pohodě. Server na tom může být opačně, pokud je hodně zatěžován. Počítejte s tím, že po zapnutí HTTP komprese vzroste zatížení procesoru a server monitorujte, zda "stíhá".

HTTP komprese je velmi účinná v případě, že server posílá ta samá data beze změny mnoha klientům. Zkomprimuje je jednou a pak si je drží v cache a zatížení systému příliš neroste.

Velké zatížení naopak čekejte v případě, že "co stránka to originál" - příkladně pokud stránky generujete dynamicky podle aktuálně přihlášeného uživatele a podobně.

## Zpětná kompatibilita

Všechny současné desktopové browsery HTTP kompresi podporují. Leč najdou se i takové, které jí nerozumí. IIS nicméně umí poznat, co komu poslat. Pokud klient s požadavkem pošle hlavičku "*Accept-Encoding: gzip, deflate*", dá tím najevo, že kompresi umí a IIS ji použije. Pokud hlavička chybí, pošle data bez komprese. Můžete si to vyzkoušet například prostřednictvím užitečného nástroje *wfetch*, který je součástí [IIS 6.0 Resource Kitu](http://www.microsoft.com/downloads/details.aspx?familyid=56fc92ee-a71a-4c73-b628-ade629c89499&displaylang=en).