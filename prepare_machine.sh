#!/bin/bash

set -uou pipefail

if [ "$(whoami)" != "root" ]; then
    printf "Must be run as sudo\n"
    exit -1
fi
# Bring system up to date
apt-get update
apt-get upgrade -y

# Essentials
apt-get install git python3-pip curl

# Nodejs
curl -sL https://deb.nodesource.com/setup_6.x | bash -
apt-get install nodejs -y

wget https://github.com/atom/atom/releases/download/v1.10.2/atom-amd64.deb
dpkg -i atom-amd64.deb

# Things for code completion
npm install tern -g
pip3 install jedi

# Chromium
apt-get install chromium-browser -y

# Guest session customization
echo 'prefix=$HOME/.node_modules' > /etc/guest-session/skel/.npmrc
mkdir -p /etc/guest-session/skel/local/bin

echo 'git config --global user.name "$USER"' >> /etc/guest-session/prefs.sh
echo 'git config --global user.email "$USER@example.com"' >> /etc/guest-session/prefs.sh
echo 'touch $HOME/.skip-guest-warning-dialog' >> /etc/guest-session/prefs.sh 
echo 'PATH=$PATH:$HOME/local/bin' >> /etc/guest-session/prefs.sh 
echo "apm install react atom-ternjs autocomplete-python" >> /etc/guest-session/prefs.sh 
echo 'chown -R $USER: $HOME' >> /etc/guest-session/prefs.sh 

