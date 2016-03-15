#!/bin/bash

user=$(whoami)

## if encfs is not set for account, exit now
if [ ! -f /home/$user/.encfs6.xml ]; then
    echo encfs password is not set up for user $user
    exit 1
fi

RUNNING1=$(docker inspect --format="{{ .State.Running }}" shadow-$user 2> /dev/null)

if [ $? -eq 1 ]; then
    docker run -d --hostname $HOSTNAME -P \
	   --cap-add SYS_ADMIN --device /dev/fuse \
	   --name shadow-$user nfs-server \
	   $user `id -u $user` `id -g $user` &> /dev/null
fi

if [ "$RUNNING1" == "false" ]; then
    docker restart shadow-$user
fi

RUNNING2=$(docker inspect --format="{{ .State.Running }}" compute-$user 2> /dev/null)

if [ $? -eq 1 ]; then
    echo started : $(date) > /home/$user/.status   
    grep "root\|ssh\|$user" /etc/passwd > /home/$user/.passwd
    grep "root\|ssh\|$user" /etc/group > /home/$user/.group
        
    # --hostname confilt --net, set it in shadow
    docker run -d --net=container:shadow-$user --name compute-$user \
	   -v /home/$user/.passwd:/etc/passwd:ro \
	   -v /home/$user/.group:/etc/group:ro \
	   -v /home/$user/.status:/etc/docker_status \
	   --cap-add SYS_ADMIN nfs-client $user &> /dev/null
    
    sleep 2
fi

if [ "$RUNNING2" == "false" ]; then
    docker restart compute-$user
fi

ssh_port=$(docker port shadow-$user 22 | awk -F: '{print $2}')
#echo $HOSTNAME $ssh_port > /home/$user/.port
#chmod 0600 /home/$user/.port

#scp works with these ssh options, -q disables ssh_banner
ssh -A -X -p $ssh_port $(hostname) "$SSH_ORIGINAL_COMMAND"

