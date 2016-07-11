```
login1: 
login-pd: ssh force into container
audit: store encfs key and passwd
registry: store/provide docker images

pbs_server:
node1: prolog, job_starter, epilog for container
node2:

/etc/sudoer on login-pd:
Defaults   env_keep += "LOGNAME"
%hipaa ALL=(ALL) NOPASSWD: /usr/bin/run_docker_container

ssh keys need to be copied to container, it is missing
```