#!/bin/bash
## on local machine, not in vm
sudo curl -L https://github.com/docker/machine/releases/download/v0.6.0/docker-machine-`uname -s`-`uname -m` > /usr/local/bin/docker-machine 
sudo chmod +x /usr/local/bin/docker-machine

sudo curl -L https://github.com/docker/compose/releases/download/1.6.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

##create a single instance of Consul running in a container:

docker-machine create -d virtualbox kv
docker $(docker-machine config kv) run -d -p 8500:8500 -h consul progrium/consul -server -bootstrap
docker $(docker-machine config kv) ps

##create three Swarm nodes (one master) that use the kv machine for Swarm discovery and overlay networking:

docker-machine create \
  -d virtualbox \
  --swarm \
  --swarm-master \
  --swarm-discovery="consul://$(docker-machine ip kv):8500" \
  --engine-opt="cluster-store=consul://$(docker-machine ip kv):8500" \
  --engine-opt="cluster-advertise=eth1:2376" \
  c0-master

docker-machine create \
  -d virtualbox \
  --swarm \
  --swarm-discovery="consul://$(docker-machine ip kv):8500" \
  --engine-opt="cluster-store=consul://$(docker-machine ip kv):8500" \
  --engine-opt="cluster-advertise=eth1:2376" \
  c0-n1

docker-machine create \
  -d virtualbox \
  --swarm \
  --swarm-discovery="consul://$(docker-machine ip kv):8500" \
  --engine-opt="cluster-store=consul://$(docker-machine ip kv):8500" \
  --engine-opt="cluster-advertise=eth1:2376" \
  c0-n2

## to interact with master
eval "$(docker-machine env --swarm c0-master)"

docker network create -d overlay myStack1
docker network ls

docker run -d --name web --net myStack1 nginx
docker run -itd --name shell1 --net myStack1 alpine /bin/sh
