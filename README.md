
```

login1:(test1)
login-pd: ssh force into container (test2)

pbs_server: (test3)
node1: prolog, job_starter, epilog for container (test4)
node2: (test5)

audit: store encfs key and passwd (test6)
registry: store/provide docker images (test6)

login-pd:
- user ssh -> sshd ForceCommand "force_into_container.sh"
    --- start container login-$user
    --- login-$user starts sshd to allow user log in and data scp
    --- second ssh into container compute-$user

* if sshd does not have log in session(i.e. user idle) for 900 seconds, container will expire and get destroyed
* hostbased ssh authorization inside container, need to have all compute nodes for torque

on host:
# tail /etc/ssh/sshd_config
 UseDNS no
 GSSAPIAuthentication no
 HostbasedAuthentication yes
 HostbasedUsesNameFromPacketOnly yes
 RhostsRSAAuthentication yes
 IgnoreRhosts no

Match User *,!root
      ForceCommand /usr/bin/force_into_container.sh

Better Security:

only allow a user to access a particular container:

cat /usr/bin/run_docker_cmd
#!/bin/sh
docker run -ti --rm  --cap-drop=all -u 3267  centos /bin/bash

After writing the script, configure sudoers to run it:

grep user1 /etc/sudoers
user1        ALL=(ALL)       NOPASSWD: /usr/bin/run_docker_cmd


encfs key separation:
ENCFS6_CONFIG=/home/me/.encfs6.xml encfs /tmp/crypt-view /tmp/plain-view
```
