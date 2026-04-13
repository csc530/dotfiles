def vincent-completer [spans: list<string>] {
    vincent _carapace nushell ...$spans | from json
}

@complete vincent-completer
def --wrapped vincent [...rest] {
    ^vincent ...$rest
}

# pr new completer annotations for zoxide
# let zoxide_completer = {|spans|
#     $spans | skip 1 | zoxide query -l ...$in | lines | where {|x| $x != $env.PWD} | append (ls | where type == Directory | get name) | sort | uniq
# }
# @complete zoxide-completer
# def --wrapped z [...rest] {
#     ^__z
# }
