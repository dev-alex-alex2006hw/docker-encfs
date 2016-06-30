
```
login workflow:

- user ssh -> sshd ForceCommand "force_into_container.sh"
    --- start container compute-$user
    --- compute-$user shares network config with shadow-$user, including IP, hostname, port binding
    --- compute-$user nfs mounts from ip-of-itself:/data to /home/$user
    --- compute-$user starts sshd to allow user log in and data scp
    --- second ssh into container compute-$user

* if sshd does not have log in session(i.e. user idle) for 900 seconds, both container expire and get destroyed
* user only have persistant data in /home/$user, it's aways encrypted
* compute-$user only have account root and $user
* both docker container needs to be built first before user can log in, all user use same containers
* encfs password needs to be set before user can log in
* hostbased ssh authorization need to be set

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

cat /usr/bin/docker-cmd
#!/bin/sh
docker run -ti --rm  --cap-drop=all -u 3267  centos /bin/bash

After writing the script, configure sudoers to run it:

grep user1 /etc/sudoers
user1        ALL=(ALL)       NOPASSWD: /usr/bin/docker-cmd


encfs key separation:
ENCFS6_CONFIG=/home/me/.encfs6.xml encfs /tmp/crypt-view /tmp/plain-view
```
