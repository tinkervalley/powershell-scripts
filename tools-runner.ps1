# PowerShell script to load the main menu and run a remote script as admin
Write-Host "Loading main menu..." -BackgroundColor Blue -ForegroundColor White
Start-Sleep -Seconds 2

# Execute the remote script with 'runas' to ensure it's run as admin
Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"irm https://raw.githubusercontent.com/tinkervalley/powershell-scripts/main/tools.ps1 | iex`"" -Verb RunAs
