<!-- dcterms:title = Skripty pro rychlé vytváření VM a App Services v Azure -->
<!-- dcterms:abstract = Spravovat Microsoft cloud z Bashe může někomu připadat jako svatokrádež, ale mně se Azure CLI líbí moc. Rozhodně víc, než webové rozhraní, které je typická moderní webová aplikace dneška - pomalá, nespolehlivá a každý týden jiná. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:coverUrl = /cover-pictures/20191114-cloud-scripts.jpg -->
<!-- x4w:coverCredits = Dennis Amith via Flickr, CC by-nc -->
<!-- x4w:pictureUrl = /perex-pictures/logo-azure-appservices.svg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:category = IT -->
<!-- dcterms:dateAccepted = 2019-11-14 -->

Mám rád cloudové prostředí Microsoft Azure. Umožňuje mi dělat co chci a ne se starat o infrastrukturu, kterou sice nechci, ale musím ji mít. Nelíbí se mi ale [webový portál pro správu](https://portal.azure.com). Je to typická moderní aplikace dnešní doby: křehká květinka plná JavaScriptu, která se zakucká při sebemenší chybyčce ve spojení a o co je nepřehlednější, o to je pomalejší. Navíc se mění pod rukama a co platilo tento týden, neplatí dnes.

Naštěstí je k dispozici _Azure CLI_ (Command Line Interface) a příkazová řádka na webu, [_Azure Cloud Shell_](https://shell.azure.com). A v tomto shellu lze spouštět bashové skripty. Spravovat Microsoft cloud z Bashe může někomu připadat jako svatokrádež, ale mně se Azure CLI líbí moc. A rozhodně jsem s ním více mentálně kompatibilní než s jeho PowerShell verzí.

## Skript pro vytvoření virtuálního počítače

Následující skript po spuštění vytvoří virtuální server (VM) s Windows 2022 Datacenter. Vytvoří vlastní resource group s náhodně vygenerovaným jménem (`Test-XXXXXXXXXX` kde `X` jsou náhodně vygenerované šestnáctkové číslice `0-f`) a VM s podobným jménem (`testXXXXXXXXXX`). VM bude mít povolené porty `80` (HTTP), `443` (HTTPS), `3389` (RDP) a `8172` (Web Management Service). Bude mít rozumnou velikost `B2ms` (2 cores, 8 GB RAM) a bude vytvořena v regionu `EastUS`, který je dlouhodobě nejlevnější. Bude vytvořen správcovský účet `Developer` s náhodně vygenerovaným heslem.

Veškeré parametry můžete upravit snadnou editací záhaví skriptu.

Takto skript vypadá:

```bash
#!/bin/bash

# Configuration
SUFFIX=$(openssl rand -hex 5)
RG_NAME=Test-$SUFFIX
NSG_NAME=Test-$SUFFIX-NSG
REGION=EastUS
SIZE=Standard_B2ms
IMAGE=win2022datacenter
VM_NAME=test$SUFFIX
USER_NAME=Developer
USER_PASS=$(openssl rand -base64 18 | sed "s|[+/]|x|g")

# Display intentions and ask user if they want to proceed
echo "This will create the following Windows VM:"
echo "  Name:           $VM_NAME.$REGION.cloudapp.azure.com"
echo "  User:           $USER_NAME"
echo "  Password:       $USER_PASS"
echo "  Region:         $REGION"
echo "  Resource Group: $RG_NAME"
echo
read -p "Do you want to continue (y/n)? " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

# Create resource group
echo "Creating the resource group..."
az group create -n $RG_NAME -l $REGION

# Create network security group
echo "Creating NSG in $REGION region..."
az network nsg create -g $RG_NAME -n $NSG_NAME -l $REGION

# Create firewall rules for RDP, HTTP, HTTPS and WMSvc
echo "Creating RDP rule..."
az network nsg rule create -g $RG_NAME --nsg-name $NSG_NAME --priority 1000 \
                           --destination-port-ranges 3389 -n RDP
echo "Creating HTTP rule..."
az network nsg rule create -g $RG_NAME --nsg-name $NSG_NAME --priority 1001 \
                           --destination-port-ranges 80 -n HTTP
echo "Creating HTTPS rule..."
az network nsg rule create -g $RG_NAME --nsg-name $NSG_NAME --priority 1002 \
                           --destination-port-ranges 443 -n HTTPS
echo "Creating WMSvc rule..."
az network nsg rule create -g $RG_NAME --nsg-name $NSG_NAME --priority 1003 \
                           --destination-port-ranges 8172 -n WMSvc

# Create virtual machine
echo "Creating virtual machine..."
az vm create -n $VM_NAME -g $RG_NAME \
             --admin-username $USER_NAME --admin-password $USER_PASS \
             --image $IMAGE --size $SIZE \
             --nsg $NSG_NAME -l $REGION \
             --public-ip-sku Standard \
             --public-ip-address-dns-name $VM_NAME

# Display results
echo "The following virtual machine has been created:"
echo "  Name:           $VM_NAME.$REGION.cloudapp.azure.com"
echo "  User:           $USER_NAME"
echo "  Password:       $USER_PASS"
echo "  Region:         $REGION"
echo "  Resource Group: $RG_NAME"
```

## Skript pro vytvoření App Service a databáze

Z podobného vrhu je druhý skript, který vytvoří nikoliv VM, ale App Service - tedy website. Vytvoří nový App Service Plan a v něm novou website. K ní vytvoří stejnojmenný SQL server a databázi. Connection string bude přidán do nastavení App Service se jménem `DefaultConnectionString`. Název bude automaticky náhodně vygenerován, stejně jako vlastní resource group.

Zdrojový kód vypadá takto:

```bash
#!/bin/bash

SUFFIX=$(openssl rand -hex 5)
RG_NAME=Test-$SUFFIX
REGION=EastUS
PLAN_NAME=TestPlan-$SUFFIX
PLAN_SKU=B1
APPSERVICE_NAME=Test$SUFFIX
SQL_SERVER=test$SUFFIX
SQL_USER=test$SUFFIX
SQL_PASSWORD=$(openssl rand -base64 18 | sed "s|[+/]|x|g")
SQL_DB=test$SUFFIX

# Display intentions and ask user if they want to proceed
echo "This will create the following Windows App Service:"
echo "  Name:           $APPSERVICE_NAME.azurewebsites.net"
echo "  Region:         $REGION"
echo "  Resource Group: $RG_NAME"
echo "  SQL Server:     $SQL_SERVER.database.windows.net"
echo "  SQL Database:   $SQL_DB"
echo "  SQL User:       $SQL_USER"
echo "  SQL Password:   $SQL_PASSWORD"
echo
read -p "Do you want to continue (y/n)? " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

# Create resource group
echo "Creating the resource group..."
az group create -n $RG_NAME -l $REGION

# Create app service plan
echo "Creating appservice plan..."
az appservice plan create -g $RG_NAME -n $PLAN_NAME -l $REGION --sku $PLAN_SKU

# Create app service (website)
az webapp create -g $RG_NAME -p $PLAN_NAME -n $APPSERVICE_NAME

# Create SQL server
az sql server create -g $RG_NAME -n $SQL_SERVER -l $REGION \
    --admin-user $SQL_USER --admin-password $SQL_PASSWORD

# Allow access from Azure services
az sql server firewall-rule create -g $RG_NAME -s $SQL_SERVER \
    -n AllowAzureServices --start-ip-address 0.0.0.0 --end-ip-address 0.0.0.0

# Create database
az sql db create -g $RG_NAME -s $SQL_SERVER -n $SQL_DB --collation Czech_CI_AI

# Show connection string
az sql db show-connection-string -s $SQL_SERVER -n $SQL_DB -c ado.net

# Assign connection string to web app
az webapp config connection-string set -g $RG_NAME -n $APPSERVICE_NAME -t SQLAzure \
    --settings DefaultConnection="Server=tcp:$SQL_SERVER.database.windows.net,1433;Database=$SQL_DB;User ID=$SQL_USER;Password=$SQL_PASSWORD;Encrypt=true;Connection Timeout=30;"

# Display result
echo "The following Windows App Service has been created:"
echo "  Name:           $APPSERVICE_NAME.azurewebsites.net"
echo "  Region:         $REGION"
echo "  Resource Group: $RG_NAME"
echo "  SQL Server:     $SQL_SERVER.database.windows.net"
echo "  SQL Database:   $SQL_DB"
echo "  SQL User:       $SQL_USER"
echo "  SQL Password:   $SQL_PASSWORD"
```

## Jak skripty používat

Oba dva skripty najdete [na mém GitHubu](https://github.com/ridercz/Scripts/tree/master/Azure). Můžete je použít buďto v Azure Cloud Shellu nebo kdekoliv, kde máte Azure CLI a Bash, například v Linux Subsystému ve Windows 10.