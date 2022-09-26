#!/bin/bash
# self-used script for initialization of the server

echo "system update && upgrade"
source /etc/os-release
case $ID in
debian|ubuntu|devuan)
    sudo apt-get install
sudo NEEDRESTART_MODE=a apt-get update && sudo NEEDRESTART_MODE=a apt-get upgrade -y
esac

echo "check geoip"
sudo NEEDRESTART_MODE=a apt-get install jq -y
COUNTRY = $(curl -s ipinfo.io |  jq -r '.country')
CN_MIRRORS=0
if [[ COUNTRY -eq "cn" ]]; then
    CN_MIRRORS=1
else
    CN_MIRRORS=0
fi

if [[ $CN_MIRRORS -eq 1 ]]; then
  echo "change to TUNA's MIRRORS"
  wget https://tuna.moe/oh-my-tuna/oh-my-tuna.py
  sudo python3 oh-my-tuna.py --global -y
  sudo NEEDRESTART_MODE=a apt-get update
fi

echo "Install Docker && Docker compose"

echo "uninstall old versions"

REQUIRED_PKGS="docker docker-engine docker.io containerd runc"
for REQUIRED_PKG in $REQUIRED_PKGS; do 
  PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG|grep "install ok installed")
  echo Checking for $REQUIRED_PKG: $PKG_OK
  if [ "" = "$PKG_OK" ]; then
    echo "No $REQUIRED_PKG."
    else
      sudo apt-get remove --purge $REQUIRED_PKG -y
  fi
done

sudo apt-get install ca-certificates curl gnupg lsb-release -y
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin


