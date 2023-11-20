<#
.##.....##..#######..########..##.....##.##.......########..######.
.###...###.##.....##.##.....##.##.....##.##.......##.......##....##
.####.####.##.....##.##.....##.##.....##.##.......##.......##......
.##.###.##.##.....##.##.....##.##.....##.##.......######....######.
.##.....##.##.....##.##.....##.##.....##.##.......##.............##
.##.....##.##.....##.##.....##.##.....##.##.......##.......##....##
.##.....##..#######..########...#######..########.########..######.
#>
Write-Host "setting up modules..."

Import-Module Terminal-Icons
Import-Module scoop-completion
# adds gsudo !! to elevate last command
Import-Module gsudoModule
Import-Module Set-PsEnv

Import-Module "${env:HOMEPATH}/.config/powershell/module/module.psd1"
# $env:PSModulePath += ";${env:config_home}\powershell"

Write-Host "finished setting up modules ✅"