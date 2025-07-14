#!/usr/bin/env nu
use ~/.config/scripts/notify.nu

const EMOJI_MODE = 'emojis'
const NERD_MODE = 'nerd-fonts'
const ALL_MODE = 'all'

def modes-completer [] { [$EMOJI_MODE $NERD_MODE $ALL_MODE] }

def _nerd_select [$path:path] {
    if ($path | path exists) and (ls $path | get modified | first) > (date now) - 12day {
        open $path --raw
    } else {
        http get https://raw.githubusercontent.com/ryanoasis/nerd-fonts/refs/heads/master/glyphnames.json |
           	transpose key value |
           	where {|e| $e.value.char? | is-not-empty } |
           	par-each {|i|
          		let _ = $i.key | parse "{source}-{name}" | get 0
          		let source = $_.source
          		let name = $_.name | str replace _ " " --all

          		let char = $i.value.char
          		let codepoint = $i.value.code | str upcase

          		let value = $"($char) - ($name) \(($source)) - U+($codepoint)"
          		{ ico: $name, txt: $value, code: $codepoint }
           	} |
           	sort |
           	get txt |
           	to text |
           	save $path --force
    open $path --raw
    }
}

def _emoji_select [$path:path] {
    if ($path | path exists) and ((date now) - 12day) < (ls $path | get modified | first) {
        open $path --raw
    } else {
        http get https://raw.githubusercontent.com/hfg-gmuend/openmoji/refs/heads/master/data/openmoji.csv |
            par-each {|e|
                let keywords = $e.tags | split row ', ' | where $it != '' | prepend [$e.group $e.subgroups] | str join ,
                let txt = $"($e.emoji) - ($e.annotation) - \(($keywords))"
                { txt: $txt, ...$e }
                } |
            sort-by order |
            get txt |
            save $path --force
        open $path --raw
    }
}

export def main [
	$mode: string@modes-completer = all
] {
    let path = if ($env.XDG_CACHE_HOME? | is-not-empty) { $env.XDG_CACHE_HOME } else { '~/.cache/'} | path join numoji-picker | path expand
    if not ($path | path exists) {
        mkdir $path
    }
    let emojiCache = $path | path join emojis.txt
    let nerdCache = $path | path join nerds.txt

    # kill any running instances of the script
    if (ps | where name == fuzzel | is-not-empty) {
        ps | where name == fuzzel | get pid.0 | kill $in
    }


    let $icons = match ($mode | str downcase) {
        'all' => {
            let emojis = if ($emojiCache | path exists) {
                open $emojiCache
            } else {
                _emoji_select $emojiCache
            }
            let nerds = if ($nerdCache | path exists) {
                open $nerdCache
            } else {
                _nerd_select $nerdCache
            }
            $emojis + $nerds
        }
        'nerds' | 'nerd' | 'nerd-font' | 'nerd-fonts' => { _nerd_select $nerdCache }
        'emojis' | 'emoji' => { _emoji_select $emojiCache }
        _ => { 'Invalid mode selected'}
    }

    let icon = $icons |
   	fuzzel --dmenu  --no-exit-on-keyboard-focus-loss  --keyboard-focus on-demand |
   	split chars |
   	get 0? |
   	to text


    if ($icon | is-not-empty) and ($icon != '') {
        wtype $icon
        wl-copy $icon
    }
}

def asciimojis [] {
http get https://raw.githubusercontent.com/jigglycrumb/ASCIImoji/refs/heads/master/dist/text-file/asciimoji.txt | parse '{names} {emoticon}' | par-each {|e| $"($e.emoticon) - ($e.names)"} | to text | fuzzel -d
}
