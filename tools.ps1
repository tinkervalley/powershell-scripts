# Check if the script is running with Administrator privileges
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    # Relaunch the script as Administrator
    $scriptPath = $MyInvocation.MyCommand.Path
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$scriptPath`"" -Verb RunAs
    exit
}

# Function to run external scripts
Function Run-ExternalScript {
    param ($scriptUrl)
    Start-Process powershell -ArgumentList "-NoExit", "-Command", "& { irm $scriptUrl | iex }" -Verb RunAs
}

# Main Menu Loop
do {
    Clear-Host
    Write-Host "Main Menu"
    Write-Host "1. Install Office"
    Write-Host "2. Run Activation Tools"
    Write-Host "3. Install Browsers"
    Write-Host "4. File Recovery"
    Write-Host "5. Declutter Windows"
    Write-Host "6. Anti-Malware Tools"
    Write-Host "7. Windows Easy Transfer"
    Write-Host "8. Other Software"
    Write-Host "9. Exit"
    
    $choice = Read-Host "Please enter a number"

    Switch ($choice) {
        1 {
            # Install Office
            $scriptUrl = "https://raw.githubusercontent.com/tinkervalley/powershell-scripts/refs/heads/main/tools/office-install.ps1"
            Run-ExternalScript -scriptUrl $scriptUrl
        }
        2 {
            # Run Activation Tools
            $scriptUrl = "https://raw.githubusercontent.com/tinkervalley/powershell-scripts/refs/heads/main/tools/activation-tools.ps1"
            Run-ExternalScript -scriptUrl $scriptUrl
        }
        3 {
            # Install Browsers
            $scriptUrl = "https://raw.githubusercontent.com/tinkervalley/powershell-scripts/refs/heads/main/tools/browsers.ps1"
            Run-ExternalScript -scriptUrl $scriptUrl
        }
        4 {
            # File Recovery
            $scriptUrl = "https://raw.githubusercontent.com/tinkervalley/powershell-scripts/refs/heads/main/tools/file-recovery.ps1"
            Run-ExternalScript -scriptUrl $scriptUrl
        }
        5 {
            # Declutter Windows
            $scriptUrl = "https://raw.githubusercontent.com/tinkervalley/powershell-scripts/refs/heads/main/tools/declutter-windows.ps1"
            Run-ExternalScript -scriptUrl $scriptUrl
        }
        6 {
            # Anti-Malware Tools
            $scriptUrl = "https://raw.githubusercontent.com/tinkervalley/powershell-scripts/refs/heads/main/tools/antimalware.ps1"
            Run-ExternalScript -scriptUrl $scriptUrl
        }
        7 {
            # Windows Easy Transfer
            $scriptUrl = "https://raw.githubusercontent.com/tinkervalley/powershell-scripts/refs/heads/main/tools/windows-easy-transfer.ps1"
            Run-ExternalScript -scriptUrl $scriptUrl
        }
        8 {
            # Other Software
            $scriptUrl = "https://raw.githubusercontent.com/tinkervalley/powershell-scripts/refs/heads/main/tools/other-software.ps1"
            Run-ExternalScript -scriptUrl $scriptUrl
        }
        9 {
            # Exit the script
            Write-Host "Exiting..."
            Exit
        }
        Default {
            Write-Host "Invalid choice, please select again."
        }
    }
    
    # Pause and wait for user to press any key before redisplaying menu
    Read-Host "Press Enter to return to the main menu"

} While ($true)
