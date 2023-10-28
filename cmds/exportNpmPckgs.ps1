npm --global --parseable --depth=0 list | Select-Object -Skip 1 | ForEach-Object {
    $path = $_ | Out-String
    $name = ($path.Split([System.IO.Path]::DirectorySeparatorChar) | Select-Object -Last 1 | Out-String).Trim()
    Write-Output $name
}