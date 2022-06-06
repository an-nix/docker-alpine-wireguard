#!/bin/bash

LABEL="homa-direct"
DIRECT=$(/usr/local/bin/kubectl get no -L${LABEL} | grep ${NODE_NAME} | awk '{print $6}')

echo "Variable"
echo $DIRECT

sleep infinity

if wg show wg0 &> /dev/null || test "$?" -eq "0" ; then
echo "WG0 is present, shut down"
wg-quick down /etc/wireguard/wg0.conf
fi

wg-quick up /etc/wireguard/wg0.conf

