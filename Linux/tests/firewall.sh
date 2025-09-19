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


PrintLightBlue "Initialize UFW"
ufw enable
ufw logging on
ufw logging high
ufw default deny incoming
ufw default allow outgoing

sed -i "s/DEFAULT_FORWARD_POLICY=.*/DEFAULT_FORWARD_POLICY=\"DROP\"/" /etc/default/ufw
sed -i "s/IPV6=.*/IPV6=no/" /etc/default/ufw

ufw reload

PrintGreen "Firewall Enabled"

PrintLightBlue "IPTables in Tandem"
PrintCyan "Is IPTables allowed (y/n)?  "
read yn
if [ $yn = "y" ]
then
	apt-get install iptables
	iptables -F
	iptables -P INPUT DROP
	iptables -P OUTPUT DROP
	iptables -P FORWARD DROP
	iptables -A INPUT -i lo -j ACCEPT
	iptables -A OUTPUT -o lo -j ACCEPT
	iptables -A INPUT -s 127.0.0.0/8 -j DROP
	iptables -A OUTPUT -p tcp -m state --state NEW,ESTABLISHED -j ACCEPT
	iptables -A OUTPUT -p udp -m state --state NEW,ESTABLISHED -j ACCEPT
	iptables -A OUTPUT -p icmp -m state --state NEW,ESTABLISHED -j ACCEPT
	iptables -A INPUT -p tcp -m state --state ESTABLISHED -j ACCEPT
	iptables -A INPUT -p udp -m state --state ESTABLISHED -j ACCEPT
	iptables -A INPUT -p icmp -m state --state ESTABLISHED -j ACCEPT
fi

