#!/bin/bash

host_file=/tmp/tcp-connection-check/host_file.txt
out_file=/tmp/tcp-results.txt

while true; do
    while read -r ip; do
        #build date
        fulld+=$(date +%d.%m.%y)
        fulld+=" "
        fulld+=$(date +%T)
        #check connection
        if timeout 5 bash -c "cat < /dev/null >/dev/tcp/${ip}/22"; then
            echo -e "$ip - Success - $fulld - $NODE_NAME"
        else
            echo -e "$ip - Failure - $fulld - $NODE_NAME" 
        fi >> "$out_file"
        unset fulld
    done < "$host_file"
    sleep 10
done