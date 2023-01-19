<!-- dcterms:title = Geolokace pomocí CloudFlare a IIS Rewrite -->
<!-- dcterms:abstract = Používám na většinu svých webů (bezplatné) služby společnosti CloudFlare a mám rád možnosti URL Rewrite modulu pro IIS. A tyto dvě věci spolu umí výborně spolupracovat. Ukažme si to na příkladu geolokace a reakce na to, ze které země uživatel pochází. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20190128-cf-geoip.png -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20190128-cf-geoip.png -->
<!-- x4w:coverCredits = shaireproductions.com via Flickr, CC BY -->
<!-- x4w:category = IT -->
<!-- x4w:category = Tipy, triky -->
<!-- dcterms:date = 2019-01-28 -->

Používám na většinu svých webů (bezplatné) služby společnosti CloudFlare a mám rád možnosti URL Rewrite modulu pro IIS. A tyto dvě věci spolu umí výborně spolupracovat. Ukažme si to na příkladu geolokace a reakce na to, ze které země uživatel pochází.

## Geolokace

Podle IP adresy uživatele lze se značnou mírou pravděpodobnosti určit, ze které země uživatel pochází, resp. odkud se připojuje. Není to zcela spolehlivé, ale pro řadu účelů to postačuje.

Cloudflare do forwardovaných HTTP požadavků přidává některé hlavičky, [což je popsáno v dokumentaci](https://support.cloudflare.com/hc/en-us/articles/200170986). Pro nás je podstatná hlavička `CF-IPCOUNTRY`, která obsahuje dvoupísmenný kód země (norma _ISO 3166-1 Alpha 2_). Speciální hodnota `XX` znamená, že se geolokace nezdařila a `T1` že požadavek přišel přes Tor.

URL rewriting modul toho umí mnohem víc, než jenom URL rewriting. Mimo jiné umí rozhodnout o zpracování požadavku podle hodnoty HTTP hlavičky. Jediná zákeřnost je, že hlavičku je nutné zadat s prefixem `HTTP_` a znak `-` nahradit podtržítkem. Z `CF-IPCOUNTRY` se tak stane `HTTP_CF_IPCOUNTRY`.

Následující konfigurace v souboru `web.config` přesměruje všechny uživatele geolokalizované do ČR a SR na můj blog:

```xml
<configuration>
    <system.webServer>
        <rewrite>
            <rules>
                <rule name="Geolocation">
                    <match url=".*" />
                    <conditions logicalGrouping="MatchAny">
                        <add input="{HTTP_CF_IPCOUNTRY}" pattern="^CZ$" />
                        <add input="{HTTP_CF_IPCOUNTRY}" pattern="^SK$" />
                    </conditions>
                    <action type="Redirect" url="https://www.altair.blog/" redirectType="Temporary" />
                </rule>
            </rules>
        </rewrite>
    </system.webServer>
</configuration>
```

Jak této funkcionality využijete, to záleží na vašich potřebách. Můžete uživatele například přesměrovat na národní web nebo uživatelům z určitých zemí zakázat přístup.

## Jak na výjimky

Geolokace probíhá podle IP adresy. Ale co když pro určité speciální adresy chcete udělat výjimku? CloudFlare nechává původní adresu v hlavičce `CF-CONNECTING-IP`. Můžete tedy přidat pravidlo, které na základě této proměnné udělá něco jiného. Například následující kód neudělá nic (typ akce je `None`) a zastaví zpracovávání dalších pravidel (atribut `stopProcessing` je `true`) v případě, že se uživatel připojuje ze sítě `10.0.0/24` nebo má IP adresu `192.168.1.1`:

```xml
<configuration>
    <system.webServer>
        <rewrite>
            <rules>
                <rule name="Exceptions" patternSyntax="Wildcard" stopProcessing="true">
                    <match url="*" />
                    <conditions logicalGrouping="MatchAny">
                        <add input="{HTTP_CF_CONNECTING_IP}" pattern="192.168.1.1" />
                        <add input="{HTTP_CF_CONNECTING_IP}" pattern="10.0.0.*" />
                    </conditions>
                    <action type="None" />
                </rule>
                <rule name="Geolocation">
                    <match url=".*" />
                    <conditions logicalGrouping="MatchAny">
                        <add input="{HTTP_CF_IPCOUNTRY}" pattern="^CZ$" />
                        <add input="{HTTP_CF_IPCOUNTRY}" pattern="^SK$" />
                    </conditions>
                    <action type="Redirect" url="https://www.altair.blog/" redirectType="Temporary" />
                </rule>
            </rules>
        </rewrite>
    </system.webServer>
</configuration>
```