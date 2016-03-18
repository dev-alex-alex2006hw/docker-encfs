
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
    --- second ssh into container compute-$user

* if sshd does not have log in session(i.e. user idle) for 900 seconds, both container expire and get destroyed
* user only have persistant data in /home/$user, it's aways encrypted
* compute-$user only have account root and $user
* user need to be added to docker group: usermod -aG docker $user
* both docker container needs to be built first before user can log in, all user use same containers
* encfs password needs to be set before user can log in
* hostbased ssh authorization need to be set

$vagrant up
$vagrant ssh test1
$sudo su
#cd /vagrant
#./deploy.sh
#su vagrant

[vagrant@test1 vagrant]$ ssh test2 cat /proc/1/cgroup

***************
Important Notice:
Please put all your data ONLY under your home dir ~/,
all other places are not secure and will be wiped clean after you log out!!
***************

10:cpuset:/docker/ae955db802e5786167fe392af47c9752eda68c95c91f5169e470033528c57375
9:perf_event:/docker/ae955db802e5786167fe392af47c9752eda68c95c91f5169e470033528c57375
8:memory:/docker/ae955db802e5786167fe392af47c9752eda68c95c91f5169e470033528c57375
7:devices:/docker/ae955db802e5786167fe392af47c9752eda68c95c91f5169e470033528c57375
6:cpuacct,cpu:/docker/ae955db802e5786167fe392af47c9752eda68c95c91f5169e470033528c57375
5:net_cls:/docker/ae955db802e5786167fe392af47c9752eda68c95c91f5169e470033528c57375
4:freezer:/docker/ae955db802e5786167fe392af47c9752eda68c95c91f5169e470033528c57375
3:hugetlb:/docker/ae955db802e5786167fe392af47c9752eda68c95c91f5169e470033528c57375
2:blkio:/docker/ae955db802e5786167fe392af47c9752eda68c95c91f5169e470033528c57375
1:name=systemd:/docker/ae955db802e5786167fe392af47c9752eda68c95c91f5169e470033528c57375

```