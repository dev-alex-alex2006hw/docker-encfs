#!/bin/bash

#on all nodes, cluster stuff is for multi-node clustering
cat >  /etc/docker/daemon.json << EOF
{
    "insecure-registries": ["10.0.15.16:5000"],
    "cluster-store": "consul://10.0.15.16:8500",
    "cluster-advertise": "enp0s8:2375"
}
EOF

systemctl restart docker

## on server side
docker run -d -p 5000:5000 --restart=always --name registry registry:2

## consul for mlti-node clustering, overlay network
docker run -d -p 8500:8500 --name=consul progrium/consul -server -bootstrap

docker tag login 10.0.15.16:5000/login
docker push 10.0.15.16:5000/login

## on clients do docker pull

