```
job script is saved by torque as /var/spool/torque/mom_priv/jobs/27.test3.SC

[root@test4 ~]# cat /var/spool/torque/mom_priv/jobs/27.test3.SC
#!/bin/bash

#PBS -l nodes=1
#PBS -N test
#PBS -j oe
sleep 100
cat /proc/1/cgroup

/etc/sudoer:
Defaults   env_keep += "LOGNAME"
%hipaa ALL=(ALL) NOPASSWD: /usr/bin/exec_docker_container

*sshd is needed for MPI jobs
*openmpi use ssh to start jobs
*ssh hostbased auth, pam disabled
*/etc/ssh/shosts.equiv have PBS_MSHOST and login-pd
*ssh_knonwn_hosts use wildcard
*ssh_keys baked in, same for all container
*job containers are put in a private overlay network
*container hostname is the same as host's hostname
*openmpi usage: mpirun --mca btl_tcp_if_include eth0 -host `paste -s -d, $PBS_NODEFILE` -n $PBS_NP excutable (--hostfile fails)

network interface inside docker with overlay network eth0:
[root@2b3117ac583c /]# ifconfig
eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1450
inet 10.0.0.4  netmask 255.255.255.0  broadcast 0.0.0.0
inet6 fe80::42:aff:fe00:4  prefixlen 64  scopeid 0x20<link>
ether 02:42:0a:00:00:04  txqueuelen 0  (Ethernet)
RX packets 8  bytes 648 (648.0 B)
RX errors 0  dropped 0  overruns 0  frame 0
TX packets 8  bytes 648 (648.0 B)
TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

eth1: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
inet 172.18.0.4  netmask 255.255.0.0  broadcast 0.0.0.0
inet6 fe80::42:acff:fe12:4  prefixlen 64  scopeid 0x20<link>
ether 02:42:ac:12:00:04  txqueuelen 0  (Ethernet)
RX packets 13659  bytes 23617801 (22.5 MiB)
RX errors 0  dropped 0  overruns 0  frame 0
TX packets 9771  bytes 532568 (520.0 KiB)
TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
inet 127.0.0.1  netmask 255.0.0.0
inet6 ::1  prefixlen 128  scopeid 0x10<host>
loop  txqueuelen 0  (Local Loopback)
RX packets 108  bytes 16396 (16.0 KiB)
RX errors 0  dropped 0  overruns 0  frame 0
TX packets 108  bytes 16396 (16.0 KiB)
TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

```
