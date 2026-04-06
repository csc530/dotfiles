## env.nu
#
# Installed by:
# version = "0.110.0"
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


# Directories to search for scripts when calling source or use
# The default for this is $nu.default-config-dir/scripts
$env.NU_LIB_DIRS = ([
    ($nu.default-config-dir | path join 'scripts') # add <nushell-config-dir>/scripts
    # nupm tings
    ($env.NUPM_HOME | path join "modules")
    ('~/.config/scripts')
    ($'($NU_SCRIPTS)/modules' | path expand)
    (ls $'($NU_SCRIPTS)/modules' | where type == "dir" | where {|e|
            let items = ls $e.name
            let length = ($items | length)
            $length != 0 and  'mod.nu' not-in $items.name
        }
        | each {|e| $e.name})
    (ls $'($NU_SCRIPTS)/custom-completions' | where type == "dir" | each {|e| $e.name})
    (ls ~/.config/nushell/lib | where type == "dir" | where {|e|
            let items = ls $e.name
            let length = ($items | length)
            $length != 0 and 'mod.nu' not-in $items.name
        }
        | each {|e| $e.name})
    ('~/.config/nushell/lib' | path expand)
    ] | flatten)

# Directories to search for plugin binaries when calling register
# The default for this is $nu.default-config-dir/plugins
$env.NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins') # add <nushell-config-dir>/plugins
]

$env.PATH = (
    $env.PATH
        | split row (char esep)
        | prepend ($env.NUPM_HOME | path join "scripts")
        | uniq
)

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# $env.PATH = ($env.PATH | split row (char esep) | prepend '/some/path')
if (sys host | get name) == 'Darwin' and (which /opt/homebrew/bin/brew | is-not-empty) {
    # translated from brew shellenv
    $env.HOMEBREW_PREFIX = '/opt/homebrew'
    $env.HOMEBREW_CELLAR = '/opt/homebrew/Cellar'
    $env.HOMEBREW_REPOSITORY = '/opt/homebrew'
    $env.PATH = $env.PATH | prepend [
        "/opt/homebrew/bin"
        "/opt/homebrew/sbin"
        "/Users/chrissc/.config/carapace/bin"
        "/Users/chrissc/Library/Application Support/nushell/nupm/scripts"
        "/usr/bin"
        "/usr/bin"
        "/usr/sbin"
        "/sbin"
        "/Applications/Ghostty.app/Contents/MacOS"
    ]
    $env.INFOPATH = $env.INFOPATH? | prepend "/opt/homebrew/share/info"
}

use `~/.config/scripts/env-load.nu`
env-load ~/.shell.env
# env-load ~/.config/user-dirs.dirs # should make xdg_* vars available
if ($env.OneDrive? | is-not-empty) {
	if (sys host | get name) == 'Darwin' {
        env-load $"($env.OneDrive)/.mac.env"
	} else if (sys host | get name) == 'Windows' {
        env-load $"($env.OneDrive)/Documents/.env"
   }
}
