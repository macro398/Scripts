#Login to Azure
$appId = "[app id]"
$password = ConvertTo-SecureString "[password]" -AsPlainText -Force
$tenantid = "[tenant id]"
$credential = New-Object System.Management.Automation.PSCredential($appId, $password)
Login-AzureRmAccount -Credential $credential -ServicePrincipal -TenantId $tenantid

# POST method: $req
#$requestBody = Get-Content $req -Raw | ConvertFrom-Json
#$guid = $requestBody.guid
$guid = "[guid]"

$ipName = "ip-" + $guid
$rgName = "rg-" + $guid
#Get Public IP Address
$pubIp = Get-AzureRmPublicIpAddress -Name $ipName -ResourceGroupName $rgName

#Response
Out-File -Encoding Ascii -FilePath $res -inputObject "{ 'pubIp' : '$pubIp' }"
