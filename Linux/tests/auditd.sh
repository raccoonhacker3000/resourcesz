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

meld /etc/audit/auditd.conf ./config-files/auditd/auditd.conf

rm -r /etc/audit/rules.d/*

meld /etc/audit/audit.rules ./config-files/auditd/audit.rules

augenrules

PrintCyan "Add the following variable to the line identified in the file that opens:
	GRUB_CMDLINE_LINUX=\"audit=1\""
gedit /etc/default/grub

systemctl enable auditd
systemctl restart auditd

PrintGreen "Auditd set up!"