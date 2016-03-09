#!/bin/bash

nodelist=$1

#assume root pub key is set and has free ssh access to all nodes, including local 

grep ^HostbasedAuthentication /etc/ssh/sshd_config > /dev/null

if [ $? -ne 0 ];then
    echo "HostbasedAuthentication yes">>/etc/ssh/sshd_config
fi

grep ^HostbasedUsesNameFromPacketOnly /etc/ssh/sshd_config > /dev/null

if [ $? -ne 0 ];then
    echo "HostbasedUsesNameFromPacketOnly yes">>/etc/ssh/sshd_config
fi

grep ^RhostsRSAAuthentication /etc/ssh/sshd_config > /dev/null

if [ $? -ne 0 ];then
    echo "RhostsRSAAuthentication yes">>/etc/ssh/sshd_config
fi

grep ^IgnoreRhosts /etc/ssh/sshd_config > /dev/null

if [ $? -ne 0 ];then
    echo "IgnoreRhosts no">>/etc/ssh/sshd_config
fi

grep ^HostbasedAuthentication /etc/ssh/ssh_config > /dev/null

if [ $? -ne 0 ];then
    echo "HostbasedAuthentication yes">>/etc/ssh/ssh_config
fi

grep ^EnableSSHKeysign /etc/ssh/ssh_config > /dev/null
if [ $? -ne 0 ];then
    echo "EnableSSHKeysign yes">>/etc/ssh/ssh_config
fi

chmod 4755 /usr/libexec/openssh/ssh-keysign
systemctl restart sshd

##finished local

for node in `cat $nodelist | awk '{print $1 "\n" $2}' `
do
    ssh-keyscan $node >> /etc/ssh/ssh_known_hosts
done

cat /etc/ssh/ssh_known_hosts | cut -d" " -f1 > /etc/ssh/shosts.equiv 
for node in `cat $nodelist | awk '{print $2}'`
do
    echo $node:
    scp /etc/ssh/shosts.equiv $node:/etc/ssh/
    scp /etc/ssh/ssh_known_hosts $node:/etc/ssh/ssh_known_hosts
    scp /etc/ssh/sshd_config $node:/etc/ssh/
    scp /etc/ssh/ssh_config $node:/etc/ssh/
    ssh $node "chmod 4755 /usr/libexec/openssh/ssh-keysign"
    ssh $node "systemctl restart sshd"
done

