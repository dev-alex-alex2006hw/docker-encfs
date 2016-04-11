#!/bin/bash

# munge auth
/usr/sbin/munged

slurmctl_host=$1
slurmctl_addr=`ping $slurmctld_host -c 1 | grep PING | awk '{print $3}' | sed 's/\((\|)\)//g'`
nodelist=$2

# munge auth
/usr/sbin/munged

# edit slurm.conf
#ControlMachine=
#ControlAddr=
sed -i "/ControlMachine=/c\ControlMachine=$slurmctl_host " /etc/slurm/slurm.conf
sed -i "/ControlAddr=/c\ControlAddr=$slurmctl_addr " /etc/slurm/slurm.conf

#NodeName=node[1-10] Procs=1 State=UNKNOWN
#PartitionName=main Nodes=node[1-10] Default=YES MaxTime=INFINITE State=UP
sed -i "/NodeName=/c\NodeName=$nodelist Procs=1 State=UNKNOWN" /etc/slurm/slurm.conf
sed -i "/PartitionName=/c\PartitionName=main Nodes=$nodelist Default=YES MaxTime=INFINITE State=UP" /etc/slurm/slurm.conf

# slurmctld daemon
slurmd -D -v  &> /var/log/slurmd.log &

while :; do
    sleep 900
done
