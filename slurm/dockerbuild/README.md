```
docker run -d --name slurmctld --net stack --hostname slurmctld -p 6817:6817 slurmctld sleep 1000000
docker run -d --name node1 --net stack --hostname node1 slurmd sleep 1000000

#!/bin/bash

# on all
munged

# on slurmctld 
slurmctld -D -v -c &> /var/log/slurmctld.log &

# on slurmd
slurmd -D -v  &> /var/log/slurmd.log &

# on all, /etc/slurm/slurm.conf must be the same
```