def "random windows-terminal scheme" [
    --preview(-p) # windows terminal preview
] {
    let path = if $preview { windows terminal-settings --path --preview } else { windows terminal-settings --path }
    let json = if $preview { windows terminal-settings --preview } else { windows terminal-settings } | update profiles.defaults.colorScheme {|json| $json.schemes | shuffle | first | get name}
    $json | save $path --force
    "Terminal scheme updated: " + (open $path | get profiles.defaults.colorScheme)
}

def getTerminal [pid: int=$nu.pid] {
    let ps = ps -l | where pid == $pid | get 0 -i
    if ($ps | is-empty)  {
        null
    } else if $ps.name !~ '(?i)windowsterminal' {
        getTerminal $ps.ppid
    } else {
        $ps
    }
}

def "windows terminal-settings" [
        --preview(-p) # windows terminal preview
        --path # path to settings file
    ] {
        cd $env.LOCALAPPDATA
        glob $'/Users/legor/AppData/Local/Packages/Microsoft.WindowsTerminal(if $preview {'Preview'})_*/LocalState/settings.json' | first | if $path { $in } else { open }
}
