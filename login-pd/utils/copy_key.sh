#!/bin/bash

folder=$1
mkdir $folder -p 
cp /etc/ssh/ssh_host_*_key $folder
cp /etc/ssh/ssh_host_*_key.pub $folder

chmod 0600 $folder/ssh_host_*_key

cp /etc/ssh/ssh_known_hosts $folder
cp /etc/ssh/shosts.equiv $folder
