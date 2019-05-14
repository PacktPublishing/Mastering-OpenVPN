#!/bin/sh
echo 'head -n1 $1' > \
/tmp/openvpn-${untrusted_ip}-${untrusted_port}.tmp
exit 0
