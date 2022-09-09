<!-- dcterms:title = Jak získat datum a čas buildu ASP.NET Core aplikace -->
<!-- dcterms:abstract = Můj oblíbený systém automatického verzování podle datumu a času není kompatibilní s novými funkcemi .NETu pro snazší vývoj, jako je hot reload částečná kompilace. Proto jsem musel přijít s jiným způsobem, jak zjistit datum a čas buildu aplikace. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:coverUrl = /cover-pictures/20220909-build-date.jpg -->
<!-- x4w:coverCredits = Lucas Santos via Unsplash.com -->
<!-- x4w:pictureUrl = /perex-pictures/20220909-build-date.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = IT -->
<!-- dcterms:dateAccepted = 2022-09-09 -->

Můj oblíbený systém [automatického verzování podle datumu a času](https://www.altair.blog/2018/11/automaticke-verzovani-v-core) není kompatibilní s novými funkcemi .NETu pro snazší vývoj, jako je hot reload a částečná kompilace. To přestane fungovat pokud se při buildu změní verze assembly. Proto jsem musel přijít s jiným způsobem, jak zjistit datum a čas buildu aplikace.

## Assembly metadata

Po vydání první verze článku (která popisuje automatické generování resource souboru) jsem byl [uživatelem _harrison314\_sk_ na Twitteru upozorněn](https://twitter.com/harrison314_sk/status/1568204506218872834), že existuje jednodušší způsob, jak do assembly vložit datum buildu (a v podstatě jakákoliv jiná metadata).

Stačí do `.csproj` souboru vložit element `AssemblyMetadata`, kterým můžete přidat do assembly vlastní informace stylem klíč-hodnota. Zde vkládám datum buildu a název počítače, na kterém byl build proveden:

```xml
<ItemGroup>
    <AssemblyMetadata Include="BuildDate" Value="$([System.DateTime]::UtcNow.ToString('s'))" />
    <AssemblyMetadata Include="BuildComputer" Value="$(ComputerName)" />
</ItemGroup>
```

> Popis použité syntaxe a možností najdete v článku [MSBuild properties](https://docs.microsoft.com/en-us/visualstudio/msbuild/msbuild-properties?view=vs-2022) na docs.microsoft.com.

Hodnotu pak můžete načíst přes reflexi. Zde jsou dvě funkce, které načtou a vrátí shora uvedené vlastnosti:

```cs
private static DateTime GetAssemblyBuildDate(Assembly? assembly) {
    if (assembly == null) return DateTime.MinValue;
    var attrs = assembly.GetCustomAttributes<AssemblyMetadataAttribute>();
    var dateString = attrs.FirstOrDefault(x => x.Key.Equals("BuildDate"))?.Value;
    var parseResult = DateTime.TryParseExact(dateString, "s", CultureInfo.InvariantCulture, DateTimeStyles.AssumeUniversal, out var dt);
    return parseResult ? dt : DateTime.MinValue;
}

private static string? GetAssemblyBuildComputer(Assembly? assembly) {
    if (assembly == null) return null;
    var attrs = assembly.GetCustomAttributes<AssemblyMetadataAttribute>();
    return attrs.FirstOrDefault(x => x.Key.Equals("BuildComputer"))?.Value;
}
```

## Automatické generování do resources

Jako většina ostatních platforem, i .NET zná koncept _resources_. Tedy ukládání dat jako jsou řetězce, obrázky, ikony a obecná data mimo zdrojový kód tak, aby byla z tohoto kódu snadno dostupná a snadno lokalizovatelná. Tento koncept využívá moje původní metoda pro automatické generování času buildu.

Nejdříve si zobrazte vlastnosti projektu. V sekci _Build_ zvolte _Events_ a do pole _Pre-build event_ zadejte následující příkaz:

```cmd
powershell -Command "((Get-Date).ToUniversalTime()).ToString(\"s\") | Out-File '$(ProjectDir)Properties\BuildDate.txt'"
```

![Screenshot](https://www.cdn.altairis.cz/Blog/2022/20220909-build-date-01.png)

Můžete také přímo editovat `.csproj` soubor a zadat do elementu `<Project>` následující kód:

```xml
<Target Name="PreBuild" BeforeTargets="PreBuildEvent">
    <Exec Command="powershell -Command &quot;((Get-Date).ToUniversalTime()).ToString(\&quot;s\&quot;) | Out-File '$(ProjectDir)Properties\BuildDate.txt'&quot;" />
</Target>
```

Poté v sekci _Resources_ klepněte na _Create or open assembly resources_.

![Screenshot](https://www.cdn.altairis.cz/Blog/2022/20220909-build-date-02.png)

Tím vytvoříte reource `./Properties/Resources.resx`. Můžete ho samozřejmě vytvořit i ručně. Pokud chcete aby byla hodnota viditelná i mimo assembly, nastavte _Access Modifier_ na _Public_:

![Screenshot](https://www.cdn.altairis.cz/Blog/2022/20220909-build-date-03.png)

Nyní aplikaci zkompilujte. Před kompilací bude vytvořen soubor `./Properties/BuildDate.txt`, který bude obsahovat aktuální datum a čas (UTC) ve formátu `yyyy-MM-ddTHH:mm:ss`.

Nyní tento soubor ze Solution Exploreru přetáhněte myší do okna, kde je zobrazen _Resources.resx_. Tím se vytvoří nový klíč, jehož obsahem bude obsah souboru:

![Screenshot](https://www.cdn.altairis.cz/Blog/2022/20220909-build-date-04.png)

Obsah tohoto souboru se mění s každým buildem, takže když se zeptáte na hodnotu `Properties.Resources.BuildDate`, dostanete vždy řetězec obsahující datum a čas, kdy byla aplikace zkompilována.

Pokud používáte Git, přidejte soubor `BuildDate.txt` do `.gitignore`, ať vám nedělá zmatek v repozitáři. 