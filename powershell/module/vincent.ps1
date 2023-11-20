
function Add-VincentTheme {
    param (
        [Parameter(Position = 0, Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet]
        [string]
        $themeName,
        [switch]
        $Force,
        [switch]
        $preview
    )
    $terminalSettings = Get-WindowsTerminalSettings -preview:$preview
    $schemes = (Get-WindowsTerminalSettings -asJson | Out-String | jq '.schemes[].name' -r) -replace '├®', 'é'
    $terminalThemeNames = $schemes.Split([Environment]::NewLine, [StringSplitOptions]::TrimEntries)

    $outThemes = [System.Collections.ArrayList]::new()
    $existingThemes = [System.Collections.ArrayList]::new()

    # ? add all themes from vincent
    if ([string]::IsNullOrWhiteSpace($themeName)) {
        # ? parse vincent themes to json
        $themes = Get-VincentTheme
        # $outThemes = Get-WindowsTerminalSettingsPath | Get-Content | Out-String | jq '.schemes' | Out-String
        $themes | ForEach-Object -ThrottleLimit 5 -Parallel {
            if ($using:terminalThemeNames -contains $PSItem.name) {
                #? force: remove already existing themes
                if ($using:Force) {
                    ($using:existingThemes).add($PSItem) > $null
                    Write-Host "Overwriting $($PSItem.name) theme" -ForegroundColor Red
                    # $terminalSettings.schemes = $terminalSettings.schemes | Convertto-Json | jq "del(.[] | select(.name == \"$themeName\"))" -c | Out-String -NoNewline | convertfrom-Json
                }
                else {
                    Write-Host "Skipping: theme $($PSItem.name) already exists" -ForegroundColor Red
                }
            }
            else {
                #* all the vincent json 'selectionBackground' were empty which caused validation errors in windows terminal json schema; so i killed them
                $themeJson = $PSItem | ConvertTo-Json -Depth 100 | jq 'del(.selectionBackground)' -c | Out-String -NoNewline | ConvertFrom-Json
                $themeJson.name = $PSItem.name -replace '├®', 'é' # something about pwsh or perhaps the json conversion is corrupting the é character encoding (or sumn)
                ($using:outThemes).add($themeJson) | Out-Null
            }
        }

        if ($Force) {
            $temp = $terminalSettings.schemes | ConvertTo-Json -Depth 100
            $existingThemes | ForEach-Object {
                $name = $PSItem.name
                $temp = $temp | jq "del(.[] | select(.name == `"$name`"))" -c
            }
            $terminalSettings.schemes = $temp | ConvertFrom-Json
        }
    }
    else {
        $theme = Get-VincentTheme -theme $themeName |
            #? remove that pesky selectionBackground property
            Select-Object * -ExcludeProperty selectionBackground

        if ($null -eq $theme) {
            Write-Host "theme $themeName not found"
        }
        elseif (!$Force -and $terminalThemeNames -contains $themeName) {
            Write-Host "theme $themeName already exists"
        }
        else {
            $outThemes.add($theme) | Out-Null
        }
    }

    if ($outThemes.Count -ne 0) {
        # ? add the array of themes to the settings.json
        #! should work but i get: Program 'jq.exe' failed to run: An error occurred trying to start process 'C:\Users\legor\scoop\shims\jq.exe' with working directory 'C:\Users\legor\.config'. The
        #! filename or extension is too long.At C:\Users\legor\.config\powershell\module\vincent.ps1:33 char:10 +          jq -n "$terminalSettings | .schemes +=
        # $outJsonThemes = $outThemes | ConvertTo-Json -Depth 100 | jq . -c | Out-String -NoNewline
        # $terminalSettings | jq ".schemes += $outJsonThemes" | Out-File -FilePath (Get-WindowsTerminalSettingsPath)
        # ($terminalSettings | convertfrom-Json) += $outThemes
        $terminalSettings.schemes += $outThemes
        ($terminalSettings | ConvertTo-Json -Depth 100 | jq -SM --tab) -replace '├®', 'é' | Out-File -FilePath (Get-WindowsTerminalSettingsPath)
        Write-Host "added $($outThemes.Count) new themes"
    }
}

function Get-VincentTheme {
    param (
        [Parameter(Position = 1, ParameterSetName = '')]
        [string]
        $Terminal = 'windows',
        [Parameter(Position = 0, ParameterSetName = '')]
        $theme,
        [switch]
        $asJson
    )
    if ($null -eq $theme) {
        $vincent = ((vincent -l | Out-String) -replace '├®', 'é').Split([Environment]::NewLine, [StringSplitOptions]::TrimEntries)
        $themes = [System.Collections.ArrayList]::new()
        $themeNames = @()
        # $themes = Get-WindowsTerminalSettings
        for ($i = 0; $i -lt $vincent.Count; $i += 18 <#kip all the preview stuff#>) {
            if ([string]::IsNullOrWhiteSpace($vincent[$i])) {
                continue
            }
            $themeNames += $vincent[$i]
        }

        $counter = @{'i' = 0 }
        $themeNames | ForEach-Object -ThrottleLimit 8 -Parallel {
            $percentComplete = [System.Math]::Round(($using:counter).i * 100 / $using:themeNames.Count)
            Write-Progress -Activity 'Loading Vincent themes' -PercentComplete $percentComplete -CurrentOperation "Processing $PSItem" -Status "$percentComplete% - $psitem"
            $json = (vincent $PSItem $using:Terminal | Out-String) -replace '├®', 'é' | ConvertFrom-Json
        ($using:themes).Add($json) > $null
        ($using:counter).i++
        }
        Write-Progress -Activity 'Loading Vincent themes' -Completed
        if ($asJson) {
            return $themes | ConvertTo-Json -Depth 100
        }
        return $themes
    }
    else {
        $json = (vincent $theme $Terminal | Out-String) -replace '├®', 'é' | ConvertFrom-Json
        return $asJson ? ($json | ConvertTo-Json -Depth 100) : $json
    }
}