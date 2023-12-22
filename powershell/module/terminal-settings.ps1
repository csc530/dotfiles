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

    $content = Get-Content -Path (get-WindowsTerminalSettingsPath -preview:$preview) | ConvertFrom-Json
    # $json = Get-Content "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal${isPreview}_*\LocalState\settings.json"
    return $asJson ? $($content | ConvertTo-Json -Depth 100) : $content

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

    if (!$settings.profiles.$profileName.colorScheme) {
        Add-Member -InputObject $settings.profiles.$profileName -MemberType NoteProperty -Name 'colorScheme' -Value $name
    }
    else {
        $settings.profiles.$profileName.colorScheme = $name
    }

    $path = Get-WindowsTerminalSettingsPath -preview:$preview
    ($settings | ConvertTo-Json -Depth 100 ) | Out-File -FilePath:$path
}

function RandomizeTerminalScheme(
    [Parameter(Mandatory = $false)]
    [switch]
    $preview = $false
) {
    $settings = Get-WindowsTerminalSettings -preview:$preview
    $scheme = $settings.schemes | Select-Object -ExpandProperty name -Unique | Get-Random
    Write-Host "colour scheme set to `"$scheme`""
    Set-WindowsTerminalScheme -name $scheme -preview:$preview
}