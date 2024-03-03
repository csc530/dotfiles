oh-my-posh init nu --print --config $"($env.POSH_THEMES_PATH)/negligible.omp.json"
    | save ~/.config/nu/.cache/omp.nu --force
carapace _carapace nushell | save --force ~/.config/nu/.cache/carapace.nu
zoxide init nushell | save -f ~/.config/nu/.cache/zoxide.nu