#!/bin/bash

set -e
user=$1
runtime=$2

enpass=$(/usr/local/bin/retrieve_pass $user)

chmod 0700 /mnt/do_not_use

echo $enpass | encfs /mnt/do_not_use /home/$user -S --public

sleep $runtime

