Write-Host "Hey there 😘"
Write-Host "We're going to setup you're powershell to beatufil as I'd like !^_^!"
Write-Host "Press any key to continue..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

# remove favourites cuz what the heck do it even do
# remove links dir cuz again what dat do doh

#? create syms for onedrive (ex. documents, and stuff)

# seetup my set-psenv
gh repo clone https://github.com/ravensorb/Set-PsEnv

Set-Location "$env:userprofile/scoop/modules"
mv Set-PsEnv ./Set-PsEnv

# symlink nvim path to .config