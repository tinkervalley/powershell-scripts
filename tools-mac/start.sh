#!/bin/bash

# Function to display the menu
display_menu() {
  echo "Please select an option:"
  echo "1. Install Office"
  echo "2. Install Programs"
  echo "3. Install Agent"
  echo "4. Exit"
}

# Function to handle user input and execute the corresponding script
handle_selection() {
  case $1 in
    1)
      echo "Installing Office..."
      curl -fsSL https://raw.githubusercontent.com/tinkervalley/powershell-scripts/refs/heads/main/tools-mac/office.sh | sudo bash
      ;;
    2)
      echo "Installing Programs..."
      curl -fsSL https://raw.githubusercontent.com/tinkervalley/powershell-scripts/refs/heads/main/tools-mac/software.sh | sudo bash
      ;;
    3)
      echo "Installing Agent..."
      curl -fsSL https://raw.githubusercontent.com/tinkervalley/powershell-scripts/refs/heads/main/tools-mac/trmmagent.sh | sudo bash
      ;;
    4)
      echo "Exiting... Goodbye!"
      exit 0
      ;;
    *)
      echo "Invalid selection. Please try again."
      ;;
  esac
}

# Main script loop
while true; do
  display_menu
  read -p "Enter your choice: " choice
  handle_selection "$choice"
done
