#!/bin/bash

user=vagrant
stack=stack
slctld=slurmctld
nodelist=node[1-5]

grep "$user" /etc/passwd > /home/$user/.passwd
grep "$user" /etc/group > /home/$user/.group

docker run -d --name $slctld --hostname $slctld --net $stack \
       	   -v /home/$user/.passwd:/etc/upasswd \
	   -v /home/$user/.group:/etc/ugroup \
	   compute/slurmctld $slctld $nodelist

docker exec -i $slctld /usr/local/bin/run_slurmctld vagrant

for i in `seq 1 5`; do
    docker run -d --name node$i --hostname node$i --net $stack \
	   -v /home/$user/.passwd:/etc/upasswd \
	   -v /home/$user/.group:/etc/ugroup \
	   -v /home/$user:/mnt/encry1 \
	   --cap-add SYS_ADMIN --device /dev/fuse \
	   compute/slurmd $slctld $nodelist

    docker exec -i node$i /usr/local/bin/setup_encfs vagrant 1000 1000
    docker exec -i node$i /usr/local/bin/run_slurmd vagrant 
done

sleep 5
docker exec -it node1 runuser -l vagrant -c "srun -N 5 hostname"

