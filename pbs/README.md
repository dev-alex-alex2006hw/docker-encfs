```
workflow:

central PBS/Moab server + consul key store(container)

-> job allocate nodes
-> docker create runtime overlay network for job
-> use ${PBS_NODEFILE} launch one pbs-server and N pbs-client containers
-> ssh pbs-server and qsub script
-> job finish
-> destroy containers
-> destroy runtime overlay network

```