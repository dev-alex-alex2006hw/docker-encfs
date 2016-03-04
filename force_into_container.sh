#!/bin/bash

user=$(whoami)
encfs_passwd=password
docker run -d --cap-add SYS_ADMIN --device /dev/fuse --name shadow-$user nfs-server $user $encfs_passwd &> /dev/null

docker run -it --rm --net=container:shadow-$user --name compute-$user --cap-add SYS_ADMIN nfs-client

RUNNING=$(docker inspect --format="{{ .State.Running }}" compute-$user 2> /dev/null)

if [ $? -eq 1 ]; then
    docker stop shadow-$user &> /dev/null
    docker rm shadow-$user &> /dev/null
fi
