$list=get-content C:\scripts\list.txt
$credentials=get-credential
foreach ($computer in $list){
invoke-command -computer $computer -Credential $credentials -scriptblock {
C:\areader.exe /sall
$net = get-netadapter -name 'Ethernet'
New-VMSwitch -name "Hyper-V External" -AllowManagementOS $True -NetAdapterName $net.Name
New-VMSwitch -name "Hyper-V Internal - A" -SwitchType Internal}
}