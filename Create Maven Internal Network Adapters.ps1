$d = "A","B","C","D","E","F","G","H","I","J"
foreach($i in $d)
{
$name = "Hyper-V Internal - " + $i
New-VMSwitch -name $name -SwitchType Internal
}