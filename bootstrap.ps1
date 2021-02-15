# BoxStarter + Chocolatey Bootstrapper

# Disabling until the end of the bootstrap process
Write-Host "Disabling UAC" -ForegroundColor "Yellow"
Disable-UAC

# Ensure that installing Powershell modules don't prompt for dependencies
$ConfirmPreference = "None"

# Get the base URI path from the ScriptToCall value
$bstrappackage = "-bootstrapPackage"
$helperUri = $Boxstarter['ScriptToCall']
$strpos = $helperUri.IndexOf($bstrappackage)
$helperUri = $helperUri.Substring($strpos + $bstrappackage.Length)
$helperUri = $helperUri.TrimStart("'", " ")
$helperUri = $helperUri.TrimEnd("'", " ")
$strpos = $helperUri.LastIndexOf("/")
$helperUri = $helperUri.Substring(0, $strpos)
$helperUri += "/scripts"
write-host "helper script base URI is $helperUri"

# Function to run additional scripts against the scripts directory
function executeScript {
    Param ([string]$script)
    write-host "executing $helperUri/$script ..."
	iex ((new-object net.webclient).DownloadString("$helperUri/$script"))
}

# Basic install scripts
executeScript "FileExplorer.ps1";
executeScript "Debloat.ps1";
executeScript "Programs.ps1";

# Need reboots
executeScript "Hyper-V.ps1";
RefreshEnv
executeScript "WSL.ps1";

# Re-enabling UAC
Enable-UAC

# Enable Windows Updates
Enable-MicrosoftUpdate

# Install Windows Updates
Install-WindowsUpdate -acceptEula