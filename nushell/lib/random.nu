const abc = "abcdefghijklmnopqrstuvwxyz";
const ABC = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
const num = "0123456789";

def "special chars" [] {
    char --list
}


# generate an endless stream of random values
def list [generator: closure] {
    generate { {out: (do $generator), next: true } } []
}

# generate a list of random booleans
export def "list bool" [] {
    list { random bool }
}

# generate a list of random integers
export def "list int" [range?: range] {
    if ($range | is-empty) {
        list { random int }
    } else {
        list { random int $range }
    }
}

# generate a list of random floats
export def "list float" [range?: range] {
    if ($range | is-empty) {
        list { random float }
    } else {
        list { random float $range }
    }
}

# generate a list of random characters
export def "list chars" [--length: int] {
    if ($length | is-empty) {
        list { random chars }
    } else {
        list { random chars --length $length }
    }
}

# generate a list of single random characters
export def "list char" [] {
        list { random chars --length 1 }
}

# select a random item from a list
export def "item" [...items]: list -> any {
    $in | append $items | shuffle | first
}