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


PrintLightBlue "NMAP Scan"
PrintCyan "Act on any discrepancies (consider the checklist for backdoor hunting):"
apt install nmap -y && nmap -sV -p- 127.0.0.1 > ./output/nmap_scan.txt && apt purge nmap -y
cat ./output/nmap_scan.txt
read REPLY
PrintGreen "Backdoors Removed!"
echo 'i hope at least ╰(✿´⌣`✿)╯'

PrintCyan "Act on processes running on a deleted binary:  "
ls -alR /proc/*/exe 2> /dev/null | grep deleted
read REPLY

PrintCyan "Act on process masquerading as another name (The exe link will show a binary, exec is different):  "
ls -al /proc/*/ | grep exe

PrintGreen "Weird Processes Removed!"

PrintCyan "Remove weird startup processes in /etc/rc.d"
read REPLY
PrintGreen "Startup Processes Secure!"

PrintLightBlue "Standardize rc.local settings"
echo "modprobe -r usb_storage
exit 0" >> /etc/rc.local
PrintGreen "rc.local fixed!"
