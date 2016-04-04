
```
[root@test1 ~]# ansible-playbook site.yml

(snip)
TASK: [slurm | copy slurm conf file] ******************************************
ok: [test1]
ok: [test3]
ok: [test2]

TASK: [slurm | start slurmctld service] ***************************************
skipping: [test2]
skipping: [test3]
ok: [test1]

TASK: [slurm | start slurmd service] ******************************************
skipping: [test1]
ok: [test2]
ok: [test3]

PLAY RECAP ********************************************************************
127.0.0.1                  : ok=5    changed=1    unreachable=0    failed=0
test1                      : ok=10   changed=0    unreachable=0    failed=0
test2                      : ok=10   changed=0    unreachable=0    failed=0
test3                      : ok=10   changed=0    unreachable=0    failed=0

[root@test1 ~]# scontrol update NodeName=test[1-3] State=RESUME
[root@test1 ~]# sinfo
PARTITION AVAIL  TIMELIMIT  NODES  STATE NODELIST
debug*       up   infinite      3   idle test[1-3]
[root@test1 ~]# srun -n3 hostname
test1
test3
test2

```