<!-- dcterms:identifier = aspnetcz#3410 -->
<!-- dcterms:title = Jak jednoduše převádět časové údaje mezi jednotlivými časovými pásmy -->
<!-- dcterms:abstract = Česká republika má to štěstí, že se celá nachází v jednom časovém pásmu a čeští programátoři jsou obvykle ušetřeni nutnosti tento údaj sledovat a pracovat s ním. Nicméně to neplatí ve chvíli, kdy se server nachází v jiném časovém pásmu, než klienti. Typickým příkladem je třeba Windows Azure, jehož servery bez ohledu na umístění běží v UTC. Nicméně, tento problém lze celkem jednoduše vyřešit. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Programování -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2013-05-03T22:00:24.473+02:00 -->
<!-- dcterms:dateAccepted = 2013-05-03T22:03:18.277+02:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20130503-jak-jednoduse-prevadet-casove-udaje-mezi-jednotlivymi-casovymi-pasmy.png -->

Česká republika má to štěstí, že se celá nachází v jednom časovém pásmu a čeští programátoři jsou obvykle ušetřeni nutnosti tento údaj sledovat a pracovat s ním. Nicméně to neplatí ve chvíli, kdy se server nachází v jiném časovém pásmu, než klienti. Typickým příkladem je třeba Windows Azure, jehož servery bez ohledu na umístění běží v UTC. Nicméně, tento problém lze celkem jednoduše vyřešit.

Obšírnější pojednání o práci s datumem a časem a časovými pásmy najdete v [seriálu Tomáše Jechy na VBNET.CZ](http://www.vbnet.cz/serial--24-prace_s_casovymi_pasmy_a_letnim_casem_v_aplikaci_a_databazi.aspx). Já se omezím jenom na konkrétní rady bez obsáhlejšího upřesnění.

Datový typ `System.DateTime` v .NET, případně databázové typy `datetime` a `smalldatetime` v sobě nenesou informaci o časové zóně, k níž se uváděný čas vztahuje. Takto určený čas tedy sám o sobě neodkazuje na konkrétní okamžik v čase. Abychom tuto informaci získali, musíme postupovat netechnickými prostředky, tedy třeba si tu informaci vyhledat v dokumentaci konkrétní aplikace. 

Datový typ `System.DateTime` má vlastnost `Kind`, která určuje, zda je hodnota v UTC, v lokálním čase (ovšem už neříká, ve kterém) nebo zda tento údaj není specifikován. Obdobnou vlastností nicméně nedisponují korespondující databázové typy, takže třeba v případě hodnoty získané z databáze bude `Kind` nejspíše nastaven na `Unspecified`.

V .NET Frameworku 3.5 přibyl nový typ, který se jmenuje `System.DateTimeOffset`. A v MicrosfSQL Serveru 2008 je k dispozici databázový typ `datetimeoffset`. Tyto datové typy sice také nenesou informaci o časové zóně, ale ukládají posun proti UTC, což nám ve většině případů postačuje – a zejména to určuje konkrétní okamžik v čase. Se znalostí této informace nicméně dokážeme čas zobrazit v libovolné časové zóně, kterou si zamaneme – nejspíše tedy té, která odpovídá uživateli.

Obecně nejrozumnější je ukládat časové údaje pomocí těchto "nových" datových typů. Je to nejrobustnější a dokážeme si poradit i s poměrně exotickými případy, jako třeba že databázový server je v jiné časové zóně, než webový a než klient.

V prostředí Windows Azure je situace o to jednodušší, že se úplně všechno počítá v UTC, tedy s offsetem nula. Můžeme tedy s klidem použít i "starší" datové typy a vycházet z toho, že údaje jsou v UTC. Pozor si budeme muset dát jenom ve chvíli, kdy přenášíme data mezi "on premises" a cloudovým prostředím, případně při vývoji a testování na lokálním stroji, který nejspíše bude v jiné časové zóně.

Klienty zpravidla příliš nezajímá, jaká časová zóna je na serveru a v databázi a údaje chtějí ve svém lokálním čase. Pro účely zobrazení tedy budeme muset převést čas do jejich zóny, se zohledněním případného letního času a podobně. Naštěstí .NET disponuje třídou `TimeZoneInfo`, která tyto konverze umí provádět.

Pro účely zobrazení lze s výhodou použít extension metody. Následující kód rozšíří instance tříd `DateTime` a `DateTimeOffset` o metodu `ToLocalDisplayFormat`, která převede čas do zvolené časové zóny a zformátuje jej podle našich parametrů. V tomto případě umí pracovat se dny "včera", "dnes" a "zítra":

    private const string TZID = "Central Europe Standard Time";

    public static string ToLocalDisplayFormat(this DateTime dt) {
        var dto = new DateTimeOffset(dt);
        return dto.ToLocalDisplayFormat();
    }

    public static string ToLocalDisplayFormat(this DateTimeOffset dt) {
        var dtConverted = TimeZoneInfo.ConvertTimeBySystemTimeZoneId(dt, TZID);
        var todayConverted = TimeZoneInfo.ConvertTimeBySystemTimeZoneId(DateTime.UtcNow, TZID).Date;

        var dayDelta = (int)dtConverted.Date.Subtract(todayConverted).TotalDays;

        if (dayDelta == -1) {
            // Yesterday
            return string.Format("včera, {0:HH:mm}", dtConverted);
        }
        else if (dayDelta == 0) {
            // Today
            return string.Format("dnes, {0:HH:mm}", dtConverted);
        }
        else if (dayDelta == 1) {
            // Tomorrow
            return string.Format("zítra, {0:HH:mm}", dtConverted);
        }
        else {
            // Sometime else
            return dtConverted.ToString("dd. MM. yyyy HH:mm");
        }
    }

Hodnota konstanty TZID určuje cílovou časovou zónu a v tomto případě se jedná o časovou zónu ČR. Kompletní seznam časových zón známých danému systému (seznam se občas mění) získáte pomocí metody [GetSystemTimeZones](http://msdn.microsoft.com/en-us/library/system.timezoneinfo.getsystemtimezones.aspx).

S příchodem model bindingu lze výše uvedenou metodu použít i při data bindingu, stačí jenom příslušnou třídu s extension metodami učinit viditelnou ve stránce, registrací jejího namespace v souboru `web.config`.