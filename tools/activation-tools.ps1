# Define the URL of the .cmd file
$url = "https://raw.githubusercontent.com/tinkervalley/Microsoft-Activation-Scripts/refs/heads/master/MAS/All-In-One-Version-KL/MAS_AIO.cmd"

# Define the local path to save the .cmd file
$localPath = "$env:temp\MAS_AIO.cmd"

# Download the .cmd file from the URL
Invoke-WebRequest -Uri $url -OutFile $localPath

# Execute the .cmd file in a new window using cmd.exe
Start-Process -FilePath "cmd.exe" -ArgumentList "/c $localPath"
