# PowerShell script to download with BITS (Background Intelligent Transfer Service)
# and show a Windows notification after completion

function Show-Notification {
    param (
        [string]$title,
        [string]$message
    )
    # Create a new toast notification using Windows Script Host
    $shell = New-Object -ComObject WScript.Shell
    $shell.Popup($message, 5, $title, 0x40)  # 0x40 = Information icon
}

function Download-O365 {
    Write-Host "Downloading Microsoft 365 Pro Plus x64..."
    $O365Url = "https://raw.githubusercontent.com/tinkervalley/powershell-scripts/refs/heads/main/tools/office/O365ProPlus64.exe"
    $O365Installer = "$env:temp\O365ProPlus64.exe"

    # Start the download using BITS
    Start-BitsTransfer -Source $O365Url -Destination $O365Installer

    Write-Host "Starting installation of Microsoft 365 Pro Plus..."
    # Execute the downloaded installer (without silent flags)
    Start-Process -FilePath $O365Installer -Wait
    Write-Host "Microsoft 365 Pro Plus installation has completed."

    Show-Notification -title "Installation Complete" -message "Microsoft 365 Pro Plus has been successfully installed!"
    Exit
}

function Download-O2024 {
    Write-Host "Downloading Microsoft Office 2024 Pro Plus x64..."
    $O2024Url = "https://raw.githubusercontent.com/tinkervalley/powershell-scripts/refs/heads/main/tools/office/O2024ProPlus64.exe"
    $O2024Installer = "$env:temp\O2024ProPlus64.exe"

    # Start the download using BITS
    Start-BitsTransfer -Source $O2024Url -Destination $O2024Installer

    Write-Host "Starting installation of Microsoft Office 2024 Pro Plus..."
    # Execute the downloaded installer (without silent flags)
    Start-Process -FilePath $O2024Installer -Wait
    Write-Host "Microsoft Office 2024 Pro Plus installation has completed."

    Show-Notification -title "Installation Complete" -message "Microsoft Office 2024 Pro Plus has been successfully installed!"
    Exit
}

# Function to show the menu and call respective download functions
function Show-Menu {
    Write-Host "Select a version to install:"
    Write-Host "1. Microsoft 365 Pro Plus x64"
    Write-Host "2. Microsoft Office 2024 Pro Plus x64"
    Write-Host "3. Exit"
}

function Install-Office {
    Show-Menu
    $choice = Read-Host "Enter your choice (1/2/3)"
    
    switch ($choice) {
        1 {
            Download-O365
            break
        }
        2 {
            Download-O2024
            break
        }
        3 {
            Write-Host "Exiting the script."
            Exit
            break
        }
        default {
            Write-Host "Invalid choice. Please select a valid option."
            Install-Office
            break
        }
    }
}

# Run the script
Install-Office
