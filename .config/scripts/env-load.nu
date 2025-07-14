const rgEnvAssignment = '(?<var>\$(?<name>(?<simple>\w+)|\{(?<complex>[^}]+)\}))'

export def --env main [
    path?:path  # path to the .env file containing environment variables to load into the current environment/context
    --dry(-d)   # do not update environment and print variables instead
    --safe(-s)  # do not overwrite existing env variables with the same name
    ]: nothing -> nothing, string -> nothing {
        let pairs = if ($path | is-empty) { $in } else { open --raw $path }
            | lines --skip-empty
            | split column '#' assignment comment --number 2 # remove comments
            | get assignment
            | where {is-not-empty}
            | par-each { split column '='  --collapse-empty }
            | flatten
            | rename key value
            # substitute the environment variables in the file
            | par-each {|item|
                # if ($item | get --ignore-errors value | is-empty) {
                #     continue
                # }

                let key = $item.key
                let value = $item.value |
                | str trim                    # Trim whitespace between value and inline comments
                | str trim -c '"'             # unquote double-quoted values
                | str trim -c "'"             # unquote single-quoted values
                | str replace -a "\\n" "\n"   # replace `\n` with newline char
                | str replace -a "\\r" "\r"   # replace `\r` with carriage return
                | str replace -a "\\t" "\t"   # replace `\t` with tab
                # let pattern = '\$(?<EnvVarName>(?:\w*|{[^}]*}))'
                let value = $value | parse -r $rgEnvAssignment | reduce --fold $value { |it acc|
                    let name = if ($it.complex? | is-not-empty) { $it.complex } else { $it.simple }
                    let envVarValue = $env | get -i $name
                    if ($envVarValue | describe) =~ 'list<.*>' {
                        # not sure if you should choose the first element or just not
                        #  same with tables and records
                    } else {
                        $acc | str replace $it.var ($envVarValue | into string)
                    }
                }



                    # ? I deceded to omit this as multiple calls to the same .env will make env vars into lists
                    # else {
                    #     load-env { $key: ($env | get -i $key | append $envValue) }
                    # }
                {key: $key, value: $value}
            }

        if $dry {
            print $pairs
        } else {
            $pairs
            | par-each {|it|
                if $safe and ($env | get --ignore-errors $it.key | is-not-empty) {
                    continue
                } else {
                    load-env {$it.key: $it.value}
                }
            }
        }
}

# from carapce

def --env get-env [name] { $env | get $name }
def --env set-env [name, value] { load-env { $name: $value } }
def --env unset-env [name] { hide-env $name }
