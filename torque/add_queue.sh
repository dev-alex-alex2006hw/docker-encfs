#!/bin/bash

qmgr -c "create queue test queue_type=execution" 
qmgr -c "set queue test enabled=true"
qmgr -c "set queue test started=true"
qmgr -c "set server scheduling=True" 
qmgr -c "set server default_queue=test"
qmgr -c "set queue test resources_default.nodes=1"
qmgr -c "set queue test resources_default.walltime=3600"

