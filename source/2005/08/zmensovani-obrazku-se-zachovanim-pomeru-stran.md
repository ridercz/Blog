<!-- dcterms:identifier = aspnetcz#45 -->
<!-- dcterms:title = Zmenšování obrázků se zachováním poměru stran -->
<!-- dcterms:abstract = Za neuvěřitelně ohavné ovšem považuji chování některých systémů, které si rozměry obrázku upraví k obrazu svému, leč nedbají přitom na poměr stran, takže ve výsledku obrázek zdeformují. Přitom postup pro zmenšení obrázku se zachováním poměru stran je jednoduchý. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Tipy, triky -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2005-08-16T21:07:04.99+02:00 -->
<!-- dcterms:dateAccepted = 2005-08-16T21:07:04.99+02:00 -->

V mnoha aplikacích je třeba umožnit uživateli, aby nahrál nějaký obrázek. Tato operace je triviální pouze zdánlivě. Ačkoliv pro webdesignéra znalého práce s Photoshopem je řekněme úprava velikosti obrázku či jeho ořez triviální, pro mnoho uživatelů představuje překážku téměř nepřekonatelnou. 

K přijímání obrázků do aplikací je třeba přistupovat obezřetně. Že vy, coby autor aplikace, si pod pojmem "ikonka" představíte malý obrázek o rozměrech 40x50 bodů ještě neznamená, že se vám tam uživatel nepokusí nahrát kompletní neupraveno fotografii z digitálu v rozlišení 6 megapixelů.

Jest tedy nutno minimálně ověřovat, co uživatel posílá. A ještě lépe, umožnit mu aby nahrál víceméně cokoliv a nějak si s tím poradit - obrázek operativně zvětšit či zmenšit.

Za neuvěřitelně ohavné ovšem považuji chování některých systémů, které si rozměry obrázku upraví k obrazu svému, leč nedbají přitom na poměr stran, takže ve výsledku obrázek zdeformují. Přitom postup pro zmenšení obrázku se zachováním poměru stran je jednoduchý. Definujeme maximální velikost obrázku jako prostor, do kterého se obrázek musí vejít. Pokud se poměr stran originálního obrázku bude shodovat s poměrem stran maximální velikosti, nastane ideální situace a obrázek bude zcela vyplňovat prostor. Bude-li jiný, je třeba zmenšit obrázek tak, aby se celý vešel do vyhrazeného prostoru a zbytek vyplnit podkladovou barvou (pokud nutně potřebujete pevnou velikost obrázku).

V zájmu ochrany svého estetického cítění před zdeformovanými obrázky zde přikládám příslušný kód:

    Public Shared Function ResizeImage(ByRef Source As System.Drawing.Image, ByVal Width As Int32, ByVal Height As Int32) As System.Drawing.Image
        ' Do nothing, if dimensions are correct
        If Source.Width = Width And Source.Height = Height Then Return Source
        ' Get proportional size of image
        Dim W, H As Int32
        If Source.Width >= Source.Height Then
            W = Width
            H = CInt(Source.Height * (Width / Source.Width))
        Else
            W = CInt(Source.Width * (Height / Source.Height))
            H = Height
        End If
        ' Draw new image
        Dim Target As New System.Drawing.Bitmap(Width, Height)
        Dim GPH As System.Drawing.Graphics = System.Drawing.Graphics.FromImage(Target)
        GPH.FillRectangle(Drawing.Brushes.White, 0, 0, Width, Height)
        GPH.CompositingQuality = Drawing.Drawing2D.CompositingQuality.HighQuality
        GPH.SmoothingMode = Drawing.Drawing2D.SmoothingMode.HighQuality
        GPH.InterpolationMode = Drawing.Drawing2D.InterpolationMode.HighQualityBicubic
        GPH.DrawImage(Source, 0, 0, W, H)
        Return Target
    End Function