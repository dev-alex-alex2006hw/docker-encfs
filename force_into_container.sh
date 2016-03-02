#!/bin/bash

user=$(whoami)
encfs_passwd=password
docker run -d --cap-add SYS_ADMIN --device /dev/fuse --name shadow-$user nfs-server $user $encfs_passwd &> /dev/null

docker run -it --rm --name compute-$user --cap-add SYS_ADMIN --link shadow-$user:nfs nfs-client 

RUNNING=$(docker inspect --format="{{ .State.Running }}" compute-$user 2> /dev/null)

if [ $? -eq 1 ]; then
    docker stop shadow-$user &> /dev/null
    docker rm shadow-$user &> /dev/null
fi
