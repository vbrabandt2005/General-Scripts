#!/bin/bash
# Title: UpdateMe
# By vbrabandt2005 <vbrabandt@proton.me>

if [ -f /etc/os-release ]; then
  os_name=$(grep -Eo '^ID=.*' /etc/os-release | cut -d= -f2- | tr -d '"')
  os_like=$(grep -Eo '^ID_LIKE=.*' /etc/os-release | cut -d= -f2- | tr -d '"' | tr ',' ' ')
  printf "Linux system detected.\n"
  if command -v dpkg >/dev/null 2>&1 && [[ "$os_like" == debian || "$os_like" == ubuntu || "$os_like" == "ubuntu debian" ]]; then
    printf "Detected Debian/Ubuntu-based system\n"
    if command -v nala >/dev/null 2>&1; then
      printf "nala found, using nala to update...\n"
      sudo nala update && sudo nala full-upgrade
    elif command -v apt >/dev/null 2>&1; then
      printf "using apt to update...\n"
      sudo apt update && sudo apt full-upgrade
    else
      printf "What the? apt is not found.\n"
    fi
    if command -v pacstall >/dev/null 2>&1; then
      printf "pactall is installed, will check for pactall updates...\n"
      pacstall -U && pacstall -Up
      else
      printf "pacstall is not found, will skip checking pacstall updates.\n"
    fi
  elif command -v dnf >/dev/null 2>&1 && [[ "$os_name" == fedora ]]; then
    printf "Detected Fedora system\n"
    if command -v dnf >/dev/null 2>&1; then
      printf "dnf found, using dnf to update...\n"
      sudo dnf upgrade
    else
      printf "What the? dnf is not found\n"
    fi
  elif [[ "$os_name" == "arch" ]]; then
    if command -v paru >/dev/null 2>&1; then
      printf "Detected Arch Linux, updating with paru...\n"
      paru
    elif command -v yay >/dev/null 2>&1; then
      printf "Detected Arch Linux, updating with yay...\n"
      yay
    elif command -v pacman >/dev/null 2>&1; then
      printf "Detected Arch Linux, unable to find paru or yay, updating with pacman...\n"
      sudo pacman -Syu
    else
      printf "What the? pacman/yay/paru is not found.\n"
    fi
  elif [[ "$os_name" == endeavouros && "$os_like" == arch ]]; then
    if command -v eos-update >/dev/null 2>&1; then
      if command -v paru >/dev/null 2>&1; then
        argu=--paru
        endy=paru
      elif command -v yay >/dev/null 2>&1; then
        argu=--yay
        endy=yay
      fi
      printf "Detected EndeavourOS, updating with eos-update with %s$endy...\n"
      eos-update "$argu"
    else
      if command -v paru >/dev/null 2>&1; then
        printf "Detected EndeavourOS, but can't find eos-update, updating with paru...\n"
        paru
      elif command -v yay >/dev/null 2>&1; then
        printf "Detected EndeavourOS, but can't find eos-update, updating with yay...\n"
        yay
      elif command -v  pacman >/dev/null 2>&1; then
        printf "Detected EndeavourOS, but can't find eos-update (nor paru or yay), updating with pacman...\n"
        sudo pacman -Syu
      else
        printf "What the? pacman/yay/paru/eos-update is not found.\n"
      fi
    fi
  else
    printf "It seems this script doesn't know your distro's system update command.\n"
  fi
  echo
  if command -v snap >/dev/null 2>&1; then
    printf "Snap is installed, will check for snap updates...\n"
    sudo snap refresh
  else
    printf "Snap is not found, will skip checking snap updates."
  fi
  echo
  if command -v flatpak >/dev/null 2>&1; then
    printf "Flatpak is installed, will check for flatpak updates...\n"
    flatpak update
  else
    printf "Flatpak is not found, will skip checking flatpak updates.\n"
  fi
elif [[ $(uname -s) == Darwin ]] && [[ $(sw_vers -productName) == "macOS" ]]; then
  printf "Detected MacOS, will try to update brew & it's apps\n"
  if command -v brew >/dev/null 2>&1; then
    brew update && brew upgrade --greedy
  else
    printf "Unable to find brew.\n"
  fi
fi
echo
printf "All update checks complete.\n"
exit 0
