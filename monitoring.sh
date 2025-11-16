#!/bin/bash
{
echo "#Architecture: $(uname -a)"
echo "#CPU physical : $(nproc)"
echo "#vCPU : $(grep -c 'processor' /proc/cpuinfo)"
echo "#Memory Usage: $(free -m | grep Mem | awk '{printf "%s/%sMB (%.2f%%)", $3, $2, $3/$2 * 100}')"
echo "#Disk Usage: $(df -BM --total | awk '/total/ {printf "%s/%.0fGb (%s)", $3, $2/1000, $5}' | tr -d 'M')"
echo "#CPU load: $(uptime | awk -F'load average:' '{print $2}' | awk '{print $1}' | tr -d ',')%"
echo "#Last boot: $(who -b | awk '{print $3,$4}')"
echo "#LVM use: $(lsblk | grep -q 'lvm' && echo yes || echo no)"
echo "#Connections TCP : $(ss -t | grep -c ESTAB) ESTABLISHED"
echo "#User log: "`who | grep -c $USER`
echo "#Network: IP $(hostname -I)($(ip link | awk '/link\/ether/ {print $2}'))"
echo "#Sudo : $(journalctl _COMM=sudo | grep -c COMMAND) cmd"
}| wall

