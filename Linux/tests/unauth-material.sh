#!/bin/bash

source ./colors.sh

PrintCyan "Remove All Media Files (y/n)?"
read yn

if [ "$yn" = "y" ]
then
	find / -name '*.mp3' -type f -delete
	find / -name '*.mov' -type f -delete
	find / -name '*.mp4' -type f -delete
	find / -name '*.avi' -type f -delete
	find / -name '*.mpg' -type f -delete
	find / -name '*.mpeg' -type f -delete
	find / -name '*.flac' -type f -delete
	find / -name '*.m4a' -type f -delete
	find / -name '*.flv' -type f -delete
	find / -name '*.ogg' -type f -delete
	find /home -name '*.gif' -type f -delete
	find /home -name '*.png' -type f -delete
	find /home -name '*.jpg' -type f -delete
	find /home -name '*.jpeg' -type f -delete
fi

PrintGreen "Media Files Managed"

PrintCyan "Remove All Hacking Tools (y/n)?"
read yn

if [ "$yn" = "y" ]
then
	# Netcat
	apt-get purge netcat -y -qq
	apt-get purge netcat-openbsd -y -qq
	apt-get purge netcat-traditional -y -qq
	apt-get purge ncat -y -qq
	apt-get purge pnetcat -y -qq
	apt-get purge socat -y -qq
	apt-get purge sock -y -qq
	apt-get purge socket -y -qq
	apt-get purge sbd -y -qq
	rm /usr/bin/nc

	# John
	apt-get purge john -y -qq
	apt-get purge john-data -y -qq

	# Hydra
	apt-get purge hydra -y -qq
	apt-get purge hydra-gtk -y -qq

	# Aircrack
	apt-get purge aircrack-ng -y -qq

	# fcrackzip
	apt-get purge fcrackzip -y -qq

	# lcrack
	apt-get purge lcrack -y -qq

	# ophcrack
	apt-get purge ophcrack -y -qq
	apt-get purge ophcrack-cli -y -qq

	# pdfcrack
	apt-get purge pdfcrack -y -qq

	# Pyrit
	apt-get purge pyrit -y -qq

	# RARCrack
	apt-get purge rarcrack -y -qq

	# SipCrack
	apt-get purge sipcrack -y -qq

	# IRPAS
	apt-get purge irpas -y -qq

	# Wireshark
	apt purge wireshark -y

	# Zeitgeist
	apt-get purge zeitgeist-core -y -qq
	apt-get purge zeitgeist-datahub -y -qq
	apt-get purge python-zeitgeist -y -qq
	apt-get purge rhythmbox-plugin-zeitgeist -y -qq
	apt-get purge zeitgeist -y -qq

	# LogKeys
	apt-get purge logkeys -y -qq

	# Aisleriot
	apt-get purge aisleriot
fi

apt clean
apt autoclean
apt autoremove

PrintGreen "Hacking Tools Removed"
