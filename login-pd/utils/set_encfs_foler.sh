#!/bin/bash

user=$1

mkdir /home/$user/encrypted -p
chown $user:`id -g $user` /home/$user/encrypted
chmod 0700 /home/$user/encrypted
mkdir /tmp/$user -p
encfs /home/$user/encrypted /tmp/$user
