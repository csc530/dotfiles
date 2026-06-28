# env.nu
#
# Installed by:
# version = "0.112.1"
#
# Previously, environment variables were typically configured in `env.nu`.
# In general, most configuration can and should be performed in `config.nu`
# or one of the autoload directories.
#
# This file is generated for backwards compatibility for now.
# It is loaded before config.nu and login.nu
#
# See https://www.nushell.sh/book/configuration.html
#
# Also see `help config env` for more options.
#
# You can remove these comments if you want or leave
# them for future reference.
use `./lib/env-load.nu`
env-load ~/.shell.env
# env-load ~/.config/user-dirs.dirs # should make xdg_* vars available

if not ($nu.cache-dir | path exists) {
    mkdir $nu.cache-dir
}
# create prompt and QoL caches
# this is done in env.nu because it initializes all the source paths so config.nu does not error-out
if $nu.is-interactive {
    use ./lib/sys *
    zoxide init nushell | cache zoxide.nu | ignore
    # oh-my-posh init nu --config $env.POSH_THEME | save -f .cache/oh-my-posh.nu
    oh-my-posh init nu --config $env.POSH_THEME
    carapace init nushell | cache carapace.nu | ignore
}
