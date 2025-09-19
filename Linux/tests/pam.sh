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

PrintLightBlue "Settings in /etc/pam.d/"
meld ./config-files/pam/common-password /etc/pam.d/common-password
meld ./config-files/pam/common-account /etc/pam.d/common-account
meld ./config-files/pam/common-auth /etc/pam.d/common-auth
meld ./config-files/pam/polkit-1 /etc/pam.d/polkit-1

PrintLightBlue "Settings in /etc"
meld ./config-files/pam/login.defs /etc/login.defs

PrintGreen "PAM Complete!"