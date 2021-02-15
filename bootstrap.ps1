# BoxStarter + Chocolatey Bootstrapper
# http://boxstarter.org/package/url?https://raw.githubusercontent.com/Camotely/Windows-Bootstrap/main/test.ps1

# Disabling until the end of the bootstrap process
Write-Host "Disabling UAC" -ForegroundColor "Yellow"
Disable-UAC

# Ensure that installing Powershell modules don't prompt for dependencies
$ConfirmPreference = "None"

#$scriptUri = "https://raw.githubusercontent.com/Camotely/Windows-Boostrap/main/scripts"

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

function executeScript {
    Param ([string]$script)
    write-host "executing $helperUri/$script ..."
	iex ((new-object net.webclient).DownloadString("$helperUri/$script"))
}

Write-Host "File Explorer" -ForegroundColor "Yellow"
executeScript "FileExplorer.ps1";
Write-Host "Debloat" -ForegroundColor "Yellow"
executeScript "Debloat.ps1";
Write-Host "Programs" -ForegroundColor "Yellow"
executeScript "Programs.ps1";

Write-Host "Hyper V" -ForegroundColor "Yellow"
executeScript "Hyper-V.ps1";
Write-Host "Refreshing" -ForegroundColor "Yellow"
RefreshEnv
Write-Host "WSL" -ForegroundColor "Yellow"
executeScript "WSL.ps1";

Write-Host "UAC" -ForegroundColor "Yellow"
# Re-enabling UAC
Enable-UAC

Write-Host "Enabling Updates" -ForegroundColor "Yellow"
# Enable Windows Updates
Enable-MicrosoftUpdate

Write-Host "Updating" -ForegroundColor "Yellow"
# Install Windows Updates
Install-WindowsUpdate -acceptEula