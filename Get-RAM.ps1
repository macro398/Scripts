$strComputer = "Maven13"
$colSlots = Get-WmiObject -Class "win32_PhysicalMemoryArray" -namespace "root\CIMV2" `
-computerName $strComputer
$colRAM = Get-WmiObject -Class "win32_PhysicalMemory" -namespace "root\CIMV2" `
-computerName $strComputer

Foreach ($objSlot In $colSlots){
     "Total Number of DIMM Slots: " + $objSlot.MemoryDevices
}
Foreach ($objRAM In $colRAM) {
     "Memory Installed: " + $objRAM.DeviceLocator
     "Memory Size: " + ($objRAM.Capacity / 1GB) + " GB"
}
 [math]::Round((Get-WmiObject -Class Win32_ComputerSystem  -computer $strComputer).TotalPhysicalMemory/1GB)

(Get-Counter -Counter "\Memory\Available MBytes" -ComputerName $strComputer).CounterSamples[0].CookedValue
