#!/bin/bash
# Project: Linux Security Baseline & Platform Audit
# Author: Arnav Mohan
# Licensed under the MIT License (see LICENSE file for details)
# Description: Automated collection of system telemetry for security hardening 
# and compliance auditing (CIS/ISO 27001).
# Target OS: RHEL/CentOS/Fedora

# Check for Root Privileges
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root to collect full security telemetry." 
   exit 1
fi

echo "-------------------------------------------------------"
echo "Starting System Security Baseline: $(date)"
echo "-------------------------------------------------------"

echo -e "(a) hostname\n"
hostname

echo -e "\n(b) disk/partition size, usage, and mount points\n"
df -h

echo -e "\n(c) network devices (name)\n"
netstat -i

echo -e	"\n(d) IP address, broadcast, and netmask for each active device\n"
ip a

echo -e	"\n(e) OS version/release level, kernel version used\n"
cat /proc/sys/kernel/{ostype,osrelease,version}

echo -e	"\n(f) security mode (SELinux status)\n"
sestatus

echo -e	"\n(g) firewall configuration\n"
firewall-cmd --list-all;sudo iptables -Lnv

echo -e	"\n(h) list of active repositories\n"
yum repolist enabled     

echo -e	"\n(i) number of software packages (rpm, deb, etc) installed\n"
rpm -qa | wc -c

echo -e	"\n(j) name of software packages installed\n"
rpm -qa 

echo -e	"\n(k) dns server configured\n"
cat /etc/resolv.conf

echo -e	"\n(l) list of active shell users\n"
cat /etc/passwd | cut -d: -f1

echo -e	"\n(m) date the os was first installed\n"
rpm -q basesystem --qf '%{installtime:date}\n'

echo -e	"\n(n) hardware details\n"
cat /proc/{cpuinfo,meminfo,scsi/scsi}

echo -e	"\n(o) services current running\n"
systemctl list-units --type=service --state=running

echo -e	"\n(p) services installed but not running\n"
systemctl list-units --type=service --state=inactive --all
