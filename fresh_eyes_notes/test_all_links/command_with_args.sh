#!/bin/bash

while IFS= read -r cmd; do
    echo "$cmd" >> $1               # write the command itself
    eval "$cmd" 2>&1 | sed 's/^/    /' >> $1   # run command and indent result
done < <(rm -f $1 | curl $2 | grep "reference external" | grep -oP '(?<=href=")[^"]*(?=")' | sed 's#^\./#https://casper-toolflow.readthedocs.io/projects/tutorials/en/latest/tutorials/rfsoc/#g' | sed 's/^/curl -I /')
