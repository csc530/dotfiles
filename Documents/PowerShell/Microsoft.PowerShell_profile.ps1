# .. *sigh* OOoOOooohh Windows sad 😔
# just stuck in my Documents like that makes sense 🫠
# APPDATA, LOCALAPPDATA, all for what, huh, **siigh**
# O🪟🪟


Import-Module Terminal-Icons

$ENV:LS_COLORS = (vivid generate jellybeans)

# scoop-search
Invoke-Expression (scoop-search --hook)
# zoxide
Invoke-Expression (& { (zoxide init powershell | Out-String) })
# oh-my-posh
oh-my-posh init pwsh --config $env:POSH_THEME

./aliases.ps1
./completers.ps1

winfetch
