$list = get-content C:\Scripts\list.txt
Foreach ($computer in $list){
    invoke-command -ComputerName $computer -ScriptBlock {
        $pass = "Logan1992"
        $a = New-ScheduledTaskAction -Execute "\\mc-pc\MDTProduction$\Scripts\Litetouch.vbs"
        $t = New-ScheduledTaskTrigger -once -At "7/4/2016 1am"
        $s = New-ScheduledTaskSettingsSet
        Register-ScheduledTask -Action $a -Trigger $t -TaskName "upgrade" -Description "Upgrade to windows 10" -user corp\mcronk -password $pass -RunLevel Highest
    }
}