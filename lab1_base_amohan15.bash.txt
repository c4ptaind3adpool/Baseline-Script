#!/bin/bash

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
