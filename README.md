
```
login workflow:

- user ssh -> sshd ForceCommand "force_into_container.sh"
    --- start container login-$user
    --- login-$user starts sshd to allow user log in and data scp
    --- second ssh into container compute-$user

* if sshd does not have log in session(i.e. user idle) for 900 seconds, both container expire and get destroyed
* hostbased ssh authorization 

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
