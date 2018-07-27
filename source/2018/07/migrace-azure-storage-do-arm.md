<!-- dcterms:title = Jak na migraci Azure Storage z Classic do ARM -->
<!-- dcterms:abstract = Pokud používáte Azure již nějakou dobu, nejspíš máte řadu Azure Storage účtů ve starém režimu "Classic". Většina nových nástrojů a služeb nicméně předpokládá, že vaše účty budou již v novém režimu, který používá Azure Resource Manager (ARM). Upgrade není úplně triviální, ale ani nemožný. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:dateAccepted = 2018-07-27 -->
<!-- x4w:category = IT -->
<!-- x4w:pictureUrl = /perex-pictures/logo-azure.png -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->

Pokud používáte Azure již nějakou dobu, nejspíš máte řadu Azure Storage účtů ve starém režimu "Classic". Většina nových nástrojů a služeb nicméně předpokládá, že vaše účty budou již v novém režimu, který používá Azure Resource Manager (ARM).

![](https://www.cdn.altairis.cz/Blog/2018/20180727-portal-1.png)

Storage účty, které jsou ve starém režimu poznáte ve webovém rozhraní podle toho, že jejich ikonka je modrá a jejich typ je _Storage account (classic)_. Účty s podporou ARM mají ikonku zelenou na typ _Storage account_.

## Jak na migraci

Migraci nelze provádět z webového portálu, ale jenom přes API - například z Azure CLI nebo PowerShellu. Návodů na to najdete spoustu (tento článek hodně vychází z [toho](https://ppolyzos.com/2016/08/07/migrate-azure-storage-account-from-classic-to-azure-resource-manager-arm/), který napsal můj MVP kolega Paris Polyzos). Bohužel, všechny mnou nalezené návody pomíjejí některé důležité aspekty, jako instalaci PS modulů nebo práci s resource groups.

### Instalace potřebných PowerShell modulů

Nejprve je nutné nainstalovat patřičné moduly pro PowerShell, a to hned dva:

* `Azure` je starší verze, která podporuje _classic_ deployment model.
* `AzureRM` je novější verze, která podporuje Resource Manager.

Pro migraci jsou potřeba oba. Spusťte si PowerShell jako administrátor a zadejte následující příkazy, kterými moduly nainstalujete:

```ps
Install-Module AzureRM
Install-Module Azure -AllowClobber
```

### Příprava účtů

Začněte tím, že naimportujete oba moduly:

```ps
Import-Module AzureRM
Import-Module Azure
```

Poté se přihlašte k Azure v obou modulech:

```ps
Login-AzureRmAccount
Add-AzureAccount
```
Poté zaregistrujte providera pro migraci:

```ps
Register-AzureRmResourceProvider -ProviderNamespace Microsoft.ClassicInfrastructureMigrate
```
Registrace může chvíli trvat. Vyčkejte, dokud není dokončena, což si ověříte následujícím příkazem:

```ps
Get-AzureRmResourceProvider -ProviderNamespace Microsoft.ClassicInfrastructureMigrate
```

Počkejte, dokud hodnota `RegistrationState` nebude `Registered`.

### Vlastní migrace

Nyní jste připraveni zahájit vlastní migraci. V následujícím příkladu budeme migrovat storage account, který se jmenuje `altairis` a nachází se v resource group `GeneralStorage`.

Migrace probíhá ve dvou krocích. Nejprve je nutno ji připravit (`-Prepare`), poté můžete zkontrolovat její výsledky a potvrdit ji (`-Commit`). Příkazy pro obojí v našem případě vypadají takto:

```ps
Move-AzureStorageAccount -Prepare -StorageAccountName "altairis"
Move-AzureStorageAccount -Commit -StorageAccountName "altairis"
```

Tato operace nějakou dobu trvá (v mém případě několik desítek sekund) a po jejím dokončení je účet zmigrován. 

Nicméně v rámci migrace je vytvořena nová resource group, která se jmenuje jako název účtu se suffixem `-Migrated`, v našem případě tedy `altairis-Migrated` jak se lze přesvědčit ve webovém rozhraní portálu:

![](https://www.cdn.altairis.cz/Blog/2018/20180727-portal-2.png)

Pro migraci zpět do původní resource group a odstranění dočasné RG lze použít následující příkaz:

```ps
$resource = Get-AzureRmResource -ResourceGroupName "altairis-Migrated" -ResourceName "altairis"
Move-AzureRmResource -DestinationResourceGroupName "GeneralStorage" -ResourceId $resource.ResourceId
Remove-AzureRmResourceGroup -Name "altairis-Migrated"
```

Změna resource group opět trvá několik desítek sekund. 

Po dokončení migrace uvidíte storage účty v portálu dvakrát. Jednou jako _classic_ a jednou jako nové. Původní _classic_ účty můžete po migraci smazat a ponechat jenom nové, spravované pomocí resource manageru.
