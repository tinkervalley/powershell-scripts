# Define the uninstaller path
$uninstallerPath = "C:\Program Files\TacticalAgent\unins000.exe"

# Check if the uninstaller exists
if (Test-Path -Path $uninstallerPath) {
    Write-Host "Uninstaller found. Running uninstaller..."
    Start-Process -FilePath $uninstallerPath -ArgumentList "/VERYSILENT" -Wait
    Write-Host "Uninstallation completed."
} else {
    Write-Host "No uninstaller found. Skipping uninstallation."
}

# Define the download URL
$url = "https://github.com/amidaware/rmmagent/releases/download/v2.8.0/tacticalagent-v2.8.0-windows-amd64.exe"

# Get the temporary directory and define the file name
$tempDir = [System.IO.Path]::GetTempPath()
$fileName = "trmm-agent-tinkervalley.exe"

# Combine the temp directory with the file name to create the full download path
$downloadPath = Join-Path -Path $tempDir -ChildPath $fileName

# Output the download path for debugging
# Write-Host "Download path: $downloadPath"

# Use BITS to download the file
Write-Host "Downloading the file..."
Start-BitsTransfer -Source $url -Destination $downloadPath

# Continue with the installation process
Write-Host "Download complete. Installing TacticalAgent..."
Start-Process -FilePath $downloadPath -ArgumentList "/VERYSILENT /SUPPRESSMSGBOXES" -Wait

# Wait 10 seconds
Start-Sleep -Seconds 10

# Define the final installation command and arguments
$installCommand = "C:\Program Files\TacticalAgent\tacticalrmm.exe"
$arguments = "-silent", "-m", "install", "--api", "https://api.tinkervalley.ca", "--client-id", "3", "--site-id", "3", "--agent-type", "workstation", "--auth", "5dc6b4395afc11b841b95aeb9b950e36d5622e2420af97a3171f37ffd5914d45"

# Run the final installation command
Write-Host "Running TacticalAgent installation command..."
Start-Process -FilePath $installCommand -ArgumentList $arguments -Wait

Write-Host "Installation completed."
