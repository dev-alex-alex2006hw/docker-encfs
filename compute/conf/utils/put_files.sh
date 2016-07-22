#!/bin/bash

cp config /var/spool/torque/mom_priv
service pbs_mom restart

cp job_starter /var/spool/torque/mom_priv

cp prologue /var/spool/torque/mom_priv/
cp prologue /var/spool/torque/mom_priv/prologue.parallel
cp epilogue /var/spool/torque/mom_priv/
cp epilogue /var/spool/torque/mom_priv/epilogue.parallel

cp start_docker_container.sh /usr/bin
cp exec_docker_container /usr/bin
