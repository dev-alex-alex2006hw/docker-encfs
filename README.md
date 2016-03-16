
```
docker-encfs

- user ssh -> sshd ForceCommand "force_into_container.sh"
   -- start nfs-server container shadow-$user
    --- shadow-$user nfs mounts 10.0.15.11:/home to /mnt/encrypted
    --- shadow-$user retrieves user's password: /usr/local/bin/retrieve_pass $user
    --- shadow-$user encfs mounts /mnt/encrypted to /data using user's pasword
    --- shadow-$user nfs exports /data to ip-of-itself
   -- start nfs-client container compute-$user
    --- compute-$user shares network config with shadow-$user, including IP, hostname, port binding
    --- compute-$user nfs mounts from ip-of-itself:/data to /home/$user
    --- compute-$user starts sshd to allow user log in and data scp

* if sshd does not have log in session(i.e. user idle) for 900 seconds, both container expire and get destroyed
* user only have persistant data in /home/$user, it's aways encrypted 
* both docker container needs to be built first before user can log in, all user use same containers
* encfs password needs to be set before user can log in

```