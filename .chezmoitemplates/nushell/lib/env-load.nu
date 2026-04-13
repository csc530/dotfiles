#!/usr/bin/env nu

# environment variable name
#
# ex: `$FOO` or `${FOO}`
const rgEnvAssignment = '(?<var>\$(?<name>(?<simple>\w+)|\{(?<complex>\w+(?<index>\[\d+\])?)\}))'

export def --env main [
    path?:path  # path to the .env file containing environment variables to load into the current environment/context
    --dry(-d)   # do not update environment and print variables instead
    --safe(-s)  # do not overwrite existing env variables with the same name
    ] {
        let pairs = if ($path | is-empty) { $in } else { open --raw $path }
            | str trim
            | lines --skip-empty
            | split column "#" assignment comment --number 2 # remove comments
            | get assignment
            | where {is-not-empty}
            | par-each --keep-order {
                let record = split column "=" key value --number 2
                if ($record.value? | is-not-empty) { $record }
            }
            | flatten
            # substitute the environment variables in the file
            | par-each --keep-order {|item|
                let key = $item.key
                let value = $item.value
                    | str trim                    # Trim whitespace between value and inline comments
                    # todo: trimming quote???
                    | str trim -c '"'             # unquote double-quoted values
                    | str trim -c "'"             # unquote single-quoted values
                    | str replace -a "\\n" "\n"   # replace `\n` with newline char
                    | str replace -a "\\r" "\r"   # replace `\r` with carriage return
                    | str replace -a "\\t" "\t"   # replace `\t` with tab

                let referencedEnvVariables = $value | parse -r $rgEnvAssignment
                let bareEnvValue = $referencedEnvVariables | get var | reduce --fold $value {|it,acc| $acc | str replace $it ""}
                let value = $referencedEnvVariables | reduce --fold $value {|it acc|
                    let name = if ($it.complex | is-not-empty) { $it.complex } else { $it.simple }
                    let envVarValue = $env | get $name --optional  | default "" | into string
                    let isAListValue = ($bareEnvValue | str contains (char env_sep)) or ($envVarValue | describe) =~ 'list<.*>'

                    if $isAListValue and ($it.index | is-not-empty) {
                        let value = $envVarValue | get $it.index
                        $acc | str replace $it.var $value
                    } else if $isAListValue {
                        let value = $envVarValue | into string | str join (char env_sep)
                        $acc | str replace $it.var $value
                    } else {
                        $acc | str replace $it.var ($envVarValue | into string)
                    }
                }

                {key:$key, value:$value}
            }

        let variables = $pairs | reduce --fold {} {|it acc|
            if $safe and ($env | get --optional $it.key | is-not-empty) {
                # do not overwrite existing env variables with the same name
                $acc
            } else if $it.key in [Path PATH] {
                #TODO: add support for env_sep that's not escaped to be made into lists
                $acc | merge deep --strategy append { $it.key: ($it.value | split row (char env_sep)) }
            } else {
                $acc | merge deep --strategy overwrite { $it.key: $it.value }
            }
        } | update cells --columns [PATH Path] {uniq}

        if not $dry {
           # i think [par-]each are run in a sandboxed scope
           # so load-env aren't bubbled back up
           for $envvar in $variables {
               load-env $envvar
           }
        }

    $variables
}

# from carapce

def --env get-env [name] { $env | get $name }
def --env set-env [name, value] { load-env { $name: $value } }
def --env unset-env [name] { hide-env $name }
