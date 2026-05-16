function Set-PsEnv
{
    [CmdletBinding()]
    param(
        [ValidateScript({
                if(-Not ($_ | Test-Path -PathType Leaf))
                {
                    throw "The path does not exist"
                }
                return $true
            })]
        [Parameter(Position = 0, ValueFromPipeline = $true)]
        [System.IO.FileInfo]$path = "./.env",
        [Parameter(ValueFromPipelineByPropertyName)]
        [System.EnvironmentVariableTarget]$target = "Process"
    )

    $ENV_RG = '(?<var>\$(?<name>(?<simple>\w+)|\{(?<complex>\w+(?<index>\[\d+\])?)\}))'

    $splitOptions = [System.StringSplitOptions]::RemoveEmptyEntries -bor [System.StringSplitOptions]::TrimEntries

    $variables = Get-Content $path
    | Where-Object { $_.Contains("=") -and -not $_.StartsWith("#") }
    | ForEach-Object {
        $line = $PSItem.split("=", 2, $splitOptions)
        $key = $line[0]
        # remove inline comments
        $value = $line[1].split("#")[0]
        @{
            key = $key;
            value = $value;
        }
    }

    $interpolatedVariables = @{}
    foreach($var in $variables)
    {
        $interpolated = $var.value
        $var.value
        | Select-String $ENV_RG -AllMatches
        | Select-Object -ExpandProperty Matches
        | ForEach-Object {
            $rg = $PSItem
            switch ($_.Groups | Where-Object Success | Select-Object -ExpandProperty Name)
            {
                var
                { Write-Debug "Replacing environment variable: $($rg.Groups["var"].Value)"
                }
                complex
                {
                    $envVarName = $rg.Groups["complex"].Value
                    if (Test-Path Env:\$envVarName)
                    {
                        $value = Get-Item Env:\$envVarName | Select-Object -ExpandProperty Value
                        Write-Debug "Found env var: $envVarName = $value"
                        $matchedEnvVar = [regex]::Escape($rg.Groups["var"].Value)
                        $interpolated = $interpolated -replace $matchedEnvVar, $value
                    } else
                    {
                        Write-Warning "No such env var: $envVarName"
                    }
                    continue
                }
                index
                {
                    $envVarName = $rg.Groups["complex"].Value

                    if (Test-Path Env:\$envVarName)
                    {
                        $arr = (Get-Item Env:/$envVarName | Select-Object -ExpandProperty Value).Split([System.IO.Path]::PathSeparator)
                        $index = [Int]$rg.Groups["index"].Value
                        Write-Debug "Found env var: $envVarName[$index] = $arr[$index]"
                        $matchedEnvVar = [regex]::Escape($rg.Groups["var"].Value)
                        $interpolated = $interpolated -replace $matchedEnvVar, $arr[$index]
                    } else
                    {
                        Write-Warning "No such env var: $envVarName"
                    }
                    continue
                }
                simple
                {
                    $matchedEnvName = $rg.Groups["name"].Value
                    if (Test-Path Env:\$matchedEnvName)
                    {
                        $value = Get-Item Env:\$matchedEnvName | Select-Object -ExpandProperty Value
                        Write-Debug "Found env var: $matchedEnvName = $value"
                        $matchedEnvVar = [regex]::Escape($rg.Groups["var"].Value)
                        $interpolated = $interpolated -replace $matchedEnvVar, $value
                    } else
                    {
                        Write-Warning "No such env var: $matchedEnvName"
                    }
                    continue
                }
            }
        }

        Write-Debug "Setting `$$($var.key) = $interpolated"
        [Environment]::SetEnvironmentVariable($var.key, $interpolated, $target)
        Write-Information "`$$($var.key) = $interpolated"
        $interpolatedVariables.$($var.key) = $interpolated
    }

    $interpolatedVariables
}


Export-ModuleMember -Function @(
    "Set-PsEnv"
)
