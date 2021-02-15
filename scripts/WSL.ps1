# WSL2 installation
choco install -y Microsoft-Windows-Subsystem-Linux --source="'windowsfeatures'"
RefreshEnv
choco install -y wsl2
RefreshEnv
choco install -y wsl-ubuntu-2004

# Update and upgrade WSL2
wsl -u root apt update
wsl -u root apt upgrade -y