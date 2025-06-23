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
$url = "https://github.com/amidaware/rmmagent/releases/download/v2.9.1/tacticalagent-v2.9.1-windows-amd64.exe"

# Get the temporary directory and define the file name
$tempDir = [System.IO.Path]::GetTempPath()
$fileName = "trmm-agent-tinkervalley.exe"
$downloadPath = Join-Path -Path $tempDir -ChildPath $fileName

# Download the file
Write-Host "Downloading TacticalAgent..."
try {
    Invoke-WebRequest -Uri $url -OutFile $downloadPath -UseBasicParsing -ErrorAction Stop
    Write-Host "Download completed successfully."
} catch {
    Write-Host "Error downloading TacticalAgent: $_"
    exit 1
}

# Verify that the file exists and is not empty
if (-Not (Test-Path $downloadPath)) {
    Write-Host "Downloaded file does not exist. Aborting."
    exit 1
}

$fileInfo = Get-Item $downloadPath
if ($fileInfo.Length -eq 0) {
    Write-Host "Downloaded file is empty. Aborting."
    exit 1
}

# Run the installer silently
Write-Host "Installing TacticalAgent..."
Start-Process -FilePath "`"$downloadPath`"" -ArgumentList "/VERYSILENT /SUPPRESSMSGBOXES" -Wait

# Wait 10 seconds to allow services to register
Start-Sleep -Seconds 10

# Define the tacticalrmm.exe command and arguments
$installCommand = "C:\Program Files\TacticalAgent\tacticalrmm.exe"
$arguments = @(
    "-silent",
    "-m", "install",
    "--api", "https://api.tinkervalley.ca",
    "--client-id", "3",
    "--site-id", "3",
    "--agent-type", "workstation",
    "--auth", "5dc6b4395afc11b841b95aeb9b950e36d5622e2420af97a3171f37ffd5914d45"
)

# Run the TacticalAgent final install command
Write-Host "Running tacticalrmm.exe with arguments..."
Start-Process -FilePath "`"$installCommand`"" -ArgumentList $arguments -Wait

Write-Host "Installation completed successfully."

# Optional: Clean up temp file
# Remove-Item $downloadPath -Force
