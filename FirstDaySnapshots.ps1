Remove-Module Hyper-V
Import-Module Hyper-V -RequiredVersion 1.1

$Servers=get-content "C:\Users\mcronk\OneDrive - QuickLearn Training Inc\Documents\Scripts\Servers.lst"
$Servers|ForEach-Object `
    {
    $VM=Get-VM -ComputerName $Servers
    $VM|ForEach-Object `
        {
        $Snapshot=$_|Get-VMSnapshot -name "First Day Checkpoint"
        if (!$Snapshot)
           {
           $_|checkpoint-vm -SnapshotName "First Day Checkpoint"    
           }
        }
    }