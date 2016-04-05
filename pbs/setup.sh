#!/bin/bash

#client
torque-mom torque-client

#server
torque-server torque-scheduler torque-client

create-munge-key

#cp /etc/munge/munge.key to all host
chown munge:munge /etc/munge/munge.key
systemctl start munge

echo node1 > /etc/torque/server_name

systemctl start pbs_server

qmgr -c "c n node2"
qmgr -c "c n node3"
