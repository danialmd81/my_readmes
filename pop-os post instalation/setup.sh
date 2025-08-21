#!/bin/bash

# Update and upgrade the system
apt update && apt upgrade -y

# Configure apt timeout and retries

# Install Visual Studio Code
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
apt update
apt install -y code
rm packages.microsoft.gpg

# Install NekoRay
wget -O nekoray.deb https://github.com/MatsuriDayo/nekoray/releases/latest/download/nekoray-linux-x64.deb
apt install -y ./nekoray.deb
rm nekoray.deb

# Install Google Chrome
wget -O chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
apt install -y ./chrome.deb
rm chrome.deb

# Install code-nautilus extension for Nautilus
apt install python3-nautilus
wget -qO- https://raw.githubusercontent.com/harry-cpp/code-nautilus/master/install.sh | bash

# Install open as Admin
apt install nautilus-admin

# Install Python
apt install -y python3 python3-pip

# Install fzf
apt install -y fzf

# Install Mailspring
wget -O mailspring.deb https://updates.getmailspring.com/download?platform=linuxDeb
apt install -y ./mailspring.deb
rm mailspring.deb

# Install Metasploit
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb >msfinstall &&
	chmod 755 msfinstall &&
	./msfinstall

# # Install v2rayN
# wget -O v2rayn.deb https://github.com/2dust/v2rayN/releases/latest/download/v2rayN-linux-64.deb
# apt install -y ./v2rayn.deb
# rm v2rayn.deb

# Install NVIDIA drivers
apt install -y system76-driver-nvidia

# Install MySQL
apt install -y mysql-server
systemctl enable mysql
systemctl start mysql
mysql_secure_installation

# Install MSSQL
curl https://packages.microsoft.com/keys/microsoft.asc | tee /etc/apt/trusted.gpg.d/microsoft.asc
add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/22.04/mssql-server-2022.list)"
apt-get update
apt-get install -y mssql-server
/opt/mssql/bin/mssql-conf setup
systemctl enable mssql-server
systemctl start mssql-server

# Install Docker
# Add Docker's mecan.ir GPG key:
apt-get update
apt-get install ca-certificates curl
install -m 0755 -d /etc/apt/keyrings
curl -fsSL "https://repo.mecan.ir/repository/debian-docker/gpg" | gpg --dearmor --yes -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg
# Add the repository to Apt sources:
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] https://repo.mecan.ir/repository/debian-docker bookworm stable" >/etc/apt/sources.list.d/docker.list
cat /etc/apt/sources.list.d/docker.list
apt-get update
# Install Docker Engine, CLI, and Containerd
apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin docker-buildx-plugin docker-ce-rootless-extras docker-scan-plugin
# rootless docker
groupadd docker
usermod -aG docker $USER
newgrp docker
# Configure Docker registry mirror
# check docker config directory
[[ -d /etc/docker ]] || mkdir /etc/docker

cat <<EOF >/etc/docker/daemon.json

{
  "registry-mirrors": ["https://hub.mecan.ir","https://hub.hamdocker.ir"]
}
EOF
# restart docker service
systemctl restart docker
systemctl enable docker

# Configure Git
git config --global user.name "Danial Mobini"
git config --global user.email "danialmobinidh81@gmail.com"
git config --global core.editor "code --wait"
git config --global init.defaultBranch main

# Install gnome-usage
apt install gnome-usage

# Install GNOME Extensions
gext install 517 240 945 36 6003 1634 906 779

# Install R
apt install -y r-base

# # Install Rust
# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
# source $HOME/.cargo/env

# Install Go
wget https://go.dev/dl/go1.24.5.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.24.5.linux-amd64.tar.gz
rm go1.24.2.linux-amd64.tar.gz
echo "export PATH=\$PATH:/usr/local/go/bin" >>~/.profile
source ~/.profile

# Install Zig
wget https://ziglang.org/download/0.11.0/zig-linux-x86_64-0.11.0.tar.xz
tar -xf zig-linux-x86_64-0.14.0.tar.xz
mv zig-linux-x86_64-0.14.0 /opt/zig
ln -s /opt/zig/zig /usr/local/bin/zig
rm zig-linux-x86_64-0.14.0.tar.xz

# Install CTF tools
apt install -y binwalk foremost steghide hashcat nmap

# Install Clipman
apt install -y xfce4-clipman

# Install Fish shell
apt install -y fish

# Install sqlmap
apt install -y sqlmap

# Install Wireshark
apt install -y wireshark

# Install Packet Tracer
wget -O packettracer.deb https://www.netacad.com/portal/resources/file/PacketTracer_8.2.0_amd64.deb
apt install -y ./packettracer.deb
rm packettracer.deb

#NOTE can't install telegram for filtering
# # Install Telegram
# wget -O telegram.tar.xz https://telegram.org/dl/desktop/linux
# tar -xf telegram.tar.xz -C /opt/
# rm telegram.tar.xz

# Install Cosmic
apt install -y cosmic-store

apt install -y gparted

# Install Audacious Music Player
apt install -y audacious

# Install uGet
apt install -y uget

# Install OBS Studio
apt install -y obs-studio

# Install SMPlayer
apt install -y smplayer

# Install Git LFS
apt install -y git-lfs
git lfs install

# Install gThumb, GIMP, and Pinta
apt install -y gthumb gimp pinta

# Install HandBrake and MKVToolNix
apt install -y handbrake mkvtoolnix mkvtoolnix-gui

# Install LaTex
apt install -y texlive texlive-xetex texlive-lang-arabic texlive-base texlive-extra-utils perl-tk ttf-mscorefonts-installer

# Install FanNotifications.sh
apt install -y inotify-tools dunst

# Fixing the System Clock
timedatectl set-local-rtc 1 --adjust-system-clock
timedatectl

# Install and set up Zsh as the default shell
apt install -y zsh
chsh -s $(which zsh)
cp -r ./zsh ~/

# Final message
