#!/bin/bash

set -e

mounts="${@}"
targets=()

ipaddr=$(/sbin/ifconfig eth0 | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}')

#rpcbind

# for mnt in "${mounts[@]}"; do
#   src=$(echo $mnt | awk -F':' '{ print $1 }')
#   target=$(echo $mnt | awk -F':' '{ print $2 }')
#   targets+=("$target")

#   mkdir -p $target

#   mount -t nfs -o proto=tcp,port=2049 ${NFS_PORT_2049_TCP_ADDR}:${src} ${target}
# done
mkdir -p /data
mount -t nfs -o proto=tcp,port=2049 $ipaddr:/data /data

cat >> /root/.bashrc <<EOF
printf '\n***************\nImportant Notice:\nPlease put all your data under /data, all other places will be wiped clean after you log out!!\n***************\n\n'  
EOF

#exec inotifywait -m "${targets[@]}"
inotifywait -m /data &> /dev/null &
exec -l /bin/bash
