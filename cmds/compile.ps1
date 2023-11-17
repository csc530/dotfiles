# backup profile
Copy-Item -Force $PROFILE "$($PROFILE)_$(Get-Date -Format 'yy-MM-dd-HH-mm-ss').backup"
#remove previous profile
Remove-Item -Force $PROFILE

Get-ChildItem "${env:config_home}\powershell/environment/*.ps1" | ForEach-Object { Get-Content $_.FullName | Out-String | Out-File -Append -Encoding utf8 -FilePath $PROFILE }
Get-ChildItem "${env:config_home}/powershell/addons/*.ps1" | ForEach-Object { Get-Content $_.FullName | Out-String | Out-File -Append -Encoding utf8 -FilePath $PROFILE }

'Mount-carapace-Completers
#carapace _carapace | Out-String | Invoke-Expression
Invoke-Expression -Command screenfetch' | Out-String | Out-File -Append -Encoding utf8 -FilePath $PROFILE