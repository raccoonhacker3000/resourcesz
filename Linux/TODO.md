# Changes to Make
* Search for weird files in baseline
	* SUID / SGID / Immutable files
	* Scripts / Text files in /etc
* Make better backups
* Polkit Security

# Gameplans
* Eventually be able to download a zip file with `/Linux` directory without cloning entire repo

## Baselining
1. Copy and map out all relevant directories and their best usage.
2. Create a util to compare and see if there are any effective differences between files.
3. Use this util as part of baselining.
**Directories to Check**
* /etc/modprobe.d/*
* /etc/grub.d/*
* /etc/default/*
* $PATH

## Tools to add
* OpenVAS 
* Nessus
* debsums

## Important utils
* View File Ommitting Commented Lines: `grep -v "^#" <file>`

## Random Notes:
* `/etc/nsswitch.conf` (Similar to /etc/hosts file)
* `/etc/init.d/*` -> startup scripts
* Reboot is needed to have auditd rules in effect


## Recommended Order:
* Backups
* Baseline
* Users
* Updates
* [Restart]
* Kernel
* Firewall
* PAM
* Auditd
* [Restart]
* Permissions
* Unauthorized Material
* Service Filtering (Basic Services)
* Antimalware
* Backdoors
* Critical Services
* [Restart]
* Baseline
