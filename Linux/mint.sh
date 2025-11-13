#!/bin/bash

source ./colors.sh

if (( EUID != 0 )); then
	PrintRed "This script must be run as root."
	exit -1
fi

chmod -R a=rwx ./tests/
mkdir ./output
apt install meld

while true
do
	PrintLightBlue "Recommended Order:
		(1) Backups
		(2) Baseline
		(3) Users
		(4) Updates
		[Restart Machine]
		(5) Kernel
		(6) Firewall
		(7) PAM
		(8) Auditd
		[Restart Machine]
		(9) Backdoors
		(10) Antimalware
		(11) Unauthorized Material
		(12) Filter Services
		(13) File System Anomalies
		(14) Critical Services
		[Restart Machine]
		[Baseline Again]
		(99) Quit Critical Services"
	PrintCyan "Which Option to Run:  "
	read option

	case "$option" in
		1)
			./tests/backups.sh
		;;
		2)
			./tests/baseline.sh
		;;
		3)
			./tests/users.sh
		;;
		4)
			./tests/updates.sh
		;;
		5)
			./tests/kernel.sh
		;;
		6)
			./tests/firewall.sh
		;;
		7)
			./tests/pam.sh
		;;
		8)
			./tests/auditd.sh
		;;
		9)
			./tests/backdoor.sh
		;;
		10)
			./tests/antimalware.sh
		;;
		11)
			./tests/unauth-material.sh
		;;
		12)
			./tests/filter-services.sh
		;;
		13)
			./tests/filesystem.sh
		;;
		14)
			while true
			do
				PrintLightBlue "Services Availabe:
					(1) SSH
					(99) Quit Critical Services"
				read service
				case "$service" in
					1)
						./tests/critical-services/ssh.sh
					;;
					99)
						exit 0
					;;
					*)
						PrintRed "Not an Option"
					;;
				esac
			done
		;;
		99)
			exit 0
		;;
		*)
			PrintRed "Not an Option"
		;;
	esac
done
