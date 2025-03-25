#!/bin/bash

# Display loading message
echo "Loading script..."

# Define the URL of the script
SCRIPT_URL="https://raw.githubusercontent.com/tinkervalley/powershell-scripts/refs/heads/main/tools-mac/start.sh"

# Download and execute the script with sudo
curl -fsSL "$SCRIPT_URL" | sudo bash
