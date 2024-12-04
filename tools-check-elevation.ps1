# Check if the script is running with Administrator privileges
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    # Relaunch the script as Administrator in the same PowerShell session
    Write-Host "Requesting elevated privileges..." -ForegroundColor Yellow
    Start-Process -FilePath "powershell" -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"$PSCommandPath`"" -Verb RunAs
    Exit
}

# Script is elevated
Write-Host "Running with elevated privileges..." -ForegroundColor Green

# Run the remote script
try {
    Write-Host "Running tools script..." -ForegroundColor Green
    irm https://raw.githubusercontent.com/tinkervalley/powershell-scripts/refs/heads/main/tools.ps1 | iex
} catch {
    Write-Host "Failed to download or execute tools.ps1" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Yellow
}

# Pause to allow viewing output (optional)
Write-Host "Script execution complete. Press Enter to exit." -ForegroundColor Cyan
Read-Host
