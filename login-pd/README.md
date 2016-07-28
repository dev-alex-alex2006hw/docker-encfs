```

/etc/sudoer on login-pd:
Defaults   env_keep += "LOGNAME"
%hipaa ALL=(ALL) NOPASSWD: /usr/bin/run_docker_container

ssh keys need to be copied to container
hostbased ssh need to have in ssh_known_hosts both test1(login-normal) & test2(login-pd) and all compute nodes(for interactive ssh during job)

sshd_config on host:
Match User *,!root
      ForceCommand /usr/bin/force_into_container.sh
      
```
