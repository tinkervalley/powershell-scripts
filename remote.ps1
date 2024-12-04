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
function Install-RustDesk {
    Write-Host "Downloading RustDesk..."

    # URL of the RustDesk installer
    $url = 'https://github.com/tinkervalley/rustdesk/releases/download/nightly/rustdesk-1.3.4-x86_64.exe'
    $installerPath = "$env:TEMP\rustdesk-installer.exe"

    # Download the installer using BITS
    Start-BitsTransfer -Source $url -Destination $installerPath

    Write-Host "Running RustDesk installer silently..."
    
    # Run the installer silently with the --silent-install flag
    Start-Process -FilePath $installerPath -ArgumentList '--silent-install' -Verb runAs -Wait

    # Notify the user that installation is complete
    Show-Notification -title "Installation Complete" -message "The installation of RustDesk is complete."

    # Optionally, remove the installer after installation
    Remove-Item -Path $installerPath -Force
}

# Run the installation function
Install-RustDesk
