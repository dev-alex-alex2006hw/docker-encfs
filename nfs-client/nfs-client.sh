#!/bin/bash

set -e
user=$1

## 1st part: nfs mount
ipaddr=$(/sbin/ifconfig eth0 | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}')

#rpcbind
mkdir -p /home/$user
mount -t nfs -o proto=tcp,port=2049 $ipaddr:/data /home/$user

inotifywait -m /data &> /dev/null &

## 2nd part sshd service
## compute does not expose 22, shadow does it and compute share same network: --net=container:shadow-$user
## sshd does not use pam, use hostbasedauthorization
mkdir /var/run/sshd
/usr/sbin/sshd -D 

