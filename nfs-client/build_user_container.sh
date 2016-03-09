#!/bin/bash
user=$1

#compute-$user is a container that has only $user account, no others

if docker images | grep compute-$user &> /dev/null ; then
    exit 0
else
    cp -f /etc/ssh/ssh_known_hosts .
    cp -f /etc/ssh/shosts.equiv .

    grep "ssh\|$user" /etc/passwd > passwd
    grep "ssh\|$user" /etc/group > group
    
    docker build -t compute-$user .
fi
