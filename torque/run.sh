#!/bin/bash

yum install rpm-build libxml2-devel openssl-devel gcc gcc-c++ boost-devel -y

wget http://wpfilebase.s3.amazonaws.com/torque/torque-6.0.1-1456945733_daea91b.tar.gz
tar -xzvf torque-6.0.1-1456945733_daea91b.tar.gz
mv torque-6.0.1-1456945733_daea91b torque-6.0.1
tar -czvf torque-6.0.1.tar.gz torque-6.0.1
mkdir -p /root/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
cp torque-6.0.1.tar.gz /root/rpmbuild/SOURCES
chown -R root:root torque-6.0.1
rpmbuild -ba torque-6.0.1/torque.spec 
cp /root/rpmbuild/RPMS/x86_64/torque*.rpm .


cat > /var/spool/torque/server_priv/nodes <<'EOF'
test2 np=1
test3 np=1
EOF

echo test1 > /var/spool/torque/server_name

cat > /var/spool/torque/mom_priv/config <<'EOF'
$pbsserver test1
$logeven 255
EOF

qmgr -c "create queue test queue_type=execution" 
qmgr -c "set queue test enabled=true"
qmgr -c "set queue test started=true"
qmgr -c "set server scheduling=True" 
qmgr -c "set server default_queue=test"
qmgr -c "set queue test resources_default.nodes=1"
qmgr -c "set queue test resources_default.walltime=3600"




