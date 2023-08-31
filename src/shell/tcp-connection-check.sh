#!/bin/bash

host_file=/tmp/tcp-connection-check/host_file.txt
out_file=/tmp/tcp-results.txt
REGEX="^(00|10|20|30|40|50)"

while true; do
    CURRENT=$(date +%S)
    if [[ $CURRENT =~ $REGEX ]]; then
        while read -r ip; do
            #build date
            fulld+=$(date +%d.%m.%y)
            fulld+=" "
            fulld+=$(date +%T)
            #check connection
            resolvedIp=$(dig +short ${ip})
            if timeout 5 bash -c "cat < /dev/null >/dev/tcp/${ip}/22"; then
                echo -e "Success - $fulld - $ip [$resolvedIp] - $NODE_NAME - $NODE_IP"
            else
                echo -e "Failure - $fulld - $ip [$resolvedIp] - $NODE_NAME - $NODE_IP" 
            fi >> "$out_file"
            unset fulld
        done < "$host_file"
    fi
    sleep 1
done