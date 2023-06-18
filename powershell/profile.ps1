# for terminal-icons module
$env:LS_COLORS = (vivid generate catppuccin-mocha)


#oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\catppuccin_mocha.omp.json"| Invoke-Expression
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\negligible.omp.json" | Invoke-Expression


."$PSScriptRoot\aliases.ps1" -ErrorAction Inquire -JobName "aliases"
."$PSScriptRoot\addons.ps1" -JobName "addons"
."$PSScriptRoot\functions.ps1" -JobName "functions"

Invoke-Expression -Command screenfetch
Invoke-Expression -Command Mount-carapace-Completers