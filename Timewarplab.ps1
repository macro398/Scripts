$listofip=get-content C:\Scripts\timewarp.txt
$credentials=get-credential
$servers=get-content C:\Scripts\TWServers.txt
#this assumes that you have already run {set-item wsman:\localhost\client\trustedhosts -value "*" -Force}
foreach($ip in $listofip)
    {
    $vmname=get-vm -computername $servers | select -ExpandProperty networkadapters | select vmname, ipaddresses, computername|where ipaddresses -eq $ip|select vmname,computername
    Restore-VMSnapshot -ComputerName $vmname.ComputerName -VMName $vmname.VMName -Name "First Day Checkpoint" -Confirm:$false
    }