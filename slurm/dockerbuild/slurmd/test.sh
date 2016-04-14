#!/bin/bash
user=vagrant
grep "$user" /etc/passwd > /home/$user/.passwd
grep "$user" /etc/group > /home/$user/.group

for i in `seq 21 22`; do
    docker run -d --name node$i --hostname node$i --net stack2 \
	   -v /home/$user/.passwd:/etc/upasswd \
	   -v /home/$user/.group:/etc/ugroup \
	   -v /home/$user:/mnt/encry1 \
	   --cap-add SYS_ADMIN --device /dev/fuse \
	   compute/slurmd:encfs slurmctld2 node2[1-2]
done
