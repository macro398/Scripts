$list=get-content C:\Scripts\list.txt
$cred2=Get-Credential corp\mcronk
ForEach ($computer in $list)
{
Invoke-Command -ComputerName $computer -Credential $cred2 -ScriptBlock {
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All -NoRestart
Restart-Computer
}
}
Start-sleep -s 150
ForEach ($computer in $list)
{
Invoke-Command -ComputerName $computer -Credential $cred2 -ScriptBlock {
Resize-Partition -DiskNumber 0 -PartitionNumber 2 -Size (40GB)
New-Partition -DiskNumber 0 -UseMaximumSize -DriveLetter D
Format-Volume -DriveLetter D -FileSystem NTFS -Force
New-SmbShare -name D -path D:\ -FullAccess Everyone
}
}
Start-Sleep -s 30
ForEach ($computer in $list)
{
invoke-command -computername $computer -credential $cred2 -scriptblock {
net localgroup administrators /add corp\Student
}
}