# Check if the script is running with Administrator privileges
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    # Relaunch the script as Administrator
    $scriptPath = $MyInvocation.MyCommand.Path
    Start-Process powershell -ArgumentList "-NoExit -NoProfile -ExecutionPolicy Bypass -File `"$scriptPath`"" -Verb RunAs
    Exit
}

# Script is elevated, now run the main script
$mainScriptPath = ".\tools.ps1"  # Ensure the path is correct for your environment
if (Test-Path $mainScriptPath) {
    Start-Process powershell -ArgumentList "-NoExit -NoProfile -ExecutionPolicy Bypass -File `"$mainScriptPath`""
} else {
    Write-Host "Could not find tools.ps1 at $mainScriptPath" -ForegroundColor Red
    Read-Host "Press Enter to exit"
}
