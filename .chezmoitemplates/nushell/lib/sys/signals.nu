#!/bin/env nu
#
#  add an enum of available (kill) signals

export-env {
    let SIGNALS = ^kill -L
        | parse --regex '(?<number>\d+) (?<name>\w+)'
        | reduce --fold {} {|it|
            merge {$it.name: ($it.number | into int)}
        }
    $env.SIG = $SIGNALS
}

export def main [] {
    $env.SIG
}
