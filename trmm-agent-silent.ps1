# Check if the script is running with administrator privileges
if (-NOT (Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\System\EnableLUA") -or !(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\System")) {
    $arguments = "-NoProfile -ExecutionPolicy Bypass -File $PSCommandPath"
    Start-Process powershell -Verb runAs -ArgumentList $arguments
    exit
}

# Define the download URL and file path
$url = "https://github.com/amidaware/rmmagent/releases/download/v2.8.0/tacticalagent-v2.8.0-windows-amd64.exe"
$downloadPath = "$env:TEMP\tacticalagent-v2.8.0-windows-amd64.exe"

# Use BITS to download the file
Write-Host "Downloading the file..."
Start-BitsTransfer -Source $url -Destination $downloadPath

# Wait for the download to complete
Write-Host "Download complete. Installing TacticalAgent..."

# Install the downloaded file with the given command
Start-Process -FilePath $downloadPath -ArgumentList "/VERYSILENT /SUPPRESSMSGBOXES" -Wait

# Wait 10 seconds before running the next command (simulating 'ping' delay)
Start-Sleep -Seconds 10

# Run the final command to install TacticalAgent using Start-Process
$installCommand = "C:\Program Files\TacticalAgent\tacticalrmm.exe"
$arguments = "-m", "install", "--api", "https://api.tinkervalley.ca", "--client-id", "3", "--site-id", "3", "--agent-type", "workstation", "--auth", "5dc6b4395afc11b841b95aeb9b950e36d5622e2420af97a3171f37ffd5914d45"

Start-Process -FilePath $installCommand -ArgumentList $arguments -Wait

Write-Host "Installation completed."
