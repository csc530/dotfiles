function Get-WindowsTerminalSettingsPath {
    param (
        [Parameter(Mandatory = $false, ParameterSetName = 'Preview')]
        [switch]
        $preview
    )
    $isPreview = $preview ? 'Preview' : ''

    return Get-Item "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal${isPreview}_*\LocalState\settings.json"
}
<#
.SYNOPSIS
    gets windows terminal settings
.DESCRIPTION
    returns windows terminal settings
.PARAMETER preview
    get windows terminal preview settings
.PARAMETER asJson
    return settings as json string
.NOTES

.LINK
    https://docs.microsoft.com/en-us/windows/terminal/customize-settings
.EXAMPLE
    Get-WindowsTerminalSettings
#>
function Get-WindowsTerminalSettings {
    param (
        [Parameter(Mandatory = $false, ParameterSetName = 'Preview')]
        [switch]$preview,
        [switch]$asJson
    )

    $content = Get-Content (Get-WindowsTerminalSettingsPath -preview:$preview) | ConvertFrom-Json
    # $json = Get-Content "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal${isPreview}_*\LocalState\settings.json"
    if ($content) {
        $output = $content
        return $asJson ? $($output | ConvertTo-Json -Depth 100) : $($output)
    }
    return $json
}

function Get-WindowsTerminalScheme(
    [Parameter(Mandatory = $false, ParameterSetName = 'Preview')]
    [switch]
    $preview,
    [string]
    $name,
    [string]
    $profileName = 'defaults'
) {
    $settings = Get-WindowsTerminalSettings -preview:$preview

    if ($profile -eq 'default') {
        $profileName = 'defaults'
    }

    return $settings.profiles.$profileName.colorScheme
}
function Set-WindowsTerminalScheme(
    [Parameter(Mandatory = $false)]
    [switch]
    $preview,
    [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [string]
    $name,
    [string]
    $profileName = 'defaults'
) {
    $settings = Get-WindowsTerminalSettings -preview:$preview

    if ($profile -eq 'default') {
        $profileName = 'defaults'
    }

    $settings.profiles.$profileName.colorScheme = $name
    $path = Get-WindowsTerminalSettingsPath -preview:$preview
    Set-Content -Path $path -Value ($settings | ConvertTo-Json -Depth 100 | Out-String | jq -SM --tab)
}

function RandomizeTerminalScheme(
    [Parameter(Mandatory = $false)]
    [switch]
    $preview
) {
    $settings = Get-WindowsTerminalSettings
    $schemes = $settings.schemes | Select-Object -ExpandProperty name
    $scheme = $schemes | Get-Random
    Write-Host "colour scheme set to `"$scheme`""
    Set-WindowsTerminalScheme -name $scheme -preview:$preview
}