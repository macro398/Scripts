$requestBody = Get-Content $req -Raw | ConvertFrom-Json

#Parameters
$guid = [guid]::NewGuid().ToString().Substring(0,8)
$subnetName = "sn-" + $guid
$vnetName = "vn-" + $guid
$nsgName = "nsg-" + $guid
$nicName = "nic-" + $guid
$ipName = "ip-" + $guid
$rgName = "rg-" + $guid
$location = "South Central US"
$storageAccName = "qlvm"
$skuName = "Standard_LRS"
$ImageRG = "SelfPaced-VM"

#Login to Azure
$appId = "[app ID]"
$password = ConvertTo-SecureString "[password]" -AsPlainText -Force
$tenantid = "[tennant ID]"
$credential = New-Object System.Management.Automation.PSCredential($appId, $password)
Login-AzureRmAccount -Credential $credential -ServicePrincipal -TenantId $tenantid

#Create Resource Group
New-AzureRmResourceGroup -Name $rgName -Location $location

#Create VM
$singleSubnet = New-AzureRmVirtualNetworkSubnetConfig -Name $subnetName -AddressPrefix 10.0.0.0/24
$vnet = New-AzureRmVirtualNetwork -Name $vnetName -ResourceGroupName $rgName -Location $location -AddressPrefix 10.0.0.0/16 -Subnet $singleSubnet
$pip = New-AzureRmPublicIpAddress -Name $ipName -ResourceGroupName $rgName -Location $location -AllocationMethod Dynamic
$nic = New-AzureRmNetworkInterface -Name $nicName -ResourceGroupName $rgName -Location $location -SubnetId $vnet.Subnets[0].Id -PublicIpAddressId $pip.Id
$rdpRule = New-AzureRmNetworkSecurityRuleConfig -Name myRdpRule -Description "Allow RDP" -Access Allow -Protocol Tcp -Direction Inbound -Priority 110 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 3389
$nsg = New-AzureRmNetworkSecurityGroup -ResourceGroupName $rgName -Location $location -Name $nsgName -SecurityRules $rdpRule -force
$vnet = Get-AzureRmVirtualNetwork -ResourceGroupName $rgName -Name $vnetName
$storageAcc = Get-AzureRmStorageAccount -ResourceGroupName $ImageRG -AccountName $storageAccName
$osDiskUri = '{0}vhds/{1}-{2}.vhd' -f $storageAcc.PrimaryEndpoints.Blob.ToString(), $vmName.ToLower(), $osDiskName

$location = "South Central US"
$osDiskName = "dn-" + $guid
$computerName = "cname-" + $guid
$vmName = "vm-" + $guid
$vmSize = "Standard_D2_v2"
$user = "Student"
$imageURI = "[source image url]"
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
