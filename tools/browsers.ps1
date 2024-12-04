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

function Download-Chrome {
    Write-Host "Downloading Google Chrome..."
    $chromeUrl = "https://dl.google.com/chrome/install/latest/chrome_installer.exe"
    $chromeInstaller = "$env:temp\chrome_installer.exe"

    Start-BitsTransfer -Source $chromeUrl -Destination $chromeInstaller

    Write-Host "Installing Google Chrome..."
    Start-Process -FilePath $chromeInstaller -Args "/silent /install" -Wait
    Write-Host "Google Chrome has been installed."

    Show-Notification -title "Installation Complete" -message "Google Chrome has been successfully installed!"
    Exit
}

function Download-Firefox {
    Write-Host "Downloading Mozilla Firefox..."
    $firefoxUrl = "https://download.mozilla.org/?product=firefox-latest&os=win&lang=en-US"
    $firefoxInstaller = "$env:temp\firefox_installer.exe"

    Start-BitsTransfer -Source $firefoxUrl -Destination $firefoxInstaller

    Write-Host "Installing Mozilla Firefox..."
    Start-Process -FilePath $firefoxInstaller -Args "/silent" -Wait
    Write-Host "Mozilla Firefox has been installed."

    Show-Notification -title "Installation Complete" -message "Mozilla Firefox has been successfully installed!"
    Exit
}

# Function to show the menu and call respective download functions
function Show-Menu {
    Write-Host "Select a browser to install:"
    Write-Host "1. Google Chrome"
    Write-Host "2. Firefox"
    Write-Host "3. Exit"
}

function Install-Browser {
    Show-Menu
    $choice = Read-Host "Enter your choice (1/2/3)"
    
    switch ($choice) {
        1 {
            Download-Chrome
            break
        }
        2 {
            Download-Firefox
            break
        }
        3 {
            Write-Host "Exiting the script."
            Exit
            break
        }
        default {
            Write-Host "Invalid choice. Please select a valid option."
            Install-Browser
            break
        }
    }
}

# Run the script
Install-Browser
