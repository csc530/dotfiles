
let envSep = char env_sep
let pairs = open ~/.config/.env | lines | where {|e| not ($e | str starts-with --ignore-case '#')  } | each { |e| $e | split column  '=' } | flatten | rename key value

# substitute the environment variables in the file
for item in $pairs {
    let key = $item.key
    let value = $item.value
    let pattern = '\${(?<EnvVarName>[^}]*)}'
    let vars = $value | parse -r $pattern

    if not ($vars | is-empty) {
        let envValue = $vars | get envVarName | reduce -f  $value { |it acc|
            let envVarValue = $env | get -i $it
            if ($envVarValue | is-empty) {
                $acc
            } else if ($envVarValue | describe) == 'string' {
                $acc | str replace $'${($it)}' $envVarValue
            }
            else if ($envVarValue | describe) == 'array' {
                $acc | str replace $'${($it)}' ($envVarValue | join $envSep)
            }
        }

        if ($env | get -i $key | is-empty) {
            load-env {$key: $envValue}
        } else {
            load-env { $key: ($env | get -i $key | append $envValue) }
        }

    } else {
        load-env { $key: $value }
    }
}