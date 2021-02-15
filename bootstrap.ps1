# BoxStarter + Chocolatey Bootstrapper
# http://boxstarter.org/package/url?https://raw.githubusercontent.com/Camotely/Windows-Bootstrap/main/test.ps1

# Disabling until the end of the bootstrap process
Disable-UAC

# Ensure that installing Powershell modules don't prompt for dependencies
$ConfirmPreference = "None"

$scriptUri = "https://raw.githubusercontent.com/Camotely/Windows-Boostrap/main/scripts"
function executeScript {
    Param ([string]$script)
    Write-Host "Running $script..."
        Invoke-Expression ((New-Object net.webclient).DownloadString("$scriptUri/$script"))
}

executeScript "FileExplorer.ps1";
executeScript "Debloat.ps1";
executeScript "Programs.ps1";

executeScript "Hyper-V.ps1";
RefreshEnv
executeScript "WSL.ps1";

# Re-enabling UAC
Enable-UAC

# Enable Windows Updates
Enable-MicrosoftUpdate

# Install Windows Updates
Install-WindowsUpdate -acceptEula