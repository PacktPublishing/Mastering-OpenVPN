#!/bin/sh
if [ "$common_name" = "client1" ]
then
    echo "disable" >> $1
fi
exit 0
