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
      let variables = if ($path | is-empty) { $in } else { open --raw $path }
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


        let resultEnv = $variables
            # substitute the environment variables in the file
            | reduce --fold $env {|item, acc|
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
                let value = $referencedEnvVariables | reduce --fold $value {|it envString|
                    let name = if ($it.complex | is-not-empty) { $it.complex } else { $it.simple }
                    let envVarValue = $acc | get $name --optional --ignore-case | default "" | into string
                    let isAListValue = ($bareEnvValue | str contains (char env_sep)) or ($envVarValue | describe) =~ 'list<.*>'
                    if $isAListValue and ($it.index | is-not-empty) {
                        let value = $envVarValue | get $it.index
                        $envString | str replace $it.var $value
                    } else if $isAListValue {
                        let value = $envVarValue | into string | str join (char env_sep)
                        $envString | str replace $it.var $value
                    } else {
                        $envString | str replace $it.var ($envVarValue | into string)
                    }
                }

                let envVar = if $key like "(?i)path" or ($value | str contains (char env_sep)) {
                    #TODO: add support for env_sep that's not escaped to be made into lists
                    {$key: ($acc.$key? | append ($value | split row (char env_sep) | uniq)) }
                } else {
                    {$key:$value}
                }

                if ($safe and ($acc | get --ignore-case --optional $key | is-not-empty)) {
                    print $"skipping ($key): not empty"
                    $acc
                } else {
                    $acc | merge deep $envVar
                }

            }
            # remove unmodified env variables
            | select ...($variables.key)

        if not $dry {
           # i think [par-]each/reduce/... are run in a sandboxed scope
           # so load-env aren't bubbled back up
           for $var in $resultEnv {
                load-env $var
           }
        }

    $resultEnv
}

# from carapce

def --env get-env [name] { $env | get $name }
def --env set-env [name, value] { load-env { $name: $value } }
def --env unset-env [name] { hide-env $name }
