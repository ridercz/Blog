<!-- dcterms:identifier = aspnetcz#5413 -->
<!-- dcterms:title = Jak na automatické verzování v nových verzích .NET a VS -->
<!-- dcterms:abstract = Starší verze .NET Frameworku podporovaly automatické verzování, kdy se část informace o verzi vygenerovala automaticky podle datumu a času. Verze 4.5 nicméně přešla na sémantické verzování a tuto funkcionalitu ztratila. Jak ji vrátit zpátky? -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Programování -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2013-11-08T19:54:51.947+01:00 -->
<!-- dcterms:dateAccepted = 2013-11-08T19:54:52+01:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20131108-jak-na-automaticke-verzovani-v-novych-verzich-net-a-vs.png -->

<p abp="329">Starší verze .NET Frameworku podporovaly automatické verzování. Pokud jste verzi zapsali například jako <code abp="330">1.0.*</code>, komponenty <code abp="331">Build</code> a <code abp="332">Revision</code> se vygenerovaly automaticky podle datumu a času buildu. Verze 4.5 nicméně přešla na sémantické verzování a tuto funkcionalitu ztratila.</p>
<p abp="333">Sémantické verzování (semantic versioning) si klade za cíl vnést logiku do procesu určování čísel verzí software. Má docela smysluplná pravidla, která lze nalézt na webu <a href="http://semver.org/" abp="334">SemVer.org</a>. Tento postup je velmi vhodný pro verzování komponent a dalších věcí, na kterých závisí široká skupina uživatelů.</p>
<p abp="335">Již méně je vhodný pro vývoj webových aplikací, které fungují v jedné nebo několika málo instancích a mění se velmi často. A přitom je dobré vědět, jaká verze je kde právě nasazená. Sémantické verzování vyžaduje, aby se verze měnila ručně a programátor ji ručně nastavil tak, jak odpovídá povaze provedených změn. V tom opačném případě je žádoucí, aby se alespoň část verze generovala automaticky a měnila se – při každém buildu, v závislosti na čase… To bohužel Visual Studio při práci s novými verzemi .NET Frameworku neumí.</p>
<p abp="336">Snažil jsem se to vyřešit pomocí různých add-inů, ale žádný z nich nefungoval dlouhodobě spolehlivě. Takže jsem add-iny zatratil a rozhodl se to vyřešit jinak, pomocí MS Build tasků.</p>
<p abp="337">Proces buildu je velmi dobře rozšiřitelný a lze v něm dělat v podstatě cokoliv, pokud máte správný task. Některé jsou přímo součástí instalace, další si můžete snadno napsat sami. Já budu používat úkoly z projektu <a href="https://github.com/loresoft/msbuildtasks/" abp="338">MS Build Community Tasks</a>.</p>
<p abp="339">Prvním krokem je instalace MS Build Community Tasks. To se dá nainstalovat buďto ručně, nebo pomocí NuGet balíčku. Zvolil jsem cestu NuGet balíčku, protože pak je všechno potřebné součástí projektu a netřeba spoléhat na to, že bude nainstalován lokálně. Balíček nainstalujete následujícím příkazem:</p>
<pre abp="340">Install-Package MSBuildTasks</pre>
<p abp="341">Na tomto balíčku je zvláštní, že nemodifikuje konkrétní projekt, ale do solution přidá novou složku <code abp="342">.build</code>, která obsahuje potřebné soubory <code abp="343">MSBuild.Community.Tasks.dll</code> a <code abp="344">MSBuild.Community.Tasks.targets</code>. Také obsahuje ukázkový projekt <code abp="345">Build.proj</code>, který ale nebudeme potřebovat a je možné ho smazat. Balíček stačí nainstalovat do jednoho projektu v solution.</p>
<p abp="346">Dále pak je nezbytné modifikovat projektový soubor (<code abp="347">.csproj</code>) každého projektu, u něhož se má automatické verzování používat. Projektový soubor je obyčejné XML. Můžete ho editovat v libovolném textovém editoru, když nemáte ve Visual Studiu otevřený projekt, který obsahuje. Případně jej můžete editovat i ve Visual Studiu samém, když z kontextového menu zvolíte <em abp="348">Unload project</em> a potom <em abp="349">Edit něco.csproj</em>.</p>
<p abp="350">Na konec souboru (před tag <code abp="351">&lt;/Project&gt;</code>)&nbsp; vložte následující kód (samozřejmě upravte metadata tak, aby vám vyhovovala):</p>
<pre class="xml" abp="352">&lt;PropertyGroup&gt;
  &lt;MSBuildCommunityTasksPath&gt;$(SolutionDir)\.build&lt;/MSBuildCommunityTasksPath&gt;
&lt;/PropertyGroup&gt;
&lt;Import Project="$(MSBuildCommunityTasksPath)\MSBuild.Community.Tasks.Targets" /&gt;
&lt;Target Name="BeforeBuild"&gt;
  &lt;Time Format="yyyy.MM.dd.HHmm" Kind="Utc"&gt;
    &lt;Output TaskParameter="Year" PropertyName="Year" /&gt;
    &lt;Output TaskParameter="FormattedTime" PropertyName="TimeVersion" /&gt;
  &lt;/Time&gt;
  &lt;Message Text="$(AssemblyName) version $(TimeVersion)" Importance="high" /&gt;
  &lt;AssemblyInfo CodeLanguage="CS"
                OutputFile="Properties\AssemblyInfo.cs"
                AssemblyTitle="My Assembly Title"
                AssemblyDescription="My Assembly Description"
                AssemblyCompany="My Company"
                AssemblyProduct="My Product Name"
                AssemblyTrademark="My Trademark"
                AssemblyCopyright="Copyright © $(Year)"
                AssemblyConfiguration="$(BuildConfiguration)"
                AssemblyVersion="$(TimeVersion)"
                AssemblyFileVersion="$(TimeVersion)" /&gt;
&lt;/Target&gt;</pre>
<p abp="353">Výše uvedené nasatvení při každém buildu dynamicky vygeneruje soubor <code abp="354">Properties\AssemblyInfo.cs</code> a nastaví v něm metadata dle zadání. Verzi přitom automaticky vygeneruje podle aktuálního datumu a času v UTC ve formátu <code abp="355">yyyy.MM.dd.HHmm</code>. Pokud tedy aktuální čas je 8. 11. 2013, 19:25 SEČ, verze bude <code abp="356">2013.11.8.1825</code>. Rovněž se dynamicky doplní rok do aktuální informace o copyrightu.</p>
<p abp="357">MS Build Community Tasks nabízí i zvláštní task <code abp="358"><a href="https://github.com/loresoft/msbuildtasks/blob/master/Source/MSBuild.Community.Tasks/Version.cs" abp="359">Version</a></code>, který umí čísla verzí generovat sofistikovaněji, například "starým" algoritmem, kdy je <code abp="360">Build</code> rovno počtu dnů od 1. 1. 2000 a <code abp="361">Revision</code> počtu sekund od půlnoci děleno dvěma (vše lokálního času).</p>
<p abp="362">Berte prosím na vědomí, že výše uvedeným postupem se při každém buildu přegeneruje aoubor <code abp="363">AssemblyInfo.cs</code> a odstraní se všechno, co v něm bylo. Pokud tam tedy máte ještě nějaké další atributy, musíte je umístit do jiného souboru.Může být také dobrý nápad odstranit tento soubor z version controllingu, protože se vám bude neustále měnit pod rukama.</p>
<p abp="364">Knihovna MS Build Community Tasks obsahuje i celou řadu dalších užitečných tasků. Kvalita dokumentace se nicméně pohybuje mezi "mizerná" a "žádná", takže je lepší se podívat do zdrojáků.</p>