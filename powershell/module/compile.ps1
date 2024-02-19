function compile() {
    # backup profile
    Copy-Item -Force $PROFILE "$($PROFILE)_$(Get-Date -Format 'yy-MM-dd-HH-mm-ss').backup"
    #remove previous profile
    Remove-Item -Force $PROFILE


    Get-Content $env:CONFIG_HOME\powershell\environment\variables.ps1 | Add-Content -Encoding utf8 -Path $PROFILE
    Get-Content $env:CONFIG_HOME\powershell\environment\modules.ps1 | Out-File -Encoding utf8 -Append $PROFILE
    Get-Content $env:CONFIG_HOME\powershell\environment\hooks.ps1 | Add-Content -Encoding utf8 -Path $PROFILE
    Get-Content $env:CONFIG_HOME\powershell\environment\aliases.ps1 | Add-Content -Encoding utf8 -Path $PROFILE



    Get-Content $env:CONFIG_HOME\powershell\addons\completers.ps1 | Add-Content -Encoding utf8 -Path $PROFILE
    Add-Content -Encoding utf8 -Value 'Mount-carapace-Completers' -Path $PROFILE
    if ($Host.Name -notlike '*Visual Studio Code*') {
        Get-Content $env:CONFIG_HOME\powershell/addons/prettypretty.ps1 | Add-Content -Encoding utf8 -Path $PROFILE
    }w
}