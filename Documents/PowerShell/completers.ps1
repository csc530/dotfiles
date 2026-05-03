# COMPLETERS
# my beatful markdown viewer
carapace _carapace powershell | Out-String | Invoke-Expression
glow completion powershell | Out-String | Invoke-Expression
pop completion powershell | Out-String | Invoke-Expression
# gum completion powershell | Out-String | Invoke-Expression ## no powershell option yet
vhs completion powershell | Out-String | Invoke-Expression
# terminal prompt theme
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
