# Check if the script is running with Administrator privileges
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    # Relaunch the script as Administrator
    $scriptPath = $MyInvocation.MyCommand.Path
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$scriptPath`"" -Verb RunAs
    Exit
}

# Script is elevated, now run the main script
$mainScriptUrl = "https://raw.githubusercontent.com/tinkervalley/powershell-scripts/refs/heads/main/tools.ps1"
Start-Process powershell -ArgumentList "-NoExit", "-Command", "& { irm $mainScriptUrl | iex }" -Verb RunAs
