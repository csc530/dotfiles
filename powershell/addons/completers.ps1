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

function Mount-carapace-Completers {
    # custom completers
    # ! carapace doesn't have an oh-my-posh completer
    # lazycomplete.exe omp "carapace oh-my-posh powershell" | Out-String | Invoke-Expression

    # https://rsteube.github.io/carapace-bin/setup.html#powershell
    Set-PSReadLineOption -Colors @{ 'Selection' = "`e[7m" }
    Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

    $apps = @()
    Get-Command -CommandType Application, Script, ExternalScript, Alias | ForEach-Object {
        $apps += remove-extension $_.Name
    }
    # $apps += Get-Command -All -CommandType Function, Cmdlet | Select-Object -Property Name | ForEach-Object { $_.Name }
    # $apps += Get-Alias | Select-Object Name | ForEach-Object { $_.Name }


    [System.Collections.Generic.List[string]]$carapace = carapace.exe --list # | Get-Random -Shuffle
    for ($i = 0; $i -lt $carapace.Count; $i++) {
        $cmd = $carapace[$i].Split()[0]
        if ($apps -inotcontains $cmd) {
            $skipped++
            continue
        }
        # https://github.com/rsteube/lazycomplete ~ for lazycomplete
        lazycomplete $cmd "carapace $cmd" | Out-String | Invoke-Expression
        # "carapace $cmd powershell;" | Out-String | Invoke-Expression | Out-Null
        $percentComplete = ($i / $carapace.Count) * 100
        Write-Progress -Activity "Setting up $cmd completer" -Status "$($percentComplete.ToString('0.00'))% complete" -PercentComplete $percentComplete
    }
    Write-Progress -Activity "Setting up $cmd completer" -Status "$percentComplete% complete:" -PercentComplete $percentComplete -Completed
    Write-Host "$($carapace.Count - $skipped) Carapace completions loaded" -ForegroundColor Green

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

}
# PowerShell parameter completion shim for the dotnet CLI
Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)
        dotnet complete --position $cursorPosition "$commandAst" | ForEach-Object {
            [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
        }
}

Write-Host '✅'