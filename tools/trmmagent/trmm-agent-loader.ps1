# PowerShell script to load the main menu, close the current window, and run a remote script as admin in a new window

# Display the loading message in the original window
Write-Host "Loading installer..." -BackgroundColor Blue -ForegroundColor White
Start-Sleep -Seconds 2


# Execute the remote script in a new PowerShell window with 'runas' and customize window appearance
Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"irm "https://raw.githubusercontent.com/tinkervalley/powershell-scripts/main/tools/trmmagent/trmm-agent.ps1" | iex`"" -Verb RunAs -WindowStyle Normal

exit
