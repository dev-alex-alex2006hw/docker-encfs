#!/bin/bash

set -e
user=$1
enpass=$(/usr/local/bin/retrieve_pass $user)

ipaddr=$(/sbin/ifconfig eth0 | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}')

mkdir -p /mnt/encrypted
mkdir -p /data
rpcbind
mount -t nfs -o proto=tcp,port=2049 10.0.15.11:/home /mnt/encrypted

userid=$2
groupid=$3

echo $enpass | encfs /mnt/encrypted/$user /data -S -o uid=$userid -o gid=$groupid

echo "/data $ipaddr(rw,sync,no_subtree_check,fsid=0,no_root_squash)" >> /etc/exports

#mounts="${@}"

#for mnt in "${mounts[@]}"; do
#  src=$(echo $mnt | awk -F':' '{ print $1 }')
#  echo "$src *(rw,sync,no_subtree_check,fsid=0,no_root_squash)" >> /etc/exports
#done

exec runsvdir /etc/sv
