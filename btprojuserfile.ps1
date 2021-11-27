foreach ($lab in (Get-ChildItem|where Name -NE Deployment|select -ExpandProperty Name)){
    $paths = Get-Childitem $lab -recurse | where extension -Contains .btproj|select -ExpandProperty FullName
    foreach ($path in $paths){
        
        $userfile=$path + ".user"
        $filecontent=get-content D:\DR.US.Messaging.btproj.user
        new-item $userfile -type "file" -force -value "$filecontent"
        (get-content $userfile).replace('Encryption',$lab)|set-content $userfile
    }
}