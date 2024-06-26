# UpdateMe

**UpdateMe** is a simple shell script which detects what OS it's running on and proceeds to run the commands to update (& upgrade) the system.

- Note: This is like my second shell program. cleaning and making it shorter is my next task 🥲.

## Support

- [**Debian**](https://www.debian.org)/[**Ubuntu**](https://ubuntu.com/desktop)-based distros
  - [x] apt
  - [x] [nala](https://gitlab.com/volian/nala)
  - [x] [pacstall](https://pacstall.dev)
- [**Fedora**](https://fedoraproject.org)
  - dnf
- [**Arch Linux**](https://archlinux.org)
  - [x] [pacman](https://wiki.archlinux.org/title/pacman)
  - [x] [yay](https://github.com/Jguer/yay)
  - [x] [paru](https://github.com/Morganamilo/paru)
- [**EndeavourOS**](https://endeavouros.com)
  - [x] eos-update
  - Probably very useless as EndeavourOS is based on Arch and `eos-update` is just a frontend for pacman, yay & paru
- [**MacOS**]("www.apple.com/macos")
  - [x] [brew](https://brew.sh): formulea & casks

## Usage

### There are four ways to use it

1. Press the download the raw file [here](https://github.com/vbrabandt2005/General-Scripts/blob/main/UpdateMe/UpdateMe.sh)
2. Download it with `curl` or `wget` into your home directory

    ```bash
    curl -o UpdateMe.sh https://raw.githubusercontent.com/vbrabandt2005/General-Scripts/main/UpdateMe/UpdateMe.sh
    ```

    or

    ```bash
    wget https://raw.githubusercontent.com/vbrabandt2005/General-Scripts/main/UpdateMe/UpdateMe.sh
    ```

    then

    ```bash
    ./UpdateMe.sh
    ```

3. Run straight from github

    ```bash
    bash -c "$(curl -fsS https://raw.githubusercontent.com/vbrabandt2005/General-Scripts/main/UpdateMe/UpdateMe.sh)"
    ```

4. just `git clone` it

    ```bash
    git clone https://github.com/vbrabandt2005/General-Scripts
    ```

## Why did I create this?

I used to rely on `sudo nala update && sudo nala full-upgrade && sudo snap refresh && flatpak update` to keep my system updated and I then proceeded to write a basic shell script which ran this command seqence.  This worked well for **Ubuntu**, but when I installed **EndeavourOS** onto my second MacBook, the script became unusable because **EndeavourOS/Arch** utilizes `pacman` instead of `apt/nala`.

This sparked my journey into shell scripting. I wanted a convenient, universal script that could handle updates across different distributions. The result is this new script. It not only automates updates but also offers the potential for future customization based on my needs.

Why is everything here so long and overly documented? honestly I don't know.
