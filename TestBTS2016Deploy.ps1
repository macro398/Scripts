#Parameters
$urlOfUploadedImageVhd = "https://qlvmstorage.blob.core.windows.net/images/BTDF13.vhd"
$rgName = "SelfPaced-VM"
$vmName = "BTDF13"
$SAName = "qlvmstorage"
$computerName = "BTDF13"
$vmSize = "Standard_DS1_v2"
$location = "West US 2" 
$imageName = "BTDF13"
$localvhd = "D:\BTDF2013R2-KIRKLAND-Base.vhd"

#Upload VHD
Add-AzureRmVhd -ResourceGroupName $rgName -Destination $urlOfUploadedImageVhd `
   -LocalFilePath $localvhd -OverWrite

$imageConfig = New-AzureRmImageConfig -Location $location
$imageConfig = Set-AzureRmImageOsDisk -Image $imageConfig -OsType Windows -OsState Generalized -BlobUri $urlOfUploadedImageVhd
$image = New-AzureRmImage -ImageName $imageName -ResourceGroupName $rgName -Image $imageConfig