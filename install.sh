#!/bin/bash

# Enter DATA

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


##Checked installed Packages and install the missing

apt-get update

#SED
if [ $(dpkg-query -W -f='${Status}' sed 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  apt-get install -y sed;
fi

#Curl
if [ $(dpkg-query -W -f='${Status}' curl 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  apt-get install -y curl;
fi

#TAR
if [ $(dpkg-query -W -f='${Status}' tar 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  apt-get install -y tar;
fi

#PYTHON3
if [ $(dpkg-query -W -f='${Status}' python3 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  apt-get install -y python3;
fi

#PIP
if [ $(dpkg-query -W -f='${Status}' python3-pip 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  apt-get install -y python3-pip;
fi

#ca-certificates
if [ $(dpkg-query -W -f='${Status}' ca-certificates 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  apt-get install -y ca-certificates;
fi

#gnupg
if [ $(dpkg-query -W -f='${Status}' gnupg 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  apt-get install -y gnupg;
fi

#wget
if [ $(dpkg-query -W -f='${Status}' wget 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  apt-get install -y wget;
fi

#apt-transport-https
if [ $(dpkg-query -W -f='${Status}' apt-transport-https 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  apt-get install -y apt-transport-https;
fi

#software-properties-common
if [ $(dpkg-query -W -f='${Status}' software-properties-common 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  apt-get install -y software-properties-common;
fi

#Powershell
if [ $(dpkg-query -W -f='${Status}' powershell 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  wget -q "https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb"
  dpkg -i packages-microsoft-prod.deb
  rm packages-microsoft-prod.deb
  apt-get update
  apt-get install -y powershell;
fi

#Docker
if [ $(dpkg-query -W -f='${Status}' docker-ce 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  sudo install -m 0755 -d /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  sudo chmod a+r /etc/apt/keyrings/docker.gpg

  echo \
   "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

  apt-get update

  apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
fi

#Python flask module
if [ $(pip3 show flask | grep -c "Flask") -eq 0 ];
then
  pip3 install flask;
fi


sleep 1s

echo "Packages are installed"

sleep 2s
#Modify Files for execution

chmod +x scripts/*.sh
chmod +x scripts/*.ps1
chmod +x scripts/docker/*.sh
chmod +x run.sh

sleep 1s

echo "Files modified for execution"

sleep 2s

# INSTALL_DOMAIN_VAR
sed -i "s/INSTALL_DOMAIN_VAR/$domain/g" scripts/status.ps1 scripts/docker.sh scripts/create_pfx.sh scripts/zip_up.sh app.py
sleep 1s

# INSTALL_EMAIL_VAR
sed -i "s/INSTALL_EMAIL_VAR/$mail/g" scripts/docker.sh
sleep 1s

# INSTALL API
sed -i "s/INSTALL_API_KEY/$api_key/g" scripts/docker.sh
sleep 1s
sed -i "s/INSTALL_KEY_SECRET/$api_key_secret/g" scripts/docker.sh
sleep 1s

# INSTALL_PFX_PASS
sed -i "s/INSTALL_PFX_PASS/$pfx_password/g" scripts/create_pfx.sh
sleep 1s

sleep 1s

echo "Files variables set"

sleep 2s

# Create folder /opt/letsencrypt

mkdir -p /opt/letsencrypt/cert

sleep 1s

echo "Folder created"

sleep 2s

# Copy cron file
chmod +x scripts/web_cert_cron.sh
sh scripts/web_cert_cron.sh

sleep 1s

echo "Cron installed"

sleep 2s

# Install Service

cp scripts/web_cert.service /etc/systemd/system/web_cert.service

systemctl daemon-reload
systemctl enable web_cert.service
systemctl start web_cert.service