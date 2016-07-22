#!/bin/bash

cp null.sh /var/spool/torque/mom_priv/prologue
cp null.sh /var/spool/torque/mom_priv/prologue.parallel
cp null.sh /var/spool/torque/mom_priv/epilogue
cp null.sh /var/spool/torque/mom_priv/epilogue.parallel

cp -fr job_starter_null /var/spool/torque/mom_priv/job_starter


