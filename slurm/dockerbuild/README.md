```
#docker network create -d overlay stack

#docker build -t compute/slurmctld slurmctld
#docker build -t compute/slurmd slurmd

#docker run -d --name slurmctld --net stack --hostname slurmctld  compute/slurmctld slurmctld node[1-2]

#docker run -d --name node1 --net stack --hostname node1  compute/slurmd slurmctld node[1-2]
#docker run -d --name node2 --net stack --hostname node2  compute/slurmd slurmctld node[1-2]

#docker exec -it slurmctld srun -n2 hostname
node1
node2

#docker exec -it slurmctld srun -n2 cat /proc/1/cgroup
 10:net_cls:/docker/02dc711814c47166af3b5b69a934f622504b5fbf7ff8094e581780a69af86028
 9:freezer:/docker/02dc711814c47166af3b5b69a934f622504b5fbf7ff8094e581780a69af86028
 8:memory:/docker/02dc711814c47166af3b5b69a934f622504b5fbf7ff8094e581780a69af86028
 7:cpuset:/docker/02dc711814c47166af3b5b69a934f622504b5fbf7ff8094e581780a69af86028
 6:blkio:/docker/02dc711814c47166af3b5b69a934f622504b5fbf7ff8094e581780a69af86028
 5:hugetlb:/docker/02dc711814c47166af3b5b69a934f622504b5fbf7ff8094e581780a69af86028
 4:devices:/docker/02dc711814c47166af3b5b69a934f622504b5fbf7ff8094e581780a69af86028
 3:cpuacct,cpu:/docker/02dc711814c47166af3b5b69a934f622504b5fbf7ff8094e581780a69af86028
 2:perf_event:/docker/02dc711814c47166af3b5b69a934f622504b5fbf7ff8094e581780a69af86028
 1:name=systemd:/docker/02dc711814c47166af3b5b69a934f622504b5fbf7ff8094e581780a69af86028
 10:net_cls:/docker/6f2c89d86b0745155ff336327b704201b8b5cd25ee062e439c82d1ac7903e174
 9:freezer:/docker/6f2c89d86b0745155ff336327b704201b8b5cd25ee062e439c82d1ac7903e174
 8:memory:/docker/6f2c89d86b0745155ff336327b704201b8b5cd25ee062e439c82d1ac7903e174
 7:cpuset:/docker/6f2c89d86b0745155ff336327b704201b8b5cd25ee062e439c82d1ac7903e174
 6:blkio:/docker/6f2c89d86b0745155ff336327b704201b8b5cd25ee062e439c82d1ac7903e174
 5:hugetlb:/docker/6f2c89d86b0745155ff336327b704201b8b5cd25ee062e439c82d1ac7903e174
 4:devices:/docker/6f2c89d86b0745155ff336327b704201b8b5cd25ee062e439c82d1ac7903e174
 3:cpuacct,cpu:/docker/6f2c89d86b0745155ff336327b704201b8b5cd25ee062e439c82d1ac7903e174
 2:perf_event:/docker/6f2c89d86b0745155ff336327b704201b8b5cd25ee062e439c82d1ac7903e174
 1:name=systemd:/docker/6f2c89d86b0745155ff336327b704201b8b5cd25ee062e439c82d1ac7903e174


no need to expose port 6817

```