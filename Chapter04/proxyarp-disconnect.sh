#!/bin/bash
/sbin/arp -i wlan0  -d ${ifconfig_pool_remote_ip}
/sbin/ip route del ${ifconfig_pool_remote_ip}/32 dev tun0

