# Display the menu
$choice = Read-Host "Select the version to download:
1. Microsoft 365 Pro Plus x64
2. Microsoft Office 2024 Pro Plus x64"

# Set download URLs
$O365Link = "https://raw.githubusercontent.com/tinkervalley/powershell-scripts/refs/heads/main/tools/office/O365ProPlus64.exe"
$O2024Link = "https://raw.githubusercontent.com/tinkervalley/powershell-scripts/refs/heads/main/tools/office/O2024ProPlus64.exe"

# Function to download and execute the file using BITS
function Download-And-Execute {
    param (
        [string]$url
    )

    try {
        # Initialize BITS transfer job
        Write-Host "Starting download from: $url"
        $bitsJob = Start-BitsTransfer -Source $url -Destination "$env:TEMP\office_installer.exe" -Asynchronous

        # Wait for download to complete
        Write-Host "Downloading... Please wait."
        while ($bitsJob.JobState -eq 'Transferring') {
            Start-Sleep -Seconds 1
        }

        # Log the job state
        Write-Host "Download complete. Job state: $($bitsJob.JobState)"
        
        # Execute the downloaded file
        if ($bitsJob.JobState -eq 'Transferred') {
            Write-Host "Executing the downloaded installer..."
            Start-Process -FilePath "$env:TEMP\office_installer.exe" -Wait
        } else {
            Write-Host "Download failed. Job state: $($bitsJob.JobState)"
        }
    } catch {
        Write-Host "Error during download: $_"
    }

    # Close the PowerShell window
    exit
}

# Perform the action based on user's choice
switch ($choice) {
    1 {
        Download-And-Execute -url $O365Link
    }
    2 {
        Download-And-Execute -url $O2024Link
    }
    default {
        Write-Host "Invalid choice. Please run the script again and select a valid option."
        exit
    }
}
