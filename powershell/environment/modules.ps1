<#
.##.....##..#######..########..##.....##.##.......########..######.
.###...###.##.....##.##.....##.##.....##.##.......##.......##....##
.####.####.##.....##.##.....##.##.....##.##.......##.......##......
.##.###.##.##.....##.##.....##.##.....##.##.......######....######.
.##.....##.##.....##.##.....##.##.....##.##.......##.............##
.##.....##.##.....##.##.....##.##.....##.##.......##.......##....##
.##.....##..#######..########...#######..########.########..######.
#>
Write-Host 'setting up modules...' -NoNewline

Import-Module Terminal-Icons
Import-Module scoop-completion
# adds gsudo !! to elevate last command
Import-Module gsudoModule
Import-Module Set-PsEnv

Import-Module myMod
# Import-Module -Name "${ENV:HOMEDRIVE}${ENV:HOMEPATH}\.config\powershell\module\mymod"
# $env:PSModulePath += ";${env:config_home}\powershell"

#34de4b3d-13a8-4540-b76d-b9e8d3851756 PowerToys CommandNotFound module
Import-Module "$(scoop config root_path)\apps\powertoys\current\WinUI3Apps\..\WinGetCommandNotFound.psd1"

Write-Host '✅'