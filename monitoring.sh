#!/bin/bash

LastBoot=$(who -b | awk '{print $3}')
LastBoot4=$(who -b | awk '{print $4}')
arc=$(uname -a)
CnxTCP=$(netstat | grep ESTABLISHED | awk 'NR==1 {print " "$6}')
Nmbcnx=$(netstat -s | grep -i established | awk '{print $1}')
Disktotal=$(df --total -H | grep -i total | awk '{print $2" ("$5")"}')
Diskused=$(df --total | grep -i total | awk '{printf("%.0f"), $3/1000}')
Memper=$(free -t | grep -i mem | awk ' var = 3072 {printf ("%.2f%%"), var/$2*100}')
Memused=$(free -t | grep -i mem | awk '{printf ("%.0f"), $3/1000}')
Memtotal=$(free -t |grep -i mem | awk '{printf ("%.0f"), $2/1000}')
Cpuload=$(top -b -n1 | grep -i ^%cpu | awk '{print $4"%"}')
VAR=MB
VAR1=Gb
CPU=$(lscpu | grep Processeur | awk '{print $2}')
networkip=$(hostname -I)
macadress=$(cat /sys/class/net/*/address | grep 08)
lvmt=$(lsblk | grep lvm | wc -l)
lvm=$(if [ $lvmt -ge 0 ]; then echo no; else echo yes;fi)
Userlog=$(who | awk '{print $1}' | sort -u |wc -l)
SudoNb=$(journalctl | grep -i COMMAND | wc -l)
vCPU=$(lscpu | grep Processeur | wc -l)

wall "
	#Architecture : $arc
	#CPU physical : $CPU
	#vCPU : $vCPU
	#Memory Usage : $Memused/$Memtotal$VAR ($Memper)
	#Disk Usage : $Diskused/$Disktotal
	#CPU load : $Cpuload
	#Last boot : $LastBoot $LastBoot4
	#LVM use : $lvm
	#connexions TCP : $Nmbcnx $CnxTCP
	#User log : $Userlog
	#Network : IP $networkip($macadress)
	#Sudo : $SudoNb
"