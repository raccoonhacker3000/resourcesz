#!/bin/bash

# For Error Messages
PrintRed () {
	echo -e "\e[31m${1}\e[0m"
}

# For Success Messages
PrintGreen () {
	echo -e "\e[32m${1}\e[0m"
}

# For Neutral Status / Task Updates
PrintLightBlue () {
	echo -e "\e[94m${1}\e[0m"
}

# For User Input
PrintCyan () {
	echo -e "\e[36m${1}\e[0m"
}

PrintLightBlue "APT Sources Page"
PrintCyan "What version APT sources do you want? (1/2)
* 1.) Mint 21
* 2.) Ubuntu 22.04
* 3.) Ubuntu 20.04 (Unavailable)
* 4.) Ubuntu 18.04
* 5.) Ubuntu 14.04 (Unavailable)
* 6.) Ubuntu 12.04 (Unavailable)
"
read version

if [ $version -eq 1 ]
then
	meld ./config-files/updates/mint-sources.list /etc/apt/sources.list
fi

if [ $version -eq 2 ]
then
	meld ./config-files/updates/ubuntu-sources.list /etc/apt/sources.list
fi

if [ $version -eq 4 ]
then
	meld ./config-files/updates/ubuntu-18-sources.list /etc/apt/sources.list
fi

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

PrintCyan "Check Graphical Software Installer for Updates. (Press Enter when complete)"
read REPLY

PrintCyan "Check Updates Daily in Software Updates App. (Press Enter when complete)"
read REPLY

PrintGreen "Graphical Updates Complete"

PrintLightBlue "OpenSSL Heartbleed Bug"
apt-get upgrade openssl libssl-dev  # Upgrade OpenSSL
apt-cache policy openssl libssl-dev  # Verify version
apt-get install make
curl https://www.openssl.org/source/openssl-1.0.2f.tar.gz | tar xz && cd openssl-1.0.2f && ./config && make && make install

PrintGreen "OpenSSL Heartbleed Bug Patched"

PrintLightBlue "APT Keys"
apt-key list
PrintCyan "Verify each key is valid. Remove bad ones. (Press Enter when complete)"
read REPLY

PrintGreen "APT Keys Secured"

PrintLightBlue "CLI Automated Updates"
PrintCyan "Do you want to run CLI for Automated Updates, if no use the GUI (y/n)?  "
read yn

if [ "${yn}" = "y" ]
then
	apt install unattended-upgrades
	dpkg-reconfigure unattended-upgrades
	meld ./config-files/updates/20auto-upgrades /etc/apt/apt.conf.d/20auto-upgrades
	meld ./config-files/updates/50unattended-upgrades /etc/apt/apt.conf.d/50unattended-upgrades
	systemctl restart unattended-upgrades
	systemctl daemon-reload
fi
PrintGreen "Automatic Updates Configured"

PrintCyan "Will Restart Next. Write Down Password"
read yn
reboot
