<#
.##.....##..#######..########..##.....##.##.......########..######.
.###...###.##.....##.##.....##.##.....##.##.......##.......##....##
.####.####.##.....##.##.....##.##.....##.##.......##.......##......
.##.###.##.##.....##.##.....##.##.....##.##.......######....######.
.##.....##.##.....##.##.....##.##.....##.##.......##.............##
.##.....##.##.....##.##.....##.##.....##.##.......##.......##....##
.##.....##..#######..########...#######..########.########..######.
#>
Import-Module scoop-completion
Import-Module Terminal-Icons
# adds gsudo !! to elevate last command
Import-Module D:\Appdata\Scoop\apps\gsudo\2.0.10\gsudoModule.psd1

<#
..######...#######..##.....##.########..##.......########.########.########.########...######.
.##....##.##.....##.###...###.##.....##.##.......##..........##....##.......##.....##.##....##
.##.......##.....##.####.####.##.....##.##.......##..........##....##.......##.....##.##......
.##.......##.....##.##.###.##.########..##.......######......##....######...########...######.
.##.......##.....##.##.....##.##........##.......##..........##....##.......##...##.........##
.##....##.##.....##.##.....##.##........##.......##..........##....##.......##....##..##....##
..######...#######..##.....##.##........########.########....##....########.##.....##..######.
#>
# volta completions: javascript tool manager
(& volta completions powershell) | Out-String | Invoke-Expression
# my beatful markdown viewer
glow completion powershell | Out-String | Invoke-Expression
# terminal prompt themeP
oh-my-posh.exe completion powershell | Out-String | Invoke-Expression
# 1password
op completion powershell | Out-String | Invoke-Expression

function Mount-carapace-Completers {
	Set-PSReadLineOption -Colors @{ 'Selection' = "`e[7m" }
	Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
	$apps = @()
	."$PSScriptRoot\functions.ps1"
	Get-Command -CommandType Application, Script, ExternalScript | ForEach-Object {
		$apps += remove-extension $_.Name
	}
	$apps += Get-Command -All -CommandType Function, Cmdlet | Select-Object -Property Name | ForEach-Object { $_.Name }
	$apps += Get-Alias | Select-Object Name | ForEach-Object { $_.Name }


	[System.Collections.Generic.List[string]]$carapace = carapace.exe --list | Get-Random -Shuffle
	
	for ($i = 0; $i -lt $carapace.Count; $i++) {
		$cmd = $carapace[$i].Split()[0]
		if ($apps -notcontains $cmd) {
			continue
		}
		lazycomplete $cmd "carapace $cmd" | Out-String | Invoke-Expression
		
		$percentComplete = ($i / ($carapace.Count)) * 100
		Write-Progress -Activity "Setting up $cmd completer" -Status "$percentComplete% complete:" -PercentComplete $percentComplete
	}
	Write-Progress -Activity "Setting up $cmd completer" -Status "$percentComplete% complete:" -PercentComplete $percentComplete -Completed
	Write-Host "$loaded Carapace completions loaded" -ForegroundColor Green
}


<#
.##.....##..#######...#######..##....##..######.
.##.....##.##.....##.##.....##.##...##..##....##
.##.....##.##.....##.##.....##.##..##...##......
.#########.##.....##.##.....##.#####.....######.
.##.....##.##.....##.##.....##.##..##.........##
.##.....##.##.....##.##.....##.##...##..##....##
.##.....##..#######...#######..##....##..######.
#>
# scoop search - faster than default speedup
Invoke-Expression (&scoop-search --hook)
zoxide init powershell | Out-String | Invoke-Expression