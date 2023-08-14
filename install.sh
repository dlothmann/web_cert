#!/bin/bash

echo "Enter your domain name like example.com"

read domain

echo "Enter your e-mail for the certificate"

read mail

echo "Enter API KEY"

read api_key

echo "Enter API KEY Secret"

read api_key_secret

echo "Enter new .pfx Default Password"

read pfx_password


chmod +x scripts/*.sh
chmod +x scripts/*.ps1

# INSTALL_DOMAIN_VAR
sed s/INSTALL_DOMAIN_VAR/$domain/ scripts/status.ps1
sed s/INSTALL_DOMAIN_VAR/$domain/ scripts/docker.sh
sed s/INSTALL_DOMAIN_VAR/$domain/ scripts/create_pfx.sh
sed s/INSTALL_DOMAIN_VAR/$domain/ scripts/zip_up.sh
sed s/INSTALL_DOMAIN_VAR/$domain/ app.py

# INSTALL_EMAIL_VAR
sed s/INSTALL_EMAIL_VAR/$mail/ scripts/docker.sh

# INSTALL API
sed s/INSTALL_API_KEY/$api_key/ scripts/docker.sh
sed s/INSTALL_KEY_SECRET/$api_key_secret/ scripts/docker.sh

# INSTALL_PFX_PASS
sed s/INSTALL_PFX_PASS/$pfx_password/ scripts/create_pfx.sh



# Create folder /opt/letsencrypt

mkdir /opt/letsencrypt/cert

# Copy cron file
cp scripts/web_cert_cron /etc/cron.d/

# Install Requirements

apt-get update

## Install Powershell

apt-get install -y wget apt-transport-https software-properties-common

wget -q "https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb"

dpkg -i packages-microsoft-prod.deb

rm packages-microsoft-prod.deb

apt-get update

apt-get install -y powershell

## Install Curl,tar,python3,

apt-get install -y curl tar python3

## Install Docker

apt-get install -y ca-certificates gnupg

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update

apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin