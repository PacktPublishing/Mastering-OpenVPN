#!/bin/bash
/sbin/arp -i wlan0  -Ds ${ifconfig_pool_remote_ip} wlan0 pub
/sbin/ip route add ${ifconfig_pool_remote_ip}/32 dev tun0
