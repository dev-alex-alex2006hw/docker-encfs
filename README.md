
```

login1:(test1)
login-pd: ssh force into container (test2)

pbs_server: (test3)
node1: prolog, job_starter, epilog for container (test4)
node2: (test5)

audit: store encfs key and passwd (test6)
registry: store/provide docker images (test6)
consul: docker overlay network (test6)

login-pd:
- user ssh -> sshd ForceCommand "force_into_container.sh"
    --- create user's private overlay network is not present
    --- start container login-$user under user's private overlay network
    --- second ssh into container compute-$user

login container does:
* retrieve encfs key and password from audit
* mount encfs and then destroys the key
* prepare bashrc and bash_profile if not present
* start sshd daemon
* start trqauthd daemon for PBS
* if sshd does not have log in session(i.e. user idle) for 900 seconds, container expires and get destroyed
* uses hostbased ssh and root key authorization

on login-pd:
# tail /etc/ssh/sshd_config 
 UseDNS no
 GSSAPIAuthentication no
 HostbasedAuthentication yes
 HostbasedUsesNameFromPacketOnly yes
 RhostsRSAAuthentication yes
 IgnoreRhosts no

Match User *,!root 
      ForceCommand /usr/bin/force_into_container.sh

#tail /etc/ssh/ssh_config
HostbasedAuthentication yes
EnableSSHKeysign yes
StrictHostKeyChecking no
CheckHostIP no

compute:
- user qsub -> PBS server allocs nodes
     --- prologue.parallel(runs first on rest nodes) and prologue(runs 2nd on MOM node) starts compute containers under user's private overlay network
     --- PBS job_starter starts job from MOM node
     --- mpi jobs are launched from MOM node via ssh to rest nodes
     --- job finish, epiplogue.parallel and epilogue destroys compute container

compute container does:
* retrieve encfs key and password from audit
* mount encfs and then destroys the key
* start sshd daemon
* uses hostbased ssh and root key authorization

containers use prepared sshd, ssh_config and keys

```
