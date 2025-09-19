# **TABLE OF CONTENTS**
1. [Forensics](#forensics) (~45 minutes)
2. [Run Script](#run-script) (~1 hour)
	* [Backdoor Hunting](#backdoor-hunting) (~15 minutes)
	* [Antimalware](#antimalware) (~forever, use a third terminal)


# Forensics
[Table of Contents](#table-of-contents) <br/>

**Tips:**
* Read the README and finish EACH instruction outlined.
* Find documentation for applications asked about in the question

**Find location of a program**
```
whereis <program>
```

**Find owner of package**
```
dpkg -S <package>
```

**Logs**
```
/var/log/message
	Where whole system logs or current activity logs are available.
```

```
/var/log/auth.log
	Authentication logs.
```

```
/var/log/kern.log
	Kernel logs.
```

```
/var/log/cron.log
	Crond logs (cron job).
```

```
/var/log/maillog
	Mail server logs.
```

```
/var/log/boot.log
	System boot log.
```

```
/var/log/mysqld.log
	MySQL database server log file
```

```
/var/log/secure
	Authentication log.
```

```
/var/log/utmp || /var/log/wtmp
	Login records file.
```

**Shares**
```
/mnt directory
```

```
/media directory
```


# Run the Script
* Log into Github, download tar, move it into root directory.

```
tar -xvf Linux.tar
rm Linux.tar
cd Linux

sed -i -e 's/\r$//' fixer.sh
chmod a=rwx fixer.sh
./fixer.sh tests
./fixer.sh config-files
./fixer.sh mint.sh

chmod a=rwx mint.sh
./mint.sh
```

# Backdoor Hunting

* NMAP Scan (Included in script)
```
apt install nmap -y && nmap -sV -p- 127.0.0.1 > nmap_scan.txt && apt purge nmap -y
cat nmap_scan.txt
```

* View all processes
```
ps -aux
```

* Check /proc for hidden processes
```
ls -la /proc/*/exe  # Uses /proc to see all processes, * is where PID exists
```

* View all open ports (sockets)
```
ss -lntup  # Gives port number instead of process
ss -ltup  # Tries to resolve process name
```

* Find file used to create a process
```
which <process_name>
```

* Find file that is using the port/pid
```
lsof -i :<port>
```
```
lsof -p <pid>
```

* Is there a service using the port?
```
systemctl list-units --type=service --state=active | grep <keywords>
```

* Is there a package using the port?
```
apt list --installed | grep <keywords>
```

* Remove the package (if exists)
```
apt purge <package>
apt autoremove
apt autoclean
```

* Remove the service (if exists)
```
systemctl stop <service>
systemctl disable <service>
```

* Delete the file using the port
```
rm -r <location>
kill -9 <Process ID>
killall -p <process name>
```

# Antimalware
**ClamAV**
```
apt-get install clamav clamav-daemon -y

systemctl stop clamav-freshclam.service
freshclam
mkdir /clamav-alerts
clamscan --infected --copy="/clamav-alerts" --recursive --bell --detect-structured /
```
