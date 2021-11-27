###Insert the name of the computer you want to import to and replace Student01
###or you can replace Student01 with a text document as shown below. (only one computer per line)
$ComputerName = "Student01"
#$ComputerName = C:\list.txt
$ComputerName|Foreach-Object
    {
    ###Make sure to set the paths to work for your network. Note that parts of these will change for each image, I recommend multiple versions.
    ###This also asumes that you are sharing out a folder named VM on the computers you are wanting to run class on.
    copy-item -Path \\quicklearn\15.03.26.01.0015\ -Destination \\$ComputerName\VM -Recurse
    (get-item 'D:\VM\15.03.26.01.0015\BTS2013-Developer\Virtual Machines\*').fullname|Import-VM
    Connect-VMNetworkAdapter -VMName BTS2013-Developer -SwitchName External
    ###Attaches the student files as a DVD drive.
    Set-VMDvdDrive -VMName BTS2013-Developer -Path D:\VM\15.03.26.01.0015\Student\BTDD.iso
    Start-VM -VMName BTS2013-Developer
    }