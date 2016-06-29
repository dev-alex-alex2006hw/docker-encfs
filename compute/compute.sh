#!/bin/bash

set -e
user=$1

enpass=$(/usr/local/bin/retrieve_pass $user)

mkdir -p /mnt/do_not_use
mkdir -p /home/$user

echo $enpass | encfs /mnt/do_not_use /home/$user -S --public

/usr/sbin/sshd -D &> /dev/null &

# # exit out of idle containers to save resources and to allow opportunities to pull in the lastest container image
while :; do
    sleep 900
    if [ $(ps auwx | grep sshd | grep -v grep | wc -l) -lt 2 ]; then
	break
    fi
done

