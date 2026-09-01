# config.nu
#
# Installed by:
# version = "0.112.1"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# Nushell sets "sensible defaults" for most configuration settings,
# so your `config.nu` only needs to override these defaults if desired.
#
# You can open this file in your default editor using:
#     config nu
#
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R


const NU_LIB_PATH: path = ($nu.default-config-dir)/lib
const NU_SCRIPTS_PATH: path = ($nu.default-config-dir)/nu_scripts

# Directories to search for scripts when calling source or use
# The default for this is $nu.default-config-dir/scripts
const $NU_LIB_DIRS = [
    $NU_LIB_PATH
    # (ls $NU_LIB_PATH | where type == "dir" | par-each {|e| $e.name})

    ($NU_SCRIPTS_PATH)/modules
    ($NU_SCRIPTS_PATH)/themes
    # (ls ($NU_SCRIPTS_PATH)/modules | where type == "dir" | par-each {|e| $e.name})
    # (ls ($NU_SCRIPTS_PATH)/themes/nu-themes | where type == "dir" | par-each {|e| $e.name})
]
    # | flatten

let external_completer = {|spans|
    let carapace_completer = {|spans: list<string>|
        carapace $spans.0 nushell ...$spans
            | from json
            # filter out err values
            | if ($in | default [] | where value =~ '^.*ERR$' | is-empty) { $in } else { null }
    }

    # if the current command is an alias, get it's expansion
    let expanded_alias = (scope aliases | where name == $spans.0 | get --optional 0 | get --optional expansion)
    # remove exe extension if present
    let bare_cmd = (
        let index = ($spans.0 | str index-of --end .exe);
        if $index == -1 { $spans.0 } else { $spans.0 | str substring 0..$index }
    )
    # overwrite
    let spans = (
        if $expanded_alias != null  {
        # put the first word of the expanded alias first in the span
        $spans | skip 1 | prepend ($expanded_alias | split row " " | take 1)
        } else if $bare_cmd != $spans.0 {
            $spans | skip 1 | prepend $bare_cmd
        } else {
            $spans
        }
    )

    do $carapace_completer $spans
}

# The default config record. This is where much of your global configuration is setup.
$env.config = {
    show_banner: true # true or false to enable or disable the welcome banner at startup

    ls: {
        use_ls_colors: true # use the LS_COLORS environment variable to colorize output
        clickable_links: true # enable or disable clickable links. Your terminal has to support links.
    }

    rm: {
        always_trash: true # always act as if -t was given. Can be overridden with -p
    }

    table: {
        mode: rounded # basic, compact, compact_double, light, thin, with_love, rounded, reinforced, heavy, none, other
        index_mode: auto # "always" show indexes, "never" show indexes, "auto" = show indexes when a table has "index" column
        show_empty: true # show 'empty list' and 'empty record' placeholders for command output
        padding: { left: 1, right: 1 } # a left right padding of each column in a table
        trim: {
            methodology: truncating # wrapping or truncating
            wrapping_try_keep_words: true # A strategy used by the 'wrapping' methodology
            truncating_suffix: "..." # A suffix used by the 'truncating' methodology
        }
        header_on_separator: false # show header text on separator/border line
        # abbreviated_row_count: 10 # limit data rows from top and bottom after reaching a set point
    }

    error_style: "fancy" # "fancy" or "plain" for screen reader-friendly error messages

    history: {
        max_size: 10_000_000 # Session has to be reloaded for this to take effect
        sync_on_enter: true # Enable to share history between multiple sessions, else you have to close the session to write history to file
        file_format: "plaintext" # "sqlite" or "plaintext"
        isolation: false # only available with sqlite file_format. true enables history isolation, false disables it. true will allow the history to be isolated to the current session using up/down arrows. false will allow the history to be shared across all sessions.
    }

    completions: {
        case_sensitive: false # set to true to enable case-sensitive completions
        quick: false    # set this to false to prevent auto-selecting completions when only one remains
        algorithm: prefix    # prefix or fuzzy
        external: {
            enable: true # set to false to prevent nushell looking into $env.PATH to find more suggestions, `false` recommended for WSL users as this look up may be very slow
            max_results: 50 # setting it lower can improve completion performance at the cost of omitting some options
            completer: $external_completer # check 'carapace_completer' above as an example
        }
    }

    cursor_shape: {
        emacs: line # block, underscore, line, blink_block, blink_underscore, blink_line, inherit to skip setting cursor shape (line is the default)
        vi_insert: block # block, underscore, line, blink_block, blink_underscore, blink_line, inherit to skip setting cursor shape (block is the default)
        vi_normal: underscore # block, underscore, line, blink_block, blink_underscore, blink_line, inherit to skip setting cursor shape (underscore is the default)
    }

    footer_mode: auto # always, never, number_of_rows, auto
    float_precision: 3 # the precision for displaying floats in tables
    use_ansi_coloring: true
    bracketed_paste: true # enable bracketed paste, currently useless on windows
    # maybe when I'm actually good with vim I'll switch this 🤔
    edit_mode: emacs # ONE DAY I'll vi
    use_kitty_protocol: ($env.TERM? | str starts-with "xterm-") # enables keyboard enhancement protocol implemented by kitty console, only if your terminal support this.
    highlight_resolved_externals: true # true enables highlighting of external commands in the repl resolved by which.


    hooks: {
        display_output: "if (term size).columns >= 100 { table -e } else { table }" # run to display the output of a pipeline
        command_not_found: (source ($NU_SCRIPTS_PATH)/nu-hooks/nu-hooks/command_not_found/did_you_mean.nu) # return an error message when a command is not found
    }
}
# $env.LS_COLORS = (vivid generate catppuccin-mocha)

# config files are only sourced in interactive mode
# unless manually specified via flag
# https://www.nushell.sh/book/configuration.html#detailed-configuration-startup-process
source "./lib/modules.nu"
