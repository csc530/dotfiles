# Nushell Config File
#
# version = "0.90.1"


const NU_SCRIPTS = '~/.config/nushell/lib/nu_scripts'


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
        let index = ($spans.0 | str index-of .exe);
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

    # datetime_format determines what a datetime rendered in the shell would look like.
    # Behavior without this configuration point will be to "humanize" the datetime display,
    # showing something like "a day ago."
    datetime_format: {
        # normal: '%a, %d %b %Y %H:%M:%S %z'    # shows up in displays of variables or other datetime's outside of tables
        # table: '%m/%d/%y %I:%M:%S%p'          # generally shows up in tabular outputs such as ls. commenting this out will change it to the default human readable datetime format
    }

    explore: {
        status_bar_background: {fg: "#1D1F21", bg: "#C4C9C6"},
        command_bar_text: {fg: "#C4C9C6"},
        highlight: {fg: "black", bg: "yellow"},
        status: {
            error: {fg: "white", bg: "red"},
            warn: {}
            info: {}
        },
        table: {
            split_line: {fg: "#404040"},
            selected_cell: {bg: light_blue},
            selected_row: {},
            selected_column: {},
        },
    }

    history: {
        max_size: 1_000_000 # Session has to be reloaded for this to take effect
        sync_on_enter: true # Enable to share history between multiple sessions, else you have to close the session to write history to file
        file_format: "plaintext" # "sqlite" or "plaintext"
        isolation: false # only available with sqlite file_format. true enables history isolation, false disables it. true will allow the history to be isolated to the current session using up/down arrows. false will allow the history to be shared across all sessions.
    }

    completions: {
        case_sensitive: false # set to true to enable case-sensitive completions
        quick: false    # set this to false to prevent auto-selecting completions when only one remains
        partial: true    # set this to false to prevent partial filling of the prompt
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

    # color_config: $dark_theme # if you want a more interesting theme, you can replace the empty record with `$dark_theme`, `$light_theme` or another custom record
    footer_mode: auto # always, never, number_of_rows, auto
    float_precision: 2 # the precision for displaying floats in tables
    buffer_editor: "" # command that will be used to edit the current line buffer with ctrl+o, if unset fallback to $env.EDITOR and $env.VISUAL
    use_ansi_coloring: true
    bracketed_paste: true # enable bracketed paste, currently useless on windows
    edit_mode: vi # emacs, vi
    shell_integration: {
        # osc2 abbreviates the path if in the home_dir, sets the tab/window title, shows the running command in the tab/window title
        osc2: true
        # osc7 is a way to communicate the path to the terminal, this is helpful for spawning new tabs in the same directory
        osc7: true
        # osc8 is also implemented as the deprecated setting ls.show_clickable_links, it shows clickable links in ls output if your terminal supports it. show_clickable_links is deprecated in favor of osc8
        osc8: true
        # osc9_9 is from ConEmu and is starting to get wider support. It's similar to osc7 in that it communicates the path to the terminal
        osc9_9: false
        # osc133 is several escapes invented by Final Term which include the supported ones below.
        # 133;A - Mark prompt start
        # 133;B - Mark prompt end
        # 133;C - Mark pre-execution
        # 133;D;exit - Mark execution finished with exit code
        # This is used to enable terminals to know where the prompt is, the command is, where the command finishes, and where the output of the command is
        osc133: true
        # osc633 is closely related to osc133 but only exists in visual studio code (vscode) and supports their shell integration features
        # 633;A - Mark prompt start
        # 633;B - Mark prompt end
        # 633;C - Mark pre-execution
        # 633;D;exit - Mark execution finished with exit code
        # 633;E - NOT IMPLEMENTED - Explicitly set the command line with an optional nonce
        # 633;P;Cwd=<path> - Mark the current working directory and communicate it to the terminal
        # and also helps with the run recent menu in vscode
        osc633: true
        # reset_application_mode is escape \x1b[?1l and was added to help ssh work better
        reset_application_mode: true
    }
    render_right_prompt_on_last_line: false # true or false to enable or disable right prompt to be rendered on last line of the prompt.
    use_kitty_protocol: ($env.TERM == "xterm-kitty") # enables keyboard enhancement protocol implemented by kitty console, only if your terminal support this.
    highlight_resolved_externals: true # true enables highlighting of external commands in the repl resolved by which.

    plugins: {} # Per-plugin configuration. See https://www.nushell.sh/contributor-book/plugins.html#configuration.

    hooks: {
        pre_prompt: [{ null }] # run before the prompt is shown
        pre_execution: [{ null }] # run before the repl input is run
        env_change: {
            PWD: [{|before, after| null }] # run if the PWD environment is different since the last repl input
        }
        display_output: "if (term size).columns >= 100 { table -e } else { table }" # run to display the output of a pipeline
        command_not_found: (source $'($NU_SCRIPTS)/nu-hooks/nu-hooks/command_not_found/did_you_mean.nu') # return an error message when a command is not found
    }

    menus: []

    keybindings: []
}
source ~/.config/nushell/lib/sys/mod.nu
# carpace
source ~/.config/nushell/.cache/carapace.nu
source ~/.config/nushell/.cache/oh-my-posh.nu
source ~/.config/nushell/.cache/zoxide.nu

# $env.LS_COLORS = (vivid generate catppuccin-mocha)
#

# source $'($NU_SCRIPTS)/themes/nu-themes/catppuccin-macchiato.nu'

use system
# because nupm git is here too🙄
use nupm/nupm
use random.nu
use ~/.config/nushell/ledger.nu

# my extern completers
use hledger.nu
use op.nu
use fakedata.nu
use legendary.nu
use komorebic.nu
use pipes-rs.nu
use swww.nu

# my modules
use sys

# scripts/
use yazi.nu *

use $'($NU_SCRIPTS)/sourced/misc/password_generator/nupass.nu'
# use jobapp.nu

# completions
source ~/.config/nushell/lib/completers/main.nu
source $'($NU_SCRIPTS)/custom-completions/btm/btm-completions.nu'
source $'($NU_SCRIPTS)/custom-completions/typst/typst-completions.nu'
source $'($NU_SCRIPTS)/custom-completions/scoop/scoop-completions.nu'
if ((sys host| get name) == 'Windows') {
	source $'($NU_SCRIPTS)/custom-completions/winget/winget-completions.nu'
} else if ((sys host| get name) == 'Linux') {
	# source $'hypr-completions.nu'
}

source $'($NU_SCRIPTS)/sourced/fun/spark.nu'
source $'($NU_SCRIPTS)/modules/formats/from-env.nu'
source $'($NU_SCRIPTS)/modules/formats/to-ini.nu'
source $'($NU_SCRIPTS)/modules/formats/to-number-format.nu'

source ~/.config/nushell/aliases.nu
oh-my-posh init nu --config $env.POSH_THEME
