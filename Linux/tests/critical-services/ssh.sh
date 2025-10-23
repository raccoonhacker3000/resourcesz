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

PrintCyan "Install OpenSSH (y/n)?"
read yn

if [ "$yn" = "y" ]
then
	apt install openssh-server
fi

PrintLightBlue "SSH Key Permissions"

# Private Keys
l_skgn="ssh_keys" # Group designated to own openSSH keys
l_skgid="$(awk -F: '($1 == "'"$l_skgn"'"){print $3}' /etc/group)"
awk '{print}' <<< "$(find /etc/ssh -xdev -type f -name 'ssh_host_*_key' -exec stat -L -c "%n %#a %U %G %g" {} +)" | (while read -r l_file l_mode l_owner l_group l_gid; do
	[ -n "$l_skgid" ] && l_cga="$l_skgn" || l_cga="root"
	[ "$l_gid" = "$l_skgid" ] && l_pmask="0137" || l_pmask="0177"
	l_maxperm="$( printf '%o' $(( 0777 & ~$l_pmask )) )"
	if [ $(( $l_mode & $l_pmask )) -gt 0 ]; then
		echo -e " - File: \"$l_file\" is mode \"$l_mode\" changing to mode: \"$l_maxperm\""
		if [ -n "$l_skgid" ]; then
			chmod u-x,g-wx,o-rwx "$l_file"
		else
			chmod u-x,go-rwx "$l_file"
		fi
	fi
	if [ "$l_owner" != "root" ]; then
		echo -e " - File: \"$l_file\" is owned by: \"$l_owner\" changing owner to \"root\""
		chown root "$l_file"
	fi
	if [ "$l_group" != "root" ] && [ "$l_gid" != "$l_skgid" ]; then
		echo -e " - File: \"$l_file\" is owned by group \"$l_group\" should belong to group \"$l_cga\""
		chgrp "$l_cga" "$l_file"
	fi
done
)

# Public Keys
find /etc/ssh -xdev -type f -name 'ssh_host_*_key.pub' -exec chmod u-x,gowx {} \;
find /etc/ssh -xdev -type f -name 'ssh_host_*_key.pub' -exec chown root:root {} \;

# Config File
chown root:root /etc/ssh/sshd_config
chmod og-rwx /etc/ssh/sshd_config

PrintGreen "SSH File Permissions are Set!"

PrintLightBlue "SSH Config File"
meld /etc/ssh/sshd_config ./config-files/critical-services/ssh/sshd_config
PrintGreen "SSH Config File Fixed!"

PrintLightBlue "SSH PAM Config"
meld /etc/pam.d/sshd ./config-files/pam/sshd
PrintGreen "SSH PAM Config Complete!"

PrintCyan "Fix these issues!"
sshd -t
read REPLY
PrintGreen "Config Files Fixed"

systemctl restart ssh
systemctl status ssh

PrintGreen "SSH Secured!"
