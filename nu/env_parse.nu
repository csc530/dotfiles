
def --env    "env source" [
    path:path # path to the .env file containing environment variables to load into the current environment/context
    ] {
        let pairs = open $path | lines | where {|e| not ($e | str starts-with --ignore-case '#')  } | each { |e| $e | split column  '=' } | flatten | rename key value

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
                    } else if ($envVarValue | describe) =~ 'list<.*>' {
                        # not sure if you should choose the first element or just not
                        #  same with tables and records
                    }
                }

                if ($env | get -i $key | is-empty) {
                    load-env {$key: $envValue}
                }
                # ? I deceded toomit this as multiple calls to the same .env will make env vars into lists
                # else {
                #     load-env { $key: ($env | get -i $key | append $envValue) }
                # }

            } else {
                load-env { $key: $value }
            }
    }
}

# from carapce

def --env get-env [name] { $env | get $name }
def --env set-env [name, value] { load-env { $name: $value } }
def --env unset-env [name] { hide-env $name }