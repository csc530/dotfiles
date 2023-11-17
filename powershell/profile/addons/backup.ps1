& "$PSScriptRoot/addons/functions.ps1"

<#
..######..##....##..######..########.########.##.....##....########.....###.....######..##....##.##.....##.########.
.##....##..##..##..##....##....##....##.......###...###....##.....##...##.##...##....##.##...##..##.....##.##.....##
.##.........####...##..........##....##.......####.####....##.....##..##...##..##.......##..##...##.....##.##.....##
..######.....##.....######.....##....######...##.###.##....########..##.....##.##.......#####....##.....##.########.
.......##....##..........##....##....##.......##.....##....##.....##.#########.##.......##..##...##.....##.##.......
.##....##....##....##....##....##....##.......##.....##....##.....##.##.....##.##....##.##...##..##.....##.##.......
..######.....##.....######.....##....########.##.....##....########..##.....##..######..##....##..#######..##.......
#>

Write-Colour 'backing system up...' -Color DarkCyan

<#
d8888b.  .d8b.   .o88b. db   dD  .d8b.   d888b  d88888b .d8888.
88  `8D d8' `8b d8P  Y8 88 ,8P' d8' `8b 88' Y8b 88'     88'  YP
88oodD' 88ooo88 8P      88,8P   88ooo88 88      88ooooo `8bo.
88~~~   88~~~88 8b      88`8b   88~~~88 88  ooo 88~~~~~   `Y8b.
88      88   88 Y8b  d8 88 `88. 88   88 88. ~8~ 88.     db   8D
88      YP   YP  `Y88P' YP   YD YP   YP  Y888P  Y88888P `8888Y'
#>

<#
           _                  _
 __      _(_)_ __   __ _  ___| |_
 \ \ /\ / / | '_ \ / _` |/ _ \ __|
  \ V  V /| | | | | (_| |  __/ |_
   \_/\_/ |_|_| |_|\__, |\___|\__|
                   |___/
#>
Write-Colour 'exporting winget packages...' -Color Yellow
winget export -o $env:CONFIG_HOME\packages\winget\packages.json
Write-Colour 'export complete' -Color Green

<#
  ___  ___ ___   ___  _ __
 / __|/ __/ _ \ / _ \| '_ \
 \__ \ (_| (_) | (_) | |_) |
 |___/\___\___/ \___/| .__/
                     |_|
#>
Write-Colour 'exporting scoop packages...' -Color Yellow
scoop export -c > $env:CONFIG_HOME\packages\scoop\packages.json
Write-Colour 'export complete' -Color Green

<#
  _ __  _ __  _ __ ___
 | '_ \| '_ \| '_ ` _ \
 | | | | |_) | | | | | |
 |_| |_| .__/|_| |_| |_|
       |_|
#>
Write-Colour 'exporting npm packages...' -Color Yellow
Export-Npm | Out-File -FilePath $env:CONFIG_HOME\packages\npm\packages.txt -InputObject $pckgList -Encoding utf8 -Force
Write-Colour 'export complete' -Color Green

Write-Colour 'backing up .npmrc...' -Color Yellow
Copy-Item $env:HOME\.npmrc $env:CONFIG_HOME\npm\.npmrc
Write-Colour 'backup complete' -Color Green

<#
        _ _       _          __  __
   __ _(_) |_ ___| |_ _   _ / _|/ _|
  / _` | | __/ __| __| | | | |_| |_
 | (_| | | |_\__ \ |_| |_| |  _|  _|
  \__, |_|\__|___/\__|\__,_|_| |_|
  |___/
#>
Write-Colour 'backing up .gitconfig...' -Color Yellow
Copy-Item $env:HOME\.gitconfig $env:CONFIG_HOME\git\.gitconfig
Write-Colour 'backup complete' -Color Green

<#
           _           _                     _                      _             _
 __      _(_)_ __   __| | _____      _____  | |_ ___ _ __ _ __ ___ (_)_ __   __ _| |
 \ \ /\ / / | '_ \ / _` |/ _ \ \ /\ / / __| | __/ _ \ '__| '_ ` _ \| | '_ \ / _` | |
  \ V  V /| | | | | (_| | (_) \ V  V /\__ \ | ||  __/ |  | | | | | | | | | | (_| | |
   \_/\_/ |_|_| |_|\__,_|\___/ \_/\_/ |___/  \__\___|_|  |_| |_| |_|_|_| |_|\__,_|_|

#>
Write-Colour 'backing up windows terminal settings...' -Color Yellow

Write-Colour 'saving preview settings...'

Write-Colour 'system backup complete' -Color DarkCyan