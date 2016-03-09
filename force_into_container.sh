#!/bin/bash

user=$(whoami)
user_passwd=password

RUNNING1=$(docker inspect --format="{{ .State.Running }}" shadow-$user 2> /dev/null)

if [ $? -eq 1 ]; then
    docker run -d -P --cap-add SYS_ADMIN --device /dev/fuse --name shadow-$user nfs-server $user $user_passwd &> /dev/null
fi

if [ "$RUNNING1" == "false" ]; then
    docker restart shadow-$user
fi

RUNNING2=$(docker inspect --format="{{ .State.Running }}" compute-$user 2> /dev/null)

if [ $? -eq 1 ]; then
    docker run -d --net=container:shadow-$user --name compute-$user \
	   -v /etc/passwd:/etc/passwd \
	   -v /etc/group:/etc/group \
	   --cap-add SYS_ADMIN nfs-client \
	   $user $user_passwd &> /dev/null
fi

if [ "$RUNNING2" == "false" ]; then
    docker restart compute-$user
fi

#    docker stop compute-$user &> /dev/null
#    docker rm compute-$user &> /dev/null

ssh_port=$(docker port shadow-$user 22 | awk -F: '{print $2}')
ssh $user@localhost -p $ssh_port
