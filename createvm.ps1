# POST method: $req
$requestBody = Get-Content $req -Raw | ConvertFrom-Json
$guid = $requestBody.guid
$osDiskUri = $requestBody.osDiskUri
$location = "South Central US"
$osDiskName = "dn-" + $guid
$computerName = "cname-" + $guid
$vmName = "vm-" + $guid
$vmSize = "Standard_D2_v2"
$user = "Student"
$imageURI = "[image url]"
$rgName = "rg-" + $guid
$nic = Get-AzureRmNetworkInterface -Name nic-$guid -ResourceGroupName $rgName
$pw = ConvertTo-SecureString "[password]" -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential($user, $pw)
$vmConfig = New-AzureRmVMConfig -VMName $vmName -VMSize $vmSize
$vm = Set-AzureRmVMOperatingSystem -VM $vmConfig -Windows -ComputerName $computerName -Credential $cred -ProvisionVMAgent -EnableAutoUpdate
$vm = Add-AzureRmVMNetworkInterface -VM $vm -Id $nic.Id
$vm = Set-AzureRmVMOSDisk -VM $vm -Name $osDiskName -VhdUri $osDiskUri -CreateOption FromImage -SourceImageUri $imageURI -Windows
New-AzureRmVM -ResourceGroupName $rgName -Location $location -VM $vm

#Get Public IP Address
$pubIp = Get-AzureRmPublicIpAddress -Name $ipName -ResourceGroupName $rgName

#Response
Out-File -Encoding Ascii -FilePath $res -inputObject "$pubIp"
