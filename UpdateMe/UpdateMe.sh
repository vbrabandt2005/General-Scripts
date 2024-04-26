#!/bin/bash

# Check for compatible OS file
if [ ! -f /etc/os-release ]; then
  echo "Error: This script is only for systems with /etc/os-release file."
  exit 1
fi

# Identify the OS based on os-release content
os_name=$(grep -Eo '^ID=.*' /etc/os-release | cut -d= -f2- | tr -d '"')

# Update for Debian-based systems (including nala-apt check)
if command -v dpkg >/dev/null 2>&1; then
  # Likely a Debian-based system, use apt commands (adjust as needed)
  echo "Detected Debian-based system, using apt..."
  if command -v nala >/dev/null 2>&1; then
    # nala-apt exists, use nala commands
    echo "Using nala for update and upgrade..."
    sudo nala update && sudo nala full-upgrade
  else
    # nala-apt not found, use apt commands
    echo "nala-apt not found, using apt..."
    sudo apt update && sudo apt full-upgrade
  fi
  
  # Check for and update with pactall (if installed)
  if command -v pacstall >/dev/null 2>&1; then
    echo "pactall is installed, will check for pactall updates..."
    pacstall -U && pacstall -Up
  fi
fi

# Update EndeavourOS
if [[ "$os_name" == endeavouros ]]; then
  echo "Detected EndeavourOS, updating..."
  eos-update --paru
fi

# Update Arch Linux (including yay check)
if [[ "$os_name" == arch ]]; then
  if command -v yay >/dev/null 2>&1; then
    echo "Detected Arch Linux, updating with yay..."
    yay -Syu --devel
  else
    echo "Detected Arch Linux, updating with pacman..."
    sudo pacman -Syyu
  fi
fi

# Update snaps (if installed)
if command -v snap >/dev/null 2>&1; then
  echo "snap is installed, will check for snap updates..."
  snap refresh
else
  echo "snap is not found, will skip checking snap updates."
fi

# Update flatpaks (if installed)
if command -v flatpak >/dev/null 2>&1; then
  echo "flatpak is installed, will check for flatpak updates..."
  flatpak update
else
  echo "flatpak is not found, will skip checking flatpak updates."
fi

echo "All update checks complete."
