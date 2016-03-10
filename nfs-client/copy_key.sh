#!/bin/bash

cp /etc/ssh/ssh_host_ecdsa_key .
cp /etc/ssh/ssh_host_ecdsa_key.pub .
cp /etc/ssh/ssh_host_ed25519_key .
cp /etc/ssh/ssh_host_ed25519_key.pub .

chmod 0600 ssh_host_*_key
