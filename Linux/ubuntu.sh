#!/bin/bash

source ./colors.sh

chmod -R a=rwx ./tests/
apt install meld

while [ true ]
do
	PrintLightBlue "Recommended Order:
	(1) Backups
	(2) Baseline
	(3) Users
	(4) Updates
	[Restart Machine]
	(5) Basic Services
	(6) Unauthorized Material
	(7) Backdoors
	(8) Antimalware
	(9) Kernel
	(10) Firewall
	(11) PAM-Privileged Access Management
	(12) Critical Services
	(13) Permissions
	(14) Auditd
	[Baseline Again]"
	PrintCyan "Which Option to Run:  "
	read option

	case "$option" in
    	1)  ./tests/backups.sh ;;
    	2)  ./tests/baseline.sh ;;
    	3)  ./tests/users.sh ;;
    	4)  ./tests/updates.sh ;;
    	5)  ./tests/prune-services.sh ;;
    	6)  ./tests/unauth-material.sh ;;
    	7)  ./tests/backdoor.sh ;;
    	8)  ./tests/antimalware.sh ;;
    	9)  ./tests/kernel.sh ;;
    	10) ./tests/firewall.sh ;;
    	11) ./tests/pam.sh ;;
    	12) ./tests/critical-services.sh ;;
    	13) ./tests/permissions.sh ;;
    	14) ./tests/auditd.sh ;;
    	*)  echo "Invalid option" ;;
	esac


done
