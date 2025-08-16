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

echo "---------Passwd file"
cat /etc/passwd

echo "---------check hostname"
hostname

echo "---------shadow file"
ls -l /etc/shadow

echo "---------OS info"
cat /etc/issue

uname -a

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



echo "---------Listing all installed packages on a Debian Linux operating system"
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
