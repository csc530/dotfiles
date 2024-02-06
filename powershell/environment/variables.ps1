Write-Host adding environment variables... -NoNewline

# for terminal-icons module
$env:LS_COLORS = (vivid generate catppuccin-mocha)

Push-Location "$env:USERPROFILE\.config"
Set-PSEnv
Pop-Location

Write-Host ✅