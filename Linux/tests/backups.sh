#!/bin/bash

source ./colors.sh

PrintLightBlue "Backups"

mkdir /backups
echo $PATH > /backups/PATH

mkdir /backups/etc
rsync -auiP /etc/pam.d / backups/etc/pam.d
rsync -auiP /etc/passwd /backups/etc/passwd
rsync -auiP /etc/shadow /backups/etc/shadow
rsync -auiP /etc/sudoers /backups/etc/sudoers
rsync -auiP /etc/adduser.conf /backups/etc/adduser.conf
rsync -auiP /etc/sysctl.conf /backups/etc/sysctl.conf

mkdir /backups/etc/apt
rsync -auiP /etc/apt/sources.list /backups/etc/apt/sources.list
mkdir /backups/etc/apt/apt.conf.d
rsync -auiP /etc/apt/apt.conf.d/20auto-upgrades /backups/etc/apt/apt.conf.d/20auto-upgrades
rsync -auiP /etc/apt/apt.conf.d/50unattended-upgrades /backups/etc/apt/apt.conf.d/50unattended-upgrades

mkdir /backups/etc/lightdm
rsync -auiP -r /usr/share/lightdm/lightdm.conf.d/ /backups/usr/share/lightdm/lightdm.conf.d

mkdir /backups/etc/default
rsync -auiP /etc/default/grub /backups/etc/default/grub

mkdir /backups/etc/security
rsync -auiP /etc/security/limits.conf /backups/etc/security/limits.conf

PrintGreen "Backups Complete"
