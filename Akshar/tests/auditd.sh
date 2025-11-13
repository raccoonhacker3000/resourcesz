#!/bin/bash

source ./colors.sh

PrintLightBlue "Installing Auditd"
apt install bash-completion
apt-get install auditd

auditd -s enable
systemctl enable auditd
systemctl restart auditd

PrintGreen "Auditd Started!"

PrintLightBlue "Configuring Settings and Rules"

rm -r /etc/audit/rules.d/*

augenrules


echo "GRUB_CMDLINE_LINUX=\"audit=1\"" >>  /etc/default/grub

systemctl enable auditd
systemctl restart auditd

PrintGreen "Auditd set up!"