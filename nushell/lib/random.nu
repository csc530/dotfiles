def list [generator: closure] {
    generate [] { {out: (do $generator), next: true } }
}

export def "list int" [range?: range] {
    if ($range | is-empty) {
        list { random int }
    } else {
        list { random int $range }
    }
}

export def "list float" [range?: range] {
    if ($range | is-empty) {
        list { random float }
    } else {
        list { random float $range }
    }
}

export def "list char" [--length: int] {
    if ($length | is-empty) {
        list { random chars }
    } else {
        list { random chars --length $length }
    }
}

export def "item" [] list -> any {
    $in | shuffle | first
}