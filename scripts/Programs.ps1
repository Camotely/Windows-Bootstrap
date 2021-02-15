# Package installation

$Packages = @(
    "VisualStudioCode"
    "pycharm-professional"
    "powershell-core"
    "microsoft-teams"
    "slack"
    "7zip"
    "sysinternals"
    "powertoys"
    "microsoft-windows-terminal"
)

ForEach ($PackageName in $Packages)
{
    choco install $PackageName -y
}
