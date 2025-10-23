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

PrintLightBlue "User Auditing"
echo "Calculating..."

users=(`getent passwd {1000..65535} | cut -d: -f1 | tr "\n" " "`)
usersLen=${#users[@]}

for ((i = 0 ; i < $usersLen ; i++ ))
do
	PrintLightBlue ${users[${i}]}
	PrintCyan "Delete ${users[${i}]} (y/n)?  "
	read yn
	if [ "$yn" = "y" ]
	then
		userdel -r "${users[${i}]}"
		PrintGreen "${users[${i}]} has been deleted."
	else
		PrintCyan "Is ${users[${i}]} you (y/n)?  "
		read yn
		if [ $yn = "n" ]
		then
			PrintCyan "Is ${users[${i}]} an administrator (y/n)?  "
			read yn
			if [ "$yn" = "y" ]
			then
				gpasswd -a "${users[${i}]}" sudo
				gpasswd -a "${users[${i}]}" adm
				gpasswd -a "${users[${i}]}" lpadmin
				gpasswd -a "${users[${i}]}" sambashare
				PrintGreen "${users[${i}]} has been made an administrator."
			else
				gpasswd -d "${users[${i}]}" sudo
				gpasswd -d "${users[${i}]}" adm
				gpasswd -d "${users[${i}]}" lpadmin
				gpasswd -d "${users[${i}]}" sambashare
				gpasswd -d "${users[${i}]}" root
				PrintGreen "${users[${i}]} has been made a standard user."
			fi
			
			pw="Akry%150Akry%150"
			echo -e "$pw\n$pw" | passwd "${users[${i}]}"

			usermod -L "${users[${i}]}"
			PrintGreen "${users[${i}]} account is locked"

			passwd -x30 -n3 -w7 "${users[${i}]}"
			PrintGreen "${users[${i}]} password has been given a maximum age of 30 days, minimum of 3 days, and warning of 7 days."
		fi
	fi
done

PrintCyan "Look through /etc/passwd for UIDs <1000 or ==0"
gedit /etc/passwd
read REPLY
PrintGreen "Odd UIDs secured"

PrintCyan "Look through /etc/group for groups that should not exist"
gedit /etc/group
read REPLY
PrintGreen "Odd groups secured"

PrintCyan "These are empty passwords, none should appear if passwords were applied correctly:"
mawk -F: '$2 == ""' /etc/passwd
read REPLY
PrintGreen "Empty passwords secured"

PrintCyan "Configure /etc/sudoers based on scenario requirements and ./config-files/users/sudoers"
read REPLY
visudo
read REPLY
PrintGreen "Sudo rights controlled"

PrintLightBlue "Lock root in case it hasn't been already"
passwd -l root
PrintGreen "Root Locked"

PrintLightBlue "Adduser Default Home Directory Permissions"
meld ./config-files/users/adduser.conf /etc/adduser.conf
PrintGreen "Adduser Default Home Directory Set"

PrintCyan "Verify Each home directory is owned by the correct user and that user's group:"
ls -la /home
read REPLY
PrintGreen "Home Dirs Secured"

PrintLightBlue "Guest Account"
PrintCyan "Is lightdm used (y/n)?  "
read yn
if [ "$yn" = "y" ]
then
	meld ./config-files/users/lightdm.conf /usr/share/lightdm/lightdm.conf.d/50-ubuntu.conf
	PrintCyan "Look through other lightdm related files to remove conflicting entries"
	ls -R /usr/share/lightdm/lightdm.conf.d
	read REPLY
	systemctl restart lightdm.service
	systemctl daemon-reload
fi
PrintGreen "Guest Account Secured"
