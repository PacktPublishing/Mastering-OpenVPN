#!/bin/sh
#
# Determines if user ($1) has been connected more than $2 seconds
if [ $# -lt 2 ];
then
    echo "usage: $0 <user> <time_in_seconds>"
    exit 1
fi
USER=$1
TO=$2
# DB seconds
SQL="SELECT SUM(connection_time) FROM vpn_session WHERE cn='$USER'"
DBTIME='/usr/local/bin/sqlite3 /var/openvpn/movpn.sqlite3 "$SQL"'
if [ "$DBTIME" = "" ];
then
    DBTIME=0
fi
# Check management port
CTIME='echo "status 2" | nc -N localhost 1194 | grep -E "CLIENT_
LIST.*$USER" | cut -f8 -d,'
if [ "$CTIME" != "" ];
then
    # we have an active connection
    D='date +"%s"'
    CTIME='expr "$D - $CTIME"'
else
    CTIME=0
fi
UTIME='expr $DBTIME + $CTIME'
if [ $UTIME -gt $TO ];
then
    logger "Disconnecting $USER, activity time exceeded ($UTIME/$TO)."
    echo "disable" >> /usr/local/etc/openvpn/ccd/$USER
    echo "kill $USER" | nc localhost 1194
fi
