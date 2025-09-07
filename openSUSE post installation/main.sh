#!/bin/bash

## Update and upgrade the system
zypper refresh && zypper update -y

#### Install Visual Studio Code
# wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
# install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
# zypper addrepo --refresh https://packages.microsoft.com/yumrepos/vscode vscode
# zypper refresh
# zypper install -y code
# rm packages.microsoft.gpg

#### Install NekoRay
wget -O nekoray.zip https://github.com/MatsuriDayo/nekoray/releases/latest/download/nekoray-4.0.1-2024-12-12-linux64.zip
unzip nekoray.zip -d /home/danial/bin/
rm nekoray.zip
zypper install libcap-progs
setcap cap_net_admin,cap_net_bind_service=+ep /home/danial/bin/nekoray/nekobox_core
cp ./nekoray.desktop /usr/share/applications/

#### Install Google Chrome
# wget -O chrome.rpm https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
# zypper install -y ./chrome.rpm
# rm chrome.rpm

## Install Python and pip
zypper install -y python3 python3-pip

## Install fzf
zypper install -y fzf

#### Install Mailspring
# wget -O mailspring.rpm https://updates.getmailspring.com/download?platform=linuxRpm
# zypper install -y ./mailspring.rpm
# rm mailspring.rpm

###### Install Metasploit (via OBS repo)
# zypper addrepo https://download.opensuse.org/repositories/security:/metasploit/openSUSE_Tumbleweed/security:metasploit.repo
# zypper refresh
# zypper install -y metasploit

## Install NVIDIA drivers (if needed)
# zypper install -y x11-video-nvidiaG05

## Install MySQL
zypper install -y mysql-community-server
systemctl enable mysql
systemctl start mysql
# TODO add this to README
# mysql_secure_installation

# TODO check
Install Docker
zypper install -y docker
systemctl enable docker
systemctl start docker
groupadd docker
usermod -aG docker $USER
newgrp docker

## Configure Git
git config --global user.name "Danial Mobini"
git config --global user.email "danialmobinidh81@gmail.com"
git config --global core.editor "code --wait"
git config --global init.defaultBranch main

###### Install GNOME Usage
# zypper install -y gnome-usage

## Install R
zypper install -y R-base

## Install Go
zypper in go
## Install Zig
xzypper in zig

###### Install CTF tools
# zypper install -y binwalk foremost steghide hashcat nmap sqlmap

###### Install Wireshark
# zypper install -y wireshark

###### Install Packet Tracer (manual install, if available)
# wget -O packettracer.rpm https://www.netacad.com/portal/resources/file/PacketTracer_8.2.0_x86_64.rpm
# zypper install -y ./packettracer.rpm
# rm packettracer.rpm

## Install Fish shell
zypper install -y fish

###### Install GParted
# zypper install -y gparted

## Install Audacious Music Player
zypper install -y audacious

###### Install uGet
# zypper install -y uget

# TODO
## Install OBS Studio
zypper install -y obs-studio

## Install SMPlayer
zypper install -y smplayer

## Install Git LFS
zypper install -y git-lfs
git lfs install

## Install gThumb, GIMP, and Pinta
zypper install -y gthumb gimp pinta

## Install HandBrake and MKVToolNix
zypper install -y mkvtoolnix mkvtoolnix-gui
# TODO handbrake

## Install inotify-tools and dunst
zypper install -y inotify-tools dunst

###### Fixing the System Clock
# timedatectl set-local-rtc 1 --adjust-system-clock
# timedatectl

###### Gnome extension
zypper install typelib-1_0-GTop-2_0

## Install and set up Zsh as the default shell
zypper install -y zsh
chsh -s $(which zsh)
cp -r ./zsh ~/

## Install Telegram Desktop
wget -O telegram.tar.xz https://telegram.org/dl/desktop/linux
tar -xf telegram.tar.xz -C /opt/
ln -sf /opt/Telegram/Telegram /usr/local/bin/telegram-desktop
rm telegram.tar.r

zypper in python3-nautilus
wget -qO- https://raw.githubusercozntent.com/harry-cpp/code-nautilus/master/install.sh | bash
