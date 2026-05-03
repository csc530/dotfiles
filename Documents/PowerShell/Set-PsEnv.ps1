param(
	 [ValidateScript({
           if(-Not ($_ | Test-Path -PathType Leaf) )
                throw "The path does not exist"
            return $true
        })]
	[FileInfo]$path = "./.env"
)

$content = Get-Content $path
