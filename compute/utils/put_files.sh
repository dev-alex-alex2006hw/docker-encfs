#!/bin/bash

cp epilogue /var/spool/torque/mom_priv
cp job_starter /var/spool/torque/mom_priv
cp prologue /var/spool/torque/mom_priv

cp start_docker_container.sh /usr/bin
cp exec_docker_container /usr/bin
