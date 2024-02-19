def "random terminal scheme" [] {
    let terminal  = getTerminal
    let isPreview = which $terminal.command | first | get path | path dirname | str contains -i preview
    let path = $'($env.LOCALAPPDATA)\Packages\Microsoft.WindowsTerminal(if $isPreview {'Preview'} else {'_'})*\LocalState\settings.json'

    open $path | update profiles.defaults.colorScheme {|json| $json.schemes | shuffle | first | get name} | save (ls $path -f | first | get name) -f
    print "Terminal scheme updated: " (open $path | get profiles.defaults.colorScheme)
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

random terminal scheme