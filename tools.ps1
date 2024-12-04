# PowerShell script to load the main menu, close the current window, and run a remote script as admin in a new window
Write-Host "Loading main menu..." -BackgroundColor Blue -ForegroundColor White
Start-Sleep -Seconds 2

# Close the current window
exit

# Execute the remote script in a new PowerShell window with 'runas', white background, black text, and smaller size
Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"irm https://raw.githubusercontent.com/tinkervalley/powershell-scripts/main/tools/start.ps1 | iex`"" -Verb RunAs -WindowStyle Normal

# Customize the appearance of the new window (background color, text color, and size)
$Host.UI.RawUI.BackgroundColor = "White"
$Host.UI.RawUI.ForegroundColor = "Black"
$Host.UI.RawUI.WindowSize = New-Object Management.ManagementObject("System.Management.ManagementClass").GetMethod("WindowSize").Invoke($Host.UI.RawUI, @([System.Management.ManagementObject]::new("Width", 80, "Height", 25)))
$Host.UI.RawUI.Flush()
