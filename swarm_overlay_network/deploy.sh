#!/bin/bash

## key store container on a dedicated node, test1
docker run -d -p 8500:8500 --name=consul progrium/consul -server -bootstrap

## docker engine to listen on 2375 on each node,(for swarm) give key store location(to use overlay network)
pdsh -w test[2-3] "docker daemon -H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock --cluster-store=consul://10.0.15.11:8500 --cluster-advertise=enp0s8:2375 &> /dev/null &"

## swarm master node
ssh test2 "docker run -d -p 4000:4000 swarm manage -H :4000 --advertise 10.0.15.11:4000 consul://10.0.15.11:8500"

## start swarm slave nodes
ssh test3 "docker run -d swarm join --advertise=10.0.15.12:2375 consul://10.0.15.11:8500"

## go to test2, swarm master node, create overlay network on swarm master
#docker -H :4000 network create -d overlay stack-001

## now ready to launch applicatoin containers on swarm nodes!

#docker -H :4000 run -itd --name shell-01 --net stack001 alpine /bin/sh
#docker -H :4000 run -itd --name shell-02 --net stack001 alpine /bin/sh
