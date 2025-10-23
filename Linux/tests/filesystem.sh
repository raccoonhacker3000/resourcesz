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


PrintLightBlue "Common Permissions"
chmod -R 444 /var/log
chmod 440 /etc/passwd
chmod 440 /etc/shadow
chmod 440 /etc/group
chown root:admin /bin/su
chmod u=rwsr /bin/su
chmod g=xr /bin/su
chmod o=x /bin/su
chown root:admin /bin/sudo
chmod u=rwsr /bin/sudo
chmod g=xr /bin/sudo
chmod o=x /bin/sudo
chown root:admin /bin/ping
chmod 02750 /bin/ping
chown root:admin /bin/ifconfig
chmod 02750 /bin/ifconfig
chown root:admin /bin/w
chmod 02750 /bin/w
chown root:admin /bin/who
chmod 02750 /bin/who
chown root:admin /bin/locate
chmod 02750 /bin/locate
chown root:admin /bin/whereis
chmod 02750 /bin/whereis
chmod 700 /etc/host.conf

chown root:root /boot/grub/grub.cfg
chmod 700 /boot/grub/grub.cfg
chown root:root /etc/grub.conf
chmod og-rwx /etc/grub.conf
chown root:root /etc/crontab
chmod og-rwx /etc/crontab
chown root:root /etc/cron.hourly
chmod og-rwx /etc/cron.hourly
chown root:root /etc/cron.daily
chmod og-rwx /etc/cron.daily
chown root:root /etc/cron.weekly
chmod og-rwx /etc/cron.weekly
chown root:root /etc/cron.monthly
chmod og-rwx /etc/cron.monthly
chown root:root /etc/cron.d
chmod og-rwx /etc/cron.d
chmod og-rwx /etc/cron.allow
chmod og-rwx /etc/at.allow
chown root:root /etc/cron.allow
chown root:root /etc/at.allow
chown root:root /etc/passwd
chmod 700 /etc/passwd
chown root:shadow /etc/shadow
chmod o-rwx,g-wx /etc/shadow
chown root:root /etc/group
chmod 700 /etc/group
chown root:shadow /etc/gshadow
chmod o-rwx,g-rw /etc/gshadow
chown root:root /etc/passwd-
chmod u-x,go-wx /etc/passwd-
chown root:root /etc/shadow-
chown root:shadow /etc/shadow-
chmod o-rwx,g-rw /etc/shadow-
chown root:root /etc/group-
chmod u-x,go-wx /etc/group-
chown root:root /etc/gshadow-
chown root:shadow /etc/gshadow-    
chmod o-rwx,g-rw /etc/gshadow-
chown root:root /etc/motd
chmod 700 /etc/motd
chown root:root /etc/issue
chmod 700 /etc/issue
chown root:root /etc/issue.net
chmod 700 /etc/issue.net
chown root:root /etc/hosts.allow
chmod 700 /etc/hosts.allow
chown root:root /etc/hosts.deny
chmod 700 /etc/hosts.deny

chown root:root /etc/securetty
chmod 0600 /etc/securetty
chmod 644 /etc/crontab
chmod 640 /etc/ftpusers
chmod 440 /etc/inetd.conf
chmod 440 /etc/xinted.conf
chmod 400 /etc/inetd.d
chmod 644 /etc/hosts.allow
chmod 440 /etc/sudoers
chown root:root /etc/sudoers
chmod 600 /etc/shadow
chown root:root /etc/shadow
chmod 644 /etc/passwd
chown root:root /etc/passwd
chmod 644 /etc/group
chown root:root /etc/group
chmod 600 /etc/gshadow
chown root:root /etc/gshadow
chmod 700 /boot
chown root:root /etc/anacrontab
chmod 600 /etc/anacrontab
chown root:root /etc/crontab
chmod 600 /etc/crontab
chown root:root /etc/cron.hourly
chmod 600 /etc/cron.hourly
chown root:root /etc/cron.daily
chmod 600 /etc/cron.daily
chown root:root /etc/cron.weekly
chmod 600 /etc/cron.weekly
chown root:root /etc/cron.monthly
chmod 600 /etc/cron.monthly
chown root:root /etc/cron.d
chmod 600 /etc/cron.d
chmod 755 /etc/rc*
chmod 755 /etc/init.d*
chmod 700 /etc/profile
chmod 700 /etc/hosts.allow
chmod 700 /etc/mtab
chmod 700 /etc/utmp
chmod 700 /var/adm/wtmp
chmod 700 /var/log/wtmp
chmod 700 /etc/syslog.pid
chmod 700 /var/run/syslog.pid
chmod 700 /etc/sysctl.conf
chmod 700 /etc/inittab
chmod 644 /etc/fstab
chown root:root /etc/fstab
chmod 644 /var/log
chown root:root /var/log
chmod 644 /var/adm
chown root:root /var/adm
chmod 644 /var/tmp
chown root:root /var/tmp

PrintGreen "Common Permissions Fixed"

PrintCyan "Resolve World Writable Files:"
find / -xdev -perm +o=w ! \( -type d -perm +o=t \) ! -type l -print
read REPLY
PrintGreen "World Writable Files Resolved"

PrintCyan "Resolve Unowned Files:"
PrintLightBlue "No user"
df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -nouser
PrintLightBlue "No group"
df --local -P | awk {'if (NR!=1) print $6'} | xargs -r '{}' find '{}' -xdev -nogroup
read REPLY
PrintGreen "Unowned Files Resolved"

PrintCyan "Resolve SUID Executables"
df --local -P | awk {'if (NR!=1)print $6'} | xargs -I '{}' find '{}' -xdev -type f -perm -4000
read REPLY
PrintGreen "SUID Executables Resolved"

PrintCyan "Resolve SGID Executables"
df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -type f -perm -2000
read REPLY
PrintGreen "SGID Executables Resolved"

PrintCyan "Resolve Immutable Files"
lsattr -l -R > ./output/lsattr_output.txt
clear
PrintCyan "Resolve Immutable Files"
grep " Immutable" ./output/lsattr_output.txt
read REPLY
PrintGreen "Immutable Files Resolved"

PrintCyan "Suspicious Files"
PrintLightBlue "Files in /etc not owned by root"
ls -la /etc | grep -v "root"
PrintLightBlue "Scripts in /etc"
ls -la /etc | grep ".sh"
PrintLightBlue "Text Files in /etc"
ls -la /etc | grep ".txt"
read REPLY
PrintGreen "Sus Files Voted Out"


PrintLightBlue "Mounts and Partitions"
apt purge autofs
systemctl unmask tmp.mount

meld /etc/fstab ./config-files/filesystem/fstab

systemctl restart tmp.mount
mount -a
PrintGreen "Partitions have been Secured!"

PrintLightBlue "Configure AIDE"
prelink -ua
apt purge prelink
apt install aide aide-common
aideinit
mv /var/lib/aide/aide.db.new /var/lib/aide/aide.db

PrintCyan "Add this line to root's crontab (hit enter to access) to regularly run AIDE checks:
	0 5 * * * /usr/bin/aide.wrapper --config /etc/aide/aide.conf --check"
read REPLY
crontab -u root -e

PrintGreen "AIDE Configured!"
