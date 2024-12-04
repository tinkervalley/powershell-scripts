# PowerShell Script to download and install Google Chrome or Firefox with progress bar

function Download-Chrome {
    Write-Host "Downloading Google Chrome..."
    $chromeUrl = "https://dl.google.com/chrome/install/latest/chrome_installer.exe"
    $chromeInstaller = "$env:temp\chrome_installer.exe"
    
    # Download with progress bar
    $progress = New-Object -TypeName PSCustomObject -Property @{PercentComplete = 0; Status = "Downloading..."}
    Invoke-WebRequest -Uri $chromeUrl -OutFile $chromeInstaller -ProgressVariable progress

    # Monitor the progress
    while ($progress.PercentComplete -lt 100) {
        Write-Progress -PercentComplete $progress.PercentComplete -Status $progress.Status -Activity "Downloading Google Chrome"
        Start-Sleep -Seconds 1
    }
    
    Write-Host "Installing Google Chrome..."
    Start-Process -FilePath $chromeInstaller -Args "/silent /install" -Wait
    Write-Host "Google Chrome has been installed."
}

function Download-Firefox {
    Write-Host "Downloading Mozilla Firefox..."
    $firefoxUrl = "https://download.mozilla.org/?product=firefox-latest&os=win&lang=en-US"
    $firefoxInstaller = "$env:temp\firefox_installer.exe"
    
    # Download with progress bar
    $progress = New-Object -TypeName PSCustomObject -Property @{PercentComplete = 0; Status = "Downloading..."}
    Invoke-WebRequest -Uri $firefoxUrl -OutFile $firefoxInstaller -ProgressVariable progress

    # Monitor the progress
    while ($progress.PercentComplete -lt 100) {
        Write-Progress -PercentComplete $progress.PercentComplete -Status $progress.Status -Activity "Downloading Mozilla Firefox"
        Start-Sleep -Seconds 1
    }

    Write-Host "Installing Mozilla Firefox..."
    Start-Process -FilePath $firefoxInstaller -Args "/silent" -Wait
    Write-Host "Mozilla Firefox has been installed."
}

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
