# Display the menu
$choice = Read-Host "Select the version to download:
1. Microsoft 365 Pro Plus x64
2. Microsoft Office 2024 Pro Plus x64"

# Set download links
$O365Link = "https://raw.githubusercontent.com/tinkervalley/powershell-scripts/refs/heads/main/tools/office/O365ProPlus64.exe"
$O2024Link = "https://raw.githubusercontent.com/tinkervalley/powershell-scripts/refs/heads/main/tools/office/O2024ProPlus64.exe"

# Set file names
$O365File = "O365ProPlus64.exe"
$O2024File = "O2024ProPlus64.exe"

# Function to download and execute the file
function Download-And-Execute {
    param (
        [string]$url,
        [string]$fileName
    )

    # Download the file
    Write-Host "Downloading $fileName..."
    Invoke-WebRequest -Uri $url -OutFile $fileName

    # Execute the downloaded file
    Write-Host "Executing $fileName..."
    Start-Process -FilePath $fileName

    # Close the PowerShell window
    exit
}

# Perform the action based on user's choice
switch ($choice) {
    1 {
        Download-And-Execute -url $O365Link -fileName $O365File
    }
    2 {
        Download-And-Execute -url $O2024Link -fileName $O2024File
    }
    default {
        Write-Host "Invalid choice. Please run the script again and select a valid option."
        exit
    }
}
