#!/bin/bash

./utils/copy_key.sh .
docker build -t login .
docker tag login 10.0.15.16:5000/login
docker push 10.0.15.16:5000/login
