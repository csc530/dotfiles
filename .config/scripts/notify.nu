#! /usr/bin/env nu

def urgency-completer [] { [low normal critical] }
def percentage-completer [] { 0..100 }

export def main [
    title: string
    body?: string
    --percentage(-p): float@percentage-completer
    --urgency(-u): string@urgency-completer = low
] {
    let hints = [{type: percentage value: $percentage}] | parse-hint
    let msg = if ($body | is-empty ) {
        [$title]
    } else {
        [$title $body]
    }
    notify-send ...$msg --urgency $urgency $hints
}

export def sound [] {
main Volume --percentage (wpctl get-volume @DEFAULT_AUDIO_SINK@ | parse 'Volume: {lvl}' | get lvl | into float)
}

def parse-hint [] {
# : record<type: string, value, name?> -> string, list<record<type: string, value:any, name?: string>> -> string {
#
    let input = $in
    def hintify [] {
        if ($in.value | is-empty) {
            return null
        }

        match $in.type {
            "percentage" => [int value $in.value]
            _ if ($in.name | is-not-empty) => [$in.type $in.name $in.value]
        } | str join : | prepend '--hint' | str join ' '
    }

    match ($input | get-type) {
        'list' => { par-each {|hint| $hint | hintify } | str join ' ' }
        'record' => { $in | hintify }
        # _ => (error make { msg: 'incorrect type for hint' })
    }
}

def get-type []: any -> string {
    $in | describe | str replace '<.*' ''
}
