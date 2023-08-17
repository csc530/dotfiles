<#
.##.....##..#######...#######..##....##..######.
.##.....##.##.....##.##.....##.##...##..##....##
.##.....##.##.....##.##.....##.##..##...##......
.#########.##.....##.##.....##.#####.....######.
.##.....##.##.....##.##.....##.##..##.........##
.##.....##.##.....##.##.....##.##...##..##....##
.##.....##..#######...#######..##....##..######.
#>
Write-Information "`rSetting up hooks..."

# scoop search - faster than default speedup
Invoke-Expression (&scoop-search --hook)
zoxide init powershell | Out-String | Invoke-Expression

Write-Information "`rfinished setting up hooks"