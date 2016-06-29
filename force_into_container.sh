#!/bin/bash

user=$(whoami)

ssh_port=$(sudo /usr/bin/docker-cmd $user)

while :; do
    if ssh -q -p $ssh_port $(hostname) date &> /dev/null ; then
	break
    fi
    sleep 0.5
done

#scp works with these ssh options, -q disables ssh_banner
ssh -A -X -p $ssh_port $(hostname) "$SSH_ORIGINAL_COMMAND"

