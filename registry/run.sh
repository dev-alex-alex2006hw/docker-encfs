#!/bin/bash

#on all nodes
cat >  /etc/docker/daemon.json << EOF
{
    "insecure-registries": ["10.0.15.11:5000"]
}
EOF

systemctl restart docker

## on server side
docker run -d -p 5000:5000 --restart=always --name registry registry:2

docker tag compute 10.0.15.11:5000/compute
docker push 10.0.15.11:5000/compute

## on clients do docker pull

