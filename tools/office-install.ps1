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

# Function to download and execute the file using BITS
function Download-And-Execute {
    param (
        [string]$url,
        [string]$fileName
    )

    # Initialize BITS transfer job
    $bitsJob = Start-BitsTransfer -Source $url -Destination $fileName

    # Wait for download to complete
    Write-Host "Downloading $fileName using BITS..."
    while ($bitsJob.JobState -eq 'Transferring') {
        Start-Sleep -Seconds 1
    }

    # Check if the download was successful
    if ($bitsJob.JobState -eq 'Transferred') {
        Write-Host "Download complete."
        
        # Check if the file exists and execute it
        if (Test-Path $fileName) {
            Write-Host "Executing $fileName..."
            try {
                # Execute the downloaded file and wait for it to finish
                Start-Process -FilePath $fileName -Wait
            } catch {
                Write-Host "Error occurred while executing the file: $_"
            }
        } else {
            Write-Host "Downloaded file not found: $fileName"
        }
    } else {
        Write-Host "Download failed. Please try again."
    }

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
