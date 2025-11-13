#!/bin/bash

source ./colors.sh


PrintCyan "Disable IPv6 (y/n)?  "
read yn
if [ $yn = "y" ]
then
	echo "net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1" >> /etc/sysctl.conf

	sed -i "s/GRUB_CMDLINE_LINUX.*/GRUB_CMDLINE_LINUX=\"ipv6.disable=1\"/" /etc/default/grub
	if [ $? -ne 0 ]
	then
		PrintCyan "/etc/default/grub
	# add => ipv6.disable=1 to GRUB_CMDLINE_LINUX
	GRUB_CMDLINE_LINUX=\"ipv6.disable=1\" \n==============================================================\n[Press Enter]\n=============================================================="
		read REPLY
	fi
	update-grub
	PrintGreen "IPv6 Disabled"
fi

PrintLightBlue "Kernel Security Policies"

meld ./config-files/kernel/sysctl.conf /etc/sysctl.conf

# limits.conf
echo "* hard core 0" >> /etc/security/limits.conf
echo "* soft core 0" >> /etc/security/limits.conf

chmod 700 /etc/sysctl.conf
sysctl -p
systemctl daemon-reload
PrintGreen "All SystemCTL Policies Updated"

PrintCyan "Ensure only 1 IP interface exists \n==============================================================\n[Press Enter]\n=============================================================="
ip address
read REPLY

PrintLightBlue "Disable USBs"
apt install usbgaurd -y
systemctl enable usbgaurd
echo "install usb-storage /bin/true
blacklist usb_storage" >> /etc/modprobe.d/usb.conf
PrintGreen "USBs Disabled"

PrintLightBlue "Unwanted File System Kernel Modules"
modprobe -r cramfs
modprobe -r freevxfs
modprobe -r jffs2
modprobe -r hfs
modprobe -r hfsplus
modprobe -r udf
systemctl stop autofs
systemctl disable autofs
echo "install cramfs /bin/true
blacklist cramfs
install freevxfs /bin/true
blacklist freevxfs
install jffs2 /bin/true
blacklist jffs2
install hfs /bin/true
blacklist hfs
install hfsplus /bin/true
blacklist hfsplus
install udf /bin/true
blacklist udf" > /etc/modprobe.d/CIS.conf
PrintGreen "Unwanted Kernel Modules Blacklisted"

PrintLightBlue "Boot Security"
chown root:root /boot/grub/grub.cfg
chmod u-wx,go-rwx /boot/grub/grub.cfg

pw="Akry%150Akry%150"
echo -e "$pw\n$pw" | grub-mkpasswd-pbkdf2

meld /etc/grub.d/grub-custom ./config-files/kernel/grub-custom.cfg
grub-mkconfig
update-grub

echo -e "$pw\n$pw" | passwd root
PrintGreen "Boot Security Completed!"

PrintLightBlue "Ensure Automatic Error Reporting is not enabled"
apt purge apport
echo "enabled=0" > /etc/default/apport
PrintGreen "Apport has been purged!"

PrintLightBlue "Restrict Core Dumps"
meld /etc/systemd/coredump.conf ./config-files/kernel/coredump.conf

systemctl daemon-reload
apt autoclean
apt autoremove

PrintGreen "Core Dumps Restricted!"