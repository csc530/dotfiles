<#
..######...#######..##.....##.########..##.......########.########.########.########...######.
.##....##.##.....##.###...###.##.....##.##.......##..........##....##.......##.....##.##....##
.##.......##.....##.####.####.##.....##.##.......##..........##....##.......##.....##.##......
.##.......##.....##.##.###.##.########..##.......######......##....######...########...######.
.##.......##.....##.##.....##.##........##.......##..........##....##.......##...##.........##
.##....##.##.....##.##.....##.##........##.......##..........##....##.......##....##..##....##
..######...#######..##.....##.##........########.########....##....########.##.....##..######.
#>

Write-Host "`rSetting up completers..." -NoNewline

# scoop completer
# Import-Module "$($(Get-Item $(Get-Command scoop.ps1).Path).Directory.Parent.FullName)\modules\scoop-completion"
Import-Module scoop-completion
# vincent - terminal colour scheme viewer/generator
vincent _carapace powershell | Out-String | Invoke-Expression
# my beatful markdown viewer
glow completion powershell | Out-String | Invoke-Expression
pop completion powershell | Out-String | Invoke-Expression
# gum completion powershell | Out-String | Invoke-Expression ## no powershell option yet
vhs completion powershell | Out-String | Invoke-Expression
# terminal prompt themeP
oh-my-posh completion powershell | Out-String | Invoke-Expression
# 1password
op completion powershell | Out-String | Invoke-Expression

# winget completer
# https://learn.microsoft.com/en-us/windows/package-manager/winget/tab-completion
Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)
    [Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()
    $Local:word = $wordToComplete.Replace('"', '""')
    $Local:ast = $commandAst.ToString().Replace('"', '""')
    winget complete --word="$Local:word" --commandline "$Local:ast" --position $cursorPosition | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
    }
}

# PowerShell parameter completion shim for the dotnet CLI
Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)
    dotnet complete --position $cursorPosition "$commandAst" | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
    }
}


Import-Module myMod
Mount-CarapaceCompleters

Write-Host '✅'