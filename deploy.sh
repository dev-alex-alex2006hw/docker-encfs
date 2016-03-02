#!/bin/bash
yum install epel-release -y
yum install ansible -y

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

./build_pdsh_rpm.sh

ssh-keygen -t rsa
for i in `grep 10.0.15 /etc/hosts | awk '{print $2}'`; do
    ssh-keyscan $i;
done > ~/.ssh/known_hosts

ansible-playbook ssh_key.yml --ask-pass

exec -l $SHELL

pdsh "curl -sSL https://get.docker.com/ | sh"
pdsh "systemctl start docker"
pdsh "systemctl enable docker"
pdsh "usermod -aG docker vagrant"



