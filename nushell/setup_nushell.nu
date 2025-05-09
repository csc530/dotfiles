#!/usr/bin/env nu

echo 'adding nu scripts'
git clone --quiet https://github.com/nushell/nu_scripts.git ~/.config/nushell/lib/nu_scripts | ignore

echo genrating caches 
mkdir ~/.config/nushell/.cache |ignore
if (which zoxide | is-not-empty) {
    zoxide init nushell | save -f ~/.config/nushell/.cache/zoxide.nu
}

if (which carapace | is-not-empty) {
   carapace _carapace nushell | save -f ~/.config/nushell/.cache/carapace.nu
}

if (which oh-my-posh | is-not-empty) {
    oh-my-posh init nu --config ~/.config/oh-my-posh/themes/negligible.omp.json --print | save -f ~/.config/nushell/.cache/oh-my-posh.nu
}

echo 'adding nu package manager (NUPM!!)'
git clone --quiet https://github.com/nushell/nupm.git ~/.config/nushell/lib/nupm | ignore
cd ~/.config/nushell/lib/nupm

echo please run
echo 'cd ~/.config/nushell/lib/
use nupm/nupm
nupm install nupm --force --path
rm --recursive ~/.config/nushell/lib/nupm'