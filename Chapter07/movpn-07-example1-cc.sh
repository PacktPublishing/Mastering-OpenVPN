#!/bin/sh
creds="/tmp/openvpn-${untrusted_ip}-${untrusted_port}.tmp"
if [ -f "$creds" ];
then
    selected='head -n1 $creds'
    if [ "$selected" = "dc1" ];
    then
        cat >> $1 <<- EOF
push "route 10.10.0.0 255.255.255.0"
push "route 10.10.1.0 255.255.255.0"
EOF
    elif [ "$selected" = "dc2" ];
    then
        cat >> $1 <<- EOF
push "route 10.20.0.0 255.255.255.0"
push "route 10.20.1.0 255.255.255.0"
EOF
    else
        cat >> $1 <<- EOF
push "route 10.10.0.0 255.255.255.0"
push "route 10.10.1.0 255.255.255.0"
push "route 10.20.0.0 255.255.255.0"
push "route 10.20.1.0 255.255.255.0"
EOF
    fi
fi
exit 0
