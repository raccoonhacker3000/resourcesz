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

PrintLightBlue "Backups"

mkdir /backups
echo $PATH > /backups/PATH

mkdir /backups/etc
cp -r /etc/pam.d / backups/etc/pam.d
cp /etc/passwd /backups/etc/passwd
cp /etc/shadow /backups/etc/shadow
cp /etc/sudoers /backups/etc/sudoers
cp /etc/adduser.conf /backups/etc/adduser.conf
cp /etc/sysctl.conf /backups/etc/sysctl.conf

mkdir /backups/etc/apt
cp /etc/apt/sources.list /backups/etc/apt/sources.list
mkdir /backups/etc/apt/apt.conf.d
cp /etc/apt/apt.conf.d/20auto-upgrades /backups/etc/apt/apt.conf.d/20auto-upgrades
cp /etc/apt/apt.conf.d/50unattended-upgrades /backups/etc/apt/apt.conf.d/50unattended-upgrades

mkdir /backups/etc/lightdm
cp -r /usr/share/lightdm/lightdm.conf.d/ /backups/usr/share/lightdm/lightdm.conf.d

mkdir /backups/etc/default
cp /etc/default/grub /backups/etc/default/grub

mkdir /backups/etc/security
cp /etc/security/limits.conf /backups/etc/security/limits.conf

PrintGreen "Backups Complete"
