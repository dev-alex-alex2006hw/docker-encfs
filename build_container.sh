#!/bin/bash

docker build -t nfs-server nfs-server/
docker build -t nfs-client nfs-client/
cp force_into_container.sh /usr/local/bin

cat >> /etc/ssh/sshd_config << EOF
Match User *,!root
        ForceCommand /usr/local/bin/force_into_container.sh
EOF

systemctl restart sshd
