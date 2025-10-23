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

chmod -R a=rwx ./tests/
apt install meld


x=1

while [ $x -eq 1 ]
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
	(11) PAM
	(12) Critical Services
	(13) Permissions
	(14) Auditd
	[Baseline Again]"
	PrintCyan "Which Option to Run:  "
	read option

	if [ "$option" -eq 1 ]
	then
		./tests/backups.sh
	fi

	if [ "$option" -eq 2 ]
	then
		./tests/baseline.sh
	fi

	if [ "$option" -eq 3 ]
	then
		./tests/users.sh
	fi

	if [ "$option" -eq 4 ]
	then
		./tests/updates.sh
	fi

	if [ "$option" -eq 5 ]
	then
		./tests/prune-services.sh
	fi

	if [ "$option" -eq 6 ]
	then
		./tests/unauth-material.sh
	fi

	if [ "$option" -eq 7 ]
	then
		./tests/backdoor.sh
	fi

	if [ "$option" -eq 8 ]
	then
		./tests/antimalware.sh
	fi

	if [ "$option" -eq 9 ]
	then
		./tests/kernel.sh
	fi

	if [ "$option" -eq 10 ]
	then
		./tests/firewall.sh
	fi

	if [ "$option" -eq 11 ]
	then
		./tests/pam.sh
	fi

	if [ "$option" -eq 12 ]
	then
		./tests/critical-services.sh
	fi

	if [ "$option" -eq 13 ]
	then
		./tests/permissions.sh
	fi

	if [ "$option" -eq 14 ]
	then
		./tests/auditd.sh
	fi

done
