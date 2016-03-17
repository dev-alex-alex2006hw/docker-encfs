#!/bin/bash

user=$(whoami)

## if encfs is not set for account, exit now
if [ ! -f /home/$user/.encfs6.xml ]; then
    echo encfs password is not set up for user $user
    exit 1
fi
echo ssh loged $(date) > /home/$user/.status

check_shadow(){
    docker inspect --format="{{ .State.Running }}" shadow-$user &> /dev/null
}

check_compute(){
    docker inspect --format="{{ .State.Running }}" compute-$user &> /dev/null
}

if ! check_shadow ; then
    docker run -i --rm --hostname $HOSTNAME -P \
	   -v /home/$user/.status:/etc/docker_status \
	   --cap-add SYS_ADMIN --device /dev/fuse \
	   --name shadow-$user nfs-server \
	   $user `id -u $user` `id -g $user` &> /dev/null &
fi

while :; do
    if check_shadow ; then
	break
    fi
done

if ! check_compute ; then
    echo compute started >> /home/$user/.status   
    grep "root\|ssh\|$user" /etc/passwd > /home/$user/.passwd
    grep "root\|ssh\|$user" /etc/group > /home/$user/.group
        
    # --hostname confilt --net, set it in shadow
    docker run -i --rm --net=container:shadow-$user --name compute-$user \
	   -v /home/$user/.passwd:/etc/passwd:ro \
	   -v /home/$user/.group:/etc/group:ro \
	   -v /home/$user/.status:/etc/docker_status \
	   --cap-add SYS_ADMIN nfs-client $user &> /dev/null &
fi

while :; do
    if check_compute ; then
	break
    fi
done

ssh_port=$(docker port shadow-$user 22 | awk -F: '{print $2}')
#echo $HOSTNAME $ssh_port > /home/$user/.port
#chmod 0600 /home/$user/.port

while :; do
    if ssh -q -p $ssh_port $(hostname) date &> /dev/null ; then
	break
    fi
done

#scp works with these ssh options, -q disables ssh_banner
ssh -A -X -p $ssh_port $(hostname) "$SSH_ORIGINAL_COMMAND"

