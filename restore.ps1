function restore () {
    Write-Output well hello there handsome; all ready to start over again are we?
    Write-Output well first things first let's make things a little sexier'

    $hasGum = $null

    if (Get-Command gum) {
        $hasGum = $true
        gum log 'oh look at you with your gum
        gum log well let`'s get this party started
    }
    else {
        $hasGum = $false
        Write-Host awww no gum 🫧💥
        Write-Host well that's too bad this could have been that much more fun. Well let's set it up anyhow
    }

    Add-Scoop $hasGum

    # remove favourites cuz what the heck do it even do
    # remove links dir cuz again what dat do doh

    #? create syms for onedrive (ex. documents, and stuff)

    # seetup my set-psenv
    gh repo clone https://github.com/ravensorb/Set-PsEnv

    Set-Location "$env:userprofile/scoop/modules"
    Move-Item Set-PsEnv ./Set-PsEnv

    # symlink nvim path to .config

    #sym links bat config dir with castpuccin themes
    # https://github.com/sharkdp/bat#adding-new-themes
}

$yes = @('y', 'yes')
$no = @('n', 'no' )
$yesno = $yes + $no


function Add-Scoop ([bool]$gum) {
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
    Invoke-RestMethod -Uri https://get.scoop.sh | Out-File -FilePath $env:temp\scoop.ps1
    $scoopConfig = @{global = $null; local = $null }
    if ($gum) {
        for ($i = 0; $i -lt $scoopConfig.Count; $i++) {
            $scoopDir = $null
            if (gum confirm "change scoop $($scoopConfig.Keys[$i]) dir?") {
                while ($null -eq $scoopDir) {
                    $scoopDir = gum input "enter new scoop $($scoopConfig.Keys[$i]) dir"
                    if ([string]::IsNullOrWhiteSpace($scoopDir) -or !(Test-Path -Path $scoopDir)) {
                        $scoopDir = $null
                        gum log --level error "path does not exist"
                    }
                }
            }
            $scoopConfig.Keys[$i] = $scoopDir
        }
    }
    else {
        for ($i = 0; $i -lt $scoopConfig.Count; $i++) {
            $changeScoopDir = $null
            while ($null -eq $changeScoopDir) {
                $changeScoopDir = Read-Host -Prompt "change scoop $($scoopConfig.Keys[$i]) dir? (y/n)"
                if ($changeScoopDir -inotin $yesno) {
                    $changeScoopDir = $null
                }
            }
            if ($changeScoopDir -iin $yes) {
                while ($null -eq $scoopDir) {
                    $scoopDir = Read-Host -Prompt "`renter new scoop $($scoopConfig.Keys[$i]) dir"
                    if ([string]::IsNullOrWhiteSpace($scoopDir) -or !(Test-Path -Path $scoopDir)) {
                        $scoopDir = $null
                        Write-Host -ForegroundColor Red "`rpath does not exist" -NoNewline
                    }
                }
            }
            $scoopConfig.Keys[$i] = $scoopDir
        }
    }
    & $env:temp\scoop.ps1 -scoopDir:$scoopConfig.local -scoopGlobalDir:$scoopConfig.global
}