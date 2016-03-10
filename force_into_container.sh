#!/bin/bash

user=$(whoami)
user_passwd=vagrant

RUNNING1=$(docker inspect --format="{{ .State.Running }}" shadow-$user 2> /dev/null)

if [ $? -eq 1 ]; then
    docker run -d --hostname $HOSTNAME -P --cap-add SYS_ADMIN --device /dev/fuse --name shadow-$user nfs-server $user $user_passwd `id -u $user` `id -g $user` &> /dev/null
fi

if [ "$RUNNING1" == "false" ]; then
    docker restart shadow-$user
    #recheck, if still not running, rm and start new
fi

RUNNING2=$(docker inspect --format="{{ .State.Running }}" compute-$user 2> /dev/null)

if [ $? -eq 1 ]; then
    grep "root\|ssh\|$user" /etc/passwd > /home/$user/.passwd
    grep "root\|ssh\|$user" /etc/group > /home/$user/.group
    
 #   cp /etc/passwd  /home/$user/passwd
 #   cp /etc/group  /home/$user/group
    # --hostname confilt --net, set it in shadow
    docker run -d --net=container:shadow-$user --name compute-$user \
	   -v /home/$user/.passwd:/etc/passwd \
	   -v /home/$user/.group:/etc/group \
	   --cap-add SYS_ADMIN nfs-client \
	   $user $user_passwd &> /dev/null
fi

if [ "$RUNNING2" == "false" ]; then
    docker restart compute-$user
    #recheck, if still not running, rm and start new
fi

#    docker stop compute-$user &> /dev/null
#    docker rm compute-$user &> /dev/null

ssh_port=$(docker port shadow-$user 22 | awk -F: '{print $2}')
echo $HOSTNAME $ssh_port > /home/$user/.port
chmod 0600 /home/$user/.port

sleep 3
#ssh $user@$HOSTNAME -p $ssh_port
