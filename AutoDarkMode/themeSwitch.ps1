# Parameter help description
param (
    [Parameter(Position = 0, Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'The type of theme to use.')]
    [ValidateSet('light', 'dark')]
    $theme
)
Import-Module C:\Users\legor\.config\powershell\module\module.psd1

if ($null -eq $theme) {
    $theme = (Get-Item HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize).GetValue('AppsUseLightTheme', 1) ? 'light' : 'dark'
}

if ($theme -eq 'dark') {
    Set-WindowsTerminalScheme -preview -name 'Catppuccin Mocha'
    Set-WindowsTerminalScheme -name 'Catppuccin Mocha'
}
else {
    Set-WindowsTerminalScheme -preview -name 'Catppuccin Latte'
    Set-WindowsTerminalScheme -name 'Catppuccin Latte'
}