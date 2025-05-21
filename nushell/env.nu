# Nushell Environment Config File
#
# version = "0.90.1"

let $NU_SCRIPTS = '~/.config/nushell/lib/nu_scripts' | path expand

def create_left_prompt [] {
    let home =  $nu.home-path

    # Perform tilde substitution on dir
    # To determine if the prefix of the path matches the home dir, we split the current path into
    # segments, and compare those with the segments of the home dir. In cases where the current dir
    # is a parent of the home dir (e.g. `/home`, homedir is `/home/user`), this comparison will
    # also evaluate to true. Inside the condition, we attempt to str replace `$home` with `~`.
    # Inside the condition, either:
    # 1. The home prefix will be replaced
    # 2. The current dir is a parent of the home dir, so it will be uneffected by the str replace
    let dir = (
        if ($env.PWD | path split | zip ($home | path split) | all { $in.0 == $in.1 }) {
            ($env.PWD | str replace $home "~")
        } else {
            $env.PWD
        }
    )

    let path_color = (if (is-admin) { ansi red_bold } else { ansi green_bold })
    let separator_color = (if (is-admin) { ansi light_red_bold } else { ansi light_green_bold })
    let path_segment = $"($path_color)($dir)"

    $path_segment | str replace --all (char path_sep) $"($separator_color)(char path_sep)($path_color)"
}

def create_right_prompt [] {
    # create a right prompt in magenta with green separators and am/pm underlined
    let time_segment = ([
        (ansi reset)
        (ansi magenta)
        (date now | format date '%x %X %p') # try to respect user's locale
    ] | str join | str replace --regex --all "([/:])" $"(ansi green)${1}(ansi magenta)" |
        str replace --regex --all "([AP]M)" $"(ansi magenta_underline)${1}")

    let last_exit_code = if ($env.LAST_EXIT_CODE != 0) {([
        (ansi rb)
        ($env.LAST_EXIT_CODE)
    ] | str join)
    } else { "" }

    ([$last_exit_code, (char space), $time_segment] | str join)
}

# Use nushell functions to define your right and left prompt
$env.PROMPT_COMMAND = {|| create_left_prompt }
# FIXME: This default is not implemented in rust code as of 2023-09-08.
$env.PROMPT_COMMAND_RIGHT = {|| create_right_prompt }

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = {|| "> " }
$env.PROMPT_INDICATOR_VI_INSERT = {|| ": " }
$env.PROMPT_INDICATOR_VI_NORMAL = {|| "> " }
$env.PROMPT_MULTILINE_INDICATOR = {|| "::: " }

# If you want previously entered commands to have a different prompt from the usual one,
# you can uncomment one or more of the following lines.
# This can be useful if you have a 2-line prompt and it's taking up a lot of space
# because every command entered takes up 2 lines instead of 1. You can then uncomment
# the line below so that previously entered commands show with a single `🚀`.
# $env.TRANSIENT_PROMPT_COMMAND = {|| "🚀 " }
# $env.TRANSIENT_PROMPT_INDICATOR = {|| "" }
# $env.TRANSIENT_PROMPT_INDICATOR_VI_INSERT = {|| "" }
# $env.TRANSIENT_PROMPT_INDICATOR_VI_NORMAL = {|| "" }
# $env.TRANSIENT_PROMPT_MULTILINE_INDICATOR = {|| "" }
# $env.TRANSIENT_PROMPT_COMMAND_RIGHT = {|| "" }

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
    "PATH": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
    "Path": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
}

if (sys host| get name) == 'Windows' {
    $env.NUPM_HOME = 'C:\Users\legor\AppData\Roaming\nushell\nupm'
    $env.NUPM_TEMP = 'C:\Users\legor\AppData\Local\Temp\nupm'
    } else if (sys host| get name) == 'Darwin' {
        $env.NUPM_HOME = ($env.HOME | path join "Library/Application Support/nushell/nupm")
        $env.NUPM_TEMP = ($env.TMPDIR | path join "nupm")
    } else {
        if ($env.XDG_DATA_DIR? | is-empty) {
            $env.XDG_DATA_HOME = ($env.HOME | path join ".local/share")
        }
        $env.NUPM_TEMP = ('/tmp' | path join "nupm")
        $env.NUPM_HOME = ($env.XDG_DATA_HOME? | path join "nupm")
}

# Directories to search for scripts when calling source or use
# The default for this is $nu.default-config-dir/scripts
$env.NU_LIB_DIRS = ([
    ($nu.default-config-dir | path join 'scripts') # add <nushell-config-dir>/scripts
    # nupm tings
    ($env.NUPM_HOME | path join "modules")

    ($'($NU_SCRIPTS)/modules' | path expand)
    (ls $'($NU_SCRIPTS)/modules' | where type == "dir" | filter {|e|
            let items = ls $e.name
            let length = ($items | length)
            $length != 0 and  'mod.nu' not-in $items.name
        }
        | each {|e| $e.name})
    (ls $'($NU_SCRIPTS)/custom-completions' | where type == "dir" | each {|e| $e.name})
    (ls ~/.config/nushell/lib | where type == "dir" | filter {|e|
        let items = ls $e.name
        let length = ($items | length)
        $length != 0 and  'mod.nu' not-in $items.name
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


source ~/.config/nushell/env_parse.nu
if ($env.OneDrive? | is-not-empty) {
	if (sys host | get name) == 'Darwin' {
        env source $"($env.OneDrive)/.mac.env"
	} else {
        env source $"($env.OneDrive)/Documents/.env"
   }
}

# update caches
mkdir ~/.config/nushell/.cache
if (which zoxide | is-not-empty) {
    zoxide init nushell | save -f ~/.config/nushell/.cache/zoxide.nu
}

if (which carapace | is-not-empty) {
   carapace _carapace nushell | save -f ~/.config/nushell/.cache/carapace.nu
}

if (which oh-my-posh | is-not-empty) {
    oh-my-posh init nu --config ~/.config/oh-my-posh/themes/negligible.omp.json --print | save -f ~/.config/nushell/.cache/oh-my-posh.nu
}