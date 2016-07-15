#!/bin/bash

user=$1
run_time=$2

check_container(){
    docker inspect --format="{{ .State.Running }}" compute-$user &> /dev/null
}

env > /tmp/$user.env

if ! check_container ; then
    docker pull 10.0.15.16:5000/compute &> /dev/null
    docker run -i --rm --hostname $HOSTNAME \
	   -v /home/$user/encrypted:/mnt/do_not_use \
	   -v /etc/passwd:/etc/passwd:ro \
	   -v /etc/group:/etc/group:ro \
	   -v /home/$user \
	   --env-file /tmp/$user.env \
           -v /var/spool/torque:/var/spool/torque \
	   --cap-drop FOWNER --cap-drop SETPCAP --cap-drop SETFCAP --cap-drop MKNOD \
	   --cap-add SYS_ADMIN --device /dev/fuse \
	   --name compute-$user 10.0.15.16:5000/compute \
	   $user $run_time &> /dev/null &
fi

while :; do
    if check_container ; then
	break
    fi
    sleep 0.5
done





