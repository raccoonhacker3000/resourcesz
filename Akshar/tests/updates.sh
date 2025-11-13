#!/bin/bash

source ./colors.sh

chmod 644 /etc/apt/sources.list

PrintGreen "APT Sources List Complete"

PrintLightBlue "Updating the System"
apt update -y
apt upgrade -y
apt dist-upgrade -y
apt autoclean
apt autoremove
snap refresh

PrintGreen "System Updates Complete"

PrintLightBlue "Graphical Software Updates"

PrintGreen "Graphical Updates Complete"

PrintLightBlue "OpenSSL Heartbleed Bug"
apt-get upgrade openssl libssl-dev  # Upgrade OpenSSL
apt-cache policy openssl libssl-dev  # Verify version
apt-get install make
curl https://www.openssl.org/source/openssl-1.0.2f.tar.gz | tar xz && cd openssl-1.0.2f && ./config && make && make install

PrintGreen "OpenSSL Heartbleed Bug Patched"


apt install unattended-upgrades
dpkg-reconfigure unattended-upgrades
systemctl restart unattended-upgrades
systemctl daemon-reload