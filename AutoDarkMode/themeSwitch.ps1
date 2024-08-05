# Parameter help description
param (
    [Parameter(Position = 0, Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'The type of theme to use.')]
    [ValidateSet('light', 'dark')]
    $theme
)
Import-Module C:\Users\legor\.config\powershell\module\module.psd1

$scoopRoot = ((scoop config root_path) ?? "$env:USERPROFILE/scoop")
$flowSettingsPath = "$scoopRoot\persist\flow-launcher\UserData\Settings\Settings.json"
$flow = Get-Content -Path $flowSettingsPath | ConvertFrom-Json
$flowThemePath = "$scoopRoot\persist\flow-launcher\UserData\Themes"

if ($null -eq $theme) {
    $theme = (Get-Item HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize).GetValue('AppsUseLightTheme', 1) ? 'light' : 'dark'
}

if ($theme -eq 'dark') {
    Set-WindowsTerminalScheme -preview -name 'Catppuccin Mocha'
    Set-WindowsTerminalScheme -name 'Catppuccin Mocha'
    $flow.Theme = 'Catppuccin Mocha'
    # ? flow-launcher does not auto detect changes in the settings.json
    $flow | ConvertTo-Json | Set-Content -Path $flowSettingsPath

}
else {
    Set-WindowsTerminalScheme -preview -name 'Catppuccin Latte'
    Set-WindowsTerminalScheme -name 'Catppuccin Latte'
    $flow.Theme = 'Catppuccin Latte'
    $flow | ConvertTo-Json | Set-Content -Path $flowSettingsPath
}
"$flowThemePath\$($flow.Theme).xaml" | Copy-Item -Destination "$flowThemePath\Catppuccin.xaml"