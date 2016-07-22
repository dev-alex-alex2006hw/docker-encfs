#!/bin/bash

user=$1
run_time=$2
mshost=$3

check_container(){
    docker inspect --format="{{ .State.Running }}" $(hostname) &> /dev/null
}

check_mount(){
    docker exec -i $(hostname) grep "encfs /home/$user" /proc/mounts &> /dev/null
}

env > /tmp/$user.env
echo $mshost > /tmp/$user.mshost

if ! check_container ; then
    docker pull 10.0.15.16:5000/compute &> /dev/null
    docker run -i --rm --hostname $HOSTNAME \
	   -v /home/$user/encrypted:/mnt/do_not_use \
	   -v /etc/passwd:/etc/passwd:ro \
	   -v /etc/group:/etc/group:ro \
           -v /tmp/$user.mshost:/etc/ssh/shosts.equiv:ro \
	   -v /home/$user \
	   --env-file /tmp/$user.env \
	   --net net-$user \
	   -v /opt:/opt:ro \
           -v /var/spool/torque:/var/spool/torque \
	   --cap-drop FOWNER --cap-drop SETPCAP --cap-drop SETFCAP --cap-drop MKNOD \
	   --cap-add SYS_ADMIN --device /dev/fuse \
	   --name $(hostname) 10.0.15.16:5000/compute \
	   $user $run_time &> /dev/null &
fi

while :; do
    if check_mount ; then
	break
    fi
    sleep 0.5
done







