﻿Get-ChildItem C:\Workspace\Courseware\BTDI16\LabDocs\BTDI13_*.docx  |Rename-Item -NewName {$_.name -replace '^BTDI13','BTDI16'}