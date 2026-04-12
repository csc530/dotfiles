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

const NU_SCRIPTS: path = './lib/nu_scripts'
let nuScriptsAbsPath: path = $NU_SCRIPTS | path expand
let nuLibPath: path = $nu.env-path | path dirname | path join lib

# Directories to search for scripts when calling source or use
# The default for this is $nu.default-config-dir/scripts
$env.NU_LIB_DIRS = ([
    ($nu.default-config-dir | path join 'scripts') # add <nushell-config-dir>/scripts
    (($nuScriptsAbsPath)/modules | path expand)
    (ls ($nuScriptsAbsPath)/modules | where type == "dir" | where {|e|
            let items = ls $e.name
            let length = ($items | length)
            $length != 0 and  'mod.nu' not-in $items.name
        }
        | each {|e| $e.name})
    (ls ($nuScriptsAbsPath)/custom-completions | where type == "dir" | each {|e| $e.name})
    (ls ~/.config/nushell/lib | where type == "dir" | where {|e|
            let items = ls $e.name
            let length = ($items | length)
            $length != 0 and 'mod.nu' not-in $items.name
        }
        | each {|e| $e.name})
    $nuLibPath
    ($nuScriptsAbsPath | path join themes)
    ] | flatten)

# Directories to search for plugin binaries when calling register
# The default for this is $nu.default-config-dir/plugins
$env.NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins') # add <nushell-config-dir>/plugins
]

# use `./lib/env-load.nu`
# env-load ~/.shell.env
# env-load ~/.config/user-dirs.dirs # should make xdg_* vars available

