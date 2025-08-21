#! /usr/bin/bash

# Install Docker
# Add Docker's mecan.ir GPG key:
apt-get update
apt-get -y install ca-certificates curl gpg
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
usermod -aG docker danial
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
