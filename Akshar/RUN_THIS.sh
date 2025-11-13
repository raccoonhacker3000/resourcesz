#!/bin/bash

source ./colors.sh

if (( EUID != 0 )); then
	PrintRed "This script must be run as root."
	exit -1
fi

chmod -R a=rwx ./tests/
mkdir ./output

./tests/backups.sh
./tests/baseline.sh
./tests/updates.sh
./tests/kernel.sh
./tests/firewall.sh
./tests/auditd.sh
./tests/backdoor.sh
./tests/antimalware.sh
./tests/filesystem.sh
./tests/critical-services/ssh.sh
