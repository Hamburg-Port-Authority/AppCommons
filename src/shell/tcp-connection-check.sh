#!/bin/bash

host_file=/tmp/tcp-connection-check/host_file.txt
out_file=/tmp/tcp-results.txt

while true; do
    while read -r ip; do
        date=$(date +%Y%m%d_%H%M%S)
        if timeout 5 bash -c "cat < /dev/null >/dev/tcp/${ip}/22"; then
            echo -e "$date - $ip - Success"
        else
            echo -e "$date - $ip - Failure" 
        fi >> "$out_file"
    done < "$host_file"
    sleep 10
done