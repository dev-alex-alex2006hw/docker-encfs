```
need to:
* prepare sshd_config for the container
* copy from host: shosts.equiv ssh_host_ecdsa_key  ssh_host_ecdsa_key.pub ssh_host_ed25519_key  ssh_host_ed25519_key.pub ssh_known_hosts
* not using RSA, ssh_host_*_key permission must be 0600
``` 

