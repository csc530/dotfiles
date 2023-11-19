function Add-VincentTheme {
    param (
        [Parameter(Position = 0, Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty]
        [string]
        $themeName,
        [Parameter(Position = 1, ParameterSetName = '')]
        [string]
        $terminal = 'windows'
    )
    $terminalThemes = Get-WindowsTerminalSettings -asJson | jq '.schemes' | Out-String -NoNewline
    $terminalThemeNames = ($terminalThemes | jq '.[].name' -r).Split([Environment]::NewLine, [StringSplitOptions]::TrimEntries)
    $outThemes =[System.Collections.ArrayList]::new()
    if ([string]::IsNullOrWhiteSpace($themeName)) {
        $themes = Get-VincentTheme
        # $outThemes = Get-WindowsTerminalSettingsPath | Get-Content | Out-String | jq '.schemes' | Out-String
        $themes | Foreach-Object -ThrottleLimit 5 -Parallel {
            if ($PSItem.name -icontains $terminalThemeNames) {
                Write-Host "Theme $_ already exists" -ForegroundColor Red
            }
            else {
                $themeJson = $PSItem#| ConvertTo-Json -Depth 100 | jq . -c | Out-String -NoNewline
                ($using:outThemes).add($themeJson) | Out-Null
            }
        }
    }
    else {

    }
    return $outThemes | ConvertTo-Json
}

function Get-VincentTheme {
    param ($theme)
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
        $json = vincent.exe $PSItem windows | Out-String | ConvertFrom-Json
        ($using:themes).Add($json) > $null
        ($using:counter).i++
    }
    Write-Progress -Activity 'Loading Vincent themes' -Completed
    return $themes
}

add-VincentTheme