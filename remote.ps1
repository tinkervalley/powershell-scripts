# Function to show a Windows notification
function Show-Notification {
    param (
        [string]$title,
        [string]$message
    )
    # Create a new toast notification using Windows Script Host
    $shell = New-Object -ComObject WScript.Shell
    $shell.Popup($message, 5, $title, 0x40)  # 0x40 = Information icon
}

# Function to download and install RustDesk using BITS
function Install-Agent {
    Write-Host "Downloading Support Agent..."

    # URL of the Agent installer
    $url = 'https://raw.githubusercontent.com/tinkervalley/powershell-scripts/refs/heads/main/meshagent-support.exe'
    $installerPath = "$env:TEMP\meshagent64-support.exe"

    # Download the installer using BITS
    Start-BitsTransfer -Source $url -Destination $installerPath

    Write-Host "Installing Support Agent..."
    
    # Run the installer silently with the --silent-install flag
    Start-Process -FilePath $installerPath -ArgumentList '-fullinstall' -Verb runAs -Wait

    # Notify the user that installation is complete
    Show-Notification -title "Installation Complete" -message "The installation of the Support Agent is complete."

    # Optionally, remove the installer after installation
    Remove-Item -Path $installerPath -Force
}

# Run the installation function
Install-Agent
