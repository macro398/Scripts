#Login to Azure
$appId = "[app id]"
$password = ConvertTo-SecureString "[password]" -AsPlainText -Force
$tenantid = "[tenant id]"
$credential = New-Object System.Management.Automation.PSCredential($appId, $password)
Login-AzureRmAccount -Credential $credential -ServicePrincipal -TenantId $tenantid

#Variables
$SA = "qlvm"
$SAkey = "[SA key]"
$context = new-azurestoragecontext -StorageAccountName $SA -StorageAccountKey $SAkey
$rgName = "rg-" + $guid

Remove-AzureRmResourceGroup -Name $rgName -force
#Clean up the Storage account
Get-AzureStorageBlob -Context $context -Container vhds -blob "vm-$guid*" | Remove-AzureStorageBlob -Force
