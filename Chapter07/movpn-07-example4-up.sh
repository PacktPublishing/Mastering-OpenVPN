#!/bin/sh
# make webroot in home if it doesn't exist
mkdir -p ~/remote_shares/webroot
if [ $? -eq 0 ];
then
    mount 192.168.19.53:/webroot ~/remote_shares/webroot
    if [ $? -eq 0 ];
    then
        osascript -e 'tell app "System Events" to display dialog "~/remote_shares/webroot is mounted"'
    else
        osascript -e 'tell app "System Events" to display dialog "Unable to mount webroot directory."'
    fi
else
    osascript -e 'tell app "System Events" to display dialog "Unable to create remote share path."'
fi

