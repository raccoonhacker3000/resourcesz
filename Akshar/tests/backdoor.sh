#!/bin/bash

source ./colors.sh


PrintLightBlue "NMAP Scan"
PrintCyan "Act on any discrepancies (consider the checklist for backdoor hunting): \n==============================================================\n[Press Enter]\n=============================================================="
apt install nmap -y && nmap -sV -p- 127.0.0.1 > ./output/nmap_scan.txt && apt purge nmap -y
PrintGreen "Backdoors Removed!"

PrintGreen "Weird Processes Removed!"


PrintLightBlue "Standardize rc.local settings"
echo "modprobe -r usb_storage
exit 0" >> /etc/rc.local
PrintGreen "rc.local fixed!"
