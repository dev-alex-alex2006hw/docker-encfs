#!/bin/bash

set -e
user=$1
runtime=$2
jobid=$3

enpass=$(/usr/local/bin/retrieve_pass $user $jobid)

chmod 0700 /mnt/do_not_use

echo $enpass | encfs /mnt/do_not_use /home/$user -S --public

rm -fr $ENCFS6_CONFIG

/usr/sbin/sshd -D &> /dev/null &

sleep $runtime

