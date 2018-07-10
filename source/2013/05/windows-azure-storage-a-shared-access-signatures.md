<!-- dcterms:identifier = aspnetcz#3411 -->
<!-- dcterms:title = Windows Azure Storage a Shared Access Signatures -->
<!-- dcterms:abstract = Původně úložiště Windows Azure Storage neumožňovalo příliš jemné nastavení přístupových práv: data mohla být buďto veřejná, takže k nim mohl kdokoliv, nebo soukromá, takže k nim nemohl nikdo, kdo neznal klíč k úložišti. A zase pokud ho znal, mohl s ním dělat cokoliv. Již zhruba rok nicméně Azure umí takzvané Shared Access Signatures, tedy technologii, která umí přístup omezit operacemi nebo časově. -->
<!-- np9:categoryId = 2 -->
<!-- x4w:category = Bezpečnost -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2013-05-03T22:41:54.95+02:00 -->
<!-- dcterms:dateAccepted = 2013-05-06T08:00:00+02:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20130506-windows-azure-storage-a-shared-access-signatures.png -->

Původně úložiště Windows Azure Storage neumožňovalo příliš jemné nastavení přístupových práv: data mohla být buďto veřejná, takže k nim mohl kdokoliv, nebo soukromá, takže k nim nemohl nikdo, kdo neznal klíč k úložišti. A zase pokud ho znal, mohl s ním dělat cokoliv. Již zhruba rok nicméně Azure umí takzvané Shared Access Signatures, tedy technologii, která umí přístup omezit operacemi nebo časově.

Princip je jednoduchý: vygenerujete speciální URL, která obsahuje informace o povolených oprávněních (typu číst, zapisovat…) a době, po kterou platí. Tyto údaje potom podepíšete pomocí HMAC a jako klíč použijete přístupový klíč k úložišti. Detailní postup je popsán [v dokumentaci](http://msdn.microsoft.com/en-us/library/windowsazure/hh508996.aspx), nicméně následující příklady předpokládají použití klientské knihovny pro .NET (NuGet: *WindowsAzure.Storage*), která vše provede za vás.

Máte na výběr ze dvou možností: přímé získání SAS, nebo navázání na pojmenovanou politiku.

## Přímé získání SAS

Získání SAS přímo je jednoduché. Nad konkrétní položkou (kontajnerem, blobem, frontou, tabulkou…) zavoláte metodu *GetSharedAccessSignature* a specifikujete oprávnění a (volitelně) začátek a konec časové platnosti. Pokud budete například chtít vytvořit k nějakému blobu odkaz na stažení, který bude platit tři dny, můžete postupovat následujícím způsobem:

    var account = CloudStorageAccount.DevelopmentStorageAccount;
    var client = account.CreateCloudBlobClient();
    var container = client.GetContainerReference("sasdemo");
    var blob = container.GetBlockBlobReference("test.txt");
    var sasToken = blob.GetSharedAccessSignature(new SharedAccessBlobPolicy {
        Permissions = SharedAccessBlobPermissions.Read,
        SharedAccessExpiryTime = DateTime.Today.AddDays(3)
    });
    var secureUriBuilder = new UriBuilder(blob.Uri) {
        Query = sasToken.Trim('?')
    };
    var secureUri = secureUriBuilder.Uri;

Kdokoliv bude znát adresu *secureUri* bude mít read-only přístup k danému blobu, ale jenom po nejbližší tři dny, pak odkaz přestane být funkční.

Získání tohoto typu je jednoduché, k jednomu objektu těchto URL může být neomezené množství (protože ta URL se nikde neukládají, jenom se ověři podpis). Nevýhodou je, že jakmile takové URL jednou dáte "z ruky", nelze jej už nijak vzít zpět, jedinou možností by bylo změnit přístupový klíč k celému úložišti.

## Získání prostřednictvím politiky

Druhá možnost je, že nejprve na úrovni kontajneru vytvoříte pojmenovanou politiku a poté se na ni při generování SAS odkážete. Kód, který to provádí, vypadá takto:

    var account = CloudStorageAccount.DevelopmentStorageAccount;
    var client = account.CreateCloudBlobClient();
    var container = client.GetContainerReference("sasdemo");
    var perms = container.GetPermissions();
    if (!perms.SharedAccessPolicies.ContainsKey("MojePolicy")) {
        perms.SharedAccessPolicies.Add("MojePolicy", new SharedAccessBlobPolicy {
            Permissions = SharedAccessBlobPermissions.Read,
            SharedAccessExpiryTime = DateTime.Today.AddDays(3)
        });
        container.SetPermissions(perms);
    }
    var blob = container.GetBlockBlobReference("test.txt");
    var sasToken = blob.GetSharedAccessSignature(null, "MojePolicy");
    var secureUriBuilder = new UriBuilder(blob.Uri) {
        Query = sasToken.Trim('?')
    };
    var secureUri = secureUriBuilder.Uri;

Výhodou tohoto přístupu je, že takto získané adresy lze snadno revokovat – stačí odstranit příslušnou politiku. Nevýhodou je, že v rámci jednoho kontajneru lze takových politik definovat nejvýše pět, což je podle mého názoru omezení dosti nepříjemné.

## Závěrečné demo

Níže uvedený kód představuje kompletní program (konzolovou aplikaci), která umožní si se SAS hrát dle libosti. Všechno sice předvádím na blobech, ale shared access signatures lze použít i pro fronty a tabulky.

    using System;
    using System.IO;
    using Microsoft.WindowsAzure.Storage;
    using Microsoft.WindowsAzure.Storage.Blob;

    namespace Altairis.Waya.Poc.SasDemo {

        internal class Program {

            private static void Main(string[] args) {
                // Create account in local emulator
                Console.WriteLine("Creating storage account...");
                var account = CloudStorageAccount.DevelopmentStorageAccount;
                var client = account.CreateCloudBlobClient();

                // Get or create container
                Console.WriteLine("Get or create container...");
                var container = client.GetContainerReference("sasdemo");
                container.CreateIfNotExists();

                // Get or create blob
                Console.WriteLine("Get or create blob...");
                var blob = container.GetBlockBlobReference("test.txt");
                if (!blob.Exists()) {
                    Console.WriteLine("Creating blob...");
                    blob.Properties.ContentType = "text/plain";
                    blob.Properties.CacheControl = "private, max-age=31536000"; // 1 year

                    var testData = System.Text.Encoding.UTF8.GetBytes("This is just a test only.");
                    using (var ms = new MemoryStream(testData)) {
                        blob.UploadFromStream(ms);
                    }
                }

                // Get SAS token directly
                Console.WriteLine();
                Console.WriteLine("SAS URL:");
                var sasToken = blob.GetSharedAccessSignature(new SharedAccessBlobPolicy {
                    Permissions = SharedAccessBlobPermissions.Read,
                    SharedAccessExpiryTime = DateTime.Today.AddDays(3)
                });
                Console.WriteLine(blob.Uri + sasToken);
                Console.WriteLine();

                // Get or create policy
                var policyId = "Policy_" + Guid.NewGuid().ToString("N").Substring(0, 20);
                var perms = container.GetPermissions();
                if (!perms.SharedAccessPolicies.ContainsKey(policyId)) {
                    if (perms.SharedAccessPolicies.Count == 5) {
                        // Policy table full
                        Console.WriteLine("Can't create new policy - maximum count exceeded.");
                        policyId = null;
                    }
                    else {
                        // Create new
                        Console.WriteLine("Creating new Shared Access Policy '{0}'", policyId);
                        perms.SharedAccessPolicies.Add(policyId, new SharedAccessBlobPolicy {
                            Permissions = SharedAccessBlobPermissions.Read,
                            SharedAccessExpiryTime = DateTime.Today.AddDays(3)
                        });
                        container.SetPermissions(perms);
                    }
                }
                else {
                    Console.WriteLine("Found existing Shared Access Policy '{0}'", policyId);
                }

                // Get SAS token via policy
                if (!string.IsNullOrEmpty(policyId)) {
                    Console.WriteLine();
                    Console.WriteLine("SAP URL:");
                    var sapToken = blob.GetSharedAccessSignature(null, policyId);
                    Console.WriteLine(blob.Uri.ToString() + sapToken);
                }

                // Delete container
                Console.WriteLine("Press ENTER...");
                Console.ReadLine();

                Console.WriteLine("Deleting container...");
                container.Delete();
            }
        }
    }