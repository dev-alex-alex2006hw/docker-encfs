#!/bin/bash

set -e
rootpass=$1

## 1st part: nfs mount
ipaddr=$(/sbin/ifconfig eth0 | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}')

#rpcbind
mkdir -p /data
mount -t nfs -o proto=tcp,port=2049 $ipaddr:/data /data

cat >> /root/.bashrc <<EOF
printf '\n***************\nImportant Notice:\nPlease put all your data under /data, all other places will be wiped clean after you log out!!\n***************\n\n'  
EOF

inotifywait -m /data &> /dev/null &

## 2nd part sshd service
## compute does not expose 22, shadow does it and compute share same network: --net=container:shadow-$user
mkdir /var/run/sshd
echo "root:$rootpass" | chpasswd
sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# SSH login fix. Otherwise user is kicked off after login
sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
echo "export VISIBLE=now" >> /etc/profile

/usr/sbin/sshd -D 
#exec -l /bin/bash
