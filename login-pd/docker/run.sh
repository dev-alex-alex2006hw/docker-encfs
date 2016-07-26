#!/bin/bash

set -e
user=$1

enpass=$(/usr/local/bin/retrieve_pass $user)

chmod 0700 /mnt/do_not_use

echo $enpass | encfs /mnt/do_not_use /home/$user -S --public

if [ ! -f /home/$user/.bashrc ]; then 
   cp /usr/local/src/.bashrc /home/$user/
   chown $user /home/$user/.bashrc  
fi

if [ ! -f /home/$user/.bash_profile ]; then
   cp /usr/local/src/.bash_profile /home/$user/
   chown $user /home/$user/.bash_profile
fi

/usr/sbin/sshd -D &> /dev/null &
/usr/sbin/trqauthd &> /dev/null &

# # exit out of idle containers to save resources and to allow opportunities to pull in the lastest container image
while :; do
    sleep 900
    if [ $(ps auwx | grep sshd | grep -v grep | wc -l) -lt 2 ]; then
	break
    fi
done

