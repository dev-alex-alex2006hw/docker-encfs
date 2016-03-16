#!/bin/bash

cp /etc/ssh/ssh_host_ecdsa_key nfs-client/
cp /etc/ssh/ssh_host_ecdsa_key.pub nfs-client/
cp /etc/ssh/ssh_host_ed25519_key nfs-client/
cp /etc/ssh/ssh_host_ed25519_key.pub nfs-client/

chmod 0600 nfs-client/ssh_host_*_key
