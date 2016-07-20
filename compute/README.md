```
job_starter:
sudo docker run -i --rm -v /var/spool/torque/:/var/spool/torque/ ubuntu $*
## job script is saved by torque as /var/spool/torque/mom_priv/jobs/27.test3.SC

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
*hostbased auth, pam disabled
*job containers are put in a private overlay network
*container hostname is the same as host's hostname
*openmpi usage: mpirun -host `paste -s -d, $PBS_NODEFILE` -n $PBS_NP excutable (--hostfile fails)
*  
```
