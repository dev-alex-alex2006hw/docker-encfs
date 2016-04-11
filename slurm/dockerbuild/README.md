```
docker run -d --name slurmctld --net stack --hostname slurmctld  slurmctld slurmctld node[1-2]
docker run -d --name node1 --net stack --hostname node1 slurmd slurmctld node[1-2]

no need to expose port 6817

```