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