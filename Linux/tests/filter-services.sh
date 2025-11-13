#!/bin/bash

source ./colors.sh


PrintLightBlue "Common Services"
PrintCyan "Is FTP required (y/n)?  "
read yn
if [ $yn = "n" ]
then
	ufw deny ftp 
	ufw deny sftp 
	ufw deny saft 
	ufw deny ftps-data 
	ufw deny ftps
	systemctl disable vsftpd
	apt-get purge vsftpd -y -qq
	apt-get purge .*ftp.*
	PrintGreen "FTP removed!"
fi

PrintCyan "Is Samba required (y/n)?  "
read yn
if [ $yn = "n" ]
then
	ufw deny netbios-ns
	ufw deny netbios-dgm
	ufw deny netbios-ssn
	ufw deny microsoft-ds
	systemctl disable smbd
	apt-get purge samba -y -qq
	apt-get purge samba-common -y  -qq
	apt-get purge samba-common-bin -y -qq
	apt-get purge samba4 -y -qq
	apt-get remove .*samba.* .*smb*.
	PrintGreen "Samba removed!"
fi

PrintCyan "Is SSH required (y/n)?  "
read yn
if [ $yn = "n" ]
then
	ufw deny ssh
	systemctl disable sshd
	apt-get purge openssh-server -y -qq
	PrintGreen "SSH removed!"
fi

PrintCyan "Is telnet required (y/n)?  "
read yn
if [ $yn = "n" ]
then
	ufw deny telnet 
	ufw deny rtelnet 
	ufw deny telnets
	systemctl disable telnet
	apt-get purge telnet -y -qq
	apt-get purge telnetd -y -qq
	apt-get purge inetutils-telnetd -y -qq
	apt-get purge telnetd-ssl -y -qq
	apt-get purge inetd -y -qq
	apt-get purge openbsd-inetd -y -qq
	apt-get purge xinetd -y -qq
	apt-get purge inetutils-ftp -y -qq
	apt-get purge inetutils-ftpd -y -qq
	apt-get purge inetutils-inetd -y -qq
	apt-get purge inetutils-ping -y -qq
	apt-get purge inetutils-syslogd -y -qq
	apt-get purge inetutils-talk -y -qq
	apt-get purge inetutils-talkd -y -qq
	apt-get purge inetutils-telnet -y -qq
	apt-get purge inetutils-telnetd -y -qq
	apt-get purge inetutils-tools -y -qq
	apt-get purge inetutils-traceroute -y -qq
	PrintGreen "Telnet removed!"
fi

PrintCyan "Are mail server protocols required (y/n)?  "
read yn
if [ $yn = "n" ]
then
	ufw deny smtp 
	ufw deny pop2 
	ufw deny pop3
	ufw deny imap2 
	ufw deny imaps 
	ufw deny pop3s
	systemctl disable pop3
	systemctl disable icmp
	systemctl disable sendmail
	systemctl disable dovecot
	apt purge cups
	apt purge exim4
	PrintGreen "Mail Server Protocols removed!"
fi

PrintCyan "Is printing, ipp/printer/cups, required (y/n)?  "
read yn
if [ $yn = "n" ]
then
	ufw deny ipp 
	ufw deny printer 
	ufw deny cups
	systemctl disable cups
	PrintGreen "Printing protocols removed!"
fi

PrintCyan "Is SQL required (y/n)?  "
read yn
if [ $yn = "n" ]
then
	ufw deny ms-sql-s 
	ufw deny ms-sql-m 
	ufw deny mysql 
	ufw deny mysql-proxy
	apt-get purge mysql -y -qq
	apt-get purge mysql-client-core-5.5 -y -qq
	apt-get purge mysql-client-core-5.6 -y -qq
	apt-get purge mysql-common-5.5 -y -qq
	apt-get purge mysql-common-5.6 -y -qq
	apt-get purge mysql-server -y -qq
	apt-get purge mysql-server-5.5 -y -qq
	apt-get purge mysql-server-5.6 -y -qq
	apt-get purge mysql-client-5.5 -y -qq
	apt-get purge mysql-client-5.6 -y -qq
	apt-get purge mysql-server-core-5.6 -y -qq
	PrintGreen "SQL removed!"
fi

PrintCyan "Is Bind9 (for DNS servers) required (y/n)?  "
read yn
if [ $yn = "n" ]
then
	ufw deny domain
	systemctl disable bind9
	apt-get purge bind9 -qq
	PrintGreen "Bind9 removed!"
fi

PrintCyan "Is Avahi required (y/n)?  "
read yn
if [ $yn = "n" ]
then
	systemctl disable avahi-daemon
	apt purge .*avahi.*
fi

PrintCyan "Is DHCP Server protocol required (y/n)?  "
read yn
if [ $yn = "n" ]
then
	systemctl disable isc-dhcp-server
	systemctl disable isc-dhcp-server6
fi

PrintCyan "Is Slapd (LDAP host) required (y/n)?  "
read yn
if [ $yn = "n" ]
then
	systemctl disable slapd
	apt-get purge ldap-utils
fi

PrintCyan "Is NFS (or other file sharing) required (y/n)?  "
read yn
if [ $yn = "n" ]
then
	systemctl disable nfs-server
	systemctl disable rpcbind
	systemctl disable rsync
	apt-get purge nfs-kernel-server -y -qq
	apt-get purge nfs-common -y -qq
	apt-get purge portmap -y -qq
	apt-get purge rpcbind -y -qq
	apt-get purge autofs -y -qq
fi

PrintCyan "Is Apache required (y/n)?  "
read yn
if [ $yn = "n" ]
then
	systemctl disable apache2
	apt purge .*apache.*
fi

PrintCyan "Is Squid proxy required (y/n)?  "
read yn
if [ $yn = "n" ]
then
	systemctl disable squid
fi

PrintCyan "Is SNMP required (y/n)?  "
read yn
if [ $yn = "n" ]
then
	systemctl disable snmpd
	apt-get purge snmp -y -qq
fi

PrintCyan "Is NIS (Network Information System) required (y/n)?  "
read yn
if [ $yn = "n" ]
then
	systemctl disable nis
	apt-get purge nis
fi

PrintCyan "Is RSH (Remote Shell) or talk required (y/n)?  "
read yn
if [ $yn = "n" ]
then
	apt-get purge rsh-client rsh-redone-client
	apt-get purge talk
fi

PrintCyan "Is Bluetooth required (y/n)?  "
read yn
if [ $yn = "n" ]
then
	apt purge bluetooth
fi

PrintCyan "Are VNC packages required (y/n)?  "
read yn
if [ $yn = "n" ]
then
	apt-get purge vnc4server -y -qq
	apt-get purge vncsnapshot -y -qq
	apt-get purge vtgrab -y -qq
fi

apt autoclean
apt autoremove

PrintGreen "Common Services Secured!"
