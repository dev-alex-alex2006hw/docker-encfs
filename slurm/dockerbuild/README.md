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
       
no need to expose port 6817

```