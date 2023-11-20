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