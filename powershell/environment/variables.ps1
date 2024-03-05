Write-Host adding environment variables... -NoNewline

# for terminal-icons module
$env:LS_COLORS = (vivid generate catppuccin-mocha)

Push-Location "$env:Onedrive\Documents"
Set-PSEnv
Pop-Location

Write-Host ✅