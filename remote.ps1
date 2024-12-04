$command = 'irm https://github.com/tinkervalley/rustdesk/releases/download/nightly/rustdesk-1.3.4-x86_64.exe -OutFile "$env:TEMP\rustdesk-installer.exe"'

# Download the installer first
Invoke-Expression $command

# Run the installer silently with the --silent-install flag
Start-Process "$env:TEMP\rustdesk-installer.exe" -ArgumentList '--silent-install' -Verb runAs

# Wait for the installation to finish
Start-Sleep -Seconds 10  # Adjust if needed based on the expected installation time

# Display a notification using Windows Forms
Add-Type -AssemblyName "System.Windows.Forms"
[System.Windows.Forms.MessageBox]::Show("The installation of RustDesk is complete.", "Installation Complete")
