#!/bin/bash

# Update and upgrade the system
sudo apt update && sudo apt upgrade -y

# Configure apt timeout and retries

# Install Visual Studio Code
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sudo apt update
sudo apt install -y code
rm packages.microsoft.gpg

# Install NekoRay
wget -O nekoray.deb https://github.com/MatsuriDayo/nekoray/releases/latest/download/nekoray-linux-x64.deb
sudo apt install -y ./nekoray.deb
rm nekoray.deb

# Install Google Chrome
wget -O chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./chrome.deb
rm chrome.deb

# Install code-nautilus extension for Nautilus
sudo apt install python3-nautilus
wget -qO- https://raw.githubusercontent.com/harry-cpp/code-nautilus/master/install.sh | bash

# Install Python
sudo apt install -y python3 python3-pip

# Install fzf
sudo apt install -y fzf

# Install Mailspring
wget -O mailspring.deb https://updates.getmailspring.com/download?platform=linuxDeb
sudo apt install -y ./mailspring.deb
rm mailspring.deb

# Install Metasploit
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb >msfinstall &&
	chmod 755 msfinstall &&
	./msfinstall

# # Install v2rayN
# wget -O v2rayn.deb https://github.com/2dust/v2rayN/releases/latest/download/v2rayN-linux-64.deb
# sudo apt install -y ./v2rayn.deb
# rm v2rayn.deb

# Install NVIDIA drivers
sudo apt install -y system76-driver-nvidia

# Install MySQL
sudo apt install -y mysql-server
sudo systemctl enable mysql
sudo systemctl start mysql
sudo mysql_secure_installation

# Install MSSQL
curl https://packages.microsoft.com/keys/microsoft.asc | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc
sudo add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/22.04/mssql-server-2022.list)"
sudo apt-get update
sudo apt-get install -y mssql-server
sudo /opt/mssql/bin/mssql-conf setup
sudo systemctl enable mssql-server
sudo systemctl start mssql-server

# Install Docker
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
# Add the repository to Apt sources:
echo \
	"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" |
	sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
sudo apt-get update
# Install Docker Engine, CLI, and Containerd
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
# Start Docker
sudo systemctl enable docker
sudo systemctl start docker
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
# Configure Docker registry mirror
sudo systemctl restart docker

# Configure Git
git config --global user.name "Danial Mobini"
git config --global user.email "danialmobinidh81@gmail.com"
git config --global core.editor "code --wait"
git config --global init.defaultBranch main

# Install gnome-usage
sudo apt install gnome-usage

# Install GNOME Extensions
gext install 517 240 945 36 6003 1634 906

# Install R
sudo apt install -y r-base

# # Install Rust
# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
# source $HOME/.cargo/env

# Install Go
wget https://go.dev/dl/go1.24.5.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.24.5.linux-amd64.tar.gz
rm go1.24.2.linux-amd64.tar.gz
echo "export PATH=\$PATH:/usr/local/go/bin" >>~/.profile
source ~/.profile

# Install Zig
wget https://ziglang.org/download/0.11.0/zig-linux-x86_64-0.11.0.tar.xz
tar -xf zig-linux-x86_64-0.14.0.tar.xz
sudo mv zig-linux-x86_64-0.14.0 /opt/zig
sudo ln -s /opt/zig/zig /usr/local/bin/zig
rm zig-linux-x86_64-0.14.0.tar.xz

# Install CTF tools
sudo apt install -y binwalk foremost steghide hashcat nmap

# Install Clipman
sudo apt install -y xfce4-clipman

# Install Fish shell
sudo apt install -y fish

# Install sqlmap
sudo apt install -y sqlmap

# Install Wireshark
sudo apt install -y wireshark

# Install Packet Tracer
wget -O packettracer.deb https://www.netacad.com/portal/resources/file/PacketTracer_8.2.0_amd64.deb
sudo apt install -y ./packettracer.deb
rm packettracer.deb

#NOTE can't install telegram for filtering
# # Install Telegram
# wget -O telegram.tar.xz https://telegram.org/dl/desktop/linux
# sudo tar -xf telegram.tar.xz -C /opt/
# rm telegram.tar.xz

# Install Cosmic
sudo apt install -y cosmic-store

sudo apt install -y gparted

# Install Audacious Music Player
sudo apt install -y audacious

# Install uGet
sudo apt install -y uget

# Install OBS Studio
sudo apt install -y obs-studio

# Install SMPlayer
sudo apt install -y smplayer

# Install Git LFS
sudo apt install -y git-lfs
git lfs install

# Install gThumb, GIMP, and Pinta
sudo apt install -y gthumb gimp pinta

# Install HandBrake and MKVToolNix
sudo apt install -y handbrake mkvtoolnix mkvtoolnix-gui

# Install LaTex
sudo apt install -y texlive texlive-xetex texlive-lang-arabic texlive-base texlive-extra-utils perl-tk ttf-mscorefonts-installer

# Install FanNotifications.sh
sudo apt install -y inotify-tools dunst

# Fixing the System Clock
sudo timedatectl set-local-rtc 1 --adjust-system-clock
timedatectl

# Install and set up Zsh as the default shell
sudo apt install -y zsh
cp -r ./zsh ~/
chsh -s $(which zsh)

# Final message
