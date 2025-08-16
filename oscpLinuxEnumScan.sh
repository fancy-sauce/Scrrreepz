#!/bin/bash

# Check if the current user is a sudoer
if sudo -n true 2>/dev/null; then
    echo "---------User is a sudoer. Running privileged commands..."

    # Add your privileged commands below
    echo "---------Listing cron jobs for the root user"
    sudo crontab -l

else
    echo "---------User is NOT a sudoer. Skipping privileged commands."
fi

echo "---------current user info"
id

echo "---------check hostname"
hostname

echo "---------OS info"
cat /etc/issue
uname -a

echo "---------Passwd file"
cat /etc/passwd

echo "---------shadow file"
ls -l /etc/shadow

echo "---------processes, check for Root owned processes that are vulnerable"
ps aux

echo "---------List network routes"
routel

echo "---------Check listening connections, try local services on loopback:"
ss -anp

echo "---------Inspecting custom IP tables"
cat /etc/iptables/rules.v4

echo "---------Listing all cron jobs"
ls -lah /etc/cron*

echo "---------Listing cron jobs for the current user"
crontab -l

echo "---------Listing all Debian installed packages"
dpkg -l

echo "---------Listing all world writable directories"
find / -writable -type d 2>/dev/null

echo "---------Listing content of /etc/fstab and all mounted drives"
cat /etc/fstab
mount

echo "---------Listing all available drives using lsblk"
lsblk

echo "---------Listing loaded drivers, check specific versions using /sbin/modinfo drivername. Check section 18.1.2 for more info"
lsmod

echo "---------Searching for SUID files...Try linpeas.sh for more detail on vulns, and GTFOBins for exploits"
find / -perm -u=s -type f 2>/dev/null

echo "---------Inspecting Environment Variables"
env

cat .bashrc

echo "---------Harvesting Active Processes for Credentials"
watch -n 1 "ps -aux | grep pass"

echo "---------Using tcpdump to Perform Password Sniffing"
sudo tcpdump -i lo -A | grep "pass"

echo "---------Inspecting the cron log file"
grep "CRON" /var/log/syslog

echo "---------Enumerating Linux Capabilities, another good place to check binary SUIDs to GTFOBins"
/usr/sbin/getcap -r / 2>/dev/null

echo "---------Gathering general information on the target system"
cat /etc/issue


echo "---------Gathering kernel and architecture information"
uname -r

arch














