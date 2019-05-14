#!/bin/bash

exec >> /tmp/movpn-07-01.log 2>&1

date +"%H:%M:%S: START $script_type script ==="
echo "argv = $0 $@"
echo "user = `id -un`/`id -gn`"
env | sort | sed 's/^/  /'
date +"%H:%M:%S: END $script_type script ==="

