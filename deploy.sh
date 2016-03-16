#!/bin/bash
yum install epel-release -y
yum install ansible pdsh nfs-utils -y

cat > /etc/ansible/hosts <<EOF 
[test]
test[1:2]

EOF

cat >> /etc/hosts <<EOF

10.0.15.11 test1
10.0.15.12 test2

EOF

cat > /etc/profile.d/pdsh.sh <<EOF
export PDSH_RCMD_TYPE='ssh'
export WCOLL='/etc/pdsh/machines'
EOF

mkdir -p /etc/pdsh
grep 10.0. /etc/hosts | awk '{print $2}' > /etc/pdsh/machines

ssh-keygen -t rsa
for i in `grep 10.0.15 /etc/hosts | awk '{print $2}'`; do
    ssh-keyscan $i;
done > ~/.ssh/known_hosts

ansible-playbook ssh_key.yml --ask-pass

source /etc/profile.d/pdsh.sh
pdsh "yum install -y encfs"
pdsh "curl -sSL https://get.docker.com/ | sh"
pdsh "systemctl start docker"
pdsh "systemctl enable docker"
pdsh "usermod -aG docker vagrant"

cat >> /etc/exports <<EOF
/home *(rw,sync,no_subtree_check,fsid=0,no_root_squash)
EOF
systemctl start nfs-server
systemctl enable nfs-server

pdsh -x test1 "mount -t nfs -o proto=tcp,port=2049 10.0.15.11:/home /home"
