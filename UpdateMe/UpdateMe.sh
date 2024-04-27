#!/bin/bash

# UpdateMe is a simple shell script which detects what OS
# the script is running on and run the appropriate update command for that system
# then proceeds to check if snap, flatpak or Pacstall is installed
# and run the commands to check for updates for those too
#
# By vbrabandt2005 <vbrabandt@proton.me>

# Check for compatible OS file
if [ ! -f /etc/os-release ]; then
  printf "Error: This script seems not be to supported by this script.\n"
  #"Error: This script is only for systems with /etc/os-release file."
  exit 1
fi

# Identify the OS based on os-release content
os_name=$(grep -Eo '^ID=.*' /etc/os-release | cut -d= -f2- | tr -d '"')

# Update for Debian-based systems (including nala-apt check)
if command -v dpkg >/dev/null 2>&1; then
  # Likely a Debian-based system, use apt (or nala) commands
  printf "Detected Debian/Ubuntu-based system\n"
  if command -v nala >/dev/null 2>&1; then
    # nala-apt exists, use nala commands
    printf "nala found, using nala to update...\n"
    sudo nala update && sudo nala full-upgrade
  else
    # nala-apt not found, use apt commands
    printf "nala not found, using apt to update...\n"
    sudo apt update && sudo apt full-upgrade
  fi
  
  # Check for and update with pactall (if installed)
  if command -v pacstall >/dev/null 2>&1; then
    printf "pactall is installed, will check for pactall updates...\n"
    pacstall -U && pacstall -Up
    else
    printf "Flatpak is not found, will skip checking flatpak updates.\n"
  fi
fi

# Update Arch Linux (including yay & paru check)
if [[ "$os_name" == arch ]]; then
  if command -v paru >/dev/null 2>&1; then
    printf "Detected Arch Linux, updating with paru..."
    paru
  elif command -v yay >/dev/null 2>&1; then
    printf "Detected Arch Linux, updating with yay..."
    yay
  else
    printf "Detected Arch Linux, unable to find paru or yay, updating with pacman..."
    sudo pacman -Syu
  fi
fi

# Update EndeavourOS 
# (honestly idk why I have this, considering eos-update is just a frontend for pacman, yay & paru)
if [[ "$os_name" == endeavouros ]]; then
  if command -v paru >/dev/null 2>&1; then
    argu=--paru
    endy=paru
  elif command -v yay >/dev/null 2>&1; then
    argu=--yay
    endy=yay
  fi
  printf "Detected EndeavourOS, updating with eos-update with %s$endy...\n"
  eos-update "$argu"
fi

echo

# Update snaps (if installed)
if command -v snap >/dev/null 2>&1; then
  printf "Snap is installed, will check for snap updates...\n"
  sudo snap refresh
else
  printf "Snap is not found, will skip checking snap updates."
fi

echo

# Update flatpaks (if installed)
if command -v flatpak >/dev/null 2>&1; then
  printf "Flatpak is installed, will check for flatpak updates...\n"
  flatpak update
else
  printf "Flatpak is not found, will skip checking flatpak updates.\n"
fi

printf "All update checks complete."
