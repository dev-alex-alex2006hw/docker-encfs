#!/bin/bash

ssh_port=$(sudo /usr/bin/run_docker_container)

while :; do
    if ssh -q -p $ssh_port $(hostname) date &> /dev/null ; then
	break
    fi
    sleep 0.5
done

#scp works with these ssh options, -q disables ssh_banner
ssh -q -A -X -p $ssh_port $(hostname) "$SSH_ORIGINAL_COMMAND"

